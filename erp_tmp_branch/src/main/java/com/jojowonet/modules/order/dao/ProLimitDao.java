package com.jojowonet.modules.order.dao;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.entity.ProLimit;

import ivan.common.persistence.BaseDao;

@Repository
public class ProLimitDao extends BaseDao<ProLimit> {
	
	public void updateProLimit(ProLimit proLimit){
		
		String sql="update crm_promise_limit set name = ?,sort = ? where id = ?";
		Db.update(sql,proLimit.getName(),proLimit.getSort(),proLimit.getId());
	}
	

}
