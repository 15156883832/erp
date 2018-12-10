package com.jojowonet.modules.sys.util.care;

import ivan.common.utils.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.ReentrantLock;

@Component
public class ActionStatsWorker implements Runnable {

    private static Logger logger = Logger.getLogger(ActionStatsWorker.class);
    private final ExecutorService workPool;
    private final Map<String, ActionStat> actionMap = new HashMap<>();
    private final ReentrantLock lock = new ReentrantLock();
    private final QuickRejectQueue q;
    private volatile Date baseDate = DateUtils.truncate(new Date(), Calendar.DATE);

    @Autowired
    public ActionStatsWorker(QuickRejectQueue q) {
        this.workPool = new ThreadPoolExecutor(2, 2, 0L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<Runnable>(1000),
                Executors.defaultThreadFactory(),
                new RejectedExecutionHandler() {
                    @Override
                    public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
                        logger.warn("stats job rejected");
                    }
                });
        this.q = q;
    }


    /**
     * @return invocation times stats snapshot for each action.
     */
    public Map<String, ActionStat> getActionStats() {
        Map<String, ActionStat> map = new HashMap<>();
        lock.lock();
        try {
            Set<Map.Entry<String, ActionStat>> entrySet = actionMap.entrySet();
            for (Map.Entry<String, ActionStat> entry : entrySet) {
                map.put(entry.getKey(), entry.getValue().snap());
            }
        } finally {
            lock.unlock();
        }
        return map;
    }

    /**
     * @return invocation times stats snapshot for each action.
     */
    public List<ActionStat> getActionStats(int start, int end) {
        List<ActionStat> list = new ArrayList<>();
        lock.lock();
        try {
            Collection<ActionStat> stats = actionMap.values();
            for (ActionStat stat : stats) {
                list.add(stat.snapBetweens(start, end));
            }
        } finally {
            lock.unlock();
        }
        return list;
    }

    class StatJob implements Runnable {

        private final ActionInfo actionInfo;

        StatJob(ActionInfo actionInfo) {
            this.actionInfo = actionInfo;
        }

        @Override
        public void run() {
            Date d = new Date(actionInfo.getPerformAt());
            if (d.getDate() != new Date().getDate()) {
                // drop this stat
                return;
            }

            ActionStat actionStat;
            lock.lock();
            try {
                String actionPath = actionInfo.getActionPath();
                actionPath = normActionPath(actionPath);
                actionStat = actionMap.get(actionPath);
                if (actionStat == null) {
                    actionStat = new ActionStat(actionPath);
                    actionMap.put(actionPath, actionStat);
                }
            } finally {
                lock.unlock();
            }
            actionStat.stat(actionInfo);
        }

        private String normActionPath(String actionPath) {
            int index = actionPath.indexOf(";jsessionid=");
            if (index > 0) {
                actionPath = actionPath.substring(0, index);
            }
            return actionPath;
        }
    }

    @Override
    public void run() {
        for (; ; ) {
            try {
                ActionInfo actionInfo = q.take();
                Date d = new Date(actionInfo.getPerformAt());
                Date atBeginningOfToday = DateUtils.truncate(new Date(), Calendar.DATE);
                if (!atBeginningOfToday.equals(baseDate)) {
                    if (d.after(atBeginningOfToday)) {
                        // we know date changed
                        baseDate = atBeginningOfToday;
                        lock.lock();
                        try {
                            actionMap.clear();
                        } finally {
                            lock.unlock();
                        }
                    }
                } else {
                    workPool.submit(new StatJob(actionInfo));
                }
            } catch (InterruptedException e) {
                logger.error("take failed", e);
            }
        }
    }
}
