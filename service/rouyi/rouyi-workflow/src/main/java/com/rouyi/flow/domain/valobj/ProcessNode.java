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
public class ProcessNode {
    private String id;
    private String parentId;
    private String type;
    private String name;
    private String desc;
    private ProcessNode children;
    private ProcessGroupProps props;
    private List<ProcessNode> branchs;

    /**
     * 是否 在 网关条件之中，
     * 如果在网关条件中，用户审批任务中 不需要创建结束节点
     */
    private boolean inGateway = false;

    public boolean hasChildren(){
        return  !(children == null
                || children.getId() == null
        //        || ProcessCommonType.NodeType.EMPTY.equals(children.getType())
        );
    }
}
