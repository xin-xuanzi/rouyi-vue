package com.rouyi.flow.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @author xuanzi
 * @date 2022/12/13 14:09
 */
@Data
public class ApprovalRecordNodeDto {

    private String actHiInstId;
    private String actId;
    private String taskId;
    private String actType;
    private String actName;
    private String assignee;
    private String userName;



    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date time;
    private List<ApprovalRecordItemDto> itemDtoList;

    @Data
    public static class ApprovalRecordItemDto{
        private String userName;
        private String assignee;
        private String comment;
        private String approvalResult;
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private Date time;

        private String actName;
    }
}
