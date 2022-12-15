package com.rouyi.flow.repo.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.rouyi.flow.domain.dto.ActProcessBusinessDto;
import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;
import com.rouyi.flow.repo.dao.ActBusinessVariableDao;
import com.rouyi.flow.repo.dao.ActExpandBusinessDao;
import com.rouyi.flow.repo.dao.po.ActBusinessVariablePo;
import com.rouyi.flow.repo.dao.po.ActExpandBusinessPo;
import com.ruoyi.common.utils.bean.BeanUtils;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/29 17:43
 */

@Repository
@AllArgsConstructor
public class ActExpandBusinessRepository {

    private ActExpandBusinessDao actExpandBusinessDao;
    private ActBusinessVariableDao actBusinessVariableDao;


    public void saveBusiness(ActProcessBusinessDto businessDto){
        ActExpandBusinessPo expandBusinessPo = new ActExpandBusinessPo();
        BeanUtils.copyBeanProp(businessDto, expandBusinessPo);


        if (expandBusinessPo.getId() == null) {
            actExpandBusinessDao.insert(expandBusinessPo);
        } else {
            actExpandBusinessDao.updateById(expandBusinessPo);
        }

        //保存流程变量
        actBusinessVariableDao.delete(new LambdaQueryWrapper<ActBusinessVariablePo>()
                .eq(ActBusinessVariablePo::getBusinessCode, businessDto.getBusinessCode()));

        ActBusinessVariablePo variablePo;
        for (ProcessVariableDto variable : businessDto.getVariables()) {
            variablePo = new ActBusinessVariablePo();
            variablePo.setVariableId(variable.getId());
            variablePo.setBusinessCode(expandBusinessPo.getBusinessCode());

            actBusinessVariableDao.insert(variablePo);
        }
    }

    public List<ActProcessBusinessDto> queryBusiness(WorkflowCommonQuery query) {
        List<ActProcessBusinessDto> actProcessBusinessDtos = actExpandBusinessDao.queryBusinessType(query);
        actProcessBusinessDtos.forEach(e -> {
            e.setVariables(actExpandBusinessDao.queryProcessVariable(e.getBusinessCode()));
        });

        return actProcessBusinessDtos;
    }

    public ActProcessBusinessDto queryDetail(Long id) {
        ActExpandBusinessPo expandBusinessPo = actExpandBusinessDao.selectById(id);
        ActProcessBusinessDto dto = new ActProcessBusinessDto();
        BeanUtils.copyProperties(expandBusinessPo, dto);

        dto.setVariables(actExpandBusinessDao.queryProcessVariable(expandBusinessPo.getBusinessCode()));
        return dto;
    }

    public ActProcessBusinessDto queryDetailInfoByCode(String businessCode) {
        ActExpandBusinessPo expandBusinessPo = actExpandBusinessDao.selectOne(new LambdaQueryWrapper<ActExpandBusinessPo>()
                .eq(ActExpandBusinessPo::getBusinessCode, businessCode));
        ActProcessBusinessDto dto = new ActProcessBusinessDto();
        BeanUtils.copyProperties(expandBusinessPo, dto);
        return dto;
    }

    public void changeStatus(ActProcessBusinessDto businessDto) {
        ActExpandBusinessPo expandBusinessPo = new ActExpandBusinessPo();
        expandBusinessPo.setId(businessDto.getId());
        expandBusinessPo.setStatus(businessDto.getStatus());
        actExpandBusinessDao.updateById(expandBusinessPo);
    }
}
