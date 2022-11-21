package com.rouyi.flow.config.parser.handler;

import lombok.Data;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * 审批人选择处理器
 * @author xuanzi
 * @date 2022/11/8 15:18
 */
@Data
public class AssignedTypeHandler implements IExpandHandler{
    private String type;
    private String assignedUser;
    private String roles;

    @Override
    public void handle(AbstractFlowNodeBuilder nodeBuilder) {

    }
}
