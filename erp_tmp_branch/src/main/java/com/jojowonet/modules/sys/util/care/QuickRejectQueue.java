package com.jojowonet.modules.sys.util.care;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

@Component
public class QuickRejectQueue {

    private static Logger logger = Logger.getLogger(QuickRejectQueue.class);
    private final LinkedBlockingQueue<ActionInfo> q = new LinkedBlockingQueue<>(1000);

    public ActionInfo take() throws InterruptedException {
        return q.take();
    }

    public boolean offer(ActionInfo stat) {
        boolean offered = q.offer(stat);
        if (!offered) {
            logger.warn(String.format("action stat rejected, action=%s", stat.getActionPath()));
        }
        return offered;
    }

    public BlockingQueue<ActionInfo> getQueue() {
        return q;
    }
}
