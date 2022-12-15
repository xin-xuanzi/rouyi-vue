package com.rouyi.flow.domain.valobj;

/**
 * 工作流参数
 * @author xuanzi
 * @date 2022/11/30 11:11
 */
public class WorkflowVariable {

    public static enum LEAVE_VARIABLE{
        ;
        private String code;
        private String name;
        private String desc;

        LEAVE_VARIABLE(String code, String name, String desc) {
            this.code = code;
            this.name = name;
            this.desc = desc;
        }

        //请假
        
    }

}
