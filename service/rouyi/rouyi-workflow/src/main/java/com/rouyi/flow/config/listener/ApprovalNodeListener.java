package com.rouyi.flow.config.listener;

import com.alibaba.fastjson2.JSONObject;
import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.domain.valobj.AssignedUser;
import com.rouyi.flow.domain.valobj.ProcessGroupProps;
import com.rouyi.flow.service.ApproveObserver;
import com.rouyi.flow.service.impl.AbstractSubject;
import com.ruoyi.common.constant.WorkflowCommonConstant;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户节点 监听器 listener
 * @author xuanzi
 * @date 2022/11/9 10:39
 */
@Slf4j
@AllArgsConstructor
@Service("approvalNodePreProcessListener")
public class ApprovalNodeListener extends AbstractSubject {

    private ApproveObserver approveObserver;

    @PostConstruct
    public void registerObserver(){
        add(approveObserver);
    }


    public void preExecution(DelegateExecution execution) {
        log.error("用户节点前置执行！！！");
    }

    public void start(DelegateExecution execution) {
        log.error("流程开始");

    }

    /**
     * 流程结束
     * @param execution
     */
    public void end(DelegateExecution execution) {
        log.info("流程结束");

        ExecutionEntity executionEntity = (ExecutionEntity) execution;
        WorkflowApprovalResultMsg msg = WorkflowApprovalResultMsg.passMsg(executionEntity.getBusinessKey(), executionEntity.getCaseInstanceId());
        msg.setApprovalResultStatus(WorkflowCommonConstant.APPROVAL_RESULT_STATUS_PASS);
        notifyObserver(msg);
    }

    /**
     * 审批节点 前置 intermediateThrowEvent end 事件，用于设置下一节点的审批人
     * @param execution
     */
    public void preProcessEndListener(DelegateExecution execution) {
        String currentActivityId = execution.getCurrentActivityId();

        //解析下个节点的审批配置
        Object variable = execution.getVariable(WorkflowConstant.APPROVAL_NODE_PROPS);
        if (variable != null) {
            JSONObject jsonObject = JSONObject.parseObject(variable.toString());
            String nextApprovalNodeId = currentActivityId.split(WorkflowConstant.APPROVAL_PRE_INTERMEDIATE_THROW_EVENT)[1];
            //获取节点配置参数
            ProcessGroupProps props = jsonObject.getObject(nextApprovalNodeId, ProcessGroupProps.class);

            List<AssignedUser> assignedUser = props.getAssignedUser();
            List<String> collect = assignedUser.stream().map(AssignedUser::getUserId).collect(Collectors.toList());
            execution.setVariable("countersignUsers", collect);
        }

        log.error("用户节点 preProcessEndListener 监听");
    }

}
