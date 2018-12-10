package com.jojowonet.modules.operate.dao;

import java.util.List;
import java.util.Map;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.SiteAddtimeRecord;
import com.jojowonet.modules.order.utils.StringUtil;


/**
 * 服务商添加时间DAO接口
 * 
 * @author yc
 * @version 2017-08-14
 */
@Repository
public class SiteAddtimeRecordDao extends BaseDao<SiteAddtimeRecord> {
	public List<Record> getlist(Page<Record> page ,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("select a.* , b.name as name ,b.contacts as contacts ,b.telephone as telephone ,b.address as address  ");
		sf.append(" from crm_site_addtime_record as a left join crm_site as b on a.site_id=b.id where a.site_id is not null");
		sf.append(getCondition(map));
		sf.append(" order by create_time desc");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString());
	}
	
	public long getListCount(Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(a.id)  FROM crm_site_addtime_record  a LEFT JOIN crm_site  b ON a.site_id=b.id WHERE a.site_id IS NOT NULL");
		sf.append(getCondition(map));
		return Db.queryLong(sf.toString());
	}

	public String getCondition(Map<String,Object> map){
		StringBuffer sf = new StringBuffer();
		if(StringUtil.checkParamsValid(map.get("name"))){
			sf.append(" and b.name like '%"+(map.get("name"))+"%' ");
		}

		if (StringUtil.checkParamsValid(map.get("telephone"))){
			sf.append(" and b.telephone like '%"+(map.get("telephone"))+"%' ");
		}


		 if(StringUtil.checkParamsValid(map.get("createTimemin"))){
				sf.append(" and a.create_time >= '"+(map.get("createTimemin"))+" 00:00:00'  ");
			}
			 if(StringUtil.checkParamsValid(map.get("createTimemax"))){
				sf.append(" and a.create_time <= '"+(map.get("createTimemax"))+" 23:59:59' ");
			}
		return sf.toString();
	}

}
