/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Township;

/**
 * 乡镇信息DAO接口
 * @author Ivan
 * @version 2018-01-20
 */
@Repository
public class TownshipDao extends BaseDao<Township> {
	
	public Boolean getCheckName(String siteId,String name){
		String sql = " SELECT id FROM crm_site_order_township a WHERE a.status='1' AND a.site_id=? AND a.name=?";
		Record rds = Db.findFirst(sql,siteId,name);
		if(rds != null){
			return true;
		}
		return false;
	}
	
	//修改信息
	 public void updates(String name, String sort, String id) {
	        String sql = "UPDATE crm_site_order_township SET name=? ,sort=? WHERE id=?";
	        Db.update(sql, name, sort, id);
	    }
	
	 public List<Record> getTownshipSiteId(String siteId){
		 String sql ="SELECT * FROM crm_site_order_township a WHERE a.site_id=? AND a.status='1' ";
		 return Db.find(sql,siteId);
	 }
}
