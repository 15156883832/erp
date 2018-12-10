/**
 */
package com.jojowonet.modules.operate.dao;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.operate.entity.SiteDriver;

import ivan.common.persistence.BaseDao;

/**
 * 司机信息DAO接口
 * @author lzp
 * @version 2018-10-31
 */
@Repository
public class SiteDriverDao extends BaseDao<SiteDriver> {
	
	public boolean getCheckNumber(String siteId,String name) {
		String sql = "SELECT COUNT(*) FROM crm_site_driver WHERE site_id=? AND driver_name=?";
		long count = Db.queryLong(sql, siteId,name);
		if(count >0) {
			return true;
		}
		return false;
	}
	
	public void deleteSiteDriver(String id) {
		String sql ="DELETE FROM crm_site_driver WHERE id = ?";
		Db.update(sql,id);
	}
}
