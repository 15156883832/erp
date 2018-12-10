package com.jojowonet.modules.sys.util.care;

import java.util.Date;
import java.util.concurrent.locks.ReentrantLock;

public class ActionStat {
    private final String actionPath;
    private final long[] invokeTimes = new long[16];
    private final long[] performConsumed = new long[16];
    private final ReentrantLock lock = new ReentrantLock();
    private long invokeTimesBetweens;
    private double avgTimeCostBetweens;

    public ActionStat(String actionPath) {
        this.actionPath = actionPath;
    }

    public String getActionPath() {
        return actionPath;
    }

    public long[] getInvokeTimes() {
        long[] tmp = new long[24];
        System.arraycopy(this.invokeTimes, 0, tmp, 7, 16);
        return tmp;
    }

    public long[] getPerformConsumed() {
        long[] tmp = new long[24];
        System.arraycopy(this.performConsumed, 0, tmp, 7, 16);
        return tmp;
    }

    /**
     * call snapBetweens first before call this method.
     */
    public long getInvokeTimesBetweens() {
        return invokeTimesBetweens;
    }

    /**
     * call snapBetweens first before call this method.
     */
    public double getAvgTimeCostBetweens() {
        return avgTimeCostBetweens;
    }

    public double getAvgConsumed(int hour) {
        if (!isStatsHour(hour)) {
            return 0;
        }
        return performConsumed[hour - 7] * 1.0d / invokeTimes[hour - 7];
    }

    public void reset() {
        lock.lock();
        try {
            resetArray(invokeTimes);
            resetArray(performConsumed);
        } finally {
            lock.unlock();
        }
    }

    private void resetArray(long[] arr) {
        for (int i = 0, n = arr.length; i < n; i++) {
            arr[i] = 0;
        }
    }

    private boolean isStatsHour(int hour) {
        // 真正统计的时间区间是：[7, 22]
        return hour != 23 && hour >= 7;
    }

    public void stat(ActionInfo actionInfo) {
        Long performAt = actionInfo.getPerformAt();
        long consumed = actionInfo.getPerformConsumed();
        int hour = new Date(performAt).getHours();
        if (isStatsHour(hour)) {
            lock.lock();
            try {
                performConsumed[hour - 7] += consumed;
                invokeTimes[hour - 7] += 1;
            } finally {
                lock.unlock();
            }
        }
    }

    public ActionStat snap() {
        lock.lock();
        try {
            ActionStat snap = new ActionStat(this.actionPath);
            System.arraycopy(this.invokeTimes, 0, snap.invokeTimes, 0, 16);
            System.arraycopy(this.performConsumed, 0, snap.performConsumed, 0, 16);
            return snap;
        } finally {
            lock.unlock();
        }
    }

    public ActionStat snapBetweens(int start, int end) {
        ActionStat snap = snap();
        long[] snapInvokeTimes = snap.getInvokeTimes();
        long[] snapPerformConsumed = snap.getPerformConsumed();

        long performConsumedStats = 0L;
        for (int i = start; i < end; i++) {
            snap.invokeTimesBetweens += snapInvokeTimes[i];
            performConsumedStats += snapPerformConsumed[i];
        }
        snap.avgTimeCostBetweens = snap.invokeTimesBetweens == 0 ? 0 : (performConsumedStats * 1.0d / snap.invokeTimesBetweens);
        return snap;
    }
}
