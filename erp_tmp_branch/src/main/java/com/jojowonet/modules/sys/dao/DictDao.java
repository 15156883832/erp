/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.dao;

import ivan.common.entity.mysql.common.Dict;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

import java.util.List;

import org.springframework.stereotype.Repository;


/**
 * 字典DAO接口
 * @version 2013-8-23
 */
@Repository(value="dictDaoET")
public class DictDao extends BaseDao<Dict> {

	public List<Dict> findAllList(){
		return find("from Dict where status=:p1 order by sort", new Parameter(Dict.DEL_FLAG_NORMAL));
	}

	public List<String> findTypeList(){
		return find("select type from Dict where status=:p1 group by type", new Parameter(Dict.DEL_FLAG_NORMAL));
	}
}
