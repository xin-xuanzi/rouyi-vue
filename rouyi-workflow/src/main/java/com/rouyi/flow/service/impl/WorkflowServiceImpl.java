package com.rouyi.flow.service.impl;

import com.alibaba.fastjson2.JSONObject;
import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.entity.WorkflowInstance;
import com.rouyi.flow.domain.valobj.ProcessNodeProps;
import com.rouyi.flow.service.IWorkflowService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.IdentityService;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.task.Task;
import org.camunda.bpm.engine.task.TaskQuery;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/15 19:14
 */
@Slf4j
@Service
@AllArgsConstructor
public class WorkflowServiceImpl implements IWorkflowService {

    private RuntimeService runtimeService;

    private IdentityService identityService;

    private TaskService taskService;

    private ProcessEngine processEngine;


    @Override
    public String startWorkflow(WorkflowDto workflowDto) {

        identityService.setAuthenticatedUserId(workflowDto.getInitiator());
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(workflowDto.getProcessKey()
                ,workflowDto.getBusinessKey(),workflowDto.getCaseInstanceId(), workflowDto.getParams());

        return processInstance.getProcessInstanceId();
    }

    @Override
    public List<String> queryTodo(WorkflowQuery query) {
        TaskQuery taskQuery = taskService.createTaskQuery();


        return null;
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
        String jsonStr = variables.get("collects").toString();

        ProcessNodeProps props = JSONObject.parseObject(jsonStr, ProcessNodeProps.class);

        WorkflowInstance instance = new WorkflowInstance(dto, processEngine);

        /**
         * 驳回
         */
        if ("N".equals(dto.getResult())) {
            instance.refuse(task, props);
        }

        return "";
    }
}
