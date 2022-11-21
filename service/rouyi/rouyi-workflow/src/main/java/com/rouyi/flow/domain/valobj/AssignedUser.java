package com.rouyi.flow.domain.valobj;

import lombok.Data;

/**
 *
 * 审批人
 * @author xuanzi
 * @date 2022/11/14 14:47
 */
@Data
public class AssignedUser {
    private Long userId;
    private String name;
}
