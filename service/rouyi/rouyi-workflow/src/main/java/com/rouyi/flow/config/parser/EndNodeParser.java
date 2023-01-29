package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.engine.delegate.ExecutionListener;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;
import org.camunda.bpm.model.bpmn.instance.camunda.CamundaExecutionListener;

/**
 * 结束节点解析
 *
 * @author xuanzi
 * @date 2022/11/10 17:20
 */
public class EndNodeParser extends AbstractNodeParser {
    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode,
                                         ExpandProcessParser processParser) {
        AbstractFlowNodeBuilder builder = this.buildEnd(nodeBuilder, null);
        //设置 ExecutionListener 流程结束事件监听
        BpmnModelInstance done = nodeBuilder.done();
        CamundaExecutionListener camundaExecutionListener = done.newInstance(CamundaExecutionListener.class);
        camundaExecutionListener.setCamundaEvent(ExecutionListener.EVENTNAME_END);
        camundaExecutionListener.setCamundaExpression("${approvalNodePreProcessListener.end(execution)}");
        builder.addExtensionElement(camundaExecutionListener);


        return builder;
    }

}
