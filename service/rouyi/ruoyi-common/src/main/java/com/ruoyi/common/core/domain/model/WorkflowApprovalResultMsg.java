package com.ruoyi.common.core.domain.model;

import com.ruoyi.common.enums.ApprovalResultEnum;
import com.ruoyi.common.utils.bean.BeanUtils;

import java.util.Map;

/**
 * 审批结果 Msg
 *
 * @author xuanzi
 * @date 2022/12/14 18:50
 */
public class WorkflowApprovalResultMsg {
    private String businessCode;
    private ApprovalResultEnum approvalResult;
    private Long approver;

    public WorkflowApprovalResultMsg() {
    }

    public WorkflowApprovalResultMsg(String businessCode, ApprovalResultEnum approvalResult, Long approver) {
        this.businessCode = businessCode;
        this.approvalResult = approvalResult;
        this.approver = approver;
    }

    public Map<String, Object> toMap() {
        return BeanUtils.fastJsonBean2Map(this);
    }

    public static WorkflowApprovalResultMsg toBean(Map<String, Object> map) {
        return BeanUtils.map2Bean(map, WorkflowApprovalResultMsg.class);
    }

}
