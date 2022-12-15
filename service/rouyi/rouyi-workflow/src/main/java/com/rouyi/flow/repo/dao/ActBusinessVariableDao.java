package com.rouyi.flow.repo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rouyi.flow.repo.dao.po.ActBusinessVariablePo;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/29 17:59
 */
public interface ActBusinessVariableDao extends BaseMapper<ActBusinessVariablePo> {
    /**
     * 批量插入
     * @param entityList
     * @return
     */
    Integer insertBatchSomeColumn(List<ActBusinessVariablePo> entityList);
}
