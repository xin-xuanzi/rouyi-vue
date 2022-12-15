package com.rouyi.flow.service.impl;

import com.google.common.collect.Lists;
import com.rouyi.flow.domain.dto.ActProcessBusinessDto;
import com.rouyi.flow.domain.dto.ProcessVariableDto;
import com.rouyi.flow.domain.query.WorkflowCommonQuery;
import com.rouyi.flow.repo.repository.ActExpandBusinessRepository;
import com.rouyi.flow.repo.repository.ActExpandProcessRepository;
import com.rouyi.flow.repo.repository.ActProcessVariableRepository;
import com.rouyi.flow.service.IActExpandBusinessService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/29 17:41
 */
@Service
@AllArgsConstructor
public class ActExpandBusinessServiceImpl implements IActExpandBusinessService {

    private ActProcessVariableRepository actProcessVariableRepository;
    private ActExpandProcessRepository actExpandProcessRepository;

    private ActExpandBusinessRepository actExpandBusinessRepository;


    @Override
    public ActProcessBusinessDto queryBusinessDetail(Long id) {

        return actExpandBusinessRepository.queryDetail(id);
    }

    @Override
    public ActProcessBusinessDto queryBusinessDetail(String businessCode) {
        return actExpandBusinessRepository.queryDetailInfoByCode(businessCode);
    }

    @Override
    public void saveOrUpdateBusiness(ActProcessBusinessDto dto) {
        actExpandBusinessRepository.saveBusiness(dto);
    }

    @Override
    public void changeStatus(ActProcessBusinessDto dto) {
        actExpandBusinessRepository.changeStatus(dto);
    }

    @Override
    public List<ProcessVariableDto> queryVariablePage(WorkflowCommonQuery query) {
        return actProcessVariableRepository.queryPage(query);
    }

    @Override
    public List<ProcessVariableDto> queryVariableByBusiness(String businessCode) {
        return actProcessVariableRepository.queryVariableByBusiness(businessCode);
    }

    @Override
    public List<String> queryInvokeMethod() {
        List<String> methods = Lists.newArrayList();
        try {
            Class<?> aClass = Class.forName("com.rouyi.flow.service.IWorkflowVariableInvokeService");

            Method[] classMethods = aClass.getMethods();
            for (Method classMethod : classMethods) {
                methods.add(classMethod.getName());
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return methods;
    }

    @Override
    public ProcessVariableDto processVariableDetail(Long id) {
        return actProcessVariableRepository.queryDetail(id);
    }

    @Override
    public void saveOrUpdateProcessVariable(ProcessVariableDto variableDto) {
        actProcessVariableRepository.saveOrUpdateVariable(variableDto);
    }


    @Override
    public List<ActProcessBusinessDto> queryActBusinessPage(WorkflowCommonQuery query) {
        return actExpandBusinessRepository.queryBusiness(query);
    }

    @Override
    public List<ActProcessBusinessDto> queryActBusinessTypeWithProcess() {
        List<ActProcessBusinessDto> actBusinessTypes = queryActBusinessPage(null);
        for (ActProcessBusinessDto actBusinessType : actBusinessTypes) {
            actBusinessType.setExpandProcess(actExpandProcessRepository.queryExpandProcess(actBusinessType.getBusinessCode(), null));
        }

        return actBusinessTypes;
    }
}
