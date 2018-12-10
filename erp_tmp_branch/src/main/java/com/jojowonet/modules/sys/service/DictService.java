/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.service;

import ivan.common.dao.DictDao;
import ivan.common.entity.mysql.common.Dict;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.CacheUtils;
import ivan.common.utils.DictUtils;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 字典Service
 * @version 2013-5-29
 */
@Service(value="dictServiceET")
@Transactional(readOnly = true)
public class DictService extends BaseService {

	@Autowired
	private DictDao dictDao;
	
//	@Autowired
//	private MyBatisDictDao myBatisDictDao;
	
	public Dict get(String id) {
		// MyBatis 查询
//		return myBatisDictDao.get(id);
		// Hibernate 查询
		return dictDao.get(id);
	}
	
	public Page<Dict> find(Page<Dict> page, Dict dict) {
		// MyBatis 查询
//		dict.setPage(page);
//		page.setList(myBatisDictDao.find(dict));
//		return page;
		// Hibernate 查询
		DetachedCriteria dc = dictDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(dict.getType())){
			dc.add(Restrictions.eq("type", dict.getType()));
		}
		if (StringUtils.isNotEmpty(dict.getDescription())){
			dc.add(Restrictions.like("description", "%"+dict.getDescription()+"%"));
		}
		dc.add(Restrictions.eq("status", Dict.DEL_FLAG_NORMAL));
		dc.addOrder(Order.asc("type")).addOrder(Order.asc("sort")).addOrder(Order.desc("id"));
		return dictDao.find(page, dc);
	}
	
	public List<String> findTypeList(){
		return dictDao.findTypeList();
	}
	
	@Transactional(readOnly = false)
	public void save(Dict dict) {
		dictDao.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		dictDao.deleteById(id);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
}
