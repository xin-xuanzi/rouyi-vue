package com.ruoyi.common.core.domain.model;

import com.ruoyi.common.enums.ApprovalActionEnum;

import java.io.Serializable;

/**
 * 审批结果 Msg
 *
 * @author xuanzi
 * @date 2022/12/14 18:50
 */
public class WorkflowApprovalResultMsg implements Serializable {
    /**
     * 业务编码
     */
    private String businessCode;
    /**
     * 审批动作
     */
    private ApprovalActionEnum approvalResult;
    /**
     *
     */
    private String businessId;

    private int approvalResultStatus;

    public WorkflowApprovalResultMsg() {
    }

    public WorkflowApprovalResultMsg(String businessCode, ApprovalActionEnum approvalResult,
                                     String businessId) {
        this.businessCode = businessCode;
        this.approvalResult = approvalResult;
        this.businessId = businessId;
    }

    public void setApprovalResultStatus(int approvalResultStatus) {
        this.approvalResultStatus = approvalResultStatus;
    }

    public String getBusinessCode() {
        return businessCode;
    }

    public ApprovalActionEnum getApprovalResult() {
        return approvalResult;
    }

    public String getBusinessId() {
        return businessId;
    }

    public static WorkflowApprovalResultMsg tempMsg() {
        return new WorkflowApprovalResultMsg("TEST", ApprovalActionEnum.REJECT, "-100");
    }

    public static WorkflowApprovalResultMsg passMsg(String businessCode, String businessId) {
        return new WorkflowApprovalResultMsg(businessCode, ApprovalActionEnum.PASS, businessId);
    }
    public static WorkflowApprovalResultMsg rejectMsg(String businessCode, String businessId) {
        return new WorkflowApprovalResultMsg(businessCode, ApprovalActionEnum.REJECT, businessId);
    }

    @Override
    public String toString() {
        return "WorkflowApprovalResultMsg{" +
                "businessCode='" + businessCode + '\'' +
                ", approvalResult='" + approvalResult + '\'' +
                ", businessId='" + businessId + '\'' +
                '}';
    }
}
