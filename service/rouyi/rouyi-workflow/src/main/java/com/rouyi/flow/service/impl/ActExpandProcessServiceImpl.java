package com.rouyi.flow.service.impl;

import com.rouyi.flow.config.parser.ExpandProcessParser;
import com.rouyi.flow.domain.ExpandProcess;
import com.rouyi.flow.domain.dto.ExpandProcessDto;
import com.rouyi.flow.repo.repository.ActExpandProcessRepository;
import com.rouyi.flow.service.IActExpandProcessService;
import com.ruoyi.common.enums.WorkflowStatus;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.camunda.bpm.engine.HistoryService;
import org.camunda.bpm.engine.RepositoryService;
import org.camunda.bpm.engine.TaskService;
import org.camunda.bpm.engine.history.HistoricActivityInstance;
import org.camunda.bpm.engine.repository.Deployment;
import org.camunda.bpm.engine.repository.ProcessDefinition;
import org.camunda.bpm.engine.task.Comment;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author xuanzi
 * @date 2022/11/17 14:29
 */
@Service
@AllArgsConstructor
public class ActExpandProcessServiceImpl  implements IActExpandProcessService {

    private RepositoryService repositoryService;

    private TaskService taskService;

    private HistoryService historyService;


    private ActExpandProcessRepository actExpandProcessRepository;



    @Override
    public void changeStatus(ExpandProcessDto dto) {
        ExpandProcess expandProcess = new ExpandProcess();
        expandProcess.setId(dto.getExpandProcessId());
        expandProcess.setStatus(dto.getStatus());
        actExpandProcessRepository.changeStatus(expandProcess);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deploy(ExpandProcessDto dto) {
        ExpandProcess expandProcess = new ExpandProcess();

        //部署流程，为了保存历史的流程信息，先将原来的设置删除，
        if (dto.getExpandProcessId() != null) {
            expandProcess.setId(dto.getExpandProcessId());
            expandProcess.setStatus(WorkflowStatus.DELETED.getCode());
            actExpandProcessRepository.changeStatus(expandProcess);
        }

        BeanUtils.copyProperties(dto, expandProcess);
        expandProcess.setStatus(WorkflowStatus.DEPLOY.getCode());
        ExpandProcessParser expandProcessParser = new ExpandProcessParser(expandProcess);
        BpmnModelInstance bpmnModelInstance = expandProcessParser.parse();

        //部署流程
        Deployment deploy = repositoryService.createDeployment().name("")
                .addModelInstance(expandProcess.getName() + ".bpmn", bpmnModelInstance)
                .deploy();
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deploy.getId()).singleResult();

        //保存流程配置
        expandProcess.setProcessDefinition(processDefinition);

        //保存历史流程信息
        actExpandProcessRepository.saveHiExpandProcess(expandProcess);
        actExpandProcessRepository.saveExpandProcess(expandProcess);
    }

    @Override
    public List<ExpandProcessDto> queryEnableByBusinessCode(String business, String status) {
        return actExpandProcessRepository.queryExpandProcess(business, status);
    }

    @Override
    public List<ExpandProcessDto> queryHiExpandProcess(Long expandProcessId) {
        List<ExpandProcessDto> expandProcessDtos = actExpandProcessRepository.queryHiExpandProcess(expandProcessId);
        return expandProcessDtos;
    }

    @Override
    public void save(ExpandProcessDto dto) {
        ExpandProcess expandProcess = new ExpandProcess();
        BeanUtils.copyProperties(dto, expandProcess);
        expandProcess.setId(dto.getExpandProcessId());
        expandProcess.setStatus(WorkflowStatus.DRAFT.getCode());
        actExpandProcessRepository.saveExpandProcess(expandProcess);
    }

    @Override
    public  ExpandProcessDto detail(Long actExpandProcessId) {
        return actExpandProcessRepository.queryDetail(actExpandProcessId);
    }

    @Override
    public ExpandProcessDto detailByProcessDefinition(String actProcessId) {
        return actExpandProcessRepository.queryDetailDeployment(actProcessId);
    }

    @Override
    public List<Map<String, Object>> approvel(String processInstanceId) {

        List<HistoricActivityInstance> list = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .orderByHistoricActivityInstanceStartTime()
                .asc().list();


        List<Map<String,Object>> result=new ArrayList<>(list.size());

        for (HistoricActivityInstance historicActivityInstance : list) {
            Map<String,Object> map=new HashMap<>(5);
            String taskId = historicActivityInstance.getTaskId();
            List<Comment> taskComments = taskService.getTaskComments(taskId);
            map.put("activityName",historicActivityInstance.getActivityName());
            map.put("activityType",matching(historicActivityInstance.getActivityType()));
            map.put("assignee",historicActivityInstance.getAssignee()==null?"无":historicActivityInstance.getAssignee());
            map.put("startTime", DateFormatUtils.format(historicActivityInstance.getStartTime(),"yyyy-MM-dd HH:mm:ss") );


            if (historicActivityInstance.getEndTime() != null) {
                map.put("endTime",DateFormatUtils.format(historicActivityInstance.getEndTime(),"yyyy-MM-dd HH:mm:ss"));

            }
            map.put("costTime",getDatePoor(historicActivityInstance.getEndTime(),historicActivityInstance.getStartTime()));

            if (taskComments.size()>0){
                map.put("message",taskComments.get(0).getFullMessage());
            }else {
                map.put("message","无");
            }
            result.add(map);
        }


        return result;
    }

    private String matching(String ActivityType){
        String value="";
        switch (ActivityType){
            case "startEvent":
                value="流程开始";
                break;
            case "userTask":
                value="用户处理";
                break;
            case "noneEndEvent":
                value="流程结束";
                break;
            default:
                value="未知节点";
                break;
        }
        return value;
    }
    public  String getDatePoor(Date endDate, Date nowDate) {
        if (endDate== null || nowDate == null) {
            return "0";
        }
        long nd = 1000 * 24 * 60 * 60;
        long nh = 1000 * 60 * 60;
        long nm = 1000 * 60;
        long ns = 1000;
        // 获得两个时间的毫秒时间差异
        long diff = endDate.getTime() - nowDate.getTime();
        // 计算差多少天
        long day = diff / nd;
        // 计算差多少小时
        long hour = diff % nd / nh;
        // 计算差多少分钟
        long min = diff % nd % nh / nm;
        // 计算差多少秒//输出结果
        long sec = diff % nd % nh % nm / ns;
        return day + "天" + hour + "小时" + min + "分钟"+ sec + "秒";
    }
}
