/**
 */
package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderParentCallBack;
import com.jojowonet.modules.order.utils.SqlKit;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

/**
 * 派工DAO接口
 * @author Ivan
 * @version 2017-05-04
 */
@Repository
public class OrderParentCallbackDao extends BaseDao<OrderParentCallBack> {

	public Record getbysite(String orderId, String siteIds) {
		return Db.findFirst("SELECT * FROM crm_order_parent_callback WHERE order_id=? AND site_id=?", orderId,siteIds);
	}
	
	public Record getLatestOrderCallback(String orderId) {
		SqlKit sb = new SqlKit()
				.append("SELECT * ")
				.append("from crm_order_callback")
				.append("where order_id=?")
				.append("order by create_time desc")
				.append("limit 1");

		return Db.findFirst(sb.toString(), orderId);
	}
}
