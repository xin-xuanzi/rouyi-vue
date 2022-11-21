package com.rouyi.flow.controller;

import com.rouyi.flow.domain.dto.ActBusinessTypeDto;
import com.rouyi.flow.service.IActExpandProcessService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/18 15:02
 */
@RestController
@AllArgsConstructor
@RequestMapping("/workflow/business")
public class BusinessController extends BaseController {

    private IActExpandProcessService actExpandProcessService;

    @GetMapping("/group")
    public AjaxResult group(){
        List<ActBusinessTypeDto> actBusinessTypeDtos = actExpandProcessService.queryActBusinessTypeWithProcess();
        return AjaxResult.success(actBusinessTypeDtos);
    }

    @GetMapping("/list")
    public AjaxResult list(Integer status){
        List<ActBusinessTypeDto> actBusinessTypeDtos = actExpandProcessService.queryActBusinessType(status);
        return AjaxResult.success(actBusinessTypeDtos);
    }

}
