/**
 */
package com.jojowonet.modules.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.order.entity.SiteSuperviseSetting;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.SiteSuperviseSettingDao;

/**
 * 监督事项信息Service
 * @author Ivan
 * @version 2018-04-19
 */
@Component
@Transactional(rollbackFor=Exception.class) 
public class SiteSuperviseSettingService extends BaseService {

	@Autowired
	private SiteSuperviseSettingDao siteSuperviseSettingDao;
	
	public SiteSuperviseSetting get(String id) {
		return siteSuperviseSettingDao.get(id);
	}
	
	public Page<Record> find(Page<Record> page,String siteId) {
		page.setList(siteSuperviseSettingDao.getsupervisePage(page, siteId));
		page.setCount(siteSuperviseSettingDao.getsuperviseCount(siteId));
		return page;
	}
	
	
	public void save(SiteSuperviseSetting siteSuperviseSetting) {
		siteSuperviseSettingDao.save(siteSuperviseSetting);
	}
	
	
	public void delete(String[] idArr,String siteId,String userId) {
		 for(int j=0;j<idArr.length;j++){
			 SiteSuperviseSetting ses = siteSuperviseSettingDao.get(idArr[j]);
			 if("0".equals(ses.getSiteId())) {
				 SiteSuperviseSetting sites = new SiteSuperviseSetting();
				 sites.setParentId(ses.getId());
				 sites.setName(ses.getName());
				 sites.setSiteId(siteId);
				 sites.setStatus("1");
				 sites.setCreateBy(userId);
				 siteSuperviseSettingDao.save(sites);
			 }else {
				 siteSuperviseSettingDao.updateStatus(idArr[j]);
			 }
	        }
		
	}

	
}
