package com.rouyi.flow.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * @author xuanzi
 * @date 2022/12/13 14:09
 */
@Data
public class ApprovalRecordDto {
    private String taskName;
    private String userName;
    private String comment;
    private String approvalResult;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date time;
}
