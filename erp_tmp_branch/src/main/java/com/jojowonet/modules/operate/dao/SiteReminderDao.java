package com.jojowonet.modules.operate.dao;

import com.jojowonet.modules.operate.entity.SiteReminder;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;
import org.springframework.stereotype.Repository;

/**
 * 服务商DAO接口
 * 
 * @author gaols
 * @version 2016-08-01
 */
@Repository
public class SiteReminderDao extends BaseDao<SiteReminder> {

	public SiteReminder getSiteXuFeiReminder(String siteId) {
		return getByHql("from SiteReminder where siteId=:p1 and remindType=:p2", new Parameter(siteId, SiteReminder.RemindType.XuFei.getVal()));
	}
}
