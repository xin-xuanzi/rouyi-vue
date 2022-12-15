package com.rouyi.flow.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 流程变量
 *
 * @author xuanzi
 * @date 2022/11/29 17:23
 */
@Data
public class ProcessVariableDto {
    private Long id;
    private String variableId;
    private String code;
    private String variableCode;
    private String title;
    private String description;
    private String invokeTarget;
    private String bean;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
}
