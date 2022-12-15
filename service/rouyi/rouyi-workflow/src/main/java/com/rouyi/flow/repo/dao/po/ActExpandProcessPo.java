package com.rouyi.flow.repo.dao.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BasePo;
import lombok.Data;

import java.util.Date;

/**
 * 流程扩展
 *
 * @author xuanzi
 * @date 2022/11/8 14:01
 */
@Data
@TableName("t_act_expand_process")
public class ActExpandProcessPo extends BasePo {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String actProcessId;
    private String actDeploymentId;
    private int version;
    private String status;
    private String name;
    private String remark;
    private String source;
    private String nodeProps;
    private String variable;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date deployTime;
    private String tenantId;
}
