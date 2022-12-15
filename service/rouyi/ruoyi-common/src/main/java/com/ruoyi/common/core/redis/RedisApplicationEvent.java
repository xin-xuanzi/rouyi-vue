package com.ruoyi.common.core.redis;

import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.data.redis.stream.StreamMessageListenerContainer;
import org.springframework.stereotype.Component;

/**
 * @author xuanzi
 * @date 2022/12/14 15:24
 */
@Component
public class RedisApplicationEvent implements ApplicationListener<ApplicationStartedEvent> {
    @Override
    public void onApplicationEvent(ApplicationStartedEvent event) {
        // 启动redis stream 监听
        event.getApplicationContext()
                .getBeanProvider(StreamMessageListenerContainer.class)
                .ifAvailable(container -> container.start());


    }
}
