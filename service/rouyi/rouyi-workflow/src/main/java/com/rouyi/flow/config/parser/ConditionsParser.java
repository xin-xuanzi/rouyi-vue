package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessCommonType;
import com.rouyi.flow.domain.valobj.ProcessGroupProps;
import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.GatewayDirection;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

import java.util.List;

/**
 * 条件网关
 *
 * @author xuanzi
 * @date 2022/11/8 18:46
 */
public class ConditionsParser extends AbstractNodeParser {

    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {
        ProcessGroupProps props = processNode.getProps();

        if (ProcessCommonType.NodeType.CONDITIONS.equals(processNode.getType())) {
            if (this.emptyGateway(processNode)) {
                return nodeBuilder;
            }

            nodeBuilder = nodeBuilder.exclusiveGateway().id(processNode.getId()).name(processNode.getName())
                    .gatewayDirection(GatewayDirection.Diverging);

            String endExclusiveGatewayId =  processNode.getId() + "_end_Gateway_";
            processParser.END_EXCLUSIVE_GATEWAY_ID.get().put(processNode.getId(), endExclusiveGatewayId);

            //解析分支
            List<ProcessNode> branchs = processNode.getBranchs();
            for (int i = 0; i < branchs.size(); i++) {
                nodeBuilder = processParser.nodeParse(nodeBuilder, branchs.get(i));

                if (i == 0) {
                    nodeBuilder.exclusiveGateway(endExclusiveGatewayId).name(processNode.getId() + "结束条件网关");
                } else {
                    nodeBuilder.connectTo(endExclusiveGatewayId);
                }

                //条件分支创建之后，跳转到开始网关
                nodeBuilder = nodeBuilder.moveToNode(processNode.getId());
            }

            nodeBuilder = nodeBuilder.moveToNode(endExclusiveGatewayId);

            //解析后置处理
            nodeBuilder = parsePostProcess(nodeBuilder, processNode, processParser);
        } else {
            nodeBuilder = nodeBuilder.condition(processNode.getName(), props.resolveGroups());

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
        processParser.END_EXCLUSIVE_GATEWAY_ID.get().remove(processNode.getId());

        //子节点包含 数据
        if (processNode.hasChildren() ){
            nodeBuilder =  processParser.nodeParse(nodeBuilder, processNode.getChildren());
        } else {
//            nodeBuilder = this.buildEnd(nodeBuilder, null);
        }

        return nodeBuilder;
    }
}
