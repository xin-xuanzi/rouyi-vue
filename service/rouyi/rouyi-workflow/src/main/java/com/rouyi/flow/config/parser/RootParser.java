package com.rouyi.flow.config.parser;

import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * 发起人解析器
 *
 * @author xuanzi
 * @date 2022/11/8 17:44
 */
public class RootParser extends AbstractNodeParser {

    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {

        nodeBuilder = nodeBuilder.userTask(WorkflowConstant.SUBMITTER).name("发起人").camundaAssignee("${starter}");

        return parsePostProcess(nodeBuilder, processNode, processParser);
    }

    @Override
    public AbstractFlowNodeBuilder parsePostProcess(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode, ExpandProcessParser processParser) {
        if (processNode.hasChildren()) {
            nodeBuilder = processParser.nodeParse(nodeBuilder, processNode.getChildren());
        }
        return nodeBuilder;
    }
}
