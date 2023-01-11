package com.rouyi.flow.repo.dao;

import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/13 15:11
 */
public interface IActWorkflowDao {

    void updateComment(@Param("approvalResult") String approvalResult, @Param("commentId") String commentId);

    /**
     * 查询流程审批日志
     * @param processInstanceId
     * @return
     */
    List<ApprovalRecordDto> queryApprovalTodo(String processInstanceId);

    /**
     * 查询 已审批数据
     * @param query
     * @return
     */
    List<ProcessTodoDto> queryApproved(WorkflowQuery query);
}
