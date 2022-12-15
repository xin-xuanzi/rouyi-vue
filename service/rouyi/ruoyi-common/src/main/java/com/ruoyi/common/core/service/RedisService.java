package com.ruoyi.common.core.service;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Range;
import org.springframework.data.redis.connection.stream.Consumer;
import org.springframework.data.redis.connection.stream.MapRecord;
import org.springframework.data.redis.connection.stream.PendingMessages;
import org.springframework.data.redis.connection.stream.RecordId;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StreamOperations;
import org.springframework.stereotype.Service;

import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

/**
 * Redis 服务类
 *
 * @author xuanzi
 * @date 2022/12/14 18:21
 */
@Service
@AllArgsConstructor
public class RedisService {
    @Value("${spring.application.name}")
    private String groupId;
    @Value("${server.port}")
    private String serverPort;

    public RedisTemplate redisTemplate;

    public IBusinessService businessService;

    public PendingMessages pendingMsg() throws UnknownHostException {
        String consumerName = Inet4Address.getLocalHost().getHostName() + ":" + serverPort;
        StreamOperations streamOperations = redisTemplate.opsForStream();
        Consumer consumer = Consumer.from(groupId, consumerName);
        PendingMessages pending = streamOperations.pending(CacheConstants.WORKFLOW_STREAM_KEY, consumer);

        return pending;
    }

    public Map<String, Object> getMsg(RecordId recordId){
        StreamOperations streamOperations = redisTemplate.opsForStream();
        List<MapRecord<String, String, Object>> result = streamOperations.range(CacheConstants.WORKFLOW_STREAM_KEY,
                Range.rightOpen(recordId.toString(), recordId.toString()));
        MapRecord<String, String, Object> entries = result.get(0);

        return entries.getValue();
    }


    /**
     * 添加消息
     *
     * @param msg
     */
    public void addMsg(WorkflowApprovalResultMsg msg) {
        StreamOperations streamOperations = redisTemplate.opsForStream();

        streamOperations.add(CacheConstants.WORKFLOW_STREAM_KEY, msg.toMap());
    }

    /**
     * 删除队列中的消息
     *
     * @param recordId
     */
    public void delMsg(RecordId recordId) {

        redisTemplate.opsForStream().delete(CacheConstants.WORKFLOW_STREAM_KEY, recordId);
    }

    /**
     * 设置消息已处理
     *
     * @param recordId
     */
    public void ack(RecordId recordId) {

        redisTemplate.opsForStream().acknowledge(CacheConstants.WORKFLOW_STREAM_KEY,
                groupId, recordId);
    }
}
