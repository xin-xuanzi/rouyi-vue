package com.ruoyi.common.core.redis;

import com.ruoyi.common.core.service.RedisService;
import org.springframework.data.redis.connection.stream.MapRecord;
import org.springframework.data.redis.stream.StreamListener;

/**
 * @author xuanzi
 * @date 2022/12/14 11:54
 */
public class StreamQueueListener implements StreamListener<String,MapRecord<String, String, String>> {

    private RedisService redisService;

    public StreamQueueListener( RedisService redisService) {
        this.redisService = redisService;
    }

    @Override
    public void onMessage(MapRecord<String, String, String> message) {
        System.out.println(">>>>>>>>>>>>>>>>>>>" + message.toString());

        //redisService.ack(message.getId());
    }
}
