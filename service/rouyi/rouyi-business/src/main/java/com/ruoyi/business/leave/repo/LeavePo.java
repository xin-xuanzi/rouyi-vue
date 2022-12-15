package com.ruoyi.business.leave.repo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @author xuanzi
 * @date 2022/12/8 15:02
 */
@Data
@TableName("t_leave")
public class LeavePo{
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Integer leaveType;
    private Date startDate;
    private String startTime;
    private Date endDate;
    private String endTime;
    private Double duration;
    private String status;
    private String remark;
    private String processInstanceId;

    private Date createTime;
    private Date updateTime;
}
