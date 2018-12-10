package com.jojowonet.modules.goods.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.formula.functions.T;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsPlatFormDao;
import com.jojowonet.modules.goods.dao.GoodsPlatFormDetailDao;
import com.jojowonet.modules.goods.dao.GoodsPlatFormOrderDao;
import com.jojowonet.modules.goods.dao.GoodsPlatformTransferOrderDao;
import com.jojowonet.modules.goods.dao.GoodsSiteSelfDao;
import com.jojowonet.modules.goods.dao.GoodsSiteselfDetailDao;
import com.jojowonet.modules.goods.entity.GoodsPlatformDetail;
import com.jojowonet.modules.goods.entity.GoodsPlatformOrder;
import com.jojowonet.modules.goods.entity.GoodsPlatformTransferOrder;
import com.jojowonet.modules.goods.entity.GoodsSiteSelf;
import com.jojowonet.modules.goods.entity.GoodsSiteselfDetail;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.SMSUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class GoodsPlatformTransferOrderService extends BaseService {
	@Autowired
	private GoodsPlatformTransferOrderDao goodsPlatformTransferOrderDao;
	@Autowired
	private GoodsPlatFormDetailDao goodsPlatFormDetailDao;
	@Autowired
	private GoodsSiteSelfDao goodsSiteSelfDao;
	@Autowired
	private GoodsSiteselfDetailDao goodsSiteselfDetailDao;
	@Autowired
	private GoodsPlatFormDao goodsPlatFormDao;
	@Autowired
	private GoodsPlatFormOrderDao goodsPlatformOrderDao;

	public Page<Record> nandaoGrid(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getNandaoList(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}

		Long count = getNanDaoCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	/* 公众号商品订单 */
	public Page<Record> getPublicNumberOrders(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getPublicNumberOrdersList(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}

		Long count = getPublicNumberOrdersCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	/* 公众号商品订单 */
	public Page<Record> getWarrantyOrderPage(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getWarrantyOrderList(page, map);
		Long count = getWarrantyOrderCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	/* 所有平台商品订单 */
	public Page<Record> getAllPlatformOrders(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getAllPlatformList(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}
		Long count = getAllPlatformCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	public List<Record> getAllPlatformOrdersForExport(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getAllPlatformList(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}
		return list;
	}

	public List<Record> getPublicNumberOrdersForExport(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getPublicNumberOrdersList(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}

		return list;
	}

	public String queryConditions(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		if (map != null) {
			if (map.get("number") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("number"))[0])) {
				sf.append(" and a.number like '%" + ((String[]) map.get("number"))[0].trim() + "%' ");
			}
			if (map.get("status") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("status"))[0])) {
				sf.append(" and a.status ='" + ((String[]) map.get("status"))[0].trim() + "' ");
			}
			/* 平台产品订单状态 */
			if (map.get("orderStatus") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("orderStatus"))[0])) {
				sf.append(" and a.status ='" + ((String[]) map.get("orderStatus"))[0].trim() + "' ");
			}
			if (map.get("goodNumber") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("goodNumber"))[0])) {
				sf.append(" and a.good_number like '%" + ((String[]) map.get("goodNumber"))[0].trim() + "%' ");
			}
			if (map.get("paymentType") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("paymentType"))[0])) {
				sf.append(" and a.payment_type = '" + ((String[]) map.get("paymentType"))[0].trim() + "' ");
			}
			if (map.get("placeOrderBy") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("placeOrderBy"))[0])) {
				List<Record> list = Db.find("select a.* from crm_site a where a.name like'%" + ((String[]) map.get("placeOrderBy"))[0].trim() + "%' and a.status='0'");
				if (list.size() > 0) {
					String ids = "";
					for (Record rd : list) {
						if (StringUtils.isNotBlank(rd.getStr("id"))) {
							if ("".equals(ids)) {
								ids = "'" + rd.getStr("id") + "'";
							} else {
								ids = ids + ",'" + rd.getStr("id") + "'";
							}
						}
					}
					if ("".equals(ids)) {
						sf.append(" and a.site_id = '' ");
					} else {
						sf.append(" and a.site_id in (" + ids + ") ");
					}

				} else {
					sf.append(" and a.site_id = '' ");
				}
			}
			if (map.get("goodName") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("goodName"))[0])) {
				sf.append(" and a.good_name like '%" + ((String[]) map.get("goodName"))[0].trim() + "%' ");
			}
			if (map.get("outStockType") != null && StringUtils.isNotEmpty((CharSequence) ((String[]) map.get("outStockType"))[0])) {
				sf.append(" and a.out_stock_type = '" + ((String[]) map.get("outStockType"))[0].trim() + "' ");
			}
			if (map.get("createTimeMin") != null && StringUtils.isNotEmpty(((String[]) map.get("createTimeMin"))[0])) {
				sf.append(" and a.placing_order_time >= '" + ((String[]) map.get("createTimeMin"))[0] + " 00:00:00' ");
			}
			if (map.get("createTimeMax") != null && StringUtils.isNotEmpty(((String[]) map.get("createTimeMax"))[0])) {
				sf.append(" and a.placing_order_time <= '" + ((String[]) map.get("createTimeMax"))[0] + " 23:59:59' ");
			}
			if (map.get("outTimeMin") != null && StringUtils.isNotEmpty(((String[]) map.get("outTimeMin"))[0])) {
				sf.append(" and a.sendgood_time >= '" + ((String[]) map.get("outTimeMin"))[0] + " 00:00:00' ");
			}
			if (map.get("outTimeMax") != null && StringUtils.isNotEmpty(((String[]) map.get("outTimeMax"))[0])) {
				sf.append(" and a.sendgood_time <= '" + ((String[]) map.get("outTimeMax"))[0] + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public List<Record> getNandaoList(Page<Record> page, Map<String, Object> map) {
		// String[] goodsSign={"QJ18040201","QJ18040202","WT18040301","CW08040801"};
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT a.*,p.unit,p.stocks as goodStocks,s.name AS siteName,s.province as siteProvince,s.city as siteCity,s.due_time ,p.distribution_type as distributionType,d.amount as outAmount,ia.review_status  ");
		sf.append(" FROM crm_goods_platform_transfer_order a ");
		sf.append(" LEFT JOIN crm_goods_platform p ON p.number=a.good_number ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id ");
		sf.append(" LEFT JOIN crm_goods_platform_detail d ON a.id=d.order_id ");
		sf.append(" left join crm_invoice_application as ia on a.invoice_record_id=ia.id ");
		sf.append(" where s.status='0' and a.pay_status='1' and a.good_category like '%插座%'  ");
		sf.append(queryConditions(map));
		sf.append("ORDER BY a.placing_order_time DESC ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public List<Record> getPublicNumberOrdersList(Page<Record> page, Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT a.*,p.unit,p.stocks as goodStocks,s.name AS siteName,s.province as siteProvince,s.city as siteCity,s.due_time ,p.distribution_type as distributionType ");
		sf.append(" FROM crm_goods_platform_customer_order a ");
		// sf.append(" LEFT JOIN crm_goods_platform p ON p.number=a.good_number ");
		sf.append("  LEFT JOIN crm_goods_platform p ON p.`id` =a.`good_id`  ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id ");
		// sf.append(" where s.status='0' and a.pay_status='1' ");
		sf.append(" where 1=1 and a.pay_status='1' and a.types!='1' ");
		sf.append(queryConditions(map));
		sf.append("ORDER BY a.placing_order_time DESC ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public List<Record> getWarrantyOrderList(Page<Record> page, Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT a.*,DATE_FORMAT(a.payment_time,'%Y-%m-%d') as placingOrderTime,DATE_FORMAT(a.buy_time,'%Y-%m-%d') as buyTime ");
		sf.append(" FROM crm_goods_platform_customer_order a ");
		sf.append(" where 1=1 and a.pay_status='1' and a.types='1' ");
		sf.append(queryConditionsWarranty(map));
		sf.append("ORDER BY a.placing_order_time DESC ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public Page<Record> areaBindingnandaoGrid(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getareaManagerNandao(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}

		Long count = getareaManagerNandaoCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	public Page<Record> areaAllBindingGrid(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getAreaAllPlatformList(page, map);
		for (Record rd : list) {
			String adress = "";
			String province = "";
			String city = "";
			String area = "";
			if (StringUtils.isNotBlank(rd.getStr("province"))) {
				province = rd.getStr("province");
			}
			if (StringUtils.isNotBlank(rd.getStr("city"))) {
				city = rd.getStr("city");
			}
			if (StringUtils.isNotBlank(rd.getStr("area"))) {
				area = rd.getStr("area");
			}
			adress = province + city + area + rd.getStr("customer_address");
			rd.set("customer_address", adress);
		}

		Long count = getAreaAllPlatformCount(map);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	/*
	 * 区域南岛订单
	 */
	public List<Record> getareaManagerNandao(Page<Record> page, Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT os.*,b.`name`  AS areaName ");
		sf.append(" FROM ( ");
		sf.append(" SELECT a.*,s.name AS siteName,s.province AS siteProvince,s.city AS siteCity,s.due_time   ");
		sf.append(" FROM crm_goods_platform_transfer_order a   ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id  ");
		sf.append(" WHERE s.status='0' AND a.pay_status='1' AND a.good_category LIKE '%插座%'  ");
		if (StringUtil.checkParamsValid(map.get("siteName"))) {
			sf.append(" AND s.name LIKE '%" + (map.get("siteName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("goodName"))) {
			sf.append(" AND a.good_name LIKE '%" + (map.get("goodName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {
			sf.append(" and a.placing_order_time >= '" + map.get("createTimeMin") + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and a.placing_order_time <= '" + map.get("createTimeMax") + " 23:59:59' ");
		}
		sf.append("   ORDER BY placing_order_time DESC  ");
		sf.append(" ) os     ");
		sf.append(" INNER JOIN crm_area_manager_site_rel c ON c.site_id = os.site_id ");
		sf.append(" INNER JOIN crm_area_manager b ON b.id = c.area_manager_id ");
		if (StringUtil.checkParamsValid(map.get("areaName"))) {
			sf.append(" AND b.id = '" + (map.get("areaName")) + "' ");
		}
		sf.append(" GROUP BY os.id ");

		/*
		 * sf.
		 * append(" SELECT b.name AS areaName,a.*,s.name AS siteName,s.province AS siteProvince,s.city AS siteCity,s.due_time   "
		 * ); sf.append("  FROM crm_goods_platform_transfer_order a   ");
		 * sf.append("  LEFT JOIN crm_site s ON s.id=a.site_id ");
		 * sf.append("  LEFT JOIN crm_area_manager_site_rel c ON c.site_id = s.id");
		 * sf.append("  LEFT JOIN crm_area_manager b ON b.id = c.area_manager_id "); sf.
		 * append(" where s.status='0' and a.pay_status='1' and a.good_category like '%插座%'  AND b.id  IS NOT  NULL "
		 * );
		 */

		// sf.append("ORDER BY a.placing_order_time DESC ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public long getareaManagerNandaoCount(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT count(*)  FROM (  ");
		sf.append(" SELECT os.*,b.`name`  AS areaName ");
		sf.append(" FROM ( ");
		sf.append(" SELECT a.*,s.name AS siteName,s.province AS siteProvince,s.city AS siteCity,s.due_time   ");
		sf.append(" FROM crm_goods_platform_transfer_order a   ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id  ");
		sf.append(" WHERE s.status='0' AND a.pay_status='1' AND a.good_category LIKE '%插座%'  ");
		if (StringUtil.checkParamsValid(map.get("siteName"))) {
			sf.append(" AND s.name LIKE '%" + (map.get("siteName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("goodName"))) {
			sf.append(" AND a.good_name LIKE '%" + (map.get("goodName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {
			sf.append(" and a.placing_order_time >= '" + map.get("createTimeMin") + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and a.placing_order_time <= '" + map.get("createTimeMax") + " 23:59:59' ");
		}
		sf.append("   ORDER BY placing_order_time DESC  ");
		sf.append(" ) os     ");
		sf.append(" INNER JOIN crm_area_manager_site_rel c ON c.site_id = os.site_id ");
		sf.append(" INNER JOIN crm_area_manager b ON b.id = c.area_manager_id ");
		if (StringUtil.checkParamsValid(map.get("areaName"))) {
			sf.append(" AND b.id = '" + (map.get("areaName")) + "' ");
		}
		sf.append(" GROUP BY os.id ");
		sf.append(" ) ass ");

		return Db.queryLong(sf.toString());
	}

	/*
	 * 区域平台订单
	 */
	public List<Record> getAreaAllPlatformList(Page<Record> page, Map<String, Object> map) {
		/* 清洁剂、水龙头、除味盒 */
		String[] goodsSign = { "QJ18040201", "QJ18040202", "WT18040301", "CW08040801" };
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT b.name AS areaName,a.*,s.name AS siteName,s.province AS siteProvince ");
		sf.append(" FROM crm_goods_platform_order a  ");
		sf.append(" LEFT JOIN crm_goods_platform p ON p.number=a.good_number  ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id ");
		sf.append(" LEFT JOIN crm_area_manager_site_rel c ON c.site_id = s.id ");
		sf.append(" LEFT JOIN crm_area_manager b ON b.id = c.area_manager_id ");
		sf.append(" where s.status='0' and a.pay_status='1' and p.good_sign in (" + StringUtil.joinInSql(goodsSign) + ")  AND b.id  IS NOT  NULL ");
		if (StringUtil.checkParamsValid(map.get("areaName"))) {
			sf.append(" AND b.id = '" + (map.get("areaName")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("goodName"))) {
			sf.append(" AND a.good_name LIKE '%" + (map.get("goodName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("siteName"))) {
			sf.append(" AND s.name LIKE '%" + (map.get("siteName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {
			sf.append(" and a.placing_order_time >= '" + map.get("createTimeMin") + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and a.placing_order_time <= '" + map.get("createTimeMax") + " 23:59:59' ");
		}
		sf.append("ORDER BY a.placing_order_time DESC ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public long getAreaAllPlatformCount(Map<String, Object> map) {
		/* 清洁剂、水龙头、除味盒 */
		String[] goodsSign = { "QJ18040201", "QJ18040202", "WT18040301", "CW08040801" };
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT count(*) ");
		sf.append(" FROM crm_goods_platform_order a  ");
		sf.append(" LEFT JOIN crm_goods_platform p ON p.number=a.good_number  ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id ");
		sf.append(" LEFT JOIN crm_area_manager_site_rel c ON c.site_id = s.id ");
		sf.append(" LEFT JOIN crm_area_manager b ON b.id = c.area_manager_id ");
		sf.append(" where s.status='0' and a.pay_status='1' and p.good_sign in (" + StringUtil.joinInSql(goodsSign) + ")  AND b.id  IS NOT  NULL ");
		if (StringUtil.checkParamsValid(map.get("areaName"))) {
			sf.append(" AND b.id = '" + (map.get("areaName")) + "' ");
		}
		if (StringUtil.checkParamsValid(map.get("goodName"))) {
			sf.append(" AND a.good_name LIKE '%" + (map.get("goodName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("siteName"))) {
			sf.append(" AND s.name LIKE '%" + (map.get("siteName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {
			sf.append(" and a.placing_order_time >= '" + map.get("createTimeMin") + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
			sf.append(" and a.placing_order_time <= '" + map.get("createTimeMax") + " 23:59:59' ");
		}
		sf.append("ORDER BY a.placing_order_time DESC ");
		return Db.queryLong(sf.toString());
	}

	// 公众号订单
	public long getPublicNumberOrdersCount(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT count(*) FROM crm_goods_platform_customer_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.pay_status='1' and a.types!='1'  ");
		sf.append(queryConditions(map));
		return Db.queryLong(sf.toString());
	}

	public long getWarrantyOrderCount(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT count(*) FROM crm_goods_platform_customer_order a where a.pay_status='1' and a.types='1'  ");
		sf.append(queryConditionsWarranty(map));
		return Db.queryLong(sf.toString());
	}

	public String queryConditionsWarranty(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		if (map != null) {
			if (StringUtils.isNotEmpty((CharSequence) map.get("number"))) {
				sf.append(" and a.number like '%" + map.get("number") + "%' ");
			}
			if (StringUtils.isNotEmpty((CharSequence) map.get("orderStatus"))) {
				sf.append(" and a.status ='" + map.get("orderStatus") + "' ");
			}
			if (StringUtils.isNotEmpty((CharSequence) map.get("warrantyType"))) {
				sf.append(" and a.warranty_type ='" + map.get("warrantyType") + "' ");
			}
			if (StringUtils.isNotEmpty((CharSequence) map.get("customerName"))) {
				sf.append(" and a.customer_name like '%" + map.get("customerName") + "%' ");
			}
			if (StringUtils.isNotEmpty((CharSequence) map.get("outTimeMin"))) {
				sf.append(" and a.placing_order_time >= '" + map.get("outTimeMin") + " 00:00:00' ");
			}
			if (StringUtils.isNotEmpty((CharSequence) map.get("outTimeMax"))) {
				sf.append(" and a.placing_order_time <= '" + map.get("outTimeMax") + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public List<Record> getAllPlatformList(Page<Record> page, Map<String, Object> map) {
		/* 清洁剂、水龙头、除味盒、冰箱 */
		String[] goodsSign = { "QJ18040201", "QJ18040202", "WT18040301", "WT18040302", "WT18040303", "CW08040801", "MD20180716", "MD20180717" };
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT a.*,p.unit,p.stocks as goodStocks,s.name AS siteName,s.province as siteProvince,s.city as siteCity,s.due_time ,p.distribution_type as distributionType,d.amount as outAmount,ia.review_status  ");
		sf.append(" FROM crm_goods_platform_order a ");
		sf.append(" LEFT JOIN crm_goods_platform p ON p.number=a.good_number ");
		sf.append(" LEFT JOIN crm_site s ON s.id=a.site_id ");
		sf.append(" LEFT JOIN crm_goods_platform_detail d ON a.id=d.order_id ");
		sf.append(" left join crm_invoice_application as ia on a.invoice_record_id=ia.id ");
		sf.append(" where s.status='0' and a.pay_status='1' and p.good_sign in (" + StringUtil.joinInSql(goodsSign) + ")  ");
		sf.append(queryConditions(map));
		sf.append("ORDER BY a.placing_order_time DESC ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public long getNanDaoCount(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT count(*) FROM crm_goods_platform_transfer_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.pay_status='1' and a.good_category like '%插座%'  ");
		sf.append(queryConditions(map));
		return Db.queryLong(sf.toString());
	}

	public long getAllPlatformCount(Map<String, Object> map) {
		String[] goodsSign = { "QJ18040201", "QJ18040202", "WT18040301", "CW08040801", "MD20180716", "MD20180717" };
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT count(*) FROM crm_goods_platform_order a LEFT JOIN crm_goods_platform p ON p.number=a.good_number  LEFT JOIN crm_site s ON s.id=a.site_id where s.status='0' and a.pay_status='1' and p.good_sign in ("
						+ StringUtil.joinInSql(goodsSign) + ")  ");
		sf.append(queryConditions(map));
		return Db.queryLong(sf.toString());
	}

	public Record getDetailById(String id) {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.*,s.name as siteName,p.unit,d.amount");
		sb.append(" from crm_goods_platform_transfer_order a");
		sb.append(" left join crm_site s on s.id=a.site_id");
		sb.append(" left Join crm_goods_platform p on a.good_id=p.id");
		sb.append(" left Join crm_goods_platform_detail d on a.id=d.order_id");
		sb.append("  where a.id='" + id + "'");
		return Db.findFirst(sb.toString());
	}

	public Record getPlatformDetailById(String id) {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.*,s.name as siteName,p.unit,d.amount");
		sb.append(" from crm_goods_platform_order a");
		sb.append(" left join crm_site s on s.id=a.site_id");
		sb.append(" left Join crm_goods_platform p on a.good_id=p.id");
		sb.append(" left Join crm_goods_platform_detail d on a.id=d.order_id");
		sb.append("  where a.id='" + id + "'");
		return Db.findFirst(sb.toString());
	}

	// 公众号商品订单
	public Record getPublicNumberformDetailById(String id) {
		StringBuffer sb = new StringBuffer();
		sb.append("select a.*,s.name as siteName,p.unit");
		sb.append(" from crm_goods_platform_customer_order a");
		sb.append(" left join crm_site s on s.id=a.site_id");
		sb.append(" left Join crm_goods_platform p on a.good_id=p.id");
		sb.append("  where a.id='" + id + "'");
		return Db.findFirst(sb.toString());
	}

	@Transactional(rollbackFor = Exception.class)
	public String outStockConfirm(String id, String logisticsName, String logisticsNo, String goodId, String outAmount, String outType, String remark) {
		Record rd = Db.findFirst(
				"select a.*,p.stocks,p.sales,p.name as goodName,p.id as goodId,p.number as goodNumber,p.brand as goodBrand,p.model as goodModel,p.category as goodCategory,p.type as goodType,p.unit as goodUnit,p.site_price as gSprice,p.platform_price as gPprice,p.profit as gprofit from crm_goods_platform_transfer_order a left join crm_goods_platform p on p.number=a.good_number  where a.id=?",
				id);
		SQLQuery sqlQuery1 = goodsPlatformTransferOrderDao.getSession()
				.createSQLQuery("update crm_goods_platform_transfer_order a set a.status='2',a.sendgood_time=now(),a.finish_time=now(),a.logistics_name='" + logisticsName
						+ "',a.logistics_no='" + logisticsNo + "',a.remark='" + remark + "' where a.id='" + id + "'");// 对应的库存添加
		sqlQuery1.executeUpdate();
		if ("0".equals(outType)) {// 公司库存
			if (rd.getBigDecimal("sales") != null) {
				SQLQuery sqlQuery2 = goodsPlatformTransferOrderDao.getSession().createSQLQuery("update crm_goods_platform a set a.sales=(a.sales+'"
						+ rd.getBigDecimal("purchase_num") + "'),a.stocks=(a.stocks-'" + outAmount + "')  where a.id='" + goodId + "' ");// 对应的库存添加
				sqlQuery2.executeUpdate();
			} else {
				SQLQuery sqlQuery2 = goodsPlatformTransferOrderDao.getSession().createSQLQuery(
						"update crm_goods_platform a set a.sales='" + rd.getBigDecimal("purchase_num") + "',a.stocks=(a.stocks-'" + outAmount + "')  where a.id='" + goodId + "'"); // 对应的库存添加
				sqlQuery2.executeUpdate();
			}
		} else {// 厂家库存
			if (rd.getBigDecimal("sales") != null) {
				SQLQuery sqlQuery2 = goodsPlatformTransferOrderDao.getSession()
						.createSQLQuery("update crm_goods_platform a set a.sales=(a.sales+'" + rd.getBigDecimal("purchase_num") + "')  where a.id='" + goodId + "' ");// 对应的库存添加
				sqlQuery2.executeUpdate();
			} else {
				SQLQuery sqlQuery2 = goodsPlatformTransferOrderDao.getSession()
						.createSQLQuery("update crm_goods_platform a set a.sales='" + rd.getBigDecimal("purchase_num") + "'  where a.id='" + goodId + "'"); // 对应的库存添加
				sqlQuery2.executeUpdate();
			}
		}
		goodsPlatformTransferOrderDao.update("update GoodsPlatformTransferOrder set out_stock_type='" + outType + "' where id='" + id + "' ");

		Date dt = new Date();
		User user = UserUtils.getUser();
		GoodsPlatformDetail gpd = new GoodsPlatformDetail();
		gpd.setOutStockType(outType);
		gpd.setOrderId(id);// 订单id
		gpd.setAmount(BigDecimal.valueOf(Double.valueOf(outAmount)));
		gpd.setConfirmor(user.getRemarks());// 运营管理员
		gpd.setConfirmTime(dt);
		gpd.setCreateTime(dt);
		gpd.setCreator(user.getId());
		gpd.setGoodBrand(rd.getStr("goodBrand"));
		gpd.setGoodCategory(rd.getStr("goodCategory"));
		gpd.setGoodModel(rd.getStr("goodModel"));
		gpd.setGoodId(rd.getStr("goodId"));
		gpd.setGoodName(rd.getStr("goodName"));
		gpd.setGoodNumber(rd.getStr("goodNumber"));
		gpd.setGoodType(rd.getStr("goodType"));
		gpd.setPlatformPrice(rd.getBigDecimal("gPprice"));
		gpd.setProfit(rd.getBigDecimal("gprofit"));
		gpd.setSitePrice(rd.getBigDecimal("gSprice"));
		gpd.setStatus("0");
		gpd.setUnit(rd.getStr("goodUnit"));
		gpd.setType("2");// 出库
		gpd.setEndStocks(rd.getBigDecimal("stocks").subtract(new BigDecimal(outAmount)));// 剩余库存跟踪
		goodsPlatFormDetailDao.save(gpd);
		String content = "您购买的" + outAmount + rd.getStr("goodUnit") + rd.getStr("goodName") + "已发货：" + logisticsName + "(" + logisticsNo + ")，请关注购买订单查看物流信息！";
		SMSUtils.sendMsg(rd.getStr("customer_contact"), content, "思方科技", "12");

		return "ok";
	}

	@Transactional(rollbackFor = Exception.class)
	public String outStockConfirmForPlat(String id, String logisticsName, String logisticsNo, String goodId, String outAmount, String outType, String goodType) {
		Record rd = null;
		if (StringUtils.isBlank(goodType)) {
			// 查出订单信息
			rd = Db.findFirst(
					"select a.*,p.stocks,p.sales,p.name as goodName,p.id as goodId,p.number as goodNumber,p.brand as goodBrand,p.model as goodModel,p.category as goodCategory,p.type as goodType,p.unit as goodUnit,p.site_price as gSprice,p.platform_price as gPprice,p.profit as gprofit from crm_goods_platform_order a left join crm_goods_platform p on p.number=a.good_number  where a.id=?",
					id);
			// 修改当前订单的信息
			SQLQuery sqlQuery1 = goodsPlatformOrderDao.getSession()
					.createSQLQuery("update crm_goods_platform_order a set a.status='4',a.sendgood_time=now(),a.finish_time=now(),a.logistics_name='" + logisticsName
							+ "',a.logistics_no='" + logisticsNo + "' where a.id='" + id + "'");// 对应的库存添加
			sqlQuery1.executeUpdate();

			goodsPlatformOrderDao.update("update GoodsPlatformOrder set out_stock_type='" + outType + "' where id='" + id + "' ");

		} else {
			// 查出订单信息 (公众号订单)
			rd = Db.findFirst(
					"select a.*,p.stocks,p.sales,p.name as goodName,p.id as goodId,p.number as goodNumber,p.brand as goodBrand,p.model as goodModel,p.category as goodCategory,p.type as goodType,p.unit as goodUnit,p.site_price as gSprice,p.platform_price as gPprice,p.profit as gprofit from crm_goods_platform_customer_order a left join crm_goods_platform p on p.number=a.good_number  where a.id=?",
					id);
			// 修改当前订单的信息
			SQLQuery sqlQuery1 = goodsPlatformOrderDao.getSession()
					.createSQLQuery("update crm_goods_platform_customer_order a set a.status='2',a.sendgood_time=now(),a.finish_time=now(),a.logistics_name='" + logisticsName
							+ "',a.logistics_no='" + logisticsNo + "', a.out_stock_type='" + outType + "' where a.id='" + id + "'");// 对应的库存添加
			sqlQuery1.executeUpdate();
		}

		if ("0".equals(outType)) {// 公司库存
			if (rd.getBigDecimal("sales") != null) {
				SQLQuery sqlQuery2 = goodsPlatformOrderDao.getSession().createSQLQuery("update crm_goods_platform a set a.sales=(a.sales+'" + rd.getBigDecimal("purchase_num")
						+ "'),a.stocks=(a.stocks-'" + outAmount + "')  where a.id='" + goodId + "' ");// 对应的库存添加
				sqlQuery2.executeUpdate();
			} else {
				SQLQuery sqlQuery2 = goodsPlatformOrderDao.getSession().createSQLQuery(
						"update crm_goods_platform a set a.sales='" + rd.getBigDecimal("purchase_num") + "',a.stocks=(a.stocks-'" + outAmount + "')  where a.id='" + goodId + "'"); // 对应的库存添加
				sqlQuery2.executeUpdate();
			}
		} else {// 厂家库存
			if (rd.getBigDecimal("sales") != null) {
				SQLQuery sqlQuery2 = goodsPlatformOrderDao.getSession()
						.createSQLQuery("update crm_goods_platform a set a.sales=(a.sales+'" + rd.getBigDecimal("purchase_num") + "')  where a.id='" + goodId + "' ");// 对应的库存添加
				sqlQuery2.executeUpdate();
			} else {
				SQLQuery sqlQuery2 = goodsPlatformOrderDao.getSession()
						.createSQLQuery("update crm_goods_platform a set a.sales='" + rd.getBigDecimal("purchase_num") + "'  where a.id='" + goodId + "'"); // 对应的库存添加
				sqlQuery2.executeUpdate();
			}
		}

		Date dt = new Date();
		User user = UserUtils.getUser();
		GoodsPlatformDetail gpd = new GoodsPlatformDetail();
		gpd.setOutStockType(outType);
		gpd.setOrderId(id);// 订单id
		gpd.setAmount(BigDecimal.valueOf(Double.valueOf(outAmount)));
		gpd.setConfirmor(user.getRemarks());// 运营管理员
		gpd.setConfirmTime(dt);
		gpd.setCreateTime(dt);
		gpd.setCreator(user.getId());
		gpd.setGoodBrand(rd.getStr("goodBrand"));
		gpd.setGoodCategory(rd.getStr("goodCategory"));
		gpd.setGoodModel(rd.getStr("goodModel"));
		gpd.setGoodId(rd.getStr("goodId"));
		gpd.setGoodName(rd.getStr("goodName"));
		gpd.setGoodNumber(rd.getStr("goodNumber"));
		gpd.setGoodType(rd.getStr("goodType"));
		gpd.setPlatformPrice(rd.getBigDecimal("gPprice"));
		gpd.setProfit(rd.getBigDecimal("gprofit"));
		gpd.setSitePrice(rd.getBigDecimal("gSprice"));
		gpd.setStatus("0");
		gpd.setUnit(rd.getStr("goodUnit"));
		gpd.setType("2");// 出库
		gpd.setEndStocks(rd.getBigDecimal("stocks").subtract(new BigDecimal(outAmount)));// 剩余库存跟踪
		goodsPlatFormDetailDao.save(gpd);
		String content = "您购买的" + outAmount + rd.getStr("goodUnit") + rd.getStr("goodName") + "已发货：" + logisticsName + "(" + logisticsNo + ")，请关注购买订单查看物流信息！";
		SMSUtils.sendMsg(rd.getStr("customer_contact"), content, "思方科技", "12");

		return "ok";
	}

	// 修改物流信息
	public String updatelogistics(String id, String logisticsName, String logisticsNo) {
		try {
			Db.update("update crm_goods_platform_transfer_order a set a.status='2',a.sendgood_time=now(),a.finish_time=now(),a.logistics_name=?,a.logistics_no=? where a.id=?",
					logisticsName, logisticsNo, id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	// 修改物流信息
	public String updatelogisticsForPLat(String id, String logisticsName, String logisticsNo) {
		try {
			Db.update("update crm_goods_platform_order a set a.status='2',a.sendgood_time=now(),a.finish_time=now(),a.logistics_name=?,a.logistics_no=? where a.id=?",
					logisticsName, logisticsNo, id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public String pass(String id, String remark) {
		try {
			StringBuffer sb = new StringBuffer("update crm_goods_platform_transfer_order a set a.status='1'");
			if (StringUtils.isNotBlank(remark)) {
				sb.append(",a.remark='" + remark + "' ");
			}
			sb.append(" where a.id=?");
			Db.update(sb.toString(), id);
			// 审核提醒发送短信 您购买的@厂家已审核通过，会尽快安排发货！【思方科技】
			Record rd = Db.findFirst(
					"select a.purchase_num,a.customer_contact,a.good_name,b.unit from  crm_goods_platform_transfer_order a left join crm_goods_platform b on a.good_id=b.id where a.id=?  ",
					id);
			String content = "您购买的" + rd.getBigDecimal("purchase_num") + rd.getStr("unit") + rd.getStr("good_name") + "厂家已审核通过，会尽快安排发货！";
			SMSUtils.sendMsg(rd.getStr("customer_contact"), content, "思方科技", "13");
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public String passForPLatform(String id, String remark) {
		try {
			StringBuffer sb = new StringBuffer("update crm_goods_platform_order a set a.status='2'");
			if (StringUtils.isNotBlank(remark)) {
				sb.append(",a.remark='" + remark + "' ");
			}
			sb.append(" where a.id=?");
			Db.update(sb.toString(), id);
			// 审核提醒发送短信 您购买的@厂家已审核通过，会尽快安排发货！【思方科技】
			Record rd = Db.findFirst(
					"select a.purchase_num,a.customer_contact,a.good_name,b.unit from  crm_goods_platform_order a left join crm_goods_platform b on a.good_id=b.id where a.id=?  ",
					id);
			String content = "您购买的" + rd.getBigDecimal("purchase_num") + rd.getStr("unit") + rd.getStr("good_name") + "厂家已审核通过，会尽快安排发货！";
			SMSUtils.sendMsg(rd.getStr("customer_contact"), content, "思方科技", "13");
			return "ok";
		} catch (Exception e) {
			e.printStackTrace();
			return "no";
		}
	}

	public String noPass(String id, String reason, String remark) {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("update crm_goods_platform_transfer_order a set a.status='3',a.no_pass_time=now(),a.no_pass_source=? ");
			if (StringUtil.isNotEmpty(remark)) {
				sb.append(" ,a.remark='" + remark + "' ");
			}
			sb.append(" where a.id=? ");
			Db.update(sb.toString(), reason, id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public String noPassForPlatform(String id, String reason, String remark) {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("update crm_goods_platform_order a set a.status='6',a.no_pass_time=now(),a.no_pass_source=? ");
			if (StringUtil.isNotEmpty(remark)) {
				sb.append(" ,a.remark='" + remark + "' ");
			}
			sb.append(" where a.id=? ");
			Db.update(sb.toString(), reason, id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	public String noPassForPlatForm(String id, String reason, String remark) {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("update crm_goods_platform_order a set a.status='3',a.no_pass_time=now(),a.no_pass_source=? ");
			if (StringUtil.isNotEmpty(remark)) {
				sb.append(" ,a.remark='" + remark + "' ");
			}
			sb.append(" where a.id=? ");
			Db.update(sb.toString(), reason, id);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}

	/**
	 * 南岛订单出库后获取该商品的订单
	 * 
	 * @param platformId
	 *            商品id
	 * @param orderId
	 *            订单id
	 */

	public void getPlatFormStockAndUpdateDetail(String platformId, String orderId, BigDecimal outAmount) {
		Record ref = Db.findFirst("select name,stocks from crm_goods_platform where id=?", platformId);
		Db.update("update crm_goods_platform_detail set end_stocks=? where order_id=? ", ref.getBigDecimal("stocks"), orderId);
		Record re = Db.findFirst("select * from crm_goods_platform_detail  where order_id=? ", orderId);
		if ("0".equals(re.getStr("out_stock_type"))) {
			logger.info("操作后：【商品库存：" + ref.getBigDecimal("stocks") + "】【操作数量：" + outAmount + "】【出库方式：公司库存】【商品名称：" + ref.getStr("name"));
		} else {
			logger.info("操作后：【商品库存：" + ref.getBigDecimal("stocks") + "】【操作数量：" + outAmount + "】【出库方式：厂家库存】【商品名称：" + ref.getStr("name"));
		}
	}

	@Transactional(rollbackFor = Exception.class)
	public String updateOrder(Map<String, Object> map) {
		GoodsPlatformTransferOrder gpt = null;
		GoodsPlatformDetail gpd = null;
		String orderId = map.get("orderId").toString();
		String payType = map.get("payType").toString();
		String remark = map.get("remark").toString();
		if (!"0".equals(payType) && !"1".equals(payType)) {
			throw new RuntimeException("payType invalid: " + payType);
		}

		if (StringUtils.isNotEmpty(orderId)) {
			gpt = goodsPlatformTransferOrderDao.get(orderId);
			gpd = goodsPlatFormDetailDao.getByHql("from GoodsPlatformDetail where order_id=:p1 ", new Parameter(orderId));
		}
		if ("0".equals(gpt.getStatus()) || "1".equals(gpt.getStatus())) {// 未出库（只可能修改支付方式及备注）
			goodsPlatformTransferOrderDao.update("update GoodsPlatformTransferOrder set payment_type=:p1,remark=:p2 where id=:p3 ", new Parameter(payType, remark, orderId));
		} else {
			if (gpd == null) {
				return "401";
			}

			Double yuanAmount = gpd.getAmount().doubleValue();// 原出库数量
			Double nowAmount = Double.valueOf(map.get("outAmount").toString());// 出库数量
			Double changeAmount = nowAmount - yuanAmount;

			// 当前出库方式
			String outType = map.get("outType").toString();
			if (StringUtil.isBlank(outType)) {
				throw new RuntimeException("out type invalid");
			}

			// 原出库方式
			String hisOutType = gpt.getOutStockType();
			// 出库方式是否改变
			Boolean outTypeChange = false;
			if (!outType.equals(hisOutType)) {
				outTypeChange = true;
			}
			if ("0".equals(outType)) {// 当前出库方式——>公司库存
				String hqlOrder = "update GoodsPlatformTransferOrder set payment_type=:p1,out_stock_type=:p2,logistics_name=:p3,logistics_no=:p4,remark=:p5 where id=:p6 ";
				// 修改订单表信息
				goodsPlatformTransferOrderDao.update(hqlOrder, new Parameter(payType, outType, map.get("logisticsName"), map.get("logisticsNo"), remark, orderId));
				if (!yuanAmount.equals(nowAmount)) {// 出库数量与原出库数量不一致（修改订单表中的出库数量）
					// 修改公司信息
					String hqlCompany = "update GoodsPlatform set stocks=stocks-'" + changeAmount + "' where id='" + gpt.getGoodId() + "' ";
					goodsPlatFormDao.update(hqlCompany);
				}
				if (outTypeChange) {
					// 修改公司信息
					String hqlCompany = "update GoodsPlatform set stocks=stocks-'" + nowAmount + "' where id='" + gpt.getGoodId() + "' ";
					goodsPlatFormDao.update(hqlCompany);
				}
			} else if ("1".equals(map.get("outType"))) {// 当前出库方式——>厂家库存
				// 修改订单表信息
				String hqlOrder = "update GoodsPlatformTransferOrder set payment_type=:p1,out_stock_type=:p2,logistics_name=:p3,logistics_no=:p4,remark=:p5 where id=:p6 ";
				goodsPlatformTransferOrderDao.update(hqlOrder, new Parameter(payType, outType, map.get("logisticsName"), map.get("logisticsNo"), remark, orderId));
				if (outTypeChange) {
					String hqlCompany = "update GoodsPlatform set stocks=stocks+'" + nowAmount + "' where id='" + gpt.getGoodId() + "' ";
					goodsPlatFormDao.update(hqlCompany);
				}
			}
			// 修改出入库明细表的信息
			String hqlDetail = "update GoodsPlatformDetail set amount='" + nowAmount + "',out_stock_type='" + outType + "'  where order_id='" + orderId + "' ";
			goodsPlatFormDetailDao.update(hqlDetail);
		}
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public String updateOrderForPlatform(Map<String, Object> map) {
		GoodsPlatformOrder gpt = null;
		GoodsPlatformDetail gpd = null;
		String orderId = map.get("orderId").toString();
		String payType = map.get("payType").toString();
		String remark = map.get("remark").toString();
		if (!"0".equals(payType) && !"1".equals(payType)) {
			throw new RuntimeException("payType invalid: " + payType);
		}

		if (StringUtils.isNotEmpty(orderId)) {
			gpt = goodsPlatformOrderDao.get(orderId);
			gpd = goodsPlatFormDetailDao.getByHql("from GoodsPlatformDetail where order_id=:p1 ", new Parameter(orderId));
		}
		if ("0".equals(gpt.getStatus()) || "1".equals(gpt.getStatus())) {// 未出库（只可能修改支付方式及备注）
			goodsPlatformOrderDao.update("update GoodsPlatformOrder set payment_type=:p1,remark=:p2 where id=:p3 ", new Parameter(payType, remark, orderId));
		} else {
			if (gpd == null) {
				return "401";
			}

			Double yuanAmount = gpd.getAmount().doubleValue();// 原出库数量
			Double nowAmount = Double.valueOf(map.get("outAmount").toString());// 出库数量
			Double changeAmount = nowAmount - yuanAmount;

			// 当前出库方式
			String outType = map.get("outType").toString();
			if (StringUtil.isBlank(outType)) {
				throw new RuntimeException("out type invalid");
			}

			// 原出库方式
			String hisOutType = gpt.getOutStockType();
			// 出库方式是否改变
			Boolean outTypeChange = false;
			if (!outType.equals(hisOutType)) {
				outTypeChange = true;
			}
			if ("0".equals(outType)) {// 当前出库方式——>公司库存
				String hqlOrder = "update GoodsPlatformOrder set payment_type=:p1,out_stock_type=:p2,logistics_name=:p3,logistics_no=:p4,remark=:p5 where id=:p6 ";
				// 修改订单表信息
				goodsPlatformOrderDao.update(hqlOrder, new Parameter(payType, outType, map.get("logisticsName"), map.get("logisticsNo"), remark, orderId));
				if (!yuanAmount.equals(nowAmount)) {// 出库数量与原出库数量不一致（修改订单表中的出库数量）
					// 修改公司信息
					String hqlCompany = "update GoodsPlatform set stocks=stocks-'" + changeAmount + "' where id='" + gpt.getGoodId() + "' ";
					goodsPlatFormDao.update(hqlCompany);
				}
				if (outTypeChange) {
					// 修改公司信息
					String hqlCompany = "update GoodsPlatform set stocks=stocks-'" + nowAmount + "' where id='" + gpt.getGoodId() + "' ";
					goodsPlatFormDao.update(hqlCompany);
				}
			} else if ("1".equals(map.get("outType"))) {// 当前出库方式——>厂家库存
				// 修改订单表信息
				String hqlOrder = "update GoodsPlatformOrder set payment_type=:p1,out_stock_type=:p2,logistics_name=:p3,logistics_no=:p4,remark=:p5 where id=:p6 ";
				goodsPlatformOrderDao.update(hqlOrder, new Parameter(payType, outType, map.get("logisticsName"), map.get("logisticsNo"), remark, orderId));
				if (outTypeChange) {
					String hqlCompany = "update GoodsPlatform set stocks=stocks+'" + nowAmount + "' where id='" + gpt.getGoodId() + "' ";
					goodsPlatFormDao.update(hqlCompany);
				}
			}
			// 修改出入库明细表的信息
			String hqlDetail = "update GoodsPlatformDetail set amount='" + nowAmount + "',out_stock_type='" + outType + "'  where order_id='" + orderId + "' ";
			goodsPlatFormDetailDao.update(hqlDetail);
		}
		return "200";
	}

	// 获取 服务商 商品线上付款交易记录
	public Page<Record> getPlatformGoodsRecord(Page<Record> page, String siteId, Map<String, Object> map) {
		List<Record> list = goodsPlatformTransferOrderDao.getSitePlatformGoodsRecord(page, siteId, map);
		for (Record re : list) {
			if (StringUtils.isNotBlank(re.getStr("good_icon"))) {
				re.set("good_icon", re.getStr("good_icon").split(",")[0]);
			}
		}
		long count = goodsPlatformTransferOrderDao.getCount(map, siteId);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	public List<Record> getPlatformGoodsRecordExport(Page<Record> page, String siteId, Map<String, Object> map) {
		List<Record> list = goodsPlatformTransferOrderDao.getSitePlatformGoodsRecord(page, siteId, map);
		return list;
	}

	public void cancelOrder(String id) {
		String sql = "update crm_goods_platform_transfer_order set status='4' where id='" + id + "' ";
		Db.update(sql);
	}

	public void cancelOrderForPlat(String id) {
		String sql = "update crm_goods_platform_order set status='5' where id='" + id + "' ";
		Db.update(sql);
	}

	public GoodsSiteSelf getGss(Record rd, String siteId, String num, Date dt) {
		GoodsSiteSelf gss = new GoodsSiteSelf();
		gss.setBrand(rd.getStr("brand"));
		gss.setCategory(rd.getStr("category"));
		gss.setCreateTime(dt);
		// gss.setCustomerPrice(customerPrice);
		gss.setDeductType("1");
		gss.setDescription(rd.getStr("description"));
		// gss.setEmployePrice(employePrice);
		gss.setHtml(rd.getStr("html"));
		gss.setIcon(rd.getStr("icon"));
		// gss.setId(id);
		gss.setImgs(rd.getStr("imgs"));
		// gss.setLocation(location);
		gss.setModel(rd.getStr("model"));
		gss.setName(rd.getStr("name"));
		// gss.setNormalDeductAmount(normalDeductAmount);
		gss.setNumber(rd.getStr("number"));
		// gss.setRatioDeductRadix(ratioDeductRadix);
		// gss.setRatioDeductVal(ratioDeductVal);
		// gss.setRebateFlag(rebateFlag);
		// gss.setRebatePrice(rebatePrice);
		// gss.setReceives(receives);
		// gss.setSales(sales);
		gss.setSellFlag("1");// 已上架状态
		gss.setSiteId(siteId);
		gss.setSitePrice(rd.getBigDecimal("site_price").doubleValue());
		gss.setSortNum(0);
		gss.setSource("1");
		gss.setStatus("0");
		gss.setStocks(Double.valueOf(num));
		gss.setUnit(rd.getStr("unit"));
		gss.setUnitType(rd.getStr("unit_type"));
		gss.setRepairTerm(rd.getStr("repair_term"));
		goodsSiteSelfDao.save(gss);
		return gss;
	}

	public void getGsd(GoodsSiteSelf gss, String siteId, String num, Date dt) {
		String name = CrmUtils.getUserXM();
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setAmount(new BigDecimal(num));
		gsd.setApplicant(name);
		gsd.setApplyTime(dt);
		gsd.setConfirmor(name);
		gsd.setConfirmTime(dt);
		gsd.setCreateTime(dt);
		// gsd.setCustomerPrice(customerPrice);
		// gsd.setEmployePrice(employePrice);
		gsd.setGoodBrand(gss.getBrand());
		gsd.setGoodCategory(gss.getCategory());
		gsd.setGoodId(gss.getId());
		gsd.setGoodModel(gss.getModel());
		gsd.setGoodName(gss.getName());
		gsd.setGoodNumber(gss.getNumber());
		// gsd.setOrderId(orderId);
		// gsd.setPayMoney(payMoney);
		gsd.setSiteId(siteId);
		gsd.setSitePrice(new BigDecimal(gss.getSitePrice()));
		gsd.setStatus("0");
		gsd.setType("1");
		gsd.setUnit(gss.getUnit());
		goodsSiteselfDetailDao.save(gsd);
		logger.info("漏保购买记录点击入库生成入库明细记录--" + num);
	}

	public void burnDetail(Record rd, String siteId, String num, Date dt) {
		String name = CrmUtils.getUserXM();
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setAmount(new BigDecimal(num));
		gsd.setApplicant(name);
		gsd.setApplyTime(dt);
		gsd.setConfirmor(name);
		gsd.setConfirmTime(dt);
		gsd.setCreateTime(dt);
		gsd.setCustomerPrice(rd.getBigDecimal("customer_price"));
		gsd.setEmployePrice(rd.getBigDecimal("employe_price"));
		gsd.setGoodBrand(rd.getStr("brand"));
		gsd.setGoodCategory(rd.getStr("category"));
		gsd.setGoodId(rd.getStr("id"));
		gsd.setGoodModel(rd.getStr("model"));
		gsd.setGoodName(rd.getStr("name"));
		gsd.setGoodNumber(rd.getStr("number"));
		gsd.setSiteId(siteId);
		gsd.setSitePrice(rd.getBigDecimal("site_price"));
		gsd.setStatus("0");
		gsd.setType("1");
		gsd.setUnit(rd.getStr("unit"));
		goodsSiteselfDetailDao.save(gsd);
		logger.info("漏保购买记录点击入库生成入库明细记录--" + num);
	}

	@Transactional
	public Result<T> doInstocks(String goodName, String goodNumber, String num, String orderId) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Result<T> rt = new Result<T>();
		Date dt = new Date();
		Record rd = Db.findFirst("select a.* from crm_goods_platform_transfer_order a  where a.id=?", orderId);
		if ("1".equals(rd.getStr("if_instocks"))) {// 校验是否已经入库
			rt.setCode("421");
			rt.setErrMsg("already instocks");
			return rt;
		}
		Record sg = selfGoodByNumber(goodNumber, siteId);
		if (sg == null) {
			// 转自营
			Record pfg = Db.findFirst("select a.* from crm_goods_platform a where a.number=? and a.status='0'", rd.getStr("good_number"));
			if (pfg == null) {
				rt.setCode("422");
				rt.setErrMsg("not exist");
				return rt;
			}
			GoodsSiteSelf gss = getGss(pfg, siteId, num, dt);// 转自营
			getGsd(gss, siteId, num, dt);// 公司出入库记录
		} else {// 更新操作
			SQLQuery sql1 = goodsSiteselfDetailDao.getSession().createSQLQuery(
					"update crm_goods_siteself a set a.stocks=(a.stocks+'" + num + "') where a.status='0' and a.site_id='" + siteId + "' and a.number='" + goodNumber + "' ");
			sql1.executeUpdate();
			Record rdn = Db.findFirst("select a.* from crm_goods_siteself a where a.status='0' and a.site_id='" + siteId + "' and a.number='" + goodNumber + "' ");
			burnDetail(rdn, siteId, num, dt);
		}
		SQLQuery sql = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_platform_transfer_order a set a.if_instocks='1' where a.id='" + orderId + "' ");
		sql.executeUpdate();
		rt.setCode("200");
		rt.setMsg("instocks success");
		return rt;
	}

	public Record selfGoodByNumber(String goodNumber, String siteId) {
		return Db.findFirst("select a.* from crm_goods_siteself a where a.status='0' and a.site_id=? and a.number=?", siteId, goodNumber);
	}
	/*
	 * 查询单个服务商近三个月购买漏保的订单数据
	*/
	public List<Record> getGoodsOrderBySite(String siteId){
		return goodsPlatformTransferOrderDao.getGoodsOrderBySite(siteId);
	}
	/*
	 * 查询单个服务商近三个月购买漏保的订单数据
	 */
	public List<Record> getGoodsOrderSite(){
		return goodsPlatformTransferOrderDao.getGoodsOrderSite();
	}
}
