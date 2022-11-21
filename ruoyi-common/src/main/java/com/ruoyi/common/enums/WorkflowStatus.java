package com.ruoyi.common.enums;

/**
 * @author xuanzi
 * @date 2022/11/18 15:16
 */
public enum WorkflowStatus {
    DRAFT(0, "草稿"), DEPLOY(1, "已部署"), DISABLE(99, "停用"), DELETED(-1, "删除");

    private final int code;
    private final String info;

    WorkflowStatus(int code, String info)
    {
        this.code = code;
        this.info = info;
    }

    public int getCode()
    {
        return code;
    }

    public String getInfo()
    {
        return info;
    }

    public static String getName(int code) {
        String name = "";
        for (WorkflowStatus value : WorkflowStatus.values()) {
            if (value.getCode() == code) {
                name = value.getInfo();
                break;
            }
        }

        return name;
    }
}
