package com.jojowonet.modules.finance.service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.google.common.collect.Lists;
import com.jojowonet.modules.order.utils.TableSplitMapper;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.SiteselfOrderDao;
import com.jojowonet.modules.order.utils.TableMigrationMapper;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

@Component
@Transactional(readOnly = true)
public class FinanceOrderExcelService extends BaseService {
	@Autowired
	private SiteselfOrderDao siteselfOrderDao;

	//@Autowired
	//TableMigrationMapper tableMapper;

	@Autowired
	TableSplitMapper tableSplitMapper;

	public List<Record> getPlacingNameList(String siteId) {
		return Db.find("SELECT DISTINCT placing_name FROM crm_goods_siteself_order where site_id='" + siteId + "' ");
	}

	public List<Map<String, Object>> getAllList(String siteId, String placingName, String poTime, String poTime1) {
		if (StringUtils.isNotBlank(poTime1)) {
			try {
				Date d = DateUtils.parseDate(poTime1, "yyyy-MM-dd");
				d = DateUtils.addDays(d, 1);
				poTime1 = new SimpleDateFormat("yyyy-MM-dd").format(d);
			} catch (ParseException e) {
				throw new RuntimeException(e);
			}
		}
		List<Map<String, Object>> ret = new ArrayList<>();
		Map<String, Map<String, Object>> map = new TreeMap<>();
		StringBuilder sf1 = new StringBuilder();
		sf1.append("SELECT DISTINCT a.placing_name FROM crm_goods_siteself_order a where a.site_id='" + siteId + "' AND a.status!='0'");
		if (StringUtils.isNotEmpty(poTime)) {
			sf1.append(" and a.placing_order_time >='" + poTime + "'");
		}
		if (StringUtils.isNotEmpty(poTime1)) {
			sf1.append(" and a.placing_order_time<'" + poTime1 + "'");
		}
		if (StringUtils.isNotEmpty(placingName)) {
			sf1.append(" and a.placing_name='" + placingName + "'");
		}
		List<Record> emNames = Db.find(sf1.toString());
		BigDecimal lscbAll = new BigDecimal("0");// 零售成本
		BigDecimal lslrAll = new BigDecimal("0");// 零售利润
		BigDecimal confirmAmountAll = new BigDecimal("0");// 零售金额
		BigDecimal salesCommissionsAll = new BigDecimal("0");// 提成金额
		for (Record rd : emNames) {
			StringBuilder sf = new StringBuilder();
			Map<String, Object> map1 = new HashMap<>();
			String emName = rd.getStr("placing_name");
			sf.append(" SELECT a.*,(a.purchase_num*b.site_price) AS lsChengben,(a.confirm_amount-a.sales_commissions-(a.purchase_num*b.site_price)) AS lsLsrun ");
			sf.append(" FROM crm_goods_siteself_order a  ");
			sf.append("LEFT JOIN crm_goods_siteself_order_goods_detail c ON c.order_id=a.id AND c.status='0'");
			sf.append(" LEFT JOIN crm_goods_siteself b ON c.good_id=b.id  ");
			sf.append(" WHERE  a.placing_name='" + emName + "' and a.site_id='" + siteId + "' and a.status !='0' ");
			if (StringUtils.isNotBlank(poTime)) {
				sf.append(" and a.placing_order_time>='" + poTime + "'");
			}
			if (StringUtils.isNotBlank(poTime1)) {
				sf.append(" and a.placing_order_time<'" + poTime1 + "'");
			}
			List<Record> listByName = Db.find(sf.toString());
			BigDecimal lsChengben = new BigDecimal("0");// 零售成本
			BigDecimal lsLsrun = new BigDecimal("0");// 零售利润
			BigDecimal confirmAmount = new BigDecimal("0");// 零售金额
			BigDecimal salesCommissions = new BigDecimal("0");// 提成金额
			for (Record r : listByName) {
				if (r.getBigDecimal("lsChengben") != null) {
					lsChengben = lsChengben.add(r.getBigDecimal("lsChengben"));
				}
				if (r.getBigDecimal("lsLsrun") != null) {
					lsLsrun = lsLsrun.add(r.getBigDecimal("lsLsrun"));
				}
				if (r.getBigDecimal("confirm_amount") != null) {
					confirmAmount = confirmAmount.add(r.getBigDecimal("confirm_amount"));
				}
				if (r.getBigDecimal("sales_commissions") != null) {
					salesCommissions = salesCommissions.add(r.getBigDecimal("sales_commissions"));
				}
			}
			lscbAll = lscbAll.add(lsChengben);
			lslrAll = lslrAll.add(lsLsrun);
			confirmAmountAll = confirmAmountAll.add(confirmAmount);
			salesCommissionsAll = salesCommissionsAll.add(salesCommissions);
			map1.put("lsChengben", lsChengben);
			map1.put("lsLsrun", lsLsrun);
			map1.put("confirmAmount", confirmAmount);
			map1.put("salesCommissions", salesCommissions);
			map1.put("emName", emName);
			map.put(emName, map1);

		}
		Map<String, Object> map2 = new HashMap();
		map2.put("lscbAll", lscbAll);
		map2.put("lslrAll", lslrAll);
		map2.put("confirmAmountAll", confirmAmountAll);
		map2.put("salesCommissionsAll", salesCommissionsAll);
		map.put("heji", map2);
		ret.addAll(map.values());
		return ret;
	}

	public List<Record> summation(String siteId, String placingName, String poTime, String poTime1) {
		StringBuilder sf = new StringBuilder();
		sf.append(
				"SELECT a.*,(a.purchase_num*b.site_price) AS lsChengben,(a.confirm_amount-a.sales_commissions-(a.purchase_num*b.site_price)) AS lsLsrun FROM crm_goods_siteself_order a  LEFT JOIN crm_goods_siteself b ON a.good_id=b.id   WHERE  a.site_id='"
						+ siteId + "' and a.status !='0'");
		if (StringUtils.isNotEmpty(placingName)) {
			sf.append(" and a.placing_name='" + placingName + "'");
		}
		if (StringUtils.isNotEmpty(poTime)) {
			sf.append(" and a.placing_order_time >='" + poTime + "'");
		}
		if (StringUtils.isNotEmpty(poTime1)) {
			sf.append(" and a.placing_name<'" + poTime1 + "'");
		}
		return Db.find(sf.toString());
	}

	public Page<Record> financeOrderExcelGrid(Page<Record> page, String siteId, Map<String, Object> map) {
		List<Record> records = siteselfOrderDao.getFinanceOrderExcelList(page, siteId, map);
		Long count = siteselfOrderDao.queryCount(siteId, map);
		page.setCount(count);
		page.setList(records);
		return page;
	}

	public List<Record> getEmployeList(String siteId) {
		return Db.find("SELECT a.name,a.status,a.id FROM crm_employe a WHERE a.site_id='" + siteId + "' AND a.status in ('0','3') order by a.status asc");
	}

	public Long orderCount(String siteId, Map<String, Object> map, String migration) {// 工单总数
		StringBuilder sf = new StringBuilder();
		sf.append("select count(*) from ").append(" crm_order a where a.site_id=? and (a.status = '5' or  a.status = '3' or  a.status = '4') ");
		sf.append(selectConditions(map));
		long l1 = Db.queryLong(sf.toString(), siteId);

		long l2 = 0l;
		if(tableSplitMapper.exists(siteId)){
			sf = new StringBuilder();
			sf.append("select count(*) from ").append(tableSplitMapper.mapOrder(siteId)).append(" a where a.site_id=? and (a.status = '5' or  a.status = '3' or  a.status = '4') ");
			sf.append(selectConditions(map));
			l2 = Db.queryLong(sf.toString(), siteId);
		}

		return l1 + l2;
	}

	public BigDecimal confirmMoney(String siteId, Map<String, Object> map, String migration) {// 实收金额
		StringBuilder sf = new StringBuilder();
		sf.append(" select * from ( ");
		sf.append("select a.* from ").append(" crm_order a where a.site_id=? and (a.status = '5' or  a.status = '3' or  a.status = '4') ");
		sf.append(selectConditions(map));
		if(tableSplitMapper.exists(siteId)){
			sf.append(" union all ");
			sf.append("select a.* from ").append(tableSplitMapper.mapOrder(siteId)).append(" a where a.site_id=? and (a.status = '5' or  a.status = '3' or  a.status = '4') ");
			sf.append(selectConditions(map));
		}
		sf.append(" ) as ot ");

		List<Record> records = null;
		if(tableSplitMapper.exists(siteId)){
			records = Db.find(sf.toString(), siteId, siteId);
		}else{
			records = Db.find(sf.toString(), siteId);
		}

		BigDecimal confirmMoney = new BigDecimal("0");
		if (records.size() > 0) {
			for (Record rd : records) {
				BigDecimal money = rd.getBigDecimal("confirm_cost");
				if (money != null) {
					confirmMoney = confirmMoney.add(money);
				}
			}
		}
		return confirmMoney;
	}

	public Long yjsOrderCount(String siteId, Map<String, Object> map, String migration) {//// 已结算工单
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT COUNT(*) FROM ").append(" crm_order a inner JOIN  ").append(" crm_order_settlement b ON a.id=b.order_id WHERE a.site_id=?  AND (a.status = '5') ");
		sf.append(selectConditions(map));

		long l1 = Db.queryLong(sf.toString(), siteId);
		long l2 = 0l;
		if(tableSplitMapper.exists(siteId)){
			sf = new StringBuilder();
			sf.append("SELECT COUNT(*) FROM ").append(tableSplitMapper.mapOrder(siteId)).append(" a inner JOIN  ").append(tableSplitMapper.mapOrderSettlement(siteId))
					.append(" b ON a.id=b.order_id WHERE a.site_id=?  AND (a.status = '5') ");
			sf.append(selectConditions(map));
			l2 = Db.queryLong(sf.toString(), siteId);
		}
		return l1 + l2;
	}

	public BigDecimal sumMoney(String siteId, Map<String, Object> map, String migration) {// 结算金额
		StringBuilder sf = new StringBuilder();
		sf.append(" select * from ( ");
		sf.append("SELECT b.sum_money FROM ").append(" crm_order a LEFT JOIN  ").append(" crm_order_settlement_detail b ON a.id=b.order_id WHERE a.site_id=?  AND (a.status = '5' ) and b.service_measures!='当日支付' ");
		sf.append(selectConditions(map));

		if(tableSplitMapper.exists(siteId)){
			sf.append(" union all ");
			sf.append("SELECT b.sum_money FROM ").append(tableSplitMapper.mapOrder(siteId)).append(" a LEFT JOIN  ").append(tableSplitMapper.mapOrderSettlementDetail(siteId))
					.append(" b ON a.id=b.order_id WHERE a.site_id=?  AND (a.status = '5' ) and b.service_measures!='当日支付' ");
			sf.append(selectConditions(map));
		}

		sf.append(" ) as ot ");
		List<Record> records = null;
		if(tableSplitMapper.exists(siteId)){
			records = Db.find(sf.toString(), siteId, siteId);
		}else{
			records = Db.find(sf.toString(), siteId);
		}

		BigDecimal sumMoney = new BigDecimal("0");
		if (records.size() > 0) {
			for (Record rd : records) {
				BigDecimal money = rd.getBigDecimal("sum_money");
				if (money != null) {
					sumMoney = sumMoney.add(money);
				}
			}
		}
		return sumMoney;
	}

	public String selectConditions(Map<String, Object> map) {// 查询条件
		StringBuilder stringBuilder = new StringBuilder();
		if (map != null) {
			String warrantyType = getTrimmedParamValue(map, "warrantyType");
			if (StringUtils.isNotEmpty(warrantyType)) {
				stringBuilder.append(" and a.warranty_type = '" + warrantyType + "' ");
			}
			String applianceBrand = getTrimmedParamValue(map, "applianceBrand");
			if (StringUtils.isNotEmpty(applianceBrand)) {
				stringBuilder.append(" and a.appliance_brand = '" + applianceBrand + "' ");
			}
			String applianceCategory = getTrimmedParamValue(map, "applianceCategory");
			if (StringUtils.isNotEmpty(applianceCategory)) {
				stringBuilder.append(" and a.appliance_category = '" + applianceCategory + "' ");
			}

			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				stringBuilder.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:00' ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				stringBuilder.append(" and a.repair_time <= '" + repairTimeMax + " 23:59:59' ");
			}

			String endTimeMin = getTrimmedParamValue(map, "endTimeMin");
			if (StringUtils.isNotEmpty(endTimeMin)) {
				stringBuilder.append(" and a.end_time >= '" + endTimeMin + " 00:00:00' ");
			}
			String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				stringBuilder.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
		}
		return stringBuilder.toString();
	}

	private String getParamValue(Map<String, Object> map, String param) {
		Object value = map.get(param);
		return value == null ? null : (map.get(param).toString());
	}

	private String getTrimmedParamValue(Map<String, Object> map, String param) {
		return StringUtils.trim(getParamValue(map, param));
	}

	public List<Record> employeOrderDetailList(String siteId, Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT a.name,IFNULL(od.wjs,0) AS wjs,IFNULL(od.yjs,0) AS yjs,IFNULL(SUM(od.sm),0) AS tatol  FROM crm_employe a ");
		sf.append(" LEFT JOIN  ( SELECT ot3.emp_name, SUM(CASE WHEN ot3.status = '5' THEN ot3.sum_money ELSE 0 END) AS sm , ");
		sf.append(" COUNT(CASE WHEN ot3.status IN ('3', '4') THEN 1 END) AS wjs,COUNT(CASE WHEN ot3.status = '5' THEN 1 END) AS yjs  ");
		sf.append(" FROM ( SELECT DISTINCT ot2.order_id, ot2.sum_money, ot2.emp_name, ot2.end_time, ot1.status FROM ( ");
		sf.append(" SELECT a.order_id, a.sum_money, b.emp_name, c.end_time FROM crm_order_settlement_detail a ");
		sf.append(" INNER JOIN crm_order_dispatch_employe_rel b ON b.dispatch_id = a.dispatch_id ");
		sf.append(" LEFT JOIN crm_order_dispatch c ON c.id = a.dispatch_id AND c.status = '5'  AND c.site_id =? ");
		sf.append("WHERE  a.employe_name = b.emp_name  ) ot2 LEFT JOIN ( ");
		sf.append("SELECT a.id AS order_id, a.status FROM crm_order a WHERE a.site_id =? AND a.status IN ('3','4','5') ");
		sf.append(selectConditions(map));
		sf.append(" ) ot1 ON ot2.order_id = ot1.order_id WHERE ot2.end_time IS NOT NULL ) ot3 GROUP BY ot3.emp_name  ");
		sf.append(" ) od ON a.name = od.emp_name  WHERE a.site_id = 'ff808081586cc3d701586ce8bef50003' AND a.status = '0'  GROUP BY a.name  ");
		return Db.find(sf.toString(), siteId, siteId);

	}

}
