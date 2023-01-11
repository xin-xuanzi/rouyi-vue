package com.rouyi.flow.domain;

import lombok.Data;

import java.util.Date;

/**
 * @author xuanzi
 * @date 2022/11/16 10:42
 */
@Data
public class WorkflowQuery{
    private String userId;
    private String processInstanceId;
    private String businessKey;
    private Integer status;
    private Integer pageNum;
    private Integer pageSize;
    private Date beginDate;
    private Date endDate;
    private String submitterNodeName;
}
