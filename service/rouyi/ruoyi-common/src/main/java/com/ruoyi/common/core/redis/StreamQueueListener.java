package com.ruoyi.common.core.redis;

import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.core.service.IBusinessService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.connection.stream.ObjectRecord;
import org.springframework.data.redis.stream.StreamListener;
import org.springframework.stereotype.Component;

/**
 * @author xuanzi
 * @date 2022/12/14 11:54
 */
@Slf4j
@Component
public class StreamQueueListener implements StreamListener<String, ObjectRecord<String, WorkflowApprovalResultMsg>> {

    private final RedisService redisService;
    private final IBusinessService businessService;

    public StreamQueueListener(RedisService redisService, IBusinessService businessService) {
        this.redisService = redisService;
        this.businessService = businessService;
    }

    @Override
    public void onMessage(ObjectRecord<String, WorkflowApprovalResultMsg> message) {
        
        try {
            businessService.execWorkflowEvent(message.getValue());

            redisService.streamAck(message.getId());
        } catch (Exception exception) {
            log.error("流程节点审批事件处理信息失败");
            throw exception;
        }

    }
}
