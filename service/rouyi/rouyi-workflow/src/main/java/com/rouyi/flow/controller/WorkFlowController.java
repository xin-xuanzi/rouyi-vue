package com.rouyi.flow.controller;

import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Maps;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.service.IActExpandProcessService;
import com.rouyi.flow.service.IWorkflowService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 工作流controller
 *
 * @author xuanzi
 * @date 2022/11/8 10:25
 */
@Slf4j
@RestController
@RequestMapping("/workflow")
@AllArgsConstructor
public class WorkFlowController extends BaseController {


    private IWorkflowService workflowService;

    private IActExpandProcessService actExpandProcessService;


    @GetMapping("/start")
    public String startWorkflow() {
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

        return workflowService.startWorkflow(workflowDto);
    }

    @GetMapping("/submit")
    public void submit(String processInstanceId){
        WorkflowQuery query = new WorkflowQuery();
        query.setProcessInstanceId(processInstanceId);
        query.setBusinessKey("LEAVE");
        query.setUserId("1");
        workflowService.submit(query);
    }

    /**
     * 部署流程
     * @param dto
     * @return
     */
    @PostMapping("/deploy")
    public AjaxResult deploy(@RequestBody ExpandProcessDto dto){
        actExpandProcessService.deploy(dto);
        return AjaxResult.success();
    }


    /**
     * 保存流程
     * @param dto
     * @return
     */
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ExpandProcessDto dto){
        actExpandProcessService.save(dto);
        return AjaxResult.success();
    }

    /**
     * 查询流程详情
     * @param dto
     * @return
     */
    @GetMapping("/detail/{actExpandProcessId}")
    public AjaxResult save(@PathVariable Long actExpandProcessId){
        return AjaxResult.success(actExpandProcessService.detail(actExpandProcessId));
    }
}
