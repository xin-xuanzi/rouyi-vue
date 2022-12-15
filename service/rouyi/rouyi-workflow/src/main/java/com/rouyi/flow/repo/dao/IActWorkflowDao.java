package com.rouyi.flow.repo.dao;

import com.rouyi.flow.domain.dto.ApprovalRecordDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/13 15:11
 */
public interface IActWorkflowDao {

    void updateComment(@Param("approvalResult") String approvalResult, @Param("commentId") String commentId);

    List<ApprovalRecordDto> queryApprovalTodo(String processInstanceId);
}
