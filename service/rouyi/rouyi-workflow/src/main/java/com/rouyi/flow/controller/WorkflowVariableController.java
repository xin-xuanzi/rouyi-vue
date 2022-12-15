package com.rouyi.flow.controller;

import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;
import com.rouyi.flow.service.IActExpandBusinessService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 流程变量 控制器
 *
 * @author xuanzi
 * @date 2022/11/30 17:01
 */

@RestController
@AllArgsConstructor
@RequestMapping("/workflow/variable")
public class WorkflowVariableController extends BaseController {

    private IActExpandBusinessService actExpandBusinessService;

    @GetMapping("/page")
    public TableDataInfo page(WorkflowCommonQuery query){
        startPage();
        List<ProcessVariableDto> list = actExpandBusinessService.queryVariablePage(query);

        return getDataTable(list);
    }

    @GetMapping("/methods")
    public AjaxResult methods(){
        return AjaxResult.success(actExpandBusinessService.queryInvokeMethod());
    }


    @GetMapping("/detail/{id}")
    public AjaxResult methods(@PathVariable Long id){
        return AjaxResult.success(actExpandBusinessService.processVariableDetail(id));
    }


    @GetMapping("/business/{code}")
    public AjaxResult methods(@PathVariable String code){
        return AjaxResult.success(actExpandBusinessService.queryVariableByBusiness(code));
    }


    @PostMapping("/saveOrUpdate")
    public AjaxResult saveOrUpdate(@RequestBody ProcessVariableDto dto){
        actExpandBusinessService.saveOrUpdateProcessVariable(dto);
        return AjaxResult.success();
    }

}
