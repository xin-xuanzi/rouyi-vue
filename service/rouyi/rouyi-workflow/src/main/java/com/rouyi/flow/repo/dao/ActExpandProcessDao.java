package com.rouyi.flow.repo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rouyi.flow.repo.dao.po.ActExpandProcessPo;

import java.util.List;

/**
 *  流程扩展业务
 * @author xuanzi
 * @date 2022/11/8 11:05
 */


public interface ActExpandProcessDao extends BaseMapper<ActExpandProcessPo> {

    List<ActExpandProcessPo> queryByBusinessCode(String businessCode);
}
