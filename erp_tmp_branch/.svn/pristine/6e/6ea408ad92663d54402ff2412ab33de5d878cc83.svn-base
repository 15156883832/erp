package com.jojowonet.modules.order.dao;

import java.util.List;
import java.util.Map;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SiteTeleDevice;

/**
 * 来电弹屏DAO接口
 * @author cdq
 * @version 2017-08-04
 */
@Repository
public class ViewManagerDao extends BaseDao<SiteTeleDevice>{

	
	//数据
	public List<Record> getViewList(Page<Record> page, Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT a.id,b.name,a.serial_no,a.create_time ");
		sf.append(" FROM crm_site_tele_device a ");
		sf.append(" LEFT JOIN  crm_site b ON a.site_id=b.id ");
		sf.append(" WHERE a.status='0' order by a.create_time desc ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
		List<Record> list = Db.find(sf.toString());
		return list;
	}
	
	//数量
	public Long getViewCount(){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*)  ");
		sf.append(" FROM crm_site_tele_device a ");
		sf.append(" LEFT JOIN  crm_site b ON a.site_id=b.id ");
		sf.append(" WHERE a.status='0' ");
		return Db.queryLong(sf.toString());
	}
	
}
