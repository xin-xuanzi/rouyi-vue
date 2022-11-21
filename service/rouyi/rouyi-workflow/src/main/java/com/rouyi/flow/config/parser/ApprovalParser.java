package com.rouyi.flow.config.parser;

import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.config.parser.handler.NoBodyHandler;
import com.rouyi.flow.config.parser.handler.RefuseHandler;
import com.rouyi.flow.config.parser.handler.TimeLimitExpandProcessor;
import com.rouyi.flow.domain.valobj.ProcessCommonType;
import com.rouyi.flow.domain.valobj.ProcessNode;
import com.rouyi.flow.domain.valobj.ProcessNodeProps;
import org.camunda.bpm.engine.delegate.ExecutionListener;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;
import org.camunda.bpm.model.bpmn.builder.IntermediateThrowEventBuilder;
import org.camunda.bpm.model.bpmn.builder.UserTaskBuilder;
import org.camunda.bpm.model.bpmn.instance.BoundaryEvent;
import org.camunda.bpm.model.bpmn.instance.camunda.CamundaExecutionListener;

/**
 * 审批人解析器
 *
 * @author xuanzi
 * @date 2022/11/8 17:44
 */
public class ApprovalParser extends AbstractNodeParser {

    /**
     * 创建用户审批前置处理 intermediateThrowEvent
     * 处理下一个节点的审批人
     *
     * @param processNode
     * @param nodeBuilder
     * @return
     */
    private AbstractFlowNodeBuilder preProcess(ProcessNode processNode, AbstractFlowNodeBuilder nodeBuilder) {
        String id  = WorkflowConstant.APPROVAL_PRE_INTERMEDIATE_THROW_EVENT + processNode.getId();
        IntermediateThrowEventBuilder throwEventBuilder = nodeBuilder.intermediateThrowEvent(id)
                .name(processNode.getName() + "--审批 过度事件");

        //设置 ExecutionListener 事件监听
        BpmnModelInstance done = nodeBuilder.done();
        CamundaExecutionListener camundaExecutionListener = done.newInstance(CamundaExecutionListener.class);
        camundaExecutionListener.setCamundaEvent(ExecutionListener.EVENTNAME_END);
        camundaExecutionListener.setCamundaExpression("${approvalNodePreProcessListener.preProcessEndListener(execution)}");
        throwEventBuilder.addExtensionElement(camundaExecutionListener);

        //判断是上个节点 是否有时间截至任务，直接审批通过
        if (TIMER_PASS_REJECT_.get().size() > 0) {
            String key = TIMER_PASS_REJECT_.get().get("KEY");
            nodeBuilder.moveToNode(key).connectTo(id);
        }


        return throwEventBuilder;
    }

    @Override
    public AbstractFlowNodeBuilder parse(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {
        ProcessNodeProps props = processNode.getProps();

        nodeBuilder = preProcess(processNode, nodeBuilder);


        UserTaskBuilder userTaskBuilder = nodeBuilder.userTask()
                .id(processNode.getId())
                .name(processNode.getName());


        // 指定人员
        if (ProcessCommonType.AssignedType.ASSIGN_USER.equals(props.getAssignedType())) {
            userTaskBuilder.camundaAssignee("${approver}");
        }

        // 审批人为空时
        NoBodyHandler nobody = props.getNobody();
        nobody.handle(nodeBuilder);

        // 审批期限
        TimeLimitExpandProcessor timeLimit = props.getTimeLimit();
        if (timeLimit.getTimeout().getValue() > 0) {
            BpmnModelInstance done = nodeBuilder.done();
            BoundaryEvent boundaryEvent = done.newInstance(BoundaryEvent.class);
            boundaryEvent.setAttachedTo(userTaskBuilder.getElement());
            String id = "boundaryEvent" + processNode.getId();

            boundaryEvent.setId(id);

            timeLimit.setBoundaryEvent(boundaryEvent);
            timeLimit.setThreadLocal(TIMER_PASS_REJECT_);
            //TODO 处理审批限期
            timeLimit.handle(nodeBuilder);
        }

        // 审批期限
        RefuseHandler refuse = props.getRefuse();
        //TODO 处理驳回
        refuse.handle(nodeBuilder);


//        if (processNode.hasChildren()){
//            return processParser.nodeParse(userTaskBuilder, processNode.getChildren());
//        }

        return parsePostProcess(userTaskBuilder, processNode, processParser);

    }

    @Override
    public AbstractFlowNodeBuilder parsePostProcess(AbstractFlowNodeBuilder nodeBuilder, ProcessNode processNode
            , ExpandProcessParser processParser) {

        if (processNode.hasChildren()) {
            nodeBuilder = processParser.nodeParse(nodeBuilder, processNode.getChildren());
        }

        if (processParser.END_EXCLUSIVE_GATEWAY_ID.get().size() == 0
                && processParser.END_PARALLEL_GATEWAY_ID.get().size() == 0) {
//            nodeBuilder = this.buildEnd(nodeBuilder, null);
        }

        return nodeBuilder;
    }
}
