package com.jojowonet.modules.sys.util.care.site;

import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.sys.util.care.DailyRecorder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.concurrent.locks.ReentrantLock;

@Component
public class SiteDailyRecorder extends DailyRecorder<Site> {
    private final HashSet<String> siteIds = new HashSet<>();
    private static final int MAX_ACTIVE_SITES = 2000;

    @Override
    protected void doRecord(Site site) {
        if (site != null && StringUtils.isNotBlank(site.getId())) {
            if (siteIds.size() < MAX_ACTIVE_SITES) {
                siteIds.add(site.getId());
            }
        }
    }

    @Override
    public void doResetRecords() {
        siteIds.clear();
    }

    public int getActiveSites() {
        ReentrantLock lock = getRecordLock();
        lock.lock();
        try {
            return siteIds.size();
        } finally {
            lock.unlock();
        }
    }

    public void recordActiveSite(Site site) {
        record(site);
    }
}
