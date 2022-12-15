package com.rouyi.flow.domain.dto;

import lombok.Data;

import java.util.Date;

/**
 * 审批代办 DTO
 * @author xuanzi
 * @date 2022/12/9 15:04
 */
@Data
public class ProcessTodoDto {
    private String processInstanceId;
    private String taskId;
    private String caseInstanceId;
    private String taskName;
    private Date createTime;
    private String processDefinitionId;
    private String submitUserName;
    private String deptName;
    private String businessCode;
    private String businessName;
    private String processName;
    private String viewPath;

}
