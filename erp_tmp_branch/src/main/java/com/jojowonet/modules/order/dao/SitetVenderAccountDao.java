package com.jojowonet.modules.order.dao;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.entity.SiteVenderAccount;

import ivan.common.persistence.BaseDao;

@Repository(value = "SitetVenderAccountDao")
public class SitetVenderAccountDao extends BaseDao<SiteVenderAccount>{
	
	public Long getCount(String siteId){
		return Db.queryLong("SELECT count(*) FROM crm_site_vender_account WHERE status='0' AND site_id='"+siteId+"'");
	}

}
