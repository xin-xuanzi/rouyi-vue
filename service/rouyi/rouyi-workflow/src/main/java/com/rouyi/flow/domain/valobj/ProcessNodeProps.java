package com.rouyi.flow.domain.valobj;

import com.rouyi.flow.config.parser.handler.NoBodyHandler;
import com.rouyi.flow.config.parser.handler.RefuseHandler;
import com.rouyi.flow.config.parser.handler.TimeLimitExpandProcessor;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 节点属性
 *
 * @author xuanzi
 * @date 2022/11/8 14:39
 */
@Data
public class ProcessNodeProps {
    private String assignedType;
    /**
     * 多人审批方式
     */
    private String mode;

    private boolean sign;
    private List<AssignedUser> assignedUser;
    private List<String> formPerms;
    private List<String> role;
    private String formUser;
    private NoBodyHandler nobody;
    private TimeLimitExpandProcessor timeLimit;
    private RefuseHandler refuse;
    private Map selfSelect;
    private Map leaderTop;
    private Map leader;
}
