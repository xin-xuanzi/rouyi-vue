package com.ruoyi.business.leave.repo;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.ruoyi.business.leave.domain.LeaveDto;
import com.ruoyi.business.leave.domain.LeaveQuery;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.core.service.ISysCommonService;
import com.ruoyi.common.enums.BusinessProcessStatus;
import com.ruoyi.common.utils.bean.BeanUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/8 16:35
 */
@Repository
@AllArgsConstructor
public class LeaveRepository {
    private ILeaveDao leaveDao;


    public void submitLeave(LeaveDto dto) {
        LeavePo po = new LeavePo();
        BeanUtils.copyBeanProp(dto, po);
        po.setLeaveType(dto.getLeaveType());
        po.setStatus(BusinessProcessStatus.APPROVAL.getCode());
        leaveDao.insert(po);
        dto.setId(po.getId());
    }

    public void updateStatus(long id, String status ) {
        LeavePo po = new LeavePo();
        po.setId(id);
        po.setStatus(status);
        leaveDao.updateById(po);
    }

    public void saveProcessInstanceId(Long leaveId, String processInstanceId) {
        LambdaUpdateWrapper<LeavePo> eq = new LambdaUpdateWrapper<LeavePo>().ge(LeavePo::getId, leaveId)
                .set(LeavePo::getProcessInstanceId, processInstanceId);
        leaveDao.update(null,eq );
    }

    public List<LeaveDto> queryPage(LeaveQuery query) {

        return leaveDao.queryList(query);
    }

    public LeaveDto queryDetail(Long id) {
        if (id == null) {
            return null;
        }

        RedisCache redisCache = SpringUtils.getBean(RedisCache.class);
        LeaveDto dto = redisCache.getCacheObject(CacheConstants.BUSINESS_LEAVE_DETAIL + id);

        if (dto == null) {
            LeavePo po = leaveDao.selectById(id);
            dto =   new LeaveDto();
            BeanUtils.copyBeanProp(po, dto);
            ISysCommonService bean = SpringUtils.getBean(ISysCommonService.class);
            SysUser sysUser = bean.getUserById(dto.getUserId());
            dto.setUserName(sysUser.getUserName());
            dto.setDeptName(sysUser.getDept().getDeptName());
            redisCache.setCacheObject(CacheConstants.BUSINESS_LEAVE_DETAIL + id, dto);
        }

        return dto;
    }
}
