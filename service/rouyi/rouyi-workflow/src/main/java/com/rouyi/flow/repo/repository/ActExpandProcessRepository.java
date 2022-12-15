package com.rouyi.flow.repo.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.google.common.collect.Lists;
import com.rouyi.flow.domain.ExpandProcess;
import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.repo.dao.ActExpandBusinessRelationDao;
import com.rouyi.flow.repo.dao.ActExpandProcessDao;
import com.rouyi.flow.repo.dao.po.ActExpandBusinessRelationPo;
import com.rouyi.flow.repo.dao.po.ActExpandProcessPo;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/8 14:28
 */
@Repository
@AllArgsConstructor
public class ActExpandProcessRepository {

    private ActExpandProcessDao actExpandProcessDao;
    private ActExpandBusinessRelationDao actExpandBusinessRelationDao;

    public void changeStatus(ExpandProcess expandProcess) {
        LambdaUpdateWrapper<ActExpandProcessPo> lambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        lambdaUpdateWrapper.eq(ActExpandProcessPo::getId, expandProcess.getId())
                .set(ActExpandProcessPo::getStatus, expandProcess.getStatus());

        actExpandProcessDao.update(null, lambdaUpdateWrapper);
    }

    public void saveExpandProcess(ExpandProcess expandProcess) {
        ActExpandProcessPo po = new ActExpandProcessPo();

        BeanUtils.copyProperties(expandProcess, po);
        if (expandProcess.getProcessDefinition() != null) {
            po.setActProcessId(expandProcess.getProcessDefinition().getId());
            po.setActDeploymentId(expandProcess.getProcessDefinition().getDeploymentId());
            po.setVersion(expandProcess.getProcessDefinition().getVersion());
            po.setDeployTime(new Date());
        }

        if (po.getId() != null) {
            actExpandProcessDao.updateById(po);
        } else {
            actExpandProcessDao.insert(po);
        }

        //保存 businessKey 关联
        actExpandBusinessRelationDao.delete(new LambdaUpdateWrapper<ActExpandBusinessRelationPo>()
                .eq(ActExpandBusinessRelationPo::getExpandProcessId,po.getId()));
        ActExpandBusinessRelationPo relationPo = new ActExpandBusinessRelationPo();
        relationPo.setExpandProcessId(po.getId());
        relationPo.setBusinessCode(expandProcess.getBusinessCode());
        actExpandBusinessRelationDao.insert(relationPo);
    }

    public ExpandProcessDto queryDetail(Long actExpandProcessId) {
        ExpandProcessDto expandProcessDto = new ExpandProcessDto();
        ActExpandProcessPo actExpandProcessPo = actExpandProcessDao.selectById(actExpandProcessId);
        BeanUtils.copyProperties(actExpandProcessPo, expandProcessDto);
        ActExpandBusinessRelationPo actExpandBusinessRelationPo = actExpandBusinessRelationDao.selectOne(new LambdaQueryWrapper<ActExpandBusinessRelationPo>()
                .eq(ActExpandBusinessRelationPo::getExpandProcessId, actExpandProcessPo.getId()));

        expandProcessDto.setExpandProcessId(actExpandProcessPo.getId());
        expandProcessDto.setBusinessCode(actExpandBusinessRelationPo.getBusinessCode());
        return expandProcessDto;
    }

    public ExpandProcessDto queryDetailDeployment(String actProcessId) {
        ExpandProcessDto actExpandProcessPo = actExpandProcessDao.selectOneByActProcessId(actProcessId);

        return actExpandProcessPo;
    }



    public List<ExpandProcessDto> queryExpandProcess(String businessCode, String status) {
        List<ActExpandProcessPo> actExpandProcessPos = actExpandProcessDao.queryByBusinessCode(businessCode, status);
        List<ExpandProcessDto> list = Lists.newArrayListWithCapacity(actExpandProcessPos.size());
        ExpandProcessDto expandProcess = null ;
        for (ActExpandProcessPo actExpandProcessPo : actExpandProcessPos) {
            expandProcess = new ExpandProcessDto();
            BeanUtils.copyProperties(actExpandProcessPo, expandProcess);
            expandProcess.setExpandProcessId(actExpandProcessPo.getId());
            list.add(expandProcess);
        }

        return list;
    }
}
