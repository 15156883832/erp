/**
 */
package com.jojowonet.modules.order.dao;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import com.jojowonet.modules.order.utils.*;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import com.jojowonet.modules.sys.util.RegexUtil;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Repository;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.order.entity.CrmOrder2017;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.TableSplitMapper;
import com.jojowonet.modules.order.utils.WebPageFunUtils;
import com.jojowonet.modules.sys.util.http.EzTemplate;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.utils.StringUtils;

/**
 * 工单DAO接口
 * 
 * @author Ivan
 * @version 2017-05-04
 */
@Repository
public class OrderDao extends BaseDao<Order> {

	@Autowired
	private EzTemplate ezTemplate;
	@Autowired
	private SfCacheService sfCacheService;
	@Autowired
	private TableSplitMapper tableSplitMapper;

	private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static Logger logger = Logger.getLogger(OrderDao.class);

	// 查询工单编号是否存在
	public Record getorderNumber(String number, String siteId) {
		String sql = "SELECT id FROM  crm_order WHERE site_id=? AND number=?";
		return Db.findFirst(sql, siteId, number);
	}

	// 待派工工单和维修中工单
	public List<Record> getOrderWaitForDis(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail,(SELECT f.name FROM `crm_order_mark_settings` AS f WHERE f.`id`=o.`flag`) AS flag,d.status as disstatus,d.dispatch_time,d.drop_in_time,d.process_time,d.id as disorderId,d.`status` as disp_status,d.completion_result as completion_result FROM "
						+ getTable(map, cateList, brandList, siteId));
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id and d.status in('1','2','4') ");
		sf.append(" WHERE o.site_id=? ");
		if ("1".equals(status)) {
			sf.append(" AND o.status IN ('0','1','7') ");
		} else if ("2".equals(status)) {
			sf.append(" AND o.status IN ('2') ");
		}
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		sf.append(createOrderBy(map, " ORDER BY FIELD(o.status,0,1,7) ASC,o.create_time DESC  "));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(), siteId);
	}

	// 维修中工单
	public List<Record> getOrderWaitForDisDuring(String siteId, String status, Map<String, Object> map, String number, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,(SELECT f.name FROM `crm_order_mark_settings` AS f WHERE f.`id`=o.`flag`) AS flag,d.status as disstatus,d.dispatch_time,d.drop_in_time,d.process_time,d.id as disorderId,d.`status` as disp_status,d.completion_result as completion_result FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id and d.status in('1','2','4') ");
		sf.append(" WHERE o.site_id=? ");
		sf.append(" and o.number in(" + number + ")");
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC  "));
		return Db.find(sf.toString(), siteId);
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

	public long getOrderWaitCount(String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM " + getTableWhenCount(map, cateList, brandList, siteId));
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id and d.status in('1','2','4') ");
		sf.append(" WHERE o.site_id=?  ");
		if ("1".equals(status)) {
			sf.append(" AND o.status IN ('0','1','7') ");
		} else if ("2".equals(status)) {
			sf.append(" AND o.status IN ('2') ");
		}
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		return Db.queryLong(sf.toString(), siteId);
	}

	// 优化查询效率
	private String getTable(Map<String, Object> map, List<String> cateList, List<String> brandList, String siteId) {
		boolean hasLimitedOrders = isLimitedOrders(map, cateList, brandList);
		return (!hasLimitedOrders ? "crm_order o " : String.format("(select * from `crm_order` a where a.`site_id` = '%s') as o ", siteId));
	}

	private boolean isLimitedOrders(Map<String, Object> map, List<String> cateList, List<String> brandList) {
		boolean hasLimitedOrders = false;
		if (!CrmUtils.isSite()) {
			if (brandList != null && !StringUtil.checkParamsValid(map.get("applianceBrands"))) {
				// 设置类品牌并且查询的时候没有关联品牌，此时应该只显示登录人员关联的品牌。
				hasLimitedOrders = true;
			}
			if (cateList != null && !StringUtil.checkParamsValid(map.get("applianceCategory"))) {
				hasLimitedOrders = true;
			}
		}
		return hasLimitedOrders;
	}

	private String getTableWhenCount(Map<String, Object> map, List<String> cateList, List<String> brandList, String siteId) {
		boolean hasLimitedOrders = isLimitedOrders(map, cateList, brandList);
		return (!hasLimitedOrders ? "crm_order o " : String.format("(select * from `crm_order` a where a.`site_id` = '%s') as o ", siteId));
	}

	private String getTableWhenTabCount(List<String> cateList, List<String> brandList, String siteId) {
		boolean hasLimitedOrders = false;
		if (!CrmUtils.isSite()) {
			if (brandList != null) {
				// 设置类品牌并且查询的时候没有关联品牌，此时应该只显示登录人员关联的品牌。
				hasLimitedOrders = true;
			}
			if (cateList != null) {
				hasLimitedOrders = true;
			}
		}
		return (!hasLimitedOrders ? "crm_order a " : String.format("(select * from `crm_order` o where o.`site_id` = '%s') as a ", siteId));
	}

	// 待回访结算工单/历史工单
	public List<Record> getOrderWaitForDhf(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		String table = getTable(map, cateList, brandList, siteId);
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail, cb.service_attitude, cb.remarks as cbremarks,cod.dispatch_time, cod.process_time,cod.id as dispId,cod.`status` as disp_status, cod.completion_result as completion_result,cod.drop_in_time,  ");
		sf.append("(SELECT f.name FROM `crm_order_mark_settings` AS f WHERE f.`id`=o.`flag`) AS flag,");
		sf.append("(SELECT f.feedback FROM `crm_order_feedback` AS f WHERE f.`order_id`=o.`id` ORDER BY f.feedback_time DESC LIMIT 1) AS feedresult FROM ").append(table);
		sf.append(" left join crm_order_callback cb on cb.order_id = o.id and cb.site_id = '").append(siteId).append("' ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '").append(siteId).append("' and cod.status in ('1','2','4','5') ");
		sf.append(" WHERE o.site_id=? ");
		if (status == null) {
			status = "";
		}
		String[] statusX = null;
		if (StringUtil.isNotBlank(status)) {
			statusX = status.split(",");
		}
		if (statusX != null && statusX.length > 0) {
			if ("99".equals(status)) {
				sf.append(" AND o.status IN ('3','4') and cod.completion_result='1'");
			} else {
				sf.append(" AND o.status IN (").append(StringUtil.joinInSql(statusX)).append(") ");
			}
		}

		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(createOrderBy(map, " ORDER BY  o.create_time DESC"));
		if (page != null) {
			sf.append(" limit ").append(page.getPageSize()).append(" offset ").append((page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(), siteId);
	}

	public List<Record> getOrderWholeList(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		String table = getTable(map, cateList, brandList, siteId);
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail, cb.service_attitude, cb.remarks as cbremarks, ");
		sf.append("(SELECT f.name FROM `crm_order_mark_settings` AS f WHERE f.`id`=o.`flag`) AS flag,");
		sf.append("(SELECT f.feedback FROM `crm_order_feedback` AS f WHERE f.`order_id`=o.`id` ORDER BY f.feedback_time DESC LIMIT 1) AS feedresult FROM ").append(table);
		sf.append(" left join crm_order_callback cb on cb.order_id = o.id and cb.site_id = '").append(siteId).append("' ");
		sf.append(" WHERE o.site_id=? ");
		if (status == null) {
			status = "";
		}
		String[] statusX = null;
		if (StringUtil.isNotBlank(status)) {
			statusX = status.split(",");
		}
		if (statusX != null && statusX.length > 0) {
			if ("99".equals(status)) {
				sf.append(" AND o.status IN ('3','4')");
			} else {
				sf.append(" AND o.status IN (").append(StringUtil.joinInSql(statusX)).append(") ");
			}
		}

		sf.append(getRealOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(createOrderBy(map, " ORDER BY  o.create_time DESC"));
		if (page != null) {
			sf.append(" limit ").append(page.getPageSize()).append(" offset ").append((page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(), siteId);
	}

	// 短信发送失败历史工单导出
	public List<Record> getOrderWrongWaitForDhf(Page<Record> page, String siteId, String status, Map<String, Object> map, String number, List<String> cateList,
			List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT o.*, cb.service_attitude, cod.dispatch_time, cod.id as dispId,cod.`status` as disp_status FROM crm_order o  ");
		sf.append(" left join crm_order_callback cb on cb.order_id = o.id and cb.site_id = '" + siteId + "' ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5') ");
		sf.append(" WHERE o.site_id=? ");
		if ("3".equals(status)) {
			sf.append(" AND o.status IN ('3','4') ");
		} else if ("5".equals(status)) {
			sf.append(" AND o.status IN ('5','8') ");
		}
		sf.append(" and o.number in(" + number + ")");
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		sf.append(" ORDER BY o.create_time DESC  ");

		return Db.find(sf.toString(), siteId);
	}

	public long getOrderWaitDhfCount(String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM " + getTableWhenCount(map, cateList, brandList, siteId));
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5')");
		sf.append(" WHERE o.site_id=?  ");
		if (status == null) {
			status = "";
		}
		String[] statusx = null;
		if (StringUtil.isNotBlank(status)) {
			statusx = status.split(",");
		}
		if (statusx != null && statusx.length > 0) {
			if ("99".equals(status)) {
				sf.append(" AND o.status IN ('3','4') and cod.completion_result='1'");
			} else {
				sf.append(" AND o.status IN (" + StringUtil.joinInSql(statusx) + ") ");
			}
		}

		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		return Db.queryLong(sf.toString(), siteId);
	}

	public long getWholeOrderCount(String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT count(*) as count FROM ").append(getTableWhenCount(map, cateList, brandList, siteId));
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '").append(siteId).append("' and cod.status in ('1','2','4','5')");
		sf.append(" WHERE o.site_id=?  ");
		if (status == null) {
			status = "";
		}
		String[] statusX = null;
		if (StringUtil.isNotBlank(status)) {
			statusX = status.split(",");
		}
		if (statusX != null && statusX.length > 0) {
			if ("99".equals(status)) {
				sf.append(" AND o.status IN ('3','4') and cod.completion_result='1'");
			} else {
				sf.append(" AND o.status IN (").append(StringUtil.joinInSql(statusX)).append(") ");
			}
		}

		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		return Db.queryLong(sf.toString(), siteId);
	}

	public void onOrderCountChanged(String siteId, String type) {
		if (StringUtil.isBlank(siteId)) {
			throw new IllegalArgumentException("site id required");
		}
		logger.info(String.format("on order count changed,site.id=%s,type=%s", siteId, type));
		String key = String.format(SfCacheKey.siteUserOrderCountMap, siteId);
		sfCacheService.delDelay(0, key);
		sfCacheService.delDelay(2, key);
	}

	// 细分查询
	public List<Record> getOrderWaitForDisType(Page<Record> page, String status, String siteId, String otype, Map<String, Object> map, List<String> cateList,
			List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail,(SELECT f.name FROM `crm_order_mark_settings` AS f WHERE f.`id`=o.`flag`) AS flag,d.status as disStatus, d.dispatch_time, d.end_time, oc.service_attitude, d.id as dispId,d.completion_result as completion_result,oc.remarks as cbremarks,  ");
		sf.append("(SELECT f.feedback FROM `crm_order_feedback` AS f WHERE f.`order_id`=o.`id` ORDER BY f.feedback_time DESC LIMIT 1) AS feedresult ");
		sf.append(" FROM " + getTable(map, cateList, brandList, siteId));
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id and d.site_id = '" + siteId + "' ");

		if ("jjgd".equals(otype)) {
			sf.append(" AND d.status IN ('3') ");
		} else if ("dhf".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else if ("djs".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else if ("ywc".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else if ("wxgd".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else {
			sf.append(" AND d.status IN ('1','2','4') ");
		}
		sf.append(" left join crm_order_callback oc on oc.order_id = o.id and oc.site_id = '" + siteId + "' ");
		sf.append(" WHERE o.site_id=?  ");
		if ("1".equals(status)) {
			sf.append(" AND o.status IN ('1','7') ");
		} else if ("2".equals(status)) {
			sf.append(" AND o.status IN ('2') ");
		} else if ("3".equals(status)) {
			sf.append(" AND o.status IN ('3','4') ");
		} else if ("5".equals(status)) {
			sf.append(" AND o.status IN ('5','8') ");
		}
		if (StringUtils.isNotEmpty(otype)) {
			sf.append(getOrdertype(otype, map));
		}
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC  "));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(), siteId);
	}

	public long getOrderWaitCountType(String siteId, String status, String otype, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM " + getTableWhenCount(map, cateList, brandList, siteId));
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id  ");
		if ("jjgd".equals(otype)) {
			sf.append(" AND d.status IN ('3') ");
		} else if ("dhf".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else if ("djs".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else if ("ywc".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else if ("wxgd".equals(otype)) {
			sf.append(" AND d.status IN ('1','2','4','5') ");
		} else {
			sf.append(" AND d.status IN ('1','2','4') ");
		}
		sf.append(" WHERE o.site_id=? ");
		if ("1".equals(status)) {
			sf.append(" AND o.status IN ('1','7') ");
		} else if ("2".equals(status)) {
			sf.append(" AND o.status IN ('2') ");
		} else if ("3".equals(status)) {
			sf.append(" AND o.status IN ('3','4') ");
		} else if ("5".equals(status)) {
			sf.append(" AND o.status IN ('5','8') ");
		}
		if (StringUtils.isNotEmpty(otype)) {
			sf.append(getOrdertype(otype, map));
		}
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		return Db.queryLong(sf.toString(), siteId);
	}

	public String getOrdertype(String otype, Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if ("zbpg".equals(otype)) {// 暂不派工
			sf.append(" and o.status = '7' ");
		} else if ("jjgd".equals(otype)) {// 拒接工单
			sf.append(" and d.status = '3' ");
		} else if ("jryy".equals(otype)) {// 今日预约
			sf.append(" and o.promise_time = CURDATE() ");
		} else if ("djd".equals(otype)) {// 待接单
			sf.append(" and d.status = '1' ");
		} else if ("yjgd".equals(otype)) {// 预警工单
			String earlyWarning = null;
			if (map.get("earlyWarning") != null) {
				earlyWarning = (String) map.get("earlyWarning");
			}
			if (org.apache.commons.lang3.StringUtils.isNotBlank(earlyWarning)) {
				if ("24".equals(earlyWarning)) {
					sf.append(" and (UNIX_TIMESTAMP(NOW()) - 24*60*60)<UNIX_TIMESTAMP(o.create_time) AND UNIX_TIMESTAMP(o.create_time) < (UNIX_TIMESTAMP(NOW()) - 20*60*60) ");
				} else if ("48".equals(earlyWarning)) {
					sf.append(" and (UNIX_TIMESTAMP(NOW()) - 24*60*60*2)<UNIX_TIMESTAMP(o.create_time)   AND UNIX_TIMESTAMP(o.create_time) < (UNIX_TIMESTAMP(NOW()) - 24*60*60) ");
				} else if ("72".equals(earlyWarning)) {
					sf.append(" and (UNIX_TIMESTAMP(NOW()) - 24*60*60*3)<UNIX_TIMESTAMP(o.create_time)  AND UNIX_TIMESTAMP(o.create_time) < (UNIX_TIMESTAMP(NOW()) - 24*60*60*2) ");
				} else if ("100".equals(earlyWarning)) {
					sf.append(" and  UNIX_TIMESTAMP(o.create_time) < (UNIX_TIMESTAMP(NOW()) - 24*60*60*3) ");
				} else {
					sf.append(" and (UNIX_TIMESTAMP(NOW()) - 20*60*60)>UNIX_TIMESTAMP(o.create_time) ");
				}
			} else {
				sf.append(" and (UNIX_TIMESTAMP(NOW()) - 20*60*60)>UNIX_TIMESTAMP(o.create_time) ");
			}
		} else if ("djgd".equals(otype)) {// 待件工单
			sf.append(" and o.status = '2' and o.fitting_flag IN ('1','2','5','6') ");
		} else if ("dhf".equals(otype)) {// 待回访
			sf.append(" and o.status = '3' ");
		} else if ("djs".equals(otype)) {// 待结算
			sf.append(" and o.status = '4' ");
		} else if ("ywc".equals(otype)) {// 已完成工单
			sf.append(" and o.status = '5' ");
		} else if ("wxgd".equals(otype)) {// 无效工单
			sf.append(" and o.status = '8' ");
		}
		return sf.toString();
	}

	// 待派工/服务中查询条件
	public String getOrderCondition(Map<String, Object> map, List<String> cateList, List<String> brandList,String siteId) {
		StringBuffer sf = new StringBuffer();
		if (StringUtil.checkParamsValid(map.get("number"))) {
			sf.append(" and o.number like '%" + (map.get("number")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("factorynumber"))) {
			sf.append(" and o.factory_number like '%" + (map.get("factorynumber")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("review"))) {
			sf.append(" and o.review = '" + (map.get("review")) + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("customerName"))) {
			sf.append(" and o.customer_name like '%" + (map.get("customerName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerMobile"))) {
			String mobile = (String) map.get("customerMobile");
			if (mobile.trim().length() == 11 && mobile.startsWith("1")) {
				sf.append(String.format(" and (o.customer_mobile='%s' or o.customer_telephone='%s' or o.customer_telephone2='%s') ", mobile, mobile, mobile));
			} else {
				sf.append(" and (o.customer_mobile like '%" + (map.get("customerMobile")) + "%' or o.customer_telephone like '%" + map.get("customerMobile")
						+ "%' or o.customer_telephone2 like '%" + map.get("customerMobile") + "%') ");
			}
			// sf.append(" and (o.customer_mobile like
			// '%"+((String[])map.get("customerMobile"))[0]+"%') ");
		}
		if (StringUtil.checkParamsValid(map.get("customerAddress"))) {
			sf.append(" and concat_ws('',o.area,o.customer_address) like '%" + (map.get("customerAddress")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerType"))) {// 用户类型
			sf.append(" and o.customer_type = '" + map.get("customerType") + "' ");
		}
		if (!CrmUtils.isSite()) {
	

			if (cateList == null) {
				// 说明没有设置品类
				if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
					String brand[] = ((map.get("applianceCategory").toString())).split(",");
					sf.append(" and ( ");
					if(StringUtils.isBlank(brand[0]))  {
						String[] temp = deleteFirst(brand);
						brand = temp;
					}
					for(int i=0;i<brand.length;i++) {
						if(StringUtils.isNotBlank(brand[i])) {
							if (i == 0) {
								sf.append(" o.appliance_category like '%" + brand[i] + "%' ");
							} else {
								sf.append(" or o.appliance_category like '%" + brand[i] + "%' ");
							}
						}
					}
					sf.append(" ) ");
					//sf.append(" and o.appliance_category like '%" + (map.get("applianceCategory")) + "%' ");
				}
			} else {
				if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
					String brand[] = ((map.get("applianceCategory").toString())).split(",");
					sf.append(" and ( ");
					if(StringUtils.isBlank(brand[0]))  {
						String[] temp = deleteFirst(brand);
						brand = temp;
					}
					for(int i=0;i<brand.length;i++) {
						if(StringUtils.isNotBlank(brand[i])) {
							if (i == 0) {
								sf.append(" o.appliance_category like '%" + brand[i] + "%' ");
							} else {
								sf.append(" or o.appliance_category like '%" + brand[i] + "%' ");
							}
						}
					}
					sf.append(" ) ");
					//sf.append(" and o.appliance_category='" + (map.get("applianceCategory")) + "' ");
				} else {
					sf.append(" and o.appliance_category in (" + StringUtil.joinInSqlforllist(cateList) + ") ");
				}
			}

			if (brandList == null) {
				// 说明没有设置品牌
				if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
					String brand[] = ((map.get("applianceBrands").toString())).split(",");
					sf.append(" and ( ");
					if(StringUtils.isBlank(brand[0]))  {
						String[] temp = deleteFirst(brand);
						brand = temp;
					}
					for(int i=0;i<brand.length;i++) {
						if(i==0) {
							sf.append(" o.appliance_brand='" + brand[i] + "' ");
						}else {
							sf.append(" or o.appliance_brand='" + brand[i] + "' ");
						}
					}
					sf.append(" ) ");
					//sf.append(" and o.appliance_brand like '%" + (map.get("applianceBrands")) + "%' ");
				}
			} else {
				if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
					String brand[] = ((map.get("applianceBrands").toString())).split(",");
					sf.append(" and ( ");
					if(StringUtils.isBlank(brand[0]))  {
						String[] temp = deleteFirst(brand);
						brand = temp;
					}
					for(int i=0;i<brand.length;i++) {
						if(i==0) {
							sf.append(" o.appliance_brand='" + brand[i] + "' ");
						}else {
							sf.append(" or o.appliance_brand='" + brand[i] + "' ");
						}
					}
					sf.append(" ) ");
					//sf.append(" and o.appliance_brand='" + (map.get("applianceBrands")) + "' ");
				} else {
					sf.append(" and o.appliance_brand in (" + StringUtil.joinInSqlforllist(brandList) + ") ");
				}
			}

		} else {
			if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
				String brand[] = ((map.get("applianceBrands").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(i==0) {
						sf.append(" o.appliance_brand='" + brand[i] + "' ");
					}else {
						sf.append(" or o.appliance_brand='" + brand[i] + "' ");
					}
				}
				sf.append(" ) ");
				//sf.append(" and o.appliance_brand like '%" + (map.get("appapplianceBrands")) + "%' ");
			}
			if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
				String brand[] = ((map.get("applianceCategory").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(StringUtils.isNotBlank(brand[i])) {
					if (i == 0) {
						sf.append(" o.appliance_category like '%" + brand[i] + "%' ");
					} else {
						sf.append(" or o.appliance_category like '%" + brand[i] + "%' ");
					}
					}
				}
				sf.append(" ) ");
			//	sf.append(" and o.appliance_category like '%" + (map.get("applianceCategory")) + "%' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("serviceType"))) {
			sf.append(" and o.service_type = '" + (map.get("serviceType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("origin"))) {
			sf.append(" and o.origin = '" + (map.get("origin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("orderType"))) {
			sf.append(" and o.order_type = '" + (map.get("orderType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("warrantyType"))) {
			sf.append(" and o.warranty_type = '" + (map.get("warrantyType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("promiseTime"))) {
			sf.append(" and o.promise_time = '" + (map.get("promiseTime")) + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("dispatchTimesMin"))) {
			sf.append(" and d.dispatch_time >= '" + (map.get("dispatchTimesMin")) + " 00:00:00'  ");
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimesMax"))) {
			sf.append(" and d.dispatch_time <= '" + (map.get("dispatchTimesMax")) + " 23:59:59' ");
		}
		if (StringUtil.checkParamsValid(map.get("level"))) {
			sf.append(" and o.level = '" + (map.get("level")) + "' ");
		}
		if (StringUtil.checkParamsValid((map.get("messengerName")))) {// 登记人
			// sf.append(" and o.messenger_name like '%"+(map.get("messengerName"))+"%' ");
			SqlKit kit = new SqlKit().append("and exists(").append("select 1 from (").append("select user_id as id, name from crm_site").append("union all")
					.append("select user_id as id, name from crm_non_serviceman")
					.append("union all")
					.append("select user_id as id, name from crm_employe where site_id='" + siteId + "'")
					.append(") as t")
					.append("where t.id=o.create_by and t.name like '%" + map.get("messengerName") + "%'").append(")");

			sf.append(" ").append(kit.toString()).append(" ");
		}
		if (StringUtil.checkParamsValid((map.get("serviceMode")))) {// 登记人
			sf.append(" and o.service_mode like '%" + (map.get("serviceMode")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("statuss"))) {
			String[] status = ((map.get("statuss").toString())).split(",");
			if (status.length > 0) {
				sf.append(" and o.status in (" + StringUtil.joinInSql(status) + ") ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("secondSite"))) {
			String[] secondSites = ((map.get("secondSite").toString())).split(",");
			if (secondSites.length > 0) {
				sf.append(" and o.site_id in (" + StringUtil.joinInSql(secondSites) + ") ");
			}
		}

		// 工单收费
		if (StringUtil.checkParamsValid(map.get("ifReceipt"))) {
			if ("0".equals(map.get("ifReceipt"))) {// 收费的工单
				sf.append(" and (serve_cost >0 or auxiliary_cost>0 or warranty_cost>0) ");
			} else {// 未收费的工单
				sf.append(" and (serve_cost <=0 and auxiliary_cost<=0 and warranty_cost<=0) ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("statusFlag"))) {// 工单状态
			String stat[] = ((map.get("statusFlag").toString())).split(",");
			List<String> flg = Lists.newArrayList();// 待备件/缺件中 fintting_flag字段
			List<String> statuss = Lists.newArrayList();// status字段

			for (int i = 0; i < stat.length; i++) {
				if (stat[i].equals("1")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("2")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("4")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("5")) {
					flg.add(stat[i]);
				} else if (stat[i].equals("6")) {
					flg.add(stat[i]);
				} else if (stat[i].equals("7")) {
					flg.add(stat[i]);
				} else if (stat[i].equals("8")) {
					flg.add(stat[i]);
				}
			}
			for (int k = 0; k < flg.size(); k++) {
				if (flg.get(k).equals("5")) {
					flg.set(k, "1");
				} else if (flg.get(k).equals("6")) {
					flg.set(k, "2");
				}else if (flg.get(k).equals("7")) {
					flg.set(k, "5");
				}else if (flg.get(k).equals("8")) {
					flg.set(k, "6");
				}
			}

			if (flg.size() > 0 && statuss.size() == 0) {// 只有fintting_flag
				if (flg.size() == 1) {
					sf.append(" and o.fitting_flag='" + flg.get(0) + "' ");
				} else if (flg.size() > 1) {
					for (int i = 0; i < flg.size(); i++) {
						if (i == 0) {
							sf.append(" and (o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i > 0 && i < flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i == flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "') ");
							continue;
						}

					}
				}
			} else if (flg.size() > 0 && statuss.size() > 0) {
				if (statuss.size() == 1 && flg.size() > 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' ");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' ");
					}
					for (int i = 0; i < flg.size(); i++) {
						if (i == 0) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i > 0 && i < flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i == flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "') ");
							continue;
						}

					}
				} else if (statuss.size() > 1 && flg.size() == 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4'  ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
					}
					sf.append(" or d.status='" + statuss.get(0) + "') ");
				} else if (statuss.size() == 1 && flg.size() == 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' ");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' ");
					}
					sf.append(" or o.fitting_flag='" + flg.get(0) + "') ");
				} else if (statuss.size() > 1 && flg.size() > 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ) ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' )");
								continue;
							}

						}
					}
				}
			} else if (flg.size() == 0 && statuss.size() > 0) {
				if (statuss.size() == 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' )");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' )");
					}
				} else if (statuss.size() > 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ) ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "') ");
								continue;
							}

						}
					}
				}
			} else {
				sf.append(" and d.status='100' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("employeNames"))) {// 服务工程师
			String[] emps = ((map.get("employeNames").toString())).split(",");
			sf.append(" and ( ");
			/*for (int i = 0; i < emps.length; i++) {
				if (i == 0) {
					sf.append(" o.employe_name like '%" + emps[i] + "%' ");
				} else {
					sf.append(" or o.employe_name like '%" + emps[i] + "%' ");
				}
			}*/
			for (int i = 0; i < emps.length; i++) {
				if (i == 0) {
					sf.append(" o.employe_name like '%" + emps[i] + "%' ");
				} else {
					sf.append(" or o.employe_name like '%" + emps[i] + "%' ");
				}
			}
			sf.append(" ) ");
			// sf.append(" and o.employe_name = '"+( map.get("employeNames"))+"' ");
		}
		if (StringUtil.checkParamsValid(map.get("whetherCollection"))) {// 交款
			sf.append(" and o.whether_collection = '" + (map.get("whetherCollection")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("returnCard"))) {// 交单
			String returnCard = (String) map.get("returnCard");
			Object fromWxgdListQuery = map.get("__WXGDList");
			if (fromWxgdListQuery == null) {
				if (!"1".equals(returnCard)) {
					sf.append(" and (o.return_card in ('0','2') or o.return_card is null) and o.status in('3','4','5') ");
				} else {
					sf.append(" and o.return_card = '1' and o.status in('3','4','5') ");
				}
			} else {
				if (!"1".equals(returnCard)) {
					sf.append(" and (o.return_card in ('0','2') or o.return_card is null) ");
				} else {
					sf.append(" and o.return_card = '1' ");
				}
			}
		}

		if (StringUtil.checkParamsValid(map.get("repairTimeMin"))) {
			if (((String) map.get("repairTimeMin")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			} else {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + " 00:00:00'  ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMax"))) {
			if (((String) map.get("repairTimeMax")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			} else {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + " 23:59:59' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {// 接入时间
			sf.append(" and o.create_time >= '" + (map.get("createTimeMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and o.create_time <= '" + (map.get("createTimeMax")) + " 23:59:59' ");
		}

		if (StringUtil.checkParamsValid(map.get("dispatchTimeMin"))) {// 派工时间
			sf.append(" and cod.dispatch_time >= '" + (map.get("dispatchTimeMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMax"))) {
			sf.append(" and cod.dispatch_time <= '" + (map.get("dispatchTimeMax")) + " 23:59:59' ");
		}

		if (StringUtil.checkParamsValid(map.get("endTimeMin"))) {
			sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMax"))) {
			sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + " 23:59:59'  ");
		}
		if (StringUtil.checkParamsValid(map.get("recordDateMin"))) {// 录单时间
			sf.append(" and o.record_account_time >= '" + (map.get("recordDateMin")) + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("recordDateMax"))) {
			sf.append(" and o.record_account_time <= '" + (map.get("recordDateMax")) + " 23:59:59' ");
		}
		if (StringUtil.checkParamsValid(map.get("elictrictyBarcode"))) {
			sf.append(" and ( o.appliance_barcode like '%" + (map.get("elictrictyBarcode")) + "%' or o.appliance_machine_code like '%" + (map.get("elictrictyBarcode")) + "%' )  ");
		}
		if (StringUtil.checkParamsValid(map.get("applianceModel"))) {
			sf.append(" and  o.appliance_model like '%" + (map.get("applianceModel")) + "%'   ");
		}
		if (StringUtil.checkParamsValid(map.get("signType"))) {
			String str[] = map.get("signType").toString().split(",");
			sf.append(" and o.flag in (" + StringUtil.joinInSql(str) + ")");
		}

		return sf.toString();
	}

	// 服务中工单预警
	public Map<String, Object> getManufactorEfficiency(String siteId) {

		StringBuilder sb = new StringBuilder("");

		sb.append(" SELECT  ");
		sb.append(
				" COUNT(CASE WHEN ( a.status IN ('2')  AND (UNIX_TIMESTAMP(NOW()) - 24*60*60)<UNIX_TIMESTAMP(a.create_time) AND UNIX_TIMESTAMP(a.create_time) < (UNIX_TIMESTAMP(NOW()) - 20*60*60)) THEN 1 END) AS 'ov20', ");
		sb.append(
				" COUNT(CASE WHEN (  a.status IN ('2')  AND (UNIX_TIMESTAMP(NOW()) - 24*60*60*2)<UNIX_TIMESTAMP(a.create_time)   AND UNIX_TIMESTAMP(a.create_time) < (UNIX_TIMESTAMP(NOW()) - 24*60*60)) THEN 1 END) AS 'ov24', ");
		sb.append(
				" COUNT(CASE WHEN (  a.status IN ('2')  AND (UNIX_TIMESTAMP(NOW()) - 24*60*60*3)<UNIX_TIMESTAMP(a.create_time)  AND UNIX_TIMESTAMP(a.create_time) < (UNIX_TIMESTAMP(NOW()) - 24*60*60*2)) THEN 1 END) AS 'ov48', ");
		sb.append(" COUNT(CASE WHEN (  a.status IN ('2')  AND UNIX_TIMESTAMP(a.create_time) < (UNIX_TIMESTAMP(NOW()) - 24*60*60*3)) THEN 1 END) AS 'ov72', ");
		sb.append("  COUNT(CASE WHEN (  a.status IN ('2')  AND UNIX_TIMESTAMP(a.create_time) < (UNIX_TIMESTAMP(NOW()) - 20*60*60)) THEN 1 END) AS 'whole'  ");
		sb.append(" FROM   ");
		sb.append(" crm_order a  ");
		sb.append(" WHERE a.site_id = ?  AND a.status= '2' ");
		Record rds = Db.findFirst(sb.toString(), siteId);
		if (rds != null) {
			return rds.getColumns();
		}
		return null;
	}

	// 查询工单来源
	public List<Record> getOrderType() {
		String sql = "SELECT a.id,a.name FROM crm_order_type a WHERE a.status='0' ";
		List<Record> rds = Db.find(sql);

		return rds;
	}

	public List<Record> getOrderFeedbackRecords(String orderId, String siteId) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from crm_order_feedback a where a.order_id = ? and a.site_id = ? order by a.feedback_time desc ");
		return Db.find(sb.toString(), orderId, siteId);
	}

	public List<Record> getOrderFeedbackRecords2017(String orderId, String siteId) {
		String table = tableSplitMapper.mapOrderFeedback(siteId);
		if (table == null) {
			return null;
		}

		StringBuilder sb = new StringBuilder();
		sb.append(" select * from " + table + " a where a.order_id = ? and a.site_id = ? order by a.feedback_time desc ");
		return Db.find(sb.toString(), orderId, siteId);
	}

	public Map<String, Object> getDealProcessDetail(Order old, Order news, String processDetail) {
		String editMark = "0";// 修改痕迹标记
		Map<String, Object> map = new HashMap<>();
		String name = CrmUtils.getUserXM();
		String strs = "";
		Date dt = new Date();
		String str = processDetail;// 原本的过程信息
		// 保修类型
		if (!(old.getWarrantyType() == null ? "" : old.getWarrantyType()).equals(news.getWarrantyType())) {// 保修类型前后不一致
			String type = ("2".equals(news.getWarrantyType())) ? "保外" : (("1".equals(news.getWarrantyType())) ? "保内" : "");
			String type1 = ("2".equals(old.getWarrantyType())) ? "保外" : (("1".equals(old.getWarrantyType())) ? "保内" : "");
			strs = name + "修改保修类型为" + type + "，原保修类型为" + type1;
			str = returnDetail(str, dt, name, strs, Target.SITE_EDIT_WARRANTY_TYPE);
			editMark = "1";
		}
		// 修改厂家工单编号
		if ("1".equals(old.getRecordAccount())) {// 曾经录过单才会有修改厂家工单编号的可能性
			if (!old.getFactoryNumber().equals(news.getFactoryNumber())) {// 厂家工单编号被修改时，生成明细信息
				String content = name + "修改厂家工单编号为" + news.getFactoryNumber() + "，原厂家工单编号为" + old.getFactoryNumber();
				if (StringUtils.isNotBlank(strs)) {
					strs = strs + "；" + content;
				} else {
					strs = content;
				}
				str = returnDetail(str, dt, name, content, Target.SITE_EDIT_RECORD_ACCOUNT_TYPE);
				editMark = "1";
			}
		}
		// 修改备注
		if (StringUtils.isNotBlank(old.getRemarks()) || StringUtils.isNotBlank(news.getRemarks())) {// 备注信息修改前后均不为空的前提下
			if (!(old.getRemarks() == null ? "" : old.getRemarks()).equals(news.getRemarks())) {// 前后工单
				String marks1 = StringUtils.isBlank(old.getRemarks()) ? "" : old.getRemarks();
				String marks2 = StringUtils.isBlank(news.getRemarks()) ? "" : news.getRemarks();
				String content = name + "修改备注为“" + marks2 + "”，原备注为“" + marks1 + "”";
				if (StringUtils.isNotBlank(strs)) {
					strs = strs + "；" + content;
				} else {
					strs = content;
				}
				str = returnDetail(str, dt, name, content, Target.SITE_EDIT_EDIT_MARK_TYPE);
				editMark = "1";
			}
		}
		map.put("processDetail", str);
		map.put("latestProcess", strs);
		map.put("latestDate", dt);
		map.put("editMark", editMark);
		return map;
	}

	public String returnDetail(String oldDetail, Date dt, String name, String content, int type) {
		Target ta = new Target();
		ta.setName(name);
		ta.setType(type);
		ta.setContent(content);
		ta.setTime(DateToStringUtils.DateToStringParam1(dt));
		return WebPageFunUtils.appendProcessDetail(ta, oldDetail);
	}

	public void updateDpgOrder(Order order) {
		Record oldOrderRd = Db.findFirst("select * from crm_order a where a.id=?", order.getId());
		StringBuilder sql = new StringBuilder();
		sql.append("update crm_order o set ");

		if (StringUtils.isNotBlank(order.getEmployeId())) {
			sql.append("o.employe_id = '").append(order.getEmployeId()).append("',o.employe_name = '").append(order.getEmployeName()).append("',");
		}

		sql.append("o.service_type = ?, o.origin = ?,o.please_refer_mall=?,");
		sql.append("o.customer_name = ?,o.customer_mobile=?,o.customer_telephone=?,o.customer_telephone2 = ?,");
		sql.append("o.customer_address = ?,o.appliance_brand=?,o.appliance_category=?,");
		sql.append("o.promise_time= ?,o.promise_limit = ?,o.customer_feedback = ?,");
		sql.append("o.remarks=?,o.appliance_model=?,o.appliance_barcode = ?,o.appliance_machine_code=?,");
		sql.append("o.appliance_buy_time=?,o.warranty_type=?,o.appliance_num=?,o.level=?,o.service_mode = ?,o.province = ?,o.city = ?,o.area = ?,o.customer_type=?,o.bd_imgs=?  ");

		// String mark = "1";
		Order oldOrder = get(order.getId());
		List<Object> list = Lists.newArrayList();
		list.add(order.getServiceType());
		list.add(order.getOrigin());
		list.add(order.getPleaseReferMall());
		list.add(order.getCustomerName());
		list.add(order.getCustomerMobile());
		list.add(order.getCustomerTelephone());
		list.add(order.getCustomerTelephone2());
		list.add(order.getCustomerAddress());
		list.add(order.getApplianceBrand());
		list.add(order.getApplianceCategory());
		list.add(order.getPromiseTime());
		list.add(order.getPromiseLimit());
		list.add(order.getCustomerFeedback());
		list.add(order.getRemarks());
		list.add(order.getApplianceModel());
		list.add(order.getApplianceBarcode());
		list.add(order.getApplianceMachineCode());
		list.add(order.getApplianceBuyTime());
		list.add(order.getWarrantyType());
		list.add(order.getApplianceNum());
		list.add(order.getLevel());
		list.add(order.getServiceMode());
		list.add(order.getProvince());
		list.add(order.getCity());
		list.add(order.getArea());
		list.add(order.getCustomerType());
		list.add(order.getBdImgs());

		String oldPromiseTime = "";
		String newPromiseTime = "";
		if (order.getPromiseTime() != null) {
			if (oldOrderRd.get("promise_time") != null) {
				try {
					oldPromiseTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(oldOrderRd.getDate("promise_time"));
				} catch (Exception e) {
				}
			}
		} else {
			oldPromiseTime = "";
		}
		String oldPromiseLimit = oldOrderRd.getStr("promise_limit");
		if (order.getPromiseTime() != null) {
			try {
				newPromiseTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(order.getPromiseTime());
			} catch (Exception e) {
			}
		} else {
			newPromiseTime = "";
		}

		String newPromiseLimit = order.getPromiseLimit();
		if (oldPromiseLimit == null) {
			oldPromiseLimit = "";
		}

		if (newPromiseLimit == null) {
			newPromiseLimit = "";
		}
		String customer_mobile = "";
		String customer_telephone = "";
		String customer_telephone2 = "";
		if (StringUtil.isNotBlank(oldOrderRd.getStr("customer_mobile"))) {
			customer_mobile = oldOrderRd.getStr("customer_mobile");
		}
		if (StringUtil.isNotBlank(oldOrderRd.getStr("customer_telephone"))) {
			customer_telephone = oldOrderRd.getStr("customer_telephone");
		}
		if (StringUtil.isNotBlank(oldOrderRd.getStr("customer_telephone2"))) {
			customer_telephone2 = oldOrderRd.getStr("customer_telephone2");
		}
		String latestProcess = "";
		// Date processTime=rd.getDate("latest_process_time");
		// String processDetail=rd.getStr("process_detail");
		List<Target> taList = new ArrayList<>();
		String processDetail = oldOrderRd.getStr("process_detail");
		String yhMsg = "0";
		if (StringUtils.isNotBlank(oldPromiseTime) || StringUtils.isNotBlank(newPromiseTime) || StringUtils.isNotBlank(newPromiseLimit)
				|| StringUtils.isNotBlank(oldPromiseLimit)) {
			if (!oldPromiseTime.equals(newPromiseTime) || !newPromiseLimit.equals(oldPromiseLimit)) {
				String name = CrmUtils.getUserXM();
				// processTime = new Date();
				latestProcess = name + "修改预约时间为" + newPromiseTime + " " + newPromiseLimit + ",原预约时间为" + oldPromiseTime + " " + oldPromiseLimit;
				Target ta1 = new Target();
				ta1.setName(name);
				ta1.setContent(latestProcess);
				ta1.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				ta1.setType(Target.MODIFY_YY_TIME);
				yhMsg = "1";
				taList.add(ta1);
				processDetail = WebPageFunUtils.appendProcessDetail(ta1, oldOrderRd.getStr("process_detail"));
			}
		}
		if ((!customer_mobile.equals(order.getCustomerMobile())) || (!customer_telephone.equals(order.getCustomerTelephone()))
				|| (!customer_telephone2.equals(order.getCustomerTelephone2()))) {
			String name = CrmUtils.getUserXM();
			// processTime = new Date();
			StringBuilder latestProcessBf = new StringBuilder();
			latestProcessBf.append(name);
			latestProcessBf.append("修改用户联系方式为：");
			if (!customer_mobile.equals(order.getCustomerMobile())) {
				latestProcessBf.append(order.getCustomerMobile());
				latestProcessBf.append("  ");
			}
			if (!customer_telephone.equals(order.getCustomerTelephone())) {
				latestProcessBf.append(order.getCustomerTelephone());
				latestProcessBf.append("  ");
			}
			if (!customer_telephone2.equals(order.getCustomerTelephone2())) {
				latestProcessBf.append(order.getCustomerTelephone2());
				latestProcessBf.append("  ");
			}
			latestProcessBf.append(",原用户联系方式为：");
			if (!customer_mobile.equals(order.getCustomerMobile())) {
				latestProcessBf.append(customer_mobile);
				latestProcessBf.append("  ");
			}
			if (!customer_telephone.equals(order.getCustomerTelephone())) {
				latestProcessBf.append(customer_telephone);
				latestProcessBf.append("  ");
			}
			if (!customer_telephone2.equals(order.getCustomerTelephone2())) {
				latestProcessBf.append(customer_telephone2);
				latestProcessBf.append("  ");
			}
			if (StringUtils.isNotBlank(latestProcess)) {
				latestProcess = latestProcess + "," + latestProcessBf.toString();
			} else {
				latestProcess = latestProcessBf.toString();
			}
			Target ta2 = new Target();
			ta2.setName(name);
			ta2.setContent(latestProcess);
			ta2.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			ta2.setType(Target.MODIFY_YHMSG);
			yhMsg = "1";
			taList.add(ta2);
			processDetail = WebPageFunUtils.appendProcessDetail(ta2, processDetail);

		}
		// processDetail = WebPageFunUtils.appendProcessDetails(taList,
		// oldOrderRd.getStr("process_detail"));
		// String strs = oldOrder.getProcessDetail();//获取之前的过程信息
		Map<String, Object> map = getDealProcessDetail(oldOrder, order, processDetail);
		String processDetails = map.get("processDetail") == null ? "" : map.get("processDetail").toString();// 最终的过程信息
		String editMks = map.get("editMark").toString();// editMark=='1',则表示有修改痕迹
		String latestPrs = map.get("latestProcess") == null ? "" : map.get("latestProcess").toString();// 修改保修类型，录单编号，备注信息的最近信息
		if ("0".equals(yhMsg) && "0".equals(editMks)) {

		} else {
			sql.append(" , o.latest_process=? , o.latest_process_time=? , o.process_detail=?  ");
			if ("1".equals(yhMsg) && "1".equals(editMks)) {// 都有修改过
				latestProcess = latestProcess + "," + latestPrs;
			}
			if ("0".equals(yhMsg) && "1".equals(editMks)) {//
				latestProcess = latestPrs;
			}
			list.add(latestProcess);
			list.add(new Date());
			list.add(processDetails);
		}

		if ("1".equals(oldOrder.getRecordAccount())) {// 曾经录过单
			if (!oldOrder.getFactoryNumber().equals(order.getFactoryNumber())) {
				// mark = "2";
				sql.append(" ,o.record_account_time=now(),o.factory_number=? ");
				list.add(order.getFactoryNumber());
			}
		}
		sql.append(" where id=?");
		// if ("2".equals(mark)) {
		// list.add(order.getFactoryNumber());
		// }
		list.add(order.getId());

		try {
			Db.update(sql.toString(), list.toArray());
			updateFittingOrder(order);
		} catch (Exception ex) {
			StringBuilder sb = new StringBuilder();
			sb.append("[");
			for (Object o : list) {
				sb.append(o).append(",");
			}
			sb.append("].list.size=");
			sb.append(list.size()).append("/");
			sb.append(sql.toString());
			logger.error("UPD DPG order failed, error=" + sb.toString());
			throw ex;
		}
		flush();
	}

	public Record getOrderTabCount(String tab, String siteId, List<String> cateList, List<String> brandList) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select ");
		if ("dpg".equals(tab)) {
			sb.append("  COUNT(CASE WHEN (a.status IN ('1','7') ) THEN 1 END) AS 'c1', ");
			sb.append(" COUNT(CASE WHEN ( a.status IN ('7')) THEN 1 END) AS 'c2', ");
			sb.append("  COUNT(CASE WHEN ( SELECT COUNT(*) FROM crm_order_dispatch cem WHERE cem.order_id in (a.id) AND cem.status='3') THEN 1 END) AS 'c3', ");
			sb.append("  COUNT(CASE WHEN ( a.promise_time = CURDATE() ) THEN 1 END) AS 'c4'  ");
		} else if ("wxz".equals(tab)) {
			sb.append("  COUNT(CASE WHEN (a.status IN ('2') ) THEN 1 END) AS 'c1', ");
			// COUNT(CASE WHEN b.status = '1' and a.status IN ('2') THEN 1 END) AS djd,
			sb.append("  COUNT(CASE WHEN b.status = '1' and a.status IN ('2') THEN 1 END) AS 'c2',	");
			sb.append("  COUNT(CASE WHEN ( (UNIX_TIMESTAMP(NOW()) - 20*60*60)>UNIX_TIMESTAMP(a.create_time) ) THEN 1 END) AS 'c3' , ");
			sb.append("  COUNT(CASE WHEN ( a.fitting_flag IN ('1','2','5','6')) THEN 1 END) AS 'c4' ");
		} else if ("dhj".equals(tab)) {
			sb.append("   COUNT(CASE WHEN (a.status IN ('3','4') ) THEN 1 END) AS 'c1', ");
			sb.append("   COUNT(CASE WHEN ( a.status IN ('3')) THEN 1 END) AS 'c2',		");
			sb.append("   COUNT(CASE WHEN ( a.status IN ('4')) THEN 1 END) AS 'c3' , ");
			sb.append("   COUNT(CASE WHEN ( a.status IN ('4')) THEN 1 END) AS 'c4' ");
		} else if ("lsgd".equals(tab)) {
			sb.append("   COUNT(CASE WHEN (a.status IN ('5','8') ) THEN 1 END) AS 'c1', ");
			sb.append("   COUNT(CASE WHEN ( a.status IN ('5')) THEN 1 END) AS 'c2',		");
			sb.append("   COUNT(CASE WHEN ( a.status IN ('8')) THEN 1 END) AS 'c3' , ");
			sb.append("   COUNT(CASE WHEN ( a.status IN ('8')) THEN 1 END) AS 'c4' ");
		}
		sb.append(" from " + getTableWhenTabCount(cateList, brandList, siteId));
		sb.append(" left join crm_order_dispatch b ");
		sb.append(" on b.order_id = a.id and b.status not in ('3', '6', '7') and b.site_id = '" + siteId + "'");
		sb.append(" where a.site_id = ?  ");
		if ("dpg".equals(tab)) {
			sb.append("  AND a.status IN ('1', '7') ");
		} else if ("wxz".equals(tab)) {
			sb.append("  AND a.status ='2' ");
		} else if ("dhj".equals(tab)) {
			sb.append("  AND a.status IN ('3','4')  ");
		} else if ("lsgd".equals(tab)) {
			sb.append("  AND a.status IN ('5','8')  ");
		}
		if (cateList != null) {
			sb.append(" AND a.appliance_category in (" + StringUtil.joinInSqlforllist(cateList) + ") ");
		}
		if (brandList != null) {
			sb.append(" AND a.appliance_brand in (" + StringUtil.joinInSqlforllist(brandList) + ") ");
		}
		return Db.findFirst(sb.toString(), siteId);
	}

	public List<Order> getByDispatchId(String[] dispArr, String siteId) {
		return find(" from Order a where a.id in (" + SqlKit.joinInSql(Arrays.asList(dispArr)) + ") and a.status != '6' and a.siteId = :p1 ", new Parameter(siteId));
	}

	public List<Order> getByOrderIds(String ids) {
		return find(" from Order a where a.id in (" + StringUtil.joinInSql(ids.split(",")) + ") ");
	}

	public List<Record> getPjMsg(String orderId, String siteId, String remark) {
		StringBuffer sql = new StringBuffer();

		if ("SYMsg".equals(remark)) {
			sql.append("select a.fitting_code,a.fitting_version,a.fitting_name,a.used_num,a.status,a.used_time,a.collection_money");
			sql.append(" from crm_site_fitting_used_record a where a.order_id= '" + orderId + "' and a.site_id= '" + siteId + "' and a.type = '1'  ");// type = 1 表示工单使用
		} else if ("SQMsg".equals(remark)) {
			sql.append("select a.fitting_code,a.fitting_version,a.fitting_name,a.fitting_img,a.status,a.fitting_apply_num,a.create_time");
			sql.append(" from crm_site_fitting_apply a where a.order_id= '" + orderId + "' and a.site_id= '" + siteId + "'  ");
			sql.append(" and a.status <> '5' and a.status <> '6' and a.status <> '7' ");
		}

		return Db.find(sql.toString());
	}

	public Long getPjMsg1(String orderId, String siteId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) ");
		sql.append(" from crm_site_fitting_apply a where a.order_id= '" + orderId + "' and a.site_id= '" + siteId + "'  ");
		sql.append(" and a.status in('0','1') ");
		return Db.queryLong(sql.toString());
	}

	public Order getOrderByNumber(String number, String siteId) {
		List<Order> list = getOrdersByNumber(number, siteId);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Order getValidOrderByNumber(String number, String siteId) {
		Query query = getSession().createQuery("from Order where number=:number and siteId=:sid and status in(:vs)");
		query.setParameter("number", number);
		query.setParameter("sid", siteId);
		query.setParameterList("vs", Arrays.asList("0", "1", "2", "3", "4", "5"));
		List list = query.list();
		return list.size() > 0 ? (Order) list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrdersByNumber(String number, String siteId) {
		Query query = getSession().createQuery("from Order where number=:number and siteId=:sid");
		query.setParameter("number", number);
		query.setParameter("sid", siteId);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrderByNumber(List<String> numbers, String siteId) {
		Query query = getSession().createQuery("from Order where number in (:number) and siteId=:sid");
		query.setParameterList("number", numbers);
		query.setParameter("sid", siteId);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrderById(List<String> ids) {
		Query query = getSession().createQuery("from Order where id in (:ids)");
		query.setParameterList("ids", ids);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrderByIdAndStatus(List<String> ids) {
		Query query = getSession().createQuery("from Order where id in (:ids) and parentStatus in('1','6','7') ");
		query.setParameterList("ids", ids);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrderByIdAndStsZp(List<String> ids) {
		Query query = getSession().createQuery("from Order where id in (:ids) and parentStatus in('2') ");
		query.setParameterList("ids", ids);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrderByIdZjfd(List<String> ids) {
		Query query = getSession().createQuery("from Order where id in (:ids) and parentStatus in('1','2','6','7') ");
		query.setParameterList("ids", ids);
		return query.list();
	}

	public List<Order> getOrderById(String[] ids) {
		return getOrderById(Arrays.asList(ids));
	}

	public boolean isOrderExists(String number, String siteId) {
		return getOrderByNumber(number, siteId) != null;
	}

	public boolean isOrderExists(List<String> numbers, String siteId) {
		List<Order> orders = getOrderByNumber(numbers, siteId);
		return orders != null && orders.size() > 0;
	}

	public String getorderNumById(String orderId, String siteId) {
		String sql = "SELECT number FROM crm_order WHERE site_id='" + siteId + "' AND id='" + orderId + "'";
		return Db.queryStr(sql);
	}

	public Order getrecord(Record rd) {
		return getrecord(rd, formatter);
	}

	public void notifyFactoryOrderComplete(Order order, String siteId, List<Target> targets) {
		if (!"7".equals(order.getOrderType())) {
			throw new IllegalArgumentException("order must come for micro factory");
		}

		Map<String, Object> params = new HashMap<>();
		params.put("number", order.getNumber());
		params.put("siteId", siteId);
		if (targets.size() > 0) {
			params.put("target", new Gson().toJson(targets, new TypeToken<List<Target>>() {
			}.getType()));
		}
		Result<Map<String, Object>> ret = ezTemplate.postForm("/notifyFactoryOrderComplete", params, new ParameterizedTypeReference<Result<Map<String, Object>>>() {
		});
		if (!"200".equals(ret.getCode())) {
			throw new RuntimeException("notify factory order status failed");
		}
	}

	public static Order getrecord(Record rd, DateFormat fmt) {
		Order or = new Order();
		if (rd != null) {
			or.setId(rd.getStr("id"));
			or.setApplianceBarcode(rd.getStr("appliance_barcode"));
			or.setApplianceBrand(rd.getStr("appliance_brand"));
			or.setApplianceBuyTime(rd.getDate("appliance_buy_time"));
			or.setApplianceCategory(rd.getStr("appliance_category"));
			// or.setApplianceInnCode(rd.getStr("appliance_inn_code"));//家电内机编号
			// or.setApplianceInvoice(rd.getStr("appliance_invoice"));//家电发票图片地址
			or.setApplianceModel(rd.getStr("appliance_model"));
			// or.setApplianceOutCode(rd.getStr("appliance_out_code"));//家电外机编号
			or.setCreateBy(rd.getStr("create_by"));
			or.setCreateTime(rd.getDate("create_time"));
			or.setRepairTime(rd.getDate("repair_time"));
			or.setApplianceMachineCode(rd.getStr("appliance_machine_code"));
			if (rd.getDate("create_time") != null) {
				or.setCreateTime(rd.getDate("create_time"));
			}
			or.setCustomerAddress(rd.getStr("customer_address"));
			or.setCustomerFeedback(rd.getStr("customer_feedback"));
			or.setCustomerLnglat(rd.getStr("customer_lnglat"));
			or.setCustomerMobile(rd.getStr("customer_mobile"));
			or.setCustomerName(rd.getStr("customer_name"));
			or.setCustomerTelephone(rd.getStr("customer_telephone"));
			or.setCustomerType(rd.getStr("customer_type"));
			or.setEmployeId(rd.getStr("employe_id"));
			or.setEmployeName(rd.getStr("employe_name"));
			or.setLevel(rd.getStr("level"));
			or.setMalfunctionType(rd.getStr("malfunction_type"));
			or.setMessengerId(rd.getStr("messenger_id"));
			or.setMessengerName(rd.getStr("messenger_name"));
			or.setNumber(rd.getStr("number"));
			or.setOrigin(rd.getStr("origin"));
			// or.setSource(rd.getStr("source"));//二级来源
			or.setPromiseLimit(rd.getStr("promise_limit"));
			or.setPromiseTime(rd.getDate("promise_time"));
			or.setRemarks(rd.getStr("remarks"));
			// or.setRepairType(rd.getStr("repair_type"));//施工类型: 1.维修 2.安装 3.咨询 4.保养 5.工程
			// 6.其他
			or.setServiceMode(rd.getStr("service_mode"));
			or.setServiceType(rd.getStr("service_type"));
			or.setSiteId(rd.getStr("site_id"));
			or.setSiteName(rd.getStr("site_name"));
			or.setStatus(rd.getStr("status"));
			// or.setUpdateBy(rd.getStr("update_by"));//更新操作人user_id
			or.setUpdateName(rd.getStr("update_name"));// 更新操作人姓名
			or.setUpdateTime(rd.getDate("update_time"));
			// or.setWhetherToRead(rd.getStr("whether_to_read"));//是否查看
			or.setReturnCard(rd.getStr("return_card"));
			// or.setMachineModel(rd.getStr("machine_model"));//标记工单
			or.setWhetherCollection(rd.getStr("whether_collection"));
			// or.setInvalid(rd.getStr("invalid"));
			or.setCanoper(rd.getStr("canoper"));
			or.setWarrantyType(rd.getStr("warranty_type"));

			BigDecimal sg = new BigDecimal(Double.valueOf(rd.getBigDecimal("auxiliary_cost").toEngineeringString()));
			or.setAuxiliaryCost(Double.valueOf(rd.getBigDecimal("auxiliary_cost").toEngineeringString()));
			or.setWarrantyCost(Double.valueOf(rd.getBigDecimal("warranty_cost").toEngineeringString()));
			or.setServeCost(Double.valueOf(rd.getBigDecimal("serve_cost").toEngineeringString()));
			or.setConfirmCost(Double.valueOf(rd.getBigDecimal("confirm_cost").toEngineeringString()));

			or.setProvince(rd.getStr("province"));
			or.setCity(rd.getStr("city"));
			or.setArea(rd.getStr("area"));
		}
		return or;
	}

	// 查询是否有相似工单
	public Record getOrderMobile(Order or, String siteId) {
		String sql = "";
		String dataOne = "";
		String dataTwo = "";
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT a.* ,b.id AS setId FROM crm_order a  ");
		sf.append(" LEFT JOIN crm_order_settlement b ON a.id=b.order_id ");
		sf.append(" WHERE a.site_id='" + siteId + "' AND a.customer_mobile='" + or.getCustomerMobile() + "' ");
		if (StringUtils.isBlank(or.getApplianceMachineCode()) && StringUtils.isNotEmpty(or.getApplianceBarcode())) {
			sf.append(" and (a.appliance_barcode = ? or a.appliance_machine_code = ?) ");
			dataOne = or.getApplianceBarcode();
			dataTwo = or.getApplianceBarcode();
		}
		if (StringUtils.isBlank(or.getApplianceBarcode()) && StringUtils.isNotBlank(or.getApplianceMachineCode())) {
			sf.append(" and (a.appliance_machine_code = ? or a.appliance_barcode = ?) ");
			dataOne = or.getApplianceMachineCode();
			dataTwo = or.getApplianceMachineCode();
		}
		if (StringUtils.isNotBlank(or.getApplianceMachineCode()) && StringUtils.isNotEmpty(or.getApplianceBarcode())) {
			sf.append(" and (a.appliance_barcode = ? or a.appliance_machine_code = ?) ");
			dataOne = or.getApplianceBarcode();
			dataTwo = or.getApplianceMachineCode();
		}
		sf.append(" AND a.create_time BETWEEN DATE_SUB('" + or.getCreateTime() + "', INTERVAL 30 DAY) AND DATE_ADD('" + or.getCreateTime() + "', INTERVAL 30 DAY) ");
		sf.append(" AND a.id !='" + or.getId() + "' AND a.status in ('0','1','2','3','4','5','7') ");
		sf.append(" ORDER BY a.create_time DESC   LIMIT 1 ");
		sql = sf.toString();
		try {
			if (StringUtils.isBlank(or.getApplianceMachineCode()) && StringUtils.isEmpty(or.getApplianceBarcode())) {
				return Db.findFirst(sf.toString());
			}
			return Db.findFirst(sf.toString(), dataOne, dataTwo);
		} catch (Exception e) {
			logger.error("get order mobile error, sql=" + sql + ";", e);
			throw e;
		}
	}

	// 2017工单中查询是否有相似工单
	public Record getOrder2017Mobile(HistoryBkOrder or, String siteId) {
		String orderTable =  tableSplitMapper.mapOrder(siteId);
		if (orderTable == null) {
			return null;
		}

		String sql = "";
		String dataOne = "";
		String dataTwo = "";
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT a.* ,b.id AS setId FROM " + orderTable + " a  ");
		sf.append(" LEFT JOIN crm_order_settlement b ON a.id=b.order_id ");
		sf.append(" WHERE a.site_id='" + siteId + "' AND a.customer_mobile='" + or.getCustomerMobile() + "' ");
		if (StringUtils.isBlank(or.getApplianceMachineCode()) && StringUtils.isNotEmpty(or.getApplianceBarcode())) {
			sf.append(" and (a.appliance_barcode = ? or a.appliance_machine_code = ?) ");
			dataOne = or.getApplianceBarcode();
			dataTwo = or.getApplianceBarcode();
		}
		if (StringUtils.isBlank(or.getApplianceBarcode()) && StringUtils.isNotBlank(or.getApplianceMachineCode())) {
			sf.append(" and (a.appliance_machine_code = ? or a.appliance_barcode = ?) ");
			dataOne = or.getApplianceMachineCode();
			dataTwo = or.getApplianceMachineCode();
		}
		if (StringUtils.isNotBlank(or.getApplianceMachineCode()) && StringUtils.isNotEmpty(or.getApplianceBarcode())) {
			sf.append(" and (a.appliance_barcode = ? or a.appliance_machine_code = ?) ");
			dataOne = or.getApplianceBarcode();
			dataTwo = or.getApplianceMachineCode();
		}
		sf.append(" AND a.create_time BETWEEN DATE_SUB('" + or.getCreateTime() + "', INTERVAL 30 DAY) AND DATE_ADD('" + or.getCreateTime() + "', INTERVAL 30 DAY) ");
		sf.append(" AND a.id !='" + or.getId() + "' AND a.status in ('0','1','2','3','4','5','7') ");
		sf.append(" ORDER BY a.create_time DESC   LIMIT 1 ");
		sql = sf.toString();
		try {
			if (StringUtils.isBlank(or.getApplianceMachineCode()) && StringUtils.isEmpty(or.getApplianceBarcode())) {
				return Db.findFirst(sf.toString());
			}
			return Db.findFirst(sf.toString(), dataOne, dataTwo);
		} catch (Exception e) {
			logger.error("get order mobile error, sql=" + sql + ";", e);
			throw e;
		}
	}

	// 全部、待派工查询条件
	public String getOrderWholeCondition(Map<String, Object> map, String siteId, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		// 小程序中使用
		if (StringUtil.checkParamsValid(map.get("ordernumberMobile"))) {
			sf.append(" and (o.customer_mobile like '%" + (map.get("ordernumberMobile")) + "%' or o.customer_telephone like '%" + map.get("ordernumberMobile")
					+ "%' or o.customer_telephone2 like '%" + map.get("ordernumberMobile") + "%' or o.number like '%" + (map.get("ordernumberMobile")) + "%') ");
		}

		if (StringUtil.checkParamsValid(map.get("customerType"))) {// 用户类型
			sf.append(" and o.customer_type like '%" + (map.get("customerType")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("number"))) {// 工单编号
			sf.append(" and o.number like '%" + (map.get("number")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("factorynumber"))) {// 厂家工单编号
			sf.append(" and o.factory_number like '%" + (map.get("factorynumber")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("pleaseReferMall"))) {// 购机商场
			sf.append(" and o.please_refer_mall like '%" + (map.get("pleaseReferMall")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("review"))) {
			sf.append(" and o.review = '" + (map.get("review")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("recordAccount"))) {// 是否录单
			sf.append(" and o.record_account = '" + (map.get("recordAccount")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerName"))) {
			sf.append(" and o.customer_name like '%" + (map.get("customerName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerMobile"))) {
			String mobile = (String) map.get("customerMobile");
			if (mobile.trim().length() == 11 && mobile.startsWith("1")) {
				sf.append(String.format(" and (o.customer_mobile='%s' or o.customer_telephone='%s' or o.customer_telephone2='%s') ", mobile, mobile, mobile));
			} else {
				sf.append(" and (o.customer_mobile like '%" + (map.get("customerMobile")) + "%' or o.customer_telephone like '%" + map.get("customerMobile")
						+ "%' or o.customer_telephone2 like '%" + map.get("customerMobile") + "%') ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("customerAddress"))) {
			sf.append(" and concat_ws('',o.area,o.customer_address) like '%" + (map.get("customerAddress")) + "%' ");
		}

		if (!CrmUtils.isSite()) {
				if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
					String cate[] = ((map.get("applianceCategory").toString())).split(",");
					sf.append(" and ( ");
					if(StringUtils.isBlank(cate[0]))  {
						String[] temp = deleteFirst(cate);
						cate = temp;
					}
					for(int i=0;i<cate.length;i++) {
						if(StringUtils.isNotBlank(cate[i])) {
							if (i == 0) {
								sf.append(" o.appliance_category like '%" + cate[i] + "%' ");
							} else {
								sf.append(" or o.appliance_category like '%" + cate[i] + "%' ");
							}
						}
					}
					sf.append(" ) ");
					//sf.append(" and o.appliance_category='" + (map.get("applianceCategory")) + "' ");
				} else if (cateList != null) {
					sf.append(" and o.appliance_category in (" + StringUtil.joinInSqlforllist(cateList) + ") ");
				}

				if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
					String brand[] = ((map.get("applianceBrands").toString())).split(",");
					sf.append(" and ( ");
					if(StringUtils.isBlank(brand[0]))  {
						String[] temp = deleteFirst(brand);
						brand = temp;
					}
					for(int i=0;i<brand.length;i++) {
						if(i==0) {
							sf.append(" o.appliance_brand='" + brand[i] + "' ");
						}else {
							sf.append(" or o.appliance_brand='" + brand[i] + "' ");
						}
					}
					sf.append(" ) ");
				} else  if (brandList != null){
					sf.append(" and o.appliance_brand in (" + StringUtil.joinInSqlforllist(brandList) + ") ");
				}

		} else {
			if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
				String brand[] = ((map.get("applianceBrands").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(i==0) {
						sf.append(" o.appliance_brand='" + brand[i] + "' ");
					}else {
						sf.append(" or o.appliance_brand='" + brand[i] + "' ");
					}
				}
				sf.append(" ) ");
			}
			if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
				String brand[] = ((map.get("applianceCategory").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(StringUtils.isNotBlank(brand[i])) {
						if (i == 0) {
							sf.append(" o.appliance_category like '%" + brand[i] + "%' ");
						} else {
							sf.append(" or o.appliance_category like '%" + brand[i] + "%' ");
						}
					}
				}
				sf.append(" ) ");
				//sf.append(" and o.appliance_category like '%" + (map.get("applianceCategory")) + "%' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("serviceType"))) {
			sf.append(" and o.service_type = '" + (map.get("serviceType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("origin"))) {
			sf.append(" and o.origin = '" + (map.get("origin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("orderType"))) {
			sf.append(" and o.order_type = '" + (map.get("orderType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("remarks"))) {
			sf.append(" and o.remarks  like '%" + (map.get("remarks")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("warrantyType"))) {
			sf.append(" and o.warranty_type = '" + (map.get("warrantyType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("promiseTime"))) {
			sf.append(" and o.promise_time = '" + (map.get("promiseTime")) + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("level"))) {
			sf.append(" and o.level = '" + (map.get("level")) + "' ");
		}
		if (StringUtil.checkParamsValid((map.get("messengerName")))) {// 登记人
			SqlKit kit = new SqlKit().append("and exists(").append("select 1 from (").append("select user_id as id, name from crm_site").append("union all")
					.append("select user_id as id, name from crm_non_serviceman")
					.append("union all")
					.append("select user_id as id, name from crm_employe where site_id='" + siteId + "'")
					.append(") as t")
					.append("where t.id=o.create_by and  t.name like '%" + map.get("messengerName") + "%'").append(")");

			sf.append(" ").append(kit.toString());
		}
		if (StringUtil.checkParamsValid((map.get("serviceMode")))) {//
			sf.append(" and o.service_mode like '%" + (map.get("serviceMode")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("statuss"))) {
			String[] status = ((map.get("statuss").toString())).split(",");
			if (status.length > 0) {
				sf.append(" and o.status in (" + StringUtil.joinInSql(status) + ") ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("secondSite"))) {
			String[] secondSites = ((map.get("secondSite").toString())).split(",");
			if (secondSites.length > 0) {
				sf.append(" and o.site_id in (" + StringUtil.joinInSql(secondSites) + ") ");
			}
		}
		// 工单收费
		if (StringUtil.checkParamsValid(map.get("ifReceipt"))) {
			if ("0".equals(map.get("ifReceipt"))) {// 收费的工单
				sf.append(" and (serve_cost >0 or auxiliary_cost>0 or warranty_cost>0) ");
			} else {// 未收费的工单
				sf.append(" and (serve_cost <=0 and auxiliary_cost<=0 and warranty_cost<=0) ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("statusFlag"))) {// 工单状态
			String stat[] = ((map.get("statusFlag").toString())).split(",");
			List<String> flg = Lists.newArrayList();// 待备件/缺件中 fintting_flag字段
			List<String> statuss = Lists.newArrayList();// status字段
			for (int i = 0; i < stat.length; i++) {
				if (stat[i].equals("1")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("2")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("4")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("5")) {
					flg.add(stat[i]);
				} else if (stat[i].equals("6")) {
					flg.add(stat[i]);
				}
			}
			for (int k = 0; k < flg.size(); k++) {
				if (flg.get(k).equals("5")) {
					flg.set(k, "1");
				} else if (flg.get(k).equals("6")) {
					flg.set(k, "2");
				}
			}
			if (flg.size() > 0 && statuss.size() == 0) {// 只有fintting_flag
				if (flg.size() == 1) {
					sf.append(" and o.fitting_flag='" + flg.get(0) + "' ");
				} else if (flg.size() > 1) {
					for (int i = 0; i < flg.size(); i++) {
						if (i == 0) {
							sf.append(" and (o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i > 0 && i < flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i == flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "') ");
							continue;
						}

					}
				}
			} else if (flg.size() > 0 && statuss.size() > 0) {
				if (statuss.size() == 1 && flg.size() > 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' ");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' ");
					}
					for (int i = 0; i < flg.size(); i++) {
						if (i == 0) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i > 0 && i < flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i == flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "') ");
							continue;
						}

					}
				} else if (statuss.size() > 1 && flg.size() == 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4'  ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
					}
					sf.append(" or d.status='" + statuss.get(0) + "') ");
				} else if (statuss.size() == 1 && flg.size() == 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' ");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' ");
					}
					sf.append(" or o.fitting_flag='" + flg.get(0) + "') ");
				} else if (statuss.size() > 1 && flg.size() > 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ) ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' )");
								continue;
							}

						}
					}
				}
			} else if (flg.size() == 0 && statuss.size() > 0) {
				if (statuss.size() == 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' )");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' )");
					}
				} else if (statuss.size() > 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ) ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "') ");
								continue;
							}

						}
					}
				}
			} else {
				sf.append(" and d.status='100' ");
			}

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
		if (StringUtil.checkParamsValid(map.get("whetherCollection"))) {// 交款
			sf.append(" and o.whether_collection = '" + (map.get("whetherCollection")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("returnCard"))) {// 交单
			String returnCard = (String) map.get("returnCard");
			Object fromWxgdListQuery = map.get("__WXGDList");
			if (fromWxgdListQuery == null) {
				if (!"1".equals(returnCard)) {
					sf.append(" and (o.return_card in ('0','2') or o.return_card is null) and o.status in('3','4','5') ");
				} else {
					sf.append(" and o.return_card = '1' and o.status in('3','4','5') ");
				}
			} else {
				if (!"1".equals(returnCard)) {
					sf.append(" and (o.return_card in ('0','2') or o.return_card is null) and o.status in('5','8')");
				} else {
					sf.append(" and o.return_card = '1' and o.status in('5','8') ");
				}
			}
		}

		if (StringUtil.checkParamsValid(map.get("repairTimeMin"))) {// 报修时间
//			if (((String) map.get("repairTimeMin")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("repairTimeMin")).matches()) {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			} else {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMax"))) {
//			if (((String) map.get("repairTimeMax")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("repairTimeMax")).matches()) {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			} else {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {// 接入时间
			sf.append(" and o.create_time >= '" + (map.get("createTimeMin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and o.create_time <= '" + (map.get("createTimeMax")) + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("dispatchTimeMin"))) {// 派工时间
//			if (((String) map.get("dispatchTimeMin")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("dispatchTimeMin")).matches()) {
				sf.append(" and cod.dispatch_time >= '" + (map.get("dispatchTimeMin")) + "' ");
			} else {
				sf.append(" and cod.dispatch_time >= '" + (map.get("dispatchTimeMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMax"))) {
//			if (((String) map.get("dispatchTimeMax")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("dispatchTimeMax")).matches()) {
				sf.append(" and cod.dispatch_time <= '" + (map.get("dispatchTimeMax")) + "' ");
			} else {
				sf.append(" and cod.dispatch_time <= '" + (map.get("dispatchTimeMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("alertDateMin"))) {// 标记时间
			if (RegexUtil.DATE.matcher((String) map.get("alertDateMin")).matches()) {
				sf.append(" and o.flag_alert_date >= '" + (map.get("alertDateMin")) + "' ");
			} else {
				sf.append(" and o.flag_alert_date >= '" + (map.get("alertDateMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("alertDateMax"))) {
			if (RegexUtil.DATE.matcher((String) map.get("alertDateMax")).matches()) {
				sf.append(" and o.flag_alert_date <= '" + (map.get("alertDateMax")) + "' ");
			} else {
				sf.append(" and o.flag_alert_date <= '" + (map.get("alertDateMax")) + "' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("endTimeMin"))) {
			if (RegexUtil.DATE.matcher((String) map.get("endTimeMin")).matches()) {
				sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + "' ");
			} else {
				sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMax"))) {
			if (RegexUtil.DATE.matcher((String) map.get("endTimeMax")).matches()) {
				sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + "' ");
			} else {
				sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("recordDateMin"))) {// 标记时间
			if (RegexUtil.DATE.matcher((String) map.get("recordDateMin")).matches()) {
				sf.append(" and o.record_account_time >= '" + (map.get("recordDateMin")) + "' ");
			} else {
				sf.append(" and o.record_account_time >= '" + (map.get("recordDateMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("recordDateMax"))) {
			if (RegexUtil.DATE.matcher((String) map.get("recordDateMax")).matches()) {
				sf.append(" and o.record_account_time <= '" + (map.get("recordDateMax")) + "' ");
			} else {
				sf.append(" and o.record_account_time <= '" + (map.get("recordDateMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("elictrictyBarcode"))) {
			sf.append(" and ( o.appliance_barcode like '%" + (map.get("elictrictyBarcode")) + "%' or o.appliance_machine_code like '%" + (map.get("elictrictyBarcode")) + "%' )  ");
		}
		if (StringUtil.checkParamsValid(map.get("applianceModel"))) {
			sf.append(" and  o.appliance_model like '%" + (map.get("applianceModel")) + "%'   ");
		}
		if (StringUtil.checkParamsValid(map.get("signType"))) {
			String str[] = map.get("signType").toString().split(",");
			sf.append(" and o.flag in (" + StringUtil.joinInSql(str) + ")");
		}

		if (StringUtil.checkParamsValid(map.get("isPrintSrue"))) {
			Integer num = Integer.parseInt(map.get("isPrintSrue").toString());
			if (num == 0) {
				sf.append(" and o.print_times=0 ");
			} else {
				sf.append(" and o.print_times != 0 ");
			}
		}

		return sf.toString();
	}


	// 全部工单查询条件
	public String getRealOrderWholeCondition(Map<String, Object> map, String siteId, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		// 小程序中使用
		if (StringUtil.checkParamsValid(map.get("ordernumberMobile"))) {
			sf.append(" and (o.customer_mobile like '%" + (map.get("ordernumberMobile")) + "%' or o.customer_telephone like '%" + map.get("ordernumberMobile")
					+ "%' or o.customer_telephone2 like '%" + map.get("ordernumberMobile") + "%' or o.number like '%" + (map.get("ordernumberMobile")) + "%') ");
		}

		if (StringUtil.checkParamsValid(map.get("customerType"))) {// 用户类型
			sf.append(" and o.customer_type like '%" + (map.get("customerType")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("number"))) {// 工单编号
			sf.append(" and o.number like '%" + (map.get("number")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("factorynumber"))) {// 厂家工单编号
			sf.append(" and o.factory_number like '%" + (map.get("factorynumber")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("pleaseReferMall"))) {// 购机商场
			sf.append(" and o.please_refer_mall like '%" + (map.get("pleaseReferMall")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("review"))) {
			sf.append(" and o.review = '" + (map.get("review")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("recordAccount"))) {// 是否录单
			sf.append(" and o.record_account = '" + (map.get("recordAccount")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerName"))) {
			sf.append(" and o.customer_name like '%" + (map.get("customerName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("customerMobile"))) {
			String mobile = (String) map.get("customerMobile");
			if (mobile.trim().length() == 11 && mobile.startsWith("1")) {
				sf.append(String.format(" and (o.customer_mobile='%s' or o.customer_telephone='%s' or o.customer_telephone2='%s') ", mobile, mobile, mobile));
			} else {
				sf.append(" and (o.customer_mobile like '%" + (map.get("customerMobile")) + "%' or o.customer_telephone like '%" + map.get("customerMobile")
						+ "%' or o.customer_telephone2 like '%" + map.get("customerMobile") + "%') ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("customerAddress"))) {
			sf.append(" and concat_ws('',o.area,o.customer_address) like '%" + (map.get("customerAddress")) + "%' ");
		}

		if (!CrmUtils.isSite()) {
			if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
				String cate[] = ((map.get("applianceCategory").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(cate[0]))  {
					String[] temp = deleteFirst(cate);
					cate = temp;
				}
				for(int i=0;i<cate.length;i++) {
					if(StringUtils.isNotBlank(cate[i])) {
						if (i == 0) {
							sf.append(" o.appliance_category like '%" + cate[i] + "%' ");
						} else {
							sf.append(" or o.appliance_category like '%" + cate[i] + "%' ");
						}
					}
				}
				sf.append(" ) ");
				//sf.append(" and o.appliance_category='" + (map.get("applianceCategory")) + "' ");
			} else if (cateList != null) {
				sf.append(" and o.appliance_category in (" + StringUtil.joinInSqlforllist(cateList) + ") ");
			}

			if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
				String brand[] = ((map.get("applianceBrands").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(i==0) {
						sf.append(" o.appliance_brand='" + brand[i] + "' ");
					}else {
						sf.append(" or o.appliance_brand='" + brand[i] + "' ");
					}
				}
				sf.append(" ) ");
			} else  if (brandList != null){
				sf.append(" and o.appliance_brand in (" + StringUtil.joinInSqlforllist(brandList) + ") ");
			}

		} else {
			if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
				String brand[] = ((map.get("applianceBrands").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(i==0) {
						sf.append(" o.appliance_brand='" + brand[i] + "' ");
					}else {
						sf.append(" or o.appliance_brand='" + brand[i] + "' ");
					}
				}
				sf.append(" ) ");
			}
			if (StringUtil.checkParamsValid(map.get("applianceCategory"))) {
				String brand[] = ((map.get("applianceCategory").toString())).split(",");
				sf.append(" and ( ");
				if(StringUtils.isBlank(brand[0]))  {
					String[] temp = deleteFirst(brand);
					brand = temp;
				}
				for(int i=0;i<brand.length;i++) {
					if(StringUtils.isNotBlank(brand[i])) {
						if (i == 0) {
							sf.append(" o.appliance_category like '%" + brand[i] + "%' ");
						} else {
							sf.append(" or o.appliance_category like '%" + brand[i] + "%' ");
						}
					}
				}
				sf.append(" ) ");
				//sf.append(" and o.appliance_category like '%" + (map.get("applianceCategory")) + "%' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("serviceType"))) {
			sf.append(" and o.service_type = '" + (map.get("serviceType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("origin"))) {
			sf.append(" and o.origin = '" + (map.get("origin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("orderType"))) {
			sf.append(" and o.order_type = '" + (map.get("orderType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("remarks"))) {
			sf.append(" and o.remarks  like '%" + (map.get("remarks")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("warrantyType"))) {
			sf.append(" and o.warranty_type = '" + (map.get("warrantyType")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("promiseTime"))) {
			sf.append(" and o.promise_time = '" + (map.get("promiseTime")) + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("level"))) {
			sf.append(" and o.level = '" + (map.get("level")) + "' ");
		}
		if (StringUtil.checkParamsValid((map.get("messengerName")))) {// 登记人
			SqlKit kit = new SqlKit().append("and exists(").append("select 1 from (").append("select user_id as id, name from crm_site").append("union all")
					.append("select user_id as id, name from crm_non_serviceman")
					.append("union all")
					.append("select user_id as id, name from crm_employe where site_id='" + siteId + "'")
					.append(") as t")
					.append("where t.id=o.create_by and  t.name like '%" + map.get("messengerName") + "%'").append(")");

			sf.append(" ").append(kit.toString());
		}
		if (StringUtil.checkParamsValid((map.get("serviceMode")))) {//
			sf.append(" and o.service_mode like '%" + (map.get("serviceMode")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("statuss"))) {
			String[] status = ((map.get("statuss").toString())).split(",");
			if (status.length > 0) {
				sf.append(" and o.status in (" + StringUtil.joinInSql(status) + ") ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("secondSite"))) {
			String[] secondSites = ((map.get("secondSite").toString())).split(",");
			if (secondSites.length > 0) {
				sf.append(" and o.site_id in (" + StringUtil.joinInSql(secondSites) + ") ");
			}
		}
		// 工单收费
		if (StringUtil.checkParamsValid(map.get("ifReceipt"))) {
			if ("0".equals(map.get("ifReceipt"))) {// 收费的工单
				sf.append(" and (serve_cost >0 or auxiliary_cost>0 or warranty_cost>0) ");
			} else {// 未收费的工单
				sf.append(" and (serve_cost <=0 and auxiliary_cost<=0 and warranty_cost<=0) ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("statusFlag"))) {// 工单状态
			String stat[] = ((map.get("statusFlag").toString())).split(",");
			List<String> flg = Lists.newArrayList();// 待备件/缺件中 fintting_flag字段
			List<String> statuss = Lists.newArrayList();// status字段
			for (int i = 0; i < stat.length; i++) {
				if (stat[i].equals("1")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("2")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("4")) {
					statuss.add(stat[i]);
				} else if (stat[i].equals("5")) {
					flg.add(stat[i]);
				} else if (stat[i].equals("6")) {
					flg.add(stat[i]);
				}
			}
			for (int k = 0; k < flg.size(); k++) {
				if (flg.get(k).equals("5")) {
					flg.set(k, "1");
				} else if (flg.get(k).equals("6")) {
					flg.set(k, "2");
				}
			}
			if (flg.size() > 0 && statuss.size() == 0) {// 只有fintting_flag
				if (flg.size() == 1) {
					sf.append(" and o.fitting_flag='" + flg.get(0) + "' ");
				} else if (flg.size() > 1) {
					for (int i = 0; i < flg.size(); i++) {
						if (i == 0) {
							sf.append(" and (o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i > 0 && i < flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i == flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "') ");
							continue;
						}

					}
				}
			} else if (flg.size() > 0 && statuss.size() > 0) {
				if (statuss.size() == 1 && flg.size() > 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' ");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' ");
					}
					for (int i = 0; i < flg.size(); i++) {
						if (i == 0) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i > 0 && i < flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "' ");
							continue;
						} else if (i == flg.size() - 1) {
							sf.append(" or o.fitting_flag='" + flg.get(i) + "') ");
							continue;
						}

					}
				} else if (statuss.size() > 1 && flg.size() == 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4'  ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
					}
					sf.append(" or d.status='" + statuss.get(0) + "') ");
				} else if (statuss.size() == 1 && flg.size() == 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' ");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' ");
					}
					sf.append(" or o.fitting_flag='" + flg.get(0) + "') ");
				} else if (statuss.size() > 1 && flg.size() > 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ) ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' )");
								continue;
							}

						}
					}
				}
			} else if (flg.size() == 0 && statuss.size() > 0) {
				if (statuss.size() == 1) {
					if (statuss.get(0).equals("4")) {
						sf.append(" and (d.status = '4' )");
					} else {
						sf.append(" and (d.status='" + statuss.get(0) + "' )");
					}
				} else if (statuss.size() > 1) {
					for (int j = 0; j < statuss.size(); j++) {
						if (j == 0) {
							if (statuss.get(j).equals("4")) {
								sf.append(" and (d.status = '4' ");
								continue;
							} else {
								sf.append(" and (d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j > 0 && j < (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "' ");
								continue;
							}
						}
						if (j == (statuss.size() - 1)) {
							if (statuss.get(j).equals("4")) {
								sf.append(" or d.status = '4' ) ");
								continue;
							} else {
								sf.append(" or d.status='" + statuss.get(j) + "') ");
								continue;
							}

						}
					}
				}
			} else {
				sf.append(" and d.status='100' ");
			}

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
		if (StringUtil.checkParamsValid(map.get("whetherCollection"))) {// 交款
			sf.append(" and o.whether_collection = '" + (map.get("whetherCollection")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("returnCard"))) {// 交单
			String returnCard = (String) map.get("returnCard");
			Object fromWxgdListQuery = map.get("__WXGDList");
			if (fromWxgdListQuery == null) {
				if (!"1".equals(returnCard)) {
					sf.append(" and (o.return_card in ('0','2') or o.return_card is null) and o.status in('3','4','5') ");
				} else {
					sf.append(" and o.return_card = '1' and o.status in('3','4','5') ");
				}
			} else {
				if (!"1".equals(returnCard)) {
					sf.append(" and (o.return_card in ('0','2') or o.return_card is null) and o.status in('5','8')");
				} else {
					sf.append(" and o.return_card = '1' and o.status in('5','8') ");
				}
			}
		}

		if (StringUtil.checkParamsValid(map.get("repairTimeMin"))) {// 报修时间
//			if (((String) map.get("repairTimeMin")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("repairTimeMin")).matches()) {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			} else {
				sf.append(" and o.repair_time >= '" + (map.get("repairTimeMin")) + "'  ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("repairTimeMax"))) {
//			if (((String) map.get("repairTimeMax")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("repairTimeMax")).matches()) {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			} else {
				sf.append(" and o.repair_time <= '" + (map.get("repairTimeMax")) + "' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {// 接入时间
			sf.append(" and o.create_time >= '" + (map.get("createTimeMin")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and o.create_time <= '" + (map.get("createTimeMax")) + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("dispatchTimeMin"))) {// 派工时间
//			if (((String) map.get("dispatchTimeMin")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("dispatchTimeMin")).matches()) {
				sf.append(" and o.dispatch_time >= '" + (map.get("dispatchTimeMin")) + "' ");
			} else {
				sf.append(" and o.dispatch_time >= '" + (map.get("dispatchTimeMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("dispatchTimeMax"))) {
//			if (((String) map.get("dispatchTimeMax")).matches("^(\\d{4})-([0-1]\\d)-([0-3]\\d)\\s([0-5]\\d):([0-5]\\d):([0-5]\\d)$")) {
			if (RegexUtil.DATE.matcher((String) map.get("dispatchTimeMax")).matches()) {
				sf.append(" and o.dispatch_time <= '" + (map.get("dispatchTimeMax")) + "' ");
			} else {
				sf.append(" and o.dispatch_time <= '" + (map.get("dispatchTimeMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("alertDateMin"))) {// 标记时间
			if (RegexUtil.DATE.matcher((String) map.get("alertDateMin")).matches()) {
				sf.append(" and o.flag_alert_date >= '" + (map.get("alertDateMin")) + "' ");
			} else {
				sf.append(" and o.flag_alert_date >= '" + (map.get("alertDateMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("alertDateMax"))) {
			if (RegexUtil.DATE.matcher((String) map.get("alertDateMax")).matches()) {
				sf.append(" and o.flag_alert_date <= '" + (map.get("alertDateMax")) + "' ");
			} else {
				sf.append(" and o.flag_alert_date <= '" + (map.get("alertDateMax")) + "' ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("endTimeMin"))) {
			if (RegexUtil.DATE.matcher((String) map.get("endTimeMin")).matches()) {
				sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + "' ");
			} else {
				sf.append(" and o.end_time >= '" + (map.get("endTimeMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("endTimeMax"))) {
			if (RegexUtil.DATE.matcher((String) map.get("endTimeMax")).matches()) {
				sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + "' ");
			} else {
				sf.append(" and o.end_time <= '" + (map.get("endTimeMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("recordDateMin"))) {// 标记时间
			if (RegexUtil.DATE.matcher((String) map.get("recordDateMin")).matches()) {
				sf.append(" and o.record_account_time >= '" + (map.get("recordDateMin")) + "' ");
			} else {
				sf.append(" and o.record_account_time >= '" + (map.get("recordDateMin")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("recordDateMax"))) {
			if (RegexUtil.DATE.matcher((String) map.get("recordDateMax")).matches()) {
				sf.append(" and o.record_account_time <= '" + (map.get("recordDateMax")) + "' ");
			} else {
				sf.append(" and o.record_account_time <= '" + (map.get("recordDateMax")) + "' ");
			}
		}
		if (StringUtil.checkParamsValid(map.get("elictrictyBarcode"))) {
			sf.append(" and ( o.appliance_barcode like '%" + (map.get("elictrictyBarcode")) + "%' or o.appliance_machine_code like '%" + (map.get("elictrictyBarcode")) + "%' )  ");
		}
		if (StringUtil.checkParamsValid(map.get("applianceModel"))) {
			sf.append(" and  o.appliance_model like '%" + (map.get("applianceModel")) + "%'   ");
		}
		if (StringUtil.checkParamsValid(map.get("signType"))) {
			String str[] = map.get("signType").toString().split(",");
			sf.append(" and o.flag in (" + StringUtil.joinInSql(str) + ")");
		}

		if (StringUtil.checkParamsValid(map.get("isPrintSrue"))) {
			Integer num = Integer.parseInt(map.get("isPrintSrue").toString());
			if (num == 0) {
				sf.append(" and o.print_times=0 ");
			} else {
				sf.append(" and o.print_times != 0 ");
			}
		}

		return sf.toString();
	}
	
	 static String[] deleteFirst(String[] arr) {
		 String[] temp = new String[arr.length - 1];
	        System.arraycopy(arr, 1, temp, 0, temp.length);
	        return temp;
	    }

	// 快捷搜索工单信息
	public List<Record> getorderListQuick(String siteId, String comp, String type) {
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT a.*,CONCAT_WS('',a.province,a.city,a.area,a.customer_address) as customerAddressDetail FROM crm_order a ");
		if ("1".equals(type)) {
			// 根据手机号码
			sf.append(" WHERE a.site_id='" + siteId + "' AND (a.customer_mobile='" + comp + "' OR a.customer_telephone='" + comp + "' OR a.customer_telephone2='" + comp + "') ");
		} else {
			sf.append(" WHERE a.site_id='" + siteId + "' AND (a.number ='" + comp + "') ");
		}
		return Db.find(sf.toString());
	}

	// 快捷搜索2017年工单信息
	public List<Record> getorderHistoryListQuick(String siteId, String comp, String type) {
		String orderTable =  tableSplitMapper.mapOrder(siteId);
	
		if (orderTable == null ) {
			return new ArrayList<>();
		}

		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT a.*,CONCAT_WS('',a.province,a.city,a.area,a.customer_address) as customerAddressDetail FROM " + orderTable + " a ");
		if ("1".equals(type)) {
			sf.append(" WHERE a.site_id='" + siteId + "' AND (a.customer_mobile='" + comp + "' OR a.customer_telephone='" + comp + "' OR a.customer_telephone2='" + comp + "') ");
		} else {
			sf.append(" WHERE a.site_id='" + siteId + "' AND (a.number ='" + comp + "') ");
		}
		return Db.find(sf.toString());
	}

	// 今日提醒标记工单列表
	public List<Record> getOrderJrtxbjList(Page<Record> page, String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail, cb.service_attitude, cod.dispatch_time, cod.id as dispId,cod.`status` as disp_status,cod.completion_result as completion_result,  ");
		sf.append("(SELECT f.name FROM `crm_order_mark_settings` AS f WHERE f.`id`=o.`flag`) AS flag,");
		sf.append("(SELECT f.feedback FROM `crm_order_feedback` AS f WHERE f.`order_id`=o.`id` ORDER BY f.feedback_time DESC LIMIT 1) AS feedresult FROM crm_order o ");
		sf.append(" left join crm_order_callback cb on cb.order_id = o.id and cb.site_id = '" + siteId + "' ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5') ");
		//sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' ");
		sf.append(" WHERE o.site_id=? and TO_DAYS(o.flag_alert_date) = TO_DAYS(NOW()) ");
		sf.append(" and o.status<>'9' ");
		if (status == null) {
			status = "";
		}
		String[] statusx = null;
		if (StringUtil.isNotBlank(status)) {
			statusx = status.split(",");
		}
		if (statusx != null && statusx.length > 0) {
			sf.append(" AND o.status IN (" + StringUtil.joinInSql(statusx) + ") ");
		}

		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC"));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(), siteId);
	}

	// 今日提醒标记工单条数
	public long getOrderJrtxbjCount(String siteId, String status, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5')");
		//sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' ");
		sf.append(" WHERE o.site_id=? and TO_DAYS(o.flag_alert_date) = TO_DAYS(NOW()) ");
		if (status == null) {
			status = "";
		}
		String[] statusx = null;
		if (StringUtil.isNotBlank(status)) {
			statusx = status.split(",");
		}
		if (statusx != null && statusx.length > 0) {
			sf.append(" AND o.status IN (" + StringUtil.joinInSql(statusx) + ") ");
		}

		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		return Db.queryLong(sf.toString(), siteId);
	}

	/**
	 * 指定的工单编号是否可以标记为无效工单，回访、结算和已完成工单不能标记为无效。
	 * 
	 * @param orderIds
	 *            待标记的工单
	 */
	public String canMarkAsInvalid(String[] orderIds) {
		HashSet<String> set = new HashSet<>();
		set.add("3");
		set.add("4");
		set.add("5");
		List<Order> orders = getOrderById(orderIds);
		for (Order order : orders) {
			if (set.contains(order.getStatus())) {
				return "N";
			} else if ("7".equals(order.getOrderType())) {
				// 来自小厂家系统的工单是不可以置为无效的
				return "NN";
			}
		}
		return "Y";
	}

	/**
	 * 工程师是否有尚未结算的工单。
	 */
	public boolean hasWaitCallbackAndSettlementOrders(String empId) {
		SqlKit kit = new SqlKit().append("SELECT * FROM crm_order AS o").append("INNER JOIN crm_order_dispatch AS d").append("ON o.id=d.`order_id` AND d.`status`='5'")
				.append("INNER JOIN `crm_order_dispatch_employe_rel` AS r").append("ON r.`dispatch_id`=d.`id` AND d.`employe_id`=?").append("WHERE o.`status` IN('3','4')")
				.append("LIMIT 1");

		return Db.findFirst(kit.toString(), empId) != null;
	}

	/**
	 * 二级网点处理中工单
	 */
	public List<Record> getOrderWaitDeal(Page<Record> page, String siteId, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail,e.name as secSiteName,d.dispatch_time,d.drop_in_time,d.id as disorderId FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id and d.status in('1','2','4') ");
		sf.append(" left join crm_site e on e.id=o.site_id ");
		sf.append(" WHERE o.site_id in (" + siteId + ")");
		sf.append(" AND (o.parent_status = '3' or o.status in ('2','1') ) ");
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC  "));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	/**
	 * 二级网点处理中工单数量
	 */
	public long getOrderWaitDealCount(String siteId, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch d on d.order_id= o.id and d.status in('1','2','4') ");
		// sf.append(" WHERE o.parent_site_id=? AND o.parent_dipatch_flag IN('1','2')
		// AND o.parent_status = '3' ");
		sf.append(" WHERE o.site_id in (" + siteId + ")");
		sf.append(" AND (o.parent_status = '3' or o.status in ('2','1') ) ");
		sf.append(getOrderCondition(map, cateList, brandList,siteId));
		return Db.queryLong(sf.toString());
	}

	/**
	 * 二级网点待回访工单数据
	 */
	public List<Record> getOrderWaitCallBack(Page<Record> page, String siteId, String sites, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail,e.name as secSiteName, cb.service_attitude, cod.dispatch_time, cod.id as dispId,cod.`status` as disp_status, cod.completion_result as completion_result,  ");
		sf.append(" concat(cuscom.star, '星(' , cuscom.content, ')') as customer_comment, ");
		sf.append("(SELECT f.feedback FROM `crm_order_feedback` AS f WHERE f.`order_id`=o.`id` ORDER BY f.feedback_time DESC LIMIT 1) AS feedresult FROM crm_order o ");
		sf.append(" left join crm_order_callback cb on cb.order_id = o.id and cb.site_id = '" + siteId + "' ");
		sf.append(" left join crm_site e on e.id=o.site_id ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5') ");
		sf.append(" left join crm_customer_order_comment cuscom on cuscom.order_id = o.id ");
		sf.append(" WHERE o.site_id in (" + sites + ")");
		sf.append(" AND (o.parent_status = '4' or o.status in('3','4') ) ");
		// sf.append(" WHERE o.parent_site_id=? ");
		/*
		 * sf.append(" AND o.status <> '9' ");
		 * sf.append(" AND  o.parent_status ='4'  ");
		 */
		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC"));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	/**
	 * 二级网点待回访工单数量
	 */
	public long getOrderWaitCallBackCount(String siteId, String sites, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5')");
		sf.append(" WHERE o.site_id in (" + sites + ")");
		sf.append(" AND (o.parent_status = '4' or o.status in('3','4') ) ");
		/*
		 * sf.append(" WHERE o.parent_site_id=?  ");
		 * sf.append(" AND  o.parent_status ='4' ");
		 */
		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		return Db.queryLong(sf.toString());
	}

	/**
	 * 二级网点已回访工单数据
	 */
	public List<Record> getOrderHadCallBack(Page<Record> page, String siteId, String sites, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT o.*,CONCAT_WS('',o.province,o.city,o.area,o.customer_address) as customerAddressDetail,e.name as secSiteName, cb.service_attitude, cod.dispatch_time, cod.id as dispId,cod.`status` as disp_status, cod.completion_result as completion_result,  ");
		sf.append(" concat(cuscom.star, '星(' , cuscom.content, ')') as customer_comment, ");
		sf.append("(SELECT f.feedback FROM `crm_order_feedback` AS f WHERE f.`order_id`=o.`id` ORDER BY f.feedback_time DESC LIMIT 1) AS feedresult FROM crm_order o ");
		sf.append(" left join crm_order_callback cb on cb.order_id = o.id and cb.site_id = '" + siteId + "' ");
		sf.append(" left join crm_site e on e.id=o.site_id ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5') ");
		sf.append(" left join crm_customer_order_comment cuscom on cuscom.order_id = o.id ");
		sf.append(" WHERE o.site_id in (" + sites + ")");
		sf.append(" AND (o.parent_status in('5','8') or o.status in('5','4') ) ");
		/*
		 * sf.append(" WHERE o.parent_site_id=? "); sf.append(" AND o.status <> '9' ");
		 */
		// sf.append(" AND o.parent_status in('5','8') ");
		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(createOrderBy(map, " ORDER BY o.create_time DESC"));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	/**
	 * 二级网点已回访工单数量,领导要求将取消工单也显示在已回访列表中。
	 */
	public long getOrderHadCallBackCount(String siteId, String sites, Map<String, Object> map, List<String> cateList, List<String> brandList) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5')");
		/*
		 * sf.append(" WHERE o.parent_site_id=?  ");
		 * sf.append(" AND  o.parent_status in('5','8') ");
		 */
		sf.append(" WHERE o.site_id in (" + sites + ")");
		sf.append(" AND (o.parent_status in('5','8') or o.status in('5','4') ) ");
		sf.append(getOrderWholeCondition(map, siteId, cateList, brandList));
		return Db.queryLong(sf.toString());
	}

	public String canBatchCopy(String[] ids) {
		List<Order> orders = getOrderById(Arrays.asList(ids));
		for (Order o : orders) {
			if (!"1".equals(o.getStatus())) {
				return "422"; // 批量复制的工单必须是待派工
			} else if (StringUtil.isNotBlank(o.getParentSiteId())) {
				return "423"; // 一级网点派工的工单不可以批量复制
			}
		}
		return "200";
	}

	/**
	 * 平台工单统计
	 * 
	 * @param siteId
	 * @return
	 */
	public Map<String, Long> getPlatformCount(String siteId, String origin) {
		Map<String, Long> map = Maps.newHashMap();
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT  COUNT( CASE WHEN TO_DAYS(a.repair_time)=TO_DAYS(NOW()) THEN 0 END ) AS jrCount ,   ");
		sb.append("   COUNT( CASE WHEN a.`status` ='0' THEN 0 END ) AS djsCount , ");
		sb.append(
				"   COUNT( CASE WHEN a.`status` IN ('1','2','0') AND a.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND a.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) THEN 0 END ) AS 20hCount,  ");
		sb.append("   COUNT( CASE WHEN a.`status` IN ('1','2','0') AND a.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) THEN 0 END ) AS 24hCount   ");
		sb.append("  FROM crm_order a WHERE a.`site_id` = '" + siteId + "'  AND order_type='7' AND a.origin='" + origin + "' ");
		Record re = Db.findFirst(sb.toString());
		map.put("jrgdCunt", re.getLong("jrCount"));
		map.put("djsCount", re.getLong("djsCount"));
		map.put("tyhCount", re.getLong("20hCount"));
		map.put("tfhCount", re.getLong("24hCount"));
		return map;
	}

	public List<Record> getPlatFormList(Page<Record> page, Map<String, Object> map, String origin, String siteId) {
		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT o.* FROM crm_order o WHERE o.site_id = '" + siteId + "' and o.origin = '" + origin + "' and order_type='7' ");
		sb.append(getOrderCondition(map));
		sb.append(createOrderBy(map, " ORDER BY o.repair_time DESC  "));
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sb.toString());
	}

	public Long getPlatFormListCount(String siteId, Map<String, Object> map, String origin) {
		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT count(*) FROM crm_order o WHERE o.site_id = '" + siteId + "' and o.origin = '" + origin + "' and order_type='7' ");
		sb.append(getOrderCondition(map));
		return Db.queryLong(sb.toString());
	}

	public String getOrderCondition(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (StringUtil.checkParamsValid((CharSequence) map.get("number"))) {// 工单编号
			sf.append(" and o.number like '%" + map.get("number").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("status"))) {// 工单状态
			String statuss[] = map.get("status").toString().split(",");
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

		if (StringUtil.checkParamsValid((CharSequence) map.get("warningType"))) {

			if ("1".equals(map.get("warningType"))) {// 今日工单总数
				sf.append(" and TO_DAYS(o.repair_time)=TO_DAYS(NOW()) ");
			} else if ("2".equals(map.get("warningType"))) {// 待接收
				sf.append(" and o.status ='0' ");
			} else if ("3".equals(map.get("warningType"))) {// 超20h预警
				sf.append(" and o.`status` IN ('1','2','0') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 20 HOUR) AND o.repair_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
			} else if ("4".equals(map.get("warningType"))) {// 超24h预警
				sf.append(" and o.`status` IN ('1','2','0') AND o.repair_time <= DATE_SUB(NOW(), INTERVAL 24 HOUR) ");
			}
		}

		if (StringUtil.checkParamsValid(map.get("applianceBrands"))) {
			String brand[] = ((map.get("applianceBrands").toString())).split(",");
			sf.append(" and ( ");
			if(StringUtils.isBlank(brand[0]))  {
				String[] temp = deleteFirst(brand);
				brand = temp;
			}
			for(int i=0;i<brand.length;i++) {
				if(i==0) {
					sf.append(" o.appliance_brand='" + brand[i] + "' ");
				}else {
					sf.append(" or o.appliance_brand='" + brand[i] + "' ");
				}
			}
			sf.append(" ) ");
			//sf.append(" and o.appliance_brand like '%" + (map.get("applianceBrands")) + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("applianceCategory"))) {// 家电类型
			String brand[] = ((map.get("applianceCategory").toString())).split(",");
			sf.append(" and ( ");
			if(StringUtils.isBlank(brand[0]))  {
				String[] temp = deleteFirst(brand);
				brand = temp;
			}
			for(int i=0;i<brand.length;i++) {
				if(StringUtils.isNotBlank(brand[i])) {
					if (i == 0) {
						sf.append(" o.appliance_category like '%" + brand[i] + "%' ");
					} else {
						sf.append(" or o.appliance_category like '%" + brand[i] + "%' ");
					}
				}
			}
			sf.append(" ) ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("applianceModel"))) {// 家电型号employeName
			sf.append(" and o.appliance_model like '%" + map.get("applianceModel").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("customerName"))) {// 用户姓名
			sf.append(" and o.customer_name like '%" + map.get("customerName").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("customerMobile"))) {// 联系方式
			sf.append(" and (o.customer_mobile like '%" + map.get("customerMobile").toString().trim() + "%' or o.customer_telephone like '%"
					+ map.get("customerMobile").toString().trim() + "%' or o.customer_telephone2 like '%" + map.get("customerMobile").toString().trim() + "%') ");
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
			sf.append(" and o.service_type like '%" + map.get("serviceType").toString().trim() + "%' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) map.get("archive"))) {// 服务类型
			String archive = (String) map.get("archive");
			if ("0".equals(archive)) {
				sf.append(" and (o.repair_record_account is null or repair_record_account='0') ");
			} else {
				sf.append(" and repair_record_account='1' ");
			}
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

	public Record findOrderByIdIfHistory(String orderId, String siteId) {
		Record rd = Db.findFirst("select a.* from crm_order a where a.id=? ", orderId);
		if (rd != null) {
			return rd;
		}
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			rd = Db.findFirst("select a.* from " + table + " a where a.id=? ", orderId);
			return rd;
		}

		return null;
	}

	public Record findOrderByNumberIfHistory(String number, String siteId) {
		Record rd = Db.findFirst("select a.* from crm_order a where a.number=? and a.site_id=? ", number, siteId);
		if (rd != null) {
			return rd;
		}
		String table = tableSplitMapper.mapOrder(siteId);
		if (table != null) {
			rd = Db.findFirst("select a.* from " + table + " a where a.number=? and a.site_id=? ", number, siteId);
			return rd;
		}

		return null;
	}

	/*修改工单信息，同时修改备件申请表和配件使用表工单相关信息
	*/
	public void updateFittingOrder(Order order) {
		String sqlapply = "UPDATE crm_site_fitting_apply SET customer_name = ? , customer_mobile = ? , customer_address = ? , appliance_category =? , appliance_brand = ? , warranty_type = ? , appliance_model =? WHERE order_id=? ";
		String sqluser = " UPDATE crm_site_fitting_used_record SET customer_name = ? , customer_mobile = ? , customer_address = ? , appliance_category = ? , appliance_brand = ?, warranty_type = ? WHERE  order_id=? ";
		Db.update(sqlapply,order.getCustomerName(),order.getCustomerMobile(),order.getCustomerAddress(),order.getApplianceCategory(),order.getApplianceBrand(),order.getWarrantyType(),order.getApplianceModel(),order.getId());
		Db.update(sqluser,order.getCustomerName(),order.getCustomerMobile(),order.getCustomerAddress(),order.getApplianceCategory(),order.getApplianceBrand(),order.getWarrantyType(),order.getId());
		
	}
	
}
