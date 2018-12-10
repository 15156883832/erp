package com.jojowonet.modules.order.service;

import java.util.List;
import java.util.Map;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.SiteAlarmDao;
import com.jojowonet.modules.order.entity.SiteAlarm;
/**
 * 预警消息service层
 * @author yc
 * @version 2017-06-15
 */

@Component
@Transactional(readOnly = true)
public class SiteAlarmService  extends BaseService{
	@Autowired
	private SiteAlarmDao  siteAlarmDao;

	public List<Record> getAlarmlist(String siteId){
		List<Record> alarmlist=siteAlarmDao.getAlarmlist(siteId);
		return alarmlist;
	}
	
	public SiteAlarm getSiteAlarm(String id ) {
		SiteAlarm sitea =siteAlarmDao.get(id);
		sitea.setStatus("1");
		siteAlarmDao.save(sitea);
		return sitea;
	}
	
	public Long queryEmployeCount(String siteId){
		return siteAlarmDao.queryEmployeCount(siteId);
	}
	
	public Long queryFinishedCount(String siteId){
		return siteAlarmDao.queryFinishedCount(siteId);
	}
	
	public Long queryStoreCount(String siteId){
		return siteAlarmDao.queryStoreCount(siteId);
	}
	
	public Long queryShortCount(String siteId){
		return siteAlarmDao.queryShortCount(siteId);
	}
	
	public Page<Record> getAlarmDetailList(Page<Record> page,String siteId, Map<String,Object> map){
		List<Record> records= siteAlarmDao.getAlarmDetailList(page,siteId,map);
		Long count = siteAlarmDao.queryCount(siteId,map);
		page.setCount(count);
		page.setList(records);
		return page;
	}
	
	public  String cancelAlarm(String rowId){
		return siteAlarmDao.cancelAlarm(rowId);
	}
	
	public  String isTop(String rowId,String isTop){
		return siteAlarmDao.isTop(rowId,isTop);
	}

	public String isFlag(String rowId, String isflag) {
		return siteAlarmDao.isFlag(rowId,isflag);
	}

	public boolean plcancelAlarm(String ids) {
		 return siteAlarmDao.plcancelAlarm(ids);
		
	}
//批量标记
	public boolean  plflag(String ids) {
		 return siteAlarmDao.pltop(ids);
		
		
	}
	//批量取消标记
	public boolean plcancelflag(String ids) {
		return siteAlarmDao.plcanceltop(ids);
		 
		
	}
}