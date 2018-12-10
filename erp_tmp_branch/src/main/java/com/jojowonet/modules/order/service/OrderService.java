/**
 */
package com.jojowonet.modules.order.service;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicLong;

import org.apache.poi.ss.formula.functions.T;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.fmss.utils.DBUtils;
import com.jojowonet.modules.fmss.utils.DataUtils;
import com.jojowonet.modules.operate.dao.EmployeDao;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.dao.SendedSmsDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.operate.entity.SendedSms;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import com.jojowonet.modules.order.dao.Order2017Dao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.dao.OrderDispatchDao;
import com.jojowonet.modules.order.dao.ServiceModeDao;
import com.jojowonet.modules.order.dao.ServiceTypeDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderDispatch;
import com.jojowonet.modules.order.form.OrderReturnVisit;
import com.jojowonet.modules.order.form.vo.CrmOrder400Vo;
import com.jojowonet.modules.order.service.excel.EOrderExcelImportHandler;
import com.jojowonet.modules.order.service.excel.HistoryOrderExcelImportHandler;
import com.jojowonet.modules.order.service.excel.UnfinishedOrderExcelImportHandler;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
import com.jojowonet.modules.order.utils.OrderCountChangeTypes;
import com.jojowonet.modules.order.utils.RandomUtil;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SimpleOrderNo;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.TableSplitMapper;
import com.jojowonet.modules.order.utils.WebPageFunUtils;
import com.jojowonet.modules.order.utils.excelExt.ExcelReader;
import com.jojowonet.modules.order.web.OrderController;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import com.jojowonet.modules.sys.db.DbKey;
import com.jojowonet.modules.sys.util.NetworkException;
import com.jojowonet.modules.sys.util.SMSUtils;
import com.jojowonet.modules.sys.util.SfSmsUtils;
import com.jojowonet.modules.sys.util.http.EzTemplate;
import com.jojowonet.modules.sys.util.http.Order400EzTemplate;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

/**
 * 工单Service
 * 
 * @author Ivan
 * @version 2017-05-04
 */
@Component
public class OrderService extends BaseService {

	@Autowired
	private NonServicemanDao nonDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private OrderDispatchDao disDao;
	@Autowired
	private EmployeDao empDao;
	@Autowired
	private NonServicemanDao noDao;

	@Autowired
	private SiteService siteService;
	@Autowired
	private SendedSmsDao sendedSmsDao;

	@Autowired
	private EzTemplate ezTemplate;
	@Autowired
	private OrderDispatchService orderDispatchService;

	@Autowired
	private ServiceTypeDao serviceTypeDao;

	@Autowired
	private ServiceModeDao serviceModeDao;

	@Autowired
	private PushMessageService pushMessageService;

	@Autowired
	private SiteMsgService siteMsgService;

	@Autowired
	private Order2017Dao order2017Dao;

	@Autowired
	private SmsService smsService;
	@Autowired
	private SfCacheService sfCacheService;
	@Autowired
	private Order400EzTemplate ez400Template;
	@Autowired
	private TableSplitMapper tableSplitMapper;

	public Order get(String id) {
		return orderDao.getByHql(" from Order a where a.id = :p1", new Parameter(id));
	}

	public Record get2017(String id, String siteId) {
		return order2017Dao.findOrderById(id, siteId);
	}

	public Page<Order> find(Page<Order> page, Order order) {
		DetachedCriteria dc = orderDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(order.getId())) {
			dc.add(Restrictions.like("name", "%" + order.getId() + "%"));
		}
		dc.add(Restrictions.eq("delFlag", "0"));

		return orderDao.find(page, dc);
	}

	public Page<Record> getOrderWaitForDis(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderWaitForDis(page, siteId, status, map, cateList, brandList);
		long count = orderDao.getOrderWaitCount(siteId, status, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 全部工单信息
	public Page<Record> getOrderHis(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderWaitForDhf(page, siteId, status, map, cateList, brandList);
		long count = orderDao.getOrderWaitDhfCount(siteId, status, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 全部工单信息
	public Page<Record> getOrderWholeList(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList,
			boolean hasCondition) {
		List<Record> list = orderDao.getOrderWholeList(page, siteId, status, map, cateList, brandList);
		long orderCount;
		if (page.getPageNo() == 1 && list.size() < page.getPageSize()) {
			orderCount = list.size();
		} else {
			if (!hasCondition) { // 如果不带查询参数，那么试图从缓存读取
				orderCount = getTotalOrderCount(siteId, status, map, cateList, brandList);
			} else {
				orderCount = orderDao.getWholeOrderCount(siteId, status, map, cateList, brandList);
			}
		}

		if (CrmUtils.isDev() && !hasCondition) { // this block is for debug only
			logger.warn("warning run in debug mode");
			long realTimeCount = orderDao.getWholeOrderCount(siteId, status, map, cateList, brandList);
			if (realTimeCount != orderCount) {
				onOrderCountChanged(siteId, "inconsistency found");
				throw new RuntimeException("detect unexpected count, real.count=" + realTimeCount + ";cached.count=" + orderCount);
			}
		}

		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(orderCount);
		return page;
	}

	// 细分菜单
	public Page<Record> getOrderWaitForDisoType(Page<Record> page, String siteId, String status, String otype, Map<String, Object> map, List<String> cateList,
			List<String> brandList) {
		List<Record> list = orderDao.getOrderWaitForDisType(page, status, siteId, otype, map, cateList, brandList);
		long count = orderDao.getOrderWaitCountType(siteId, status, otype, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 待回访结算，历史导出
	public List<Record> getOrderHistoryList(Page<Record> pages, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderWaitForDhf(pages, siteId, status, map, cateList, brandList);
		for (Record rd : list) {
			BigDecimal auxiliaryCost = rd.getBigDecimal("auxiliary_cost");
			BigDecimal serveCost = rd.getBigDecimal("serve_cost");
			BigDecimal warrantyCost = rd.getBigDecimal("warranty_cost");
			rd.set("totalMoney", auxiliaryCost.add(serveCost).add(warrantyCost));
		}
		return list;
	}

	// 短信发送失败的历史工单导出
	public List<Record> getWrongNumberOrderHistoryList(String siteId, String status, Map<String, Object> map, String number, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderWrongWaitForDhf(null, siteId, status, map, number, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		return list;
	}

	// 待派工维修中导出
	public List<Record> getOrderList(Page<Record> pages, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		return orderDao.getOrderWaitForDis(pages, siteId, status, map, cateList, brandList);
	}

	// 待派工维修中导出
	public List<Record> getWrongNumberOrderDuringList(String siteId, String status, Map<String, Object> map, String number, List<String> cateList, List<String> brandList) {
		return orderDao.getOrderWaitForDisDuring(siteId, status, map, number, cateList, brandList);
	}

	// 细分导出
	public List<Record> getOrderListRecord(Page<Record> pages, String siteId, String status, String otype, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderWaitForDisType(pages, status, siteId, otype, map, cateList, brandList);
		for (Record rd : list) {
			BigDecimal auxiliaryCost = rd.getBigDecimal("auxiliary_cost");
			BigDecimal serveCost = rd.getBigDecimal("serve_cost");
			BigDecimal warrantyCost = rd.getBigDecimal("warranty_cost");
			rd.set("totalMoney", auxiliaryCost.add(serveCost).add(warrantyCost));
		}
		return list;
	}

	@Transactional
	public void persist(Order or) {
		orderDao.save(or);
	}

	public Long numberCount1(String orderNumber) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return numberCount1(orderNumber, siteId);
	}

	public Long numberCount1(String orderNumber, String siteId) {
		String orderTable = tableSplitMapper.mapOrder(siteId);
		Long aLong = Db.queryLong("select count(*) from crm_order a where a.number=? and site_id=?", orderNumber, siteId);
		if (aLong <= 0) {
			return Db.queryLong("select count(*) from " + orderTable + " a where a.number=? and site_id=?", orderNumber, siteId);
		}
		return aLong;
	}

	@Transactional(rollbackFor = Exception.class)
	public void save(Order or, String userId) {
		User user = UserUtils.getUser();
		String ori = "";
		if (StringUtils.isNotBlank(userId)) {
			user = UserUtils.getUserById(userId);
			ori = "从小程序";
		}
		String siteId = CrmUtils.getCurrentSiteId(user);
		Site site = siteDao.get(siteId);
		Date date = new Date();
		String uname = CrmUtils.getCreateName(user);
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			or.setMessengerId(site.getId());
			or.setMessengerName(site.getName());

		} else {
			no = noDao.getNonServiceman(user);
			or.setMessengerId(no.getId());
			or.setMessengerName(no.getName());

		}
		if (StringUtil.isNotBlank(or.getFactoryNumber())) {
			or.setRecordAccount("1");
		}
		StringBuilder sfb = new StringBuilder();
		or.setCreateBy(user.getId());
		or.setSiteId(siteId);
		or.setSiteName(site.getName());
		or.setLatestProcess(uname + ori + "接入");
		or.setLatestProcessTime(date);
		if (StringUtils.isNotEmpty(or.getEmployeId())) {
			Target ta = new Target();
			ta.setTime(DateToStringUtils.DateToString());
			ta.setName(uname);
			ta.setType(Target.NEW_ORDER);
			ta.setContent(uname + "接入");
			String str = WebPageFunUtils.appendProcessDetail(ta, "");
			or.setStatus("1");
			or.setProcessDetail(str);
			orderDao.save(or);
			Target ta1 = new Target();
			ta1.setTime(DateToStringUtils.DateToString());
			ta1.setName(uname);
			ta1.setType(Target.DISPATCH_ORDER);
			or.setLatestProcessTime(date);
			or.setStatus("2");

			String[] empId = or.getEmployeId().split(",");
			String empName = "";

			for (String id : empId) {
				Employe em = empDao.get(id);
				if (empName == "") {
					empName = em.getName();
				} else {
					empName = empName + "," + em.getName();
				}
			}
			or.setEmployeName(empName);
			ta1.setContent(uname + "派工至 " + empName);
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, or.getProcessDetail());
			or.setProcessDetail(str1);
			or.setLatestProcess(uname + " 派工至  " + empName);
			sfb.append(uname + "派工至" + empName);
			or.setDispatchTime(date);// 派工时间
			orderDao.save(or);
			OrderDispatch od = new OrderDispatch();
			od.setOrder(or);
			od.setSiteId(siteId);
			od.setEmployeId(or.getEmployeId());
			od.setEmployeName(empName);
			if (User.USER_TYPE_SIT.equals(user.getUserType())) {
				or.setMessengerId(site.getId());
				or.setMessengerName(site.getName());
			} else {
				or.setMessengerId(no.getId());
				or.setMessengerName(no.getName());
			}
			disDao.save(od);
			List<String> list = Lists.newArrayList();
			for (String eId : empId) {
				Employe em = empDao.get(eId);
				StringBuffer sf = new StringBuffer();
				sf.append("INSERT INTO crm_order_dispatch_employe_rel (id,order_id, dispatch_id, emp_id, emp_name, site_id) VALUES( ");
				sf.append("'" + IdGen.uuid() + "', '" + or.getId() + "', '" + od.getId() + "', '" + em.getId() + "', '" + em.getName() + "', '" + siteId + "') ");
				list.add(sf.toString());
			}
			saveRel(list);

			// 派工推送消息
			Map<String, String> idMap = Maps.newHashMap();
			String oId = or.getId();
			String num = or.getNumber();
			idMap.put(oId, num);
			pushMessageService.notifyOrder(idMap, "1", "");// 推送消息

		} else {
			Target ta = new Target();
			/*
			 * if (User.USER_TYPE_SIT.equals(user.getUserType())) { uname =
			 * siteService.getUserSite(user.getId()).getName(); }
			 */
			ta.setContent(uname + "接入");
			ta.setName(uname);
			ta.setType(Target.NEW_ORDER);
			ta.setTime(DateToStringUtils.DateToString());
			String str = WebPageFunUtils.appendProcessDetail(ta, "");
			or.setStatus("1");
			or.setProcessDetail(str);
			orderDao.save(or);
		}
		onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_xjgd);
	}

	/**
	 * 来电弹屏新建工单
	 * 
	 * @param or
	 */
	@Transactional(rollbackFor = Exception.class)
	public void callShowSave(Order or, String seriNo) {
		String s = "select * from crm_site_tele_device where serial_no='" + seriNo + "' and status='0' ";
		Record reco = Db.findFirst(s);
		String siteId = reco.getStr("site_id");

		String sqm = "SELECT a.user_id FROM crm_non_serviceman a where id='" + or.getMessengerId() + "' ";
		String userId = Db.queryStr(sqm);
		/*
		 * String sq="select * from  crm_site where name='"+or.getMessengerName()+"' ";
		 * Record rec=Db.findFirst(sq);
		 */

		Site site = siteDao.get(siteId);
		Date date = new Date();

		/*
		 * or.setMessengerId(rec.getStr("id")); or.setMessengerName(rec.getStr("name"));
		 */

		StringBuffer sfb = new StringBuffer();
		// or.setCreateBy(rec.getStr("user_id"));
		or.setCreateBy(userId);
		or.setSiteId(siteId);
		or.setSiteName(site.getName());

		Record re = Db.findFirst("SELECT a.name FROM crm_non_serviceman a where a.id=? ", or.getMessengerId());
		String messageName = re.getStr("name");
		or.setLatestProcess(messageName + "接入");
		or.setLatestProcessTime(date);
		if (StringUtils.isNotEmpty(or.getEmployeId())) {
			Target ta = new Target();
			ta.setTime(DateToStringUtils.DateToString());
			ta.setName(messageName);
			ta.setType(Target.NEW_ORDER);
			ta.setContent(messageName + "接入");
			String str = WebPageFunUtils.appendProcessDetail(ta, "");
			or.setStatus("1");
			or.setProcessDetail(str);
			orderDao.save(or);
			Target ta1 = new Target();
			ta1.setTime(DateToStringUtils.DateToString());
			ta1.setName(messageName);
			ta1.setType(Target.DISPATCH_ORDER);
			or.setLatestProcessTime(date);
			or.setStatus("2");

			String[] empId = or.getEmployeId().split(",");
			String empName = "";

			for (String id : empId) {
				Employe em = empDao.get(id);
				if (empName == "") {
					empName = em.getName();
				} else {
					empName = empName + "," + em.getName();
				}
			}
			or.setEmployeName(empName);
			ta1.setContent(messageName + "派工至 " + empName);
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, or.getProcessDetail());
			or.setProcessDetail(str1);
			or.setLatestProcess(messageName + " 派工至  " + empName);
			sfb.append(messageName + "派工至" + empName);
			or.setDispatchTime(date);
			orderDao.save(or);
			OrderDispatch od = new OrderDispatch();
			od.setOrder(or);
			od.setSiteId(siteId);
			od.setEmployeId(or.getEmployeId());
			od.setEmployeName(empName);

			/*
			 * or.setMessengerId(rec.getStr("id")); or.setMessengerName(rec.getStr("name"));
			 */

			disDao.save(od);
			List<String> list = Lists.newArrayList();
			for (String eId : empId) {
				Employe em = empDao.get(eId);
				StringBuffer sf = new StringBuffer();
				sf.append("INSERT INTO crm_order_dispatch_employe_rel (id,order_id, dispatch_id, emp_id, emp_name, site_id) VALUES( ");
				sf.append("'" + IdGen.uuid() + "', '" + or.getId() + "', '" + od.getId() + "', '" + em.getId() + "', '" + em.getName() + "', '" + siteId + "') ");
				list.add(sf.toString());
			}
			saveRel(list);

			// 派工推送消息
			Map<String, String> idMap = Maps.newHashMap();
			String oId = or.getId();
			String num = or.getNumber();
			idMap.put(oId, num);
			pushMessageService.notifyOrder(idMap, "1", "");// 推送消息
		} else {
			Target ta = new Target();
			ta.setContent(messageName + "接入");
			ta.setName(messageName);
			ta.setType(Target.NEW_ORDER);
			ta.setTime(DateToStringUtils.DateToString());
			String str = WebPageFunUtils.appendProcessDetail(ta, "");
			or.setStatus("1");
			or.setProcessDetail(str);
			orderDao.save(or);
		}
	}

	// 获取工单的所有反馈内容
	public Map<String, Object> getOrderFeedbackRecords(String orderId, String siteId) {
		Map<String, Object> ret = Maps.newHashMap();
		List<Map<String, Object>> list = Lists.newArrayList();
		List<Record> rds = orderDao.getOrderFeedbackRecords(orderId, siteId);
		List<Map<String, Object>> imgMaps = Lists.newArrayList();
		boolean imgurl = false;
		if (rds != null) {
			for (int i = 0; i < rds.size(); i++) {
				Map<String, Object> imgs = Maps.newHashMap();
				Record rd = rds.get(i);
				String fbTime = DateToStringUtils.DateToStringParam1(rd.getDate("feedback_time"));
				imgs.put("fbImgTime", DateToStringUtils.DateToStringParam(rd.getDate("feedback_time")));
				if (StringUtils.isNotBlank(rd.getStr("feedback_img"))) {
					String[] str = rd.getStr("feedback_img").split(",");
					imgs.put("fbImgPath", str);
					imgurl = true;
				}
				imgs.put("feedbackId", rd.getStr("id"));
				Map<String, Object> item = Maps.newHashMap();
				item.put("feedbackTime", fbTime);
				item.put("feedbackName", rd.getStr("feedback_name"));
				item.put("feedbackResults", rd.getStr("feedback"));
				list.add(item);
				imgMaps.add(imgs);
			}
		}
		ret.put("feedbackImgs", imgMaps);
		ret.put("feedbackResults", list);
		ret.put("isbackImg", imgurl);
		return ret;
	}

	public Map<String, Object> getOrderFeedbackRecordsIfHistory(String orderId, String siteId) {
		Order order = get(orderId);
		return order == null ? getOrderFeedbackRecords2017(orderId, siteId) : getOrderFeedbackRecords(orderId, siteId);
	}

	// 获取工单的所有反馈内容
	public Map<String, Object> getOrderFeedbackRecords2017(String orderId, String siteId) {
		Map<String, Object> ret = Maps.newHashMap();
		List<Map<String, Object>> list = Lists.newArrayList();
		List<Record> rds = orderDao.getOrderFeedbackRecords2017(orderId, siteId);
		List<Map<String, Object>> imgMaps = Lists.newArrayList();
		if (rds != null) {
			for (int i = 0; i < rds.size(); i++) {
				Map<String, Object> imgs = Maps.newHashMap();
				Record rd = rds.get(i);
				String fbTime = DateToStringUtils.DateToStringParam1(rd.getDate("feedback_time"));
				imgs.put("fbImgTime", DateToStringUtils.DateToStringParam(rd.getDate("feedback_time")));
				if (StringUtils.isNotBlank(rd.getStr("feedback_img"))) {
					String[] str = rd.getStr("feedback_img").split(",");
					imgs.put("fbImgPath", str);
				}

				Map<String, Object> item = Maps.newHashMap();
				item.put("feedbackTime", fbTime);
				item.put("feedbackName", rd.getStr("feedback_name"));
				item.put("feedbackResults", rd.getStr("feedback"));
				list.add(item);
				imgMaps.add(imgs);
			}
		}
		ret.put("feedbackImgs", imgMaps);
		ret.put("feedbackResults", list);
		return ret;
	}

	@Transactional(rollbackFor = Exception.class)
	public void delete(String id) {
		orderDao.deleteById(id);
		onOrderCountChanged(CrmUtils.getCurrentSiteId(UserUtils.getUser()), OrderCountChangeTypes.TYPE_scgd);
	}

	// 批量保存
	@Transactional(rollbackFor = Exception.class)
	public void saveRel(List<String> list) {
		Db.batch(list, list.size());
	}

	public List<Record> getOrderType() {
		return orderDao.getOrderType();
	}

	public Map<String, Long> getOrderTabCount(String tab, String siteId, List<String> cateList, List<String> brandList) {
		Map<String, Long> map = Maps.newHashMap();
		Record rd = orderDao.getOrderTabCount(tab, siteId, cateList, brandList);
		map.put("c1", rd.getLong("c1"));
		map.put("c2", rd.getLong("c2"));
		map.put("c3", rd.getLong("c3"));
		map.put("c4", rd.getLong("c4"));
		return map;
	}

	// 预警工单数
	public Map<String, Object> getManufactorEfficiency(String siteId) {
		return orderDao.getManufactorEfficiency(siteId);
	}

	// 配件关联工单

	public List<Record> getPjMsg(List<Record> list, String orderId, String siteId, String remark) {
		// orderDao
		list = orderDao.getPjMsg(orderId, siteId, remark);
		return list;
	}

	// 配件关联工单

	public Long getPjMsg1(String orderId, String siteId) {
		// orderDao
		return orderDao.getPjMsg1(orderId, siteId);
	}

	public Map<String, Object> getPeijianWelcomeData(String siteId, Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(case when a.status = '0' then 1 end) as dsh, ");
		sb.append(" count(case when a.status = '1' then 1 end) as qjz, ");
		sb.append(" count(case when a.status = '2' then 1 end) as dck ");
		sb.append(" from crm_site_fitting_apply a ");
		sb.append(" where 1=1  ");
		sb.append(" and a.site_id = ? ");
		sb.append(" and a.status in ('0','1','2') ");
		return Db.findFirst(sb.toString(), siteId).getColumns();
	}

	public Map<String, Object> getNormalWelcomeData(String siteId, Map<String, Object> params, List<String> cateList, List<String> brandList) {
		Date now = new Date();
		String dateStr = "'" + DateUtils.formatDate(now, "yyyy-MM-dd") + " 00:00:00'";
		String dateStr1 = "'" + DateUtils.formatDate(now, "yyyy-MM-dd") + " 23:59:59'";
		SqlKit sb = new SqlKit();
		sb.forceMaster();
		sb.append(" select  ");
		sb.append(" COUNT(CASE WHEN TO_DAYS(a.repair_time) = TO_DAYS(NOW()) THEN 1 END) AS jrgd,   ");
		sb.append(" COUNT(CASE WHEN TO_DAYS(a.flag_alert_date) = TO_DAYS(NOW()) THEN 1 END) AS jrtx,   ");// 今日提醒标记
		sb.append(" COUNT(CASE WHEN (a.promise_time >= " + dateStr + " and a.promise_time <= " + dateStr1 + " AND a.status = '1') THEN 1 END) AS jryy,  ");
		sb.append(" COUNT(CASE WHEN a.status in('1','7') THEN 1 END) AS dpg, ");
		sb.append(" COUNT(CASE WHEN a.fitting_flag IN ('2', '5','6') AND a.`status`='2' AND b.`status` IN ('1','2', '4') THEN 1 END) AS qjz, ");
		sb.append(" COUNT(CASE WHEN a.`status`='2' AND b.`status` IN ('1','2', '4') THEN 1 END) AS fwz ");
		sb.append(" FROM (SELECT * from crm_order AS k where k.site_id=? and k.`status` !='6') AS a ");
		sb.append(" left join crm_order_dispatch b ");
		sb.append(" on b.order_id = a.id and b.status not in ('3', '6', '7') and b.site_id = '" + siteId + "'");
		sb.append(" where 1=1 ");
		if (cateList != null) {
			sb.append(" AND a.appliance_category in (" + StringUtil.joinInSqlforllist(cateList) + ") ");
		}
		if (brandList != null) {
			sb.append(" AND a.appliance_brand in (" + StringUtil.joinInSqlforllist(brandList) + ") ");
		}
		Record first = Db.findFirst(sb.toString(), siteId);
		if (first != null) {
			return first.getColumns();
		}

		Map<String, Object> ret = new HashMap<>();
		ret.put("jrgd", 0);
		ret.put("jrjd", 0);
		ret.put("jryy", 0);
		ret.put("ylgd", 0);
		ret.put("ywg", 0);
		ret.put("dpg", 0);
		ret.put("djd", 0);
		ret.put("dyy", 0);
		ret.put("qjz", 0);
		ret.put("fwz", 0);
		return ret;
	}

	public List<Record> getHistoryOrdersByTel(String tel) {
		tel = org.apache.commons.lang.StringUtils.trim(tel);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SqlKit kit = new SqlKit().append("select * from crm_order").append("where (customer_mobile=? OR customer_telephone=? OR customer_telephone2=?)").append("AND site_id=?");
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			kit.append("union all select * from " + table + " ").append("where (customer_mobile=? OR customer_telephone=? OR customer_telephone2=?)").append("AND site_id=?");
			return Db.find(kit.toString(), tel, tel, tel, siteId, tel, tel, tel, siteId);
		}
		return Db.find(kit.toString(), tel, tel, tel, siteId);
	}

	public List<Record> getHistoryOrdersBycodeIn(String code) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String table = tableSplitMapper.mapOrder(siteId);
		String sql = "select a.* from crm_order a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?";
		if (table != null) {
			sql += "select a.* from " + table + " a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?";
			return Db.find(sql, code, code, siteId, code, code, siteId);
		}
		return Db.find(sql, code, code, siteId);
	}

	public List<Record> getHistoryOrdersBycodeIn2(String code, String id, String siteId) {
		String sql = "select a.* from crm_order a where (a.appliance_barcode=? or a.appliance_machine_code=?) and a.site_id=?";
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			sql += " union all select a.* from " + table + " a where (a.appliance_barcode=? or a.appliance_machine_code=?) and a.site_id=?";
			return Db.find(sql, code, code, siteId, code, code, siteId);
		}
		return Db.find(sql, code, code, siteId);
	}

	public List<Record> showHistoryPopupDetail(String code, String id, String siteId) {
		String sql = "select a.* from crm_order a where (a.appliance_barcode=? or a.appliance_machine_code=?) and a.site_id=? and a.id!=?";
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			sql += " union all select a.* from " + table + " a where (a.appliance_barcode=? or a.appliance_machine_code=?) and a.site_id=? and a.id!=?";
			return Db.find(sql, code, code, siteId, id, code, code, siteId, id);
		}

		return Db.find(sql, code, code, siteId, id);
	}

	public List<Record> showHistoryPopupDetail2017(String code, String id, String siteId) {
		return showHistoryPopupDetail(code, id, siteId);
	}

	public List<Record> getHistoryOrdersBycodeOut(String code) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String sql = "select a.*,DATE_FORMAT(a.repair_time,'%Y-%m-%d %H:%m:%s') as repairTime,DATE_FORMAT(a.end_time,'%Y-%m-%d %H:%m:%s') as endTime,DATE_FORMAT(a.appliance_buy_time,'%Y-%m-%d %H:%m:%s') as buyTime from crm_order a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?";
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			sql += "select a.*,DATE_FORMAT(a.repair_time,'%Y-%m-%d %H:%m:%s') as repairTime,DATE_FORMAT(a.end_time,'%Y-%m-%d %H:%m:%s') as endTime,DATE_FORMAT(a.appliance_buy_time,'%Y-%m-%d %H:%m:%s') as buyTime from "
					+ table + " a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?";
			return Db.find(sql, code, code, siteId);
		}
		return Db.find(sql, code, code, CrmUtils.getCurrentSiteId(UserUtils.getUser()));
	}

	public long getHistoryOrdersCountByTel(String tel) {
		long count = 0;
		tel = org.apache.commons.lang.StringUtils.trim(tel);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());

		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			SqlKit kit1 = new SqlKit().append("select count(1) as cnt from " + table).append(" where (customer_mobile=? OR customer_telephone=? OR customer_telephone2=?)")
					.append("AND site_id=?");
			count += Db.queryLong(kit1.toString(), tel, tel, tel, siteId);
		}

		SqlKit kit = new SqlKit().append("select count(1) as cnt from crm_order").append("where (customer_mobile=? OR customer_telephone=? OR customer_telephone2=?)")
				.append("AND site_id=?");
		return count + Db.queryLong(kit.toString(), tel, tel, tel, siteId);
	}

	public Long getHistoryOrdersCodeInCountByTel(String code) {
		return getHistoryOrdersCodeCountByTel(code);
	}

	public Long getHistoryOrdersCodeOutCountByTel(String code) {
		return getHistoryOrdersCodeCountByTel(code);
	}

	private Long getHistoryOrdersCodeCountByTel(String code) {
		Long cached = getHistoryOrdersCodeOutCountByTelDetailCached(code, null);
		if (cached != null) {
			return cached;
		}

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SqlKit kit = new SqlKit().append("select count(*) from crm_order a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?");
		long count = Db.queryLong(kit.toString(), code, code, siteId);

		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			kit = new SqlKit().append("select count(*) from " + table + " a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?");
			count += Db.queryLong(kit.toString(), code, code, siteId);
		}
		return count;
	}

	public Long getHistoryOrdersCodeOutCountByTelDetail(String code, String id) {
		Long cached = getHistoryOrdersCodeOutCountByTelDetailCached(code, id);
		if (cached != null) {
			return cached;
		}

		Long aLong = doGetHistoryOrdersCodeOutCountByTelDetail(code, id);
		if ("000000".equals(code) && aLong > 0) {
			// 针对000000这种特殊的编号作出缓存，因为工程师那边默认就填的是这个编号，所以这个编号理论上会很多。
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			sfCacheService.setex(String.format(SfCacheKey.siteDefault0CodeCountMap, siteId), 30 * 60, aLong.toString());
		}
		return aLong;
	}

	private Long getHistoryOrdersCodeOutCountByTelDetailCached(String code, String id) {
		if ("000000".equals(code)) {
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			String val = sfCacheService.get(String.format(SfCacheKey.siteDefault0CodeCountMap, siteId));
			if (StringUtil.isNotBlank(val)) {
				return Long.valueOf(val);
			}
		}
		return null;
	}

	private Long doGetHistoryOrdersCodeOutCountByTelDetail(String code, String id) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		/*SqlKit kit = new SqlKit().append("select count(*) from crm_order a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?");
		long aLong = Db.queryLong(kit.toString(), code, code, siteId);
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			kit = new SqlKit().append("select count(*) from " + table + " a where (a.appliance_barcode=? or a.appliance_machine_code=? ) and a.site_id=?");
			aLong += Db.queryLong(kit.toString(), code, code, siteId);
		}
		return aLong > 0 ? aLong - 1 : aLong;*/
		long s1 = System.currentTimeMillis();

		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(1) as cnt from crm_order a where a.appliance_barcode=? and a.site_id = ? ");
		sb.append(" union all ");
		sb.append(" select count(1) as cnt from crm_order a where a.appliance_machine_code=? and a.site_id = ? ");
		List<Record> rds1 = Db.find(sb.toString(), code, siteId, code, siteId);
		Long l1 = 0l;
		for(Record rd : rds1){
			l1 += rd.getLong("cnt");
		}
		Long l2 = 0l;
		if(tableSplitMapper.exists(siteId)){
			sb = new StringBuilder("");
			sb.append(" select count(1) as cnt from "+tableSplitMapper.mapOrder(siteId)+" a where a.appliance_barcode=? and a.site_id = ? ");
			sb.append(" union all ");
			sb.append(" select count(1) as cnt from "+tableSplitMapper.mapOrder(siteId)+" a where a.appliance_machine_code=? and a.site_id = ? ");
			List<Record> rds2 = Db.find(sb.toString(), code, siteId, code, siteId);
			for(Record rd : rds2){
				l2 += rd.getLong("cnt");
			}
		}
		System.out.println(" >> doGetHistoryOrdersCodeOutCountByTelDetail time:" + (System.currentTimeMillis() - s1));
		long ret = l1 + l2;
		return ret > 0 ? ret -1 : ret;
	}

	public Long getHistoryOrdersCodeOutCountByTelDetail2017(String code, String id) {
		return doGetHistoryOrdersCodeOutCountByTelDetail(code, id);
	}

	@Transactional(rollbackFor = Exception.class)
	// 更新过程信息 createby @yc
	public void upProcessDetail(String orderId, String processDetaile, Date processTime, String latestProcess) {
		Db.update("UPDATE crm_order SET process_detail=? , latest_process=? , latest_process_time=? WHERE id=? ", processDetaile, latestProcess, processTime, orderId);
	}

	@Transactional(rollbackFor = Exception.class)
	public Boolean confirmCollection(String id, String mnys) {
		String name = CrmUtils.getUserXM();
		Target ta = new Target();
		Record rd = Db.findFirst("select a.process_detail from crm_order a where a.id=?", id);
		String content = name + "确认已交款，实收金额为" + mnys + "元";
		ta.setContent(content);
		ta.setName(name);
		ta.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		ta.setType(Target.SITE_EDIT_CONFIRM_PAY_MONEY_TYPE);
		String processDetail = WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail"));
		Db.update(
				"update crm_order a set a.whether_collection='1',a.confirm_cost=?,a.process_detail=?,a.latest_process=?,a.latest_process_time=now(),a.pay_time=now() where a.status in('3','4') and a.id='"
						+ id + "'",
				mnys, processDetail, content);
		return true;
	}

	@Transactional(rollbackFor = Exception.class)
	public Boolean confirmCollection2017(String id, String amount) {
		String name = CrmUtils.getUserXM();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Target ta = new Target();
		Record rd = order2017Dao.findOrderById(id, siteId);
		String content = name + "确认已交款，实收金额为" + amount + "元";
		ta.setContent(content);
		ta.setName(name);
		ta.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		ta.setType(Target.SITE_EDIT_CONFIRM_PAY_MONEY_TYPE);
		String processDetail = WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail"));
		String orderTable = tableSplitMapper.mapOrder(siteId);
		if (orderTable == null) {
			return false;
		}
		Db.update("update " + orderTable
				+ " a set a.whether_collection='1',a.confirm_cost=?,a.process_detail=?,a.latest_process=?,a.latest_process_time=now(),a.pay_time=now() where a.status in('3','4') and a.id=?",
				amount, processDetail, content, id);
		return true;
	}

	@Transactional(rollbackFor = Exception.class)
	public String confirmCard(String id, String relMoney, String ifSelect, String oneOrMore) {// ifSelect 1:选中 2：未选中
		if (StringUtils.isBlank(id)) {
			return "notExist";
		}
		Date dt = new Date();
		String dtStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
		String name = CrmUtils.getUserXM();

		String sqls = "";
		if ("2".equals(oneOrMore)) {// 单个交单
			Record rd = Db.findFirst("select a.process_detail,a.whether_collection from crm_order a where a.id=?", id);
			Target ta = new Target();
			ta.setContent(name + "确认已交回卡单");
			ta.setName(name);
			ta.setTime(dtStr);
			ta.setType(Target.SITE_EDIT_CONFIRM_RETURN_CARD_TYPE);
			String paytime = "";

			if ("1".equals(ifSelect)) {// 选中交款,交单的同时也交款
				String ProcessDetail = WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail"));
				if ("0".equals(rd.getStr("whether_collection"))) {
					Target ta1 = new Target();
					paytime = ",a.pay_time=now()";
					ta1.setContent(name + "确认已交款，实收金额为" + relMoney + "元");
					ta1.setName(name);
					ta1.setTime(dtStr);
					ta1.setType(Target.SITE_EDIT_CONFIRM_PAY_MONEY_TYPE);
					ProcessDetail = WebPageFunUtils.appendProcessDetail(ta1, ProcessDetail);
				}
				sqls = "update crm_order a set a.return_card='1',a.return_card_time=now(),a.whether_collection='1',a.confirm_cost='" + relMoney + "',a.process_detail='"
						+ ProcessDetail + "',a.latest_process='" + name + "确认已交款，实收金额为" + relMoney + "元" + "'" + paytime + " where a.id in(" + StringUtil.joinInSql(id.split(","))
						+ ") and a.status in('3','4','5','8') and a.return_card !='1'";
			} else {// 未选中，则将确认交款状态置为0
				sqls = "update crm_order a set a.return_card='1',a.return_card_time=now(),a.whether_collection='0' ,a.latest_process_time=now(),a.process_detail='"
						+ WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail")) + "',a.latest_process='" + name + "确认已交回卡单" + "' where a.id in("
						+ StringUtil.joinInSql(id.split(",")) + ") and a.status in('3','4','5','8') and a.return_card !='1'";
			}
			SQLQuery sql = orderDao.getSession().createSQLQuery(sqls);
			sql.executeUpdate();
		} else {// 批量交单
			List<Record> list = Db.find("select a.* from crm_order a where a.id in(" + StringUtil.joinInSql(id.split(",")) + ")");
			for (Record rd : list) {
				Target ta = new Target();
				ta.setContent(name + "确认已交回卡单");
				ta.setName(name);
				ta.setTime(dtStr);
				ta.setType(Target.SITE_EDIT_CONFIRM_RETURN_CARD_TYPE);
				sqls = "update crm_order a set a.return_card='1',a.return_card_time=now(),a.latest_process_time=now(),a.process_detail='"
						+ WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail")) + "',a.latest_process='" + name + "确认已交回卡单" + "' where a.id in("
						+ StringUtil.joinInSql(id.split(",")) + ") and a.status in('3','4','5','8') and a.return_card !='1'";
				SQLQuery sql = orderDao.getSession().createSQLQuery(sqls);
				sql.executeUpdate();
			}
		}
		return "ok";
	}

	@Transactional(rollbackFor = Exception.class)
	public String confirmCard2017(String id, String relMoney, String ifSelect, String oneOrMore) {// ifSelect 1:选中 2：未选中
		if (StringUtils.isBlank(id)) {
			return "notExist";
		}
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderTable = tableSplitMapper.mapOrder(siteId);
		if (orderTable == null) {
			return "notExist";
		}

		Date dt = new Date();
		String dtStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
		String name = CrmUtils.getUserXM();

		String sqls;
		if ("2".equals(oneOrMore)) {// 单个交单
			Record rd = order2017Dao.findOrderById(id, siteId);
			Target ta = new Target();
			ta.setContent(name + "确认已交回卡单");
			ta.setName(name);
			ta.setTime(dtStr);
			ta.setType(Target.SITE_EDIT_CONFIRM_RETURN_CARD_TYPE);
			if ("1".equals(ifSelect)) {// 选中交款,交单的同时也交款
				Target ta1 = new Target();
				ta1.setContent(name + "确认已交款，实收金额为" + relMoney + "元");
				ta1.setName(name);
				ta1.setTime(dtStr);
				ta1.setType(Target.SITE_EDIT_CONFIRM_PAY_MONEY_TYPE);
				sqls = "update " + orderTable + " a set a.return_card='1',a.return_card_time=now(),a.whether_collection='1',a.confirm_cost='" + relMoney + "',a.process_detail='"
						+ WebPageFunUtils.appendProcessDetail(ta1, WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail"))) + "',a.latest_process='" + name
						+ "确认已交款，实收金额为" + relMoney + "元" + "',a.pay_time=now() where a.id in(" + StringUtil.joinInSql(id.split(","))
						+ ") and a.status in('3','4','5','8') and a.return_card !='1'";
			} else {// 未选中，则将确认交款状态置为0
				sqls = "update " + orderTable + " a set a.return_card='1',a.return_card_time=now(),a.whether_collection='0' ,a.latest_process_time=now(),a.process_detail='"
						+ WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail")) + "',a.latest_process='" + name + "确认已交回卡单" + "' where a.id in("
						+ StringUtil.joinInSql(id.split(",")) + ") and a.status in('3','4','5','8') and a.return_card !='1'";
			}
			// SQLQuery sql = orderDao.getSession().createSQLQuery(sqls);
			// sql.executeUpdate();
			Db.update(sqls);
		} else {// 批量交单
			List<Record> list = order2017Dao.findOrderByIds(id.split(","), siteId);
			for (Record rd : list) {
				Target ta = new Target();
				ta.setContent(name + "确认已交回卡单");
				ta.setName(name);
				ta.setTime(dtStr);
				ta.setType(Target.SITE_EDIT_CONFIRM_RETURN_CARD_TYPE);
				sqls = "update " + orderTable + " a set a.return_card='1',a.return_card_time=now(),a.latest_process_time=now(),a.process_detail='"
						+ WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail")) + "',a.latest_process='" + name + "确认已交回卡单" + "' where a.id in("
						+ StringUtil.joinInSql(id.split(",")) + ") and a.status in('3','4','5','8') and a.return_card !='1'";
				// SQLQuery sql = orderDao.getSession().createSQLQuery(sqls);
				// sql.executeUpdate();
				Db.update(sqls);
			}
		}
		return "ok";
	}

	public Integer getMsgNumbers(String content, String sign, String type) {
		String str = content + sign;
		if (!StringUtils.isNotBlank(str)) {
			return 0;
		}
		if (str.length() <= 70) {
			return 1;
		}

		return (str.length() + 66) / 67;

	}

	public Integer getMsgNumbersOne(String content, String sign) {
		if (!StringUtils.isNotBlank(content)) {
			return 0;
		}
		if (content.length() <= 70) {
			return 1;
		}

		return (content.length() + 66) / 67;

	}

	@Transactional
	public Record getRemainMsgNum(String siteId) {
		return Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
	}

	public Integer getSendMsg1(String content, String sign, String mobile, String siteId) {
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		String[] str = mobile.split(",");
		Integer mobileNums = 0;
		for (int i = 0; i < str.length; i++) {
			if (str[i].length() == 11 && str[i].subSequence(0, 1).equals("1")) {// 电话的长度为11，并且首位为“1”有效，表示发送成功
				mobileNums++;
			}
		}
		return mobileNums * nums;
	}

	public Integer getSendMsg2(String content, String sign, String mobile, String siteId, Integer sNum) {
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		return sNum * nums;
	}

	/* 批量发送短信 */
	@Transactional(rollbackFor = Exception.class)
	public String getSendMsg(String content, String sign1, String mobile, String siteId, String number) {
		String sign = "【" + sign1 + "】";
		String[] strg = mobile.split(",");
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		Integer mks = nums * strg.length;
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		if (mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		User user = UserUtils.getUser();
		String name = "";
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = CrmUtils.getSiteName();
		} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
		}
		List<SendedSms> list = Lists.newArrayList();

		Integer successMsgNums = 0;

		String[] str1 = mobile.split(",");
		String[] str2 = number.split(",");
		int i = 0;
		for (String st : str1) {
			SendedSms sm = new SendedSms();
			String result = SfSmsUtils.sendMsg(mobile, content, sign);
			sm.setStatus("0");
			if (StringUtils.isBlank(result)) {

			} else {
				successMsgNums = successMsgNums + nums;
				sm.setStatus("1");
				sm.setReceiveTime(new Date());
			}
			sm.setSendTime(new Date());
			sm.setType("1");
			sm.setCreateTime(new Date());
			sm.setCreateBy(name);
			sm.setSendid(result);
			sm.setExtno("99");
			sm.setSmsNum(nums);
			sm.setCreateType(user.getUserType());
			sm.setSiteId(siteId);
			Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
			sm.setSiteMobile(r.getStr("mobile"));
			sm.setSign(sign);
			sm.setContent(content);
			sm.setMobile(st);
			if (i == 0) {
				Record rd = Db.findFirst("select * from crm_order a where a.number='" + str2[0] + "' and a.site_id='" + siteId + "'");
				sm.setOrderId(rd.getStr("id"));
				sm.setOrderNumber(str2[0]);
				i++;
			} else {
				Record rd = Db.findFirst("select * from crm_order a where a.number='" + str2[i] + "' and a.site_id='" + siteId + "'");
				sm.setOrderId(rd.getStr("id"));
				sm.setOrderNumber(str2[i]);
				i++;
			}
			list.add(sm);
		}

		sendedSmsDao.save(list);
		if (successMsgNums > 0) {
			smsService.consumeSms(successMsgNums, siteId);
		}
		return "ok";
	}

	/**
	 * 派工或转派中给周边用户发送短信
	 * 
	 * @param content
	 *            短信内容
	 * @param sign1
	 *            短信签名
	 * @param mobile
	 *            手机号
	 * @param siteId
	 * @param number
	 *            工单编号
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public String sendInDispOrTurnDisp(String content, String sign1, String mobile, String siteId, String number) {
		String sign = sign1 + "服务";

		String[] strg = mobile.split(",");
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		Integer mks = nums * strg.length;
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		if (mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		User user = UserUtils.getUser();
		String name = "";
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = CrmUtils.getSiteName();
		} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
		}
		List<SendedSms> list = Lists.newArrayList();
		String result = SMSUtils.sendMsg(mobile, content, sign, "14");
		Integer sNum = 0;
		Integer successMsgNums = 0;
		if ("3".equals(result.split(",")[0])) {

		} else if ("0".equals(result.split(",")[0])) {
			// sNum = Integer.valueOf(result.split(",")[3]);
			successMsgNums = getSendMsg2(content, sign, mobile, siteId, 1);// 成功发送的短信条数
		} else {
			logger.error("sms send error in dispatcher, The callback for message is :" + result);
		}
		String[] rst = result.split(",");
		// Db.update("update crm_site a set
		// a.sms_available_amount=(a.sms_available_amount-" + successMsgNums + ") where
		// a.status='0' and a.id='" + siteId + "'");// 更新服务商短信数量
		smsService.consumeSms(successMsgNums, siteId);

		SendedSms sm = new SendedSms();
		if (mobile.length() == 11 && mobile.startsWith("1")) {// 电话的长度为11，并且首位为“1”有效，表示发送成功
			sm.setStatus("1");
			sm.setReceiveTime(new Date());
		} else {
			sm.setStatus("0");
		}
		sm.setSendTime(new Date());
		sm.setType("10");
		sm.setCreateTime(new Date());
		sm.setCreateBy(name);
		sm.setSendid(rst[1]);
		sm.setExtno("14");
		sm.setSmsNum(nums);
		sm.setCreateType(user.getUserType());
		sm.setSiteId(siteId);
		Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
		sm.setSiteMobile(r.getStr("mobile"));
		sm.setSign(sign);
		sm.setContent(content);
		sm.setMobile(mobile);
		Record rd = Db.findFirst("select * from crm_order a where a.number='" + number + "' and a.site_id='" + siteId + "'");
		sm.setOrderId(rd.getStr("id"));
		sm.setOrderNumber(number);
		sendedSmsDao.save(sm);
		return "ok";
	}

	/* 短信催单短信催单-编辑的短信-不是模板 发送 */
	@Transactional(rollbackFor = Exception.class)
	public String getFwzSendmsg(String content, String sign1, String orderMsgMobile, String siteId, String orderMsgId) {
		String sign = "【" + sign1 + "】";
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		String[] strg = orderMsgMobile.split(",");
		Integer mks = nums * strg.length;
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		if (mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		try {
			Integer successMsgNums = 0;

			for (String st : orderMsgMobile.split(",")) {
				SendedSms sm = new SendedSms();
				String result = SfSmsUtils.sendMsg(st, content, sign);// 自定义模板
				if (StringUtils.isNotBlank(result)) {// 已发送
					successMsgNums = successMsgNums + nums;
					sm.setStatus("1");
					sm.setReceiveTime(new Date());
					sm.setSendid(result);
				} else {
					sm.setStatus("0");
				}
				sm.setSendTime(new Date());
				sm.setType("1");
				sm.setCreateTime(new Date());
				sm.setCreateBy(name);
				sm.setExtno("99");
				sm.setSmsNum(nums);
				sm.setCreateType(user.getUserType());
				sm.setSiteId(siteId);
				Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
				sm.setSiteMobile(r.getStr("mobile"));
				sm.setSign(sign);
				sm.setContent(content);
				sm.setMobile(st);
				sm.setOrderId(orderMsgId);
				sm.setOrderNumber(orderDao.get(orderMsgId).getNumber());
				sendedSmsDao.save(sm);
			}
			if (successMsgNums > 0) {
				smsService.consumeSms(successMsgNums, siteId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}

	}

	/* 来电弹屏短信通知（自定义模板） */
	@Transactional(rollbackFor = Exception.class)
	public String callShowSendmsg(String noId, String content, String sign1, String orderMsgMobile, String siteId, String orderMsgId) {
		String sign = sign1 + "服务";
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		String name = "";
		NonServiceman no = nonDao.get(noId);
		name = no.getName();
		try {
			String result = SMSUtils.sendMsg(orderMsgMobile, content, sign, "99");// 自定义模板
			String[] rst = result.split(",");
			Integer sNum = Integer.valueOf(result.split(",")[3]);
			Integer successMsgNums = getSendMsg2(content, sign, orderMsgMobile, siteId, sNum);// 成功发送的短信条数
			// Db.update("update crm_site a set
			// a.sms_available_amount=(a.sms_available_amount-" + successMsgNums + ") where
			// a.status='0' and a.id='" + siteId + "'");// 更新服务商短信数量
			smsService.consumeSms(successMsgNums, siteId);
			SendedSms sm = new SendedSms();
			if (orderMsgMobile.length() == 11 && orderMsgMobile.subSequence(0, 1).equals("1")) {// 电话的长度为11，并且首位为“1”有效，表示发送成功
				sm.setStatus("1");
				sm.setReceiveTime(new Date());
			} else {
				sm.setStatus("0");
			}
			sm.setSendTime(new Date());
			sm.setType("7");
			sm.setCreateTime(new Date());
			sm.setCreateBy(name);
			sm.setSendid(rst[1]);
			// sm.setSendid("87766");
			sm.setExtno("99");
			sm.setSmsNum(nums);
			sm.setCreateType("3");
			sm.setSiteId(siteId);
			Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
			sm.setSiteMobile(r.getStr("mobile"));
			sm.setSign(sign);
			sm.setContent(content);
			sm.setMobile(orderMsgMobile);
			sm.setOrderId(orderMsgId);
			sm.setOrderNumber(orderDao.get(orderMsgId).getNumber());
			sendedSmsDao.save(sm);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	/* 来电弹屏短信通知（短信模板） */
	@Transactional(rollbackFor = Exception.class)
	public String getCallFwzSendmsgModel(String noId, String temId, String sign1, String content1, String extno, String orderId, String customerMobile, String siteId) {
		int leng = content1.indexOf("【");
		String sign = sign1 + "服务";
		String content = content1.substring(0, leng).trim();
		String name = "";
		NonServiceman no = nonDao.get(noId);
		name = no.getName();
		try {
			String result = SMSUtils.sendMsg(customerMobile, content, sign, extno);
			String[] rst = result.split(",");
			Integer sNum = Integer.valueOf(result.split(",")[3]);
			Integer successMsgNums = getSendMsg2(content, sign, customerMobile, siteId, sNum);// 成功发送的短信条数
			// Db.update("update crm_site a set
			// a.sms_available_amount=(a.sms_available_amount-" + successMsgNums + ") where
			// a.status='0' and a.id='" + siteId + "'");// 更新服务商短信数量
			smsService.consumeSms(successMsgNums, siteId);
			SendedSms sm = new SendedSms();
			sm.setSendTime(new Date());
			sm.setCreateTime(new Date());
			sm.setCreateBy(name);
			sm.setSendid(rst[1]);
			sm.setExtno(extno);
			sm.setCreateType("3");
			sm.setSiteId(siteId);
			Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
			sm.setSiteMobile(r.getStr("mobile"));
			sm.setSign(sign);
			sm.setSmsNum(successMsgNums);
			sm.setContent(content);
			sm.setMobile(customerMobile);
			sm.setOrderId(orderId);
			sm.setOrderNumber(orderDao.get(orderId).getNumber());
			sm.setTemplateId(temId);
			sm.setStatus("1");
			if (extno.equals("6")) {// 上门前
				sm.setType("6");
			} else if (extno.equals("4")) {// 无人接听
				sm.setType("2");
			} else if (extno.equals("3")) {// 改约
				sm.setType("3");
			} else if (extno.equals("2")) {// 缺件
				sm.setType("4");
			} else if (extno.equals("5")) {
				sm.setType("5");
			} else if (extno.equals("11")) {
				sm.setType("7");
			}
			sendedSmsDao.save(sm);

			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	// public Order getOrderByNumber(String number, String siteId) {
	// return orderDao.getOrderByNumber(number, siteId);
	// }

	// public boolean isOrderExists(String number, String siteId) {
	// return getOrderByNumber(number, siteId) != null;
	// }

	/* 短信通知（短信模板） 短信催单-模板发送 */
	@Transactional(rollbackFor = Exception.class)
	public String getFwzSendmsgModel(String temId, String sign1, String content1, String extno, String orderId, String customerMobile, String siteId) {
		String sign = "【" + sign1 + "】";
		String content = content1.trim();
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		Integer nums = getMsgNumbers(content, sign, "");
		String[] strg = customerMobile.split(",");
		Integer mks = nums * strg.length;
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		if (rdNum.getInt("sms_available_amount") == null || mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		Integer sucNum = queryValidMobile(customerMobile);
		try {
			Integer successMsgNums = 0;

			List<SendedSms> ls = new ArrayList<>();
			for (String st : customerMobile.split(",")) {
				String result = SfSmsUtils.sendMsg(st, content, sign);
				SendedSms sm = new SendedSms();
				if (StringUtils.isNotBlank(result)) {// 已发送
					successMsgNums = successMsgNums + nums;
					sm.setStatus("1");
					sm.setReceiveTime(new Date());
					sm.setSendid(result);
				} else {
					sm.setStatus("0");
				}
				sm.setSendTime(new Date());
				sm.setCreateTime(new Date());
				sm.setCreateBy(name);

				sm.setExtno(extno);
				sm.setCreateType(user.getUserType());
				sm.setSiteId(siteId);
				Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
				sm.setSiteMobile(r.getStr("mobile"));
				sm.setSign(sign);
				sm.setSmsNum(nums);
				sm.setContent(content);
				sm.setMobile(st);
				sm.setOrderId(orderId);
				sm.setOrderNumber(orderDao.get(orderId).getNumber());
				sm.setTemplateId(temId);
				if (extno.equals("6")) {// 上门前
					sm.setType("6");
				} else if (extno.equals("4")) {// 无人接听
					sm.setType("2");
				} else if (extno.equals("3")) {// 改约
					sm.setType("3");
				} else if (extno.equals("2")) {// 缺件
					sm.setType("4");
				} else if (extno.equals("5")) {
					sm.setType("5");
				} else if (extno.equals("11")) {
					sm.setType("7");
				} else if (extno.equals("7")) {
					sm.setType("8");
				} else if (extno.equals("9")) {
					sm.setType("9");
				} else if (extno.equals("8")) {
					sm.setType("0");// 待派工
				}
				ls.add(sm);
			}
			sendedSmsDao.save(ls);
			if (successMsgNums > 0) {
				smsService.consumeSms(successMsgNums, siteId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public Integer queryValidMobile(String mobiles) {
		Integer g = 0;
		for (int i = 0; i < mobiles.split(",").length; i++) {
			if (mobiles.split(",")[i].length() == 11 && mobiles.split(",")[i].subSequence(0, 1).equals("1")) {
				g++;
			}
		}
		return g;
	}

	public Integer getModelMsgNums(String customerMobile, String[] yxIds, String temId, String siteName, String jdPhone, String endMode, String siteArea, String oneHref,
			String siteMobile, String sign) {
		int h = 0;
		Integer allNums = 0;
		for (String st : customerMobile.split(",")) {
			SendedSms sm = new SendedSms();
			Map<String, String> msg2 = new HashMap<>();
			Order od = orderDao.get(yxIds[h]);// 获取每条order表信息;
			String proTime = "";
			if (od.getPromiseTime() != null) {
				proTime = od.getPromiseTime().toString().substring(0, 11);
			}
			String msg1 = "";
			String msg2Names = "";
			String msg2Mobiles = "";
			if (StringUtils.isNotBlank(od.getEmployeId())) {
				Map<String, String> empDetail = orderDispatchService.getEmployeMsg1(od.getEmployeId());
				msg1 = empDetail.get("nameMobile").toString();
				msg2Names = empDetail.get("empNames").toString();
				msg2Mobiles = empDetail.get("empMobiles").toString();
			}
			msg2 = orderDispatchService.getEmployeMsg1(od.getEmployeId());
			String contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile") + "为您服务，注意用电安全请点击" + oneHref + "，详情咨询上门工程师。";
			if ("2".equals(temId)) {// 上门前1
				contentn = od.getCustomerName() + "您好，您的" + od.getServiceType() + "业务" + siteName + "已受理，" + msg1 + "，将为您提供服务，请保持电话通畅，监督电话：" + jdPhone + "。";
			}
			if ("3".equals(temId)) {// 上门前2
				contentn = "尊敬的用户：您的信息" + siteName + jdPhone + "已经派工，服务工程师" + msg2Names + "，联系电话" + msg2Mobiles + "，请您对我们的服务进行监督！";
			}
			if ("9".equals(temId)) {// 增值短信
				if ("2".equals(endMode)) {
					contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile") + "为您服务，注意用电安全请点击" + oneHref + "，详情咨询上门工程师。";
				}
				if ("3".equals(endMode)) {
					contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile") + "为您服务，另有专用自动止水水龙头，详情咨询上门工程师。";
				}
				if ("4".equals(endMode)) {
					contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile")
							+ "为您服务，另有安全用电家电伴侣产品等为您提供试用，使您拥有最安心的家电使用体验，洗衣机专用自动止水水龙头和洗衣机底座，可有效防止水淹事故导致财产损失，延长家电安全使用寿命，详情咨询上门工程师。";
				}
			}
			if ("4".equals(temId)) {// 电话无人接听
				contentn = "尊敬的用户，您的电话无法接通状态，请您在方便的时候回复" + jdPhone + "或服务工程师电话" + msg1 + "，我们将尽快为您提供满意的服务！";
			}
			if ("12".equals(temId)) {// 配件无人接听
				contentn = "你好，你购买的商品今天到" + siteArea + "，联系你电话无人接听，看到短信后请联系" + siteMobile + "。";
			}
			if ("5".equals(temId)) {// 改约
				contentn = od.getCustomerName() + "您好，您的预约时间已改至" + proTime + "，" + od.getPromiseLimit() + "，具体上门时间，" + msg1 + "，会与您联系，监督电话：" + jdPhone + "。";
			}
			if ("6".equals(temId)) {// 缺件
				contentn = od.getCustomerName() + "您好，因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，" + msg1 + "，会与您联系，监督电话：" + jdPhone + "。";
			}
			Integer numn = getMsgNumbers(contentn, sign, "");// 成功发送的短信条数
			allNums = allNums + numn;
			h++;
		}
		return allNums;
	}

	/* 短信通知（短信模板） （目前已使用：系统短信模板-群发） */
	@Transactional(rollbackFor = Exception.class)
	public String fwzSendmsgModelFwz(String temId, String sign1, String content1, String extno, String orderId, String customerMobile, String siteId, String yxId, String oneHref,
			String endMode) {
		String sign = "【" + sign1 + "】";
		String content = content1.trim();
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		Integer nums = getMsgNumbers(content, sign, "");// 一条信息算计条短信
		String[] strg = customerMobile.split(",");
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		try {
			int h = 0;
			Integer successNum = 0;
			List<SendedSms> ls = new ArrayList<>();
			String[] yxIds = yxId.split(",");
			Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
			String jdPhone = r.getStr("sms_phone");
			String siteMobile = r.getStr("mobile");
			String siteName = r.getStr("name");
			String siteArea = r.getStr("area");
			Integer needNums = getModelMsgNums(customerMobile, yxIds, temId, siteName, jdPhone, endMode, siteArea, oneHref, siteMobile, sign);
			if (needNums > rdNum.getInt("sms_available_amount")) {
				return "noMessage";// 短信条数不足
			}

			for (String st : customerMobile.split(",")) {
				SendedSms sm = new SendedSms();
				Map<String, String> msg2 = new HashMap<>();
				Order od = orderDao.get(yxIds[h]);// 获取每条order表信息;
				String proTime = "";
				if (od.getPromiseTime() != null) {
					proTime = od.getPromiseTime().toString().substring(0, 11);
				}
				String msg1 = "";
				String msg2Names = "";
				String msg2Mobiles = "";
				if (StringUtils.isNotBlank(od.getEmployeId())) {
					Map<String, String> empDetail = orderDispatchService.getEmployeMsg1(od.getEmployeId());
					msg1 = empDetail.get("nameMobile").toString();
					msg2Names = empDetail.get("empNames").toString();
					msg2Mobiles = empDetail.get("empMobiles").toString();
				}
				msg2 = orderDispatchService.getEmployeMsg1(od.getEmployeId());
				String contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile") + "为您服务，注意用电安全请点击" + oneHref + "，详情咨询上门工程师。";
				if ("2".equals(temId)) {// 上门前1
					contentn = od.getCustomerName() + "您好，您的" + od.getServiceType() + "业务" + siteName + "已受理，" + msg1 + "，将为您提供服务，请保持电话通畅，监督电话：" + jdPhone + "。";
				}
				if ("3".equals(temId)) {// 上门前2
					contentn = "尊敬的用户：您的信息" + siteName + jdPhone + "已经派工，服务工程师" + msg2Names + "，联系电话" + msg2Mobiles + "，请您对我们的服务进行监督！";
				}
				if ("9".equals(temId)) {// 增值短信
					if ("2".equals(endMode)) {
						contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile") + "为您服务，注意用电安全请点击" + oneHref + "，详情咨询上门工程师。";
					}
					if ("3".equals(endMode)) {
						contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile") + "为您服务，另有专用自动止水水龙头，详情咨询上门工程师。";
					}
					if ("4".equals(endMode)) {
						contentn = "尊敬的" + od.getCustomerName() + "，您的" + od.getServiceType() + "业务，我司已受理，指派" + msg2.get("nameMobile")
								+ "为您服务，另有安全用电家电伴侣产品等为您提供试用，使您拥有最安心的家电使用体验，洗衣机专用自动止水水龙头和洗衣机底座，可有效防止水淹事故导致财产损失，延长家电安全使用寿命，详情咨询上门工程师。";
					}
				}
				if ("4".equals(temId)) {// 电话无人接听
					contentn = "尊敬的用户，您的电话无法接通状态，请您在方便的时候回复" + jdPhone + "或服务工程师电话" + msg1 + "，我们将尽快为您提供满意的服务！";
				}
				if ("12".equals(temId)) {// 配件无人接听
					contentn = "你好，你购买的商品今天到" + siteArea + "，联系你电话无人接听，看到短信后请联系" + siteMobile + "。";
				}
				if ("5".equals(temId)) {// 改约
					contentn = od.getCustomerName() + "您好，您的预约时间已改至" + proTime + "，" + od.getPromiseLimit() + "，具体上门时间，" + msg1 + "，会与您联系，监督电话：" + jdPhone + "。";
				}
				if ("6".equals(temId)) {// 缺件
					contentn = od.getCustomerName() + "您好，因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，" + msg1 + "，会与您联系，监督电话：" + jdPhone + "。";
				}
				String result1 = SfSmsUtils.sendMsg(st, contentn, sign);
				Integer sNumn = 0;
				Integer numn = getMsgNumbers(contentn, sign, "");// 成功发送的短信条数
				if (StringUtils.isNotBlank(result1)) {// 已发送
					sNumn = numn;
					successNum = successNum + numn;
					sm.setSendid(result1);
					sm.setStatus("1");
					sm.setReceiveTime(new Date());
				} else {
					sm.setSendid("0");
					sm.setStatus("0");
				}
				sm.setSendTime(new Date());
				sm.setCreateTime(new Date());
				sm.setCreateBy(name);

				sm.setExtno(extno);
				sm.setCreateType(user.getUserType());
				sm.setSiteId(siteId);
				sm.setSiteMobile(r.getStr("mobile"));
				sm.setSign(sign);
				sm.setSmsNum(numn);
				sm.setContent(contentn);
				sm.setMobile(st);
				sm.setOrderId(yxIds[h]);
				sm.setOrderNumber(od.getNumber());
				h++;
				sm.setTemplateId(temId);
				if (extno.equals("6")) {// 上门前
					sm.setType("6");
				} else if (extno.equals("4")) {// 无人接听
					sm.setType("2");
				} else if (extno.equals("3")) {// 改约
					sm.setType("3");
				} else if (extno.equals("2")) {// 缺件
					sm.setType("4");
				} else if (extno.equals("5")) {
					sm.setType("5");
				} else if (extno.equals("11")) {
					sm.setType("7");
				} else if (extno.equals("7")) {
					sm.setType("8");
				} else if (extno.equals("9")) {
					sm.setType("9");
				} else if (extno.equals("8")) {
					sm.setType("0");// 待派工
				}
				ls.add(sm);
				// sendedSmsDao.save(sm);
			}
			sendedSmsDao.save(ls);
			if (successNum > 0) {
				// Db.update("update crm_site a set
				// a.sms_available_amount=(a.sms_available_amount-" + successNum + ") where
				// a.status='0' and a.id='" + siteId + "'");// 更新服务商短信数量
				smsService.consumeSms(successNum, siteId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public String mark(String ids, String siteId) {
		String mark = "";
		List<Record> list = Db.find("select * from crm_site_fitting_apply a where a.status in('0','1') and a.order_id in(" + ids + ") and a.site_id='" + siteId + "'");
		if (list.size() > 0) {
			mark = "1";
		} else {
			mark = "0";
		}
		return mark;
	}

	// 获取服务商短信数量
	public Map<String, Object> getMessageCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgCount", Db.queryInt("select sms_available_amount from crm_site where id=?", CrmUtils.getCurrentSiteId(UserUtils.getUser())));
		return map;
	}

	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> importUnfinishedOrder(Map<String, String> params, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "import");
		UnfinishedOrderExcelImportHandler handler = new UnfinishedOrderExcelImportHandler();
		handler.setStartSheet(1);
		handler.setStartRow(3);
		handler.setParams(params);
		try {
			new ExcelReader().readExcel(in, params.get("fileName"), handler);
			String sql = handler.getExecuteSql();
			handler.checkExistsOrderNum();
			List<Object[]> exeSqlParams = handler.getExecuteParams();
			if (exeSqlParams != null && exeSqlParams.size() > 0) {
				DBUtils.batchSaveOrUpdateSQL(sql, handler.getExecuteParams(), orderDao.getSession());
			}
			retMap.put("pass", "y");
			retMap.put("successCount", handler.getSuccessCount());
			retMap.put("errorCount", handler.getErrorCount());
			retMap.put("errorDetail", handler.getErrorDetail());
			retMap.put("importHints", "y");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return retMap;
	}

	/**
	 * 导入历史工单
	 * 
	 * @param params
	 * @param in
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> importHistoryOrder(Map<String, String> params, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "import");
		HistoryOrderExcelImportHandler handler = new HistoryOrderExcelImportHandler();
		handler.setStartSheet(1);
		handler.setStartRow(3);
		handler.setParams(params);
		try {
			new ExcelReader().readExcel(in, params.get("fileName"), handler);
			String sql = (String) handler.getExecuteSql();
			handler.checkExistsOrderNum();
			List<Object[]> exeSqlParams = handler.getExecuteParams();
			if (exeSqlParams != null && exeSqlParams.size() > 0) {
				DBUtils.batchSaveOrUpdateSQL(sql, handler.getExecuteParams(), orderDao.getSession());
			}
			retMap.put("pass", "y");
			retMap.put("successCount", handler.getSuccessCount());
			retMap.put("errorCount", handler.getErrorCount());
			retMap.put("errorDetail", handler.getErrorDetail());
			retMap.put("importHints", "y");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return retMap;
	}

	/**
	 * 导入电商模板
	 * 
	 * @param webparams
	 * @param in
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> importEOrderExcelTemplate(Map<String, String> webparams, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "import");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String userId = user.getId();
		Site site = siteService.get(siteId);
		EOrderExcelImportHandler eoi = new EOrderExcelImportHandler();
		Map<String, Object> params = Maps.newHashMap();
		String templateId = webparams.get("templateId");
		params.put("templateId", templateId);
		params.put("siteId", siteId);
		params.put("siteName", site.getName());
		Record tempRd = Db.findById("crm_order_import_excel_template", templateId);
		eoi.setStartRow(Integer.valueOf(tempRd.getStr("startline")));
		params.put("templateRecord", tempRd);
		params.put("userId", userId);
		params.put("isHistory", webparams.get("isHistory"));
		params.put("now", new Date());
		params.put("status", "1");
		eoi.setParams(params);
		List<Record> serviceTypeList = serviceTypeDao.filterServiceType(null);
		Map<String, Object> serviceTypeMap = DataUtils.records2Map(serviceTypeList, "name");
		List<Record> serviceModeList = serviceModeDao.filterServiceMode(null);
		Map<String, Object> serviceModeMap = DataUtils.records2Map(serviceModeList, "name");
		params.put("serviceTypeMap", serviceTypeMap);
		params.put("serviceModeMap", serviceModeMap);
		int successCount = 0;
		try {
			new ExcelReader().read(in, webparams.get("extName"), eoi);
			List<Object[]> exeSqlParams = eoi.getExecuteParams();
			if (exeSqlParams != null && exeSqlParams.size() > 0) {
				DBUtils.batchSaveOrUpdateSQL(eoi.getExecuteSql(), exeSqlParams, siteDao.getSession());
			}
			successCount = eoi.getSuccessCount();
			retMap.put("pass", "y");
		} catch (Exception e) {
			e.printStackTrace();
			retMap.put("pass", "n");
		}
		retMap.put("successCount", successCount);

		return retMap;
	}

	/**
	 * 导入其他平台模板
	 * 
	 * @param webparams
	 * @param in
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> importEOrderExcelOlatform(Map<String, String> webparams, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "import");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String userId = user.getId();
		Site site = siteService.get(siteId);
		EOrderExcelImportHandler eoi = new EOrderExcelImportHandler();
		Map<String, Object> params = Maps.newHashMap();
		String templateId = webparams.get("templateId");
		params.put("templateId", templateId);
		params.put("siteId", siteId);
		params.put("siteName", site.getName());
		Record tempRd = Db.findById("crm_order_import_excel_template", templateId);
		eoi.setStartRow(Integer.valueOf(tempRd.getStr("startline")));
		params.put("templateRecord", tempRd);
		params.put("userId", userId);
		params.put("now", new Date());
		params.put("status", "5");
		eoi.setParams(params);
		List<Record> serviceTypeList = serviceTypeDao.filterServiceType(null);
		Map<String, Object> serviceTypeMap = DataUtils.records2Map(serviceTypeList, "name");
		List<Record> serviceModeList = serviceModeDao.filterServiceMode(null);
		Map<String, Object> serviceModeMap = DataUtils.records2Map(serviceModeList, "name");
		params.put("serviceTypeMap", serviceTypeMap);
		params.put("serviceModeMap", serviceModeMap);
		int successCount = 0;
		try {
			new ExcelReader().read(in, webparams.get("extName"), eoi);
			List<Object[]> exeSqlParams = eoi.getExecuteParams();
			if (exeSqlParams != null && exeSqlParams.size() > 0) {
				DBUtils.batchSaveOrUpdateSQL(eoi.getExecuteSql(), exeSqlParams, siteDao.getSession());
			}
			successCount = eoi.getSuccessCount();
			retMap.put("pass", "y");
		} catch (Exception e) {
			e.printStackTrace();
			retMap.put("pass", "n");
		}
		retMap.put("successCount", successCount);

		return retMap;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> checkUnfinishedOrder(Map<String, String> params, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "check");
		UnfinishedOrderExcelImportHandler handler = new UnfinishedOrderExcelImportHandler();
		handler.setStartSheet(1);
		handler.setStartRow(2);
		handler.setParams(params);
		try {
			new ExcelReader().check(in, params.get("extName"), handler);
			Map<String, Object> map = (Map<String, Object>) handler.getHandlerResult();
			Map<String, String> existsOrderMap = (Map<String, String>) map.get("existsOrderMap");
			String result = (String) map.get("TemplateError");
			if ("TemplateError".equalsIgnoreCase(result)) {
				retMap.put("templateError", "y");
			} else if (existsOrderMap.size() > 0) {
				for (String key : existsOrderMap.keySet()) {
					String vas = existsOrderMap.get(key);
					if (vas.indexOf(",") != -1) {
						int one = vas.indexOf(",", 0);
						handler.appendErrorDetail("<p>第" + vas.substring(0, one) + "行数据与第" + vas.substring((one + 1), vas.length()) + "行工单编号重复" + "</p>");
					}
				}
				String error = handler.getErrorDetail();
				if (StringUtils.isNotBlank(error)) {
					retMap.put("errorDetail", error);
					retMap.put("errorMessage", "y");
				} else {
					retMap.put("pass", "y");
				}

			} else if ("overLimit".equalsIgnoreCase((String) map.get("overLimit"))) {
				retMap.put("overLimit", "y");
			} else {
				retMap.put("pass", "y");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return retMap;
	}

	/**
	 * 历史工单导入数据检测
	 * 
	 * @param params
	 * @param in
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> checkHistoryOrder(Map<String, String> params, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "check");
		HistoryOrderExcelImportHandler handler = new HistoryOrderExcelImportHandler();
		handler.setStartSheet(1);
		handler.setStartRow(2);
		handler.setParams(params);
		try {
			new ExcelReader().check(in, params.get("extName"), handler);
			Map<String, Object> map = (Map<String, Object>) handler.getHandlerResult();
			Map<String, String> existsOrderMap = (Map<String, String>) map.get("existsOrderMap");
			String result = (String) map.get("TemplateError");
			if (existsOrderMap.size() > 0) {
				for (String key : existsOrderMap.keySet()) {
					String vas = existsOrderMap.get(key);
					if (vas.contains(",")) {
						int one = vas.indexOf(",", 0);
						handler.appendErrorDetail("<p>第" + vas.substring(0, one) + "行数据与第" + vas.substring((one + 1), vas.length()) + "行工单编号重复" + "</p>");
					}
				}
				String hanl = handler.getErrorDetail();
				if (StringUtils.isNotBlank(hanl)) {
					retMap.put("errorDetail", hanl);
					retMap.put("errorMessage", "y");
				} else {
					retMap.put("pass", "y");
				}

			}
			if ("TemplateError".equalsIgnoreCase(result)) {
				retMap.put("templateError", "y");
			} else if ("overLimit".equalsIgnoreCase((String) map.get("overLimit"))) {
				retMap.put("overLimit", "y");
			} else {
				retMap.put("pass", "y");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return retMap;
	}

	/**
	 * 检查导入电商模板
	 * 
	 * @param webparams
	 * @param in
	 * @return
	 */
	public Map<String, Object> checkEOrderExcelTemplate(Map<String, String> webparams, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "check");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String userId = user.getId();
		Site site = siteService.get(siteId);
		EOrderExcelImportHandler eoi = new EOrderExcelImportHandler();
		eoi.setMaxRows(5000);
		Map<String, Object> params = Maps.newHashMap();
		String templateId = webparams.get("templateId");
		params.put("templateId", templateId);
		params.put("siteId", siteId);
		params.put("siteName", site.getName());
		Record tempRd = Db.findById("crm_order_import_excel_template", templateId);
		eoi.setStartRow(Integer.valueOf(tempRd.getStr("startline")));
		params.put("templateRecord", tempRd);
		params.put("userId", userId);
		params.put("now", new Date());
		eoi.setParams(params);
		// File ef = new File("/home/ivan/Desktop/excel/苏宁.xls");
		try {
			new ExcelReader().check(in, webparams.get("extName"), eoi);
			String errMsg = (String) eoi.getHandlerResult();
			if (StringUtils.isNotBlank(errMsg)) {
				if ("overLimit".equalsIgnoreCase(errMsg)) {
					retMap.put("overLimit", "y");
				} else if ("dataError".equalsIgnoreCase(errMsg)) {
					retMap.put("errorMessage", "y");
					retMap.put("errorDetail", eoi.getErrorDetail());
				} else {
					retMap.put("templateError", "y");
				}
			} else {
				retMap.put("pass", "y");
			}
		} catch (Exception e) {
			e.printStackTrace();
			retMap.put("templateError", "y");
		}
		return retMap;
	}

	public Record getCustomerAddress(String siteId) {
		String sql = "SELECT province,city,AREA,address FROM crm_site WHERE id='" + siteId + "' ";
		return Db.findFirst(sql);
	}

	public List<Record> getTag(String tag) {
		return Db.find("select * from sys_sms_template a where a.tag='" + tag + "' order by a.id");
	}

	public Record pingjia(String id) {
		return Db.findFirst("select * from sys_sms_template a where a.id='" + id + "'");
	}

	// 查找相似工单
	public Record getOrderMobile(Order or, String siteId) {
		return orderDao.getOrderMobile(or, siteId);
	}

	/* 2017查找相似工单 */
	public Record getOrder2017Mobile(HistoryBkOrder or, String siteId) {
		return orderDao.getOrder2017Mobile(or, siteId);
	}

	public Record getDetailByOrderNum(String orderNum, String siteId) {
		return Db.findFirst("select a.* from crm_order a where a.number=? and a.site_id=?", orderNum, siteId);
	}

	public Record getDetailByOrderNum2017(String orderNum, String siteId) {
		String orderTable = tableSplitMapper.mapOrder(siteId);
		if (orderTable == null) {
			return null;
		}
		return Db.findFirst("select a.* from " + orderTable + " a where a.number=? and a.site_id=?", orderNum, siteId);
	}

	public List<Record> getOrderRelatedEmployeList(String orderId) {
		SqlKit kit = new SqlKit().append("SELECT e.* FROM").append("(SELECT * FROM `crm_order_dispatch_employe_rel` AS rel").append("WHERE rel.`dispatch_id`=(")
				.append("SELECT d.`id` FROM crm_order_dispatch AS d").append("WHERE d.`order_id`=? AND d.`status`='5' LIMIT 1)").append(") AS rt")
				.append("INNER JOIN crm_employe AS e").append("ON e.`status`='0' AND e.`id` = rt.emp_id AND (rt.emp_id=e.`id` OR rt.emp_name = e.`name`)");
		return Db.find(kit.toString(), orderId);
	}

	public List<Record> getOrderRelatedEmployeList2017(String orderId, String siteId) {
		String relTable = tableSplitMapper.mapOrderDispatchEmployeRel(siteId);
		String dispatchTable = tableSplitMapper.mapOrderDispatch(siteId);
		if (relTable == null) {
			return new ArrayList<>();
		}

		SqlKit kit = new SqlKit().append("SELECT e.* FROM").append("(SELECT * FROM " + relTable + " AS rel").append("WHERE rel.`dispatch_id`=(")
				.append("SELECT d.`id` FROM " + dispatchTable + " AS d").append("WHERE d.`order_id`=? AND d.`status`='5' LIMIT 1)").append(") AS rt")
				.append("INNER JOIN crm_employe AS e").append("ON e.`status`='0' AND e.`id` = rt.emp_id AND (rt.emp_id=e.`id` OR rt.emp_name = e.`name`)");
		return Db.find(kit.toString(), orderId);
	}

	@SuppressWarnings("rawtypes")
	@Transactional(rollbackFor = Exception.class)
	public Object delWxgd(String[] idsToDel) {
		Result rt = new Result();
		if (idsToDel == null || idsToDel.length == 0) {// ids为空
			rt.setCode("421");
			rt.setErrMsg("please select data");
			return rt;
		}
		Session session = orderDao.getSession();
		// 工单
		SQLQuery sqlQuery = session.createSQLQuery("delete from crm_order where `id` in (:ids)");
		sqlQuery.setParameterList("ids", idsToDel);
		int update = sqlQuery.executeUpdate();
		if (update > 0) {
			logger.info(String.format("order %s del found", Arrays.toString(idsToDel)));
		}

		// 派工
		SQLQuery sqlQuery2 = session.createSQLQuery("delete from crm_order_dispatch where order_id in(:ids)");
		sqlQuery2.setParameterList("ids", idsToDel);
		sqlQuery2.executeUpdate();
		// 派工与工程师关系表
		SQLQuery sqlQuery3 = session.createSQLQuery("delete from crm_order_dispatch_employe_rel where order_id in(:ids)");
		sqlQuery3.setParameterList("ids", idsToDel);
		sqlQuery3.executeUpdate();
		// 回访
		SQLQuery sqlQuery4 = session.createSQLQuery("delete from crm_order_callback where order_id in(:ids)");
		sqlQuery4.setParameterList("ids", idsToDel);
		sqlQuery4.executeUpdate();
		// 反馈
		SQLQuery sqlQuery5 = session.createSQLQuery("delete from crm_order_feedback where order_id in(:ids)");
		sqlQuery5.setParameterList("ids", idsToDel);
		sqlQuery5.executeUpdate();
		// 结算
		SQLQuery sqlQuery6 = session.createSQLQuery("delete from crm_order_settlement where order_id in(:ids)");
		sqlQuery6.setParameterList("ids", idsToDel);
		sqlQuery6.executeUpdate();
		// 结算明细
		SQLQuery sqlQuery7 = session.createSQLQuery("delete from crm_order_settlement_detail where order_id in(:ids)");
		sqlQuery7.setParameterList("ids", idsToDel);
		sqlQuery7.executeUpdate();
		rt.setCode("200");
		rt.setMsg("success");

		onOrderCountChanged(CrmUtils.getCurrentSiteId(UserUtils.getUser()), OrderCountChangeTypes.TYPE_scgd);
		return rt;
	}

	@SuppressWarnings("rawtypes")
	@Transactional(rollbackFor = Exception.class)
	public Object delWxgd2017(String[] idsToDel) {
		Result rt = new Result();
		if (idsToDel == null || idsToDel.length == 0) {// ids为空
			rt.setCode("421");
			rt.setErrMsg("please select data");
			return rt;
		}

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderTable = tableSplitMapper.mapOrder(siteId);
		String dispatchTable = tableSplitMapper.mapOrderDispatch(siteId);
		String relTable = tableSplitMapper.mapOrderDispatchEmployeRel(siteId);
		String callbackTable = tableSplitMapper.mapOrderCallback(siteId);
		String feedbackTable = tableSplitMapper.mapOrderFeedback(siteId);
		String settlementTable = tableSplitMapper.mapOrderSettlement(siteId);
		String settlementDetailTable = tableSplitMapper.mapOrderSettlementDetail(siteId);
		if (orderTable == null || dispatchTable == null || relTable == null || callbackTable == null || feedbackTable == null || settlementTable == null
				|| settlementDetailTable == null) {
			rt.setCode("422");
			logger.error("map table failed when del wxgd");
			return rt;
		}

		Session session = orderDao.getSession();
		List<Order> orders = orderDao.getByOrderIds(org.apache.commons.lang3.StringUtils.join(idsToDel, ","));
		for (Order o : orders) {
			if (!"8".equals(o.getStatus())) {
				rt.setCode("422");
				logger.error("found valid order");
				return rt;
			}
		}

		// 工单
		SQLQuery sqlQuery = session.createSQLQuery("delete from " + orderTable + " where `id` in (:ids)");
		sqlQuery.setParameterList("ids", idsToDel);
		int update = sqlQuery.executeUpdate();
		if (update > 0) {
			logger.info(String.format("order %s del found", Arrays.toString(idsToDel)));
		}

		// 派工
		SQLQuery sqlQuery2 = session.createSQLQuery("delete from " + dispatchTable + " where order_id in(:ids)");
		sqlQuery2.setParameterList("ids", idsToDel);
		sqlQuery2.executeUpdate();
		// 派工与工程师关系表
		SQLQuery sqlQuery3 = session.createSQLQuery("delete from " + relTable + " where order_id in(:ids)");
		sqlQuery3.setParameterList("ids", idsToDel);
		sqlQuery3.executeUpdate();
		// 回访
		SQLQuery sqlQuery4 = session.createSQLQuery("delete from " + callbackTable + " where order_id in(:ids)");
		sqlQuery4.setParameterList("ids", idsToDel);
		sqlQuery4.executeUpdate();
		// 反馈
		SQLQuery sqlQuery5 = session.createSQLQuery("delete from " + feedbackTable + " where order_id in(:ids)");
		sqlQuery5.setParameterList("ids", idsToDel);
		sqlQuery5.executeUpdate();
		// 结算
		SQLQuery sqlQuery6 = session.createSQLQuery("delete from " + settlementTable + " where order_id in(:ids)");
		sqlQuery6.setParameterList("ids", idsToDel);
		sqlQuery6.executeUpdate();
		// 结算明细
		SQLQuery sqlQuery7 = session.createSQLQuery("delete from " + settlementDetailTable + " where order_id in(:ids)");
		sqlQuery7.setParameterList("ids", idsToDel);
		sqlQuery7.executeUpdate();
		rt.setCode("200");
		rt.setMsg("success");

		onOrderCountChanged(CrmUtils.getCurrentSiteId(UserUtils.getUser()), OrderCountChangeTypes.TYPE_scgd);
		return rt;
	}

	@SuppressWarnings("unchecked")
	public List<Order> getByIds(String[] ids) {
		Query query = orderDao.getSession().createQuery("from Order where id in(:alist)");
		query.setParameterList("alist", ids);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Record> getByIds2017(String[] ids, String siteId) {
		return order2017Dao.findOrderByIds(ids, siteId);
	}

	@Transactional(rollbackFor = Exception.class)
	public void markOrders(String[] ids, String flag, String flagDesc, String flagAlertTime) {
		if (ids != null && ids.length > 0) {
			String operator = CrmUtils.getUserXM();
			List<String> idList = Arrays.asList(ids);
			List<Order> orders = orderDao.getOrderById(idList);
			for (Order o : orders) {
				o.setFlag(flag);
				o.setFlagDesc(flagDesc);
				if (StringUtil.isNotBlank(flagAlertTime)) {
					o.setFlagAlertDate(com.jojowonet.modules.operate.utils.DateUtils.parseDate(flagAlertTime, "yyyy-MM-dd"));
				}
				o.newTarget(Target.MARK_ORDER, operator, "标记工单：" + flagDesc);
			}
			orderDao.save(orders);
		}
	}

	/**
	 * 标记工单（2017）
	 * 
	 * @param ids
	 * @param flag
	 * @param flagDesc
	 * @param flagAlertTime
	 */
	@Transactional(rollbackFor = Exception.class)
	public void markOrdersFor2017(String[] ids, String flag, String flagDesc, String flagAlertTime) {
		if (ids != null && ids.length > 0) {
			String operator = CrmUtils.getUserXM();
			List<String> idList = Arrays.asList(ids);
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			List<Record> orders = order2017Dao.getOrder2017ById(idList, siteId);
			String orderTable = tableSplitMapper.mapOrder(siteId);
			if (orderTable == null) {
				throw new RuntimeException("table not found,siteId=" + siteId);
			}

			for (Record o : orders) {
				// o.setFlag(flag);
				// o.setFlagDesc(flagDesc);
				// if (StringUtil.isNotBlank(flagAlertTime)) {
				// o.setFlagAlertDate(com.jojowonet.modules.operate.utils.DateUtils.parseDate(flagAlertTime,
				// "yyyy-MM-dd"));
				// }
				// o.newTarget(Target.MARK_ORDER, operator, "标记工单：" + flagDesc);

				if (StringUtil.isBlank(flagAlertTime)) {
					flagAlertTime = null;
				}
				String oldProcessDetail = o.getStr("process_detail");
				String processDetail = CrmUtils.newTarget(Target.MARK_ORDER, operator, "标记工单：" + flagDesc, oldProcessDetail);
				Db.update("update " + orderTable + " set flag=?,flag_desc=?,flag_alert_date=?,process_detail=? where id=?", flag, flagDesc, flagAlertTime, processDetail,
						o.getStr("id"));
			}
			// order2017Dao.save(orders);
		}
	}

	@Transactional(rollbackFor = Exception.class)
	public void cancelOrdersMark(String orderIds[]) {
		if (orderIds != null && orderIds.length > 0) {
			String operator = CrmUtils.getUserXM();
			List<Order> orders = orderDao.getOrderById(Arrays.asList(orderIds));
			for (Order o : orders) {
				o.setFlag(null);
				o.setFlagDesc(null);
				o.setFlagAlertDate(null);
				o.newTarget(Target.MARK_ORDER, operator, "取消标记");
			}
		}
	}

	/**
	 * 取消标记工单（2017）
	 * 
	 * @param orderIds
	 */
	@Transactional(rollbackFor = Exception.class)
	public void cancelOrdersMarkFor2017(String orderIds[]) {
		if (orderIds != null && orderIds.length > 0) {
			String operator = CrmUtils.getUserXM();
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			String orderTable = tableSplitMapper.mapOrder(siteId);
			if (orderTable == null) {
				throw new RuntimeException("table not found,siteId=" + siteId);
			}

			List<Record> orders = order2017Dao.getOrder2017ById(Arrays.asList(orderIds), siteId);
			for (Record o : orders) {
				String oldProcessDetail = o.getStr("process_detail");
				String processDetail = CrmUtils.newTarget(Target.MARK_ORDER, operator, "取消标记", oldProcessDetail);
				Db.update("update " + orderTable + " set flag=?,flag_desc=?,flag_alert_date=?,process_detail=? where id=?", null, null, null, processDetail, o.getStr("id"));
			}
		}
	}

	public Page<Record> getorderListQuick(Page<Record> page, String siteId, String status, String type) {
		List<Record> list = orderDao.getorderListQuick(siteId, status, type);
		if (StringUtils.isNotBlank(tableSplitMapper.mapOrder(siteId))) {
			List<Record> listhis = orderDao.getorderHistoryListQuick(siteId, status, type);
			list.addAll(listhis);
		}
		long count = 0;
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> getorderListQuick400(Page<Record> page, String siteId, String status, String type) {
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", siteId);
		params.put("status", status);
		params.put("type", type);
		Result<Page<CrmOrder400Vo>> resp = ez400Template.postForm("/order400/getorderList400Quick", params, new ParameterizedTypeReference<Result<Page<CrmOrder400Vo>>>() {
		});
		if (!resp.isOk()) {
			throw new NetworkException("get quick order 400 failed");
		}

		List<CrmOrder400Vo> data = resp.getData().getList();
		List<Record> retList = new ArrayList<>();
		for (CrmOrder400Vo v : data) {
			retList.add(v.asRecord());
		}
		page.setList(retList);
		page.setCount(0);
		return page;
	}

	@Transactional(rollbackFor = Exception.class)
	public Result<T> confirmAccount(String id, String factoryNumber) {
		Result<T> rt = new Result();
		String name = CrmUtils.getUserXM();
		Date record_account_time = new Date();
		String userId = UserUtils.getUser().getId();
		try {
			if (factoryNumber.length() > 32) {
				rt.setCode("500");
				rt.setMsg("factoryNumber too lang!");
				return rt;
			}
			Target ta = new Target();
			ta.setContent(name + "确认已录单");
			ta.setName(name);
			ta.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			ta.setType(Target.SITE_EDIT_CONFIRM_RECORD_TYPE);
			Record rd = Db.findFirst("select a.process_detail from crm_order a where a.id=?", id);
			String updateStr = "update crm_order a set a.record_account = '1', a.record_account_time =?,a.record_account_by='" + userId + "' where a.id=?";
			if (StringUtil.isNotBlank(factoryNumber)) {
				updateStr = "update crm_order a set a.record_account = '1', a.record_account_time =?, a.factory_number='" + factoryNumber
						+ "',a.latest_process=?,a.latest_process_time=now(),a.process_detail=?,a.record_account_by='" + userId + "' where a.id=?";
			}
			Db.update(updateStr, record_account_time, name + "确认已录单", WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail")), id);
			rt.setCode("200");
			rt.setMsg("confirmAccount success !");
			return rt;
		} catch (Exception e) {
			rt.setCode("421");
			rt.setErrMsg("confirmAccount wrong !");
			return rt;
		}
	}

	@Transactional(rollbackFor = Exception.class)
	public Result<T> confirmAccount2017(String id, String factoryNumber) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderTable = tableSplitMapper.mapOrder(siteId);
		if (orderTable == null) {
			throw new RuntimeException("order map table required,siteid:" + siteId);
		}

		Result<T> rt = new Result();
		String name = CrmUtils.getUserXM();
		Date record_account_time = new Date();
		try {
			if (factoryNumber.length() > 32) {
				rt.setCode("500");
				rt.setMsg("factoryNumber too lang!");
				return rt;
			}
			Target ta = new Target();
			ta.setContent(name + "确认已录单");
			ta.setName(name);
			ta.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			ta.setType(Target.SITE_EDIT_CONFIRM_RECORD_TYPE);
			Record rd = order2017Dao.findOrderById(id, siteId);
			String updateStr = "update " + orderTable + " a set a.record_account = '1', a.record_account_time =? where a.id=?";
			if (StringUtil.isNotBlank(factoryNumber)) {
				updateStr = "update " + orderTable + " a set a.record_account = '1', a.record_account_time =?, a.factory_number='" + factoryNumber
						+ "',a.latest_process=?,a.latest_process_time=now(),a.process_detail=? where a.id=?";
			}
			Db.update(updateStr, record_account_time, name + "确认已录单", WebPageFunUtils.appendProcessDetail(ta, rd.getStr("process_detail")), id);
			rt.setCode("200");
			rt.setMsg("confirmAccount success !");
			return rt;
		} catch (Exception e) {
			rt.setCode("421");
			rt.setErrMsg("confirmAccount wrong !");
			return rt;
		}
	}

	// 今日提醒标记工单列表
	public Page<Record> getJrtxbjList(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderJrtxbjList(page, siteId, status, map, cateList, brandList);
		long count = orderDao.getOrderJrtxbjCount(siteId, status, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Record> getJrtxbjListExport(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		List<Record> list = orderDao.getOrderJrtxbjList(page, siteId, status, map, cateList, brandList);
		for (Record rd : list) {
			String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
			rd.set("customer_mobile", customerMobiles);
			BigDecimal auxiliaryCost = rd.getBigDecimal("auxiliary_cost");
			BigDecimal serveCost = rd.getBigDecimal("serve_cost");
			BigDecimal warrantyCost = rd.getBigDecimal("warranty_cost");
			rd.set("totalMoney", auxiliaryCost.add(serveCost).add(warrantyCost));
		}
		return list;
	}

	/**
	 * 工单批量复制
	 * 
	 * @param orderId
	 *            工单id
	 * @param nums
	 *            复制数量
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public String copyOrder(String orderId, int nums) {
		Order order = orderDao.get(orderId);
		// 该工单并非带派工工单
		if (!"1".equals(order.getStatus())) {
			return "401";
		}
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String code = siteMsgService.ifOpenOrderSet(siteId);// code=200是工单编号自定义开启

		if ("200".equals(code)) {

		}
		List<Order> list = Lists.newArrayList();
		List<SimpleOrderNo> son = new ArrayList<SimpleOrderNo>();
		if ("200".equals(code)) {
			son = CrmUtils.genOrderNos(siteId, nums);
		}
		Integer sonMark = 0;

		for (int i = 0; i < nums; i++) {
			Order o = new Order();
			o.setCallbackResult(order.getCallbackResult());
			o.setAuxiliaryCost(order.getAuxiliaryCost());
			o.setApplianceNum(order.getApplianceNum());
			o.setApplianceModel(order.getApplianceModel());
			o.setApplianceMachineCode(order.getApplianceMachineCode());
			o.setApplianceCategory(order.getApplianceCategory());
			o.setApplianceBuyTime(order.getApplianceBuyTime());
			o.setApplianceBrand(order.getApplianceBrand());
			o.setNumber(RandomUtil.randomOrderNumber());
			if ("200".equals(code)) {
				if (son.size() > 0) {
					SimpleOrderNo sonEntity = son.get(sonMark);
					o.setNumber(sonEntity.getNo());
					o.setSeq(sonEntity.getS());
					sonMark++;
				}
			}
			o.setCustomerType(order.getCustomerType());
			o.setPleaseReferMall(order.getPleaseReferMall());
			o.setCallbackTime(order.getCallbackTime());
			o.setCanoper(order.getCanoper());
			o.setConfirmCost(order.getConfirmCost());
			o.setCreateBy(order.getCreateBy());
			o.setCreateTime(new Date());
			o.setProvince(order.getProvince());
			o.setCity(order.getCity());
			o.setArea(order.getArea());
			o.setCustomerAddress(order.getCustomerAddress());
			o.setCustomerFeedback(order.getCustomerFeedback());
			o.setCustomerLnglat(order.getCustomerLnglat());
			o.setCustomerMobile(order.getCustomerMobile());
			o.setCustomerName(order.getCustomerName());
			o.setCustomerTelephone(order.getCustomerTelephone());
			o.setCustomerTelephone2(order.getCustomerTelephone2());
			o.setDropinCount(order.getDropinCount());
			o.setEmployeId(order.getEmployeId());
			o.setEmployeName(order.getEmployeName());
			o.setEndTime(order.getEndTime());
			o.setFittingFlag(order.getFittingFlag());
			o.setFlag(order.getFlag());
			o.setFlagAlertDate(order.getFlagAlertDate());
			o.setFlagDesc(order.getFlagDesc());
			o.setLatestProcess(order.getLatestProcess());
			o.setLatestProcessTime(order.getLatestProcessTime());
			o.setLevel(order.getLevel());
			o.setMalfunctionCause(order.getMalfunctionCause());
			o.setMalfunctionCauseDescription(order.getMalfunctionCauseDescription());
			o.setMalfunctionDescription(order.getMalfunctionDescription());
			o.setMalfunctionType(order.getMalfunctionType());
			o.setMeasures(order.getMeasures());
			o.setMeasuresDescription(order.getMeasuresDescription());
			o.setMessengerId(order.getMessengerId());
			o.setMessengerName(order.getMessengerName());
			o.setOrderType(order.getOrderType());
			o.setOrigin(order.getOrigin());
			o.setProcessDetail(order.getProcessDetail());
			o.setPromiseLimit(order.getPromiseLimit());
			o.setPromiseTime(order.getPromiseTime());
			o.setRecordAccount(order.getRecordAccount());
			o.setRejectCount(order.getRejectCount());
			o.setRemarks(order.getRemarks());
			o.setRepairTime(order.getRepairTime());
			o.setReturnCard(order.getReturnCard());
			o.setReturnCardTime(order.getReturnCardTime());
			o.setReview(order.getReview());
			o.setServeCost(order.getServeCost());
			o.setServiceMode(order.getServiceMode());
			o.setServiceType(order.getServiceType());
			o.setSiteId(order.getSiteId());
			o.setSiteName(order.getSiteName());
			o.setStatus(order.getStatus());
			o.setTelCount(order.getTelCount());
			o.setUpdateName(order.getUpdateName());
			o.setUpdateTime(order.getUpdateTime());
			o.setWarrantyCost(order.getWarrantyCost());
			o.setWarrantyType(order.getWarrantyType());
			o.setWhetherCollection(order.getWhetherCollection());
			list.add(o);
		}
		orderDao.save(list);
		onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_fzgd);
		return "200";
	}

	public Map<String, Object> jiaodanPageShow(String ids) {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Record> list = Db
				.find("select a.id from crm_order a where a.id in (" + StringUtil.joinInSql(ids.split(",")) + ") and a.status in('3','4','5','8') and a.return_card!='1' ");
		Long count = Db.queryLong(
				"select count(*) from crm_order a where a.id in (" + StringUtil.joinInSql(ids.split(",")) + ") and a.status in('3','4','5','8') and a.return_card!='1' ");
		Record record = Db.findFirst(
				"SELECT a.whether_collection,sum(a.confirm_cost) as shishouMoney,(SUM(a.warranty_cost)+SUM(a.auxiliary_cost)+SUM(a.serve_cost)) as realPayMoney, (SUM(a.confirm_cost)-SUM(b.payment_amount)) AS flashMoney,SUM(b.payment_amount) AS allMoney,SUM(CASE WHEN b.payment_type='0' THEN b.payment_amount ELSE 0 END) AS  zfbMoney,SUM(CASE WHEN b.payment_type='1' THEN b.payment_amount ELSE 0 END) AS wxMoney from crm_order a LEFT JOIN crm_order_collections b ON a.id=b.order_id AND b.source='0' AND b.status='0' where a.id in ("
						+ StringUtil.joinInSql(ids.split(",")) + ") and a.status in('3','4','5','8') and a.return_card!='1' ");// 待回访、待结算、已完成、无效工单可以交单
		String idss = "";
		for (Record rd : list) {
			if (StringUtils.isBlank(idss)) {
				idss += rd.getStr("id");
			} else {
				idss += "," + rd.getStr("id");
			}
		}
		map.put("count", count);
		map.put("data", record);
		map.put("idss", idss);
		return map;
	}

	public Map<String, Object> jiaodanPageShow2017(String ids) {
		Map<String, Object> map = new HashMap<>();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderTable = tableSplitMapper.mapOrder(siteId);
		if (orderTable == null) {
			throw new RuntimeException("order map table required,site_id=" + siteId);
		}

		List<Record> list = Db.find(
				"select a.id from " + orderTable + " a where a.id in (" + StringUtil.joinInSql(ids.split(",")) + ") and a.status in('3','4','5','8') and a.return_card!='1' ");
		Long count = Db.queryLong(
				"select count(*) from " + orderTable + " a where a.id in (" + StringUtil.joinInSql(ids.split(",")) + ") and a.status in('3','4','5','8') and a.return_card!='1' ");
		Record record = Db.findFirst(
				"SELECT a.whether_collection,sum(a.confirm_cost) as shishouMoney,(SUM(a.warranty_cost)+SUM(a.auxiliary_cost)+SUM(a.serve_cost)) as realPayMoney, (SUM(a.confirm_cost)-SUM(b.payment_amount)) AS flashMoney,SUM(b.payment_amount) AS allMoney,SUM(CASE WHEN b.payment_type='0' THEN b.payment_amount ELSE 0 END) AS  zfbMoney,SUM(CASE WHEN b.payment_type='1' THEN b.payment_amount ELSE 0 END) AS wxMoney from crm_order a LEFT JOIN crm_order_collections b ON a.id=b.order_id AND b.source='0' AND b.status='0' where a.id in ("
						+ StringUtil.joinInSql(ids.split(",")) + ") and a.status in('3','4','5','8') and a.return_card!='1' ");// 待回访、待结算、已完成、无效工单可以交单
		String idss = "";
		for (Record rd : list) {
			if (StringUtils.isBlank(idss)) {
				idss += rd.getStr("id");
			} else {
				idss += "," + rd.getStr("id");
			}
		}
		map.put("count", count);
		map.put("data", record);
		map.put("idss", idss);
		return map;
	}

	public String canMarkAsInvalid(String[] orderIds) {
		return orderDao.canMarkAsInvalid(orderIds);
	}

	public boolean hasWaitCallbackAndSettlementOrders(String empId) {
		if (StringUtil.isBlank(empId)) {
			throw new IllegalArgumentException("emp id is required");
		}
		return orderDao.hasWaitCallbackAndSettlementOrders(empId);
	}

	public String canBatchCopy(String[] ids) {
		return orderDao.canBatchCopy(ids);
	}

	public String checkIfAllowSendMsg(String siteId) {
		Record rd = Db.findFirst("select a.* from crm_site_common_setting a where a.site_id=? and a.type='4'", siteId);
		if (rd == null) {
			return "420";
		}
		if ("0".equals(rd.getStr("set_value"))) {
			return "420";
		}
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> erjiDispatch(String ids, String secondSiteId, String secondSiteName, String siteId) {
		String dt1 = DateToStringUtils.DateToString();
		Date date = new Date();
		Site site = siteDao.get(siteId);
		Site secondSite = siteDao.get(secondSiteId);
		Order order = orderDao.get(ids);
		Map<String, Object> map = new HashMap<String, Object>();
		if (!("1".equals(order.getStatus()))) {
			map.put("code", "201");
		} else {
			Order byNumber = orderDao.getOrderByNumber(order.getNumber(), secondSiteId);
			if (StringUtil.isEmpty(secondSiteId) || StringUtil.isEmpty(secondSiteName)) {
				map.put("code", "202");
			} else if (byNumber != null) {
				map.put("code", "422");
				return map;
			} else {
				Target ta1 = new Target();
				ta1.setContent(site.getName() + "派工至 " + secondSite.getName());
				ta1.setName(site.getName());
				ta1.setType(Target.DISPATCH_SECOND_ORDER);
				ta1.setTime(dt1);
				String str1 = WebPageFunUtils.appendProcessDetail(ta1, order.getProcessDetail());
				order.setProcessDetail(str1);
				order.setLatestProcess(site.getName() + "派工至 " + secondSite.getName());
				order.setLatestProcessTime(date);
				order.setSiteId(secondSiteId);
				order.setSiteName(secondSiteName);
				order.setParentSiteId(siteId);
				order.setParentDipatchFlag("1");
				order.setStatus("0");
				order.setParentStatus("2");
				orderDao.save(order);
				map.put("code", "200");
			}
		}
		return map;
	}

	/* 短信通知（短信自定义模板） */// temId,sign,content,extno,number,customerMobile,siteId,yxId
	@Transactional(rollbackFor = Exception.class)
	public String fwzSendmsgModelFwzDefined1400(String temId, String sign1, String content1, String extno, String numbers, String customerMobile, String siteId, String yxId,
			String markType) {
		String sign = "【" + sign1 + "】";
		String content = content1.trim();
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		Integer nums = getMsgNumbers(content, sign, "");
		String[] strg = customerMobile.split(",");
		Integer mks = nums * strg.length;
		Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
		if (mks > r.getInt("sms_available_amount")) {
			return "noMessage";
		}
		try {
			int h = 0;
			Integer successNum = 0;
			List<SendedSms> ls = new ArrayList<>();
			String[] yxIds = yxId.split(",");
			Record rd = Db.findFirst("select a.* from crm_site_sms_template a where a.id=?", temId);
			for (String st : customerMobile.split(",")) {
				String result1 = SfSmsUtils.sendMsg(st, content, sign);
				Integer sNumn = 0;
				SendedSms sm = new SendedSms();
				if (!"3".equals(result1.substring(0, 1))) {// 已发送
					sNumn = nums;// 成功发送的短信条数
					successNum = successNum + sNumn;
					sm.setSendid(result1);
					sm.setStatus("1");
					sm.setReceiveTime(new Date());
				} else {
					sm.setSendid("0");
					sm.setStatus("0");
				}
				sm.setSendTime(new Date());
				sm.setCreateTime(new Date());
				sm.setCreateBy(name);

				sm.setExtno(extno);
				sm.setCreateType(user.getUserType());
				sm.setSiteId(siteId);
				sm.setSiteMobile(r.getStr("mobile"));
				sm.setSign(sign);
				sm.setSmsNum(nums);
				sm.setContent(content);
				sm.setMobile(st);
				sm.setOrderId(yxIds[h]);
				Record rdRecord = Db.use(DbKey.DB_ORDER_400).findFirst("select a.* from crm_order_400 a where a.id=? ", yxIds[h]);
				sm.setOrderNumber(rdRecord != null ? rdRecord.getStr("number") : "");
				h++;
				sm.setTemplateId(temId);
				if (extno.equals("6")) {// 上门前
					sm.setType("6");
				} else if (extno.equals("4")) {// 无人接听
					sm.setType("2");
				} else if (extno.equals("3")) {// 改约
					sm.setType("3");
				} else if (extno.equals("2")) {// 缺件
					sm.setType("4");
				} else if (extno.equals("5")) {
					sm.setType("5");
				} else if (extno.equals("11")) {
					sm.setType("7");
				} else if (extno.equals("7")) {
					sm.setType("8");
				} else if (extno.equals("9")) {
					sm.setType("9");
				} else if (extno.equals("8")) {
					sm.setType("0");// 待派工
				} else if (extno.equals("0")) {
					sm.setType("1");// 自定义短信模板
				}
				ls.add(sm);
			}
			sendedSmsDao.save(ls);
			if (successNum > 0) {
				smsService.consumeSms(successNum, siteId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public String returnContent(String a, Order order, String phone) {
		Integer lgth = a.split("@").length - 1;
		for (int i = 0; i < lgth; i++) {
			a.indexOf("@", i);
			String str = a.substring(a.indexOf("@", i), a.indexOf("@", i) + 2);
			String cont = returnParams(order, str, phone) != null ? returnParams(order, str, phone) : "";
			a = a.substring(0, a.indexOf("@", i)) + cont + a.substring(a.indexOf("@", i) + 2, a.length());
		}
		return a;
	}

	public String returnParams(Order order, String str, String phone) {
		if ("@1".equals(str)) {// 用户姓名
			return order.getCustomerName();
		}
		if ("@2".equals(str)) {// 家电品牌
			return order.getApplianceBrand();
		}
		if ("@3".equals(str)) {// 家电品类
			return order.getApplianceCategory();
		}
		if ("@4".equals(str)) {// 服务类型
			return order.getServiceType();
		}
		if ("@5".equals(str)) {// 服务方式
			return order.getServiceMode();
		}
		if ("@6".equals(str)) {// 工程师姓名
			return order.getEmployeName();
		}
		if ("@7".equals(str)) {// 工程师电话
			String empMobiles = "";
			List<Record> list = new ArrayList<>();
			if (StringUtils.isNotBlank(order.getEmployeId())) {
				list = Db.find("select a.mobile from crm_employe a where a.id in(" + StringUtil.joinInSql(order.getEmployeId().split(",")) + ") and a.status='0'");
			}
			if (list.size() > 0) {
				for (Record rd : list) {
					if (StringUtils.isBlank(empMobiles)) {
						empMobiles = rd.getStr("mobile");
					} else {
						empMobiles = empMobiles + "," + rd.getStr("mobile");
					}
				}
			}
			return empMobiles;
		}
		if ("@8".equals(str)) {// 联系电话
			return phone;
		}
		return "";
	}

	public Map<String, Long> getPlatformCount(String siteId, String origin) {
		return orderDao.getPlatformCount(siteId, origin);
	}

	/*
	 * 平台工单
	 */
	public Page<Record> getPlatFormList(String siteId, Page<Record> page, Map<String, Object> map, String origin) {
		List<Record> list = orderDao.getPlatFormList(page, map, origin, siteId);
		Long count = orderDao.getPlatFormListCount(siteId, map, origin);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 接收工单
	@Transactional(rollbackFor = Exception.class)
	public Result<Void> recvOrders(String orderIds) {
		// 工单的状态应该是待接收
		String[] orderIdList = orderIds.split(",");
		List<Order> orders = orderDao.getOrderById(orderIdList);
		String uname = CrmUtils.getUserXM();
		String siteName = CrmUtils.getSiteName();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<String> list = Lists.newArrayList();
		Map<String, Object> pros = new HashMap<>();
		Map<String, Object> params = new HashMap<>();
		for (Order o : orders) {
			if (!siteId.equals(o.getSiteId())) {
				return Result.fail("422", "order gone"); // 可能是转派
			}
			if (!"0".equals(o.getStatus())) {
				return Result.fail("500", "order status invalid");
			}
			if (!"7".equals(o.getOrderType())) {
				return Result.fail("423", "order type invalid");
			}

			pros.put(o.getNumber(), o.getProcessDetail());
			list.add(o.getNumber());
		}
		params.put("siteId", siteId);
		params.put("uname", uname);
		params.put("siteName", siteName);
		params.put("orderNumber", list);
		params.put("process_detail", pros);
		// 修改厂家库中工单
		Result<String> ret = ezTemplate.postJson("/recvOrders", params, new ParameterizedTypeReference<Result<String>>() {
		});
		if (!"200".equals(ret.getCode())) {
			return Result.fail(ret.getCode(), "recv order failed");
		}
		return Result.ok();
	}

	// 拒单
	@Transactional(rollbackFor = Exception.class)
	public Result<Void> refuseOrders(String orderIds) {
		if (StringUtils.isBlank(orderIds)) {
			throw new IllegalArgumentException("order id required");
		}
		String[] orderIdList = orderIds.split(",");
		List<Order> orderList = orderDao.getOrderById(orderIdList);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<String> listNumber = Lists.newArrayList();
		Map<String, Object> params = new HashMap<>();
		Map<String, Object> pros = new HashMap<>();
		for (Order order : orderList) {
			if (StringUtils.isBlank(order.getStatus())) {
				return Result.fail("422", "not a factory order");
			}
			if (!"0".equals(order.getStatus())) {//
				return Result.fail("423", "order status changed, refresh and try again");
			}
			if (!siteId.equals(order.getSiteId())) {// 已转派
				return Result.fail("423", "order status changed, refresh and try again");
			}
			pros.put(order.getNumber(), order.getProcessDetail());
			listNumber.add(order.getNumber());
		}
		String uname = CrmUtils.getUserXM();
		String siteName = CrmUtils.getSiteName();
		params.put("siteId", siteId);
		params.put("siteName", siteName);
		params.put("uname", uname);
		params.put("orderNumber", listNumber);
		params.put("process_detail", pros);
		/*
		 * for (Order order : orderList) { String msg = String.format("%s 退回厂家派单",
		 * siteName); order.setStatus("9"); order.newTarget(Target.ACCEPT_ORDER, user,
		 * msg); order.setLatestProcess(msg); order.setLatestProcessTime(new Date()); }
		 */
		Result<String> ret = ezTemplate.postJson("/refuseOrders", params, new ParameterizedTypeReference<Result<String>>() {
		});
		if (!"200".equals(ret.getCode())) {
			return Result.fail("522", "order gone");
		}
		// orderDao.save(orderList);
		return Result.ok();
	}

	public Page<OrderReturnVisit> getFactoryReturn(Page<OrderReturnVisit> page, Map<String, Object> params, String siteId, List<Map<String, Object>> returnlist) {
		params.put("PageNo", page.getPageNo());
		params.put("PageSize", page.getPageSize());
		params.put("siteId", siteId);
		Result<Map<String, Object>> ret = ezTemplate.postForm("/getfactoryReturnVisit", params, new ParameterizedTypeReference<Result<Map<String, Object>>>() {
		});
		Map<String, Object> map = ret.getData();
		List<Map<String, Object>> lists = (List) map.get("list");
		List<OrderReturnVisit> list = getOrderReturnVisitList(lists);
		long count = Long.parseLong(map.get("count").toString());
		// 获取所有回访明细数据
		List<Map<String, Object>> returnvisit = (List) map.get("returnvisit");
		sortByOrderReturnVisit(list, returnlist, returnvisit);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Map<String, Object>> getreturnlist() {
		Map<String, Object> params = Maps.newHashMap();
		Result<List<Map<String, Object>>> ret = ezTemplate.postForm("/getReturnVisitList", params, new ParameterizedTypeReference<Result<List<Map<String, Object>>>>() {
		});
		// 获取所有回访自定义项
		List<Map<String, Object>> returnlist = (List) ret.getData();

		return returnlist;
	}

	public List<OrderReturnVisit> getOrderReturnVisitList(List<Map<String, Object>> rds) {
		List<OrderReturnVisit> lists = Lists.newArrayList();
		for (Map<String, Object> rd : rds) {
			OrderReturnVisit od = new OrderReturnVisit();
			od.setId(rd.get("id").toString());
			od.setVisId(rd.get("visId").toString());
			od.setNumber(rd.get("number").toString());
			od.setOrderType(rd.get("order_type").toString());
			// od.setCreateTime(rd.get("create_time"));
			// od.setRepairTime(rd.get("repair_time"));
			od.setApplianceBrand(rd.get("appliance_brand").toString());
			od.setApplianceCategory(rd.get("appliance_category").toString());
			od.setApplianceModel(rd.get("appliance_model").toString());
			od.setApplianceBarcode(rd.get("appliance_barcode").toString());
			// od.setApplianceBuyTime(rd.get("appliance_buy_time"));
			// od.setApplianceNum(rd.get("appliance_num"));
			// od.setApplianceMachineCode(rd.get("appliance_machine_code"));
			od.setCustomerName(rd.get("customer_name").toString());
			od.setCustomerProvince(rd.get("customer_province").toString());
			od.setCustomerCity(rd.get("customer_city").toString());
			od.setCustomerArea(rd.get("customer_area").toString());
			od.setCustomerAddress(rd.get("customer_address").toString());
			od.setCustomerMobile(rd.get("customer_mobile").toString());
			od.setCustomerTelephone(rd.get("customer_telephone").toString());
			od.setCustomerTelephone2(rd.get("customer_telephone2").toString());
			// od.setPromiseTime(rd.get("promise_time"));
			od.setPromiseLimit(rd.get("promise_limit").toString());
			od.setCustomerFeedback(rd.get("customer_feedback").toString());
			od.setRemarks(rd.get("remarks").toString());
			od.setOrigin(rd.get("origin").toString());
			od.setServiceType(rd.get("service_type").toString());
			od.setSiteName(rd.get("site_name").toString());
			od.setSiteId(rd.get("site_id").toString());
			// od.setEmployeId(rd.get("employe_id").toString());
			od.setEmployeName(String.valueOf(rd.get("employe_name")));
			od.setMessengerName(String.valueOf(rd.get("messenger_name").toString()));
			od.setVisistTime(rd.get("visistTime").toString());
			od.setCreateName(rd.get("create_name").toString());
			lists.add(od);
		}
		return lists;
	}

	public List<OrderReturnVisit> sortByOrderReturnVisit(List<OrderReturnVisit> lists, List<Map<String, Object>> sets, List<Map<String, Object>> detas) {
		for (OrderReturnVisit ods : lists) {
			List<Map<String, Object>> listsa = Lists.newArrayList();
			String orderId = ods.getId();
			for (Map<String, Object> set : sets) {
				for (Map<String, Object> rd : detas) {
					if (set.get("id").equals(rd.get("visit_setting_id")) && orderId.equals(rd.get("order_id"))) {
						listsa.add(rd);
					}
				}
			}
			ods.setDetails(listsa);

		}
		return lists;
	}

	public String getLatestEmployesByMobile(String siteId, String mobile) {
		String empNames = "";
		String employes = "";
		Record rd = Db.findFirst(
				"SELECT a.* FROM crm_order a WHERE a.status IN ('2','3','4','5') AND a.site_id=? AND a.customer_mobile=? AND UNIX_TIMESTAMP(a.repair_time) > (UNIX_TIMESTAMP(NOW()) - 24*60*60*30) group by a.repair_time desc limit 1",
				siteId, mobile);
		if (rd != null) {
			String emps = rd.getStr("employe_name");
			if (StringUtils.isNotBlank("emps")) {
				if (StringUtils.isNotBlank("employes")) {
					employes = employes + "," + emps;
				} else {
					employes = emps;
				}
			}
		}
		if (StringUtils.isNotBlank(employes)) {
			String[] empArray = employes.split(",");
			Set<String> set = new HashSet<>();
			for (int i = 0; i < empArray.length; i++) {
				set.add(empArray[i]);
			}
			empArray = (String[]) set.toArray(new String[set.size()]);
			for (String str : empArray) {
				if (StringUtils.isNotBlank(str)) {
					if (StringUtils.isNotBlank(empNames)) {
						empNames = empNames + "," + str;
					} else {
						empNames = str;
					}
				}
			}
		}
		return empNames;
	}

	/* 短信通知（短信模板） 已使用 系统短信模板-单个发送 */
	@Transactional(rollbackFor = Exception.class)
	public String fwzSendmsgModelFwzOne(String temId, String sign1, String content1, String extno, String orderId, String customerMobile, String siteId, String yxId,
			String oneHref, String endMode, String definedContentTz, String target) {
		String sign = "【" + sign1 + "】";
		String content = content1.trim();
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		Integer nums = getMsgNumbers(content, sign, "");
		String[] strg = customerMobile.split(",");
		Integer mks = nums * strg.length;
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		if (mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		try {
			int h = 0;
			Integer successNum = 0;
			List<SendedSms> ls = new ArrayList<>();
			String[] yxIds = yxId.split(",");
			Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
			for (String st : customerMobile.split(",")) {
				SendedSms sm = new SendedSms();
				Map<String, String> msg2 = new HashMap<>();

				String result1 = SfSmsUtils.sendMsg(st, definedContentTz, sign);
				Integer sNumn = 0;
				String[] rstn = result1.split(",");

				if (StringUtils.isNotBlank(result1)) {// 号码无效，未发成功
					sNumn = nums;// 成功发送的短信条数
					successNum = successNum + sNumn;
					sm.setSendid(result1);
					sm.setStatus("1");
					sm.setReceiveTime(new Date());
				} else {
					sm.setSendid("0");
					sm.setStatus("0");
				}
				/*
				 * if (st.length() == 11 && st.subSequence(0, 1).equals("1")) {//
				 * 电话的长度为11，并且首位为“1”有效，表示发送成功
				 *
				 * } else {
				 *
				 * }
				 */
				sm.setSendTime(new Date());
				sm.setCreateTime(new Date());
				sm.setCreateBy(name);

				sm.setExtno(extno);
				sm.setCreateType(user.getUserType());
				sm.setSiteId(siteId);
				sm.setSiteMobile(r.getStr("mobile"));
				sm.setSign(sign1);
				sm.setSmsNum(nums);
				sm.setContent(definedContentTz);
				sm.setMobile(st);
				sm.setOrderId(yxIds[h]);
				if ("2".equals(target)) {// 400工单
					Record rdRecord = Db.use(DbKey.DB_ORDER_400).findFirst("select a.* from crm_order_400 a where a.id=? ", yxIds[h]);
					sm.setOrderNumber(rdRecord != null ? rdRecord.getStr("number") : "");
				} else {// erp工单
					sm.setOrderNumber(orderDao.get(yxIds[h]).getNumber());
				}

				h++;
				sm.setTemplateId(temId);
				// sm.setStatus("1");
				if (extno.equals("6")) {// 上门前
					sm.setType("6");
				} else if (extno.equals("4")) {// 无人接听
					sm.setType("2");
				} else if (extno.equals("3")) {// 改约
					sm.setType("3");
				} else if (extno.equals("2")) {// 缺件
					sm.setType("4");
				} else if (extno.equals("5")) {
					sm.setType("5");
				} else if (extno.equals("11")) {
					sm.setType("7");
				} else if (extno.equals("7")) {
					sm.setType("8");
				} else if (extno.equals("9")) {
					sm.setType("9");
				} else if (extno.equals("8")) {
					sm.setType("0");// 待派工
				}
				ls.add(sm);
				// sendedSmsDao.save(sm);
			}
			sendedSmsDao.save(ls);
			if (successNum > 0) {
				// Db.update("update crm_site a set
				// a.sms_available_amount=(a.sms_available_amount-" + successNum + ") where
				// a.status='0' and a.id='" + siteId + "'");// 更新服务商短信数量
				smsService.consumeSms(successNum, siteId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public Integer dealCheckNumEnough(String[] yxIds, String customerMobile, String modelContent, String phone, String sign) {
		int h = 0;
		Integer nums = 0;
		for (String st : customerMobile.split(",")) {
			Order order = orderDao.get(yxIds[h]);// 获取每条order表信息;
			Integer lgth = modelContent.split("@").length - 1;
			for (int i = 0; i < lgth; i++) {
				modelContent.indexOf("@", i);
				String str = modelContent.substring(modelContent.indexOf("@", i), modelContent.indexOf("@", i) + 2);
				String cont = returnParams(order, str, phone) != null ? returnParams(order, str, phone) : "";
				modelContent = modelContent.substring(0, modelContent.indexOf("@", i)) + cont + modelContent.substring(modelContent.indexOf("@", i) + 2, modelContent.length());
			}
			Integer num = getMsgNumbers(modelContent, sign, "");
			nums = nums + num;
			h++;
		}
		return nums;
	}

	/* 短信通知（短信自定义模板） */// temId,sign,content,extno,number,customerMobile,siteId,yxId
	@Transactional(rollbackFor = Exception.class)
	public String fwzSendmsgModelFwzDefined(String temId, String sign1, String content1, String extno, String numbers, String customerMobile, String siteId, String yxId,
			String markType) {
		String sign = "【" + sign1 + "】";
		String content = content1.trim();
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		Integer nums = getMsgNumbers(content, sign, "");
		String[] strg = customerMobile.split(",");
		Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
		try {
			int h = 0;
			Integer successNum = 0;
			List<SendedSms> ls = new ArrayList<>();
			String[] yxIds = yxId.split(",");
			Record rd = Db.findFirst("select a.* from crm_site_sms_template a where a.id=?", temId);
			String modelContent = rd.getStr("content");// 此处获取的是短信模板的内容
			Integer needNums = dealCheckNumEnough(yxIds, customerMobile, modelContent, r.getStr("sms_phone"), sign);
			if (needNums > r.getInt("sms_available_amount")) {
				return "noMessage";
			}
			for (String st : customerMobile.split(",")) {
				Order od = orderDao.get(yxIds[h]);// 获取每条order表信息;
				String contentn = returnContent(modelContent, od, r.getStr("sms_phone"));// 事实上要发送给用户的内容
				String result1 = SfSmsUtils.sendMsg(st, contentn, sign);
				Integer sNumn = 0;
				Integer numn = getMsgNumbers(contentn, sign, "");
				SendedSms sm = new SendedSms();
				if (StringUtils.isNotBlank(result1)) {// 已发送
					sNumn = numn;// 成功发送的短信条数
					successNum = successNum + sNumn;
					sm.setSendid(result1);
					sm.setStatus("1");
					sm.setReceiveTime(new Date());
				} else {
					sm.setSendid("0");
					sm.setStatus("0");
				}

				/*
				 * if (st.length() == 11 && st.subSequence(0, 1).equals("1")) {//
				 * 电话的长度为11，并且首位为“1”有效，表示发送成功
				 *
				 * } else {
				 *
				 * }
				 */
				sm.setSendTime(new Date());
				sm.setCreateTime(new Date());
				sm.setCreateBy(name);

				sm.setExtno(extno);
				sm.setCreateType(user.getUserType());
				sm.setSiteId(siteId);
				sm.setSiteMobile(r.getStr("mobile"));
				sm.setSign(sign);
				sm.setSmsNum(numn);
				sm.setContent(contentn);
				sm.setMobile(st);
				sm.setOrderId(yxIds[h]);
				sm.setOrderNumber(od.getNumber());
				h++;
				sm.setTemplateId(temId);
				if (extno.equals("6")) {// 上门前
					sm.setType("6");
				} else if (extno.equals("4")) {// 无人接听
					sm.setType("2");
				} else if (extno.equals("3")) {// 改约
					sm.setType("3");
				} else if (extno.equals("2")) {// 缺件
					sm.setType("4");
				} else if (extno.equals("5")) {
					sm.setType("5");
				} else if (extno.equals("11")) {
					sm.setType("7");
				} else if (extno.equals("7")) {
					sm.setType("8");
				} else if (extno.equals("9")) {
					sm.setType("9");
				} else if (extno.equals("8")) {
					sm.setType("0");// 待派工
				} else if (extno.equals("0")) {
					sm.setType("1");// 自定义短信模板
				}
				ls.add(sm);
			}
			sendedSmsDao.save(ls);
			if (successNum > 0) {
				smsService.consumeSms(successNum, siteId);
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	/* 批量发送短信 */
	@Transactional(rollbackFor = Exception.class)
	public String getSendMsg400(String content, String sign1, String mobile, String siteId, String number) {
		String sign = "【" + sign1 + "】";
		String[] strg = mobile.split(",");
		Integer nums = getMsgNumbers(content, sign, "");// 短信的字数，看是多少条短信
		Integer mks = nums * strg.length;
		Record rdNum = Db.findFirst("select * from crm_site a where a.id=?", siteId);
		if (mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();

		List<SendedSms> list = Lists.newArrayList();
		String result = SfSmsUtils.sendMsg(mobile, content, sign);
		Integer successMsgNums = 0;
		String[] str1 = mobile.split(",");
		String[] str2 = number.split(",");
		int i = 0;
		for (String st : str1) {
			SendedSms sm = new SendedSms();
			if (StringUtils.isNotBlank(result)) {
				successMsgNums = successMsgNums + nums;
				sm.setStatus("1");
				sm.setReceiveTime(new Date());
				sm.setSendid(result);
			} else {
				sm.setStatus("0");
			}
			sm.setSendTime(new Date());
			sm.setType("1");
			sm.setCreateTime(new Date());
			sm.setCreateBy(name);

			sm.setExtno("99");
			sm.setSmsNum(nums);
			sm.setCreateType(user.getUserType());
			sm.setSiteId(siteId);
			Record r = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
			sm.setSiteMobile(r.getStr("mobile"));
			sm.setSign(sign);
			sm.setContent(content);
			sm.setMobile(st);
			if (i == 0) {
				Record rd = Db.use(DbKey.DB_ORDER_400).findFirst("select * from crm_order_400 a where a.number='" + str2[0] + "' and a.site_id='" + siteId + "'");
				sm.setOrderId(rd.getStr("id"));
				sm.setOrderNumber(str2[0]);
				i++;
			} else {
				Record rd = Db.use(DbKey.DB_ORDER_400).findFirst("select * from crm_order_400 a where a.number='" + str2[i] + "' and a.site_id='" + siteId + "'");
				sm.setOrderId(rd.getStr("id"));
				sm.setOrderNumber(str2[i]);
				i++;
			}
			list.add(sm);
		}
		sendedSmsDao.save(list);
		if (successMsgNums > 0) {
			smsService.consumeSms(successMsgNums, siteId);
		}
		return "ok";
	}

	public Date getdisTime(String siteId, String orderId) {
		Record rd = Db.findFirst("SELECT dispatch_time FROM crm_order_dispatch WHERE site_id=? AND STATUS='5' AND order_id=?", siteId, orderId);
		return rd != null ? rd.getDate("dispatch_time") : null;
	}

	public void onOrderCountChanged(String siteId, String type) {
		orderDao.onOrderCountChanged(siteId, type);
	}

	public long getTotalOrderCount(String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		String userId = UserUtils.getUser().getId();
		// get from cache
		Long count = getOrderCountFromCache(siteId, userId);
		if (count != null) {
			AtomicLong aLong = OrderController.fromMap.get("count-cache");
			aLong.getAndIncrement();
			if (aLong.get() > 1000000) {
				aLong.set(0);
			}
			return count;
		}

		long ret = orderDao.getWholeOrderCount(siteId, status, map, cateList, brandList);
		sfCacheService.hset(String.format(SfCacheKey.siteUserOrderCountMap, siteId), userId, Long.toString(ret));
		return ret;
	}

	private Long getOrderCountFromCache(String siteId, String userId) {
		String data = sfCacheService.hget(String.format(SfCacheKey.siteUserOrderCountMap, siteId), userId);
		if (StringUtil.isNotBlank(data)) {
			return Long.parseLong(data);
		}

		return null;
	}

	public List<Record> getDownOrderFeedback(String orderId, String siteId) {
		return orderDao.getOrderFeedbackRecords(orderId, siteId);
	}

	public Record findOrderById(String orderId, String siteId) {
		return orderDao.findOrderByIdIfHistory(orderId, siteId);
	}

	public Record findOrderByNumberIfHistory(String number, String siteId) {
		return orderDao.findOrderByNumberIfHistory(number, siteId);
	}

	public Order getOrderByNumber(String number, String siteId) {
		return orderDao.getOrderByNumber(number, siteId);
	}

	public Order getrecord(Record rd) {
		return orderDao.getrecord(rd);
	}
}
