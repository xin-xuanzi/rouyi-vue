package com.rouyi.flow.config;

import org.camunda.bpm.engine.impl.cfg.IdGenerator;
import org.camunda.bpm.engine.impl.persistence.StrongUuidGenerator;

/**
 * 工作流流程常量
 *
 * @author xuanzi
 * @date 2022/11/16 18:54
 */
public class WorkflowConstant {


    public static final IdGenerator idGenerator = new StrongUuidGenerator();


    /**
     * 审批节点 前置审批 中间过度事件
     */
    public static final String APPROVAL_PRE_INTERMEDIATE_THROW_EVENT = "Approval-pre-process_";

    /**
     * 审批人节点参数
     */
    public static final String APPROVAL_NODE_PROPS = "ApprovalProps";

    /**
     * 提交人
     */
    public static final String SUBMITTER = "Submitter_12312";
}
