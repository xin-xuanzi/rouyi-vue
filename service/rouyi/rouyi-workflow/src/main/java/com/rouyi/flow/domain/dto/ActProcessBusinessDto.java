package com.rouyi.flow.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @author xuanzi
 * @date 2022/11/17 15:31
 */
@Data
public class ActProcessBusinessDto {
    private Long id;
    private String businessName;
    private String businessCode;

    private String  viewPath;

    private String status;
    private String statusName;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
    private List<ExpandProcessDto> expandProcess;

    private List<ProcessVariableDto> variables;
}
