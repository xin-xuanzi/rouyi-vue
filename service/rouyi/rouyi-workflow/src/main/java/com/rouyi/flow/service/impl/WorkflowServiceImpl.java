package com.rouyi.flow.service.impl;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Lists;
import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordDto;
import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.entity.WorkflowInstance;
import com.rouyi.flow.domain.valobj.ApproveResult;
import com.rouyi.flow.domain.valobj.ProcessGroupProps;
import com.rouyi.flow.repo.repository.ActWorkflowRepository;
import com.rouyi.flow.service.ApproveObserver;
import com.rouyi.flow.service.IActExpandProcessService;
import com.rouyi.flow.service.IWorkflowService;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.service.ISysCommonService;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.common.workflow.IWorkflowServiceApi;
import com.ruoyi.common.workflow.WorkflowStartParam;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.*;
import org.camunda.bpm.engine.history.HistoricTaskInstance;
import org.camunda.bpm.engine.history.HistoricVariableInstance;
import org.camunda.bpm.engine.repository.ProcessDefinition;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.runtime.VariableInstance;
import org.camunda.bpm.engine.task.Task;
import org.camunda.bpm.engine.task.TaskQuery;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/15 19:14
 */
@Slf4j
@Service
@AllArgsConstructor
public class WorkflowServiceImpl extends AbstractSubject implements IWorkflowService, IWorkflowServiceApi {

    private RuntimeService runtimeService;

    private HistoryService historyService;

    private IdentityService identityService;

    private TaskService taskService;

    private RepositoryService repositoryService;

    private ProcessEngine processEngine;

    private IActExpandProcessService actExpandProcessService;
    private ActExpandBusinessServiceImpl actExpandBusinessService;
    private ISysCommonService sysCommonService;

    private ActWorkflowRepository actWorkflowRepository;

    private ApproveObserver approveObserver;

    @PostConstruct
    public void registerObserver(){
        add(approveObserver);
    }

    @Override
    public String startWorkflow(WorkflowDto workflowDto) throws Exception {
        ExpandProcessDto expandProcessDto = actExpandProcessService.detailByProcessDefinition(workflowDto.getProcessDefinitionId());
        //保存流程变量 nodeProps
        workflowDto.setBusinessKey(expandProcessDto.getBusinessCode());
        workflowDto.getParams().put("ApprovalProps", expandProcessDto.getNodeProps());
        workflowDto.getParams().put("businessCode", workflowDto.getBusinessKey());
        JSONArray jsonArray = JSONArray.parseArray(expandProcessDto.getVariable());

        if (jsonArray != null && jsonArray.size() > 0) {
            List<ProcessGroupProps.Groups> groups = jsonArray.toList(ProcessGroupProps.Groups.class);

            //处理自定义的流程变量
            for (ProcessGroupProps.Groups group : groups) {
                ProcessVariableDto processVariableDto = actExpandBusinessService.processVariableDetail(Long.parseLong(group.getVariableId()));

                Object bean = SpringUtils.getBean(processVariableDto.getBean());
                Object o = invokeMethod(bean, processVariableDto.getInvokeTarget(), workflowDto.getInitiator());
                workflowDto.getParams().put(group.getVariableCode(), o);
            }
        }

        identityService.setAuthenticatedUserId(workflowDto.getInitiator());

        ProcessInstance processInstance = runtimeService.startProcessInstanceById(workflowDto.getProcessDefinitionId()
                , workflowDto.getBusinessKey(), workflowDto.getCaseInstanceId(), workflowDto.getParams());
        return processInstance.getProcessInstanceId();
    }

    @Override
    public String startWorkflowAndSubmit(WorkflowStartParam param) {
        WorkflowDto workflowDto = new WorkflowDto(param);

        String processInstanceId = null;

        try {
            processInstanceId = startWorkflow(workflowDto);
        } catch (Exception e) {
            log.error("流程启动失败, param=[{}]", param);
            throw new RuntimeException(e);
        }

        WorkflowQuery query = new WorkflowQuery();
        query.setProcessInstanceId(processInstanceId);
        query.setUserId(workflowDto.getInitiator());
        query.setBusinessKey(workflowDto.getBusinessKey());
        complete(query);

        log.info("{}流程定义{}业务ID=[{}]启动成功，流程实例=[{}]", param.getBusinessKey()
                , param.getProcessDefinitionId(), param.getCaseInstanceId(), processInstanceId);
        return processInstanceId;
    }

    @Override
    public List<ProcessTodoDto> queryTodo(WorkflowQuery query) {
        int firstResult = (query.getPageNum() - 1) * query.getPageSize();
        TaskQuery taskQuery = taskService.createTaskQuery()
                .taskAssignee(query.getUserId());

        if (StringUtils.isNotEmpty(query.getBusinessKey())) {
            taskQuery.processDefinitionKey(query.getBusinessKey());
        }
        if (StringUtils.isNotNull(query.getBeginDate())) {
            taskQuery.taskCreatedBefore(query.getBeginDate()).taskCreatedAfter(query.getEndDate());
        }

        List<Task> tasks = taskQuery.orderByTaskCreateTime().desc().listPage(firstResult, query.getPageSize());
        List<ProcessTodoDto> list = Lists.newArrayListWithCapacity(tasks.size());

        ProcessTodoDto dto;
        for (Task task : tasks) {
            dto = new ProcessTodoDto();
            dto.setCaseInstanceId(task.getCaseInstanceId());
            dto.setTaskId(task.getId());
            dto.setProcessInstanceId(task.getProcessInstanceId());
            dto.setProcessDefinitionId(task.getProcessDefinitionId());
            dto.setTaskName(task.getName());
            buildSubmitterInfo(dto, task.getProcessInstanceId(), task.getProcessDefinitionId(), task);

            list.add(dto);
        }

        return list;
    }

    /**
     * 补全提交人信息
     *
     * @param dto
     * @param processInstanceId
     * @param processDefinitionId
     */
    private void buildSubmitterInfo(ProcessTodoDto dto, String processInstanceId, String processDefinitionId, Task task) {
        SysUser userInfo = getUserInfo(processInstanceId, task);

        if (userInfo != null) {
            dto.setSubmitUserName(userInfo.getUserName());
            dto.setDeptName(userInfo.getDept().getDeptName());
        }

        ProcessDefinition procDef = getProcDef(processDefinitionId);
        if (procDef != null) {
            dto.setBusinessCode(procDef.getKey());
            dto.setProcessName(procDef.getName());
        }
    }

    @Override
    public List<ProcessTodoDto> queryApproved(WorkflowQuery query) {
        query.setSubmitterNodeName(WorkflowConstant.SUBMITTER);
        List<ProcessTodoDto> processTodoDtos = actWorkflowRepository.queryApproved(query);

        for (ProcessTodoDto processTodoDto : processTodoDtos) {
            buildSubmitterInfo(processTodoDto, processTodoDto.getProcessInstanceId(),
                    processTodoDto.getProcessDefinitionId(), null);
        }

        return processTodoDtos;
    }

    @Override
    public ProcessTodoDto queryTodoDetail(String taskId) {
        Task tasks = taskService.createTaskQuery()
                .taskId(taskId).singleResult();
        ProcessTodoDto todoDto = new ProcessTodoDto();
        String processDefinition = null;

        if (tasks == null) {
            HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                    .taskId(taskId).singleResult();
            if (historicTaskInstance == null) {
                return null;
            }
            processDefinition = historicTaskInstance.getProcessDefinitionId();
            todoDto.setAssignee(historicTaskInstance.getAssignee());
            todoDto.setCaseInstanceId(historicTaskInstance.getCaseInstanceId());
            todoDto.setProcessInstanceId(historicTaskInstance.getProcessInstanceId());
            todoDto.setEndTime(historicTaskInstance.getEndTime());
        } else {
            processDefinition = tasks.getProcessDefinitionId();
            todoDto.setAssignee(tasks.getAssignee());
            todoDto.setCaseInstanceId(tasks.getCaseInstanceId());
            todoDto.setProcessInstanceId(tasks.getProcessInstanceId());

        }

        ExpandProcessDto expandProcessDto = actExpandProcessService.detailByProcessDefinition(processDefinition);

        todoDto.setTaskId(taskId);
        todoDto.setViewPath(expandProcessDto.getViewPath());
        todoDto.setBusinessCode(expandProcessDto.getBusinessCode());

        return todoDto;
    }

    @Override
    public List<ApprovalRecordDto> queryApprovalRecord(String processInstanceId) {
        return actWorkflowRepository.queryApprovalTodo(processInstanceId);
    }

    @Override
    public long queryTodoCount(WorkflowQuery query) {
        TaskQuery taskQuery = taskService.createTaskQuery();
        taskQuery.taskAssignee(query.getUserId());

        if (StringUtils.isNotEmpty(query.getBusinessKey())) {
            taskQuery.processDefinitionKey(query.getBusinessKey());
        }
        if (StringUtils.isNotNull(query.getBeginDate())) {
            taskQuery.taskCreatedBefore(query.getBeginDate()).taskCreatedAfter(query.getEndDate());
        }

        return taskQuery.count();
    }

    @Override
    public void submit(WorkflowQuery query) {
        complete(query);
    }

    @Override
    public void complete(WorkflowQuery query) {
        Task task = taskService.createTaskQuery().processInstanceId(query.getProcessInstanceId())
                .taskAssignee(query.getUserId())
                .processInstanceBusinessKey(query.getBusinessKey())
                .singleResult();

        taskService.complete(task.getId());
    }

    @Override
    public String approve(WorkflowApprovalDto dto) {
        Task task = taskService.createTaskQuery().taskAssignee(dto.getUserId())
                .processInstanceId(dto.getProcessInstance()).singleResult();

        Map<String, Object> variables = runtimeService.getVariables(task.getExecutionId());
        String jsonStr = variables.get(WorkflowConstant.APPROVAL_NODE_PROPS).toString();

        JSONObject jsonObject = JSONObject.parseObject(jsonStr);
        //获取节点配置参数
        ProcessGroupProps props = jsonObject.getObject(task.getTaskDefinitionKey(), ProcessGroupProps.class);
        WorkflowInstance instance = new WorkflowInstance(dto, processEngine);

        //流程审批
        ApproveResult approveResult = instance.approve(task, props);

        if (approveResult.getMsg() != null) {
            notifyObserver(approveResult.getMsg());
        }

        //保存 comment 审批结果
        actWorkflowRepository.saveApprovalResultComment(dto.getResult(), approveResult.getComment().getId());
        return "";
    }

    /**
     * 执行 调用方法，默认方法只有一个参数，提交人ID
     *
     * @param object
     * @param methodName
     * @throws NoSuchMethodException
     * @throws SecurityException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     * @throws InvocationTargetException
     */
    private Object invokeMethod(Object object, String methodName, String initiator) throws NoSuchMethodException,
            SecurityException, IllegalAccessException, IllegalArgumentException,
            InvocationTargetException {
        Method method = object.getClass().getMethod(methodName, String.class);
        Object invoke = method.invoke(object, initiator);

        return invoke;
    }

    private SysUser getUserInfo(String processInstanceId, Task task) {
        Object submitter = null;
        //待办中获取 提交人信息
        if (task != null) {
            VariableInstance starter = runtimeService.createVariableInstanceQuery()
                    .processInstanceIdIn(processInstanceId)
                    .variableName("starter").singleResult();
            submitter = starter.getValue();

        } else {
            HistoricVariableInstance starter = historyService.createHistoricVariableInstanceQuery()
                    .processInstanceIdIn(processInstanceId)
                    .variableName("starter").singleResult();

            submitter = starter.getTypedValue().getValue();
        }

        if (submitter != null) {
            return sysCommonService.getUserById(Long.parseLong(submitter.toString()));
        }

        return null;
    }

    private ProcessDefinition getProcDef(String proDefId) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(proDefId).singleResult();
        return processDefinition;
    }
}
