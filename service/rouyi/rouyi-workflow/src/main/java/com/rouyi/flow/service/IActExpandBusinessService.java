package com.rouyi.flow.service;

import com.rouyi.flow.domain.dto.ActProcessBusinessDto;
import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/29 17:40
 */
public interface IActExpandBusinessService {


    /**
     * 查询流程业务代码
     * @param query
     * @return
     */
    ActProcessBusinessDto queryBusinessDetail(Long id);

    ActProcessBusinessDto queryBusinessDetail(String businessCode);
    void saveOrUpdateBusiness(ActProcessBusinessDto dto);

    /**
     * 修改状态
     * @param dto
     */
    void changeStatus(ActProcessBusinessDto dto);


    /**
     * 查询流程变量
     * @param query
     * @return
     */
    List<ProcessVariableDto> queryVariablePage(WorkflowCommonQuery query);

    List<ProcessVariableDto> queryVariableByBusiness(String businessCode);

    /**
     * com.rouyi.flow.service.IWorkflowVariableService 内的方法
     * 可调用执行的方法
     * @return
     */
    List<String> queryInvokeMethod();

    /**
     * 查询详情
     * @param id
     * @return
     */
    ProcessVariableDto processVariableDetail(Long id);

    /**
     * 保存流程变量
     * @param variableDto
     */
    void saveOrUpdateProcessVariable(ProcessVariableDto variableDto);

    /**
     * 查询业务code
     * @return
     */
    List<ActProcessBusinessDto> queryActBusinessPage(WorkflowCommonQuery query);


    /**
     * 查询业务code 和对应的流程
     * @return
     */
    List<ActProcessBusinessDto> queryActBusinessTypeWithProcess();
}
