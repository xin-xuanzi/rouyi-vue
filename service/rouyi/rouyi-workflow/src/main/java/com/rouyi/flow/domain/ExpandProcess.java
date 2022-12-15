package com.rouyi.flow.domain;

import lombok.Data;
import org.camunda.bpm.engine.repository.ProcessDefinition;

/**
 * 扩展流程定义
 *
 * @author xuanzi
 * @date 2022/11/8 10:42
 */
@Data
public class ExpandProcess {
    private Long id;
    private String businessCode;
    private String source;
    private String status;
    private String nodeProps;
    private String variable;
    private String name;
    private int version;
    private ProcessDefinition processDefinition;
}
