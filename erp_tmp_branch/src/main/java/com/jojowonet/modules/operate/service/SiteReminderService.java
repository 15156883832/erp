package com.jojowonet.modules.operate.service;

import com.jojowonet.modules.operate.dao.SiteReminderDao;
import com.jojowonet.modules.operate.entity.SiteReminder;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * @author gaols
 * @version 2016-08-01
 */
@Service
@Transactional(readOnly = true)
public class SiteReminderService extends BaseService {

    @Autowired
    SiteReminderDao siteReminderDao;

    public SiteReminder getSiteXuFeiReminder(String siteId) {
        return siteReminderDao.getSiteXuFeiReminder(siteId);
    }

    public void touchLastRemind(String siteId) {
        SiteReminder reminder = getSiteXuFeiReminder(siteId);
        if (reminder == null) {
			reminder = new SiteReminder();
			reminder.setRemindType(SiteReminder.RemindType.XuFei.getVal());
			reminder.setLastRemindTime(new Date());
			reminder.setSiteId(siteId);
			siteReminderDao.save(reminder);
        } else {
            reminder.setLastRemindTime(new Date());
            siteReminderDao.save(reminder);
        }
    }
}
