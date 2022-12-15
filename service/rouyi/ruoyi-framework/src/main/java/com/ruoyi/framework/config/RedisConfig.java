package com.ruoyi.framework.config;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.StreamQueueListener;
import com.ruoyi.common.core.service.RedisService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.stream.*;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.data.redis.stream.StreamListener;
import org.springframework.data.redis.stream.StreamMessageListenerContainer;

import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.util.Collections;

/**
 * redis配置
 *
 * @author ruoyi
 */
@Configuration
@EnableCaching
public class RedisConfig extends CachingConfigurerSupport {

    @Value("${spring.application.name}")
    private String groupId;
    @Value("${server.port}")
    private String serverPort;
    @Bean
    @SuppressWarnings(value = {"unchecked", "rawtypes"})
    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        FastJson2JsonRedisSerializer serializer = new FastJson2JsonRedisSerializer(Object.class);

        // 使用StringRedisSerializer来序列化和反序列化redis的key值
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(serializer);

        // Hash的key也采用StringRedisSerializer的序列化方式
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(serializer);

        template.afterPropertiesSet();
        return template;
    }


    @Bean
    public StreamMessageListenerContainer<String, MapRecord<String, String, String>> streamMessageListenerContainer(RedisConnectionFactory redisConnectionFactory) {
        // 创建配置对象
        StreamMessageListenerContainer.StreamMessageListenerContainerOptions<String, MapRecord<String, String, String>>
                streamMessageListenerContainerOptions = StreamMessageListenerContainer.StreamMessageListenerContainerOptions
                .builder()
                // 一次性最多拉取多少条消息
                .batchSize(10)
                .build();

        // 根据配置对象创建监听容器
        return StreamMessageListenerContainer
                .create(redisConnectionFactory, streamMessageListenerContainerOptions);
    }

    @Bean
    @DependsOn(value = {"redisService"})
    public StreamListener<String, MapRecord<String, String, String>> streamListener(
            StreamMessageListenerContainer<String, MapRecord<String, String, String>> streamMessageListenerContainer,
            RedisTemplate<String, String> redisTemplate, RedisService redisService) throws UnknownHostException {

        String consumerName = Inet4Address.getLocalHost().getHostName() + ":" + serverPort;

        // 判断 stream 是否初始化，未初始化则进行初始化
        if (!Boolean.TRUE.equals(redisTemplate.hasKey(CacheConstants.WORKFLOW_STREAM_KEY))) {
            // 往 stream 发送消息，会自动创建 streame
            RecordId recordId = redisTemplate.opsForStream().add(CacheConstants.WORKFLOW_STREAM_KEY, Collections.singletonMap("_up", "up"));

            // 创建 消费者组
            redisTemplate.opsForStream().createGroup(CacheConstants.WORKFLOW_STREAM_KEY, groupId);

            // 删除创建
            redisTemplate.opsForStream().delete(CacheConstants.WORKFLOW_STREAM_KEY, recordId);
        }

        // 监听器
        StreamListener streamListener = new StreamQueueListener(redisService);

        // 使用监听容器监听消息，并且自动应答
        streamMessageListenerContainer.receive(
                Consumer.from(groupId, consumerName),
                StreamOffset.create(CacheConstants.WORKFLOW_STREAM_KEY, ReadOffset.lastConsumed()),
                streamListener);
        return streamListener;
    }


    @Bean
    public DefaultRedisScript<Long> limitScript() {
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setScriptText(limitScriptText());
        redisScript.setResultType(Long.class);
        return redisScript;
    }

    /**
     * 限流脚本
     */
    private String limitScriptText() {
        return "local key = KEYS[1]\n" +
                "local count = tonumber(ARGV[1])\n" +
                "local time = tonumber(ARGV[2])\n" +
                "local current = redis.call('get', key);\n" +
                "if current and tonumber(current) > count then\n" +
                "    return tonumber(current);\n" +
                "end\n" +
                "current = redis.call('incr', key)\n" +
                "if tonumber(current) == 1 then\n" +
                "    redis.call('expire', key, time)\n" +
                "end\n" +
                "return tonumber(current);";
    }
}
