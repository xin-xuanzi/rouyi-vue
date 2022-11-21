package com.rouyi.flow.config.parser.handler;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;
import org.camunda.bpm.model.bpmn.instance.BoundaryEvent;
import org.camunda.bpm.model.bpmn.instance.TimeCycle;
import org.camunda.bpm.model.bpmn.instance.TimeDuration;
import org.camunda.bpm.model.bpmn.instance.TimerEventDefinition;
import org.camunda.bpm.model.bpmn.instance.bpmndi.BpmnShape;

import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/8 15:00
 */
@Data
public class TimeLimitExpandProcessor implements IExpandHandler{
    private Timeout timeout;
    private TimeLimitHandler handler;

    @JsonIgnore
    private BoundaryEvent boundaryEvent;
    @JsonIgnore
    private ThreadLocal<Map<String, String>> threadLocal;

    public void setBoundaryEvent(BoundaryEvent boundaryEvent) {
        this.boundaryEvent = boundaryEvent;
    }

    public void setThreadLocal(ThreadLocal threadLocal) {
        this.threadLocal = threadLocal;
    }

    @Override
    public void handle(AbstractFlowNodeBuilder nodeBuilder) {
        BpmnModelInstance done = nodeBuilder.done();
        boundaryEvent.setName("审批定时处理");

        TimerEventDefinition timerEventDefinition = done.newInstance(TimerEventDefinition.class);

        boundaryEvent.getEventDefinitions().add(timerEventDefinition);

        nodeBuilder.getElement().getParentElement()
                .addChildElement(boundaryEvent);
        BpmnShape bpmnShape = nodeBuilder.createBpmnShape(boundaryEvent);
        bpmnShape.getBounds().setX(402);
        bpmnShape.getBounds().setY(182);

        switch (handler.getType()){
            case "PASS":
                TimeDuration timeDuration = done.newInstance(TimeDuration.class);
                timeDuration.setTextContent("PT1H");
                timerEventDefinition.setTimeDuration(timeDuration);
                threadLocal.get().put("KEY", boundaryEvent.getId());
                break;
            case "REFUSE":
                //TODO 驳回
                break;

            case "NOTIFY":
                // 消息提醒, 并创建 service task
                TimeCycle timeCycle = done.newInstance(TimeCycle.class);
                timeCycle.setTextContent("R/PT10S");
                timerEventDefinition.setTimeCycle(timeCycle);
                handler.setBoundaryEvent(boundaryEvent);
                handler.handle(nodeBuilder);
        }


    }

    @Data
    public static class Timeout{
        private String unit;
        private int value;
    }
}
