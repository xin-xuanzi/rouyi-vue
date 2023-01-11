package com.ruoyi.common.core.redis;

import com.google.common.collect.Lists;
import com.ruoyi.common.constant.RedisConstants;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Range;
import org.springframework.data.redis.connection.stream.*;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.time.Duration;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Redis 服务类
 *
 * @author xuanzi
 * @time 2022/12/14 18:21
 */
@Slf4j
@Service
public class RedisService {
    @Value("${server.port}")
    private String port;

    @Value("${spring.application.name}")
    private String groupId;

    private final StringRedisTemplate redisTemplate;

    public RedisService(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public Consumer getCurrentConsumer() {
        String  consumerName = "";
        try {
            consumerName = Inet4Address.getLocalHost().getHostName() + ":" + port;
        } catch (UnknownHostException e) {
            throw new RuntimeException(e);
        }

        return Consumer.from(groupId, consumerName);
    }


    public void checkKey(String key, String groupId) {
        Boolean aBoolean = redisTemplate.hasKey(key);
        if (Boolean.FALSE.equals(aBoolean)) {
            //创建 stream key
            RecordId recordId = addMsg(key, WorkflowApprovalResultMsg.tempMsg());
            //创建组
            createGroup(key, groupId);

            //删除上面的临时消息
            delMsg(key, recordId);
        }
    }

    public void delConsumer(Consumer consumer) {
        redisTemplate.opsForStream().deleteConsumer(RedisConstants.STREAM_KEY, consumer);
    }

    /**
     * 创建消费组
     *
     * @param key
     * @param group
     * @return
     */
    public String creatGroup(String key, String group) {
        return redisTemplate.opsForStream().createGroup(key, group);
    }

    public RecordId workflowSendMsg(WorkflowApprovalResultMsg record) {
        return addMsg(RedisConstants.STREAM_KEY, record);
    }
    public RecordId addMsg(String key, WorkflowApprovalResultMsg record) {

        ObjectRecord<String, WorkflowApprovalResultMsg> objectRecord
                = StreamRecords.objectBacked(record).withStreamKey(key);

        return redisTemplate.opsForStream().add(objectRecord);
    }

    public void createGroup(String key, String groupId) {
        redisTemplate.opsForStream().createGroup(key, groupId);
    }

    public void delMsg(String key, RecordId recordId) {
        redisTemplate.opsForStream().delete(key, recordId);
    }


    public void ack(String key, String groupId, RecordId recordId) {
        redisTemplate.opsForStream().acknowledge(RedisConstants.STREAM_KEY, groupId, recordId);
    }

    public void streamAck(RecordId recordId) {
        ack(RedisConstants.STREAM_KEY, groupId, recordId);
    }


    public PendingMessages pendingMsg(String key, Consumer consumer) {
        return redisTemplate.opsForStream().pending(key, consumer);
    }


    public StreamInfo.XInfoGroups groups(String key) {
        return redisTemplate.opsForStream().groups(key);
    }

    public StreamInfo.XInfoConsumers consumers(String key, String groupId) {
        return redisTemplate.opsForStream().consumers(key,groupId);
    }


    /**
     * 处理死信
     */
    public List<ObjectRecord<String, WorkflowApprovalResultMsg>> deadLetter() {

        PendingMessages pendingMessages = pendingMsg(RedisConstants.STREAM_KEY, getCurrentConsumer());

        if (pendingMessages.isEmpty()) {
            return Lists.newArrayList();
        }

        PendingMessage first = pendingMessages.get(0);
        PendingMessage last = pendingMessages.get(pendingMessages.size() - 1);

        Range<String> range = Range.closed(first.getIdAsString(), last.getIdAsString());

        return redisTemplate.opsForStream()
                .range(WorkflowApprovalResultMsg.class,
                RedisConstants.STREAM_KEY, range);
    }

    public void changeOtherConsumer()  {
        PendingMessages pendingMessages = pendingMsg(RedisConstants.STREAM_KEY, getCurrentConsumer());

        if (pendingMessages.isEmpty()) {
            return;
        }

        //过滤掉 执行次 2次 以上的
        pendingMessages.stream().filter(e -> e.getTotalDeliveryCount() < 3).collect(Collectors.toList());
        StreamInfo.XInfoConsumers consumers = consumers(RedisConstants.STREAM_KEY, groupId);
        //选择其他的消费者
        Consumer currentConsumer = getCurrentConsumer();
        String otherConsumer = null;
        Iterator<StreamInfo.XInfoConsumer> iterator = consumers.stream().iterator();
        if (consumers.size() < 2) {
            log.error("当前分组中的消费者只有一个，不需要想转换消费者");
            return;
        }
        while (iterator.hasNext()){
            StreamInfo.XInfoConsumer next = iterator.next();
            if (!next.consumerName().equals(currentConsumer.getName())) {
                otherConsumer = next.consumerName();
                break;
            }
        }

        if (otherConsumer == null) {
            log.error("获取其他消费者失败。");
            return;
        }

        List<RecordId> collect = pendingMessages.stream().filter(e -> e.getTotalDeliveryCount() < 3).map(e -> e.getId()).collect(Collectors.toList());

        log.info("totalPending=[{}], <3次=[{}]", pendingMessages.size(), collect.size());
        if (collect.isEmpty()) {
            return;
        }

        RecordId[] recordIds = collect.toArray(new RecordId[collect.size()]);
        final String finalOtherConsumer = otherConsumer;
        redisTemplate.execute((RedisCallback<Object>) connection ->
                connection.streamCommands().xClaim(RedisConstants.STREAM_KEY.getBytes(),
                        groupId, finalOtherConsumer,
                        Duration.ofSeconds(10), recordIds));

    }
}
