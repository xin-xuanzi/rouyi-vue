package com.rouyi.flow.domain;

import lombok.Data;

import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/15 18:47
 */
@Data
public class WorkflowApprovalDto {
    private String processInstance;
    private String business;
    private String userId;
    private String result;
    private String comment;
    private Map<String,Object> params;
}
