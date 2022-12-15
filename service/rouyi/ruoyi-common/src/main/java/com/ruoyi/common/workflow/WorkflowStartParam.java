package com.ruoyi.common.workflow;

import lombok.Data;

/**
 * @author xuanzi
 * @date 2022/12/8 16:04
 */
@Data
public class WorkflowStartParam {
    private String processKey;
    /**
     * 流程ID
     */
    private String processDefinitionId;
    /**
     * 业务编码
     */
    private String businessKey;
    /**
     * 提交人
     */
    private String initiator;
    /**
     * 业务ID
     */
    private String caseInstanceId;

    private Object fromData;

    @Override
    public String toString() {
        return "WorkflowStartParam{" +
                "processKey='" + processKey + '\'' +
                ", processDefinitionId='" + processDefinitionId + '\'' +
                ", businessKey='" + businessKey + '\'' +
                ", initiator='" + initiator + '\'' +
                ", caseInstanceId='" + caseInstanceId + '\'' +
                ", fromData=" + fromData +
                '}';
    }
}
