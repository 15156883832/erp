package com.jojowonet.modules.fmss.dao;

import org.springframework.stereotype.Repository;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

@Repository(value = "AccountDao")
public class AccountDao extends BaseDao<User> {

	public User getSiteByUserId(String id) {
		
		return getByHql("from crmAccount where user.id= :p1",
				new Parameter( id));
	}
	
}
