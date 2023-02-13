package com.rouyi.flow.service;

import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordNodeDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import com.ruoyi.common.core.domain.entity.SysUser;

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

    /**
     * 查询已审批
     * @param query
     * @return
     */
    List<ProcessTodoDto> queryApproved(WorkflowQuery query);
    ProcessTodoDto queryTodoDetail(String taskId);

    /**
     * 审批记录
     * @param processInstanceId
     * @return
     */
    List<ApprovalRecordNodeDto> queryApprovalRecord(String processInstanceId);
    long queryTodoCount(WorkflowQuery query);

    void submit(WorkflowQuery query);

    void complete(WorkflowQuery query);
    /**
     * 审批
     * @param dto
     * @return
     */
    String approve(WorkflowApprovalDto dto);

    /**
     * 查询 当前流程实例的审批人
     * @param procIstId
     * @return
     */
    List<SysUser> queryCurrentApprover(String procIstId);
}
