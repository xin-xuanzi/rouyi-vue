package com.rouyi.flow.config.listener;

import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.springframework.stereotype.Service;

/**
 * @author xuanzi
 * @date 2022/11/16 18:34
 */
@Slf4j
@Service("serviceTaskExpression")
public class ServiceTaskExpression {

    /**
     * 审批节点 前置 intermediateThrowEvent end 事件，用于设置下一节点的审批人
     * @param execution
     */
    public void sendMessage(DelegateExecution execution) {
        log.info("--->>>>" + execution.getVariable("collects"));
        log.error("发送消息提醒");
    }
}
