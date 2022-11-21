package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * 空节点解析器
 *
 * @author xuanzi
 * @date 2022/11/10 11:58
 */
public class EmptyNodeParser extends AbstractNodeParser {

    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode,
                                         ExpandProcessParser processParser) {
        return parsePostProcess(nodeBuilder, processNode, processParser);
    }

    @Override
    public AbstractFlowNodeBuilder parsePostProcess(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode, ExpandProcessParser processParser) {
        //子节点包含 数据
        if (processNode.hasChildren()){
            nodeBuilder =  processParser.nodeParse(nodeBuilder, processNode.getChildren());
        } else if (
                processParser.END_PARALLEL_GATEWAY_ID.get().size() == 0
                && processParser.END_PARALLEL_GATEWAY_ID.get().size() == 0
        ){
//            nodeBuilder = this.buildEnd(nodeBuilder, null);
        }

        return nodeBuilder;
    }

}
