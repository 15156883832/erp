package com.jojowonet.modules.order.service;

import java.util.*;

import com.jojowonet.modules.order.utils.*;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.dao.CustomerTypeDao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.dao.OrderDispatchDao;
import com.jojowonet.modules.order.dao.OrderDispatchEmployeRelDao;
import com.jojowonet.modules.order.dao.ServiceTypeDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderDispatch;
import com.jojowonet.modules.order.entity.OrderDispatchEmployeRel;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

@Component
public class SecondSiteOrderService extends BaseService {
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private TableSplitMapper tableSplitMapper;
	/*
	 * @Autowired private NonServicemanDao noDao;
	 */
	@Autowired
	private NonServicemanService nonService;
	@Autowired
	private OrderOriginService orderOriginService;
	@Autowired
	private SiteService siteService;
	@Autowired
	private OrderDispatchDao orderDispatchDao;
	@Autowired
	private OrderDispatchEmployeRelDao orderDispatchEmployeRelDao;

	/**
	 * 处理中工单数据
	 */
	public Page<Record> getOrderWaitForDis(Page<Record> page, String siteId, Map<String, Object> map) {
		User user = UserUtils.getUser();
		String sites = CrmUtils.getSiteIdList(siteId);
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			String cate = nonService.servicemanCate(user.getId(), siteId);
			String brand = nonService.servicemanBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cate);
			brandList = StringUtil.tolist(brand);
		}
		List<Record> list = orderDao.getOrderWaitDeal(page, sites, map, cateList, brandList);
		long count = orderDao.getOrderWaitDealCount(sites, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	/**
	 * 待回访工单信息
	 */
	public Page<Record> getOrderWaitCallBack(Page<Record> page, String siteId, Map<String, Object> map) {
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		String sites = CrmUtils.getSiteIdList(siteId);
		if (!("2".equals(user.getUserType()))) {
			String cate = nonService.servicemanCate(user.getId(), siteId);
			String brand = nonService.servicemanBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cate);
			brandList = StringUtil.tolist(brand);
		}
		List<Record> list = orderDao.getOrderWaitCallBack(page, siteId, sites, map, cateList, brandList);
		long count = orderDao.getOrderWaitCallBackCount(siteId, sites, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	/**
	 * 已回访工单信息
	 */
	public Page<Record> getOrderHadCallBack(Page<Record> page, String siteId, Map<String, Object> map) {
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			String cate = nonService.servicemanCate(user.getId(), siteId);
			String brand = nonService.servicemanBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cate);
			brandList = StringUtil.tolist(brand);
		}
		String sites = CrmUtils.getSiteIdList(siteId);
		List<Record> list = orderDao.getOrderHadCallBack(page, siteId, sites, map, cateList, brandList);
		long count = orderDao.getOrderHadCallBackCount(siteId, sites, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	/*
	 * 待处理工单数据
	 */
	public Page<Record> getSecondWaitDealOrderList(Page<Record> page, String siteId, Map<String, Object> map) {
		List<Record> list = secondWaitDealOrderList(page, siteId, map);
		long count = secondWaitDealOrderCount(siteId, map);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	/*
	 * 一级网点下显示的二级网点工单数据
	 */
	public Page<Record> getWholeWaitDealOrderList(Page<Record> page, String siteId, Map<String, Object> map, String type) {
		// String sites = CrmUtils.getSiteIdList(siteId);全部的二级网点
		// String sites = CrmUtils.getSecondLevelSiteList(siteId, type);// type:1
		// 为直营网点，2为合作型网点

		List<Record> list = wholeWaitDealOrderList(page, siteId, map, type);
		long count = wholeWaitDealOrderCount(siteId, map);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 获取待处理工单tab的数量标签
	public Map<String, Object> getWholeOrderTabCount(String siteId) {
		// String sites = CrmUtils.getSiteIdList(siteId);
		Map<String, Object> map = new HashMap<String, Object>();
		// Long count = wholeWaitDealOrderCount(siteId, sites, map);
		Long count = (long) 0;
		map.put("count1", count);
		return map;
	}

	// 待处理工单列表查询
	public List<Record> secondWaitDealOrderList(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail,s.name as second_site_name FROM crm_order o left join crm_site s on s.id=o.site_id  ");
		sf.append(" WHERE o.parent_site_id=? ");
		sf.append(" AND o.parent_status IN ('1','2','6','7') ");
		sf.append(getOrderCondition(map));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC  "));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(), siteId);
	}

	// 待处理工单总条数查询
	public long secondWaitDealOrderCount(String siteId, Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_order o left join crm_site s on s.id=o.site_id  ");
		sf.append(" WHERE o.parent_site_id=?  ");
		sf.append(" AND o.parent_status IN ('1','2','6','7') ");
		sf.append(getOrderCondition(map));
		return Db.queryLong(sf.toString(), siteId);
	}

	// 二级网点全部工单列表查询
	public List<Record> wholeWaitDealOrderList(Page<Record> page, String siteId, Map<String, Object> map, String type) {
		String secondSiteId = map.get("secondSiteId").toString();
		String tableName = tableSplitMapper.mapOrder(secondSiteId);
		StringBuffer sf = new StringBuffer();
		sf.append("  SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) AS customerAddressDetail,e.name AS secSiteName,");
		sf.append(" ca.service_attitude,ca.remarks");
		sf.append("   FROM crm_order o  ");
		// type:1 为直营网点，2为合作型网点
		if ("1".equals(type)) {
			sf.append(" LEFT JOIN crm_order_callback  ca ON ca.order_id = o.id ");
		} else {
			sf.append(" LEFT JOIN crm_order_parent_callback ca ON ca.order_id = o.id ");
		}
		sf.append(" LEFT JOIN crm_site e ON e.id=o.site_id  ");
		sf.append("  WHERE ");
		if ("1".equals(map.get("parentType"))) {
			// 查看直营全部工单
			sf.append("  (o.site_id = '" + secondSiteId + "'  )");
		} else if ("3".equals(map.get("parentType"))) {
			// 自建
			sf.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id is null  )");
		} else {
			// 只查看指派工单
			sf.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id='" + siteId + "' )");
		}
		sf.append(getOrderCondition(map));
		
		if(StringUtils.isNotBlank(tableName)) {
			sf.append("  UNION  ALL ");
			sf.append("  SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) AS customerAddressDetail,e.name AS secSiteName,");
			sf.append(" ca.service_attitude,ca.remarks");
			sf.append("   FROM ").append(tableName);
			sf.append(" o  ");
			// type:1 为直营网点，2为合作型网点
			if ("1".equals(type)) {
				sf.append(" LEFT JOIN ").append(tableSplitMapper.mapOrderCallback(secondSiteId));
				sf.append(" ca ON ca.order_id = o.id ");
			} else {
				sf.append(" LEFT JOIN crm_order_parent_callback ca ON ca.order_id = o.id ");
			}
			sf.append(" LEFT JOIN crm_site e ON e.id=o.site_id  ");
			sf.append("  WHERE ");
			if ("1".equals(map.get("parentType"))) {
				// 查看直营全部工单
				sf.append("  (o.site_id = '" + secondSiteId + "'  )");
			} else if ("3".equals(map.get("parentType"))) {
				// 自建
				sf.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id is null  )");
			} else {
				// 只查看指派工单
				sf.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id='" + siteId + "' )");
			}
			sf.append(getOrderCondition(map));
			
		}
		sf.append(createOrderBy(map, " ORDER BY FIELD(`parent_status`,6,1,2,3,4,5,7),  create_time DESC  "));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	// 二级网点全部工单总条数查询
	public long wholeWaitDealOrderCount(String siteId, Map<String, Object> map) {
		String secondSiteId = map.get("secondSiteId").toString();
		String tableName = tableSplitMapper.mapOrder(secondSiteId);
		StringBuffer sf = new StringBuffer();
		sf.append("  SELECT count(*) ");
		sf.append("   FROM crm_order o ");
		sf.append(" LEFT JOIN crm_site e ON e.id=o.site_id  ");
		sf.append("  WHERE  ");
		if ("1".equals(map.get("parentType"))) {
			// 查看直营全部工单
			sf.append("  (o.site_id = '" + secondSiteId + "'  )");
		} else if ("3".equals(map.get("parentType"))) {
			// 自建
			sf.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id is null  )");
		} else {
			// 只查看指派工单
			sf.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id='" + siteId + "' )");
		}
		sf.append(getOrderCondition(map));
		long count =Db.queryLong(sf.toString());
		
		if(StringUtils.isNotBlank(tableName)) {
			StringBuffer sf1 = new StringBuffer();
			sf1.append("  SELECT count(*) ");
			sf1.append("   FROM ").append(tableSplitMapper.mapOrder(secondSiteId));
			sf1.append(" o ");
			sf1.append(" LEFT JOIN crm_site e ON e.id=o.site_id  ");
			sf1.append("  WHERE  ");
			if ("1".equals(map.get("parentType"))) {
				// 查看直营全部工单
				sf1.append("  (o.site_id = '" + secondSiteId + "'  )");
			} else if ("3".equals(map.get("parentType"))) {
				// 自建
				sf1.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id is null  )");
			} else {
				// 只查看指派工单
				sf1.append("  (o.site_id = '" + secondSiteId + "'  and o.parent_site_id='" + siteId + "' )");
			}
			sf.append(getOrderCondition(map));
			count = count + Db.queryLong(sf1.toString());
		}
		return count;
	}

	
	
	// 表头排序
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

	// 待处理工单查询条件
	public String getOrderCondition(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (StringUtil.checkParamsValid(map.get("number"))) {
			sf.append(" and o.number like '%" + (map.get("number")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("statuss"))) {
			String[] status = ((map.get("statuss").toString())).split(",");
			if (status.length > 0) {
				sf.append(" and o.status in (" + StringUtil.joinInSql(status) + ") ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("serviceType"))) {
			sf.append(" and o.service_type = '" + (map.get("serviceType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
			sf.append(" and o.appliance_category like '%" + (map.get("applianceCategory")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("applianceBrand"))) {
			sf.append(" and o.appliance_brand like '%" + (map.get("applianceBrand")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("applianceModel"))) {
			sf.append(" and  o.appliance_model like '%" + (map.get("applianceModel")) + "%'   ");
		}
		if (StringUtil.checkParamsValid((map.get("serviceMode")))) {
			sf.append(" and o.service_mode like '%" + (map.get("serviceMode")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("warrantyType"))) {
			sf.append(" and o.warranty_type = '" + (map.get("warrantyType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerName"))) {
			sf.append(" and o.customer_name like '%" + (map.get("customerName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerMobile"))) {
			sf.append(" and (o.customer_mobile like '%" + (map.get("customerMobile")) + "%' or o.customer_telephone like '%" + map.get("customerMobile")
					+ "%' or o.customer_telephone2 like '%" + map.get("customerMobile") + "%') ");
		}
		if (StringUtil.checkParamsValid(map.get("promiseTime"))) {
			sf.append(" and o.promise_time = '" + (map.get("promiseTime")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("signType"))) {
			String str[] = map.get("signType").toString().split(",");
			sf.append(" and o.flag in (" + StringUtil.joinInSql(str) + ")");
		}
		if (StringUtil.checkParamsValid(map.get("pleaseReferMall"))) {
			sf.append(" and o.please_refer_mall like '%" + (map.get("pleaseReferMall")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("remarks"))) {
			sf.append(" and o.remarks like '%" + (map.get("remarks")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("employeNames"))) {// 服务工程师
			String[] emps = ((map.get("employeNames").toString())).split(",");
			sf.append(" and ( ");
			for (int i = 0; i < emps.length; i++) {
				if (i == 0) {
					sf.append(" o.employe_name like '%" + emps[i] + "%' ");
				} else {
					sf.append(" or o.employe_name like '%" + emps[i] + "%' ");
				}
			}
			sf.append(" ) ");
		}
		if (StringUtil.checkParamsValid(map.get("origin"))) {
			sf.append(" and o.origin = '" + (map.get("origin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("elictrictyBarcode"))) {
			sf.append(" and ( o.appliance_barcode like '%" + (map.get("elictrictyBarcode")) + "%' or o.appliance_machine_code like '%" + (map.get("elictrictyBarcode")) + "%' )  ");
		}
		if (StringUtil.checkParamsValid((map.get("messengerName")))) {// 登记人
			SqlKit kit = new SqlKit().append("and exists(").append("select 1 from (").append("select user_id as id, name from crm_site").append("union all")
					.append("select user_id as id, name from crm_non_serviceman").append(") as t")
					.append("where t.id=o.create_by and t.name like '%" + map.get("messengerName") + "%'").append(")");

			sf.append(" ").append(kit.toString());
		}
		if (StringUtil.checkParamsValid(map.get("level"))) {
			sf.append(" and o.level = '" + (map.get("level")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerType"))) {// 用户类型
			sf.append(" and o.customer_type like '%" + (map.get("customerType")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMin"))) {
			sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + " 00:00:00'  ");
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMax"))) {
			sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + " 23:59:59' ");
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMin"))) {// 派工时间
			sf.append(" and o.dispatch_time >= '" + (map.get("dispatchTimeMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMax"))) {
			sf.append(" and o.dispatch_time <= '" + (map.get("dispatchTimeMax")) + " 23:59:59' ");
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMin"))) {
			sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMax"))) {
			sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + " 23:59:59'  ");
		}
		return sf.toString();
	}

	public List<Record> getSecondSiteList(String siteId) {
		return Db.find(
				"SELECT a.*,u.login_name,k.id as relId FROM crm_site a LEFT JOIN sys_user u ON u.id=a.user_id AND u.status='0' INNER JOIN (SELECT  g.site_id, g.create_time,g.id,g.site_type FROM crm_site_parent_rel g WHERE g.parent_site_id = ? AND g.status = '0') AS k ON k.site_id = a.id WHERE a.status = '0' order by k.create_time desc ",
				siteId);
	}

	public List<Record> getSecondSiteListAll(String siteId, String type) {
		return Db.find(
				"SELECT a.*,u.login_name,k.id as relId FROM crm_site a LEFT JOIN sys_user u ON u.id=a.user_id AND u.status='0' INNER JOIN (SELECT  g.site_id, g.create_time,g.id,g.site_type FROM crm_site_parent_rel g WHERE g.parent_site_id = ? AND g.status = '0') AS k ON k.site_id = a.id WHERE a.status = '0' and k.site_type='"
						+ type + "'  order by k.create_time desc ",
				siteId);
	}

	public Site getSiteById(String siteId) {
		return siteDao.get(siteId);
	}

	/**
	 * 待处理工单的新建工单中直接派单至网点，以及保存操作， 根据secondSiteId区别，secondSiteId不为空，则表示保存并派工值网点
	 * 否则就是仅仅保存
	 */
	@Transactional(rollbackFor = Exception.class)
	public void save(Order or, Map<String, Object> map) {
		String secondSiteId = map.get("secondSiteId").toString();
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Site site = siteDao.get(siteId);
		Date date = new Date();
		// NonServiceman no = null;
		or.setOrderType("6");
		// StringBuilder sfb = new StringBuilder();
		or.setCreateBy(user.getId());
		or.setParentSiteId(siteId);
		String name = "";
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = siteService.getUserSite(user.getId()).getName();
		} else {
			name = nonService.getNonServiceman(user).getName();
		}

		or.setStatus("9");
		Target ta = new Target();
		String dt1 = DateToStringUtils.DateToString();
		ta.setContent(name + "接入");
		ta.setName(name);
		ta.setType(Target.NEW_SECOND_ORDER);
		ta.setTime(dt1);
		String str = WebPageFunUtils.appendProcessDetail(ta, "");
		or.setLatestProcessTime(date);
		if (StringUtils.isNotBlank(secondSiteId)) {// 派工
			Site secondSite = siteDao.get(secondSiteId);
			or.setParentStatus(Order.PSTATUS_WAIT_RECV);
			or.setParentDipatchFlag("1");
			or.setSiteId(secondSiteId);
			or.setSiteName(secondSite.getName());
			Target ta1 = new Target();
			ta1.setContent(site.getName() + "派工至 " + secondSite.getName());
			ta1.setName(site.getName());
			ta1.setType(Target.DISPATCH_SECOND_ORDER);
			ta1.setTime(dt1);
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, str);
			or.setProcessDetail(str1);
			or.setLatestProcess(site.getName() + "派工至 " + secondSite.getName());
			or.setStatus("0");
		} else {
			or.setLatestProcess(or.getMessengerName() + "接入");
			or.setParentStatus(Order.PSTATUS_WAIT_DISPATCH);
			or.setParentDipatchFlag("0");
			or.setProcessDetail(str);
		}
		orderDao.save(or);
	}

	// 获取待处理工单tab的数量标签
	public Map<String, Object> getSecondOrderTabCount(String siteId) {
		Long count = Db.queryLong("select count(*) from crm_order a where a.parent_site_id=? and a.parent_status in('1','2','6','7')", siteId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("count1", count);
		return map;
	}

	// 合并之前已查出的所有的siteId,派工的二级网点列表
	public String hbIds(String siteIds, List<Record> list) {
		for (Record rd : list) {
			if (rd != null) {
				if (StringUtils.isBlank(siteIds)) {
					siteIds = rd.getStr("site_id");
				} else {
					siteIds = siteIds + "," + rd.getStr("site_id");
				}
			}
		}
		return siteIds;
	}

	// 将list1合并至list，派工的二级网点列表
	public List<Record> hbList(List<Record> list, List<Record> list1) {
		for (Record rd : list1) {
			if (rd != null) {
				list.add(rd);
			}
		}
		return list;
	}

	/*
	 * 查询派工给二级网点时的二级网点列表 完全匹配+品类匹配+品牌匹配+不匹配且品类品牌不全为空的+不匹配品类品牌全为空的
	 */
	public List<Record> getSecondSiteDetailMsg(String searchName, String siteId, String category, String brand) {
		List<Record> list = new ArrayList<Record>();
		String siteIds = "";
		List<Record> list1 = getSecondSiteDetailMsg1(searchName, siteId, category, brand);// 完全匹配
		siteIds = hbIds(siteIds, list1);
		list = hbList(list, list1);
		List<Record> list2 = getSecondSiteDetailMsg2(searchName, siteId, category, brand, siteIds);// 仅仅是品类匹配的
		siteIds = hbIds(siteIds, list2);
		list = hbList(list, list2);
		List<Record> list6 = getSecondSiteDetailMsg6(searchName, siteId, category, brand, siteIds);// 仅仅是品类匹配的
		if (list6.size() > 0) {
			for (Record rd : list6) {
				rd.set("b_name", "");
			}
		}
		siteIds = hbIds(siteIds, list6);
		list = hbList(list, list6);
		List<Record> list3 = getSecondSiteDetailMsg3(searchName, siteId, category, brand, siteIds);// 仅仅是品牌匹配的
		siteIds = hbIds(siteIds, list3);
		list = hbList(list, list3);
		List<Record> list4 = getSecondSiteDetailMsg4(searchName, siteId, category, brand, siteIds);// 完全不匹配的,品牌品类不全为空
		siteIds = hbIds(siteIds, list4);
		list = hbList(list, list4);
		List<Record> list5 = getSecondSiteDetailMsg7(searchName, siteId, category, brand, siteIds);
		if (list5.size() > 0) {
			for (Record rd : list5) {
				rd.set("b_name", "");
			}
		}
		siteIds = hbIds(siteIds, list5);
		list = hbList(list, list5);
		List<Record> list8 = getSecondSiteDetailMsg8(searchName, siteId, category, brand, siteIds);
		if (list5.size() > 0) {
			for (Record rd : list8) {
				rd.set("b_name", "");
			}
		}
		list = hbList(list, list8);
		return list;
	}

	// 提出相同的sql
	public String sameSql() {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT fn.*,rtc.c_name,rtc.b_name FROM ( SELECT a.site_id,a.site_type,s.name,s.province,s.city  ");
		sb.append("FROM (SELECT m.site_id,m.site_type FROM crm_site_parent_rel m WHERE m.parent_site_id =? ");
		sb.append("AND m.status = '0') AS a INNER JOIN crm_site s ON s.id = a.site_id ) AS fn LEFT JOIN  ");
		sb.append("(SELECT ct.name AS c_name,br.name AS b_name,sr.site_id AS s_site_id FROM crm_site_brand_rel sr INNER JOIN  crm_brand br ON br.id=sr.brand_id  ");
		sb.append("INNER JOIN crm_category ct ON ct.id=sr.category_id )  AS rtc  ON rtc.s_site_id=fn.site_id  ");
		return sb.toString();
	}

	// 品牌品类完全不匹配且不全为空
	public List<Record> getSecondSiteDetailMsg4(String searchName, String siteId, String category, String brand, String siteIds) {
		StringBuilder sb = new StringBuilder();
		sb.append(sameSql());
		sb.append("WHERE (rtc.c_name is not null or rtc.b_name is not null)  ");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and  (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		if (StringUtils.isNotBlank(siteIds)) {
			sb.append(" and fn.site_id not in (" + StringUtil.joinInSql(siteIds.split(",")) + ")");
		}
		sb.append(" GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId);// 完全不匹配的
	}

	// 品牌品类完全不匹配且不全为空,品类全都未维护品牌
	public List<Record> getSecondSiteDetailMsg7(String searchName, String siteId, String category, String brand, String siteIds) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT fn.*,rtc.c_name FROM (SELECT a.site_id,a.site_type,s.name, s.province,s.city FROM (SELECT m.site_id,m.site_type FROM crm_site_parent_rel m ");
		sb.append(" WHERE m.parent_site_id = ? AND m.status = '0') AS a INNER JOIN crm_site s ON s.id = a.site_id ) AS fn ");
		sb.append("  LEFT JOIN ( SELECT a.site_id,a.name AS c_name FROM crm_category a  WHERE a.del_flag='0' ) AS rtc ON rtc.site_id = fn.site_id  ");
		sb.append("where rtc.c_name is not null");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		if (StringUtils.isNotBlank(siteIds)) {
			sb.append(" and fn.site_id not in (" + StringUtil.joinInSql(siteIds.split(",")) + ")");
		}
		sb.append(" GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId);
	}

	// 品牌品类完全不匹配且不全为空,品类全都未维护品牌
	public List<Record> getSecondSiteDetailMsg8(String searchName, String siteId, String category, String brand, String siteIds) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT fn.*,rtc.c_name FROM (SELECT a.site_id,a.site_type,s.name, s.province,s.city FROM (SELECT m.site_id,m.site_type FROM crm_site_parent_rel m ");
		sb.append(" WHERE m.parent_site_id = ? AND m.status = '0') AS a INNER JOIN crm_site s ON s.id = a.site_id ) AS fn ");
		sb.append("  LEFT JOIN ( SELECT a.site_id,a.name AS c_name FROM crm_category a  WHERE a.del_flag='0' ) AS rtc ON rtc.site_id = fn.site_id  ");
		sb.append("where rtc.c_name is null");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		if (StringUtils.isNotBlank(siteIds)) {
			sb.append(" and fn.site_id not in (" + StringUtil.joinInSql(siteIds.split(",")) + ")");
		}
		sb.append(" GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId);
	}

	// 品牌匹配品类不匹配
	public List<Record> getSecondSiteDetailMsg3(String searchName, String siteId, String category, String brand, String siteIds) {
		StringBuilder sb = new StringBuilder();
		sb.append(sameSql());
		sb.append("WHERE  rtc.b_name=? ");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		if (StringUtils.isNotBlank(siteIds)) {
			sb.append(" and fn.site_id not in (" + StringUtil.joinInSql(siteIds.split(",")) + ")");
		}
		sb.append(" GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId, brand);// 非完全匹配的，即品牌完全匹配
	}

	// 品类匹配
	public List<Record> getSecondSiteDetailMsg6(String searchName, String siteId, String category, String brand, String siteIds) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT fn.*,rtc.c_name FROM (SELECT a.site_id,a.site_type,s.name, s.province,s.city FROM (SELECT m.site_id,m.site_type FROM crm_site_parent_rel m ");
		sb.append(" WHERE m.parent_site_id = ? AND m.status = '0') AS a INNER JOIN crm_site s ON s.id = a.site_id ) AS fn ");
		sb.append("  LEFT JOIN ( SELECT a.site_id,a.name AS c_name FROM crm_category a  WHERE a.del_flag='0' ) AS rtc ON rtc.site_id = fn.site_id  ");
		sb.append("where rtc.c_name=?");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		if (StringUtils.isNotBlank(siteIds)) {
			sb.append(" and fn.site_id not in (" + StringUtil.joinInSql(siteIds.split(",")) + ")");
		}
		sb.append(" GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId, category);// 非完全匹配的，即品类完全匹配
	}

	// 品类匹配
	public List<Record> getSecondSiteDetailMsg2(String searchName, String siteId, String category, String brand, String siteIds) {
		StringBuilder sb = new StringBuilder();
		sb.append(sameSql());
		sb.append("WHERE  rtc.c_name=? ");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		if (StringUtils.isNotBlank(siteIds)) {
			sb.append(" and fn.site_id not in (" + StringUtil.joinInSql(siteIds.split(",")) + ")");
		}
		sb.append(" GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId, category);// 非完全匹配的，即品类完全匹配
	}

	// 品类品牌完全匹配
	public List<Record> getSecondSiteDetailMsg1(String searchName, String siteId, String category, String brand) {// 完全匹配
		StringBuilder sb = new StringBuilder();
		sb.append(sameSql());
		sb.append("WHERE  rtc.c_name=? and rtc.b_name=?  ");
		if (StringUtils.isNotBlank(searchName)) {
			sb.append(" and (fn.name like '%" + searchName + "%' or fn.province like '%" + searchName + "%' or fn.city like '%" + searchName + "%') ");
		}
		sb.append("GROUP BY fn.site_id");
		return Db.find(sb.toString(), siteId, category, brand);// 完全匹配的，即品类品牌完全匹配
	}

	/*
	 * 待处理工单派工操作，目前不支持批量派工 派工后，parent_status:2(待网点接收)，status:0(待网点接收)
	 */
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> plDispatch(String ids, String siteId, String secondSiteId) {
		List<String> strList = new ArrayList<String>();
		for (String str : ids.split(",")) {
			strList.add(str);
		}
		String dt1 = DateToStringUtils.DateToString();
		Date date = new Date();
		Site site = siteDao.get(siteId);
		Site secondSite = siteDao.get(secondSiteId);
		List<Order> orderList = orderDao.getOrderByIdAndStatus(strList);
		for (Order od : orderList) {
			Target ta1 = new Target();
			ta1.setContent(site.getName() + "派工至 " + secondSite.getName());
			ta1.setName(site.getName());
			ta1.setType(Target.DISPATCH_SECOND_ORDER);
			ta1.setTime(dt1);
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, od.getProcessDetail());
			od.setProcessDetail(str1);
			od.setLatestProcess(site.getName() + "派工至 " + secondSite.getName());
			od.setParentStatus(Order.PSTATUS_WAIT_RECV);
			od.setParentDipatchFlag("1");
			od.setSiteId(secondSiteId);
			od.setLatestProcessTime(date);
			od.setStatus("0");
		}
		orderDao.save(orderList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "200");
		return map;
	}

	// 待处理工单转派操作，目前不支持批量转派parent_status:2，status:0
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> plDispatchZp(String ids, String siteId, String secondSiteId, String reason) {
		List<String> strList = new ArrayList<String>();
		for (String str : ids.split(",")) {
			strList.add(str);
		}
		String dt1 = DateToStringUtils.DateToString();
		Date date = new Date();
		Site site = siteDao.get(siteId);
		Site secondSite = siteDao.get(secondSiteId);
		List<Order> orderList = orderDao.getOrderByIdAndStsZp(strList);
		Target ta1 = new Target();
		ta1.setContent(site.getName() + "转派至 " + secondSite.getName() + "：" + reason);
		ta1.setName(site.getName());
		ta1.setType(Target.REDIRECT_DISPATCH_SECOND_ORDER);
		ta1.setTime(dt1);
		for (Order od : orderList) {
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, od.getProcessDetail());
			od.setProcessDetail(str1);
			od.setLatestProcess(site.getName() + "转派至 " + secondSite.getName() + "：" + reason);
			od.setParentStatus(Order.PSTATUS_WAIT_RECV);
			od.setParentDipatchFlag("2");
			od.setSiteId(secondSiteId);
			od.setSiteName(secondSite.getName());
			od.setLatestProcessTime(date);
			od.setStatus("0");
		}
		orderDao.save(orderList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "200");
		return map;
	}

	/**
	 * 取消工单：（只有一级网点待处理的工单，待处理的工单1,2,6,7可以直接封单），封单操作将parentstatus:5,status置为8。
	 * 已经取消的工单也显示在已回访的列表中.@领导英明的决策@01/25
	 * 
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public String wdplfd(String id, String latestProcess) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<String> strList = new ArrayList<>();
		strList.addAll(Arrays.asList(id.split(",")));
		String dt1 = DateToStringUtils.DateToString();
		Date date = new Date();
		Site site = siteDao.get(siteId);
		List<Order> orderList = orderDao.getOrderByIdZjfd(strList);

		Target ta1 = new Target();
		ta1.setContent(site.getName() + "取消工单 ：" + latestProcess);
		ta1.setName(site.getName());
		ta1.setType(Target.DIRECTLY_CLOSE_SECOND_ORDER);
		ta1.setTime(dt1);
		for (Order od : orderList) {
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, od.getProcessDetail());
			od.setProcessDetail(str1);
			od.setLatestProcess(site.getName() + "取消工单 ：" + latestProcess);
			od.setParentStatus(Order.PSTATUS_CANCEL);
			od.setStatus("6");// 一级网点直接封单，对应二级网点来说，工单就是取消了。
			od.setEndTime(date);
			od.setLatestProcessTime(date);
			od.setSiteName(null);
			od.setSiteId(null);
		}
		orderDao.save(orderList);
		return "200";
	}

	// 接收工单
	@Transactional(rollbackFor = Exception.class)
	public Result<Void> recvOrders(String orderIds) {
		// 网点应该是二级网点，工单的状态应该是待接收
		String[] orderIdList = orderIds.split(",");
		List<Order> orders = orderDao.getOrderById(orderIdList);
		String uname = CrmUtils.getUserXM();
		String siteName = CrmUtils.getSiteName();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());

		for (Order o : orders) {
			if (!siteId.equals(o.getSiteId())) {
				return Result.fail("422", "order gone"); // 可能是转派
			}
			if (!Order.PSTATUS_WAIT_RECV.equals(o.getParentStatus())) {
				return Result.fail("order status invalid");
			} else {
				o.setStatus("1");
				o.setParentStatus(Order.PSTATUS_SERVING);
				o.setLatestProcess("接收一级网点派单");
				o.setLatestProcessTime(new Date());
				o.newTarget(Target.ACCEPT_ORDER, uname, String.format("%s 接收一级网点派单", siteName));
			}
		}
		orderDao.save(orders);
		orderDao.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_jsyjwdgd);
		return Result.ok();
	}

	// 拒接工单(没接收，没派工的情况下，可以退回。)
	@Transactional(rollbackFor = Exception.class)
	public Result<Void> refuseOrders(String orderIds) {
		// 网点应该是二级网点，工单的状态应该是待接收
		String[] orderIdList = orderIds.split(",");
		List<Order> orders = orderDao.getOrderById(orderIdList);
		String uname = CrmUtils.getUserXM();
		String siteName = CrmUtils.getSiteName();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		for (Order o : orders) {
			if (StringUtil.isBlank(o.getParentSiteId())) {
				return Result.fail("423", "level 1 site order required"); // 只能拒绝1级网点派工的工单，不能是自建工单。
			}

			if (!siteId.equals(o.getSiteId())) {
				return Result.fail("422", "order gone"); // 可能是转派
			}
			if (!"0".equals(o.getStatus()) && !"1".equals(o.getStatus())) {
				return Result.fail("order status invalid");
			} else {
				o.setStatus("9"); // 未指派
				o.setParentStatus(Order.PSTATUS_REFUSED);
				o.setLatestProcess("二级网点拒接工单");
				o.setLatestProcessTime(new Date());
				o.newTarget(Target.REJECT_ORDER, uname, String.format("%s 二级网点拒接工单", siteName));
				orderDao.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_jjyjwdgd);
				orderDao.onOrderCountChanged(o.getParentSiteId(), OrderCountChangeTypes.TYPE_jjyjwdgd);
			}
		}
		orderDao.save(orders);
		return Result.ok();
	}

	@Transactional(rollbackFor = Exception.class)
	public Result<Void> returnSiteOrder(String orderId) {
		// 网点应该是二级网点，工单的状态应该是待接收
		Order o = orderDao.get(orderId);
		String siteName = CrmUtils.getSiteName();
		String creaName = CrmUtils.getUserXM();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (StringUtil.isBlank(o.getParentSiteId())) {
			return Result.fail("423", "level 1 site order required"); // 只能拒绝1级网点派工的工单，不能是自建工单。
		}
		if ("2".equals(o.getStatus())) {
			// 更改派工表信息
			Db.update("UPDATE crm_order_dispatch SET status = '7' WHERE order_id = ? AND status <> '6' ", orderId);
		}
		String parentSiteId = o.getParentSiteId();
		o.setStatus("1"); // 未指派
		o.setEmployeId("");
		o.setEmployeName("");
		o.setParentStatus(Order.PSTATUS_WAIT_DISPATCH);
		o.setParentSiteId("");
		o.setParentDipatchFlag("0");
		o.setSiteId(siteId);
		o.setSiteName(siteName);
		o.setLatestProcess("返回一级网点待派工");
		o.setLatestProcessTime(new Date());
		o.newTarget(Target.REJECT_ORDER, creaName, String.format("%s 返回一级网点待派工", siteName));
		orderDao.save(o);
		orderDao.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_fhgd);
		orderDao.onOrderCountChanged(parentSiteId, OrderCountChangeTypes.TYPE_fhgd);
		return Result.ok();
	}

	public List<Record> getEmployeBuSiteId(String siteId, String category) {
		List<Record> list = new ArrayList<Record>();
		list = Db.find(
				"SELECT a.* FROM crm_employe a inner join sys_user u on a.user_id=u.id LEFT JOIN crm_category b ON b.del_flag='0' AND FIND_IN_SET(b.id,a.category) AND b.site_id=? WHERE a.status='0' and u.status='0' AND a.site_id=? and b.name=? GROUP BY a.id\r\n"
						+ " order by a.create_time,a.id asc",
				siteId, siteId, category);
		if (list.size() == 0) {
			list = Db.find("select a.* from crm_employe a inner join sys_user u on a.user_id=u.id  where a.status='0' and a.site_id=? and u.status='0' GROUP BY a.id\r\n"
					+ " order by a.create_time,a.id asc ", siteId);
		}
		return list;
	}

	public List<Record> getSearchSiteList(String siteId) {
		return Db.find(
				"SELECT a.site_type,a.site_id,b.name FROM crm_site_parent_rel a INNER JOIN crm_site b ON a.site_id=b.id WHERE a.status='0' AND b.status='0' AND a.parent_site_id=? GROUP BY a.id ORDER BY a.create_time,a.id ASC",
				siteId);
	}

	public List<Order> getOrderByIdAndDispatchStatus(String orderId, String status) {
		SQLQuery sql = orderDao.getSession()
				.createSQLQuery("select  a.* from crm_order a where a.status in(" + status + ") and a.id in(" + StringUtil.joinInSql(orderId.split(",")) + ")")
				.addEntity(Order.class);
		List<Order> list = sql.list();
		return list;
	}

	public List<Order> getOrderByIdAndDispatchStatus1(String orderId, String parentStatus, String status) {
		SQLQuery sql = orderDao.getSession().createSQLQuery("select  a.* from crm_order a where (a.parent_status in(" + parentStatus + ") or a.status in (" + status
				+ ")) and a.id in(" + StringUtil.joinInSql(orderId.split(",")) + ") ").addEntity(Order.class);
		List<Order> list = sql.list();
		return list;
	}

	// 最新-派工保存
	@Transactional(rollbackFor = Exception.class)
	public String dispatchOrderSave(Map<String, Object> map) {
		String orderId = map.get("orderId").toString();
		List<Order> odList = getOrderByIdAndDispatchStatus1(orderId, "'1','6'", "'1','7'");
		if (odList.size() < 1) {
			return "420";
		}
		String thisSiteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String mark = map.get("mark").toString();// 1派工至网点 2 派工至服务工程师
		String siteId = map.get("siteId").toString();
		String empIds = map.get("empIds") != null ? map.get("empIds").toString() : "";
		String empNames = map.get("empIds") != null ? map.get("empNames").toString() : "";

		String dt1 = DateToStringUtils.DateToString();
		Date date = new Date();
		Site site = siteDao.get(thisSiteId);
		Site secondSite = siteDao.get(siteId);

		if ("1".equals(mark)) {// 1派工至网点
			Target ta1 = new Target();
			ta1.setContent(site.getName() + "派工至 " + secondSite.getName());
			ta1.setName(site.getName());
			ta1.setType(Target.DISPATCH_SECOND_ORDER);
			ta1.setTime(dt1);
			for (Order od : odList) {
				//校验工单编号是否存在
				Record orn = orderDao.getorderNumber(od.getNumber(), siteId);
				if(orn != null) {
					return "420";
				}
				String str1 = WebPageFunUtils.appendProcessDetail(ta1, od.getProcessDetail());
				od.setLatestProcessTime(date);
				od.setParentDipatchFlag("1");
				od.setSiteId(siteId);
				od.setSiteName(secondSite.getName());
				od.setParentSiteId(thisSiteId);
				od.setProcessDetail(str1);
				od.setLatestProcess(site.getName() + "派工至 " + secondSite.getName());// 一级网点派工至二级网点
				od.setParentStatus(Order.PSTATUS_WAIT_RECV);
				od.setLatestProcessTime(date);
				od.setStatus("0");
				od.setOrderType("6");
				orderDao.save(od);
				orderDao.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_yjwdpg);
				orderDao.onOrderCountChanged(thisSiteId, OrderCountChangeTypes.TYPE_yjwdpg);
			}

			return "200";
		} else {// 2 派工至服务工程师
			Target ta2 = new Target();
			ta2.setContent(site.getName() + "派工至 " + secondSite.getName() + "的" + empNames);
			ta2.setName(site.getName());
			ta2.setType(Target.ONESITE_DISPATCH_SECONDSITE_EMPLOYES);
			ta2.setTime(dt1);

			for (Order od : odList) {
				//校验工单编号是否存在
				Record orn = orderDao.getorderNumber(od.getNumber(), siteId);
				if(orn != null) {
					return "420";
				}
				String str2 = WebPageFunUtils.appendProcessDetail(ta2, od.getProcessDetail());
				od.setLatestProcessTime(date);
				od.setEmployeId(empIds);
				od.setEmployeName(empNames);
				od.setOrderType("6");
				od.setUpdateTime(date);
				od.setSiteId(siteId);
				od.setParentSiteId(thisSiteId);
				od.setSiteName(secondSite.getName());
				od.setProcessDetail(str2);
				od.setLatestProcess(site.getName() + "派工至 " + secondSite.getName() + "的" + empNames);// 一级网点派工至二级网点
				od.setParentStatus(Order.PSTATUS_SERVING);// 服务中
				od.setParentDipatchFlag("1");
				od.setSiteId(siteId);
				od.setLatestProcessTime(date);
				od.setStatus("2");// 服务中
				orderDao.save(od);
				OrderDispatch ods = new OrderDispatch();
				ods.setDispatchTime(date);
				ods.setOrder(od);
				ods.setMessengerId(site.getId());
				ods.setMessengerName(site.getName());
				ods.setStatus("1");
				ods.setEmployeName(empNames.split(",")[0]);
				ods.setSiteId(siteId);
				orderDispatchDao.save(ods);
				for (int i = 0; i < empIds.split(",").length; i++) {
					OrderDispatchEmployeRel oder = new OrderDispatchEmployeRel();
					oder.setDispatchId(ods.getId());
					oder.setEmpId(empIds.split(",")[i]);
					oder.setEmpName(empNames.split(",")[i]);
					oder.setOrderId(od.getId());
					oder.setSiteId(siteId);
					orderDispatchEmployeRelDao.save(oder);
				}
			}
			orderDao.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_yjwdpg);
			orderDao.onOrderCountChanged(thisSiteId, OrderCountChangeTypes.TYPE_yjwdpg);
			return "200";
		}
	}

	// 最新-转派保存
	@Transactional(rollbackFor = Exception.class)
	public String dispatchChangeOrderSave(Map<String, Object> map) {
		String orderId = map.get("orderId").toString();
		String origin = map.get("origin") != null ? map.get("origin").toString() : "";
		String sts = "'0','1','2','7'";// 直营型型网点-服务中-可以转派
		if ("hz".equals(origin)) {// 合作型网点-服务中-禁止转派
			sts = "'0','1','7'";
		}
		List<Order> odList = getOrderByIdAndDispatchStatus(orderId, sts);
		if (odList.size() < 1) {
			return "420";
		}
		Set<String> oldSiteIds = new HashSet<>();
		String thisSiteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String mark = map.get("mark").toString();// 1派工至网点 2 派工至服务工程师
		String siteId = map.get("siteId").toString();
		String reason = map.get("zpReson").toString();
		String empIds = map.get("empIds") != null ? map.get("empIds").toString() : "";
		String empNames = map.get("empIds") != null ? map.get("empNames").toString() : "";

		String dt1 = DateToStringUtils.DateToString();
		Date date = new Date();
		Site site = siteDao.get(thisSiteId);
		Site secondSite = siteDao.get(siteId);
		for (Order od : odList) {
			oldSiteIds.add(od.getSiteId());
			SQLQuery dispatchSql = orderDao.getSession()
					.createSQLQuery("update crm_order_dispatch a set a.status='7' where a.status in ('1','2','3','4','5') and a.order_id='" + od.getId() + "'");
			dispatchSql.executeUpdate();
			od.setLatestProcessTime(date);
			if ("1".equals(mark)) {// 1转派至网点
				Target ta1 = new Target();
				ta1.setContent(site.getName() + "转派至 " + secondSite.getName() + "：" + reason);
				ta1.setName(site.getName());
				ta1.setType(Target.REDIRECT_DISPATCH_SECOND_ORDER);
				ta1.setTime(dt1);
				String str1 = WebPageFunUtils.appendProcessDetail(ta1, od.getProcessDetail());
				od.setProcessDetail(str1);
				od.setLatestProcess(site.getName() + "转派至 " + secondSite.getName() + "：" + reason);
				od.setParentStatus(Order.PSTATUS_WAIT_RECV);
				od.setParentDipatchFlag("2");
				od.setSiteId(siteId);
				od.setOrderType("6");
				od.setEmployeId("");
				od.setEmployeName("");
				od.setParentSiteId(thisSiteId);
				od.setSiteName(secondSite.getName());
				od.setLatestProcessTime(date);
				od.setStatus("0");
				orderDao.save(od);

			} else {// 2 转派至服务工程师
				Target ta2 = new Target();
				ta2.setContent(site.getName() + "转派至 " + secondSite.getName() + "的" + empNames + "：" + reason);
				ta2.setName(site.getName());
				ta2.setType(Target.ONESITE_DISPATCHCHANGE_SECONDSITE_EMPLOYES);
				ta2.setTime(dt1);
				String str2 = WebPageFunUtils.appendProcessDetail(ta2, od.getProcessDetail());
				od.setEmployeId(empIds);
				od.setEmployeName(empNames);
				od.setUpdateTime(date);
				od.setSiteId(siteId);
				od.setOrderType("6");
				od.setParentSiteId(thisSiteId);
				od.setSiteName(secondSite.getName());
				od.setProcessDetail(str2);
				od.setLatestProcess(site.getName() + "转派至 " + secondSite.getName() + "的" + empNames + "：" + reason);// 一级网点派工至二级网点的工程师
				od.setParentStatus(Order.PSTATUS_SERVING);// 服务中
				od.setParentDipatchFlag("2");
				od.setSiteId(siteId);
				od.setLatestProcessTime(date);
				od.setStatus("2");// 服务中
				orderDao.save(od);
				OrderDispatch ods = new OrderDispatch();
				ods.setDispatchTime(date);
				ods.setOrder(od);
				ods.setMessengerId(site.getId());
				ods.setMessengerName(site.getName());
				ods.setStatus("1");
				ods.setEmployeName(empNames.split(",")[0]);
				ods.setSiteId(siteId);
				orderDispatchDao.save(ods);
				for (int i = 0; i < empIds.split(",").length; i++) {
					OrderDispatchEmployeRel oder = new OrderDispatchEmployeRel();
					oder.setDispatchId(ods.getId());
					oder.setEmpId(empIds.split(",")[i]);
					oder.setEmpName(empNames.split(",")[i]);
					oder.setOrderId(od.getId());
					oder.setSiteId(siteId);
					orderDispatchEmployeRelDao.save(oder);
				}

			}
		}
		orderDao.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_yjwdzp);
		orderDao.onOrderCountChanged(thisSiteId, OrderCountChangeTypes.TYPE_yjwdzp);
		for (String oldSiteId : oldSiteIds) {
			orderDao.onOrderCountChanged(oldSiteId, OrderCountChangeTypes.TYPE_yjwdzp);
		}
		return "200";
	}

	public Map<String, Object> getConditionsDataBySiteId(String siteId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Record> serviceModelList = new ArrayList<Record>();// 服务类型
		List<Record> serviceTypeList = new ArrayList<Record>();// 服务方式
		List<Record> employeList = new ArrayList<Record>();// 服务工程师
		List<Record> originList = new ArrayList<Record>();// 信息来源
		List<Record> customerTypeList = new ArrayList<Record>();// 用户类型
		List<Record> categoryList = new ArrayList<Record>();// 家电品类
		List<Record> markList = new ArrayList<Record>();// 标记类型
		if (StringUtils.isNotBlank(siteId)) {
			StringBuilder sf = new StringBuilder();
			sf.append(" SELECT * FROM ( ");
			sf.append("SELECT * FROM crm_service_mode a ");
			sf.append(" WHERE a.site_id = '0' AND a.status = '0' AND NOT EXISTS ");
			sf.append(" ( ");
			sf.append(" 	SELECT b.* FROM crm_service_mode b, crm_site si ");
			sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
			sf.append(" 	) ");
			sf.append(" UNION ");
			sf.append(" SELECT b.* FROM crm_service_mode b, crm_site si ");
			sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? ");
			sf.append("  ) ass ORDER BY ass.sort ASC  ");
			serviceModelList = ServiceTypeDao.getServiceTypeList(siteId);
			serviceTypeList = Db.find(sf.toString(), siteId, siteId);
			employeList = CrmUtils.getEmloyeListForAll(siteId);
			originList = orderOriginService.filterOrderOrigin(siteId);
			customerTypeList = CustomerTypeDao.getCustomerTypeList(siteId);
			categoryList = CategoryUtils.getListCategorySite(siteId);
			markList = Db.find("select id,name from crm_order_mark_settings where site_id=? and status='0' order by sort asc", siteId);
		}
		map.put("serviceModelList", serviceModelList.size() > 0 ? serviceModelList : "");
		map.put("serviceTypeList", serviceTypeList.size() > 0 ? serviceTypeList : "");
		map.put("employeList", employeList.size() > 0 ? employeList : "");
		map.put("originList", originList.size() > 0 ? originList : "");
		map.put("customerTypeList", customerTypeList.size() > 0 ? customerTypeList : "");
		map.put("categoryList", categoryList.size() > 0 ? categoryList : "");
		map.put("markList", markList.size() > 0 ? markList : "");
		return map;
	}

}