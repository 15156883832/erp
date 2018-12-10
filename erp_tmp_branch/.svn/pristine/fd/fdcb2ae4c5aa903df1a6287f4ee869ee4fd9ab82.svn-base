package com.jojowonet.modules.operate.service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsPlatFormDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.dao.SiteParentRelDao;
import com.jojowonet.modules.operate.dao.SiteReminderDao;
import com.jojowonet.modules.operate.dao.SiteRolePermissionDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.entity.SiteParentRel;
import com.jojowonet.modules.operate.entity.SiteReminder;
import com.jojowonet.modules.order.form.ZtreeNode;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.sys.util.AuthUtils;
import com.jojowonet.modules.sys.util.SMSUtils;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import javax.swing.event.ListSelectionEvent;

/**
 * 服务商Service
 * @author Ivan
 * @version 2016-08-01
 */
@Component
@Transactional(readOnly = true)
public class SiteService extends BaseService {

	private static Logger logger = Logger.getLogger(SiteService.class);

	@Autowired
	private SiteDao siteDao;
	
	@Autowired
	private SiteRolePermissionDao siteRolePermissionDao;
	@Autowired
	private SiteReminderDao siteReminderDao;
	@Autowired
	private GoodsPlatFormDao goodsPlatFormDao;
/*	@Autowired
	private AreaManagerDao areaManagerDao;*/
	@Autowired
	private SiteParentRelDao siteParentRelDao;

	
	public Record getSiteId(String id) {
		return siteDao.getSiteId(id);
	}
	
	public Page<Site> findSites(Page<Site> page, Site site) {
		DetachedCriteria dc = siteDao.createDetachedCriteria();
		if(StringUtils.isNotBlank(site.getName())){
			dc.add(Restrictions.like("name", "%" + site.getName() + "%"));
		}
		if(site.getUser() != null && StringUtils.isNotBlank(site.getUser().getLoginName())){
			dc.createAlias("user", "user");
			dc.add(Restrictions.like("user.loginName", "%" + site.getUser().getLoginName() + "%"));
		}
		if(StringUtils.isNotBlank(site.getCreateTimeStart())){
			dc.add(Restrictions.ge("createTime", DateUtils.getDateStart(DateUtils.parseDate(site.getCreateTimeStart()))));
		}
		if(StringUtils.isNotBlank(site.getCreateTimeEnd())){
			dc.add(Restrictions.le("createTime", DateUtils.getDateEnd(DateUtils.parseDate(site.getCreateTimeEnd()))));
		}
		dc.add(Restrictions.eq("status", "0"));
		dc.addOrder(Order.desc("createTime"));
		return siteDao.find(page, dc);
	}
	
	public Page<Record> getsiteList(Page<Record> page,Map<String, Object> paras){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT s.*,u.login_name,sj.jurisdiction FROM crm_site AS s ");
		sf.append(" LEFT JOIN sys_user AS u ON  u.id=s.user_id AND u.status='0' ");
		sf.append(" LEFT JOIN crm_site_jurisdiction AS sj ON  s.id=sj.site_id ");
		sf.append(" WHERE s.status='0'  ");
		sf.append(sqlOrdersByStatusFilter(paras));
		sf.append(" ORDER BY s.create_time DESC  ");
		sf.append(limit(page));
		List<Record> list = Db.find(sf.toString());
		page.setList(list);
		page.setCount(getcount(paras));
		return page;
	}
	
	public long getcount(Map<String, Object> paras){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT count(*) as count FROM crm_site AS s ");
		sf.append(" LEFT JOIN sys_user AS u ON  u.id=s.user_id AND u.status='0' ");
		sf.append(" LEFT JOIN crm_site_jurisdiction AS sj ON  s.id=sj.site_id ");
		sf.append(sqlOrdersByStatusFilter(paras));
		sf.append(" WHERE s.status='0' ORDER BY s.create_time DESC  ");
		return Db.queryLong(sf.toString());
	}
	
	public String sqlOrdersByStatusFilter(Map<String, Object> map){
		StringBuffer sf = new StringBuffer();
		if(map.get("createTimeStart") != null && StringUtils.isNotBlank(((String[]) map.get("createTimeStart"))[0])){
			sf.append(" and s.create_time >= '"+((String[]) map.get("createTimeStart"))[0]+"' ");
		}
		if(map.get("createTimeEnd") != null && StringUtils.isNotBlank(((String[]) map.get("createTimeEnd"))[0])){
			sf.append(" and s.create_time <= '"+((String[]) map.get("createTimeEnd"))[0]+" 23:59:59' ");
		}
		if(map.get("name") != null && StringUtils.isNotBlank(((String[]) map.get("name"))[0])){
			sf.append(" and s.name like '%"+((String[]) map.get("name"))[0]+"%' ");
		}
		if(map.get("loginName") != null && StringUtils.isNotBlank(((String[]) map.get("loginName"))[0])){
			sf.append(" and u.login_name like '%"+((String[]) map.get("loginName"))[0]+"%' ");
		}
		if(map.get("jurisdiction") != null && StringUtils.isNotBlank(((String[]) map.get("jurisdiction"))[0])){
			sf.append(" and sj.jurisdiction = '"+((String[]) map.get("jurisdiction"))[0]+"' ");
		}
		return sf.toString();
	}
	
    private String limit(Page<?> page) {
        return "LIMIT " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize();
    }
	
	public String getbrand(String id){
		return siteDao.getcateId(id);
	}

	public Site get(String id) {
		return siteDao.getByHql(" from Site where id= '"+id+"' and status = '0' ");
	} 
	
	@Transactional(readOnly = false)
	public void save(String id ,Site site) {
		siteDao.UpdateSiteId(id ,site);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		siteDao.deleteById(id);
	}

    public List<Site> getListSite(Site site){
    	return siteDao.getListSite(site);
    }

    public Site getUserSite(String userId) {
		Parameter parameter = new Parameter();
		parameter.put("uid", userId);
    	return siteDao.getByHql("from Site where user.id=:uid", parameter);
	}



    public Record getByUserId(String userId){
	return siteDao.getByUserId(userId);
     }
	/**
	 * 根据userid获取网点信息
	 * @param userid
	 * @return
	 */
	public String findSiteIdByUserId(String userid){
		return siteDao.findSiteIdByUserId(userid);
	}
	
	//修改网点品类
	public void updatebrang(String cate,String id,List<String> list){
		if(list.size()>0){
			siteDao.updatecate(id, list);
		}
		
		siteDao.updatebrand(cate, id);	
	}
	public void updateBrand(String brand ,String cateid,String siteId){
		siteDao.updateBrand(brand, cateid, siteId);
	}

	public List<Map<java.lang.String, Object>> getCategoriesBySiteId(Site site) {
		List<Map<java.lang.String, Object>> list = Lists.newArrayList();
		String catStr = site.getCategory();
		if(StringUtils.isNotBlank(catStr)){
			StringBuffer sb = new StringBuffer("");
			sb.append(" SELECT a.id, a.name, a.img FROM crm_category a WHERE a.del_flag = '0' AND a.id IN ("+catStr+") ");
			List<Record> rds = Db.find(sb.toString());
			for(Record rd : rds){
				list.add(rd.getColumns());
			}
		}
		return list;
	}

	public List<Map<String, Object>> getBrandsBySiteId(Site site) {
		List<Map<String, Object>> list = Lists.newArrayList();
		String catStr = site.getCategory();
		if(StringUtils.isNotBlank(catStr)){
			StringBuffer sb = new StringBuffer("");
			sb.append(" SELECT a.brand_id, a.category_id, b.name AS bname, c.name AS cname, c.img  ");
			sb.append(" FROM crm_site_brand_rel a LEFT JOIN crm_brand b ON b.id = a.brand_id AND b.del_flag = '0' ");
			sb.append(" LEFT JOIN crm_category c ON c.id = a.category_id ");
			sb.append(" WHERE a.site_id = '"+site.getId()+"' AND a.category_id IN ("+catStr+") order by a.category_id asc ");
			List<Record> rds = Db.find(sb.toString());
			String cid = "";
			Map<String, Object> map = Maps.newHashMap();
			List<Map<String, Object>> subItem = Lists.newArrayList();
			for(Record rd : rds){
				Map<String, Object> subMap = Maps.newHashMap();
				if(!cid.equalsIgnoreCase(rd.getInt("category_id").toString())){
					cid = rd.getInt("category_id").toString();
					map = Maps.newHashMap();
					subItem = Lists.newArrayList();
					map.put("cid", rd.getInt("category_id").toString());
					map.put("subItem", subItem);
					map.put("cname", rd.getStr("cname"));
					map.put("img", rd.getStr("img"));
					list.add(map);
				}
				subItem.add(subMap);
				subMap.put("bname", rd.getStr("bname"));
			}
		}
		return list;
	}

	public Page<Record> memberIndex(Page<Record> page, Map map) {
		page.setList(getMembers(page, map));
		page.setCount(countMembers(page, map));
		return page;
	}
	
	public List<Record> getMembers(Page<Record> page, Map map){
		StringBuilder sb = new StringBuilder("");
		sb.append(" SELECT a.id, IFNULL(a.level, '0') AS 'level', a.name, a.mobile, a.contacts, a.share_code, IFNULL(ot.num, '0') AS num, ");
		sb.append(" (CASE WHEN  ot.num >= 12 THEN 24 ");
		sb.append(" WHEN  ot.num>=6 THEN 12 ");
		sb.append(" WHEN  ot.num>=3 THEN 6 ELSE 0 ");
		sb.append(" END) AS ycMonth ");
		sb.append(" FROM crm_site a LEFT JOIN ( ");
		sb.append(" SELECT a.share_code_site_parent_id, COUNT(1) AS num FROM crm_site a  ");
		sb.append(" WHERE a.status = '0' AND a.share_code_site_parent_id IS NOT NULL  ");
		sb.append(" GROUP BY a.share_code_site_parent_id  ");
		sb.append(" ) ot ON ot.share_code_site_parent_id = a.id ");
		sb.append(" WHERE a.status = '0' ");
		if(map.get("siteName") != null && StringUtils.isNotBlank(((String[]) map.get("siteName"))[0])){
			sb.append(" and a.name like '%"+((String[]) map.get("siteName"))[0]+"%' ");
		}
		if(map.get("level") != null && StringUtils.isNotBlank(((String[]) map.get("level"))[0])){
			sb.append(" and a.level = '"+((String[]) map.get("level"))[0]+"' ");
		}
		sb.append("  ORDER BY num DESC  ");
		if(page != null){
			sb.append(limit(page));
		}
		return Db.find(sb.toString());
	}
	
	public Long countMembers(Page<Record> page, Map map){
		StringBuilder sb = new StringBuilder("");
		sb.append(" SELECT count(1) as count ");
		sb.append(" FROM crm_site a LEFT JOIN ( ");
		sb.append(" SELECT a.share_code_site_parent_id, COUNT(1) AS num FROM crm_site a  ");
		sb.append(" WHERE a.status = '0' AND a.share_code_site_parent_id IS NOT NULL  ");
		sb.append(" GROUP BY a.share_code_site_parent_id  ");
		sb.append(" ) ot ON ot.share_code_site_parent_id = a.id ");
		sb.append(" WHERE a.status = '0' ");
		sb.append("  ");
		if(map.get("siteName") != null && StringUtils.isNotBlank(((String[]) map.get("siteName"))[0])){
			sb.append(" and a.name like '%"+((String[]) map.get("siteName"))[0]+"%' ");
		}
		if(map.get("level") != null && StringUtils.isNotBlank(((String[]) map.get("level"))[0])){
			sb.append(" and a.level = '"+((String[]) map.get("level"))[0]+"' ");
		}
		
		return Db.queryLong(sb.toString());
	}

	public Page<Record> commonSetting(Page<Record> page, Map map, java.lang.String type, String siteId) {
		StringBuilder listSb = new StringBuilder(" select a.id, ifnull(b.id,0) as cfId, ifnull(b.type,0) as type, ifnull(b.set_value, 0) as setValue ");
		StringBuilder fromSb = new StringBuilder(" from crm_site a left join crm_site_common_setting b on b.site_id = a.id and b.type = '"+type+"'");
		fromSb.append(" where a.status = '0' and a.id = '"+siteId+"' ");
		com.jfinal.plugin.activerecord.Page<Record> jfPage =  Db.paginate(page.getPageNo(), page.getPageSize(), listSb.toString(), fromSb.toString());
		page.setList(jfPage.getList());
		page.setCount(jfPage.getTotalRow());
		return page;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getSiteCommonSetting(String siteId){
		Record rd = Db.findFirst("select * from crm_site_common_setting a where a.site_id = '"+siteId+"'"); 
		return (Map<String, Object>) (rd == null ? Maps.newHashMap() : rd.getColumns());
	}

	public void setCommonSetting(String siteId, String type, String val) {
		if(StringUtils.isNotBlank(siteId)){
			String relSiteId = siteId.split("_")[0];
			Record rd = Db.findFirst(" select id from crm_site_common_setting where site_id = '"+relSiteId+"' ");
			String cfId = rd == null ? "" : rd.getStr("id");
			String setVal = "true".equalsIgnoreCase(val) || "0".equalsIgnoreCase(val) ? "0" : "1";
			if(StringUtils.isBlank(cfId)){
				Db.update(" insert into crm_site_common_setting values ('"+IdGen.uuid()+"', '"+relSiteId+"', '0', '"+setVal+"')");
			}else{
				Db.update(" update crm_site_common_setting set set_value = '"+setVal+"' where id = '"+cfId+"' ");
			}
		}
	}
	//获取短信所属模板与名称
	public List<Map<String,String>> getTemplate(){
		return siteDao.getTemplate();
	}

	public List<Record> getTempTag(String tag){
		return siteDao.getTempTag(tag);
	}
	
	public List<ZtreeNode> getAllSiteMenus(String siteId){
		//List<Menu> menus = menuDao.find("from Menu where status=:p1 order by sort", new Parameter("0"));
		/*StringBuilder sb = new StringBuilder("");
		sb.append(" select * from (  ");
		sb.append(" select a.id, a.parent_id, a.name, a.sort from sys_menu a, sys_role_menu b where b.menu_id = a.id and b.role_id = '3' and a.is_show = '1' ");
		sb.append(" and exists (select 1 from sys_menu c where c.id = a.parent_id and c.status = '0') ");
		sb.append(" and a.status = '0' ");
		sb.append(" union all ");
		sb.append(" select a.id, a.parent_id, a.name, a.sort ");
		sb.append(" from sys_menu a where a.target in ('1', '2') ");
		sb.append(" and a.status = '0' and a.is_show = '1' ");
		sb.append(" ) ot order by ot.sort asc ");*/
		
		List<Record> menusRd = siteRolePermissionDao.getSystemSiteRoleMenus() ;
		
		Map<String, String> perMap = AuthUtils.getSitePermissionArr();
		List<ZtreeNode> nodes = Lists.newArrayList();
		for(Record rd : menusRd){
			if(StringUtils.isNotBlank(rd.getStr("id")) && rd.getStr("id").indexOf(",") == -1){
				ZtreeNode zn = new ZtreeNode(rd);
				if(perMap.containsKey(zn.getId())){
					zn.setChecked(true);
				}
				nodes.add(zn);
			}
		}
		return nodes;
	}

	//public Map<String, Map<String, Object>> getSiteAlarm(String siteId) {
	public List<Record> getSiteAlarm(String siteId) {
		StringBuilder sb = new StringBuilder();
		sb.append(" select * from crm_site_alarm_setting a where a.site_id = ? ");
		List<Record> rds = Db.find(sb.toString(), siteId);
//		Map<String, Object> alarmMap = Maps.newHashMap();
		Record r1 = new Record().setColumns(new HashMap<String, Object>());
		Record r2 = new Record().setColumns(new HashMap<String, Object>());
		Record r3 = new Record().setColumns(new HashMap<String, Object>());
		Record r4 = new Record().setColumns(new HashMap<String, Object>());
		for(Record rd : rds){
			if("1".equals(rd.get("type", ""))){
				r1 = rd;
			}else if("2".equals(rd.get("type", ""))){
				r2 = rd;
			}else if("3".equals(rd.get("type", ""))){
				r3 = rd;
			}else if("4".equals(rd.get("type", ""))){
				r4 = rd;
			}
			String unit = rd.getStr("unit");
			String val = rd.getStr("val");
			if("1".equals(unit) && StringUtils.isNumeric(val)){
				Double valNew = Double.valueOf(val);
				val = String.valueOf(new Double(valNew/60).intValue());
			}
			rd.set("val", val);
		}
		List<Record> retRds = Lists.newArrayList();
		retRds.add(r1);
		retRds.add(r2);
		retRds.add(r3);
		retRds.add(r4);
		/*alarmMap.put("alarm1", r1.getColumns());
		alarmMap.put("alarm2", r2.getColumns());
		alarmMap.put("alarm3", r3.getColumns());
		alarmMap.put("alarm4", r4.getColumns());*/
		return retRds;
	}

	public String saveAlarm(Map<String, Object> map, String siteId) {
		List<Record> rds = Db.find("select * from crm_site_alarm_setting a where a.site_id = ?", siteId);
		for(int i =0; i < 4; i++){
			String id = "";
			String index = String.valueOf(i+1);
			for(Record rd : rds){
				if(index.equals(rd.get("type", "0"))){
					id = rd.getStr("id");
					break;
				}
			}
			String name = "";
			if("1".equals(index)){
				name = "服务工程师接单预警";
			}else if("2".equals(index)){
				name = "服务工程师完工预警";
			}else if("3".equals(index)){
				name = "库存预警";
			}else if("4".equals(index)){
				name = "缺件预警";
			}
			String receiver_type = String.valueOf(map.get("receiver_type@"+i) == null ? "" : map.get("receiver_type@"+i));
			String notify_type = String.valueOf(map.get("notify_type@"+i) == null ? "" : map.get("notify_type@"+i));
			String val = String.valueOf(map.get("val@"+i) == null ? "" : map.get("val@"+i));
			String unit = String.valueOf(map.get("unit@"+i) == null ? "0" : map.get("unit@"+i));
			Double valNew = 0d;
			if("1".equals(unit)){
				valNew = Double.valueOf(val) * 60;
				val = String.valueOf(valNew.intValue());
			}
			String status = String.valueOf(map.get("status@"+i) == null ? "0" : map.get("status@"+i));
			String type = index;
			if(StringUtils.isNotBlank(id)){
				//更新操作
				Db.update("update crm_site_alarm_setting set receiver_type = ?, notify_type = ?, val = ?, unit = ?, status = ?, update_time = ? where id = ?",
						receiver_type, notify_type, val, unit, status, new Date(), id);
			}else{
				//新增操作
				Db.update("insert into crm_site_alarm_setting(id, site_id, name, receiver_type, notify_type, val, unit, status, type, update_time) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
						IdGen.uuid(), siteId, name, receiver_type, notify_type, val, unit, status, type, new Date());
			}
		}
		return null;
	}
	
	public String compareDueTime(String siteId){
		Date now = new Date();
		Record rd = Db.findFirst("select * from crm_site a where a.id='"+siteId+"' and a.status='0' ");
		if(rd.getDate("due_time")==null ){
			return "wkt";
		}else if(rd.getDate("due_time").getTime() < now.getTime()){
			return "gq";
		}else{
			return "ok";
		}
	}

	public Map<String ,Object> getSiteLevel(String siteId) {
		Long shareCount = Db.queryLong("select count(1) as cnt from crm_site where share_code_site_parent_id=? and status='0' and due_time is not null", siteId);
		return convertSiteLevel(shareCount);
	}

	private Map<String ,Object>  convertSiteLevel(Long sharingCount) {
		Map<String ,Object>  map = Maps.newHashMap();
		if (sharingCount == null) {
			sharingCount = 0L;
		}

		if (sharingCount >= 12) {
			map.put("count", 4);
			map.put("name", "钻石会员");
			return map;
		}
		if (sharingCount >= 6) {
			map.put("count", 3);
			map.put("name", "金牌会员");
			return map;
		}
		if (sharingCount >= 3) {
			map.put("count", 2);
			map.put("name", "银牌会员");
			return map;
		}
		map.put("count", 1);
		map.put("name", "普通会员");
		return map;
	}

	/**
	 * 老会员到期续费方案：
	 * 1. 会员到期7天（包括7天）内，每人登陆都做对应的提醒；会员到期90天（包括90天）内，
	 * 服务商经理人登陆，触发会员到期提醒窗口，逻辑上记录服务商当前提醒日期，下次登陆日期和上次提醒日期
	 * 在一周之内（小于7天）不再提醒；一周之外（大于等于7天）再次提醒，记录当前提醒日期。
	 * 2. 会员有效期内，服务商续费价格按照上一次购买记录超过1年（包括1年期）的价格进行续费；会员有效期外的，按照最新的价格执行。
	 */
	public static boolean xufeiRemind(Date dueTime, Date baseTime, Date lastRemindTime) {
		int remainingDays = com.jojowonet.modules.operate.utils.DateUtils.daysBetween(baseTime, dueTime);
		if (dueTime == null || dueTime.before(baseTime) || remainingDays > 90) { // 如果已经过期了或者到期时间超过3个月，则不提醒
			return false;
		}
		// 当天已经提醒过了，则不再提醒。
		if (lastRemindTime != null && org.apache.commons.lang3.time.DateUtils.isSameDay(lastRemindTime, baseTime)) {
			return false;
		}

		if (remainingDays <= 7) {
			return true;
		}
		if (lastRemindTime == null) {
			return true;
		}
		int daysSinceLastRemind = com.jojowonet.modules.operate.utils.DateUtils.daysBetween(lastRemindTime, baseTime);
		return daysSinceLastRemind >= 7;
	}

	public boolean xufeiRemind(String siteId) {
		Site site  = get(siteId);
		SiteReminder reminder = siteReminderDao.getSiteXuFeiReminder(siteId);
		Date lastRemindTime = reminder == null ? null : reminder.getLastRemindTime();
		return xufeiRemind(site.getDueTime(), new Date(), lastRemindTime);
	}

	public boolean xufeiRemindDock(String siteId) {
		Site site  = get(siteId);
		return xufeiRemind(site.getDueTime(), new Date(), null);
	}

	/**
	 *
	 * @param site 续费vip的网点
	 * @param months 续费vip的时长，以月计
	 * @return 返回网点续费vip需要支付的费用，单位元。
	 */
	public int getSiteXufeiAmount(Site site, int months) {
		Date dueTime = site.getDueTime();
		Date now = new Date();
		Record lastVipXuFeiMore12Month = goodsPlatFormDao.getLastVipXuFeiMore12Month(site.getId()); // 寻找指定网点上次购买或者续费思方vip超过12个月的购买记录

		if (dueTime == null || dueTime.before(now) || lastVipXuFeiMore12Month == null || months < 12) {
			if (months == 1) {
				return 300;
			} else if (months == 6) {
				return 1620;
			} else if (months == 12) {
				return 2920;
			} else if (months == 24) {
				return 5110;
			} else if (months == 36) {
				return 6570;
			} else {
				throw new RuntimeException("no such vip months span: " + months);
			}
		} else { // 没过期的服务商续费，找上一次的有效付款时间12个月以上的记录，按照那个价格执行。
			int goodAmount = lastVipXuFeiMore12Month.getBigDecimal("good_amount").intValue();
			int purchaseNum = lastVipXuFeiMore12Month.getBigDecimal("purchase_num").intValue();
			int buyYears = (months / 12);
			int perYearFee = goodAmount / (purchaseNum / 12);
			if (perYearFee == 1825 && purchaseNum % 12 == 0) {
				return 1825 * buyYears;
			} else if (perYearFee == 2190 && purchaseNum % 12 == 0) {
				return 2190 * buyYears;
			} else {
				if (buyYears == 1) {
					return 2920;
				} else if (buyYears == 2) {
					return 5110;
				} else if (buyYears == 3) {
					return 6570;
				}
				throw new RuntimeException("no such vip months span2:" + months);
			}
		}
	}

	public Map<String, Integer> getSiteXuFeiInfo(Site site) {
		Map<String, Integer> map = new HashMap<>();
		int amount = getSiteXufeiAmount(site, 12);
		if (amount > 0 && amount % SiteReminder.XuFeiJia.FiftyPO.getVal() == 0) {
			// 5折老会员
			map.put("discount", 5);
			map.put("remindIcon", 1);
		} else if (amount > 0 && amount % SiteReminder.XuFeiJia.SixtyPO.getVal() == 0) {
			// 6折老会员
			map.put("discount", 6);
			map.put("remindIcon", 1); // 当网点能够以5折和6折购买思方vip会员的时候，在首页显示续费提醒小图标
		} else {
			map.put("discount", 8);
			map.put("remindIcon", 0);
		}
		Date dueTime = site.getDueTime();
		int leftDays = 0;
		if (dueTime != null) {
			int realLeftDays = com.jojowonet.modules.operate.utils.DateUtils.daysBetween(new Date(), dueTime);
			leftDays = realLeftDays > 0 ? realLeftDays : 0;
		}
		map.put("leftDays", leftDays);
		return map;
	}

	public int genShareCode() {
		Set<String> codes = new HashSet<>();
		List<Record> records = Db.find("select s.share_code from crm_site as s where LENGTH(s.share_code)>0");
		List<Record> records1 = Db.find("select s.code from crm_area_manager as s where LENGTH(s.code)>0");
		for (Record rd : records) {
			codes.add(rd.getStr("share_code").toLowerCase());
		}
		for (Record rd : records1) {
			codes.add(rd.getStr("code").toLowerCase());
		}
		List<Record> sr = Db.find("select s.id from crm_site as s where LENGTH(s.share_code)=0 or s.share_code is null");
		int ret = 0;
		for (Record rd : sr) {
			Db.update("update crm_site set share_code=? where id=? and (LENGTH(share_code)=0 or share_code is null)", genSiteShareCode(codes), rd.getStr("id"));
			ret++;
		}
		return ret;
	}

	private String genSiteShareCode(Set<String> old) {
		while (true) {
			String code = RandomStringUtils.randomAlphanumeric(4);
			if (!old.contains(code.toLowerCase())) {
				old.add(code.toLowerCase());
				return code;
			}
		}
	}

	//根据userID 查询网点的分享区管的分享码
	public String getAreaCode(String userId) {
		return siteDao.getAreaCode(userId);
	}
	
	public Object getSiteCode(Map<String, Object> params){
//		Date h1 = DateUtils.addHours(new Date(), 1);
		Record rd = Db.findFirst(" select * from crm_site_code a where a.number = ? and a.status = '0' ", params.get("number"));
		if(rd != null){
			Date ct = rd.getDate("create_time");
			Date now = new Date();
			if((now.getTime() - ct.getTime()) < 1 * 60 * 60 * 1000){
				return rd;
			}
			return null;
		}
		return null;
	}
	/*一级网点查看所有二级网点*/
	public Page<Record> secondSiteList(String siteId,Page<Record> page,Map<String,Object> map) {
		List<Record> list = getSecondSiteList(siteId,page,map);
		for(Record rd : list){
			String address = rd.getStr("province") + rd.getStr("city")+rd.getStr("area")+rd.getStr("address");
			rd.set("versionMark", "0");
			Date dt = rd.getDate("due_time");
			if(dt!=null){
				if(dt.getTime() >= new Date().getTime()){
					rd.set("versionMark", "1");
				}
			}
			rd.set("address", address);
		}
		Long count = getSecondSiteCount(siteId,map);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	/*二级网点查看主网点*/
	public List<Record> siteParentList(String siteId,Map<String,Object> map) {
		List<Record> list = getSiteParentList(siteId);
		for(Record rd : list){
			String address = rd.getStr("province") + rd.getStr("city")+rd.getStr("area")+rd.getStr("address");
			rd.set("versionMark", "0");
			Date dt = rd.getDate("due_time");
			if(dt!=null){
				if(dt.getTime() >= new Date().getTime()){
					rd.set("versionMark", "1");
				}
			}
			rd.set("address", address);
		}

		return list;
	}
	/*查看所有一级网点*/
	public List<Record> getSiteParentList(String siteId){
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT b.*  "
				+ " FROM crm_site_parent_rel a  "
				+ " LEFT JOIN crm_site b ON b.id = a.parent_site_id AND b.status='0' "
				+ " WHERE a.status='0' AND a.site_id=? ");

		return Db.find(sb.toString(),siteId);
	}
	public long getSiteParentCount(String siteId,Map<String,Object> map){
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT count(*) "
				+ " FROM crm_site_parent_rel a  "
				+ " LEFT JOIN crm_site b ON b.id = a.parent_site_id AND b.status='0' "
				+ " WHERE a.status='0' AND a.site_id=? ");
		return Db.queryLong(sb.toString(),siteId);
	}
	
	public List<Record> getSecondSiteList(String siteId,Page<Record> page,Map<String,Object> map){
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT a.*,u.login_name,k.id as relId,CASE k.site_type WHEN '1' THEN '直营网点' WHEN '2' THEN '合作网点' ELSE '' END AS site_type FROM crm_site a LEFT JOIN sys_user u ON u.id=a.user_id AND u.status='0' "
				+ "INNER JOIN (SELECT  g.site_id, g.create_time,g.id  ,g.site_type "
				+ "FROM crm_site_parent_rel g WHERE g.parent_site_id = ? AND g.status = '0') "
				+ "AS k ON k.site_id = a.id WHERE a.status = '0'  ");
		sb.append(" order by k.create_time desc");
		if(page!=null){
			sb.append(" limit "+page.getPageSize()+" offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sb.toString(),siteId);
	}
	/*二级网点的数量
	*/
	public Map<String, Long> getOrderTabCount(String siteId) {
		Map<String, Long> map = Maps.newHashMap();
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT  ");
		sf.append(" COUNT(CASE WHEN ( a.site_type = '1' ) THEN 1 END) AS 'zy' , ");
		sf.append(" COUNT(CASE WHEN ( a.site_type = '2' ) THEN 1 END) AS 'hz'  ");
		sf.append(" FROM crm_site_parent_rel a  ");
		sf.append(" WHERE a.parent_site_id=? AND a.status='0'  ");
		Record rd = Db.findFirst(sf.toString(),siteId);
		map.put("zy", rd.getLong("zy"));
		map.put("hz", rd.getLong("hz"));
		return map;
	}

	
	public Long getSecondSiteCount(String siteId,Map<String,Object> map){
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT count(*) FROM crm_site a LEFT JOIN sys_user u ON u.id=a.user_id AND u.status='0' INNER JOIN (SELECT  g.site_id, g.create_time FROM crm_site_parent_rel g WHERE g.parent_site_id = ? AND g.status = '0') AS k ON k.site_id = a.id WHERE a.status = '0'  ");
		return Db.queryLong(sb.toString(),siteId);
	}
	
	public String checkAndSendMsg(String siteId,String mobile,String code ){
		Record rd = Db.findFirst("select a.* from crm_site a where a.mobile=? and a.status='0' ",mobile);
		if(rd==null){
			return "421";
		}
	//	Record rd1 = Db.findFirst("select a.* from crm_site a where a.mobile=? and a.status='0' and a.type='2' ",mobile);
		Record rd1 = Db.findFirst("SELECT * FROM crm_site a " + 
				"LEFT JOIN crm_site_parent_rel b ON b.site_id = a.id AND b.status='0' " + 
				"WHERE a.mobile =? AND a.status='0'AND  b.parent_site_id=? AND a.type='2' " + 
				" ",mobile,siteId);
		if(rd1!=null){//该服务商下已经添加了手机号的二级网点
			return "422";
		}
		Record rd2 = Db.findFirst("select a.* from crm_site a where a.mobile=? and a.status='0' and a.type='1' ",mobile);
		if(rd2!=null){//一级网点
			return "423";
		}
	//	Site st = siteDao.get(siteId);
		SMSUtils.sendMsg(mobile,"【思方科技】您的验证码是:"+code+"，在5分钟内有效。如非本人操作请忽略本短信。","","");
		return "200";
	}
	
	@Transactional(rollbackFor=Exception.class)
	public String addSecondSiteConfirm(String siteId,String siteName,String siteMobile,String code,String mobileMsg,String userId,String type){
		if(!code.equals(mobileMsg)){
			return "420";
		}

		Record rd = Db.findFirst("select a.* from crm_site a where a.name=? and a.mobile=? and a.status='0' and a.type!='1'", siteName, siteMobile);
		if (rd == null) {//不存在该普通网点
			Long count = Db.queryLong("select count(*) from crm_site a where a.status='0' and a.name=? ", siteName);
			if (count < 1) {
				//不存在服务商名称为 的二级网点
				return "421";
			}
			Long count1 = Db.queryLong("select count(*) from crm_site a where a.status='0' and a.mobile=? ", siteMobile);
			if (count1 < 1) {
				//不存在手机号为  的经理人账号，请再次确认！
				return "422";
			}
			//服务商名称与经理人注册的的手机号不相符请再次确认！
			return "423";
		}

		Record rd2 = Db.findFirst("select a.* from crm_site_parent_rel a where a.status='0' and a.site_id=? and a.parent_site_id =? ", rd.getStr("id"),siteId);
		if (rd2 != null ) {
			//已绑定该网点为二级网点，请不要重复绑定
			return "425";
		}
		
		Record rd1 = Db.findFirst("select a.*,u.id as uId from crm_site a left join sys_user u on u.id=a.user_id where a.id=? ",siteId);
		String meType = rd1.getStr("type");
		if(!"1".equals(meType)){//判断当前网点是不是一级网点，再次验证
			return "424";
		}
		SiteParentRel spr = new SiteParentRel();
		spr.setCreateBy(userId);
		spr.setCreateName(CrmUtils.getUserXM());
		spr.setParentSiteId(siteId);
		spr.setSiteId(rd.getStr("id"));
		spr.setStatus("0");
		spr.setCreateTime(new Date());
		spr.setSiteType(type);
		siteParentRelDao.save(spr);
		SQLQuery sql = siteParentRelDao.getSession().createSQLQuery("update crm_site a set a.type='2' where a.id=:id and a.status='0' ");
		sql.setParameter("id", rd.getStr("id"));
		sql.executeUpdate();
		return "200";
	}
	/*一级网点解绑二级网点*/
	@SuppressWarnings("unchecked")
	@Transactional(rollbackFor=Exception.class)
	public String delSecondSite(String siteId,String ids,String userId){
		String name = CrmUtils.getUserXM();
        Query query = siteParentRelDao.getSession().createQuery("from SiteParentRel where id in(:ids) and parentSiteId=:pid");
        query.setParameterList("ids", ids.split(","));
        query.setParameter("pid", siteId);
        List<SiteParentRel> lt = query.list();
		for(SiteParentRel spr : lt){
			spr.setStatus("1");
			spr.setCancelId(userId);
			spr.setCancelName(name);
			spr.setCancelTime(new Date());
			/*SQLQuery sql = siteParentRelDao.getSession().createSQLQuery("update crm_site a set a.type='0' where a.id=:id and a.status='0' ");
			sql.setParameter("id", spr.getSiteId());
			sql.executeUpdate();*/
		}
		siteParentRelDao.save(lt);
		return "200";
	}

	/**
	 * 判断该网点是否属于指定的一级网点
	 * @param parentSiteId 一级网点的ID
	 * @param siteId 网点的ID(可以一级/也可以时二级)
	 * @return
	 */
	public String checkSiteInParentSite(String parentSiteId, String siteId){
		if(StringUtils.isBlank(parentSiteId)){
			return "no";
		}
		if(parentSiteId.equalsIgnoreCase(siteId)){
			return "yes";//该网点就是一级网点
		}

		StringBuilder sb = new StringBuilder("");
		sb.append(" select a.id from crm_site_parent_rel a where a.parent_site_id = ? and a.site_id = ? and a.status = '0' limit 1 ");
		Record rd = Db.findFirst(sb.toString(), parentSiteId, siteId);
		if(rd == null){
			return "no";
		}
		return "yes";
	}
	
	/**
	 * 判断该网点是否授权帮手
	 * @param siteId 网点的ID
	 * @return
	 */
	public String checkSiteBangshou(String siteId){
		StringBuilder sb = new StringBuilder("");
		sb.append("  SELECT b.set_value FROM crm_site a ");
		sb.append("  LEFT JOIN crm_site_common_setting b ON b.site_id = a.id AND b.type='17' ");
		sb.append("  WHERE a.id = ? ");
		Record rd = Db.findFirst(sb.toString(),  siteId);
		if(rd == null || null== rd.getStr("set_value") || "0".equals(rd.getStr("set_value"))){
			return "no";
		}
		return "yes";
	}
	
}
