/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderSettlementDetail;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

/**
 * 派工DAO接口
 * @author Ivan
 * @version 2017-05-04
 */
@Repository
public class OrderSettlementDetailDao extends BaseDao<OrderSettlementDetail> {

	public Map<String, OrderSettlementDetail> getByDispathIdInMap(String dispatchId) {
		List<OrderSettlementDetail> list = getByDispathId(dispatchId);
		Map<String, OrderSettlementDetail> retMap = Maps.newHashMap();
		for(OrderSettlementDetail detail : list){
			retMap.put(detail.getEmployeId(), detail);
		}
		return retMap;
	}
	
	public List<OrderSettlementDetail> getByDispathId(String dispatchId) {
		return findBySql(" from OrderSettlementDetail a where a.dispatchId = :p1 ", new Parameter(dispatchId));
	}
	
	//查询结算明细
	public Record getOrderSettlement(String siteId,String orderId){
	String sql =" SELECT * FROM crm_order_settlement_detail WHERE order_id='"+orderId+"' AND site_id='"+siteId+"' ";	
	return Db.findFirst(sql);
	}
}
