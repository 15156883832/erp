/**
 */
package com.jojowonet.modules.order.dao;

import com.jojowonet.modules.order.utils.TableSplitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jojowonet.modules.order.entity.OrderCallBack;
import com.jojowonet.modules.order.utils.SqlKit;

import ivan.common.persistence.BaseDao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 派工DAO接口
 * @author Ivan
 * @version 2017-05-04
 */
@Repository
public class OrderCallbackDao extends BaseDao<OrderCallBack> {
	@Autowired
	TableSplitMapper tableSplitMapper;

	public Record getbysite(String orderId, String siteIds) {
		
		return Db.findFirst("SELECT * FROM crm_order_callback WHERE order_id=? AND site_id=?", orderId,siteIds);
	}
	
	public Record getLatestOrderCallback(String orderId) { // callback理论上只有一条，所以没必要limit 1
		SqlKit sb = new SqlKit()
				.append("SELECT * ")
				.append("from crm_order_callback")
				.append("where order_id=?")
				.append("order by create_time desc")
				.append("limit 1");

		return Db.findFirst(sb.toString(), orderId);
	}

	public Record getLatestOrderCallback2017(String orderId, String siteId) {
		String callbackTable = tableSplitMapper.mapOrderCallback(siteId);
		if (callbackTable == null) {
			return null;
		}

		StringBuilder sb = new StringBuilder();
		sb.append(" select * from " + callbackTable + " a  where a.order_id = ? and a.site_id = ? order by a.create_time desc limit 1");
		return Db.findFirst(sb.toString(), orderId, siteId);
	}
}
