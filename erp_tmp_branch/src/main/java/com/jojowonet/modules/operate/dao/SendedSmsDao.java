package com.jojowonet.modules.operate.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.SendedSms;
import com.jojowonet.modules.order.dao.OrderDao;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Repository
public class SendedSmsDao extends BaseDao<SendedSms> {
	
	@Autowired
	private OrderDao orderDao;
	//查询所有发送短信（分页）
	public List<Record> getSendedList(Page<Record> page ,String siteId,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT a.* FROM crm_sended_sms a  ");
		sf.append(" WHERE a.site_id=?");
		sf.append(getCondition(map,siteId));
		if(page.getSqlOrderBy()!=null&&!"".equals(page.getSqlOrderBy())){
			sf.append(page.getSqlOrderBy());
		}else{
			sf.append(" ORDER BY a.send_time DESC ");
		}
		
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
	
		return Db.find(sf.toString(), siteId);
		
	}
	//查询所有发送短信（不分页）
	public List<Record> getSendedListforexcel(String siteId,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM crm_sended_sms");
		sf.append(" WHERE site_id=?");
		sf.append(getCondition(map,siteId));
		return Db.find(sf.toString(), siteId);
		
	}
	
	public long getsendedcount(String siteId,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT count(*) FROM crm_sended_sms a ");
		sf.append(" WHERE a.site_id=?");
		sf.append(getCondition(map,siteId));
		return Db.queryLong(sf.toString(), siteId);
	}
	//查询条件控制
	public String getCondition(Map<String,Object> map,String siteId){
		StringBuffer sf = new StringBuffer();
		if(map != null){
			if (map.get("orderNum") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("orderNum"))[0])){
				sf.append(" and a.order_number like '%"+(((String[])map.get("orderNum"))[0]).trim()+"%'");
			}
			if(map.get("mobile") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("mobile"))[0])){
				sf.append(" and a.mobile like '%"+(((String[])map.get("mobile"))[0]).trim()+"%'");
				//sf.append(" and (o.customer_mobile like '%"+((String[])map.get("customerMobile"))[0]+"%') ");
			}
			if (map.get("type") != null && StringUtils.isNotEmpty((CharSequence)((String[])map.get("type"))[0])){
				sf.append(" and a.type='"+(((String[])map.get("type"))[0])+"'");
			}
			 if(map.get("sendTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("sendTimeMin"))[0])){//接入时间
					sf.append(" and a.send_time >= '"+(((String[]) map.get("sendTimeMin"))[0]).trim()+" 00:00:00' ");
				}
				 if(map.get("sendTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("sendTimeMax"))[0])){
					sf.append(" and a.send_time <= '"+(((String[]) map.get("sendTimeMax"))[0]).trim()+" 23:59:59' ");
				}
			
		}
		 return sf.toString();
	}

}
