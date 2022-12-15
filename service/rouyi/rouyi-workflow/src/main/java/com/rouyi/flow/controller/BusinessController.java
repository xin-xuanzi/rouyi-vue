package com.rouyi.flow.controller;

import com.rouyi.flow.domain.dto.ActProcessBusinessDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;
import com.rouyi.flow.service.IActExpandBusinessService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/18 15:02
 */
@RestController
@AllArgsConstructor
@RequestMapping("/workflow/business")
public class BusinessController extends BaseController {

    private IActExpandBusinessService actExpandBusinessService;

    @GetMapping("/group")
    public AjaxResult group() {
        List<ActProcessBusinessDto> actBusinessTypeDtos = actExpandBusinessService.queryActBusinessTypeWithProcess();
        return AjaxResult.success(actBusinessTypeDtos);
    }

    @GetMapping("/list")
    public AjaxResult list(WorkflowCommonQuery query) {
        List<ActProcessBusinessDto> actBusinessTypeDtos = actExpandBusinessService.queryActBusinessPage(query);
        return AjaxResult.success(actBusinessTypeDtos);
    }

    @GetMapping("/page")
    public TableDataInfo page(WorkflowCommonQuery query) {
        startPage();
        List<ActProcessBusinessDto> list = actExpandBusinessService.queryActBusinessPage(query);
        return getDataTable(list);
    }

    @GetMapping("/detail/{id}")
    public AjaxResult detail(@PathVariable Long id) {
        return AjaxResult.success(actExpandBusinessService.queryBusinessDetail(id));
    }


    @PostMapping("/saveOrUpdate")
    public AjaxResult saveOrUpdate(@RequestBody ActProcessBusinessDto dto) {
        actExpandBusinessService.saveOrUpdateBusiness(dto);
        return AjaxResult.success();
    }


    @PostMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody ActProcessBusinessDto dto) {
        actExpandBusinessService.changeStatus(dto);
        return AjaxResult.success();
    }

}
