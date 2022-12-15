package com.ruoyi.business.leave;

import com.ruoyi.business.leave.domain.LeaveDto;
import com.ruoyi.business.leave.domain.LeaveQuery;
import com.ruoyi.business.leave.service.ILeaveService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/8 15:01
 */
@RestController
@AllArgsConstructor
@RequestMapping("/leave")
public class LeaveController extends BaseController {
    private ILeaveService leaveService;

    @PostMapping("/submit")
    public AjaxResult submit(@RequestBody LeaveDto dto) {
        dto.setUserId(getLoginUser().getUserId());
        leaveService.submitLeave(dto);
        return AjaxResult.success();
    }

    @GetMapping("/page")
    public TableDataInfo page(LeaveQuery query) {
        startPage();
        List<LeaveDto> list = leaveService.queryPage(query);

        return getDataTable(list);
    }

    @GetMapping("/detail/{id}")
    public AjaxResult submit(@PathVariable Long id) {

        return AjaxResult.success(leaveService.queryDetail(id));
    }
}
