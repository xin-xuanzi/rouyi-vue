package com.rouyi.flow.service;

import com.rouyi.flow.domain.dto.ExpandProcessDto;

import java.util.List;
import java.util.Map;

/**
 * 流程扩展 service
 *
 * @author xuanzi
 * @date 2022/11/8 14:30
 */
public interface IActExpandProcessService {

    /**
     * 变更流程状态
     * @param workflowDto
     */
    void changeStatus(ExpandProcessDto dto);


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

    List<ExpandProcessDto> queryEnableByBusinessCode(String business, String status);

    /**
     * 查询流程历史信息
     * @param expandProcessId
     * @return
     */
    List<ExpandProcessDto> queryHiExpandProcess(Long expandProcessId);

    /**
     * 更新流程定义查询扩展基本信息
     * @param actProcessId
     * @return
     */
    ExpandProcessDto detailByProcessDefinition(String actProcessId);

    List<Map<String,Object>> approvel(String processInstanceId);

}
