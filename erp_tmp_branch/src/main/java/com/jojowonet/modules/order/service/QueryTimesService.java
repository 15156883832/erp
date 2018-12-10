/**
 */
package com.jojowonet.modules.order.service;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.QueryTimes;
import com.jojowonet.modules.order.dao.QueryTimesDao;

/**
 * 查询信息Service
 * @author Ivan
 * @version 2017-11-02
 */
@Component
@Transactional(readOnly = true)
public class QueryTimesService extends BaseService {

	@Autowired
	private QueryTimesDao queryTimesDao;
	
	public QueryTimes get(String id) {
		return queryTimesDao.get(id);
	}
	
	
	@Transactional(readOnly = false)
	public void save(QueryTimes queryTimes) {
		queryTimesDao.save(queryTimes);
	}
	
	@Transactional
	public void updateCount(String name,String siteId){
		queryTimesDao.updateCount(name, siteId);
	}
	
	public Page<Record> find(Page<Record> page) {
		page.setList(queryTimesDao.getqueryList(page));
		page.setCount(queryTimesDao.getQueryCount());
		return page;
	}
	public Record getSum(){
		return queryTimesDao.getSum();
	}
	
}
