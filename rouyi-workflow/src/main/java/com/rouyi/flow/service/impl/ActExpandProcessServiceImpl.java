package com.rouyi.flow.service.impl;

import com.rouyi.flow.config.parser.ExpandProcessParser;
import com.rouyi.flow.domain.ExpandProcess;
import com.rouyi.flow.domain.dto.ActBusinessTypeDto;
import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.repo.repository.ActExpandProcessRepository;
import com.rouyi.flow.service.IActExpandProcessService;
import lombok.AllArgsConstructor;
import org.camunda.bpm.engine.RepositoryService;
import org.camunda.bpm.engine.repository.Deployment;
import org.camunda.bpm.engine.repository.ProcessDefinition;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/17 14:29
 */
@Service
@AllArgsConstructor
public class ActExpandProcessServiceImpl implements IActExpandProcessService {

    private RepositoryService repositoryService;

    private ActExpandProcessRepository actExpandProcessRepository;

    @Override
    public void deploy(ExpandProcessDto dto) {
        ExpandProcess expandProcess = new ExpandProcess();
        BeanUtils.copyProperties(dto, expandProcess);

        ExpandProcessParser expandProcessParser = new ExpandProcessParser(expandProcess);
        BpmnModelInstance bpmnModelInstance = expandProcessParser.parse();

        //部署流程
        Deployment deploy = repositoryService.createDeployment().name("")
                .addModelInstance(expandProcess.getName() + ".bpmn", bpmnModelInstance)
                .deploy();
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deploy.getId()).singleResult();

        //保存流程配置
        expandProcess.setProcessDefinition(processDefinition);

        actExpandProcessRepository.saveExpandProcess(expandProcess);
    }

    @Override
    public void save(ExpandProcessDto dto) {
        ExpandProcess expandProcess = new ExpandProcess();
        BeanUtils.copyProperties(dto, expandProcess);
        expandProcess.setId(dto.getExpandProcessId());
        actExpandProcessRepository.saveExpandProcess(expandProcess);
    }

    @Override
    public  ExpandProcessDto detail(Long actExpandProcessId) {
        return actExpandProcessRepository.queryDetail(actExpandProcessId);
    }

    @Override
    public List<ActBusinessTypeDto> queryActBusinessType(Integer status) {

        return actExpandProcessRepository.queryBusinessType(status);
    }

    @Override
    public List<ActBusinessTypeDto> queryActBusinessTypeWithProcess() {
        List<ActBusinessTypeDto> actBusinessTypes = queryActBusinessType(null);
        for (ActBusinessTypeDto actBusinessType : actBusinessTypes) {
            actBusinessType.setExpandProcess(actExpandProcessRepository.queryExpandProcess(actBusinessType.getCode()));
        }

        return actBusinessTypes;
    }
}
