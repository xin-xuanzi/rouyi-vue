package com.ruoyi.common.core.redis;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.core.service.IBusinessService;
import com.ruoyi.common.core.service.RedisService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.connection.stream.PendingMessages;
import org.springframework.stereotype.Component;

import java.net.UnknownHostException;
import java.util.Map;

/**
 * redis 死信处理
 *
 * @author xuanzi
 * @date 2022/12/14 19:16
 */
@Slf4j
@Component
@AllArgsConstructor
public class HandleDeadLetter {

    private RedisService redisService;

    private IBusinessService businessService;

    public void consumptionMsg() throws UnknownHostException {
        PendingMessages pending = redisService.pendingMsg();

        pending.get().forEach(e -> {
            Map<String, Object> msg = redisService.getMsg(e.getId());

            log.info("处理 pending队列中的数据=>[{}] ", JSONObject.toJSONString(msg.toString()));
            businessService.execWorkflowEvent(WorkflowApprovalResultMsg.toBean(msg));
            redisService.delMsg(e.getId());
        });
    }
}
