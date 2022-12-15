package com.ruoyi.business.leave.service;

import com.ruoyi.business.leave.domain.LeaveDto;
import com.ruoyi.business.leave.domain.LeaveQuery;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/8 15:10
 */
public interface ILeaveService {

    /**
     * 提交流程
     * @param dto
     */
    void submitLeave(LeaveDto dto);

    List<LeaveDto> queryPage(LeaveQuery query);

    LeaveDto queryDetail(Long id);

}
