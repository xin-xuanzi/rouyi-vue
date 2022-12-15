package com.ruoyi.framework.config;

import com.ruoyi.framework.injector.SqlInjector;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

import java.util.TimeZone;

/**
 * 程序注解配置
 *
 * @author ruoyi
 */
@Configuration
// 表示通过aop框架暴露该代理对象,AopContext能够访问
@EnableAspectJAutoProxy(exposeProxy = true)
@MapperScan(basePackages = {"com.ruoyi.**.mapper"
        ,"com.ruoyi.business.*.repo"
        , "com.rouyi.*.repo.dao"})
public class ApplicationConfig
{


    @Bean
    public SqlInjector sqlInjector(){
        return new SqlInjector();
    }

    /**
     * 时区配置
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jacksonObjectMapperCustomization()
    {
        return jacksonObjectMapperBuilder -> jacksonObjectMapperBuilder.timeZone(TimeZone.getDefault());
    }
}
