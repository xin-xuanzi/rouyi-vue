package com.rouyi.flow.repo.dao;

import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordNodeDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import org.apache.ibatis.annotations.Param;

import java.util.LinkedList;
import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/13 15:11
 */
public interface IActWorkflowDao {

    /**
     * Task 保存审批结果
     * @param approvalResult
     * @param taskId
     */
    void updateApprovalResult(@Param("approvalResult") String approvalResult,
                              @Param("taskId") String taskId);

    /**
     * 查询流程 每个节点的审批明细记录
     * @param processInstanceId
     * @return
     */
    List<ApprovalRecordNodeDto.ApprovalRecordItemDto> queryApprovalNodeItem(@Param("processInstanceId") String processInstanceId,
                                                                        @Param("actHiInstId") String actHiInstId);

    /**
     * 查询流程实例中执行ID
     * @param processInstanceId
     * @return
     */
    LinkedList<ApprovalRecordNodeDto> queryActNodeByProcInsId(String processInstanceId);

    /**
     * 查询 已审批数据
     * @param query
     * @return
     */
    List<ProcessTodoDto> queryApproved(WorkflowQuery query);

    /**
     * 查询流程实例当前的 审批人
     * @param procInstId
     * @return
     */
    List<String> queryCurrentApprover(String procInstId);
}
