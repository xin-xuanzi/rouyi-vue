package com.ruoyi.business.leave.service.impl;

import com.ruoyi.business.leave.domain.LeaveDto;
import com.ruoyi.business.leave.domain.LeaveQuery;
import com.ruoyi.business.leave.repo.LeaveRepository;
import com.ruoyi.business.leave.service.ILeaveService;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.enums.ApprovalActionEnum;
import com.ruoyi.common.workflow.IWorkflowServiceApi;
import com.ruoyi.common.workflow.WorkflowStartParam;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/8 15:10
 */
@Service
@AllArgsConstructor
public class LeaveServiceImpl implements ILeaveService {
    private LeaveRepository leaveRepository;
    private IWorkflowServiceApi workflowServiceApi;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submitLeave(LeaveDto dto) {
        leaveRepository.submitLeave(dto);

        WorkflowStartParam param = new WorkflowStartParam();
        param.setBusinessKey(dto.getBusinessKey());
        param.setInitiator(String.valueOf(dto.getUserId()));
        param.setCaseInstanceId(dto.getId().toString());
        param.setProcessDefinitionId(dto.getProcessDefinitionId());
        param.setFromData(dto);

        leaveRepository.saveProcessInstanceId(dto.getId(), workflowServiceApi.startWorkflowAndSubmit(param));
    }

    @Override
    public List<LeaveDto> queryPage(LeaveQuery query) {
        return leaveRepository.queryPage(query);
    }

    @Override
    public LeaveDto queryDetail(Long id) {
        return leaveRepository.queryDetail(id);
    }

    @Override
    public void approvePostProcessing(WorkflowApprovalResultMsg resultMsg) {
        if(ApprovalActionEnum.REJECT.equals(resultMsg.getApprovalResult())) {
            leaveRepository.updateStatus(Long.parseLong(resultMsg.getBusinessId()), "99");
        }
    }
}
