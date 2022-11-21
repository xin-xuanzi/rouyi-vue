package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessCommonType;
import com.rouyi.flow.domain.valobj.ProcessGroupProps;
import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.GatewayDirection;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

import java.util.List;

/**
 * 并行网关
 *
 * @author xuanzi
 * @date 2022/11/9 17:29
 */
public class ParallelParser extends AbstractNodeParser{

    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {
        ProcessGroupProps props = processNode.getProps();

        if (ProcessCommonType.NodeType.CONCURRENTS.equals(processNode.getType())) {
            if (this.emptyGateway(processNode)) {
                return nodeBuilder;
            }

            nodeBuilder = nodeBuilder.parallelGateway().id(processNode.getId()).name(processNode.getName())
                    .gatewayDirection(GatewayDirection.Diverging);

            String endGatewayId =  processNode.getId() + "_end_parallelGateway_";

            processParser.END_PARALLEL_GATEWAY_ID.get().put(processNode.getId(), endGatewayId);

            //解析分支
            List<ProcessNode> branchs = processNode.getBranchs();
            for (int i = 0; i < branchs.size(); i++) {
                nodeBuilder = processParser.nodeParse(nodeBuilder, branchs.get(i));
                if (i == 0) {
                    nodeBuilder.parallelGateway(endGatewayId).name(processNode.getId() + "结束条件网关");
                } else {
                    nodeBuilder.connectTo(endGatewayId);
                }

                nodeBuilder = nodeBuilder.moveToNode(processNode.getId());
            }

            nodeBuilder = nodeBuilder.moveToNode(endGatewayId);

            //解析后置处理
            nodeBuilder = parsePostProcess(nodeBuilder, processNode, processParser);

        } else {
            nodeBuilder = nodeBuilder.condition(processNode.getName(), props.getExpression());

            if (processNode.hasChildren()){
                nodeBuilder = processParser.nodeParse(nodeBuilder, processNode.getChildren());
            }
        }

        return nodeBuilder;
    }

    /**
     * 解析后置处理
     * @param nodeBuilder
     * @param processNode
     * @param processParser
     */
    public AbstractFlowNodeBuilder parsePostProcess(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {
        processParser.END_PARALLEL_GATEWAY_ID.get().remove(processNode.getId());

        //子节点包含 数据
        if (processNode.hasChildren()){
            nodeBuilder =  processParser.nodeParse(nodeBuilder, processNode.getChildren());
        } else {
//            nodeBuilder = this.buildEnd(nodeBuilder, null);
        }

        return nodeBuilder;
    }

}
