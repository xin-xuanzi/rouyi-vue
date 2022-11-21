package com.rouyi.flow.service;

import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.WorkflowDto;

import java.util.List;

/**
 * 工作流服务
 *
 * @author xuanzi
 * @date 2022/11/15 18:45
 */
public interface IWorkflowService {
    /**
     * 开启流程
     * @param workflowDto
     * @return
     */
    String startWorkflow(WorkflowDto workflowDto);

    List<String> queryTodo(WorkflowQuery query);

    void submit(WorkflowQuery query);

    void complete(WorkflowQuery query);
    /**
     * 审批
     * @param dto
     * @return
     */
    String approve(WorkflowApprovalDto dto);
}
