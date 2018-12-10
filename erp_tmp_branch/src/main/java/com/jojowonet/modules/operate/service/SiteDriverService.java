/**
 */
package com.jojowonet.modules.operate.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteDriverDao;
import com.jojowonet.modules.operate.entity.SiteDriver;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

/**
 * 司机信息Service
 * @author lzp
 * @version 2018-10-31
 */
@Component
@Transactional(readOnly = true)
public class SiteDriverService extends BaseService {

	@Autowired
	private SiteDriverDao siteDriverDao;
	
	public SiteDriver get(String id) {
		return siteDriverDao.get(id);
	}
	
	public Page<SiteDriver> find(Page<SiteDriver> page, SiteDriver siteDriver,String siteId) {
		DetachedCriteria dc = siteDriverDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(siteDriver.getDriverName())){
			dc.add(Restrictions.like("driverName", "%"+siteDriver.getDriverName()+"%"));
		}
		if (StringUtils.isNotEmpty(siteDriver.getDriverMobile())){
			dc.add(Restrictions.like("driverMobile", "%"+siteDriver.getDriverMobile()+"%"));
		}
		dc.add(Restrictions.eq("siteId", siteId));
		dc.addOrder(Order.desc("createTime"));
		return siteDriverDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public void save(SiteDriver siteDriver) {
		siteDriverDao.save(siteDriver);
	}
	
	public boolean getCheckNumber(String siteId,String name) {
		return siteDriverDao.getCheckNumber(siteId, name);
	}
	
	@Transactional(readOnly = false)
	public void deleteSiteDriver(String id) {
		siteDriverDao.deleteSiteDriver(id);
	}
	
	/*
	 * 获取当前服务商的司机人员
	*/
	public static List<Record> getsiteDriverList(String siteId){
		String sql =" SELECT driver_name,id FROM crm_site_driver WHERE site_id=? ";
		return Db.find(sql,siteId);
		
	}
}
