package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * 抄送人解析器
 *
 * @author xuanzi
 * @date 2022/12/6 16:58
 */
public class CcParser extends AbstractNodeParser {
    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode, ExpandProcessParser processParser) {
        nodeBuilder = nodeBuilder.serviceTask(processNode.getId())
                .name(processNode.getName())
                .camundaExpression("${serviceTaskExpression.setCcUser(execution)}");
        return nodeBuilder;
    }
}
