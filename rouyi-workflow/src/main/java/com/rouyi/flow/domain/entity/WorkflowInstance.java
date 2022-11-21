package com.rouyi.flow.domain.entity;

import com.rouyi.flow.config.parser.handler.RefuseHandler;
import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.valobj.ProcessCommonType;
import com.rouyi.flow.domain.valobj.ProcessNodeProps;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.ActivityTypes;
import org.camunda.bpm.engine.ProcessEngine;
import org.camunda.bpm.engine.history.HistoricActivityInstance;
import org.camunda.bpm.engine.impl.RepositoryServiceImpl;
import org.camunda.bpm.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.camunda.bpm.engine.impl.pvm.PvmTransition;
import org.camunda.bpm.engine.impl.pvm.process.ActivityImpl;
import org.camunda.bpm.engine.impl.pvm.process.TransitionImpl;
import org.camunda.bpm.engine.runtime.ActivityInstance;
import org.camunda.bpm.engine.runtime.ProcessInstanceModificationBuilder;
import org.camunda.bpm.engine.task.Task;

import java.util.ArrayList;
import java.util.List;

/**
 * 工作流实例
 *
 * @author xuanzi
 * @date 2022/11/16 11:46
 */
@Slf4j
public class WorkflowInstance {
    private String instanceId;
    private String businessKey;
    private String assignee;
    private String comment;
    private ProcessEngine processEngine;

    public WorkflowInstance(WorkflowApprovalDto approvalDto, ProcessEngine processEngine) {
        this.instanceId = approvalDto.getProcessInstance();
        this.assignee = approvalDto.getUserId();
        this.comment = approvalDto.getComment();

        this.processEngine = processEngine;
    }

    public void refuse(Task currentTask, ProcessNodeProps props) {
        ActivityInstance tree = processEngine.getRuntimeService().getActivityInstance(instanceId);

        List<HistoricActivityInstance> resultList = processEngine.getHistoryService()
                .createHistoricActivityInstanceQuery()
                .processInstanceId(instanceId)
                .activityType(ActivityTypes.TASK_USER_TASK)
                .finished()
                .orderByHistoricActivityInstanceEndTime()
                .asc()
                .list();



        ActivityInstance  currentActivityInstance = getInstanceIdForActivity(tree, currentTask.getTaskDefinitionKey());

        ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) ((RepositoryServiceImpl) processEngine.getRepositoryService())
                .getDeployedProcessDefinition(currentTask.getProcessDefinitionId());

        ActivityImpl currActivity = processDefinitionEntity
                .findActivity(currentTask.getTaskDefinitionKey());

        log.info(">>>>" + processDefinitionEntity);
        log.info(">>>>" + currActivity.getActivityId());
        log.info(">>>>" + currentActivityInstance.toString());
        log.info(">>>>" + currentActivityInstance.getId());
        log.info(">>>>" + currentActivityInstance.getActivityId());

        RefuseHandler refuse = props.getRefuse();

        ProcessInstanceModificationBuilder processInstanceModification = processEngine.getRuntimeService().createProcessInstanceModification(instanceId);

        //
        processEngine.getTaskService().createComment(currentTask.getId(), instanceId, comment);
        switch (refuse.getType()) {
            //结束流程
            case ProcessCommonType.RefuseType.TO_END:

                processInstanceModification = processInstanceModification
                        .cancelActivityInstance(currentActivityInstance.getActivityId());

            //驳回到上一审批人
            case ProcessCommonType.RefuseType.TO_BEFORE:
                HistoricActivityInstance lase = resultList.get(resultList.size() - 1);
                processInstanceModification = processInstanceModification.startBeforeActivity(lase.getActivityId());
                break;

            //跳转到任意节点
            case ProcessCommonType.RefuseType.TO_NODE:

                //清空原有的 flow
                List<PvmTransition> originPvmTransitionList = new ArrayList<PvmTransition>();
                List<PvmTransition> pvmTransitionList = currActivity.getOutgoingTransitions();
                for (PvmTransition pvmTransition : pvmTransitionList) {
                    originPvmTransitionList.add(pvmTransition);
                }

                pvmTransitionList.clear();

                //创建新的小的线条方向
                ActivityImpl target = processDefinitionEntity.findActivity(refuse.getTarget());
                TransitionImpl transitionImpl = currActivity.createOutgoingTransition(target.getId());
                transitionImpl.setDestination(target);

                //任务节点完成
                processEngine.getTaskService().complete(currentTask.getId());

                // 恢复方向
                currActivity.getOutgoingTransitions().remove(transitionImpl);
                for (PvmTransition pvmTransition : originPvmTransitionList) {
                    pvmTransitionList.add(pvmTransition);
                }

                break;
        }

//        processInstanceModification.execute();
    }


    /**
     * 获取当前活动的 instanceId
     * @param activityInstance
     * @param activityId
     * @return
     */
    private ActivityInstance getInstanceIdForActivity( ActivityInstance activityInstance, String activityId) {
        ActivityInstance instance = getChildInstanceForActivity(activityInstance, activityId);
        if (instance != null) {
            return instance;
        }
        return null;
    }

    private ActivityInstance getChildInstanceForActivity(ActivityInstance activityInstance, String activityId) {
        if (activityId.equals(activityInstance.getActivityId())) {
            return activityInstance;
        }
        for (ActivityInstance childInstance : activityInstance.getChildActivityInstances()) {
            ActivityInstance instance = getChildInstanceForActivity(childInstance, activityId);
            if (instance != null) {
                return instance;
            }
        }
        return null;
    }
}
