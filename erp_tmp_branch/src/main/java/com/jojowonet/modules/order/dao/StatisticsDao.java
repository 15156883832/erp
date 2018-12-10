/**
 */
package com.jojowonet.modules.order.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Statistics;
import com.jojowonet.modules.order.utils.StringUtil;

/**
 * 统计信息DAO接口
 * @author Ivan
 * @version 2018-01-03
 */
@Repository
public class StatisticsDao extends BaseDao<Statistics> {

	public List<Record> getStatisticsDaoList(Page<Record> page,
			Map<String, Object> map,String priname) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT a.* ,s.share_code_site_parent_id,s.name ,s.area_manager_id,s.address,s.area,s.city,s.province,s.due_time,s.share_code,s.mobile,s.create_time,  ");
		sf.append(" (SELECT m.name FROM `crm_area_manager` AS m WHERE m.id=s.`area_manager_id`) AS areamanager ");
		sf.append(" FROM crm_site s ");
		sf.append(" LEFT JOIN crm_use_statistics a  ON s.id= a.site_id ");
		sf.append(" WHERE s.status!= '1' ");
		sf.append(getOrderCondition(map));
		if(StringUtil.isNotEmpty(priname)){
			String[] pname = priname.split(","); 
			sf.append(" AND s.province in("+StringUtil.joinInSql(pname)+")");
		}
		sf.append(createOrderBy(map," "));
		if(page != null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public long getStatisticsDaoCount(Map<String, Object> map,String priname) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT count(*) as count ");
		sf.append(" FROM crm_site s ");
		sf.append(" LEFT JOIN crm_use_statistics a  ON s.id= a.site_id ");
		sf.append(" WHERE s.status!= '1' ");
		sf.append(getOrderCondition(map));
		if(StringUtil.isNotEmpty(priname)){
			String[] pname = priname.split(","); 
			sf.append(" AND s.province in("+StringUtil.joinInSql(pname)+")");
		}
		return Db.queryLong(sf.toString());
	}
	
	public List<Record> getstatisticsDetailedList(String id){
		StringBuilder sf = new StringBuilder();
		
		sf.append("SELECT a.*,s.login_name FROM crm_use_statistics_detailed a ");
		sf.append(" LEFT JOIN sys_user s ON s.id=a.user_id AND s.user_type='1' ");
		sf.append(" WHERE a.site_id=? ORDER BY a.create_time DESC ");
	//	String sql ="SELECT * FROM crm_use_statistics_detailed WHERE site_id=? ORDER BY create_time DESC ";
		return Db.find(sf.toString(),id);
	}
	
	public Record getStatisticsById(String id){
		StringBuilder sf = new StringBuilder();
		
		sf.append("SELECT a.id ,a.site_id,a.login_name,a.share_site,a.follow_up_method,a.usage,a.contact_results,a.purchase_time,a.promise_time,a.update_time,a.follow_up_detailed,s.create_time,s.due_time, ");
		sf.append("s.name FROM crm_use_statistics a ");
		sf.append("LEFT JOIN crm_site s ON s.id= a.site_id AND s.status != '1' WHERE a.site_id=? ");
		return Db.findFirst(sf.toString(),id);
	}
	
	public void update(Statistics sta){
		StringBuilder sf = new StringBuilder();
		sf.append("UPDATE crm_use_statistics a ");
		sf.append("SET ");
		if(sta.getPromiseTime() != null){
			sf.append("a.promise_time = '"+DateUtils.formatDate(sta.getPromiseTime(), "yyyy-MM-dd HH:mm:ss")+"' , ");
		}
		sf.append(" a.usage = '"+sta.getUsage()+"' , share_site = '"+sta.getShareSite()+"' ,a.contacts='"+sta.getContacts()+"', ");
		sf.append("follow_up_method = '"+sta.getFollowUpMethod()+"' , follow_up_detailed = '"+sta.getFollowUpDetailed()+"' , ");
		sf.append("contact_results = '"+sta.getContactResults()+"' , update_time = '"+DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"' ");
		sf.append(" WHERE id = '"+sta.getId()+"' ");
		Db.update(sf.toString());
	}
	
	public void insetoDet(String useId,Statistics det,String ded){
		StringBuilder sf = new StringBuilder();
		sf.append(" INSERT INTO crm_use_statistics_detailed ");
		sf.append(" (id, user_id,site_id, follow_up_detailed, create_time,follow_up_method,usages,contact_results,newly_added)");
		sf.append(" VALUES('"+IdGen.uuid()+"', '"+useId+"','"+det.getSiteId()+"', '"+det.getFollowUpDetailed()+"', '"+DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")+"'");
		sf.append(",'"+det.getFollowUpMethod()+"', '"+det.getUsage()+"','"+det.getContactResults()+"','"+ded+"')");
		Db.update(sf.toString());
	}
	
	

	//条件
	public String getOrderCondition(Map<String,Object> map){
		StringBuffer sf = new StringBuffer();
		if(StringUtil.checkParamsValid(map.get("name"))){
			sf.append(" and s.name like '%"+(map.get("name"))+"%' ");
		}
		if(StringUtil.checkParamsValid(map.get("province"))){
			sf.append(" and s.province = '"+(map.get("province"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("usage"))){
			sf.append(" and a.usage like '%"+(map.get("usage"))+"%' ");
		}
		
		if(StringUtil.checkParamsValid(map.get("erp_order_num"))){
			sf.append(" and a.erp_order_num >= '"+(map.get("erp_order_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("ma_order_num"))){
			sf.append(" and a.ma_order_num >= '"+(map.get("ma_order_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("fitting_num"))){
			sf.append(" and a.fitting_num >= '"+(map.get("fitting_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("goods_num"))){
			sf.append(" and a.goods_num >= '"+(map.get("goods_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("not_covered_count"))){
			sf.append(" and a.not_covered_count >= '"+(map.get("not_covered_count"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("not_covered_num"))){
			sf.append(" and a.not_covered_num >= '"+(map.get("not_covered_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("not_covered_numMax"))){
			sf.append(" and a.not_covered_num <= '"+(map.get("not_covered_numMax"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("receivables_num"))){
			sf.append(" and a.receivables_num >= '"+(map.get("receivables_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("vcard_num"))){
			sf.append(" and a.vcard_num >= '"+(map.get("vcard_num"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("sms_num"))){
			sf.append(" and a.sms_num >= '"+(map.get("sms_num"))+"' ");
		}
		
		if(StringUtil.checkParamsValid(map.get("promiseTime"))){
			sf.append(" and a.promise_time >= '"+(map.get("promiseTime"))+" 00:00:00'  ");
			sf.append(" and a.promise_time <= '"+(map.get("promiseTime"))+" 23:59:59' ");
		}
		if(StringUtil.checkParamsValid(map.get("updateTime"))){
			sf.append(" and a.update_time >= '"+(map.get("updateTime"))+" 00:00:00'  ");
			sf.append(" and a.update_time <= '"+(map.get("updateTime"))+" 23:59:59' ");
		}
		if(StringUtil.checkParamsValid(map.get("contact_results"))){
			sf.append(" and a.contact_results = '"+(map.get("contact_results"))+"' ");
		}
		if(StringUtil.checkParamsValid(map.get("share_site"))){
			sf.append(" and a.share_site = '"+(map.get("share_site"))+"' ");
		}
		
		if(StringUtil.checkParamsValid(map.get("contacts"))){
			sf.append(" and a.contacts = '"+(map.get("contacts"))+"' ");
		}
		
		//跟进时间
		if(StringUtil.checkParamsValid(map.get("update_timemin"))){//
			sf.append(" and a.update_time >= '"+(map.get("update_timemin"))+" 00:00:00' ");
		}
		if(StringUtil.checkParamsValid(map.get("update_timemax"))){
			sf.append(" and a.update_time <= '"+(map.get("update_timemax"))+" 23:59:59' ");
		}
		
		if(StringUtil.checkParamsValid(map.get("createTimemin"))){//
				sf.append(" and s.create_time >= '"+(map.get("createTimemin"))+" 00:00:00' ");
		}
		if(StringUtil.checkParamsValid(map.get("createTimemax"))){
			sf.append(" and s.create_time <= '"+(map.get("createTimemax"))+" 23:59:59' ");
		}
		 
		
		 if(StringUtil.checkParamsValid(map.get("dueTimemin"))){
			sf.append(" and s.due_time >= '"+( map.get("dueTimemin"))+" 00:00:00' ");
		}
		 if(StringUtil.checkParamsValid(map.get("dueTimemax"))){
			sf.append(" and s.due_time <= '"+( map.get("dueTimemax"))+" 23:59:59'  ");
		}
		 if (StringUtil.checkParamsValid(map.get("version"))){
			 String nowtime = DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss");
				if(map.get("version").toString().equals("1")){
					sf.append(" and (s.due_time IS NULL or s.due_time < '"+nowtime+"') ");
				}else if(map.get("version").toString().equals("2")){
					sf.append(" and (s.due_time IS NOT NULL and s.due_time >='"+nowtime+"') ");
				}else {
					sf.append("");
				}
			}
	
	/*	if(StringUtil.checkParamsValid(map.get("signType"))){
			String str[]=map.get("signType").toString().split(",");
			sf.append(" and o.flag in (" + StringUtil.joinInSql(str) + ")");
		}
*/
		return sf.toString();
	}
	
	//表头排序
		private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
			String sort = null;
			String dir = null;
			if (map.get("sidx") != null) {
				if (StringUtils.isNotBlank(map.get("sidx").toString())) {
					if ("end_time".equals(map.get("sidx").toString())) {
						sort = " o.end_time ";
					} else {
						sort = map.get("sidx").toString();
					}
				}
			}
			if (map.get("sord") != null) {
				if (StringUtils.isNotBlank(map.get("sord").toString())) {
					dir = map.get("sord").toString();
				}
			}

			String result = defaultOrderBy;
			if (map.get("sidx") != null) {
				if ("end_time".equals(map.get("sidx").toString())) {
					result = (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? (" order by " + sort + " " + dir) : defaultOrderBy;
				} else {
					result = (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? (" order by `" + sort + "` " + dir) : defaultOrderBy;
				}
			}

			return result;
		}
	
	//判断是否为昨天没有今天新增客户
	public boolean getCheck(String siteId){
		String sql =" SELECT COUNT(*) FROM crm_use_statistics_detailed WHERE( TO_DAYS( NOW( ) ) - TO_DAYS(create_time) <= 1  OR TO_DAYS(create_time) = TO_DAYS(NOW())) AND site_id=? ";
		long count = Db.queryLong(sql, siteId);
		if(count>0){
			return true;
		}
		return false;
	}
	
	public List<Record> getCountForms(String time,String userId){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT ot.user_id,s.login_name, COUNT(ot.fws) AS fwes, ot.ctime ");
		sf.append("FROM ( ");
		sf.append("SELECT DATE(a.create_time) AS ctime, a.user_id, COUNT(a.site_id) AS fws, a.site_id ");
		sf.append("FROM crm_use_statistics_detailed a ");
		sf.append("WHERE 1=1  ");
		sf.append("AND DATE_FORMAT(a.create_time,'%Y-%m')='"+time+"'");
		sf.append("AND a.user_id='"+userId+"'");
		sf.append("GROUP BY DATE(a.create_time), a.user_id, a.site_id ");
		sf.append(") ot "); 
		sf.append("LEFT JOIN sys_user s ON s.id=ot.user_id ");
		sf.append("WHERE 1=1 ");
		sf.append("GROUP BY ot.ctime, ot.user_id ");
		
		//String sql ="SELECT id ,login_name FROM sys_user WHERE  user_type='1' AND login_name != 'system'";
		return Db.find(sf.toString());
	}
	public List<Record> getnewaddCountForms(String time,String userId){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT ot.user_id,s.login_name, SUM(ot.fws) AS fwes, ot.ctime ");
		sf.append("FROM ( ");
		sf.append("SELECT DATE(a.create_time) AS ctime, a.user_id, COUNT(a.site_id) AS fws, a.site_id ");
		sf.append("FROM crm_use_statistics_detailed a ");
		sf.append("WHERE 1=1  ");
		sf.append("AND DATE_FORMAT(a.create_time,'%Y-%m')='"+time+"' AND a.newly_added='2' ");
		sf.append("AND a.user_id='"+userId+"'");
		sf.append("GROUP BY DATE(a.create_time), a.user_id, a.site_id ");
		sf.append(") ot "); 
		sf.append("LEFT JOIN sys_user s ON s.id=ot.user_id ");
		sf.append("WHERE 1=1 ");
		sf.append("GROUP BY ot.ctime, ot.user_id ");
		
		//String sql ="SELECT id ,login_name FROM sys_user WHERE  user_type='1' AND login_name != 'system'";
		return Db.find(sf.toString());
	}
	public List<Record> getUserlogins(String time){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT  a.user_id,s.login_name ");
		sf.append("FROM crm_use_statistics_detailed a ");
		sf.append("LEFT JOIN sys_user s ON s.id=a.user_id  ");
		sf.append("WHERE 1=1 ");
		sf.append("AND DATE_FORMAT(a.create_time,'%Y-%m')='"+time+"' ");
		sf.append("GROUP BY  a.user_id ");
		return Db.find(sf.toString());
	}
	
	public List<Record> getUserLoginNames(){
		String sql ="SELECT id ,login_name FROM sys_user WHERE  user_type='1' AND login_name != 'system'";
		return Db.find(sql);
	}
	
	public List<Record> gettimes(){
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT DATE_FORMAT(create_time,'%Y-%m') AS create_time FROM crm_use_statistics_detailed ");
		sf.append(" WHERE 1=1 GROUP BY DATE_FORMAT(create_time,'%Y-%m') ");
		return Db.find(sf.toString());
	}
	
	
	
	
}
