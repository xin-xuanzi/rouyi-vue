package com.rouyi.flow.service;

import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;

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
    String startWorkflow(WorkflowDto workflowDto) throws Exception;

    List<ProcessTodoDto> queryTodo(WorkflowQuery query);
    ProcessTodoDto queryTodoDetail(String taskId);
    List<ApprovalRecordDto> queryApprovalRecord(String processInstanceId);
    long queryTodoCount(WorkflowQuery query);

    void submit(WorkflowQuery query);

    void complete(WorkflowQuery query);
    /**
     * 审批
     * @param dto
     * @return
     */
    String approve(WorkflowApprovalDto dto);


}
