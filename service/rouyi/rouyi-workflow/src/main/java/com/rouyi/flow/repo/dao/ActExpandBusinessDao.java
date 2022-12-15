package com.rouyi.flow.repo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rouyi.flow.domain.dto.ActProcessBusinessDto;
import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;
import com.rouyi.flow.repo.dao.po.ActExpandBusinessPo;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 *  流程扩展业务
 * @author xuanzi
 * @date 2022/11/8 11:05
 */
@Component
public interface ActExpandBusinessDao extends BaseMapper<ActExpandBusinessPo> {
    List<ActProcessBusinessDto> queryBusinessType(WorkflowCommonQuery query);

    List<ProcessVariableDto> queryProcessVariable(String businessCode);
}
