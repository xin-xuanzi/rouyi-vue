package com.rouyi.flow.config.listener;

import lombok.extern.slf4j.Slf4j;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.springframework.stereotype.Service;

/**
 * 流程 开始， 结束 监听器 listener
 * @author xuanzi
 * @date 2022/11/9 10:39
 */
@Slf4j
@Service("processListener")
public class ProcessInstanceListener {
    public void start(DelegateExecution execution) {
        log.error("流程开始");
    }
}
