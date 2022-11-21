package com.rouyi.flow.domain.valobj;

import com.google.common.collect.Maps;
import com.rouyi.flow.config.parser.*;

import java.util.Map;

/**
 * 流程节点配置类型
 *
 * @author xuanzi
 * @date 2022/11/8 15:50
 */
public class ProcessCommonType {
    public static final Map<String, AbstractNodeParser> PARSER_MAP = Maps.newHashMap();
    static {
        PARSER_MAP.put(NodeType.ROOT, new RootParser());
        PARSER_MAP.put(NodeType.END, new EndNodeParser());
        PARSER_MAP.put(NodeType.EMPTY, new EmptyNodeParser());
        PARSER_MAP.put(NodeType.APPROVAL, new ApprovalParser());
        PARSER_MAP.put(NodeType.CONDITIONS, new ConditionsParser());
        PARSER_MAP.put(NodeType.CONDITION, new ConditionsParser());
        PARSER_MAP.put(NodeType.CONCURRENTS, new ParallelParser());
        PARSER_MAP.put(NodeType.CONCURRENT, new ParallelParser());
    }

    /**
     * 流程节点类型
     */
    public static class NodeType{

        public static final String END = "END";
        /**
         * 空节点
         */
        public static final String EMPTY = "EMPTY";

        /**
         * 开始节点
         */
        public static final String ROOT = "ROOT";
        /**
         * 用户审批
         */
        public static final String APPROVAL = "APPROVAL";

        /**
         * 条件分支
         */
        public static final String CONDITIONS = "CONDITIONS";

        /**
         * 条件分支--支线
         */
        public static final String CONDITION = "CONDITION";


        /**
         * 并行分支
         */
        public static final String CONCURRENTS = "CONCURRENTS";


        /**
         * 并行分支--支线
         */
        public static final String CONCURRENT = "CONCURRENT";

    }

    /**
     * 选择审批对象
     */
    public static class AssignedType{
        /**
         * 选择人员
         */
        public static final String ASSIGN_USER = "ASSIGN_USER";

        /**
         * 自己选择
         */
        public static final String SELF_SELECT = "SELF_SELECT";

        /**
         * 角色配置
         */
        public static final String ROLE = "ROLE";
    }

    /**
     * 审批人为空
     */
    public static class NobodyType{
        /**
         * 自动通过
         */
        public static final String TO_PASS = "TO_PASS";

        /**
         * 自动驳回
         */
        public static final String TO_REFUSE = "TO_REFUSE";

        /**
         * 转交审批管理员
         */
        public static final String TO_ADMIN = "TO_ADMIN";


        /**
         * 转交到指定人员
         */
        public static final String TO_USER = "TO_USER";
    }


    /**
     * 审批期限
     */
    public static class TimeLimitType{
        /**
         * 自动通过
         */
        public static final String PASS = "PASS";

        /**
         * 自动驳回
         */
        public static final String REFUSE = "REFUSE";

        /**
         * 发送提醒
         */
        public static final String NOTIFY = "NOTIFY";

    }


    /**
     * 审批驳回
     */
    public static class RefuseType{
        /**
         * 直接结束流程
         */
        public static final String TO_END = "TO_END";

        /**
         * 驳回到上级审批节点
         */
        public static final String TO_BEFORE = "TO_BEFORE";

        /**
         * 驳回到指定节点
         */
        public static final String TO_NODE = "TO_NODE";

    }


    /**
     * 多人审批时审批方式
     */
    public static class ModeType{
        /**
         * 会签 （按选择顺序审批，每个人必须同意）
         */
        public static final String NEXT = "NEXT";

        /**
         * 会签（可同时审批，每个人必须同意）
         */
        public static final String AND = "AND";

        /**
         * 或签（有一人同意即可）
         */
        public static final String OR = "OR";

    }

}
