/**
 */
package com.jojowonet.modules.order.service;

import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Township;
import com.jojowonet.modules.order.dao.TownshipDao;

/**
 * 乡镇信息Service
 * @author Ivan
 * @version 2018-01-20
 */
@Component
@Transactional(readOnly = true)
public class TownshipService extends BaseService {

	@Autowired
	private TownshipDao townshipDao;
	
	public Township get(String id) {
		return townshipDao.get(id);
	}
	
	public Page<Township> find(Page<Township> page,String siteId) {
		DetachedCriteria dc = townshipDao.createDetachedCriteria();
		dc.add(Restrictions.eq("siteId", siteId));
		dc.add(Restrictions.eq("status", "1"));
		dc.addOrder(Order.asc("sort"));
		return townshipDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public void save(Township township) {
		townshipDao.save(township);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		townshipDao.updateStatus(id,"0");
	}
	
	public Boolean getCheckName(String siteId,String name){
		return townshipDao.getCheckName(siteId, name);
	}
	
	public void updates(String name, String sort, String id) {
		townshipDao.updates(name, sort, id);
	}
	
	public List<Record> getTownshipSiteId(String siteId){
		return townshipDao.getTownshipSiteId(siteId);
	}
}
