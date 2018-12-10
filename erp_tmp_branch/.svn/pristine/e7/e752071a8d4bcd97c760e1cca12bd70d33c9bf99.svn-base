package com.jojowonet.modules.order.service;

import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.order.dao.OrderTypeDao;
import com.jojowonet.modules.order.entity.OrderType;

@Component
@Transactional(readOnly=true)
public class OrderTypeService extends BaseService {

	@Autowired
	private OrderTypeDao orderTypeDao;
	
	public OrderType get(String id){
		
		return orderTypeDao.get(Integer.parseInt(id));
	}
	
	public Page<OrderType> find(Page<OrderType> page){
		 DetachedCriteria dc = orderTypeDao.createDetachedCriteria();
		 dc.add(Restrictions.eq("status", "0"));
		 dc.addOrder(Order.asc("createTime"));
		 return orderTypeDao.find(page,dc);
	}
	
	public void save(OrderType orderType){
			if(orderType.getId()==null){
				orderTypeDao.save(orderType);
			}else{
				orderTypeDao.updateOrderType(orderType);
			}
		//orderTypeDao.flush();
	}
	
	public void delete(String id){
		orderTypeDao.deleteById(Integer.parseInt(id));
	}
	
	public int queryNameNum(String name){
		
		return orderTypeDao.queryNameNum(name);
	}
	public boolean queryNumByName(String name){
		List list = orderTypeDao.createSqlQuery("select * from crm_order_type"
				+ " where name = :p1",new Parameter(name)).list();
		if (list.size()>0)
			return false;
		return true;
	}
	
}
