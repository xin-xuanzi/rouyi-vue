package com.rouyi.flow;

import com.rouyi.flow.config.parser.ExpandProcessParser;
import com.rouyi.flow.domain.ExpandProcess;
import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.model.bpmn.Bpmn;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;

import java.io.*;

/**
 * @author xuanzi
 * @date 2022/11/9 16:13
 */
@Slf4j
public class WorkflowTest {

    public static void main(String[] args)throws Exception {
//        String split = StringUtils.substring("Approval-pre-process_node_12312", WorkflowConstant.APPROVAL_PRE_INTERMEDIATE_THROW_EVENT.length());
//        System.out.println(" ===>>>"+split);

        test001();
//        Class<?> aClass = Class.forName("com.rouyi.flow.service.IWorkflowVariableInvokeService");
//        Method[] classMethods = aClass.getMethods();
//        for (Method classMethod : classMethods) {
//            System.out.println(classMethod.getName());
//        }
    }
    public static void test001() throws Exception {

        String source = readJsonFile("E:\\Projects\\my-project\\process\\processNodeArray.json");


        ExpandProcess expandProcess = new ExpandProcess();
        expandProcess.setName("测试-延时审批");
        expandProcess.setBusinessCode("delay_complete");
        expandProcess.setSource(source);
        ExpandProcessParser expandProcessParser = new ExpandProcessParser(expandProcess);

        BpmnModelInstance parse = expandProcessParser.parse();

        File file = null;
        try {
            file = new File("E:\\Projects\\my-project\\process\\delay_complete.bpmn");
            Bpmn.writeModelToFile(file, parse);
        } catch (Exception e) {
            // TODO Auto-generated catch block

            log.info("Exception occured" + e.getMessage());
            e.printStackTrace();
        }


    }



    public static String readJsonFile(String fileName) {
        String jsonStr = "";
        try {
            File jsonFile = new File(fileName);
            FileReader fileReader = new FileReader(jsonFile);

            Reader reader = new InputStreamReader(new FileInputStream(jsonFile), "utf-8");
            int ch = 0;
            StringBuffer sb = new StringBuffer();
            while ((ch = reader.read()) != -1) {
                sb.append((char) ch);
            }

            fileReader.close();
            reader.close();
            jsonStr = sb.toString();
            return jsonStr;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

}
