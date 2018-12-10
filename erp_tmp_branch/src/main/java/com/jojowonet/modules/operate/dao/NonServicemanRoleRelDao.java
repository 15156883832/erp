package com.jojowonet.modules.operate.dao;

import ivan.common.entity.mysql.common.Role;
import ivan.common.persistence.BaseDao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.NonServicemanRoleRel;

/**
 * 关系表DAO接口
 * @author Ivan
 * @version 2017-06-12
 */
@Repository
public class NonServicemanRoleRelDao extends BaseDao<NonServicemanRoleRel>{
	
	public List<Role> getPcRole(){
		List<Role> pcRole = find("from Role a where a.id = '4' ");
		return pcRole;
	}
	
	public List<Role> getEmpRole(){
		List<Role> empRole = find("from Role a where a.id = '8' ");
		return empRole;
	}
	
	/**
	 * @param siteId
	 * @param defaultRoleId:1/2/3
	 * @return
	 */
	public Record getDefaultNonmanRoleRelIdInSitePermission(String siteId, String defaultRoleId){
		return Db.findFirst(" select * from crm_site_role_permission a where a.sys_role_id = ? and a.site_id = ? ", defaultRoleId, siteId);
	}
}
