/**
 */
package com.jojowonet.modules.order.dao;

import ivan.common.persistence.BaseDao;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Printdesign;

/**
 * 打印信息DAO接口
 * @author Ivan
 * @version 2017-11-06
 */
@Repository
public class PrintdesignDao extends BaseDao<Printdesign> {
	
	public Record getPrintde(String siteId){
		String sql = "SELECT * FROM crm_printdesign WHERE site_id=?  ";
		return Db.findFirst(sql,siteId);
	}
	
	public Record getPrintdeState(String siteId){
		String sql = "SELECT * FROM crm_printdesign WHERE site_id=?  and  state = '1' ";
		return Db.findFirst(sql,siteId);
	}
	
}
