package com.rouyi.flow.domain;

import lombok.Data;

import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/15 18:47
 */
@Data
public class WorkflowDto {
    private String processKey;
    private String businessKey;
    private String initiator;
    private String caseInstanceId;
    private Map<String,Object> params;
}
