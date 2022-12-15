package com.rouyi.flow.domain;

import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Maps;
import com.ruoyi.common.constant.HttpStatus;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.workflow.WorkflowStartParam;
import lombok.Data;

import java.util.Map;

/**
 * @author xuanzi
 * @date 2022/11/15 18:47
 */
@Data
public class WorkflowDto {

    public WorkflowDto() {
    }
    public WorkflowDto(WorkflowStartParam param) {
        if (param.getFromData() == null) {
            throw new ServiceException("业务表单数据不能为空", HttpStatus.BAD_REQUEST);
        }
        if (StringUtils.isEmpty(param.getProcessDefinitionId())) {
            throw new ServiceException("流程定义ID不能为空", HttpStatus.BAD_REQUEST);
        }
//        if (StringUtils.isEmpty(param.getBusinessKey())) {
//            throw new ServiceException("流程业务编码不能为空", HttpStatus.BAD_REQUEST);
//        }
        if (StringUtils.isEmpty(param.getInitiator())) {
            throw new ServiceException("流程提价人不能为空", HttpStatus.BAD_REQUEST);
        }

        if (StringUtils.isEmpty(param.getCaseInstanceId())) {
            throw new ServiceException("业务ID不能为空", HttpStatus.BAD_REQUEST);
        }

        this.processDefinitionId = param.getProcessDefinitionId();
        this.initiator = param.getInitiator();
        this.caseInstanceId = param.getCaseInstanceId();
        this.params = Maps.newHashMap();
        params.put("formData", JSONObject.toJSONString(param.getFromData()));
    }


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
    /**
     * 请求参数
     * 必须包括 fromData,业务实例对象
     */
    private Map<String,Object> params;

}
