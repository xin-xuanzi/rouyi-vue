package com.rouyi.flow.service;

import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;

/**
 * 观察者
 *
 * @author xuanzi
 * @date 2023/1/10 17:02
 */
public interface ApproveObserver {
    /**
     * 通知消息
     * @param msg
     */
    void response(WorkflowApprovalResultMsg msg);
}
