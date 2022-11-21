package com.rouyi.flow.config.listener;

import com.alibaba.fastjson2.JSONObject;
import com.rouyi.flow.config.WorkflowConstant;
import com.rouyi.flow.domain.valobj.ProcessGroupProps;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.springframework.stereotype.Service;

/**
 * 用户节点 监听器 listener
 * @author xuanzi
 * @date 2022/11/9 10:39
 */
@Slf4j
@Service("approvalNodePreProcessListener")
public class ApprovalNodeListener {
    public void preExecution(DelegateExecution execution) {
        log.error("用户节点前置执行！！！");
    }

    public void start(DelegateExecution execution) {
        log.info("--->>>>" + execution.getVariable("collects"));
        log.error("用户节点监听还是");
    }

    /**
     * 审批节点 前置 intermediateThrowEvent end 事件，用于设置下一节点的审批人
     * @param execution
     */
    public void preProcessEndListener(DelegateExecution execution) {
        String currentActivityId = execution.getCurrentActivityId();

        //解析下个节点的审批配置
        Object variable = execution.getVariable(WorkflowConstant.APPROVAL_NODE_PROPS);
        if (variable != null) {
            JSONObject jsonObject = JSONObject.parseObject(variable.toString());
            String nextApprovalNodeId = currentActivityId.split(WorkflowConstant.APPROVAL_PRE_INTERMEDIATE_THROW_EVENT)[1];
            //获取节点配置参数
            ProcessGroupProps props = jsonObject.getObject(nextApprovalNodeId, ProcessGroupProps.class);

            execution.setVariable("approver", "1");
        }
        log.error("用户节点监听还是");
    }

}
