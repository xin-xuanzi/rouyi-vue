package com.ruoyi.common.enums;

/**
 * @author xuanzi
 * @date 2022/12/13 15:21
 */
public enum ApprovalActionEnum {
    /**
     * 同意
     */
    PASS,
    /**
     * 驳回，流程取消，不可编辑。
     */
    REJECT,

    /**
     * 驳回_待提交状态，可以变基再提交
     */
    REJECT_TO_BE_SUBMITTED,
}
