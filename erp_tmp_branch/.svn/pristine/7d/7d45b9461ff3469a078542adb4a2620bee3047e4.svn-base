package com.jojowonet.modules.order.service;

import ivan.common.service.BaseService;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

@Component
@Transactional(readOnly = true)
public class PrintService extends BaseService{

	public Record getOrderMsg(String orderId){
		//查询额外的信息
		StringBuilder sb = new StringBuilder("");
		sb.append(" SELECT a.service_attitude,c.name as siteName, c.mobile,c.sms_phone, co.end_time,co.dispatch_time ");
		sb.append(" FROM crm_order co LEFT JOIN crm_order_callback a ON a.order_id = co.id ");
		sb.append(" LEFT JOIN crm_site c ON c.id = co.site_id ");
		sb.append(" WHERE co.id = '"+orderId+"' ");
		sb.append(" ORDER BY a.create_time DESC  LIMIT 1 ");
		return Db.findFirst(sb.toString());
	}
}
