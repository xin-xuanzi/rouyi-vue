package com.ruoyi.business;

import com.ruoyi.business.leave.service.ILeaveService;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.core.service.IBusinessService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author xuanzi
 * @date 2023/1/4 16:02
 */
@Slf4j
@Service
@AllArgsConstructor
public class BusinessService implements IBusinessService {
    private ILeaveService leaveService;
    @Override
    public void execWorkflowEvent(WorkflowApprovalResultMsg msg) {

        leaveService.approvePostProcessing(msg);
        log.info("处理行流程节点审批事件" + msg);

    }
}
