package com.rouyi.flow.repo.repository;

import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import com.rouyi.flow.repo.dao.IActWorkflowDao;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 工作流 repository
 *
 * @author xuanzi
 * @date 2022/12/13 15:02
 */
@Repository
@AllArgsConstructor
public class ActWorkflowRepository {

    private IActWorkflowDao actWorkflowDao;
    public void saveApprovalResultComment(String approvalResult, String commentId) {
        actWorkflowDao.updateComment(approvalResult, commentId);
    }


    /**
     * 查询审批记录
     * @param processInstanceId
     * @return
     */
    public List<ApprovalRecordDto> queryApprovalTodo(String processInstanceId) {
       return actWorkflowDao.queryApprovalTodo(processInstanceId);
    }


    /**
     * 查询已审批数据
     * @param processInstanceId
     * @return
     */
    public List<ProcessTodoDto> queryApproved(WorkflowQuery query) {
        return actWorkflowDao.queryApproved(query);
    }
}
