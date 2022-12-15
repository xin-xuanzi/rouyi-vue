package com.rouyi.flow.repo.dao.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 流程业务PO
 *
 * @author xuanzi
 * @date 2022/11/8 11:09
 */
@Data
@TableName("t_act_business_variable")
public class ActBusinessVariablePo {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String businessCode;
    private Long variableId;
}
