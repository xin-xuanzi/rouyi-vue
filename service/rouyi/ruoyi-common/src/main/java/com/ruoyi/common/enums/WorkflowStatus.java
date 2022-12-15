package com.ruoyi.common.enums;

import java.util.Objects;

/**
 * @author xuanzi
 * @date 2022/11/18 15:16
 */
public enum WorkflowStatus {
    DRAFT("0", "草稿"), DEPLOY("1", "已部署"), DISABLE("99", "停用"), DELETED("-1", "删除");

    private final String code;
    private final String info;

    WorkflowStatus(String code, String info)
    {
        this.code = code;
        this.info = info;
    }

    public String getCode()
    {
        return code;
    }

    public String getInfo()
    {
        return info;
    }

    public static String getName(String code) {
        String name = "";
        for (WorkflowStatus value : WorkflowStatus.values()) {
            if (Objects.equals(value.getCode(), code)) {
                name = value.getInfo();
                break;
            }
        }

        return name;
    }
}
