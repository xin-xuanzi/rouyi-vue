package com.rouyi.flow.config.listener;

import com.alibaba.fastjson2.JSONObject;
import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.domain.valobj.AssignedUser;
import com.rouyi.flow.domain.valobj.ProcessGroupProps;
import com.rouyi.flow.service.IWorkflowService;
import com.ruoyi.common.core.domain.entity.SysUser;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.impl.history.event.HistoricTaskInstanceEventEntity;
import org.camunda.bpm.engine.impl.history.event.HistoryEvent;
import org.camunda.bpm.engine.impl.history.event.HistoryEventProcessor;
import org.camunda.bpm.engine.impl.history.producer.HistoryEventProducer;
import org.camunda.bpm.engine.impl.persistence.entity.ExecutionEntity;
import org.camunda.bpm.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/16 18:34
 */
@Slf4j
@Service("serviceTaskExpression")
@AllArgsConstructor
public class ServiceTaskExpression {

    private final IWorkflowService workflowService;

    /**
     * 发送审批通知
     *
     * @param execution
     */
    public void sendMessage(DelegateExecution execution) {
        List<SysUser> userList = workflowService.queryCurrentApprover(execution.getProcessInstanceId());

        for (SysUser sysUser : userList) {
            log.info("向{}发送审批消息提醒", sysUser.getUserName());
        }
    }

    /**
     * 设置抄送人
     *
     * @param execution
     */
    public void setCcUser(DelegateExecution execution) {
        String currentActivityId = execution.getCurrentActivityId();

        //解析抄送人
        Object variable = execution.getVariable(WorkflowConstant.APPROVAL_NODE_PROPS);
        if (variable != null) {
            JSONObject jsonObject = JSONObject.parseObject(variable.toString());
            //获取节点配置参数
            ProcessGroupProps props = jsonObject.getObject(currentActivityId, ProcessGroupProps.class);
            ExecutionEntity processInstance = (ExecutionEntity) execution.getProcessInstance();
            List<AssignedUser> assignedUser = props.getAssignedUser();
            for (AssignedUser user : assignedUser) {
                TaskEntity taskEntity = new TaskEntity();

                taskEntity.setId(WorkflowConstant.idGenerator.getNextId());
                taskEntity.setRevision(1);
                taskEntity.setCaseInstanceIdWithoutCascade(processInstance.getCaseInstanceId());
                taskEntity.setExecutionId(execution.getId());
                taskEntity.setProcessInstanceId(execution.getProcessInstanceId());
                taskEntity.setProcessDefinitionId(execution.getProcessDefinitionId());
                taskEntity.setName(execution.getCurrentActivityName());
                taskEntity.setDescription("自动知会");
                taskEntity.setTaskDefinitionKey(execution.getCurrentActivityId());
                taskEntity.setPriority(50);
                taskEntity.setCreateTime(new Date());
                taskEntity.setSuspensionState(1);
                taskEntity.setAssignee(user.getUserId());

                //创建 HistoricTask 对象
                HistoryEventProcessor.processHistoryEvents(new HistoryEventProcessor.HistoryEventCreator() {
                    @Override
                    public HistoryEvent createHistoryEvent(HistoryEventProducer producer) {
                        HistoricTaskInstanceEventEntity evt = (HistoricTaskInstanceEventEntity)producer.createTaskInstanceCreateEvt(taskEntity);
                        evt.setDeleteReason("cc");
                        return evt;
                    }
                });
            }

        }
    }
}
