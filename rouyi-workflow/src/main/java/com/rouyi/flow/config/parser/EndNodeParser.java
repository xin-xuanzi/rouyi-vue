package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

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
        return this.buildEnd(nodeBuilder, null);
    }

}
