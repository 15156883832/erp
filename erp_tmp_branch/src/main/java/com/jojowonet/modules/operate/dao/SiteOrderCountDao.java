package com.jojowonet.modules.operate.dao;

import java.text.SimpleDateFormat;
import java.util.*;

import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.sys.db.DbKey;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.StringUtil;


/**
 * 工单数量统计DAO接口
 * 
 * @author yc
 * @version 2017-08-14
 */
@Repository
public class SiteOrderCountDao  extends BaseDao<Site>{
	
	public List<Record> siteList(Page<Record> page,Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT t.*,(SELECT COUNT(1) FROM `crm_order` AS o WHERE o.`site_id`=t.`id` ");
		sf.append(gettimeCondition(map));
		sf.append(") AS ordercount, ");
		sf.append("0 AS order400count, ");
		sf.append(" (SELECT m.name FROM `crm_area_manager` AS m WHERE m.id=t.`area_manager_id`) AS areamanager ");
		sf.append("  FROM crm_site t INNER JOIN sys_user AS u ");
		sf.append(" ON t.`user_id` =u.`id` AND u.`status` ='0' WHERE t.status!=1");
		sf.append(getCondition(map));
		//sf.append(page.getSqlOrderBy());
		sf.append(" ORDER BY t.`create_time` DESC ");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		List<Record> records = Db.find(sf.toString());
		fill400OrderCount(records, gettimeCondition(map));
		return records;
	}

	private void fill400OrderCount(List<Record> records, String cond) {
		List<String> idList = new ArrayList<>();
		Map<String, Record> mapper = new HashMap<>();
		for(Record r : records) {
			idList.add(r.getStr("id"));
			mapper.put(r.getStr("id"), r);
		}

		if (idList.size() > 0) {
			// ok
			SqlKit kit = new SqlKit().append("SELECT COUNT(1) as cnt,site_id FROM `crm_order_400` AS o WHERE o.`site_id` in(" + CrmUtils.joinInSql(idList) + ")").append(cond).last("group by o.site_id");
			List<Record> list = Db.use(DbKey.DB_ORDER_400).find(kit.toString());
			for (Record r : list) {
				String siteId = r.getStr("site_id");
				Record record = mapper.get(siteId);
				if (record != null) {
					record.set("order400count", r.getLong("cnt"));
				}
			}
		}
	}

	public long getListCount(Map<String,Object> map){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(t.id) FROM `crm_site` AS t INNER JOIN sys_user AS u ");
		sf.append(" ON t.`user_id` =u.`id` AND u.`status` ='0' ");
		sf.append("WHERE t.`status` !='1'  ");
		sf.append(getCondition(map));
		sf.append(" ORDER BY t.`create_time` DESC ");
		return Db.queryLong(sf.toString());
	}
	
	public String getCondition(Map<String,Object> map){
		StringBuffer sf = new StringBuffer();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowtime = sdf.format(now);
		if(StringUtil.checkParamsValid(map.get("name"))){
			sf.append(" and t.name like '%"+(map.get("name"))+"%' ");
		}
		if(StringUtil.checkParamsValid(map.get("version"))){
			if("1".equals(map.get("version"))){
				sf.append(" and t.due_time IS NULL or t.due_time < '"+nowtime+"' ");
			}else if("2".equals(map.get("version"))){
				sf.append(" and t.due_time IS NOT NULL and t.due_time >='"+nowtime+"' ");
			}else {
				sf.append("");
			}
		}
		if(StringUtil.checkParamsValid(map.get("area"))){
			sf.append(" and t.province like '%"+(map.get("area"))+"%' ");
		}
		


		return sf.toString();
	}
	
	
	private String gettimeCondition(Map<String, Object> map) {
		
		StringBuffer sf = new StringBuffer();
		 if(StringUtil.checkParamsValid(map.get("createTimemin"))){
				sf.append(" and o.repair_time >= '"+(map.get("createTimemin"))+" 00:00:00'  ");
			}
			 if(StringUtil.checkParamsValid(map.get("createTimemax"))){
				sf.append(" and o.repair_time <= '"+(map.get("createTimemax"))+" 23:59:59' ");
			}
		return sf.toString();
	}
}
