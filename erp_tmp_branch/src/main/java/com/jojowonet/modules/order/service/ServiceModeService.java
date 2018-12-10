package com.jojowonet.modules.order.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.ServiceModeDao;
import com.jojowonet.modules.order.entity.ServiceMode;
import com.jojowonet.modules.order.utils.CrmUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

@Component
@Transactional(rollbackFor=Exception.class)
public class ServiceModeService extends BaseService {
	
	@Autowired
	private ServiceModeDao serviceModeDao;
	
	public ServiceMode get(Integer id) {
		return serviceModeDao.get(id);
	}
	
   public Page<ServiceMode> find(Page<ServiceMode> page, ServiceMode serviceMode) {
		DetachedCriteria dc = serviceModeDao.createDetachedCriteria();
		if (StringUtils.isNotBlank(serviceMode.getName())){
			dc.add(Restrictions.like("name", "%"+serviceMode.getId()+"%"));
		}
		dc.add(Restrictions.eq("status", "0"));
		dc.add(Restrictions.eq("siteId", "0"));
		dc.addOrder(Order.asc("sort"));
		
		return serviceModeDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public void save(ServiceMode serviceMode) {
		//orderOriginDao.clear();
		if("1".equals(serviceMode.getIsDefault())) {
			//删除其他默认选项
			Db.update(" UPDATE crm_service_mode  SET is_default = '0' WHERE site_id = ? ",serviceMode.getSiteId());
		}

		serviceModeDao.save(serviceMode);
		
			
	}
	
	@Transactional(readOnly = false)
	public void delete(Integer id) {
	
		serviceModeDao.deleteByIds(id);
	}
	
	public List<Record> filterServiceMode() {
		return serviceModeDao.filterServiceMode(null);
	}
	/*服务商自定义添加服务方式使用*/
	public boolean sitequeryNumByName(String name,String siteId,Integer id){
		StringBuilder sf = new StringBuilder();
		sf.append("select * from crm_service_mode where  name = ? and status='0' and site_id= ? ");
		if(id != null) {
			sf.append(" and id !="+id+" ");
		}
		//List<Record> list = Db.find(sf.toString(),name,siteId);
		long count = serviceModeDao.getNewServiceModeCount(siteId,name,id);
		if (count>0) {
			return true;}
		return false;
	}
	
	public boolean queryNumByName(String name){
		List list = serviceModeDao.createSqlQuery("select * from crm_service_mode"
				+ " where  name = :p1 and status='0' ",new Parameter(name)).list();
		if (list.size()>0)
			return true;
		return false;
	}

	public Record getServiceModeById(Integer id) {
     Record rd=serviceModeDao.getServiceModeById(id);
		return rd;
	}
	@Transactional(rollbackFor=Exception.class)
	public void siteupdates(String name, String sort, Integer id,String isDefault) {
		if(StringUtils.isBlank(sort)) {
			sort ="0";
		}
		ServiceMode seMode = serviceModeDao.get(id);
		if("1".equals(isDefault)) {
			User user =UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			//删除其他默认选项
			Db.update(" UPDATE crm_service_mode  SET is_default = '0' WHERE site_id = ? ",siteId);
		}
		 if("0".equals(seMode.getSiteId())) {
			 User user = UserUtils.getUser();
			 String siteId = CrmUtils.getCurrentSiteId(user);
			 //将系统和默认的转变成自定义的
			 ServiceMode sites = new ServiceMode();
			 sites.setParentId(seMode.getId().toString());
			 sites.setName(seMode.getName());
			 sites.setSiteId(siteId);
			 sites.setStatus("1");
			 sites.setCreate_by(user.getId());
			 serviceModeDao.save(sites);
			 ServiceMode sitenew = new ServiceMode();
			 sitenew.setName(name);
			 sitenew.setSort(Integer.valueOf(sort));
			 sitenew.setIsDefault(isDefault);
			 sitenew.setSiteId(siteId);
			 sitenew.setCreate_by(user.getId());
			 serviceModeDao.save(sitenew);
		 }else {
			 seMode.setName(name);
			 seMode.setSort(Integer.valueOf(sort));
			 seMode.setIsDefault(isDefault);
			 //serviceModeDao.save(seMode);
		 }
	}


	public void updates(String name, String sort, Integer id) {
		serviceModeDao.updates(name,sort,id);
		
	}

	public boolean queryNumByNames(String names,Integer id){
		List list = serviceModeDao.createSqlQuery("select * from crm_service_mode"
				+ " where name = :p1 and id!=:p2 and status='0' ",new Parameter(names,id)).list();
		if (list.size()>0)
			return false;
		return true;
	}
	/*服务商自定义*/
	public Page<Record> getServiceModePage(Page<Record> page ,String siteId){
		List<Record> list = serviceModeDao.getNewServiceMode(page, siteId);
		long count = serviceModeDao.getNewServiceModeCount(siteId,"",null);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	/*服务商删除服务方式*/
	@Transactional(rollbackFor=Exception.class)
	public void siteDelete(Integer id) {
		ServiceMode seMode = serviceModeDao.get(id);
		 if("0".equals(seMode.getSiteId())) {
			 User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			 ServiceMode sites = new ServiceMode();
			 sites.setParentId(seMode.getId().toString());
			 sites.setName(seMode.getName());
			 sites.setSiteId(siteId);
			 sites.setStatus("1");
			 sites.setCreate_by(user.getId());
			 serviceModeDao.save(sites);
		 }else {
			 seMode.setStatus("1");
			 //serviceModeDao.save(seMode);
		 }

	}
	public List<Record> getnewSiteServiceMode(String siteId) {
		return serviceModeDao.getNewServiceMode(null, siteId);
	}
}
