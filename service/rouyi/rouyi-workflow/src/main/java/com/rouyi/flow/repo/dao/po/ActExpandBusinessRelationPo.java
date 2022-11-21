package com.rouyi.flow.repo.dao.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author xuanzi
 * @date 2022/11/8 14:00
 */
@Data
@TableName("t_act_expand_business_relation")
public class ActExpandBusinessRelationPo {
    @TableId(type = IdType.AUTO)
    private Long id;
    private long expandProcessId;
    private String businessCode ;
}
