package com.rouyi.flow.config.parser;

import com.alibaba.fastjson2.JSONObject;
import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.domain.ExpandProcess;
import com.rouyi.flow.domain.valobj.ProcessCommonType;
import com.rouyi.flow.domain.valobj.ProcessNode;
import com.ruoyi.common.exception.ServiceException;
import org.camunda.bpm.model.bpmn.Bpmn;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;
import org.camunda.bpm.model.bpmn.builder.ProcessBuilder;

import java.util.HashMap;
import java.util.Map;

/**
 * 流程节点解析器
 *
 * @author xuanzi
 * @date 2022/11/8 16:48
 */

public class ExpandProcessParser {

    /**
     * 用于记录条件网关个数，
     */
    ThreadLocal<Map<String, String>> END_EXCLUSIVE_GATEWAY_ID = ThreadLocal.withInitial(HashMap::new);

    /**
     * 用于记录并行网关个数
     */
    ThreadLocal<Map<String, String>> END_PARALLEL_GATEWAY_ID = ThreadLocal.withInitial(HashMap::new);

//    ThreadLocal<Map<String, ProcessGroupProps>> NODE_PROPS = ThreadLocal.withInitial(HashMap::new);

    /**
     * ID 生成器
     */
    private ExpandProcess expandProcess;

    private ProcessNode processNode;

    private ProcessBuilder processBuilder;

    public ExpandProcessParser(ExpandProcess expandProcess) {
        this.expandProcess = expandProcess;
        this.processNode = JSONObject.parseObject(expandProcess.getSource(), ProcessNode.class);
    }

    public BpmnModelInstance parse() {
        if (expandProcess == null) {
            return null;
        }

        processBuilder = Bpmn.createExecutableProcess(expandProcess.getBusinessCode()+ "_" + expandProcess.getId())
                .name(expandProcess.getName());

        AbstractFlowNodeBuilder nodeBuilder = null;

        // 开始解析，创建开始节点
        nodeBuilder =
                processBuilder.startEvent().name("start").camundaInitiator("starter");

        //创建用户提交 node
        nodeBuilder = nodeParse(nodeBuilder, processNode);

        nodeBuilder = nodeBuilder.moveToNode(WorkflowConstant.SUBMITTER);
//        BpmnModelInstance instance = nodeBuilder.done();

        //保存节点参数
//        CamundaInputOutput inputOutput = instance.newInstance(CamundaInputOutput.class);
//        CamundaOutputParameter outputParameter = instance.newInstance(CamundaOutputParameter.class);
//        inputOutput.getCamundaOutputParameters().add(outputParameter);
//        outputParameter.setCamundaName(WorkflowConstant.APPROVAL_NODE_PROPS);
//        outputParameter.setTextContent(JSONObject.toJSONString(NODE_PROPS.get()));
//        nodeBuilder.addExtensionElement(inputOutput);

        BpmnModelInstance done = nodeBuilder.done();

        return done;
    }

    /**
     * 流程解析
     * @param nodeBuilder
     * @param processNode
     * @return
     */
    public AbstractFlowNodeBuilder nodeParse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode) {

        AbstractNodeParser abstractNodeParser = ProcessCommonType.PARSER_MAP
                .get(processNode.getType());
        if (abstractNodeParser == null) {
            throw new ServiceException("流程节点解析失败，未找到【"+processNode.getType()+"】对应的解析器", 500);
        }

        //添加属性记录 node 节点属性，
        nodeBuilder = abstractNodeParser.parse(nodeBuilder, processNode, this);

        return nodeBuilder;
    }

}
