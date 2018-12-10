/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SiteSuperviseSetting;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

/**
 * 监督事项信息DAO接口
 * @author Ivan
 * @version 2018-04-19
 */
@Repository
public class SiteSuperviseSettingDao extends BaseDao<SiteSuperviseSetting> {
	
	public void updateStatus(String id) {
		String sql ="UPDATE crm_site_supervise_setting SET status = '1' WHERE id = ?";
		Db.update(sql,id);
	}
	
	public List<Record> getsupervisePage(Page<Record> page,String siteId){
		StringBuilder sf = new StringBuilder();
		
		sf.append(" SELECT * FROM crm_site_supervise_setting a ");
		sf.append(" WHERE a.site_id = '0' AND NOT EXISTS ");
		sf.append(" ( ");
		sf.append(" 	SELECT b.* FROM crm_site_supervise_setting b, crm_site si ");
		sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
		sf.append(" 	) ");
		sf.append(" UNION ");
		sf.append(" SELECT b.* FROM crm_site_supervise_setting b, crm_site si ");
		sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? ");
		
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString(),siteId,siteId);
	}
	public long getsuperviseCount(String siteId){
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT COUNT(*) FROM ( ");
		sf.append(" SELECT * FROM crm_site_supervise_setting a ");
		sf.append(" WHERE a.site_id = '0' AND NOT EXISTS ");
		sf.append(" ( ");
		sf.append(" 	SELECT b.* FROM crm_site_supervise_setting b, crm_site si ");
		sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
		sf.append(" 	) ");
		sf.append(" UNION ");
		sf.append(" SELECT b.* FROM crm_site_supervise_setting b, crm_site si ");
		sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? ");
		sf.append(" ) a  ");
		return Db.queryLong(sf.toString(),siteId,siteId);
	}
	
}
