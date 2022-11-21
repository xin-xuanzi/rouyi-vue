package com.rouyi.flow.service;

import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.domain.dto.ActBusinessTypeDto;

import java.util.List;

/**
 * 流程扩展 service
 *
 * @author xuanzi
 * @date 2022/11/8 14:30
 */
public interface IActExpandProcessService {

    /**
     * 部署流程
     * @param dto
     */
    void deploy(ExpandProcessDto dto);

    /**
     * 保存
     * @param dto
     */
    void save(ExpandProcessDto dto);

    /**
     * 查询流程详情
     * @param actExpandProcessId
     * @return
     */
    ExpandProcessDto detail(Long actExpandProcessId);

    /**
     * 查询业务code
     * @return
     */
    List<ActBusinessTypeDto> queryActBusinessType(Integer status);


    /**
     * 查询业务code 和对应的流程
     * @return
     */
    List<ActBusinessTypeDto> queryActBusinessTypeWithProcess();
}
