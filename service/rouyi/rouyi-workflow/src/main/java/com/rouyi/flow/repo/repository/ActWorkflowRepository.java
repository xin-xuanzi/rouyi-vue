package com.rouyi.flow.repo.repository;

import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ApprovalRecordNodeDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import com.rouyi.flow.repo.dao.IActWorkflowDao;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.service.ISysCommonService;
import lombok.AllArgsConstructor;
import org.camunda.bpm.engine.ActivityTypes;
import org.springframework.stereotype.Repository;

import java.util.LinkedList;
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

    private final IActWorkflowDao actWorkflowDao;

    private final ISysCommonService sysCommonService;
    public void saveApprovalResult(String approvalResult, String taskId) {
        actWorkflowDao.updateApprovalResult(approvalResult, taskId);
    }


    /**
     * 查询审批记录
     * 1、先查询 ACT_HI_ACTINST 数据中是 父级是流程实例ID的，其中包括了 用户节点和单节点，
     *
     * 2、再根据ACT_HI_ACTINST ID 查找对用的审批人，和审批意见
     *
     * @param processInstanceId
     * @return
     */
    public List<ApprovalRecordNodeDto> queryApprovalTodo(String processInstanceId) {
        LinkedList<ApprovalRecordNodeDto> nodes = actWorkflowDao.queryActNodeByProcInsId(processInstanceId);
        SysUser sysUser = null;
        for (ApprovalRecordNodeDto node : nodes) {
            if (ActivityTypes.MULTI_INSTANCE_BODY.equals(node.getActType())) {
                List<ApprovalRecordNodeDto.ApprovalRecordItemDto> itemDtos = actWorkflowDao.queryApprovalNodeItem(processInstanceId, node.getActHiInstId());
                if (!itemDtos.isEmpty()) {
                    ApprovalRecordNodeDto.ApprovalRecordItemDto first = itemDtos.get(0);
                    node.setActName(first.getActName());
                }

                for (ApprovalRecordNodeDto.ApprovalRecordItemDto itemDto : itemDtos) {
                    sysUser = sysCommonService.getUserById(itemDto.getAssignee());
                    itemDto.setUserName(sysUser.getUserName());
                }

                node.setItemDtoList(itemDtos);
            } else {
                sysUser = sysCommonService.getUserById(node.getAssignee());
                node.setUserName(sysUser.getUserName());
            }
        }

        return nodes;
    }


    /**
     * 查询已审批数据
     *
     * @param query
     * @return
     */
    public List<ProcessTodoDto> queryApproved(WorkflowQuery query) {
        return actWorkflowDao.queryApproved(query);
    }

    /**
     * 查询当前流程实例审批人
     *
     * @param procInstId
     * @return
     */
    public List<String> queryCurrentApprover(String procInstId) {
        return actWorkflowDao.queryCurrentApprover(procInstId);
    }
}
