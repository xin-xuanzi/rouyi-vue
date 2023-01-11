package com.ruoyi.common.core.redis;

import com.ruoyi.common.constant.RedisConstants;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.stream.Consumer;
import org.springframework.data.redis.connection.stream.ObjectRecord;
import org.springframework.data.redis.connection.stream.ReadOffset;
import org.springframework.data.redis.connection.stream.StreamOffset;
import org.springframework.data.redis.stream.StreamListener;
import org.springframework.data.redis.stream.StreamMessageListenerContainer;
import org.springframework.stereotype.Component;

import java.net.Inet4Address;

/**
 * @author xuanzi
 * @date 2023/1/6 13:34
 */
@Slf4j
@Component
public class StreamListenerRunner implements ApplicationRunner, DisposableBean {
    @Value("${spring.application.name}")
    private String groupId;
    @Value("${server.port}")
    private String serverPort;
    private StreamMessageListenerContainer<String, ObjectRecord<String, WorkflowApprovalResultMsg>> listenerContainer;


    private final RedisService redisStreamService;

    private final StreamListener<String, ObjectRecord<String, WorkflowApprovalResultMsg>> streamMsgListener;

    private final RedisConnectionFactory redisConnectionFactory;

    public StreamListenerRunner(RedisService redisStreamService,
                                StreamListener<String, ObjectRecord<String, WorkflowApprovalResultMsg>> streamMsgListener,
                                RedisConnectionFactory redisConnectionFactory) {
        this.redisStreamService = redisStreamService;
        this.streamMsgListener = streamMsgListener;
        this.redisConnectionFactory = redisConnectionFactory;
    }

    @Override
    public void destroy() throws Exception {

    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        StreamMessageListenerContainer.StreamMessageListenerContainerOptions<String, ObjectRecord<String,
                        WorkflowApprovalResultMsg>>
                build = StreamMessageListenerContainer
                .StreamMessageListenerContainerOptions
                .builder()
                .targetType(WorkflowApprovalResultMsg.class)
                // 一次性最多拉取多少条消息
                .batchSize(10)
                .build();

        // 根据配置对象创建监听容器
        listenerContainer = StreamMessageListenerContainer
                .create(redisConnectionFactory, build);

        String consumerName = Inet4Address.getLocalHost().getHostName() + ":" + serverPort;
        //验证分组是否已经创建
        redisStreamService.checkKey(RedisConstants.STREAM_KEY, groupId);
        // 使用监听容器监听消息，设置不自动应答
        listenerContainer.receive(
                Consumer.from(groupId, consumerName),
                StreamOffset.create(RedisConstants.STREAM_KEY, ReadOffset.lastConsumed()),
                streamMsgListener);

        listenerContainer.start();
    }
}
