package com.jojowonet.modules.sys.dao;

import ivan.common.entity.mysql.common.UserRoleEntity;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.google.common.collect.Lists;


@Repository
public class UserRoleDao extends BaseDao<UserRoleEntity> {

	public Long getRoleIdByUserId(Long userId)
	{
		Long roleId = Long.MIN_VALUE;
		
		UserRoleEntity userRoleEntity = getByHql("from UserRoleEntity where user_id=:p1",new Parameter(String.valueOf(userId)));
		
		if(userRoleEntity != null)
		{
			String roleIdStr = userRoleEntity.getRole_id();
			try
			{
				roleId = Long.valueOf(roleIdStr);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return roleId;
	}
	
	public List<Long> getRoleIdsByUserId(Long userId)
	{
		List<Long> roleIds = Lists.newArrayList();
		Query query = createQuery(
				"select role_id from UserRoleEntity where user_id=:p1",
				new Parameter(String.valueOf(userId)));
		@SuppressWarnings("unchecked")
		Iterator<String> it = query.iterate();
		while(it.hasNext())
		{
			String roleIdStr = it.next();
			try
			{
				roleIds.add(Long.valueOf(roleIdStr));
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return roleIds;
	}
}
