package com.rouyi.flow.service;

import java.math.BigDecimal;

/**
 * @author xuanzi
 * @date 2022/11/30 11:35
 */
public interface IWorkflowVariableInvokeService {

    /**
     * 当前月份请假天数
     * @return
     */
    BigDecimal leaveDaysCurrentMonth(String starter);
}
