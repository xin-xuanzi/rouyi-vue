package com.ruoyi.web.controller.system;

/**
 * @author xuanzi
 * @date 2022/11/9 15:05
 */

import com.ruoyi.common.core.domain.entity.SysUser;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/workflow/user")
public class TestRController {
    @GetMapping("/list")
    public String list(SysUser user)
    {

        return "SSSSSSSSSSSS";
    }
}
