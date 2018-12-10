package com.jojowonet.modules.order.dao;

import org.springframework.stereotype.Repository;

import ivan.common.persistence.BaseDao;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.entity.OrderType;

@Repository
public class OrderTypeDao extends BaseDao<OrderType> {

	
	public int queryNameNum(String name){
		
		return getSession().createSQLQuery("select * from crm_order_type where name = '"+name+"' and status='0'").list().size();
	}
	
	public void updateOrderType(OrderType orderType){
		String sql="update crm_order_type set name =? where id= ?";
		Db.update(sql,orderType.getName(),orderType.getId());
	}
}
