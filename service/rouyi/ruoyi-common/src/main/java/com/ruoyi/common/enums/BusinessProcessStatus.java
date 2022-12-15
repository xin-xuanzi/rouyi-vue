package com.ruoyi.common.enums;

import lombok.Getter;

import java.util.Objects;

/**
 * @author xuanzi
 * @date 2022/12/8 16:30
 */
@Getter
public enum BusinessProcessStatus {
    DRAFT("0", "草稿"),
    APPROVAL("1", "审批中")
    , PASSED("2", "通过")
    , REJECTED("99", "驳回")
    , DELETED("-1", "删除")

    ;

    private final String code;
    private final String info;

    BusinessProcessStatus(String code, String info)
    {
        this.code = code;
        this.info = info;
    }

    public static String getName(String code) {
        String name = "";
        for (BusinessProcessStatus value : BusinessProcessStatus.values()) {
            if (Objects.equals(value.getCode(), code)) {
                name = value.getInfo();
                break;
            }
        }

        return name;
    }
}
