package com.rouyi.flow.service.impl;


import com.rouyi.flow.service.ApproveObserver;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;

import java.util.ArrayList;
import java.util.List;

/**
 * 抽象目标
 * @author xuanzi
 * @date 2023/1/10 17:09
 */
public abstract class AbstractSubject {
    protected List<ApproveObserver> observers = new ArrayList<>();

    /** 增加观察者方法
     *
     * @param observer
     */
    public void add(ApproveObserver observer) {
        observers.add(observer);
    }

    /** 删除观察者方法
     *
     * @param observer
     */
    public void remove(ApproveObserver observer) {
        observers.remove(observer);
    }

    /** 通知观察者方法
     *
     * @param msg
     */
    public void notifyObserver(WorkflowApprovalResultMsg msg) {
        for (ApproveObserver observer : observers) {
            observer.response(msg);
        }
    }
}
