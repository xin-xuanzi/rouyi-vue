package com.rouyi.flow.service.impl;

import com.rouyi.flow.service.IWorkflowVariableInvokeService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**
 * @author xuanzi
 * @date 2022/11/30 11:36
 */
@Service("workflowVariableInvokeService")
public class WorkflowVariableInvokeServiceImpl implements IWorkflowVariableInvokeService {

    @Override
    public BigDecimal leaveDaysCurrentMonth(String starter) {
        return new BigDecimal(1.5);
    }
}
