package com.rouyi.flow.controller;

import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Maps;
import com.rouyi.flow.domain.WorkflowApprovalDto;
import com.rouyi.flow.domain.WorkflowDto;
import com.rouyi.flow.domain.WorkflowQuery;
import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.domain.dto.ProcessTodoDto;
import com.rouyi.flow.service.IActExpandProcessService;
import com.rouyi.flow.service.IWorkflowService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.WorkflowApprovalResultMsg;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
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
    private RedisService redisService;
    /**
     * 查询流程详情
     *
     * @param business
     * @return
     */
    @GetMapping("/{business}")
    public AjaxResult save(@PathVariable String business) {
        return AjaxResult.success(actExpandProcessService.queryEnableByBusinessCode(business, "1"));
    }


    /**
     * 变更流程状态
     *
     * @param dto
     * @return
     */
    @PostMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody ExpandProcessDto dto) {
        actExpandProcessService.changeStatus(dto);
        return AjaxResult.success();
    }


    @GetMapping("/start")
    public String startWorkflow(@RequestParam(required = true) String processDefinitionId) throws Exception {
        WorkflowDto workflowDto = new WorkflowDto();
        workflowDto.setProcessKey("LEAVE");
        workflowDto.setProcessDefinitionId(processDefinitionId);

        JSONObject formData = new JSONObject();
        formData.put("days", "2.5");
        formData.put("userId", 1);

        Map<String, Object> params = Maps.newHashMap();
        params.put("formData", formData.toString());
        params.put("days", 5);

        workflowDto.setParams(params);
        workflowDto.setInitiator("1");
        workflowDto.setCaseInstanceId("10001");
        workflowDto.setBusinessKey("LEAVE");

        return workflowService.startWorkflow(workflowDto);
    }

    @GetMapping("/submit")
    public void submit(String processInstanceId) {
        WorkflowQuery query = new WorkflowQuery();
        query.setProcessInstanceId(processInstanceId);
        query.setBusinessKey("LEAVE");
        query.setUserId("1");
        workflowService.submit(query);
    }


    @GetMapping("/history")
    public AjaxResult history(Long expandProcessId) {
        //startPage();
        List<ExpandProcessDto> expandProcessDtos = actExpandProcessService.queryHiExpandProcess(expandProcessId);
        return AjaxResult.success(expandProcessDtos);
    }

    /**
     * 部署流程
     *
     * @param dto
     * @return
     */
    @PostMapping("/deploy")
    public AjaxResult deploy(@RequestBody ExpandProcessDto dto) {
        actExpandProcessService.deploy(dto);
        return AjaxResult.success();
    }


    /**
     * 保存流程
     *
     * @param dto
     * @return
     */
    @PostMapping("/save")
    public AjaxResult save(@RequestBody ExpandProcessDto dto) {
        actExpandProcessService.save(dto);
        return AjaxResult.success();
    }

    /**
     * 查询流程详情
     *
     * @param actExpandProcessId
     * @return
     */
    @GetMapping("/detail/{actExpandProcessId}")
    public AjaxResult save(@PathVariable Long actExpandProcessId) {
        return AjaxResult.success(actExpandProcessService.detail(actExpandProcessId));
    }


    /**
     * 查询流程详情
     *
     * @param
     * @return
     */
    @GetMapping("/todo")
    public TableDataInfo todo(WorkflowQuery query) {
        query.setUserId(getUserId().toString());
        query.setPageNum(1);
        query.setPageSize(10);

        List<ProcessTodoDto> processTodoDtos = workflowService.queryTodo(query);
        long l = workflowService.queryTodoCount(query);
        TableDataInfo tableDataInfo = new TableDataInfo(processTodoDtos, Integer.parseInt(String.valueOf(l)));
        return tableDataInfo;
    }



    /**
     * 查询流程详情
     *
     * @param query 已审批
     * @return
     */
    @GetMapping("/approved")
    public TableDataInfo approved(WorkflowQuery query) {
        query.setUserId(getUserId().toString());
        startPage();

        List<ProcessTodoDto> list = workflowService.queryApproved(query);

        return getDataTable(list);
    }


    /**
     * 查询流程代办详情
     *
     * @param
     * @return
     */
    @GetMapping("/todo/{taskId}")
    public AjaxResult todoDetail(@PathVariable String taskId) {
        ProcessTodoDto todoDto = workflowService.queryTodoDetail(taskId);
        return AjaxResult.success(todoDto);
    }

    /**
     * 查询流程代办详情
     *
     * @param
     * @return
     */
    @GetMapping("/approvalRecord/{processInstanceId}")
    public AjaxResult approvalRecord(@PathVariable String processInstanceId) {
        return AjaxResult.success(workflowService.queryApprovalRecord(processInstanceId));
    }

    /**
     * 审批代办
     *
     * @param
     * @return
     */
    @PostMapping("/approve")
    public AjaxResult approve(@RequestBody WorkflowApprovalDto workflowApprovalDto) {
        workflowApprovalDto.setUserId(getUserId().toString());
        workflowService.approve(workflowApprovalDto);

        return AjaxResult.success();
    }



    /**
     * 审批代办
     *
     * @param
     * @return
     */
    @PostMapping("/test")
    public AjaxResult test() {
        redisService.workflowSendMsg(WorkflowApprovalResultMsg.rejectMsg("123", "123"));
        return AjaxResult.success();
    }


}
