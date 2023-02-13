package com.rouyi.flow.domain.entity;

import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.config.parser.handler.RefuseHandler;
import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.valobj.ApproveResult;
import com.rouyi.flow.domain.valobj.ProcessCommonType;
import com.rouyi.flow.domain.valobj.ProcessNodeProps;
import com.rouyi.flow.service.impl.AbstractSubject;
import com.ruoyi.common.constant.WorkflowCommonConstant;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.enums.ApprovalActionEnum;
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
import org.camunda.bpm.engine.task.Comment;
import org.camunda.bpm.engine.task.Task;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 工作流实例
 *
 * @author xuanzi
 * @date 2022/11/16 11:46
 */
@Slf4j
public class WorkflowInstance extends AbstractSubject {
    private String instanceId;
    private String approvalAction;
    private String businessCode;
    private String commentStr;
    private ProcessEngine processEngine;

    public WorkflowInstance(WorkflowApprovalDto approvalDto, ProcessEngine processEngine) {
        this.instanceId = approvalDto.getProcessInstance();
        this.businessCode = approvalDto.getBusiness();
        this.commentStr = approvalDto.getComment();
        this.approvalAction = approvalDto.getResult();

        this.processEngine = processEngine;
    }

    public ApproveResult approve(Task currentTask, ProcessNodeProps props) {
        if (ApprovalActionEnum.REJECT.toString().equals(approvalAction)) {
            ApproveResult result = refuse(currentTask, props);
            result.setMsg(WorkflowApprovalResultMsg.rejectMsg(businessCode,currentTask.getCaseInstanceId()));
            return result;
        } else {
            return pass( currentTask,  props);
        }
    }

    /**
     * 驳回
     * @param currentTask
     * @param props
     * @return
     */
    private ApproveResult refuse(Task currentTask, ProcessNodeProps props) {
        ActivityInstance tree = processEngine.getRuntimeService().getActivityInstance(instanceId);

        List<HistoricActivityInstance> resultList = processEngine.getHistoryService()
                .createHistoricActivityInstanceQuery()
                .processInstanceId(instanceId)
                .activityType(ActivityTypes.TASK_USER_TASK)
                .finished()
                .orderByHistoricActivityInstanceEndTime()
                .asc()
                .list();

        ActivityInstance currentActivityInstance = getInstanceIdForActivity(tree, currentTask.getExecutionId());

        ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) ((RepositoryServiceImpl) processEngine.getRepositoryService())
                .getDeployedProcessDefinition(currentTask.getProcessDefinitionId());

        ActivityImpl currActivity = processDefinitionEntity
                .findActivity(currentTask.getTaskDefinitionKey());

        RefuseHandler refuse = props.getRefuse();

        ProcessInstanceModificationBuilder processInstanceModification = processEngine.getRuntimeService()
                .createProcessInstanceModification(instanceId);


        ApproveResult approveResult = new ApproveResult();
        approveResult.setActionEnum(ApprovalActionEnum.REJECT);
        //判断每个节点的审批配置
        switch (refuse.getType()) {
            //结束流程
            case ProcessCommonType.RefuseType.TO_END:
                processInstanceModification = processInstanceModification
                        .cancelActivityInstance(currentActivityInstance.getId())
                ;

                if (ProcessCommonType.ModeType.AND.equals(props.getMode())
                        || ProcessCommonType.ModeType.NEXT.equals(props.getMode())) {
                    processInstanceModification = processInstanceModification
                            .cancelActivityInstance(currentActivityInstance.getParentActivityInstanceId());
                }

                approveResult.setApprovalResultStatus(WorkflowCommonConstant.APPROVAL_RESULT_STATUS_REJECT);
                break;
            //驳回到上一审批人
            case ProcessCommonType.RefuseType.TO_BEFORE:
                //判断是不是第一个审批人，如果是第一个审批，驳回上一审批人，那就是驳回到提交人中。
                if (resultList.size() == 1) {
                    HistoricActivityInstance submitter = resultList.get(0);
                    processInstanceModification = processInstanceModification.startBeforeActivity(submitter.getActivityId())
                            .cancelActivityInstance(currentActivityInstance.getId());
                    approveResult.setApprovalResultStatus(WorkflowCommonConstant.APPROVAL_RESULT_STATUS_SUBMITTER);
                } else {
                    HistoricActivityInstance lase = resultList.get(resultList.size() - 1);
                    processInstanceModification = processInstanceModification.startBeforeActivity( WorkflowConstant.APPROVAL_PRE_INTERMEDIATE_THROW_EVENT
                            + lase.getActivityId()).cancelActivityInstance(currentActivityInstance.getId());
                }

                break;
            //驳回到提交人
            case ProcessCommonType.RefuseType.TO_SUBMITTER:
                HistoricActivityInstance submitter = resultList.get(0);

                processInstanceModification = processInstanceModification.startBeforeActivity(submitter.getActivityId())
                        .cancelActivityInstance(currentActivityInstance.getId());
                approveResult.setApprovalResultStatus(WorkflowCommonConstant.APPROVAL_RESULT_STATUS_SUBMITTER);
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

            default:

        }

        processInstanceModification.execute();

        Comment comment = processEngine.getTaskService().createComment(currentTask.getId(), instanceId, commentStr);
        approveResult.setComment(comment);
        return approveResult;
    }

    /**
     * 审批通过
     * @param currentTask
     * @param props
     * @return
     */
    private ApproveResult pass(Task currentTask, ProcessNodeProps props) {

        ApproveResult approveResult = new ApproveResult();
        processEngine.getTaskService().complete(currentTask.getId());
        approveResult.setComment(processEngine.getTaskService().createComment(currentTask.getId(), instanceId, commentStr));
        return approveResult;
    }

    /**
     * 获取当前活动的 instanceId
     * @param activityInstance
     * @param executionId
     * @return
     */
    private ActivityInstance getInstanceIdForActivity( ActivityInstance activityInstance, String executionId) {
        ActivityInstance instance = getChildInstanceForActivity(activityInstance, executionId);
        if (instance != null) {
            return instance;
        }
        return null;
    }

    private ActivityInstance getChildInstanceForActivity(ActivityInstance activityInstance, String executionId) {
        if (Arrays.asList(activityInstance.getExecutionIds()).contains(executionId)) {
            return activityInstance;
        }
        for (ActivityInstance childInstance : activityInstance.getChildActivityInstances()) {
            ActivityInstance instance = getChildInstanceForActivity(childInstance, executionId);
            if (instance != null) {
                return instance;
            }
        }
        return null;
    }
}
