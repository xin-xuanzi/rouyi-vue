package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

/**
 * 流程节点解析器
 * @author xuanzi
 * @date 2022/11/8 17:43
 */
public interface INodeParser {

    /**
     * 解析
     * @param nodeBuilder
     * @param processNode
     * @return
     */
    AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode, ExpandProcessParser processParser);
}
