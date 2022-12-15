package com.ruoyi.common.core.service;

import com.ruoyi.common.core.domain.entity.SysUser;

/**
 * @author xuanzi
 * @date 2022/12/9 15:52
 */
public interface ISysCommonService {
    /**
     * 根据ID获取用户信息
     * @return
     */
    SysUser getUserById(Long userId);
}
