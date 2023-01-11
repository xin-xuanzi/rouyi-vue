package com.ruoyi.business.leave.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.enums.BusinessProcessStatus;
import lombok.Data;

import java.util.Date;

/**
 * @author xuanzi
 * @date 2022/12/8 15:09
 */
@Data
public class LeaveDto {
    private Long id;
    private long userId;
    private Integer leaveType;
    private String userName;
    private String deptName;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    private String startTime;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
    private String endTime;
    private Double duration;
    private String status;
    private String businessKey;
    private String remark;
    /**
     * 流程定义ID
     */
    private String processDefinitionId;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public String getStatusName() {
        return BusinessProcessStatus.getName(this.status);
    }
}
