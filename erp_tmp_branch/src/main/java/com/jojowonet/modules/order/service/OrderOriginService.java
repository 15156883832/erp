/**
 */
package com.jojowonet.modules.order.service;

import java.util.Date;
import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.search.bridge.builtin.UUIDBridge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderOrigin;
import com.jojowonet.modules.order.dao.OrderOriginDao;

/**
 * 来源Service
 * @author Ivan
 * @version 2017-05-04
 */
@Component
@Transactional(readOnly = true)
public class OrderOriginService extends BaseService {

	@Autowired
	private OrderOriginDao orderOriginDao;
	
	public OrderOrigin get(String id) {
		return orderOriginDao.get(id);
	}
	
	public Page<OrderOrigin> find(Page<OrderOrigin> page, OrderOrigin orderOrigin,String siteId) {
		DetachedCriteria dc = orderOriginDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(orderOrigin.getId())){
			dc.add(Restrictions.like("name", "%"+orderOrigin.getId()+"%"));
		}
		dc.add(Restrictions.eq("siteId", siteId));
		dc.add(Restrictions.eq("status", "0"));
		//dc.add(Restrictions.eq("delFlag", "0"));
		dc.addOrder(Order.asc("sort"));
		
		return orderOriginDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public void save(OrderOrigin orderOrigin) {
		//orderOriginDao.clear();
		if("".equals(orderOrigin.getId())||orderOrigin.getId()==null){
			orderOrigin.setId(null);
		}

			orderOriginDao.save(orderOrigin);
		
			
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		orderOriginDao.deleteById(id);
	}
	
	public List<Record> filterOrderOrigin(String siteId) {
		return orderOriginDao.filterOrderOrigin(siteId, null);
	}
	
	public boolean queryNumByName(String site_id,String name){
		List list = orderOriginDao.createSqlQuery("select * from crm_site_order_origin"
				+ " where site_id = :p1 and name = :p2 and status='0' ",new Parameter(site_id,name)).list();
		if (list.size()>0)
			return true;
		return false;
	}

	

	public Record getOrderOriginById(String id, String siteId) {

Record rd=orderOriginDao.getOrderOriginById(id,siteId);

		return rd;
	}

	public void update(OrderOrigin orderOrigin) {

		
	}

	public void updates(String name, String sort, String id) {
		orderOriginDao.updates(name,sort,id);
		
	}

	public boolean queryNumByNames(String site_id,String names,String id){
		List list = orderOriginDao.createSqlQuery("select * from crm_site_order_origin"
				+ " where site_id = :p1 and name = :p2 and id!=:p3 and status='0' ",new Parameter(site_id,names,id)).list();
		if (list.size()>0)
			return false;
		return true;
	}
}
