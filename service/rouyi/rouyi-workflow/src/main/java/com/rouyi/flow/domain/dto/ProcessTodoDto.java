package com.rouyi.flow.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
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
    private String assignee;
    private String caseInstanceId;
    private String taskName;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
    private String processDefinitionId;
    private String submitUserName;
    private String deptName;
    private String businessCode;
    private String businessName;
    private String processName;
    private String viewPath;

}
