package com.rouyi.flow.config.parser.handler;

import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * @author xuanzi
 * @date 2022/11/8 15:04
 */
public interface IExpandHandler {

    void handle(AbstractFlowNodeBuilder nodeBuilder);
}
