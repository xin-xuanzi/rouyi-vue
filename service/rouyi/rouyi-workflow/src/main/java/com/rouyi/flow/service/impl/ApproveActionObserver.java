package com.rouyi.flow.service.impl;

import com.rouyi.flow.service.ApproveObserver;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.core.redis.RedisService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * 审批活动 观察者
 * @author xuanzi
 * @date 2023/1/10 17:07
 */
@Component
@AllArgsConstructor
public class ApproveActionObserver implements ApproveObserver {
    private RedisService redisService;

    @Override
    public void response(WorkflowApprovalResultMsg msg) {
        redisService.workflowSendMsg(msg);
    }
}
