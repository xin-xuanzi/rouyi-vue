package com.rouyi.flow.domain;

import lombok.Data;

/**
 * @author xuanzi
 * @date 2022/11/16 10:42
 */
@Data
public class WorkflowQuery {
    private String userId;
    private String processInstanceId;
    private String businessKey;
    private Integer status;
}
