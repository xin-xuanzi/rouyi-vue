package com.rouyi.flow.config.parser.handler;

import com.rouyi.flow.domain.valobj.AssignedUser;
import com.rouyi.flow.domain.valobj.ProcessCommonType;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.model.bpmn.builder.AbstractFlowNodeBuilder;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/8 15:09
 */
@Slf4j
@Data
public class NoBodyHandler implements IExpandHandler{
    private String type;
    private List<AssignedUser> assignedUser;

    @Override
    public void handle(AbstractFlowNodeBuilder nodeBuilder) {
        //TODO
        if (ProcessCommonType.NobodyType.TO_USER.equals(type)) {
            log.error("审批人为空，，指定人员");
        }
    }
}
