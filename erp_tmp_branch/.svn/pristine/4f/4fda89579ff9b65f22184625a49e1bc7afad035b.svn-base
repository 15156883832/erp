/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.dao;

import ivan.common.entity.mysql.common.Dict;
import ivan.common.entity.mysql.common.Menu;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

import java.util.List;

import org.springframework.stereotype.Repository;

/**
 * 菜单DAO接口
 * @version 2013-8-23
 */
@Repository(value="menuDaoET")
public class MenuDao extends BaseDao<Menu> {
	
	public List<Menu> findAllActivitiList() {
		return find("from Menu where status=:p1 and isActiviti = :p2 order by sort",new Parameter(Dict.DEL_FLAG_NORMAL,Menu.YES));
	}
	
	public List<Menu> findByParentIdsLike(String parentIds){
		return find("from Menu where parentIds like :p1", new Parameter(parentIds));
	}

	public List<Menu> findAllList(){
		return find("from Menu where status=:p1 order by sort", new Parameter(Dict.DEL_FLAG_NORMAL));
	}
	
	public List<Menu> findByUserId(String userId){
		return find("select distinct m from Menu m, Role r, User u where m in elements (r.menuList) and r in elements (u.roleList)" +
				" and m.status=:p1 and r.status=:p1 and u.status=:p1 and u.id=:p2" + // or (m.user.id=:p2  and m.status=:p1)" + 
				" order by m.sort", new Parameter(Menu.DEL_FLAG_NORMAL, userId));
	}
	public List<Menu> findAllActivitiList(String userId) {
		return find("select distinct m from Menu m, Role r, User u where m in elements (r.menuList) and r in elements (u.roleList)" +
				" and m.status=:p1 and r.status=:p1 and u.status=:p1 and m.isActiviti=:p2 and u.id=:p3 order by m.sort", 
				new Parameter(Menu.DEL_FLAG_NORMAL, Menu.YES,userId));
	}
	
}
