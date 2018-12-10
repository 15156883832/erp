package com.jojowonet.modules.sys.util.care;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ActionAnalytics implements InitializingBean {

    private static Logger logger = Logger.getLogger(ActionAnalytics.class);

    private final QuickRejectQueue actionStatsQueue;

    private final ActionStatsWorker actionStatsWorker;

    @Autowired
    public ActionAnalytics(QuickRejectQueue actionStatsQueue, ActionStatsWorker actionStatsWorker) {
        this.actionStatsQueue = actionStatsQueue;
        this.actionStatsWorker = actionStatsWorker;
    }

    public void actionPerformed(String actionPath, long at, long performConsumed, long renderConsumed, boolean hasEx) {
        if (performConsumed > 2000 || renderConsumed > 2000) {
            logger.info(String.format("action performed,path=%s,c=%d,r=%d,hasEx=%b", actionPath, performConsumed, renderConsumed, hasEx));
        }

        ActionInfo actionInfo = new ActionInfo();
        actionInfo.setActionPath(actionPath);
        actionInfo.setPerformAt(at);
        actionInfo.setPerformConsumed(performConsumed);
        actionInfo.setRenderConsumed(renderConsumed);
        actionStatsQueue.offer(actionInfo);
    }

    public void startWorker() {
        new Thread(actionStatsWorker).start();
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        startWorker();
    }
}
