package com.jojowonet.modules.sys.util.care;

import ivan.common.utils.DateUtils;

import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.locks.ReentrantLock;

public abstract class DailyRecorder<T> {
    private volatile Date baseDate = DateUtils.truncate(new Date(), Calendar.DATE);
    private final ReentrantLock lock = new ReentrantLock();

    public final void record(T rec) {
        lock.lock();
        try {
            Date atBeginningOfToday = DateUtils.truncate(new Date(), Calendar.DATE);
            if (atBeginningOfToday.after(baseDate)) {
                baseDate = DateUtils.truncate(new Date(), Calendar.DATE);
                doResetRecords();
            }
            if (atBeginningOfToday.equals(baseDate)) {
                doRecord(rec);
            }
        } finally {
            lock.unlock();
        }
    }

    public ReentrantLock getRecordLock() {
        return lock;
    }

    /**
     * do record logic here.
     *
     * @param t data to be record
     */
    protected abstract void doRecord(T t);

    /**
     * reset recorded data when date changed.
     */
    public abstract void doResetRecords();
}
