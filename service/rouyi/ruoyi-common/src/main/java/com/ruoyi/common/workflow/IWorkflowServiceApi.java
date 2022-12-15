package com.ruoyi.common.workflow;

/**
 * 工作流接口
 *
 * @author xuanzi
 * @date 2022/12/8 16:03
 */
public interface IWorkflowServiceApi {
    public String startWorkflowAndSubmit(WorkflowStartParam param);
}
