package com.jojowonet.modules.order.service;

import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.order.dao.ProLimitDao;
import com.jojowonet.modules.order.entity.ProLimit;

@Component
@Transactional(readOnly = true)
public class ProLimitService extends BaseService {
	
	@Autowired
	private ProLimitDao proLimitDao;
	
	public ProLimit get(String id) {
		return proLimitDao.get(Integer.parseInt(id));
	}

	public Page<ProLimit> find(Page<ProLimit> page){
		DetachedCriteria dc = proLimitDao.createDetachedCriteria();
		dc.add(Restrictions.eq("status", "0"));
		//dc.add(Restrictions.eq("delFlag", "0"));
		dc.addOrder(Order.asc("sort"));
		return proLimitDao.find(page, dc);
		
	}
	
	@Transactional(readOnly = false)
	public void save(ProLimit proLimit){
		if(proLimit.getId()==null){
			proLimitDao.save(proLimit);
		}else{
			proLimitDao.updateProLimit(proLimit);
		}
		
	}
	
	@Transactional(readOnly = false)
	public void delete(String id){
		
		proLimitDao.deleteById(Integer.parseInt(id));
	}
	public boolean queryNumByName(String name){
		List list = proLimitDao.createSqlQuery("select * from crm_promise_limit"
				+ " where name = :p1",new Parameter(name)).list();
		if (list.size()>0)
			return false;
		return true;
	}
	
}
