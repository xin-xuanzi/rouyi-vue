package com.ruoyi.common.core.service;

import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;

/**
 * @author xuanzi
 * @date 2022/12/14 18:15
 */
public interface IBusinessService {
    void execWorkflowEvent(WorkflowApprovalResultMsg msg);
}
