package com.rouyi.flow.config.parser;

import com.rouyi.flow.domain.valobj.ProcessNode;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

import java.util.HashMap;
import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/8 17:48
 */
public abstract class AbstractNodeParser implements INodeParser{
    /**
     * 条件分支--结束节点
     * key 条件分支开始
     * value 条件分支结束
     */

    ThreadLocal<String> END_ID = new ThreadLocal<>();
    /**
     *
     */
    ThreadLocal<Map<String, String>> TIMER_PASS_REJECT_ = ThreadLocal.withInitial(HashMap::new);

    public AbstractFlowNodeBuilder buildEnd(AbstractFlowNodeBuilder nodeBuilder, String previousNodeBoundaryEventId) {
        if (END_ID.get() == null) {
            String end = "endEvent";
            END_ID.set(end);

            nodeBuilder = nodeBuilder.endEvent().id(END_ID.get())
                    .name("Invoice processed");
        } else  {
            nodeBuilder.connectTo(END_ID.get());
        }

        return nodeBuilder;
    }

    /**
     * 解析 后置处理
     *
     * @param nodeBuilder
     * @param processNode
     * @param processParser
     */
    public AbstractFlowNodeBuilder parsePostProcess(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {

        return nodeBuilder;
    }

    /**
     * 判断是不是空的网关条件，如果为空就不需要创建
     * @param processNode
     * @return
     */
    boolean emptyGateway(ProcessNode processNode){
        boolean empty = true;

        for (ProcessNode branch : processNode.getBranchs()) {
            if (branch.hasChildren()) {
                empty = false;
                break;
            }
        }

        return empty;
    }
}
