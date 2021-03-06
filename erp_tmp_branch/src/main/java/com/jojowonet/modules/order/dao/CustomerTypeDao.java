/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.CustomerType;

import ivan.common.persistence.BaseDao;

/**
 * 用户类型DAO接口
 * @author lzp
 * @version 2018-07-18
 */
@Repository
public class CustomerTypeDao extends BaseDao<CustomerType> {
	
	public static List<Record> getCustomerTypeList(String siteId){
		return Db.find("  SELECT * FROM crm_site_customer_type a WHERE a.site_id =? AND a.status='0' ORDER BY a.create_time ASC  ",siteId);
	}
	
	public static long getsiteCustomerTypeCount(String siteId) {
		return Db.queryLong("  SELECT count(*) FROM crm_site_customer_type a WHERE a.site_id =? AND a.status='0'  ", siteId);
	}
}
