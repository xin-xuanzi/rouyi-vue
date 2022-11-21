package com.rouyi.flow.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.enums.WorkflowStatus;
import lombok.Data;

import java.util.Date;

/**
 * 流程扩展配置Dto
 *
 * @author xuanzi
 * @date 2022/11/8 16:45
 */
@Data
public class ExpandProcessDto {
    private Long expandProcessId;
    private String businessCode;
    private String source;
    private String name;
    private String notifyTypes;
    private String notifyTitle;
    private int status;
    private int version;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date deployTime;

    public String getStatusName() {
        return WorkflowStatus.getName(this.status);
    }
}
