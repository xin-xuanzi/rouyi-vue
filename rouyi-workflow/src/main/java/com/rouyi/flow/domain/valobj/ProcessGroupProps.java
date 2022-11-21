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
        private List<String> cids;
        private List<String> conditions;
    }
}
