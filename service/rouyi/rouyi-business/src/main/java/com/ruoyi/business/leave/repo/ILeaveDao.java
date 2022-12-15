package com.ruoyi.business.leave.repo;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.business.leave.domain.LeaveDto;
import com.ruoyi.business.leave.domain.LeaveQuery;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/8 15:11
 */
public interface ILeaveDao extends BaseMapper<LeavePo> {

    List<LeaveDto> queryList(LeaveQuery query);
}
