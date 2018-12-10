/**
 */
package com.jojowonet.modules.order.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.order.entity.CustomerType;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.dao.CustomerTypeDao;

/**
 * 用户类型Service
 * @author lzp
 * @version 2018-07-18
 */
@Component
@Transactional(readOnly = true)
public class CustomerTypeService extends BaseService {

	@Autowired
	private CustomerTypeDao customerTypeDao;
	
	public CustomerType get(String id) {
		return customerTypeDao.get(id);
	}
	
	public Page<CustomerType> find(Page<CustomerType> page, CustomerType customerType,String siteId) {
		DetachedCriteria dc = customerTypeDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(customerType.getId())){
			dc.add(Restrictions.like("name", "%"+customerType.getId()+"%"));
		}
		dc.add(Restrictions.eq("status", "0"));
		dc.add(Restrictions.eq("siteId", siteId));
		dc.addOrder(Order.desc("createTime"));
		return customerTypeDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public void save(CustomerType customerType) {
		customerTypeDao.save(customerType);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		customerTypeDao.deleteById(id);
	}
	
	public boolean sitequeryNumByName(String name,String siteId,String id){
		StringBuilder sf = new StringBuilder();
		sf.append("select count(*) from crm_site_customer_type where  name = ? and status='0' and site_id= ? ");
		if(StringUtils.isNotBlank(id)) {
			sf.append(" and id !='"+id+"' ");
		}
		long count = Db.queryLong(sf.toString(),name,siteId);
		return count>0;
	}

	public void siteupdates(String names, String id) {
		CustomerType type = customerTypeDao.get(id);
		type.setName(names);
	}
}
