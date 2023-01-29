package com.rouyi.flow.domain.valobj;

import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.enums.ApprovalActionEnum;
import lombok.Data;
import org.camunda.bpm.engine.task.Comment;

/**
 * 审批结果
 *
 * @author xuanzi
 * @date 2023/1/29 13:53
 */
@Data
public class ApproveResult {
    /**
     * 审批动作
     */
    private ApprovalActionEnum actionEnum;

    /**
     * 0：提交人节点
     * 1：流程结束（驳回）
     * 2：流程正常通过
     */
    private int approvalResultStatus = -99;

    private Comment comment;

    private WorkflowApprovalResultMsg msg;

    public void setMsg(WorkflowApprovalResultMsg msg) {
        msg.setApprovalResultStatus(approvalResultStatus);
        this.msg = msg;
    }
}
