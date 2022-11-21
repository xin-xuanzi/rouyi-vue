package com.rouyi.flow.config.parser.handler;

import lombok.Data;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * 拒绝处理器
 *
 * @author xuanzi
 * @date 2022/11/8 15:47
 */
@Data
public class RefuseHandler implements IExpandHandler{
    private String type;
    /**
     * 驳回目标活动ID
     */
    private String target;

    @Override
    public void handle(AbstractFlowNodeBuilder nodeBuilder) {

    }

}
