package com.rouyi.flow.repo.dao.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.common.core.domain.BasePo;
import lombok.Data;

/**
 * 流程业务PO
 *
 * @author xuanzi
 * @date 2022/11/8 11:09
 */
@Data
@TableName("t_act_expand_business")
public class ActExpandBusinessPo extends BasePo {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String  businessCode;
    private String  businessName;
    private String  status;
}
