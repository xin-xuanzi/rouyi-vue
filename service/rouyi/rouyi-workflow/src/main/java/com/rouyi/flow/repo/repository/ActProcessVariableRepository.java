package com.rouyi.flow.repo.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.google.common.collect.Lists;
import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;
import com.rouyi.flow.repo.dao.ActExpandBusinessDao;
import com.rouyi.flow.repo.dao.ActExpandProcessVariableDao;
import com.rouyi.flow.repo.dao.po.ActExpandProcessVariablePo;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.bean.BeanUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/30 14:16
 */
@Repository
@AllArgsConstructor
public class ActProcessVariableRepository {
    private ActExpandProcessVariableDao actExpandProcessVariableDao;

    private ActExpandBusinessDao actExpandBusinessDao;

    public List<ProcessVariableDto> queryPage(WorkflowCommonQuery query) {
        LambdaQueryWrapper<ActExpandProcessVariablePo> wrapper = new LambdaQueryWrapper<>();
        if (!StringUtils.isEmpty(query.getCondition())) {
            wrapper.like(ActExpandProcessVariablePo::getTitle, query.getCondition()).or()
                    .like(ActExpandProcessVariablePo::getDescription, query.getCondition());
        }

        List<ProcessVariableDto> actExpandProcessVariablePos = Lists.newArrayList();
        List<ActExpandProcessVariablePo> poList = actExpandProcessVariableDao.selectList(wrapper);
        poList.forEach(e -> {
            ProcessVariableDto dto = new ProcessVariableDto();
            BeanUtils.copyProperties(e, dto);
            actExpandProcessVariablePos.add(dto);
        });

        return actExpandProcessVariablePos;
    }

    public List<ProcessVariableDto> queryVariableByBusiness(String businessCode) {

        return actExpandBusinessDao.queryProcessVariable(businessCode);
    }

    /**
     * 查询详情
     * @param id
     * @return
     */
    public ProcessVariableDto queryDetail(Long id) {
        ActExpandProcessVariablePo po = SpringUtils.getBean(RedisCache.class).getCacheObject(CacheConstants.PROCESS_VARIABLE + id);
        if (po == null) {
            po = actExpandProcessVariableDao.selectById(id);
            SpringUtils.getBean(RedisCache.class).setCacheObject(CacheConstants.PROCESS_VARIABLE + id, po);
        }

        ProcessVariableDto dto = new ProcessVariableDto();
        if (po != null) {
            BeanUtils.copyProperties(po, dto);
        }

        return dto;
    }

    /**
     * 保存流程变量
     * @param processVariableDto
     */
    public void saveOrUpdateVariable(ProcessVariableDto processVariableDto) {
        ActExpandProcessVariablePo actExpandProcessVariablePo = new ActExpandProcessVariablePo();

        BeanUtils.copyProperties(processVariableDto, actExpandProcessVariablePo);
        if (actExpandProcessVariablePo.getId() == null) {
            actExpandProcessVariableDao.insert(actExpandProcessVariablePo);
        } else {
            SpringUtils.getBean(RedisCache.class).deleteObject(CacheConstants.PROCESS_VARIABLE + actExpandProcessVariablePo.getId());
            actExpandProcessVariableDao.updateById(actExpandProcessVariablePo);
        }
    }
}
