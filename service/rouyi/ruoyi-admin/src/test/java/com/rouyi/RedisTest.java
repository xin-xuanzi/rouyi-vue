package com.rouyi;

import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.core.redis.RedisService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author xuanzi
 * @date 2022/12/8 15:18
 */
public class RedisTest extends BaseJunit{
    @Autowired
    private RedisService redisService;

    @Test
    public void text001() {
        redisService.workflowSendMsg(WorkflowApprovalResultMsg.rejectMsg("123", "123"));
    }
}
