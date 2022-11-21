package com.rouyi;

import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Maps;
import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.service.IWorkflowService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/15 19:22
 */
@Slf4j
public class WorkflowTest extends BaseJunit{

    @Autowired
    private IWorkflowService workflowService;

    private String PROCESS_INSTANCE_ID = "6e450431-6635-11ed-b6c2-c6bde56990c4";

    @Test
    public void startWorkflow() {
        WorkflowDto workflowDto = new WorkflowDto();
        workflowDto.setProcessKey("LEAVE");

        JSONObject formData = new JSONObject();
        formData.put("days", "2.5");
        formData.put("userId", 1);

        Map<String, Object> params = Maps.newHashMap();
        params.put("formData", formData.toString());

        workflowDto.setParams(params);
        workflowDto.setInitiator("1");
        workflowDto.setCaseInstanceId("10001");
        workflowDto.setBusinessKey("LEAVE");

        log.info("流程启动成功》》》" + workflowService.startWorkflow(workflowDto));
    }


    /**
     * submit
     */
    @Test
    public void submit() {
        WorkflowQuery query = new WorkflowQuery();
        query.setProcessInstanceId(PROCESS_INSTANCE_ID);
        query.setBusinessKey("LEAVE");
        query.setUserId("1");

        workflowService.submit(query);
    }

    /**
     * complete
     */
    @Test
    public void complete() {
        WorkflowQuery query = new WorkflowQuery();
        query.setProcessInstanceId(PROCESS_INSTANCE_ID);
        query.setBusinessKey("LEAVE");
        query.setUserId("lisi");

        workflowService.complete(query);
    }

    /**
     * approve
     */
    @Test
    public void approve() {
        WorkflowApprovalDto query = new WorkflowApprovalDto();
        query.setProcessInstance(PROCESS_INSTANCE_ID);
        query.setUserId("1");
        query.setResult("N");
        query.setComment("不同意！！");

        workflowService.approve(query);
    }

}
