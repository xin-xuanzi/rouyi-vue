package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.service.ISysCommonService;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author xuanzi
 * @date 2022/12/9 15:55
 */
@Service
public class SysCommonService implements ISysCommonService {

    @Autowired
    private ISysUserService userService;
    @Override
    public SysUser getUserById(Long userId) {
        return userService.selectUserById(userId);
    }
}
