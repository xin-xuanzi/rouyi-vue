package com.rouyi.flow.domain.valobj;

import lombok.Data;

import java.util.List;

/**
 * 前端数组节点
 *
 * @author xuanzi
 * @date 2022/11/8 14:34
 */
@Data
public class ProcessGroupProps extends ProcessNodeProps{
    private String groupsType;
    private String expression;
    private List<Groups> groups;

    @Data
    public static class Groups{
        private String groupType;
        private String variableId;
        private String variableCode;
        private String operator;
        private String value;
    }


    public String resolveGroups() {
        StringBuilder sb = new StringBuilder("${");
        for (Groups group : groups) {
            sb.append(group.getVariableCode()).append(group.getOperator()).append(group.getValue())
                    .append(" ")
                    .append("OR".equals( group.getGroupType())?"||":"&&")
                    .append(" ")
            ;
        }

        sb = sb.delete(sb.length() - 3, sb.length());

        sb.append("}");
        return sb.toString();
    }
}
