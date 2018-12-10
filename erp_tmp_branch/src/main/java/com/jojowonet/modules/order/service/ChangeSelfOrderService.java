package com.jojowonet.modules.order.service;

import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.fitting.service.FittingUsedRecordService;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.order.dao.CrmOrder400Dao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.dao.OrderDispatchDao;
import com.jojowonet.modules.order.dao.OrderDispatchEmployeRelDao;
import com.jojowonet.modules.order.dao.OrderFeedbackDao;
import com.jojowonet.modules.order.entity.CrmOrder400;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderDispatch;
import com.jojowonet.modules.order.entity.OrderDispatchEmployeRel;
import com.jojowonet.modules.order.entity.OrderFeedback;
import com.jojowonet.modules.order.form.vo.CrmOrder400Vo;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
import com.jojowonet.modules.order.utils.OrderNo;
import com.jojowonet.modules.order.utils.RedisKeyConstants;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SimpleOrderNo;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.WebPageFunUtils;
import com.jojowonet.modules.sys.config.SfCacheService;
import com.jojowonet.modules.sys.db.DbKey;
import com.jojowonet.modules.sys.util.NetworkException;
import com.jojowonet.modules.sys.util.http.Order400EzTemplate;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class ChangeSelfOrderService extends BaseService {

	private static final Logger logger = Logger.getLogger(ChangeSelfOrderService.class);

	@Autowired
	private OrderDao orderDao;
	@Autowired
	private NonServicemanDao nonDao;
	@Autowired
	private OrderDispatchDao orderDispatchDao;
	@Autowired
	private OrderFeedbackDao orderFeedbackDao;
	@Autowired
	private OrderDispatchEmployeRelDao orderDispatchEmployeRelDao;
	@Autowired
	private SiteMsgService siteMsgService;
	@Autowired
	private FittingUsedRecordService fittingUsedRecordService;
	@Autowired
	private OrderFittingService orderFittingService;
	@Autowired
	private SfCacheService sfCacheService;
	@Autowired
	private CrmOrder400Dao crmOrder400Dao;
	@Autowired
	private Order400EzTemplate ezTemplate;

	/* 获取system权限下维护的厂家 */
	public List<Record> gerOrderBrandList(String siteId) {
		return Db.find("SELECT a.* FROM crm_vender_info a WHERE a.status='0' ");
	}

	/**
	 * 判断是否显示某厂家的工单
	 * 
	 * @param siteId
	 */
	public List<Record> selectFactory(String siteId) {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.name FROM crm_site_vender_account a ");
		sb.append(" LEFT JOIN crm_vender_info b ON a.vender_id=b.id AND b.status='0' ");
		sb.append(" WHERE a.status='0' AND a.site_id='" + siteId + "' ");
		return Db.find(sb.toString());
	}

	public Page<Record> getFourHandurandOrderGrid(String siteId, Page<Record> page, Map<String, Object> map, String orderType) {
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", siteId);
		params.put("orderType", orderType);
		params.putAll(map);
		params.put("pageNo", page.getPageNo());
		params.put("pageSize", page.getPageSize());
		Result<Page<CrmOrder400Vo>> resp = ezTemplate.postForm("/order400/list", params, new ParameterizedTypeReference<Result<Page<CrmOrder400Vo>>>() {
		});

		if ("200".equals(resp.getCode())) {
			Page<CrmOrder400Vo> respPage = resp.getData();
			List<CrmOrder400Vo> list = respPage.getList();

			List<Record> recList = new ArrayList<>();
			Map<String, String> flagIdNameMap = new HashMap<>();

			List<String> flagIdList = new ArrayList<>();
			for (CrmOrder400Vo v : list) {
				Record record = v.asRecord();
				if (StringUtil.isNotBlank(v.getFlag())) {
					if (StringUtil.isNotBlank(v.getFlag())) {
						flagIdList.add(v.getFlag());
					}
				}
				recList.add(record);
			}
			page.setCount(respPage.getCount());
			page.setList(recList);

			if (flagIdList.size() > 0) {
				SqlKit kit = new SqlKit().append("select s.id,s.name from crm_order_mark_settings as s where s.id in(" + CrmUtils.joinInSql(flagIdList) + ")");
				List<Record> marks = Db.find(kit.toString());
				for (Record m : marks) {
					flagIdNameMap.put(m.getStr("id"), m.getStr("name"));
				}
			}

			for (Record v : recList) {
				String flagId = v.getStr("flag");
				if (StringUtil.isNotBlank(flagId)) {
					v.set("flag", flagIdNameMap.get(flagId));
				}
			}

			return page;
		}
		logger.info("get order list failed");
		return null;
	}

	/* 400工单历史数据 */
	public Page<Record> old400Order(String siteId, Page<Record> page, Map<String, Object> map) {
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", siteId);
		params.putAll(map);
		params.put("pageNo", page.getPageNo());
		params.put("pageSize", page.getPageSize());
		Result<Page<CrmOrder400Vo>> resp = ezTemplate.postForm("/order400/listForOld", params, new ParameterizedTypeReference<Result<Page<CrmOrder400Vo>>>() {
		});

		if ("200".equals(resp.getCode())) {
			Page<CrmOrder400Vo> respPage = resp.getData();
			List<CrmOrder400Vo> list = respPage.getList();

			List<Record> recList = new ArrayList<>();
			Map<String, Record> mapper = new HashMap<>();
			List<String> markIdList = new ArrayList<>();
			for (CrmOrder400Vo v : list) {
				Record record = v.asRecord();
				if (StringUtil.isNotBlank(v.getFlag())) {
					markIdList.add(v.getFlag());
					mapper.put(v.getFlag(), record);
				}
				recList.add(record);
			}
			page.setCount(respPage.getCount());
			page.setList(recList);

			if (markIdList.size() > 0) {
				SqlKit kit = new SqlKit().append("select s.name from crm_order_mark_settings as s where s.id = ? ");
				for (Record m : recList) {
					Record marks = Db.findFirst(kit.toString(), m.get("flag"));
					if (marks != null) {
						m.set("flag", marks.getStr("name"));
					} else {
						m.set("flag", "");
					}
				}
			}

			return page;
		}

		return null;
	}

	// 表头排序
	private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
		String sort = null;
		String dir = null;
		if (map.get("sidx") != null) {
			if (StringUtils.isNotBlank(map.get("sidx").toString())) {
				sort = map.get("sidx").toString();
			}
		}
		if (map.get("sord") != null) {
			if (StringUtils.isNotBlank(map.get("sord").toString())) {
				dir = map.get("sord").toString();
			}
		}

		String result = defaultOrderBy;
		if (map.get("sidx") != null) {
			result = (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by `" + sort + "` " + dir) : defaultOrderBy;
		}
		return result;
	}

	public List<Record> getList(String siteId, Page<Record> page, Map<String, Object> map, String orderType) {
		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT o.* FROM crm_order_400 o WHERE o.site_id = '" + siteId + "' and order_type='" + orderType + "' ");
		sb.append(getOrderCondition(map, orderType));
		sb.append(" ORDER BY o.create_time desc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.use(DbKey.DB_ORDER_400).find(sb.toString());
	}

	/**
	 * 导出400历史工单
	 * 
	 * @param siteId
	 * @param page
	 * @param map
	 * @return
	 */
	public List<Record> getListForOld400(String siteId, Page<Record> page, Map<String, Object> map) {
		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT o.* FROM crm_order_400_2017 o WHERE o.site_id = '" + siteId + "' ");
		sb.append(getOrderCondition(map, ""));
		sb.append(" ORDER BY o.create_time desc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		List<Record> list = Db.use(DbKey.DB_ORDER_400).find(sb.toString());
		return list;
	}

	public String getOrderCondition(Map<String, Object> map, String orderType) {
		StringBuffer sf = new StringBuffer();
		// 小程序中使用
		if (StringUtil.checkParamsValid(map.get("ordernumberMobile"))) {
			sf.append(" and (o.customer_mobile like '%" + (map.get("ordernumberMobile")) + "%' or o.customer_telephone like '%" + map.get("ordernumberMobile")
					+ "%' or o.customer_telephone2 like '%" + map.get("ordernumberMobile") + "%' or o.number like '%" + (map.get("ordernumberMobile")) + "%') ");
		}

		if (StringUtil.checkParamsValid((CharSequence) map.get("number"))) {// 工单编号
			sf.append(" and o.number like '%" + map.get("number").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("status"))) {// 工单状态
			String statuss[] = map.get("status").toString().split(",");
			if ("9".equals(orderType) || "f".equals(orderType)) {// 奥克斯、美菱工单状态是输入框查询
				sf.append(" and o.status like '%" + map.get("status") + "%'");
			} else {
				sf.append(" and o.status in ( ");
				for (int i = 0; i < statuss.length; i++) {
					if (i < statuss.length - 1) {
						sf.append(" '" + statuss[i] + "', ");
					} else {
						sf.append(" '" + statuss[i] + "' ");
					}
				}
				sf.append(" ) ");
			}
		}

		if (StringUtils.isNotBlank(orderType)) {
			if (StringUtil.checkParamsValid((CharSequence) map.get("origin"))) {
				if ("2".equals(orderType)) {// 2.美的厂家系统
					String[] origins = map.get("origin").toString().trim().split(",");
					List<String> list = Arrays.asList(origins);
					List arrList = new ArrayList(list);
					if (list.contains("用户自助微信")) {
						arrList.add("用户自助-微信");
					}
					if (list.contains("用户自助官网")) {
						arrList.add("用户自助-官网");
					}
					String[] originsArray = new String[arrList.size()];
					arrList.toArray(originsArray);
					sf.append(" and o.origin  in (" + StringUtil.joinInSql(originsArray) + ") ");
				} else {
					sf.append(" and o.origin  like '%" + map.get("origin").toString().trim() + "%' ");
				}
			}
		}

		if (StringUtil.checkParamsValid((CharSequence) map.get("warningType"))) {
			if (StringUtils.isNotBlank(orderType)) {
				if ("2".equals(orderType)) {// 2.美的厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("2".equals(map.get("warningType"))) {// 待接收
						sf.append(" and o.`status` in('待派单','待接收','一级网点改派申请','抢单中') ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('待派单','已派工','已接单','待接收','一级网点改派申请','抢单中','已预约') ");
					} else if ("4".equals(map.get("warningType"))) {// 超20h预警
						sf.append(
								" and o.`status` IN ('待派单','已派工','已接单','待接收','一级网点改派申请','抢单中','已预约') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超24h预警
						sf.append(" and o.`status` IN ('待派单','已派工','已接单','待接收','一级网点改派申请','抢单中','已预约') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("6".equals(map.get("warningType"))) {// 超45分钟未预约
						sf.append(
								" and (ISNULL(o.promise_time) or o.promise_time='') and o.`status` IN ('待派单','待接收','一级网点改派申请','抢单中','已预约') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 45 minute) ");
					} else if ("7".equals(map.get("warningType"))) {// 预约倒计时2H
						sf.append(
								" and o.promise_time IS NOT NULL AND o.promise_time <> '' and o.`status` IN ('待派单','待接收','一级网点改派申请','抢单中','已预约') AND o.promise_time >= DATE_SUB(NOW(), INTERVAL 2 HOUR) ");
					}

				} else if ("3".equals(orderType)) { // 3.惠而浦厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('已派至网点') ");
					} else if ("4".equals(map.get("warningType"))) {// 超20h预警
						sf.append(" and o.`status` IN ('已派至网点') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超24h预警
						sf.append(" and o.`status` IN ('已派至网点') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					}
				} else if ("4".equals(orderType)) {// 4.海信厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` in('待派工','已派工','已接收','已联系用户','已指派工程师','已反馈') ");
					} else if ("4".equals(map.get("warningType"))) {// 超20h预警
						sf.append(
								" and o.`status` IN ('待派工','已派工','已接收','已联系用户','已指派工程师','已反馈') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超24h预警
						sf.append(" and o.`status` IN ('待派工','已派工','已接收','已联系用户','已指派工程师','已反馈') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					}
				} else if ("5".equals(orderType)) {// 5.海尔厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('服务中','已派单','抢单中','已到商','已到兵','已响应','已预约','处理中','未完工') ");
					} else if ("4".equals(map.get("warningType"))) {// 超48h预警
						sf.append(
								" and o.`status` IN ('服务中','已派单','抢单中','已到商','已到兵','已响应','已预约','处理中','未完工') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 48 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 72 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超72h预警
						sf.append(" and o.`status` IN ('服务中','已派单','抢单中','已到商','已到兵','已响应','已预约','处理中','未完工') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 72 HOUR) ");
					}
				} else if ("9".equals(orderType)) {// 6.奥克斯厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('服务中','已派单') ");
					} else if ("4".equals(map.get("warningType"))) {// 超48h预警
						sf.append(
								" and o.`status` IN ('服务中','已派单') AND AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超72h预警
						sf.append(" and o.`status` IN ('服务中','已派单') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					}
				} else if ("8".equals(orderType)) {// 7.格力厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('保存','待网点派工','待服务人员处理','待件','拉修中','用户改约','延误','服务人员接收','服务人员拒绝','用户反馈','服务人员报完工') ");
					} else if ("4".equals(map.get("warningType"))) {// 超48h预警
						sf.append(
								" and o.`status` IN ('保存','待网点派工','待服务人员处理','待件','拉修中','用户改约','延误','服务人员接收','服务人员拒绝','用户反馈','服务人员报完工') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超72h预警
						sf.append(
								" and o.`status` IN ('保存','待网点派工','待服务人员处理','待件','拉修中','用户改约','延误','服务人员接收','服务人员拒绝','用户反馈','服务人员报完工') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					}
				} else if ("f".equals(orderType)) {// 7.美菱厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('保存','待网点派工','待服务人员处理','待件','拉修中','用户改约','延误','服务人员接收','服务人员拒绝','用户反馈','服务人员报完工') ");
					} else if ("4".equals(map.get("warningType"))) {// 超48h预警
						sf.append(
								" and o.`status` IN ('保存','待网点派工','待服务人员处理','待件','拉修中','用户改约','延误','服务人员接收','服务人员拒绝','用户反馈','服务人员报完工') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超72h预警
						sf.append(
								" and o.`status` IN ('保存','待网点派工','待服务人员处理','待件','拉修中','用户改约','延误','服务人员接收','服务人员拒绝','用户反馈','服务人员报完工') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					}
				} else if ("g".equals(orderType)) {// 7.美菱厂家系统
					if ("1".equals(map.get("warningType"))) {// 今日工单总数
						sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
					} else if ("3".equals(map.get("warningType"))) {// 未完工
						sf.append(" and o.`status` IN ('待接单','待回单','已回过程单','未关闭') ");
					} else if ("4".equals(map.get("warningType"))) {// 超48h预警
						sf.append(
								" and o.`status` IN ('待接单','待回单','已回过程单','未关闭') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					} else if ("5".equals(map.get("warningType"))) {// 超72h预警
						sf.append(" and o.`status` IN ('待接单','待回单','已回过程单','未关闭') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
					}
				}
			}
		}

		if (StringUtil.checkParamsValid((CharSequence) map.get("applianceB"))) {// 家电品牌
			sf.append(" and o.appliance_brand like '%" + map.get("applianceB").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("applianceCategory"))) {// 家电类型
			sf.append(" and o.appliance_category like '%" + map.get("applianceCategory").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("applianceModel"))) {// 家电型号employeName
			sf.append(" and o.appliance_model like '%" + map.get("applianceModel").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("customerName"))) {// 用户姓名
			sf.append(" and o.customer_name like '%" + map.get("customerName").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("customerMobile"))) {// 联系方式
			Object mobile = map.get("customerMobile");
			if (StringUtil.isMobile(mobile)) {
				sf.append(" and (o.customer_mobile = '" + map.get("customerMobile").toString().trim() + "' or o.customer_telephone = '"
						+ map.get("customerMobile").toString().trim() + "' or o.customer_telephone2 = '" + map.get("customerMobile").toString().trim() + "') ");
			} else {
				sf.append(" and (o.customer_mobile like '%" + map.get("customerMobile").toString().trim() + "%' or o.customer_telephone like '%"
						+ map.get("customerMobile").toString().trim() + "%' or o.customer_telephone2 like '%" + map.get("customerMobile").toString().trim() + "%') ");
			}
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("customerAddress"))) {// 详细地址
			sf.append(" and o.customer_address like '%" + map.get("customerAddress").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("employeName"))) {// 服务工程师
			sf.append(" and (o.employe1 like '%" + map.get("employeName").toString().trim() + "%' or o.employe2 like '%" + map.get("employeName").toString().trim()
					+ "%' or o.employe3 like '%" + map.get("employeName").toString().trim() + "%') ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("isConvert"))) {// 转自接
			sf.append(" and o.is_convert ='" + map.get("isConvert") + "' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("serviceType"))) {// 服务类型
			sf.append(" and (o.service_type like '%" + map.get("serviceType").toString().trim() + "%' or o.c_service_type like '%" + map.get("serviceType").toString().trim()
					+ "%') ");
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMin"))) {// 报修时间
			if (((String) map.get("repairTimeMin")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			} else {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMax"))) {
			if (((String) map.get("repairTimeMax")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			} else {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMin"))) {// 完成时间
			sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMax"))) {
			sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + "'  ");
		}
		if (StringUtil.checkParamsValid(map.get("promiseTimeMin"))) {// 预约时间
			sf.append(" and o.promise_time >= '" + (map.get("promiseTimeMin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("promiseTimeMax"))) {
			sf.append(" and o.promise_time <= '" + (map.get("promiseTimeMax")) + "'  ");
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMin"))) {// 派工时间
			sf.append(" and o.dispatch_time >= '" + (map.get("dispatchTimeMin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMax"))) {
			sf.append(" and o.dispatch_time <= '" + (map.get("dispatchTimeMax")) + "'  ");
		}
		if (StringUtil.checkParamsValid(map.get("signType"))) {
			String str[] = map.get("signType").toString().split(",");
			sf.append(" and o.flag in (" + StringUtil.joinInSql(str) + ")");
		}
		return sf.toString();
	}

	public List<Record> empList(String siteId) {
		return Db.find("select * from crm_employe a where a.status='0' and a.site_id='" + siteId + "'");
	}

	public String confirm(String siteId, String employes) {
		String[] employeArray = employes.split(",");
		String emps = "";
		for (String st : employeArray) {
			if ("".equals(emps)) {
				emps = "'" + st + "'";
			} else {
				emps = emps + ",'" + st + "'";
			}
		}
		Long count = Db.queryLong("select count(*) from crm_employe a where a.site_id=? and a.status='0' and a.name in(" + emps + ") ", siteId);
		if (count > 0) {
			List<Record> list = Db.find("select a.* from crm_employe a where a.site_id=? and a.status='0' and a.name in(" + emps + ")", siteId);
			String employesExist = "";
			for (Record rd : list) {
				if ("".equals(employesExist)) {
					employesExist = rd.getStr("name");
				} else {
					employesExist = employesExist + "," + rd.getStr("name");
				}
			}
			return employesExist;
		}
		return "noEmployes";
	}

	/**
	 * 创建反馈内容。
	 * 
	 * @param siteId
	 *            网点id
	 * @param fbName
	 *            反馈人姓名
	 * @param fbTime
	 *            反馈时间
	 * @param fbContent
	 *            反馈内容
	 * @param fbResult
	 *            反馈结果
	 * @param orderId
	 *            工单id
	 * @param dispId
	 *            派工单id
	 * @param remark
	 *            备注
	 */
	private void createEmpFeedback(String siteId, String fbName, Date fbTime, String fbContent, String fbResult, String orderId, String dispId, String remark) {
		OrderFeedback orderFeedback = newEmpFeedback(siteId, fbName, fbTime, fbContent, fbResult, orderId, dispId, remark);
		if (orderFeedback != null) {
			orderFeedbackDao.save(orderFeedback);
		}
	}

	private OrderFeedback newEmpFeedback(String siteId, String fbName, Date fbTime, String fbContent, String fbResult, String orderId, String dispId, String remark) {
		if (StringUtil.isBlank(fbContent)) {
			return null;
		}

		if (fbTime == null) {
			fbTime = new Date();
		}
		OrderFeedback orderFeedback = new OrderFeedback();
		if (StringUtils.isNotBlank(fbName)) {
			Record rd3 = Db.findFirst("select * from crm_employe a where a.status='0' and a.site_id=? and a.name=?", siteId, fbName);
			if (rd3 != null) {
				orderFeedback.setFeedbackId(rd3.getStr("id"));
			}
		} else {
			fbName = "400反馈";
		}
		orderFeedback.setDispatchId(dispId);
		orderFeedback.setOrderId(orderId);
		orderFeedback.setFeedbackName(fbName);
		orderFeedback.setSiteId(siteId);
		orderFeedback.setFeedbackType("1");
		orderFeedback.setUserType("4");
		if (StringUtils.isNotBlank(remark)) {
			orderFeedback.setRemarks(remark);// 备注
		}
		orderFeedback.setFeedbackTime(fbTime);
		if (StringUtils.isNotBlank(fbResult)) {// 反馈结果
			orderFeedback.setFeedbackResult(fbResult);
		}
		orderFeedback.setFeedback(fbContent);
		return orderFeedback;
	}

	private List<String> getRecordedOrderNo(List<String> orderNos, String siteId) {
		List<String> ret = new ArrayList<>();
		String[] args = new String[orderNos.size()];
		int i = 0, j = 0;
		for (String no : orderNos) {
			String key = String.format(RedisKeyConstants.RECORDED_FACTORY_NO, no, siteId);
			args[i++] = key;
		}
		List<String> values = sfCacheService.mget(args);
		for (String val : values) {
			if ("1".equals(val)) {
				ret.add(orderNos.get(j));
			}
			j++;
		}
		return ret;
	}

	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> confirmOne(String siteId, String id400, String employes, String orderStatus, String userId) {
		Map<String, Object> mapRet = new HashMap<>();
		mapRet.put("ids", "");
		Record rd5;
		try {
			rd5 = oneDetail(id400);
		} catch (Exception ex) {
			logger.error("confirm one request failed");
			mapRet.put("code", "no");
			return mapRet;
		}

		if (rd5 == null) {
			mapRet.put("code", "orderNoExist");
			return mapRet;
		}
		String number = rd5.getStr("number");
		if ("1".equals(rd5.getStr("is_convert")) || orderDao.isOrderExists(number, siteId)) {
			mapRet.put("code", "alreadyZzj");
			return mapRet;
		}
		String confirmResult = "";
		if (StringUtils.isNotBlank(employes)) {
			confirmResult = confirm(siteId, employes);
			if (confirmResult.equals("noEmployes")) {
				mapRet.put("code", "noEmployes");
				return mapRet;
			}
			employes = confirmResult;
		}
		User user = null;
		if (StringUtils.isNotBlank(userId)) {
			user = UserUtils.getUserById(userId);
		} else {
			user = UserUtils.getUser();
		}
		Record rd = rd5;
		Record site = Db.findFirst("select * from crm_site a where a.id='" + siteId + "'");

		String name;
		String msgId = "";
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = CrmUtils.getSiteName();
			msgId = CrmUtils.getCurrentSiteId(user);
		} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
			msgId = no.getId();
		}
		Order order = new Order();
		order.setFlag(rd.getStr("flag"));
		order.setAuxiliaryCost(orderFittingService.sumFittingUseCostByOrder(siteId, number).setScale(2, RoundingMode.HALF_UP).doubleValue());
		order.setFlagAlertDate(rd.getDate("flag_alert_date"));
		order.setFlagDesc(rd.getStr("flag_desc"));
		order.setStatus(orderStatus);
		order.setOrderType(rd.getStr("order_type"));// 工单来源
		order.setCreateTime(new Date());// 创建时间
		order.setRepairTime(rd.getDate("repair_time") == null ? new Date() : rd.getDate("repair_time"));// 报修时间
		order.setCreateBy(UserUtils.getUser().getId());// 创建人
		order.setApplianceBrand(rd.getStr("appliance_brand"));// 家电品牌
		order.setApplianceCategory(rd.getStr("appliance_category"));// 家电品类
		order.setApplianceModel(rd.getStr("appliance_model"));// 家电型号
		order.setApplianceBarcode(rd.getStr("appliance_barcode"));// 家电内机条码
		order.setApplianceNum(1);// 家电数量
		order.setApplianceMachineCode(rd.getStr("appliance_machine_code"));// 家电外机条码
		order.setCustomerName(rd.getStr("customer_name"));// 用户姓名
		logger.info("编号为" + rd.getStr("number") + "的工单转自接前保修类型为：" + rd.getStr("warranty_type") + ";家电购机时间为：" + rd.getDate("appliance_buy_time") + " \n");
		order.setApplianceBuyTime(rd.getDate("appliance_buy_time"));// 家电购机时间
		if ("保内".equals(rd.getStr("warranty_type"))) {
			order.setWarrantyType("1");// 保修类型-保内
		} else if ("保外".equals(rd.getStr("warranty_type"))) {
			order.setWarrantyType("2");// 保修类型-保外
		}

		order.setMalfunctionCause(rd.getStr("malfunction_cause"));
		order.setMalfunctionCauseDescription(rd.getStr("malfunction_cause_description"));
		order.setMalfunctionType(rd.getStr("malfunction_type"));
		order.setMalfunctionDescription(rd.getStr("malfunction_description"));
		order.setMeasures(rd.getStr("measures"));
		order.setMeasuresDescription(rd.getStr("measures_description"));
		if (StringUtils.isNotBlank(rd.getStr("customer_address"))) {
			order.setCustomerAddress(rd.getStr("customer_address"));// 用户地址
		} else if (StringUtils.isNotBlank(rd.getStr("customer_address2"))) {
			order.setCustomerAddress(rd.getStr("customer_address2"));// 用户地址2
		}
		String mobiles = rd.getStr("customer_mobile");
		order.setCustomerMobile(StringUtils.isNotBlank(mobiles) ? mobiles.split(",")[0] : "");// 用户联系方式
		order.setCustomerTelephone(rd.getStr("customer_telephone"));// 用户电话
		order.setCustomerTelephone2(rd.getStr("customer_telephone2"));// 用户电话2
		if (rd.getDate("promise_time") != null) {
			order.setPromiseTime(rd.getDate("promise_time"));// 预约时间
		}
		if (StringUtils.isNotBlank(rd.getStr("promise_limit"))) {
			order.setPromiseLimit(rd.getStr("promise_limit"));// 时间要求
		}
		if (StringUtils.isNotBlank(rd.getStr("customer_feedback"))) {
			order.setCustomerFeedback(rd.getStr("customer_feedback"));// 用户反馈TradeNoUtils.genOrderNo("V")
		}
		if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
			order.setRemarks(rd.getStr("remarks"));// 备注
		}
		order.setOrigin(dealOrigin(rd.getStr("order_type")));// 信息来源
		if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
			order.setServiceType(rd.getStr("service_type"));// 服务类型
		} else {
			order.setServiceType(rd.getStr("c_service_type"));// 服务类型
		}
		if (StringUtils.isNotBlank(rd.getStr("service_mode"))) {
			order.setServiceMode(rd.getStr("service_mode"));// 服务类型
		} else {
			order.setServiceMode(rd.getStr("c_service_mode"));// 服务类型
		}
		if (StringUtils.isNotBlank(rd.getStr("level"))) {
			if (rd.getStr("level").equals("紧急")) {
				order.setLevel("1");// 信息等级
			} else {
				order.setLevel("2");// 信息等级
			}
		}
		order.setSiteId(siteId);// 网点Id
		order.setSiteName(site.getStr("name"));// 网点名称
		order.setMessengerId(msgId);// 信息员Id
		order.setMessengerName(name);// 信息员名称
		order.setNumber(rd.getStr("number"));
		order.setFactoryNumber(rd.getStr("number"));// 转自接过来的工单记录原400工单编号
		order.setRecordAccount("0");// 未录单
		String code = siteMsgService.ifOpenOrderSet(siteId);
		if ("200".equals(code)) {
			OrderNo odn = CrmUtils.genOrderNo(siteId);
			if (odn != null) {
				if ("200".equals(check400OrderNumber(rd.getStr("number"), siteId))) {
					order.setNumber(odn.getData());
					order.setSeq(odn.getSeq());
				}
			}
		}
		if (orderStatus.equals("1")) {// 待派工
			order.setLatestProcessTime(new Date());
			order.setLatestProcess(name + "转自接");// 最新过程信息
			order.setProcessDetail(processDetail(name, rd.getStr("process_detail")));// 过程信息
			orderDao.save(order);
		} else if (orderStatus.equals("2")) {// 服务中
			String[] employeArray = employes.split(",");
			/* crm_order工单表 */
			Target ta1 = new Target();
			ta1.setType(Target.DISPATCH_ORDER);// 派工
			ta1.setName(name);
			ta1.setContent(name + "派工至" + employes);
			if (rd.getDate("dispatch_time") != null) {
				ta1.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("dispatch_time")));
				// order.setPromiseTime(rd.getDate("dispatch_time"));
			} else {
				ta1.setTime(DateToStringUtils.DateToString());
			}
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, processDetail(name, rd.getStr("process_detail")));

			order.setProcessDetail(str1);// 过程信息
			order.setLatestProcess(name + "派工至" + employes);// 最新过程信息
			order.setEmployeId(employeIdAndName(employes, siteId));// 服务工程师ids 3张表
			order.setEmployeName(employes);// 服务工程师names
			orderDao.save(order);

			/* crm_order_dispacth派工表 */
			OrderDispatch orderDispatch = new OrderDispatch();
			if (rd.getDate("dispatch_time") != null) {// 派工时间
				orderDispatch.setDispatchTime(rd.getDate("dispatch_time"));
			} else {
				orderDispatch.setDispatchTime(new Date());
			}
			orderDispatch.setOrder(order);// order_id
			orderDispatch.setStatus("1");// 派工状态，4-已上门维修中
			if (rd.getDate("promise_time") != null) {
				orderDispatch.setPromiseFlag("1");// 是否有预约时间
			}
			orderDispatch.setUpdateTime(new Date());// 更新时间
			orderDispatch.setUpdateBy(name);// 更新操作人
			if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
				orderDispatch.setRemarks(rd.getStr("remarks"));// 备注
			}
			orderDispatch.setMessengerId(msgId);
			orderDispatch.setMessengerName(name);
			orderDispatch.setSiteId(siteId);
			orderDispatch.setEmployeId(employeIdAndName(employes, siteId));// 服务工程师ids
			orderDispatch.setEmployeName(employes);// 服务工程师names
			orderDispatchDao.save(orderDispatch);

			/* crm_order_dispatch_employe_rel工单派工与工程师关系表 */
			for (String st : employeArray) {
				OrderDispatchEmployeRel orderDispatchEmployeRel = new OrderDispatchEmployeRel();
				Record rd1 = Db.findFirst("select * from crm_employe a where a.status='0' and a.site_id=? and a.name=?", siteId, st);
				orderDispatchEmployeRel.setDispatchId(orderDispatch.getId());
				orderDispatchEmployeRel.setSiteId(siteId);
				orderDispatchEmployeRel.setOrderId(order.getId());
				orderDispatchEmployeRel.setEmpId(rd1.getStr("id"));
				orderDispatchEmployeRel.setEmpName(st);
				orderDispatchEmployeRelDao.save(orderDispatchEmployeRel);
			}

			String fbContent = rd.getStr("feedback");
			if (StringUtil.isNotBlank(fbContent)) {
				String fbName = rd.getStr("feedback_name");
				String fbResult = rd.getStr("feedback_result");
				String remark = rd.getStr("remarks");
				String orderId = order.getId();
				String dispId = orderDispatch.getId();
				Date fbTime = rd.getDate("feedback_time");
				createEmpFeedback(siteId, fbName, fbTime, fbContent, fbResult, orderId, dispId, remark);
			}
		} else if (orderStatus.equals("3")) {// 待回访
			String[] employeArray = employes.split(",");
			/* crm_order工单表 */
			Target ta1 = new Target();
			ta1.setType(Target.DISPATCH_ORDER);// 派工
			ta1.setName(name);
			ta1.setContent(name + "派工至" + employes);
			if (rd.getDate("dispatch_time") != null) {
				ta1.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("dispatch_time")));
			} else {
				ta1.setTime(DateToStringUtils.DateToString());
			}
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, processDetail(name, rd.getStr("process_detail")));

			Target ta2 = new Target();// 完成
			ta2.setTime(DateToStringUtils.DateToStringParam1(new Date()));
			if (rd.getDate("end_time") != null) {
				ta2.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("end_time")));
				order.setLatestProcessTime(rd.getDate("end_time"));
				order.setEndTime(rd.getDate("end_time"));// 完工时间
			} else {
				order.setEndTime(new Date());
			}
			ta2.setName(employes);
			ta2.setContent(employes + "确认维修完成");
			ta2.setType(12);
			String str2 = WebPageFunUtils.appendProcessDetail(ta2, str1);
			order.setProcessDetail(str2);// 过程信息
			order.setLatestProcess(employes + "确认维修完成");// 最新过程信息
			order.setEmployeId(employeIdAndName(employes, siteId));
			order.setEmployeName(employes);// 服务工程师names
			orderDao.save(order);

			/* crm_order_dispacth派工表 */
			OrderDispatch orderDispatch = new OrderDispatch();
			if (rd.getDate("dispatch_time") != null) {// 派工时间
				orderDispatch.setDispatchTime(rd.getDate("dispatch_time"));
			} else {
				orderDispatch.setDispatchTime(new Date());
			}
			if (rd.getDate("end_time") != null) {
				orderDispatch.setEndTime(rd.getDate("end_time"));// 完工时间
			} else {
				orderDispatch.setEndTime(new Date());
			}
			orderDispatch.setOrder(order);// order_id
			orderDispatch.setStatus("5");// 派工状态，4-已上门维修中
			if (rd.getDate("promise_time") != null) {
				orderDispatch.setPromiseFlag("1");// 是否有预约时间
			}
			orderDispatch.setUpdateTime(new Date());// 更新时间
			orderDispatch.setUpdateBy(name);// 更新操作人
			if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
				orderDispatch.setRemarks(rd.getStr("remarks"));// 备注
			}
			orderDispatch.setMessengerId(msgId);
			orderDispatch.setMessengerName(name);
			orderDispatch.setSiteId(siteId);
			orderDispatch.setEmployeId(employeIdAndName(employes, siteId));// 服务工程师ids 3张表
			orderDispatch.setEmployeName(employes);// 服务工程师names
			orderDispatchDao.save(orderDispatch);

			/* crm_order_dispatch_employe_rel工单派工与工程师关系表 */
			for (String st : employeArray) {
				OrderDispatchEmployeRel orderDispatchEmployeRel = new OrderDispatchEmployeRel();
				Record rd1 = Db.findFirst("select * from crm_employe a where a.status='0' and a.site_id=? and a.name=?", siteId, st);
				orderDispatchEmployeRel.setDispatchId(orderDispatch.getId());
				orderDispatchEmployeRel.setSiteId(siteId);
				orderDispatchEmployeRel.setOrderId(order.getId());
				orderDispatchEmployeRel.setEmpId(rd1.getStr("id"));
				orderDispatchEmployeRel.setEmpName(st);
				orderDispatchEmployeRelDao.save(orderDispatchEmployeRel);
			}

			String fbContent = rd.getStr("feedback");
			if (StringUtil.isNotBlank(fbContent)) {
				String fbName = rd.getStr("feedback_name");
				String fbResult = rd.getStr("feedback_result");
				String remark = rd.getStr("remarks");
				String orderId = order.getId();
				String dispId = orderDispatch.getId();
				Date fbTime = rd.getDate("feedback_time");
				createEmpFeedback(siteId, fbName, fbTime, fbContent, fbResult, orderId, dispId, remark);
			}
		}

		Result<Void> result = confirmChangePeer(order.getId(), id400);
		if (StringUtil.isNotBlank(result.getCode()) && !"200".equals(result.getCode())) {
			throw new RuntimeException("change confirm failed");
		}
		mapRet.put("code", "ok");
		mapRet.put("ids", order);
		return mapRet;

	}

	private Result<Void> confirmChangePeer(String orderId, String id400) {
		// Map<String, Object> params1 = new HashMap<>();
		// params1.put("orderId", orderId);
		// params1.put("id", id400);
		// return ezTemplate.postForm("/order400/confirmChange", params1, new
		// ParameterizedTypeReference<Result<Void>>() {
		// });
		SqlKit sqlQuery = new SqlKit().append("update crm_order_400 a set a.is_convert='1',a.update_time=now(),a.order_id=? where a.id=?");
		Db.use(DbKey.DB_ORDER_400).update(sqlQuery.toString(), orderId, id400);
		Result<Void> ret = new Result<>();
		ret.setCode("200");
		return ret;
	}

	private Result<Void> confirmChangeMorePeer(String orderIds, String ids400) {

		String[] orderIdsArr = orderIds.split(",");
		String[] ids400Arr = ids400.split(",");
		for (int i = 0; i < orderIdsArr.length; i++) {
			confirmChangePeer(orderIdsArr[i], ids400Arr[i]);
		}
		Result<Void> ret = new Result<>();
		ret.setCode("200");
		return ret;
	}

	public String employeIdAndName(String employes, String siteId) {
		String[] emName = employes.split(",");
		List<Record> emIdList = Db.find("select * from crm_employe a where a.status='0' and a.site_id=? and a.name in(" + StringUtil.joinInSql(emName) + ")", siteId);

		String str = "";
		for (Record rd1 : emIdList) {
			if (str.equals("")) {
				str = rd1.getStr("id");
			} else {
				str = str + "," + rd1.getStr("id");
			}
		}
		return str;
	}

	public Long checkEmploye(String emps, String siteId) {
		String[] emp400 = emps.split(",");
		return Db.queryLong("select count(*)  from crm_employe a where a.name in(" + StringUtil.joinInSql(emp400) + ") and a.site_id='" + siteId + "' and a.status='0'");
	}

	/*
	 * 判断数组中是否有重复的值
	 */
	public static boolean cheakIsRepeat(String[] array) {
		HashSet<String> hashSet = new HashSet<String>();
		for (int i = 0; i < array.length; i++) {
			hashSet.add(array[i]);
		}
		if (hashSet.size() == array.length) {
			return true;
		} else {
			return false;
		}
	}

	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> confirmMore(String siteId, String ids, String employes, String orderStatus, String isEmployes) {
		Map<String, Object> mapRet = new HashMap<>();
		mapRet.put("ids", "");
		List<Record> ls;
		try {
			ls = getList400(ids);
		} catch (NetworkException ex) {
			logger.error("confirm more failed for network req failed");
			mapRet.put("code", "no");
			return mapRet;
		}

		String marks = "0";
		List<String> numbers = new ArrayList<>();
		String zzjNums = "";

		for (Record rd : ls) {
			String numberOne = rd.getStr("number");
			if (StringUtils.isEmpty(zzjNums)) {
				zzjNums = numberOne;
			} else {
				zzjNums = zzjNums + "," + numberOne;
			}
			numbers.add(rd.getStr("number"));
			if ("1".equals(rd.getStr("is_convert"))) {
				marks = "1";
			}
		}
		if (StringUtils.isNotBlank(zzjNums)) {
			String[] numberArr = zzjNums.split(",");
			if (!cheakIsRepeat(numberArr)) {
				mapRet.put("code", "numbersRepeat");
				return mapRet;
			}
		}
		if ("1".equals(marks) || orderDao.isOrderExists(numbers, siteId)) {
			mapRet.put("code", "alreadyZzj");
			return mapRet;
		}
		String confirmResult = "";
		if (StringUtils.isNotBlank(employes)) {
			confirmResult = confirm(siteId, employes);
			if (confirmResult.equals("noEmployes")) {
				if ("是".equals(isEmployes)) {
					mapRet.put("code", "noEmployes");
					return mapRet;
				}
			}
			employes = confirmResult;
		}
		List<Order> orderList = new ArrayList<>();
		List<OrderDispatch> orderDispatchList = new ArrayList<>();
		List<Record> list = ls;
		Map<String, Record> mapper = new HashMap<>();
		for (Record r : list) {
			mapper.put(r.getStr("id"), r);
		}

		Record site = Db.findFirst("select * from crm_site a where a.id='" + siteId + "'");
		User user = UserUtils.getUser();
		List<String> id400List = new ArrayList<>();
		String name;
		String msgId = "";
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = CrmUtils.getSiteName();
			msgId = CrmUtils.getCurrentSiteId(user);
		} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
			msgId = no.getId();
		}
		String allNumbers = togetherNumber(list);

		HashSet<String> ret = new HashSet<>();
		String code = siteMsgService.ifOpenOrderSet(siteId);
		List<SimpleOrderNo> son = new ArrayList<SimpleOrderNo>();
		if ("200".equals(code)) {
			List<Record> listApply = Db.find(
					"select a.order_number from crm_site_fitting_apply a where a.order_number in (" + StringUtil.joinInSql(allNumbers.split(",")) + ") and a.site_id=? ", siteId);
			List<Record> listUsed = Db.find(
					"select a.order_number from crm_site_fitting_used_record a where a.order_number in (" + StringUtil.joinInSql(allNumbers.split(",")) + ") and a.site_id=? ",
					siteId);
			ret = needsNum(listApply, listUsed);
			son = CrmUtils.genOrderNos(siteId, list.size() - ret.size());
		}
		Integer sonMark = 0;
		String[] orderIds = new String[list.size()];
		int c = 0;
		for (Record rd : list) {
			orderIds[c++] = rd.getStr("id");
		}

		Map<String, Double> fittingFee = fittingUsedRecordService.calcFittingFee(orderIds);
		for (Record rd : list) {

			id400List.add(rd.getStr("id"));
			Order order = new Order();
			order.setFlag(rd.getStr("flag"));
			Double fee = fittingFee.get(rd.getStr("id"));
			if (fee != null) {
				order.setAuxiliaryCost(fee);
			}
			order.setFlagAlertDate(rd.getDate("flag_alert_date"));
			order.setFlagDesc(rd.getStr("flag_desc"));
			order.setStatus(orderStatus);
			order.setOrderType(rd.getStr("order_type"));// 工单来源
			order.setCreateTime(new Date());// 创建时间
			order.setRepairTime(rd.getDate("repair_time") == null ? new Date() : rd.getDate("repair_time"));// 报修时间
			order.setCreateBy(UserUtils.getUser().getId());// 创建人
			order.setApplianceBrand(rd.getStr("appliance_brand"));// 家电品牌
			order.setApplianceCategory(rd.getStr("appliance_category"));// 家电品类
			order.setApplianceModel(rd.getStr("appliance_model"));// 家电型号
			order.setApplianceBarcode(rd.getStr("appliance_barcode"));// 家电内机条码
			order.setApplianceNum(1);// 家电数量
			order.setApplianceMachineCode(rd.getStr("appliance_machine_code"));// 家电外机条码
			order.setCustomerName(rd.getStr("customer_name"));// 用户姓名
			order.setRecordAccount("0");// 未录单
			logger.info("编号为" + rd.getStr("number") + "的工单转自接前保修类型为：" + rd.getStr("warranty_type") + ";家电购机时间为：" + rd.getDate("appliance_buy_time") + " \n");
			order.setApplianceBuyTime(rd.getDate("appliance_buy_time"));// 家电购机时间
			if ("保内".equals(rd.getStr("warranty_type"))) {
				order.setWarrantyType("1");// 保修类型-保内
			} else if ("保外".equals(rd.getStr("warranty_type"))) {
				order.setWarrantyType("2");// 保修类型-保外
			}
			order.setMalfunctionCause(rd.getStr("malfunction_cause"));
			order.setMalfunctionCauseDescription(rd.getStr("malfunction_cause_description"));
			order.setMalfunctionType(rd.getStr("malfunction_type"));
			order.setMalfunctionDescription(rd.getStr("malfunction_description"));
			order.setMeasures(rd.getStr("measures"));
			order.setMeasuresDescription(rd.getStr("measures_description"));
			if (StringUtils.isNotBlank(rd.getStr("customer_address"))) {
				order.setCustomerAddress(rd.getStr("customer_address"));// 用户地址
			} else if (StringUtils.isNotBlank(rd.getStr("customer_address2"))) {
				order.setCustomerAddress(rd.getStr("customer_address2"));// 用户地址2
			}
			String mobiles = rd.getStr("customer_mobile");
			order.setCustomerMobile(StringUtils.isNotBlank(mobiles) ? mobiles.split(",")[0] : "");// 用户联系方式
			// order.setCustomerMobile(rd.getStr("customer_mobile"));// 用户联系方式
			order.setCustomerTelephone(rd.getStr("customer_telephone"));// 用户电话
			order.setCustomerTelephone2(rd.getStr("customer_telephone2"));// 用户电话2
			if (rd.getDate("promise_time") != null) {
				order.setPromiseTime(rd.getDate("promise_time"));// 预约时间
			}
			if (StringUtils.isNotBlank(rd.getStr("promise_limit"))) {
				order.setPromiseLimit(rd.getStr("promise_limit"));// 时间要求
			}
			if (StringUtils.isNotBlank(rd.getStr("customer_feedback"))) {
				order.setCustomerFeedback(rd.getStr("customer_feedback"));// 用户反馈TradeNoUtils.genOrderNo("V")
			}
			if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
				order.setRemarks(rd.getStr("remarks"));// 备注
			}
			order.setOrigin(dealOrigin(rd.getStr("order_type")));// 信息来源
			if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
				order.setServiceType(rd.getStr("service_type"));// 服务类型
			} else {
				order.setServiceType(rd.getStr("c_service_type"));// 服务类型
			}

			if (StringUtils.isNotBlank(rd.getStr("level"))) {
				if ("紧急".equals(rd.getStr("level"))) {
					order.setLevel("1");// 信息等级
				} else {
					order.setLevel("2");// 信息等级
				}
			}
			order.setSiteId(siteId);// 网点Id
			order.setSiteName(site.getStr("name"));// 网点名称
			order.setMessengerId(msgId);// 信息员Id
			order.setMessengerName(name);// 信息员名称
			order.setNumber(rd.getStr("number"));
			order.setFactoryNumber(rd.getStr("number"));// 转自接过来的工单记录原400工单编号
			if ("200".equals(code)) {
				if (son.size() > 0) {
					SimpleOrderNo sonEntity = son.get(sonMark);
					if (!ret.contains(rd.getStr("number"))) {
						order.setNumber(sonEntity.getNo());
						order.setSeq(sonEntity.getS());
						sonMark++;
					}
				}
			}
			if (orderStatus.equals("1")) {// 待派工
				order.setLatestProcessTime(new Date());
				order.setLatestProcess(name + "转自接");// 最新过程信息
				order.setProcessDetail(processDetail(name, rd.getStr("process_detail")));// 过程信息
				orderList.add(order);
			} else if (orderStatus.equals("2")) {// 服务中
				if ("否".equals(isEmployes)) {
					List<String> list1 = getEmpIdAndName(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"), siteId);
					order.setEmployeName(list1.get(0));
					order.setEmployeId(list1.get(2));
					Target ta1 = new Target();
					ta1.setType(Target.DISPATCH_ORDER);// 派工
					ta1.setName(name);
					ta1.setContent(name + "派工至" + list1.get(0));
					if (rd.getDate("dispatch_time") != null) {
						ta1.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("dispatch_time")));
						// order.setPromiseTime(rd.getDate("dispatch_time"));
					} else {
						ta1.setTime(DateToStringUtils.DateToString());
						// order.setPromiseTime(new Date());
					}
					String str1 = WebPageFunUtils.appendProcessDetail(ta1, processDetail(name, rd.getStr("process_detail")));
					order.setProcessDetail(str1);// 过程信息
					order.setLatestProcess(name + "派工至" + list1.get(0));// 最新过程信息
					/* crm_order_dispacth派工表 */
					OrderDispatch orderDispatch = new OrderDispatch();
					if (rd.getDate("dispatch_time") != null) {// 派工时间
						orderDispatch.setDispatchTime(rd.getDate("dispatch_time"));
					} else {
						orderDispatch.setDispatchTime(new Date());
					}
					orderDispatch.setOrder(order);// order_id
					orderDispatch.setStatus("1");// 派工状态，4-已上门维修中
					if (rd.getDate("promise_time") != null) {
						orderDispatch.setPromiseFlag("1");// 是否有预约时间
					}
					orderDispatch.setUpdateTime(new Date());// 更新时间
					orderDispatch.setUpdateBy(name);// 更新操作人
					if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
						orderDispatch.setRemarks(rd.getStr("remarks"));// 备注
					}
					orderDispatch.setMessengerId(msgId);
					orderDispatch.setMessengerName(name);
					orderDispatch.setSiteId(siteId);
					orderDispatch.setEmployeId(list1.get(2));// 服务工程师ids
					orderDispatch.setEmployeName(list1.get(0));// 服务工程师names
					orderList.add(order);
					orderDispatchList.add(orderDispatch);
				} else if ("是".equals(isEmployes)) {
					Target ta1 = new Target();
					ta1.setType(Target.DISPATCH_ORDER);// 派工
					ta1.setName(name);
					ta1.setContent(name + "派工至" + employes);
					if (rd.getDate("dispatch_time") != null) {
						ta1.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("dispatch_time")));
						// order.setPromiseTime(rd.getDate("dispatch_time"));
					} else {
						ta1.setTime(DateToStringUtils.DateToString());
						// order.setPromiseTime(new Date());
					}
					String str1 = WebPageFunUtils.appendProcessDetail(ta1, processDetail(name, rd.getStr("process_detail")));
					order.setProcessDetail(str1);// 过程信息
					order.setLatestProcess(name + "派工至" + employes);// 最新过程信息
					order.setEmployeId(employeIdAndName(employes, siteId));// 服务工程师ids 3张表
					order.setEmployeName(employes);// 服务工程师names
					/* crm_order_dispacth派工表 */
					OrderDispatch orderDispatch = new OrderDispatch();
					if (rd.getDate("dispatch_time") != null) {// 派工时间
						orderDispatch.setDispatchTime(rd.getDate("dispatch_time"));
					} else {
						orderDispatch.setDispatchTime(new Date());
					}
					orderDispatch.setOrder(order);// order_id
					orderDispatch.setStatus("1");// 派工状态，4-已上门维修中
					if (rd.getDate("promise_time") != null) {
						orderDispatch.setPromiseFlag("1");// 是否有预约时间
					}
					orderDispatch.setUpdateTime(new Date());// 更新时间
					orderDispatch.setUpdateBy(name);// 更新操作人
					if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
						orderDispatch.setRemarks(rd.getStr("remarks"));// 备注
					}
					orderDispatch.setMessengerId(msgId);
					orderDispatch.setMessengerName(name);
					orderDispatch.setSiteId(siteId);
					orderDispatch.setEmployeId(employeIdAndName(employes, siteId));// 服务工程师ids
					orderDispatch.setEmployeName(employes);// 服务工程师names
					orderList.add(order);
					orderDispatchList.add(orderDispatch);
				}
			} else if (orderStatus.equals("3")) {// 待回访
				if ("否".equals(isEmployes)) {// 选择的否的话，则每个工单转自接之后服务工程师还是原本工单的工程师
					List<String> list1 = getEmpIdAndName(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"), siteId);
					order.setEmployeName(list1.get(0));
					order.setEmployeId(list1.get(2));
					Target ta1 = new Target();
					ta1.setType(Target.DISPATCH_ORDER);// 派工
					ta1.setName(name);
					ta1.setContent(name + "派工至" + list1.get(0));
					if (rd.getDate("dispatch_time") != null) {
						ta1.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("dispatch_time")));
					} else {
						ta1.setTime(DateToStringUtils.DateToString());
					}
					String str1 = WebPageFunUtils.appendProcessDetail(ta1, processDetail(name, rd.getStr("process_detail")));
					Target ta2 = new Target();// 完成
					ta2.setTime(DateToStringUtils.DateToStringParam1(new Date()));
					if (rd.getDate("end_time") != null) {
						ta2.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("end_time")));
						order.setLatestProcessTime(rd.getDate("end_time"));
						order.setEndTime(rd.getDate("end_time"));// 完工时间
					} else {
						order.setEndTime(new Date());
					}
					ta2.setName(list1.get(0));
					ta2.setContent(list1.get(0) + "确认维修完成");
					ta2.setType(12);
					String str2 = WebPageFunUtils.appendProcessDetail(ta2, str1);
					order.setProcessDetail(str2);// 过程信息
					order.setLatestProcess(list1.get(0) + "确认维修完成");// 最新过程信息
					/* crm_order_dispacth派工表 */
					OrderDispatch orderDispatch = new OrderDispatch();
					if (rd.getDate("dispatch_time") != null) {// 派工时间
						orderDispatch.setDispatchTime(rd.getDate("dispatch_time"));
					} else {
						orderDispatch.setDispatchTime(new Date());
					}
					if (rd.getDate("end_time") != null) {
						orderDispatch.setEndTime(rd.getDate("end_time"));// 完工时间
					} else {
						orderDispatch.setEndTime(new Date());
					}
					orderDispatch.setOrder(order);// order_id
					orderDispatch.setStatus("5");// 派工状态，4-已上门维修中
					if (rd.getDate("promise_time") != null) {
						orderDispatch.setPromiseFlag("1");// 是否有预约时间
					}
					orderDispatch.setUpdateTime(new Date());// 更新时间
					orderDispatch.setUpdateBy(name);// 更新操作人
					if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
						orderDispatch.setRemarks(rd.getStr("remarks"));// 备注
					}
					orderDispatch.setMessengerId(msgId);
					orderDispatch.setMessengerName(name);
					orderDispatch.setSiteId(siteId);
					orderDispatch.setEmployeId(list1.get(2));// 服务工程师ids
					orderDispatch.setEmployeName(list1.get(0));// 服务工程师names
					orderList.add(order);
					orderDispatchList.add(orderDispatch);
				} else if ("是".equals(isEmployes)) {
					/* crm_order工单表 */
					Target ta1 = new Target();
					ta1.setType(Target.DISPATCH_ORDER);// 派工
					ta1.setName(name);
					ta1.setContent(name + "派工至" + employes);
					if (rd.getDate("dispatch_time") != null) {
						ta1.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("dispatch_time")));
					} else {
						ta1.setTime(DateToStringUtils.DateToString());
					}
					String str1 = WebPageFunUtils.appendProcessDetail(ta1, processDetail(name, rd.getStr("process_detail")));

					Target ta2 = new Target();// 完成
					ta2.setTime(DateToStringUtils.DateToStringParam1(new Date()));
					if (rd.getDate("end_time") != null) {
						ta2.setTime(DateToStringUtils.DateToStringParam1(rd.getDate("end_time")));
						order.setLatestProcessTime(rd.getDate("end_time"));
						order.setEndTime(rd.getDate("end_time"));// 完工时间
					} else {
						order.setEndTime(new Date());
					}
					ta2.setName(employes);
					ta2.setContent(employes + "确认维修完成");
					ta2.setType(12);
					String str2 = WebPageFunUtils.appendProcessDetail(ta2, str1);
					order.setProcessDetail(str2);// 过程信息
					order.setLatestProcess(employes + "确认维修完成");// 最新过程信息
					order.setEmployeId(employeIdAndName(employes, siteId));
					order.setEmployeName(employes);// 服务工程师names

					/* crm_order_dispacth派工表 */
					OrderDispatch orderDispatch = new OrderDispatch();
					if (rd.getDate("dispatch_time") != null) {// 派工时间
						orderDispatch.setDispatchTime(rd.getDate("dispatch_time"));
					} else {
						orderDispatch.setDispatchTime(new Date());
					}
					if (rd.getDate("end_time") != null) {
						orderDispatch.setEndTime(rd.getDate("end_time"));// 完工时间
					} else {
						orderDispatch.setEndTime(new Date());
					}
					orderDispatch.setOrder(order);// order_id
					orderDispatch.setStatus("5");// 派工状态，4-已上门维修中
					if (rd.getDate("promise_time") != null) {
						orderDispatch.setPromiseFlag("1");// 是否有预约时间
					}
					orderDispatch.setUpdateTime(new Date());// 更新时间
					orderDispatch.setUpdateBy(name);// 更新操作人
					if (StringUtils.isNotBlank(rd.getStr("remarks"))) {
						orderDispatch.setRemarks(rd.getStr("remarks"));// 备注
					}
					orderDispatch.setMessengerId(msgId);
					orderDispatch.setMessengerName(name);
					orderDispatch.setSiteId(siteId);
					orderDispatch.setEmployeId(employeIdAndName(employes, siteId));// 服务工程师ids 3张表
					orderDispatch.setEmployeName(employes);// 服务工程师names
					orderList.add(order);
					orderDispatchList.add(orderDispatch);
				}
			}
		}
		if (orderStatus.equals("1")) {// 待派工
			orderDao.save(orderList);
		} else if (orderStatus.equals("2")) {// 服务中
			List<OrderDispatchEmployeRel> oderList = new ArrayList<>();
			List<OrderFeedback> orderFeedbackList = new ArrayList<>();
			Integer j = 0;
			orderDispatchDao.save(orderDispatchList);
			/* crm_order_dispatch_employe_rel工单派工与工程师关系表 */
			for (OrderDispatch op : orderDispatchList) {
				Record order4 = mapper.get(id400List.get(j));
				j++;
				String employeDis = op.getEmployeName();
				String[] empDis = employeDis.split(",");
				for (String st : empDis) {
					OrderDispatchEmployeRel orderDispatchEmployeRel = new OrderDispatchEmployeRel();
					Record rd1 = Db.findFirst("select * from crm_employe a where a.status='0' and a.site_id=? and a.name=?", siteId, st);
					orderDispatchEmployeRel.setDispatchId(op.getId());
					orderDispatchEmployeRel.setSiteId(siteId);
					orderDispatchEmployeRel.setOrderId(op.getOrder().getId());
					orderDispatchEmployeRel.setEmpId(rd1.getStr("id"));
					orderDispatchEmployeRel.setEmpName(st);
					oderList.add(orderDispatchEmployeRel);
				}

				String fbContent = order4.getStr("feedback");
				if (StringUtil.isNotBlank(fbContent)) {
					String fbName = order4.getStr("feedback_name");
					String fbResult = order4.getStr("feedback_result");
					String remark = order4.getStr("remarks");
					String orderId = op.getOrder().getId();
					String dispId = op.getId();
					Date fbTime = order4.getDate("feedback_time");
					OrderFeedback orderFeedback = newEmpFeedback(siteId, fbName, fbTime, fbContent, fbResult, orderId, dispId, remark);
					if (orderFeedback != null) {
						orderFeedbackList.add(orderFeedback);
					}
				}
			}
			orderDispatchEmployeRelDao.save(oderList);
			orderFeedbackDao.save(orderFeedbackList);
		} else if (orderStatus.equals("3")) {// 待回访
			List<OrderDispatchEmployeRel> oderList = new ArrayList<>();
			List<OrderFeedback> orderFeedbackList = new ArrayList<>();
			orderDispatchDao.save(orderDispatchList);
			Integer j = 0;
			/* crm_order_dispatch_employe_rel工单派工与工程师关系表 */
			for (OrderDispatch op : orderDispatchList) {
				Record order4 = mapper.get(id400List.get(j));
				j++;
				String employeDis = op.getEmployeName();
				String[] empDis = employeDis.split(",");
				for (String st : empDis) {
					OrderDispatchEmployeRel orderDispatchEmployeRel = new OrderDispatchEmployeRel();
					Record rd1 = Db.findFirst("select * from crm_employe a where a.status='0' and a.site_id=? and a.name=?", siteId, st);
					orderDispatchEmployeRel.setDispatchId(op.getId());
					orderDispatchEmployeRel.setSiteId(siteId);
					orderDispatchEmployeRel.setOrderId(op.getOrder().getId());
					orderDispatchEmployeRel.setEmpId(rd1.getStr("id"));
					orderDispatchEmployeRel.setEmpName(st);
					oderList.add(orderDispatchEmployeRel);
				}
				/* crm_order_feedback工单反馈表 */
				// OrderFeedback orderFeedback = new OrderFeedback();
				// String feedName="MAINSERVICE";//反馈人
				// if(StringUtils.isNotBlank(order4.getStr("feedback_name"))){
				// Long ff = Db.queryLong("select count(*) from crm_employe a where a.status='0'
				// and a.site_id=? and a.name=?",siteId,order4.getStr("feedback_name"));
				// if(ff>0){
				// feedName=order4.getStr("feedback_name");
				// Record rd3 = Db.findFirst("select * from crm_employe a where a.status='0' and
				// a.site_id=? and a.name=?",siteId,order4.getStr("feedback_name"));
				// orderFeedback.setFeedbackId(rd3.getStr("id"));
				// }
				// }
				// orderFeedback.setDispatchId(op.getId());
				// orderFeedback.setOrderId(op.getOrder().getId());
				// orderFeedback.setFeedbackName(feedName);
				// orderFeedback.setSiteId(siteId);
				// orderFeedback.setFeedbackType("1");
				// orderFeedback.setUserType("4");
				// if(StringUtils.isNotBlank(order4.getStr("remarks"))){
				// orderFeedback.setRemarks(order4.getStr("remarks"));//备注
				// }
				// if(order4.getDate("feedback_time")!=null){//反馈时间
				// orderFeedback.setFeedbackTime(order4.getDate("feedback_time"));
				// }
				// if(StringUtils.isNotBlank(order4.getStr("feedback_result"))){//反馈结果
				// orderFeedback.setFeedbackResult(order4.getStr("feedback_result"));
				// }
				// if(StringUtils.isNotBlank(order4.getStr("feedback"))){//反馈内容
				// orderFeedback.setFeedback(order4.getStr("feedback"));
				// }

				String fbContent = order4.getStr("feedback");
				if (StringUtil.isNotBlank(fbContent)) {
					String fbName = order4.getStr("feedback_name");
					String fbResult = order4.getStr("feedback_result");
					String remark = order4.getStr("remarks");
					String orderId = op.getOrder().getId();
					String dispId = op.getId();
					Date fbTime = order4.getDate("feedback_time");
					OrderFeedback orderFeedback = newEmpFeedback(siteId, fbName, fbTime, fbContent, fbResult, orderId, dispId, remark);
					if (orderFeedback != null) {
						orderFeedbackList.add(orderFeedback);
					}
				}
			}
			orderDispatchEmployeRelDao.save(oderList);
			orderFeedbackDao.save(orderFeedbackList);
		}
		Integer i = 0;
		List<String> orderIds2 = new ArrayList<>();
		List<String> ids2 = new ArrayList<>();
		String idsRet = "";
		for (Order od : orderList) {
			orderIds2.add(od.getId());
			ids2.add(id400List.get(i));
			if (StringUtils.isBlank(idsRet)) {
				idsRet = od.getId();
			} else {
				idsRet += "," + od.getId();
			}
			i++;
		}
		confirmChangeMorePeer(StringUtils.join(orderIds2, ","), StringUtils.join(ids2, ","));
		mapRet.put("code", "ok");
		mapRet.put("ids", orderList);
		return mapRet;
	}

	public String processDetail(String name, String proDetail) {// 同步过程信息和转自接
		String str1 = "";
		if (StringUtils.isNotBlank(proDetail)) {
			Target ta1 = new Target();
			ta1.setType(Target.ORDER_ZZJ);// 同步过程信息
			ta1.setName("系统助手");
			ta1.setContent(proDetail);
			ta1.setTime(DateToStringUtils.DateToString());
			str1 = WebPageFunUtils.appendProcessDetail(ta1, "");
		}
		Target ta = new Target();
		ta.setType(Target.NEW_ORDER);// 转自接工单
		ta.setName(name);
		ta.setContent(name + "转自接");
		ta.setTime(DateToStringUtils.DateToString());
		return WebPageFunUtils.appendProcessDetail(ta, str1);
	}

	public List<String> getEmpIdAndName(String emps1, String emps2, String emps3, String siteId) {
		List<String> list = new ArrayList<>();
		String emp1 = "";
		String emp2 = "";
		if (StringUtils.isNotBlank(emps1)) {
			if (emp1.equals("")) {
				emp1 = emps1;
				emp2 = "'" + emps1 + "'";
			} else {
				emp1 = emp1 + "," + emps1;
				emp2 = emp2 + ",'" + emps1 + "'";
			}
		}
		if (StringUtils.isNotBlank(emps2)) {
			if (emp1.equals("")) {
				emp1 = emps2;
				emp2 = "'" + emps2 + "'";
			} else {
				emp1 = emp1 + "," + emps2;
				emp2 = emp2 + ",'" + emps2 + "'";
			}
		}
		if (StringUtils.isNotBlank(emps3)) {
			if (emp1.equals("")) {
				emp1 = emps3;
				emp2 = "'" + emps3 + "'";
			} else {
				emp1 = emp1 + "," + emps3;
				emp2 = emp2 + ",'" + emps3 + "'";
			}
		}
		Set<String> set = new HashSet<>();
		String[] emp4001 = emp1.split(",");
		for (int i = 0; i < emp4001.length; i++) {
			set.add(emp4001[i]);
		}
		emp4001 = (String[]) set.toArray(new String[set.size()]);
		emp1 = StringUtils.join(emp4001, ",");

		List<Record> records = Db.find("select * from crm_employe a where a.status='0' and a.site_id='" + siteId + "' and a.name in (" + emp2 + ")");
		String empIds = "";
		for (Record rd : records) {
			if (empIds.equals("")) {
				empIds = rd.getStr("id");
			} else {
				empIds = empIds + "," + rd.getStr("id");
			}
		}
		list.add(emp1);
		list.add(emp2);
		list.add(empIds);
		return list;
	}

	public Record changeSelfOrderService(String id) {
		return oneDetail(id);
	}

	public Record changeSelfOrderServiceFor2017(String id) {
		return oneDetail2017(id);
	}

	public Record changeSelfOrderService4(String oderNum, String siteId) {
		return getOrder400ByNumber(oderNum, siteId);
	}

	public Record getOrder400ByNumber(String oderNum, String siteId) {
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", siteId);
		params.put("oderNum", oderNum);
		Result<CrmOrder400Vo> resp = ezTemplate.postForm("/order400/showByOrderNumber", params, new ParameterizedTypeReference<Result<CrmOrder400Vo>>() {
		});
		if (!resp.isOk()) {
			logger.error("request 400 by number failed");
			throw new NetworkException("request 400 by number failed");
		}
		CrmOrder400Vo v = resp.getData();
		return v == null ? null : v.asRecord();
	}

	public List<Record> getList400(String ids) {
		Map<String, Object> params = new HashMap<>();
		params.put("ids", ids);
		Result<List<CrmOrder400Vo>> resp = ezTemplate.postForm("/order400/showM", params, new ParameterizedTypeReference<Result<List<CrmOrder400Vo>>>() {
		});
		if (!resp.isOk()) {
			logger.error("confirm more failed for network req failed");
			throw new NetworkException("request 400 by ids failed");
		}
		List<Record> ls = new ArrayList<>();
		for (CrmOrder400Vo v : resp.getData()) {
			ls.add(v.asRecord());
		}
		return ls;
	}

	public List<Record> getList400SortByCreateTimeDesc(String ids) {
		List<Record> list400 = getList400(ids);
		Collections.sort(list400, new Comparator<Record>() {
			@Override
			public int compare(Record o1, Record o2) {
				Date d1 = o1.getDate("create_time");
				Date d2 = o2.getDate("create_time");
				return d1.compareTo(d2);
			}
		});
		return list400;
	}

	public Record oneDetail(String id) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		Result<CrmOrder400Vo> resp = ezTemplate.postForm("/order400/show", params, new ParameterizedTypeReference<Result<CrmOrder400Vo>>() {
		});
		if (!resp.isOk()) {
			throw new NetworkException("request 400 order detail failed");
		}
		CrmOrder400Vo data = resp.getData();
		return data == null ? null : data.asRecord();
	}

	public CrmOrder400 getOrder400(String id) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		Result<CrmOrder400> resp = ezTemplate.postForm("/order400/show", params, new ParameterizedTypeReference<Result<CrmOrder400>>() {
		});
		if (!resp.isOk()) {
			throw new NetworkException("request 400 order detail failed");
		}
		return resp.getData();
	}

	public Record oneDetail2017(String id) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		Result<CrmOrder400Vo> resp = ezTemplate.postForm("/order400/show2017", params, new ParameterizedTypeReference<Result<CrmOrder400Vo>>() {
		});
		if (!resp.isOk()) {
			throw new NetworkException("request 400 2017 order detail failed");
		}
		CrmOrder400Vo data = resp.getData();
		return data == null ? null : data.asRecord();
	}

	public String checkNumber(String numbers, String siteId) {
		try {
			Long count = Db.queryLong("select count(*) from crm_order a where a.site_id='" + siteId + "' and a.number in(" + numbers + ")");
			if (count < 1) {
				return "ok";
			} else {
				return "existNumber";
			}
		} catch (Exception e) {
			return "no";
		}
	}

	/**
	 * 美的
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getCount(String siteId) {
		return getInnerCount(siteId, "2");
	}

	private Map<String, Long> getInnerCount(String siteId, String orderType) {
		Map<String, Long> ret = loadCountFromCache(siteId, orderType);
		if (ret != null) {
			return ret;
		}

		Map<String, Object> params = new HashMap<>();
		params.put("siteId", siteId);
		params.put("orderType", orderType);
		ret = ezTemplate.postForm("/order400/getCounts", params, new ParameterizedTypeReference<Map<String, Long>>() {
		});

		if (!ret.containsKey("error")) {
			sfCacheService.setex(String.format("sid:%s:t:%s:count", siteId, orderType), 10 * 60, new Gson().toJson(ret));
		}
		return ret;
	}

	private Map<String, Long> loadCountFromCache(String siteId, String orderType) {
		String s = sfCacheService.get(String.format("sid:%s:t:%s:count", siteId, orderType));
		if (!StringUtil.isBlank(s)) {
			return new Gson().fromJson(s, new TypeToken<HashMap<String, Long>>() {
			}.getType());
		}
		return null;
	}

	/**
	 * 海尔
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getHaierCount(String siteId) {
		return getInnerCount(siteId, "5");
	}

	/**
	 * 海信
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getHaixinCount(String siteId) {
		return getInnerCount(siteId, "4");
	}

	/**
	 * 惠而浦
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getHuierpuCount(String siteId) {
		return getInnerCount(siteId, "3");
	}

	/**
	 * 奥克斯
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getAokesiCount(String siteId) {
		return getInnerCount(siteId, "9");
	}

	/**
	 * 格力
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getGeliCount(String siteId) {
		return getInnerCount(siteId, "8");
	}

	/**
	 * 美菱
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getMeilingCount(String siteId) {
		return getInnerCount(siteId, "f");
	}

	/**
	 * Tcl
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getTclCount(String siteId) {
		return getInnerCount(siteId, "g");
	}

	public Map<String, Long> getSuningCount(String siteId) {
		return getInnerCount(siteId, "h");
	}

	public Map<String, Long> getGuomeiCount(String siteId) {
		return getInnerCount(siteId, "i");
	}

	public Map<String, Long> getJingdongCount(String siteId) {
		return getInnerCount(siteId, "j");
	}

	@Transactional(rollbackFor = Exception.class)
	public String delMore(String delIds) {
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		params.put("delIds", delIds);
		return ezTemplate.postForm("/order400/delMore", params, new ParameterizedTypeReference<String>() {
		});
	}

	public String getEmpIdAndName1(String emps1, String emps2, String emps3) {
		// List<String> list = new ArrayList<>();
		// String emp1="";
		// if(StringUtils.isNotBlank(emps1)){
		// if(emp1.equals("")){
		// emp1=emps1;
		// }else{
		// emp1=emp1+","+emps1;
		// }
		// }
		// if(StringUtils.isNotBlank(emps2)){
		// if(emp1.equals("")){
		// emp1=emps2;
		// }else{
		// emp1=emp1+","+emps2;
		// }
		// }
		// if(StringUtils.isNotBlank(emps3)){
		// if(emp1.equals("")){
		// emp1=emps3;
		// }else{
		// emp1=emp1+","+emps3;
		// }
		// }
		// Set<String> set = new HashSet<>();
		// String[] emp4001 = emp1.split(",");
		// for(int i=0;i<emp4001.length;i++){
		// set.add(emp4001[i]);
		// }
		// emp4001 = (String[]) set.toArray(new String[set.size()]);
		// emp1=StringUtils.join(emp4001,",");
		// return emp1;
		return StringUtil.uniqueJoin(",", emps1, emps2, emps3);
	}

	public Map<String, Object> getEmpIdAndName2(String emps1, String emps2, String emps3, String siteId) {
		String emps = "";
		String msg1 = "";// name(mobile),name(mobile)
		String msg2 = "";// names
		String msg3 = "";// mobiles
		String msg4 = "no";
		if (StringUtils.isNotBlank(emps1)) {
			if (emps.equals("")) {
				emps = emps1;
			} else {
				emps = emps + "," + emps1;
			}
		}
		if (StringUtils.isNotBlank(emps2)) {
			if (emps.equals("")) {
				emps = emps2;
			} else {
				emps = emps + "," + emps2;
			}
		}
		if (StringUtils.isNotBlank(emps3)) {
			if (emps.equals("")) {
				emps = emps3;
			} else {
				emps = emps + "," + emps3;
			}
		}
		if (StringUtils.isNotBlank(emps)) {
			String[] emp400 = emps.split(",");
			/* 先给服务工程师做去重处理 */
			Set<String> set = new HashSet<>();
			for (int i = 0; i < emp400.length; i++) {
				set.add(emp400[i]);
			}
			emp400 = (String[]) set.toArray(new String[set.size()]);
			// StringUtil.joinInSql(emp400)+");
			// String sql = "select a.* from crm_employe a where a.status='0' and
			// a.site_id=? and a.name in ("+StringUtil.joinInSql(emp400)+")";
			List<Record> list = Db.find("select a.* from crm_employe a where a.status='0' and a.site_id=? and a.name in (" + StringUtil.joinInSql(emp400) + ")", siteId);
			if (list.size() > 0) {
				msg4 = "ok";
				for (Record rd : list) {
					String mobile = "";
					if (StringUtils.isNotBlank(rd.getStr("mobile"))) {
						mobile = rd.getStr("mobile");
						if ("".equals(msg1)) {
							msg3 = rd.getStr("mobile");
						} else {
							msg3 = msg3 + "," + rd.getStr("mobile");
						}
					}
					if ("".equals(msg1)) {
						msg1 = rd.getStr("name") + "(" + mobile + ")";
					} else {
						msg1 = msg1 + "," + rd.getStr("name") + "(" + mobile + ")";
					}
					if ("".equals(msg2)) {
						msg2 = rd.getStr("name");
					} else {
						msg2 = msg2 + "," + rd.getStr("name");
					}
				}
			}
		}
		Map<String, Object> map = new HashMap<>();
		map.put("msg1", msg1);
		map.put("msg2", msg2);
		map.put("msg3", msg3);
		map.put("msg4", msg4);
		return map;
	}

	@Transactional
	public void markOrders(String[] ids, String flag, String flagDesc, String flagAlertTime) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (ids != null && ids.length > 0) {
			Map<String, Object> params = new HashMap<>();
			params.put("siteId", siteId);
			params.put("ids", StringUtils.join(ids, ","));
			params.put("flag", flag);
			params.put("flagDesc", flagDesc);
			params.put("flagAlertTime", flagAlertTime);
			ezTemplate.postForm("/order400/markOrders", params, new ParameterizedTypeReference<String>() {
			});
		}
	}

	/**
	 * 标记2017工单(400)
	 * 
	 * @param ids
	 * @param flag
	 * @param flagDesc
	 * @param flagAlertTime
	 */
	@Transactional
	public void markOrdersFor2017(String ids, String flag, String flagDesc, String flagAlertTime) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (StringUtils.isNotBlank(ids)) {
			Map<String, Object> maps = Maps.newHashMap();
			maps.put("flag", flag);
			maps.put("desc", flagDesc);
			maps.put("siteId", siteId);
			maps.put("ids", ids);
			maps.put("flagAlertTime", flagAlertTime);
			ezTemplate.postForm("/order400/markOrdersFor2017", maps, new ParameterizedTypeReference<String>() {
			});
		}
	}

	@Transactional
	public void cancelOrdersMark(String[] ids) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (ids != null && ids.length > 0) {
			Map<String, Object> params = new HashMap<>();
			params.put("siteId", siteId);
			params.put("ids", StringUtils.join(ids, ","));
			ezTemplate.postForm("/order400/cancelOrdersMark", params, new ParameterizedTypeReference<String>() {
			});
		}
	}

	/**
	 * 取消标记工单2017
	 * 
	 * @param ids
	 */
	@Transactional
	public void cancelOrdersMarkFor2017(String ids) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (StringUtils.isNotBlank(ids)) {
			Map<String, Object> maps = Maps.newHashMap();
			maps.put("siteId", siteId);
			maps.put("ids", ids);
			ezTemplate.postForm("/order400/cancelOrdersMarkOld", maps, new ParameterizedTypeReference<Result<String>>() {
			});
		}
	}

	public String check400OrderNumber(String number, String siteId) {
		Long applyCount = Db.queryLong("select count(1) from crm_site_fitting_apply a where a.order_number=? and a.site_id=? ", number, siteId);
		Long usedCount = Db.queryLong("select count(1) from crm_site_fitting_used_record a where a.order_number=? and a.site_id=? ", number, siteId);
		if (applyCount > 0 || usedCount > 0) {
			return "420";// 有关联备件使用或者申请，则工单编号不变
		}
		return "200";// 工单编号自定义规则
	}

	public String togetherNumber(List<Record> list) {
		String numbers = "";
		for (Record rd : list) {
			String number = rd.getStr("number");
			if (StringUtils.isBlank(numbers)) {
				numbers = number;
			} else {
				numbers = numbers + "," + number;
			}
		}
		return numbers;
	}

	public HashSet<String> needsNum(List<Record> list1, List<Record> list2) {
		HashSet<String> ret = new HashSet<>();
		for (Record r : list1) {
			ret.add(r.getStr("order_number"));
		}
		for (Record r : list2) {
			ret.add(r.getStr("order_number"));
		}
		return ret;
	}

	public String dealOrigin(String type) {
		String name = "";
		if ("2".equals(type)) {
			name = "美的";
		}
		if ("3".equals(type)) {
			name = "惠而浦";
		}
		if ("4".equals(type)) {
			name = "海信";
		}
		if ("5".equals(type)) {
			name = "海尔";
		}
		if ("8".equals(type)) {
			name = "格力";
		}
		if ("9".equals(type)) {
			name = "奥克斯";
		}
		if ("f".equals(type)) {
			name = "美菱";
		}
		if ("g".equals(type)) {
			name = "TCL";
		}
		if ("h".equals(type)) {
			name = "苏宁";
		}
		if ("i".equals(type)) {
			name = "国美";
		}
		if ("j".equals(type)) {
			name = "京东";
		}
		if (StringUtils.isBlank(name)) {
			return type;
		}
		return name;
	}
}
