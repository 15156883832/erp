/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.dao;

import ivan.common.entity.mysql.common.Role;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

import org.springframework.stereotype.Repository;


/**
 * 角色DAO接口
 * @version 2013-8-23
 */
@Repository(value="roleDaoET")
public class RoleDao extends BaseDao<Role> {

	public Role findByName(String name){
		return getByHql("from Role where status = :p1 and name = :p2", new Parameter(Role.DEL_FLAG_NORMAL, name));
	}

//	@Query("from Role where status='" + Role.DEL_FLAG_NORMAL + "' order by name")
//	public List<Role> findAllList();
//
//	@Query("select distinct r from Role r, User u where r in elements (u.roleList) and r.status='" + Role.DEL_FLAG_NORMAL +
//			"' and u.status='" + User.DEL_FLAG_NORMAL + "' and u.id=?1 or (r.user.id=?1 and r.status='" + Role.DEL_FLAG_NORMAL +
//			"') order by r.name")
//	public List<Role> findByUserId(Long userId);

}
