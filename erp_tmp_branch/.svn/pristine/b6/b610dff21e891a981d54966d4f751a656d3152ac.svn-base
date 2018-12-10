package com.jojowonet.modules.order.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;













import com.jfinal.plugin.activerecord.Db;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.SysSettleDao;
import com.jojowonet.modules.order.entity.sysSettle;



@Component
@Transactional(readOnly = true)
public class SysSettleService extends BaseService {
	@Autowired
	private SysSettleDao sysSettleDao;
	

	public Page<Record> getlistSys(Page<Record> page,String siteId){
        List<Record> list =sysSettleDao.getsettngList(page,siteId);
        long count = sysSettleDao.getListcount(siteId);
        page.setCount(count);
        page.setList(list);
		return page;
	}


	public void save(sysSettle sys) {
		sysSettleDao.save(sys);
		
	}
	@Transactional(readOnly = false)
	public List<Record> querysettletype() {
return sysSettleDao.querysettletype();

	}


	@Transactional(readOnly = false)
	public void deletesettle(String id) {
		sysSettleDao.deletesettle(id);
	}
	@Transactional(readOnly = false)
	public void updatesettle(String id) {
		sysSettleDao.updatesettle(id);
	}


	@Transactional(readOnly = false)
	public void updatesettles(String id) {
		sysSettleDao.updatesettles(id);
	}


	public String getSiteSettleFlag(String siteId) {
		Record rd = sysSettleDao.getSiteSettleFlag(siteId); 
		return rd == null ? "1" : rd.getStr("figure");
		
	}


}
