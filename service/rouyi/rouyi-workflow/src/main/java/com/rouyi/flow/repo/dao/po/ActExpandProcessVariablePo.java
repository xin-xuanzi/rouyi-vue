package com.rouyi.flow.repo.dao.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;

/**
 * 流程业务PO
 *
 * @author xuanzi
 * @date 2022/11/8 11:09
 */
@Data
@TableName("t_act_expand_process_variable")
public class ActExpandProcessVariablePo {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String  code;
    private String  title;
    private String  description;
    private String  invokeTarget;
    private String  bean;
    private Date createTime;
    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    private Date updateTime;
}
