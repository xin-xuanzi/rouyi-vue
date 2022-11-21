package com.rouyi.flow.config.parser.handler;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;
import org.camunda.bpm.model.bpmn.builder.BoundaryEventBuilder;
import org.camunda.bpm.model.bpmn.instance.BoundaryEvent;

/**
 * @author xuanzi
 * @date 2022/11/8 15:09
 */
@Data
public class TimeLimitHandler implements IExpandHandler{

    private String type;
    private Notify notify;

    @JsonIgnore
    private BoundaryEvent boundaryEvent;

    @Override
    public void handle(AbstractFlowNodeBuilder nodeBuilder) {
        BoundaryEventBuilder builder = boundaryEvent.builder();

        builder.serviceTask("serviceTask_"+ boundaryEvent.getId())
                .name("定时消息提醒 serviceTask")
                .camundaExpression("${serviceTaskExpression.sendMessage(execution)}")
        ;

    }

    @Data
    public static class Notify{
        private boolean once;
        private int hour;
    }
}
