package com.jojowonet.modules.operate.dao;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.ReceivedSms;



@Repository
public class ReceivedSmsDao extends BaseDao<ReceivedSms> {
	
//分页查询数据
	public List<Record> getReceivedList(Page<Record> page ,String siteId,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM crm_received_sms");
		sf.append(" WHERE site_id=? AND status='0'");
		sf.append(getCondition(map,siteId));
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString(), siteId);
		
	}	
	public long getreceivedcount(String siteId,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(*) FROM crm_received_sms");
		sf.append(" WHERE site_id=? AND status='0'");
		sf.append(getCondition(map,siteId));
		return Db.queryLong(sf.toString(), siteId);
	}
	//获得查询条件
	public String getCondition(Map<String,Object> map,String siteId){
		StringBuffer sf = new StringBuffer();
		if(map != null){
			if (map.get("content") != null && StringUtils.isNotEmpty(((String[])map.get("content"))[0])){
				sf.append(" and content='"+(((String[])map.get("content"))[0])+"'");
			}
			if(map.get("mobile") != null && StringUtils.isNotEmpty(((String[])map.get("mobile"))[0])){
				sf.append(" and mobile like '%"+(((String[])map.get("mobile"))[0]).trim()+"%'");
			}
			 if(map.get("receivedTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("receivedTimeMin"))[0])){//接入时间
					sf.append(" and send_time >= '"+((String[]) map.get("receivedTimeMin"))[0]+" 00:00:00' ");
				}
				 if(map.get("receivedTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("receivedTimeMax"))[0])){
					sf.append(" and send_time <= '"+((String[]) map.get("receivedTimeMax"))[0]+" 23:59:59' ");
				}
			
		}
		 return sf.toString();
	}

}
