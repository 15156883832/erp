/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Distribution;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

/**
 * 配送信息DAO接口
 * @author lzp
 * @version 2018-10-31
 */
@Repository
public class DistributionDao extends BaseDao<Distribution> {
	
	public List<Record> getDistributionList(String siteId,Page<Record> page,Map<String,Object> map){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT a.driver_name,a.create_time,a.distribution_number,a.distribution_time,a.plate_number,");
		sf.append("o.customer_address,o.number AS order_number,o.customer_name,o.customer_mobile");
		sf.append(" FROM crm_order_distribution a ");
		sf.append("LEFT JOIN crm_order o ON o.id= a.order_id  ");
		sf.append("WHERE a.site_id=? ");
		sf.append(getDistributionMap(map));
		sf.append(" ORDER BY create_time DESC  ");
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString(),siteId);
	}
	
	public long getDistributionCount(String siteId,Map<String,Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT COUNT(*) ");
		sf.append(" FROM crm_order_distribution a ");
		sf.append("LEFT JOIN crm_order o ON o.id= a.order_id  ");
		sf.append("WHERE a.site_id=? ");
		sf.append(getDistributionMap(map));
		return Db.queryLong(sf.toString(), siteId);
	}
	
	private  String getDistributionMap(Map<String,Object> map) {
		StringBuilder sf = new StringBuilder();
		if (StringUtil.checkParamsValid(map.get("distribution_number"))) {
			sf.append(" and a.distribution_number = '" + (map.get("distribution_number")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("order_number"))) {
			sf.append(" and o.number = '" + (map.get("order_number")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("customer_mobile"))) {
			sf.append(" and o.customer_mobile = '" + (map.get("customer_mobile")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("plate_number"))) {
			sf.append(" and a.plate_number = '" + (map.get("plate_number")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("driver_name"))) {
			sf.append(" and a.driver_name like '%" + (map.get("driver_name")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("customer_name"))) {
			sf.append(" and o.customer_name like '%" + (map.get("customer_name")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("distributionTimeMin"))) {// 录单时间
			sf.append(" and a.distribution_time >= '" + (map.get("distributionTimeMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("distributionTimeMax"))) {
			sf.append(" and a.distribution_time <= '" + (map.get("distributionTimeMax")) + " 23:59:59' ");
		}
		return sf.toString();
	}
}
