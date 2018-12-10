package com.jojowonet.modules.finance.dao;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.utils.*;
import com.jojowonet.modules.sys.util.ActiveRecordUtil;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
public class RevenueDao {

	//@Autowired
	//TableMigrationMapper tableMapper;

	@Autowired
	TableSplitMapper tableSplitMapper;
	@Autowired
	OrderDao orderDao;
	private static Logger logger = Logger.getLogger(RevenueDao.class);

//	public List<Record> getOrderRevenueList(Page<Record> page, Map<String, Object> map) {
//		return getOrderRevenueList(page, map);
//	}

	public List<Record> getOrderRevenueList(Page<Record> page, Map<String, Object> map, Tuple<Long, Long> countTuple) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		System.out.println("::the page no is:"  + page.getPageNo());
		System.out.println("::tuple val is:"  + countTuple.getVal1() + ";val2=" + countTuple.getVal2());

		List<Record> currentOrders = new ArrayList<>();
		if((page.getPageNo() - 1) * page.getPageSize() < countTuple.getVal1() ) {
			StringBuilder sb = new StringBuilder("");
			sb.append(
					" select a.migration,a.id,a.callback_cost, a.number, a.warranty_type, a.appliance_category,a.appliance_num, a.appliance_model,a.appliance_brand, a.service_type, ");
			sb.append(" a.serve_cost, a.auxiliary_cost, a.warranty_cost, a.confirm_cost, a.whether_collection,a.review_time, ");
			sb.append(
					" a.employe_id, a.employe_name,a.review, b.sum_money, b.payment_amount, b.cost_detail,b.factory_money,b.fitting_costs,b.profits,DATE_FORMAT(b.settlement_time,'%Y-%m-%d') as settlement_time, b.remarks,b.settlement_detail,b.service_measures as sm,");
			sb.append(" a.origin, a.order_type, a.customer_name, a.customer_mobile, a.customer_address, a.appliance_barcode, ");
			sb.append(" a.appliance_machine_code, a.repair_time, a.end_time,a.pay_time, ");
			sb.append(" a.dispatch_time ");
			sb.append(" from crm_order a ");
			sb.append(" left join crm_order_settlement b on b.order_id = a.id ");
			sb.append(" where a.status in('5', '3','4') ");
			sb.append(" and a.site_id =? ");
			sb.append(getOrderRevenueFilter(map));
			sb.append(" order by a.repair_time desc ");
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
			currentOrders = Db.find(sb.toString(), siteId);
			if (currentOrders.size() == page.getPageSize()) {
				logger.info("::revenue current order is enough");
				return currentOrders;
			}
		}

		if (tableSplitMapper.exists(siteId)) {
			long left = page.getPageSize() - currentOrders.size();
			long realOffset = (page.getPageNo()-1)*page.getPageSize()-countTuple.getVal1();
			realOffset = realOffset <0 ? 0 : realOffset;

			System.out.println("::realOff=" + realOffset + ";left=" + left);
			StringBuilder sb1 = new StringBuilder("");
			sb1.append(
					" select a.migration,a.id,a.callback_cost, a.number, a.warranty_type, a.appliance_category,a.appliance_num, a.appliance_model,a.appliance_brand, a.service_type, ");
			sb1.append(" a.serve_cost, a.auxiliary_cost, a.warranty_cost, a.confirm_cost, a.whether_collection,a.review_time, ");
			sb1.append(
					" a.employe_id, a.employe_name,a.review, b.sum_money, b.payment_amount, b.cost_detail,b.factory_money,b.fitting_costs,b.profits,DATE_FORMAT(b.settlement_time,'%Y-%m-%d') as settlement_time, b.remarks,b.settlement_detail,b.service_measures as sm,");
			sb1.append(" a.origin, a.order_type, a.customer_name, a.customer_mobile, a.customer_address, a.appliance_barcode, ");
			sb1.append(" a.appliance_machine_code, a.repair_time, a.end_time,a.pay_time, ");
			sb1.append(" a.dispatch_time ");
			sb1.append(" from " + tableSplitMapper.mapOrder(siteId) + " a ");
			sb1.append(" left join " + tableSplitMapper.mapOrderSettlement(siteId) + " b on b.order_id = a.id ");
			sb1.append(" where a.status in('5', '3','4') ");
			sb1.append(" and a.site_id =? ");
			sb1.append(getOrderRevenueFilter(map));
			sb1.append(" order by a.repair_time desc ");
			sb1.append(" limit " + page.getPageSize() + " offset " + realOffset);
			List<Record> records = Db.find(sb1.toString(), siteId);
			for (int i=0;i<records.size()&&i<left;i++) {
				currentOrders.add(records.get(i));
			}

		}

//		sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
//		if (tableSplitMapper.exists(siteId)) {
//			return Db.find(sb.toString(), siteId, siteId);
//		}
//		return Db.find(sb.toString(), siteId);
		return currentOrders;
	}

	public Record getOrderRevenueListCountMoney(Map<String, Object> map, String migration) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		long s1 = System.currentTimeMillis();
		Record nowRd = getOrderRevenueListCountMoney_now(map, siteId);
		long s2 = System.currentTimeMillis();
		System.out.println(" >> getOrderRevenueListCountMoney S2:" + (s2 - s1));
		Record historyRd = getOrderRevenueListCountMoney_history(map, siteId);
		long s3 = System.currentTimeMillis();
		Record finalRd = ActiveRecordUtil.combineRecord(nowRd, historyRd);
		long s4 = System.currentTimeMillis();
		System.out.println(" >> getOrderRevenueListCountMoney S4:" + (s4 - s3));
		return finalRd;
	}

	public Record getOrderRevenueListCountMoney_now(Map<String, Object> map, String siteId) {
		/*StringBuilder sb = new StringBuilder("");
		sb.append("select sum(ff.serve_cost) as serve_cost_count,sum(ff.auxiliary_cost) as auxiliary_cost_count,sum(ff.warranty_cost) as warranty_cost_count,");
		sb.append(" sum(ff.confirm_cost) as confirm_cost_count,sum(ff.callback_cost) as callback_cost_count,");
		sb.append(" sum(ff.serve_cost+ff.auxiliary_cost+ff.warranty_cost) as costs_count,sum(ff.factory_money) as factory_money_count,sum(ff.profits) as profits_count, ");
		sb.append(" sum(ff.sum_money) as sum_money_count,sum(ff.payment_amount) as payment_amount_count,sum(ff.fitting_costs) as fitting_costs_count ");
		sb.append(
				"  from ( select a.migration,a.id,a.callback_cost, a.number, a.warranty_type, a.appliance_category,a.appliance_num, a.appliance_model,a.appliance_brand, a.service_type, ");
		sb.append(" a.serve_cost, a.auxiliary_cost, a.warranty_cost, a.confirm_cost, a.whether_collection,a.review_time, ");
		sb.append(
				" a.employe_id, a.employe_name,a.review, b.sum_money, b.payment_amount, b.cost_detail,b.factory_money,b.fitting_costs,b.profits,DATE_FORMAT(b.settlement_time,'%Y-%m-%d') as settlement_time, b.remarks,b.settlement_detail,b.service_measures as sm,");
		sb.append(" a.origin, a.order_type, a.customer_name, a.customer_mobile, a.customer_address, a.appliance_barcode, ");
		sb.append(" a.appliance_machine_code, a.repair_time, a.end_time,a.pay_time, ");
		sb.append("(select f.dispatch_time from `crm_order_dispatch` as f where f.`order_id`=a.`id` order by  f.update_time desc limit 1) AS dispatch_time ");
		sb.append(" from crm_order a ");
		sb.append(" left join crm_order_settlement b on b.order_id = a.id ");
		sb.append(" where a.status in('5', '3','4') ");
		sb.append(" and a.site_id =? ");
		sb.append(getOrderRevenueFilter(map));
		sb.append(") as ff");
		return Db.findFirst(sb.toString(), siteId);*/
		StringBuilder sb = new StringBuilder("");
		sb.append(" select  a.serve_cost, a.auxiliary_cost, a.warranty_cost, a.confirm_cost, a.callback_cost, ");
		sb.append(" b.factory_money, b.profits, b.sum_money, b.payment_amount, b.fitting_costs ");
		sb.append(" from crm_order a left join crm_order_settlement b on b.order_id = a.id and b.site_id = a.site_id ");
		sb.append(" where  a.site_id ='"+siteId+"' ");
		sb.append(" and a.status in('5', '3','4') ");
		sb.append(getOrderRevenueFilter(map));

		List<Record> rds = Db.find(sb.toString());
		Record rd = manualCountOrderRevenueMoney(rds);
		return rd;
	}

	public Record manualCountOrderRevenueMoney(List<Record> rds){
		Record retRd = new Record();
		retRd.set("serve_cost_count", new BigDecimal(0));
		retRd.set("auxiliary_cost_count", new BigDecimal(0));
		retRd.set("warranty_cost_count", new BigDecimal(0));
		retRd.set("confirm_cost_count", new BigDecimal(0));
		retRd.set("callback_cost_count", new BigDecimal(0));
		retRd.set("costs_count", new BigDecimal(0));
		retRd.set("factory_money_count", new BigDecimal(0));
		retRd.set("profits_count", new BigDecimal(0));
		retRd.set("sum_money_count", new BigDecimal(0));
		retRd.set("payment_amount_count", new BigDecimal(0));
		retRd.set("fitting_costs_count", new BigDecimal(0));
		if(rds == null){
			return retRd;
		}

		long s1 = System.currentTimeMillis();
		System.out.println(" start >> manualCountOrderRevenueMoney size:" + rds.size());

		for(Record rd : rds){
			BigDecimal serve_cost_count = rd.get("serve_cost", new BigDecimal(0));
			BigDecimal auxiliary_cost_count = rd.get("auxiliary_cost", new BigDecimal(0));
			BigDecimal warranty_cost_count = rd.get("warranty_cost", new BigDecimal(0));
			BigDecimal confirm_cost_count = rd.get("confirm_cost", new BigDecimal(0));
			BigDecimal callback_cost_count = rd.get("callback_cost", new BigDecimal(0));

			BigDecimal costs_count = serve_cost_count.add(auxiliary_cost_count).add(warranty_cost_count);
			BigDecimal factory_money_count = rd.get("factory_money", new BigDecimal(0));
			BigDecimal profits_count = rd.get("profits", new BigDecimal(0));
			BigDecimal sum_money_count = rd.get("sum_money", new BigDecimal(0));
			BigDecimal payment_amount_count = rd.get("payment_amount", new BigDecimal(0));
			BigDecimal fitting_costs_count = rd.get("fitting_costs", new BigDecimal(0));

			retRd.set("serve_cost_count", ((BigDecimal)retRd.get("serve_cost_count")).add(serve_cost_count));
			retRd.set("auxiliary_cost_count", ((BigDecimal)retRd.get("auxiliary_cost_count")).add(auxiliary_cost_count));
			retRd.set("warranty_cost_count", ((BigDecimal)retRd.get("warranty_cost_count")).add(warranty_cost_count));
			retRd.set("confirm_cost_count", ((BigDecimal)retRd.get("confirm_cost_count")).add(confirm_cost_count));
			retRd.set("callback_cost_count", ((BigDecimal)retRd.get("callback_cost_count")).add(callback_cost_count));
			retRd.set("costs_count", ((BigDecimal)retRd.get("costs_count")).add(costs_count));
			retRd.set("factory_money_count", ((BigDecimal)retRd.get("factory_money_count")).add(factory_money_count));
			retRd.set("profits_count", ((BigDecimal)retRd.get("profits_count")).add(profits_count));
			retRd.set("sum_money_count", ((BigDecimal)retRd.get("sum_money_count")).add(sum_money_count));
			retRd.set("payment_amount_count", ((BigDecimal)retRd.get("payment_amount_count")).add(payment_amount_count));
			retRd.set("fitting_costs_count", ((BigDecimal)retRd.get("fitting_costs_count")).add(fitting_costs_count));
		}
		System.out.println(" end >> manualCountOrderRevenueMoney time:" + (System.currentTimeMillis() - s1));
		return retRd;
	}

	public Record getOrderRevenueListCountMoney_history(Map<String, Object> map, String siteId) {
		long s1 = System.currentTimeMillis();
		if (!tableSplitMapper.exists(siteId)) {
			return new Record();
		}
		/*StringBuilder sb = new StringBuilder("");
		sb.append("select sum(ff.serve_cost) as serve_cost_count,sum(ff.auxiliary_cost) as auxiliary_cost_count,sum(ff.warranty_cost) as warranty_cost_count,");
		sb.append(" sum(ff.confirm_cost) as confirm_cost_count,sum(ff.callback_cost) as callback_cost_count,");
		sb.append(" sum(ff.serve_cost+ff.auxiliary_cost+ff.warranty_cost) as costs_count,sum(ff.factory_money) as factory_money_count,sum(ff.profits) as profits_count, ");
		sb.append(" sum(ff.sum_money) as sum_money_count,sum(ff.payment_amount) as payment_amount_count,sum(ff.fitting_costs) as fitting_costs_count ");
		sb.append(
				"  from ( select a.migration,a.id,a.callback_cost, a.number, a.warranty_type, a.appliance_category,a.appliance_num, a.appliance_model,a.appliance_brand, a.service_type, ");
		sb.append(" a.serve_cost, a.auxiliary_cost, a.warranty_cost, a.confirm_cost, a.whether_collection,a.review_time, ");
		sb.append(
				" a.employe_id, a.employe_name,a.review, b.sum_money, b.payment_amount, b.cost_detail,b.factory_money,b.fitting_costs,b.profits,DATE_FORMAT(b.settlement_time,'%Y-%m-%d') as settlement_time, b.remarks,b.settlement_detail,b.service_measures as sm,");
		sb.append(" a.origin, a.order_type, a.customer_name, a.customer_mobile, a.customer_address, a.appliance_barcode, ");
		sb.append(" a.appliance_machine_code, a.repair_time, a.end_time,a.pay_time, ");
		sb.append("(select f.dispatch_time from `").append(tableSplitMapper.mapOrderDispatch(siteId))
				.append("` as f where f.`order_id`=a.`id` order by  f.update_time desc limit 1) AS dispatch_time ");
		sb.append(" from ").append(tableSplitMapper.mapOrder(siteId)).append(" a ");
		sb.append(" left join ").append(tableSplitMapper.mapOrderSettlement(siteId)).append(" b on b.order_id = a.id ");
		sb.append(" where a.status in('5', '3','4') ");
		sb.append(" and a.site_id =? ");
		sb.append(getOrderRevenueFilter(map));
		sb.append(") as ff");
		return Db.findFirst(sb.toString(), siteId);*/

		StringBuilder sb = new StringBuilder("");
		sb.append(" select  a.serve_cost, a.auxiliary_cost, a.warranty_cost, a.confirm_cost, a.callback_cost, ");
		sb.append(" b.factory_money, b.profits, b.sum_money, b.payment_amount, b.fitting_costs ");
		sb.append(" from "+tableSplitMapper.mapOrder(siteId)+" a left join "+tableSplitMapper.mapOrderSettlement(siteId)+" b on b.order_id = a.id and b.site_id = a.site_id ");
		sb.append(" where  a.site_id ='"+siteId+"' ");
		sb.append(" and a.status ='5' ");
		sb.append(getOrderRevenueFilter(map));

		List<Record> rds = Db.find(sb.toString());
		long s2 = System.currentTimeMillis();
		System.out.println(" >> getOrderRevenueListCountMoney_history time:" + (s2 -s1));
		Record rd = manualCountOrderRevenueMoney(rds);
		return rd;
	}

	public List<Record> getOrderJSCountList(Map<String, Object> map, String migration, String type) {
		/*
		 * StringBuilder sb = new StringBuilder(""); sb.
		 * append("SELECT count(*) as orderCounts,SUM(hh.serve_cost) AS serve_cost_emp,SUM(hh.auxiliary_cost) AS auxiliary_cost_emp,SUM(hh.warranty_cost) AS warranty_cost_emp"
		 * ); sb.
		 * append(" ,SUM(hh.confirm_cost) AS confirm_cost_emp,SUM(hh.callback_cost) AS callback_cost_emp,SUM(hh.serve_cost+hh.auxiliary_cost+hh.warranty_cost) AS costs_emp"
		 * ); sb.append(
		 * " ,SUM(hh.sum_money) AS sum_money_emp,SUM(hh.payment_amount) AS payment_amount_emp,SUM(hh.factory_money) AS factory_money_emp,SUM(hh.fitting_costs) AS fitting_costs_emp,SUM(hh.profits)  AS profits_emp"
		 * ); sb.
		 * append(" FROM (SELECT a.id,a.serve_cost,a.auxiliary_cost,a.warranty_cost,a.confirm_cost,"
		 * ); sb.
		 * append(" a.callback_cost,b.sum_money,b.payment_amount,b.cost_detail,b.factory_money,b.fitting_costs,b.profits"
		 * ); sb.append(" FROM ").append(tableMapper.mapOrder(migration)).
		 * append("  a LEFT JOIN ").append(tableMapper.mapOrderSettlement(migration)).
		 * append(" b ON b.order_id = a.id ");
		 * sb.append("  WHERE a.status IN ('5', '3', '4') AND a.site_id = ?"); //
		 * sb.append(" AND a.repair_time >= '2018-01-01 00:00:00' AND a.repair_time <=
		 * // '2018-09-10 23:59:59' "); sb.append(getOrderRevenueConditions(map)); if
		 * ("2".equals(type)) {// 待结算 sb.append(" and b.id is null "); } if
		 * ("1".equals(type)) {// 已结算 sb.append(" and b.id is not null "); }
		 * sb.append(" ORDER BY a.`id` ) AS hh "); String siteId =
		 * CrmUtils.getCurrentSiteId(UserUtils.getUser()); return Db.find(sb.toString(),
		 * siteId);
		 */

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> nowRds = getOrderJSCountList_now(map, type, siteId);
		List<Record> historyRds = getOrderJSCountList_history(map, type, siteId);

		List<Record> finalRds = ActiveRecordUtil.combineRecords("lgId", nowRds, historyRds);
		return finalRds;
	}

	public List<Record> getOrderJSCountList_now(Map<String, Object> map, String type, String siteId) {
		StringBuilder sb = new StringBuilder("");
		sb.append(
				"SELECT '1' as lgId, count(*) as orderCounts,SUM(hh.serve_cost) AS serve_cost_emp,SUM(hh.auxiliary_cost) AS auxiliary_cost_emp,SUM(hh.warranty_cost) AS warranty_cost_emp");
		sb.append(" ,SUM(hh.confirm_cost) AS confirm_cost_emp,SUM(hh.callback_cost) AS callback_cost_emp,SUM(hh.serve_cost+hh.auxiliary_cost+hh.warranty_cost) AS costs_emp");
		sb.append(
				" ,SUM(hh.sum_money) AS sum_money_emp,SUM(hh.payment_amount) AS payment_amount_emp,SUM(hh.factory_money) AS factory_money_emp,SUM(hh.fitting_costs) AS fitting_costs_emp,SUM(hh.profits)  AS profits_emp");
		sb.append(" FROM (SELECT a.id,a.serve_cost,a.auxiliary_cost,a.warranty_cost,a.confirm_cost,");
		sb.append(" a.callback_cost,b.sum_money,b.payment_amount,b.cost_detail,b.factory_money,b.fitting_costs,b.profits");
		sb.append(" FROM crm_order  a LEFT JOIN crm_order_settlement b ON b.order_id = a.id ");
		sb.append("  WHERE a.status IN ('5', '3', '4') AND a.site_id = ?");
		sb.append(getOrderRevenueConditions(map));
		if ("2".equals(type)) {// 待结算
			sb.append(" and b.id is null ");
		} else if ("1".equals(type)) {// 已结算
			sb.append(" and b.id is not null ");
		}
		sb.append(" ) AS hh ");
		return Db.find(sb.toString(), siteId);
	}

	public List<Record> getOrderJSCountList_history(Map<String, Object> map, String type, String siteId) {
		if (!tableSplitMapper.exists(siteId)) {
			return Lists.newArrayList();
		}
		StringBuilder sb = new StringBuilder("");
		sb.append(
				"SELECT '1' as lgId, count(*) as orderCounts,SUM(hh.serve_cost) AS serve_cost_emp,SUM(hh.auxiliary_cost) AS auxiliary_cost_emp,SUM(hh.warranty_cost) AS warranty_cost_emp");
		sb.append(" ,SUM(hh.confirm_cost) AS confirm_cost_emp,SUM(hh.callback_cost) AS callback_cost_emp,SUM(hh.serve_cost+hh.auxiliary_cost+hh.warranty_cost) AS costs_emp");
		sb.append(
				" ,SUM(hh.sum_money) AS sum_money_emp,SUM(hh.payment_amount) AS payment_amount_emp,SUM(hh.factory_money) AS factory_money_emp,SUM(hh.fitting_costs) AS fitting_costs_emp,SUM(hh.profits)  AS profits_emp");
		sb.append(" FROM (SELECT a.id,a.serve_cost,a.auxiliary_cost,a.warranty_cost,a.confirm_cost,");
		sb.append(" a.callback_cost,b.sum_money,b.payment_amount,b.cost_detail,b.factory_money,b.fitting_costs,b.profits");
		sb.append(" FROM " + tableSplitMapper.mapOrder(siteId) + "  a LEFT JOIN " + tableSplitMapper.mapOrderSettlement(siteId) + " b ON b.order_id = a.id ");
		sb.append("  WHERE a.status IN ('5', '3', '4') AND a.site_id = ?");
		sb.append(getOrderRevenueConditions(map));
		if ("2".equals(type)) {// 待结算
			sb.append(" and b.id is null ");
		} else if ("1".equals(type)) {// 已结算
			sb.append(" and b.id is not null ");
		}
		sb.append(" ) AS hh ");
		return Db.find(sb.toString(), siteId);
	}

	public List<Record> getEmployeDetail(Page<Record> page, Map<String, Object> map, String siteId) {
		return getEmployeDetail(page, map, siteId, null);
	}

	public List<Record> getEmployeDetail(Page<Record> page, Map<String, Object> map, String siteId, Tuple<Long, Long> tuple) {
		/*
		 * SqlKit sb = new SqlKit(); sb.
		 * append("select a.number,b.remarks,a.service_type,a.warranty_type,a.appliance_model,a.appliance_brand,a.review,a.appliance_category,a.customer_name,a.customer_mobile,a.customer_address,a.repair_time,a.end_time,b.settlement_time,b.cost_detail,b.service_measures as deMeasures,(CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,\r\n"
		 * +
		 * "  (CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName,b.create_time as deCreateTime"
		 * );
		 * sb.append("from ").append(tableMapper.mapOrderSettlementDetail(migration)).
		 * append(" b"); sb.append("left join ").append(tableMapper.mapOrder(migration))
		 * .append(" a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3') where b.site_id='"
		 * + siteId + "' and a.status != '8'  ");
		 * sb.append(getEmployeDetailconditions(map)); if (page != null) {
		 * sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() -
		 * 1) * page.getPageSize()); } return Db.find(sb.toString());
		 */
/*

		SqlKit sb = new SqlKit();

		sb.append(" select * from ( ");
		sb.append("select a.number,b.remarks,a.service_type,a.warranty_type,a.appliance_model,a.appliance_brand,a.review,a.appliance_category,a.customer_name,a.customer_mobile,a.customer_address,a.repair_time,a.end_time,b.settlement_time,b.cost_detail,b.service_measures as deMeasures,(CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,\r\n"
						+ "  (CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName,b.create_time as deCreateTime");
		sb.append("from crm_order_settlement_detail b");
		sb.append("left join crm_order a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3') where b.site_id='" + siteId
				+ "' and a.status != '8'  ");
		sb.append(getEmployeDetailconditions(map));

		if (tableSplitMapper.exists(siteId)) {
			sb.append(" union all ");
			sb.append("select a.number,b.remarks,a.service_type,a.warranty_type,a.appliance_model,a.appliance_brand,a.review,a.appliance_category,a.customer_name,a.customer_mobile,a.customer_address,a.repair_time,a.end_time,b.settlement_time,b.cost_detail,b.service_measures as deMeasures,(CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,\r\n"
							+ "  (CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName,b.create_time as deCreateTime");
			sb.append("from " + tableSplitMapper.mapOrderSettlementDetail(siteId) + " b");
			sb.append("left join " + tableSplitMapper.mapOrder(siteId)
					+ " a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3') where b.site_id='" + siteId + "' and a.status != '8'  ");
			sb.append(getEmployeDetailconditions(map));
		}
		sb.append(" ) as ot0 ");

		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
*/


		SqlKit sb = new SqlKit();
		sb.append("select a.number,b.remarks,a.service_type,a.warranty_type,a.appliance_model,a.appliance_brand,a.review,a.appliance_category,a.customer_name,a.customer_mobile,a.customer_address,a.repair_time,a.end_time,b.settlement_time,b.cost_detail,b.service_measures as deMeasures,(CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,\r\n"
				+ "  (CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName,b.create_time as deCreateTime");
		sb.append("from crm_order_settlement_detail b");
		sb.append("left join crm_order a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3') where b.site_id='" + siteId
				+ "' and a.status != '8'  ");
		sb.append(getEmployeDetailconditions(map));
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		List<Record> rds = Db.find(sb.toString());
		if(rds != null){
			if(rds.size() == page.getPageSize()){
				return rds;
			}else{
				int newLimit = page.getPageSize();
				int newOffset = (page.getPageNo() -1)*page.getPageSize() - tuple.getVal1().intValue();
				newOffset = newOffset >= 0 ? newOffset : 0;
				if(tableSplitMapper.exists(siteId)){
					sb = new SqlKit();
					sb.append("select a.number,b.remarks,a.service_type,a.warranty_type,a.appliance_model,a.appliance_brand,a.review,a.appliance_category,a.customer_name,a.customer_mobile,a.customer_address,a.repair_time,a.end_time,b.settlement_time,b.cost_detail,b.service_measures as deMeasures,(CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,\r\n"
							+ "  (CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName,b.create_time as deCreateTime");
					sb.append("from " + tableSplitMapper.mapOrderSettlementDetail(siteId) + " b");
					sb.append("left join " + tableSplitMapper.mapOrder(siteId)
							+ " a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3') where b.site_id='" + siteId + "' and a.status != '8'  ");
					sb.append(getEmployeDetailconditions(map));
					sb.append(" limit " + newLimit + " offset " + newOffset);
					List<Record> rds2 = Db.find(sb.toString());
					rds.addAll(rds2);
				}
			}
			return rds;
		}
		return Lists.newArrayList();

		//return Db.find(sb.toString());
	}

	public Record orderEmployeListCountMoney(Map<String, Object> map, String siteId, String migration) {
		Record nowRd = orderEmployeListCountMoney_now(map, siteId, migration);
		Record historyRd = orderEmployeListCountMoney_history(map, siteId, migration);
		Record finalRd = ActiveRecordUtil.combineRecord(nowRd, historyRd);
		return finalRd;
	}

	public Record orderEmployeListCountMoney_now(Map<String, Object> map, String siteId, String migration) {
		SqlKit sb = new SqlKit();
		sb.append(" select sum(ff.deSumMoney) as deSumMoney_emp,sum(ff.drzgMny) as drzgMny_emp from  ");
		sb.append(
				"( select (CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName");
		sb.append("from crm_order_settlement_detail b");
		sb.append("left join crm_order a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status='0' where b.site_id='" + siteId + "' and a.status != '8'  ");
		sb.append(getEmployeDetailconditions(map));
		sb.append(" ) as ff");
		return Db.findFirst(sb.toString());
	}

	public Record orderEmployeListCountMoney_history(Map<String, Object> map, String siteId, String migration) {
		if (!tableSplitMapper.exists(siteId)) {
			return new Record();
		}
		SqlKit sb = new SqlKit();
		sb.append(" select sum(ff.deSumMoney) as deSumMoney_emp,sum(ff.drzgMny) as drzgMny_emp from  ");
		sb.append(
				"( select (CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END  ) AS drzgMny,(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money  ELSE 0 END ) AS deSumMoney,b.employe_name as deEmployeName");
		sb.append("from ").append(tableSplitMapper.mapOrderSettlementDetail(siteId)).append(" b");
		sb.append("left join ").append(tableSplitMapper.mapOrder(siteId))
				.append(" a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status='0' where b.site_id='" + siteId + "' and a.status != '8'  ");
		sb.append(getEmployeDetailconditions(map));
		sb.append(" ) as ff");
		return Db.findFirst(sb.toString());
	}

	// 查询统计财务各项的总和
	public Record getSumMoney(Map<String, Object> map) {
		return getSumMoney(map, "");
	}

	public Record getSumMoney(Map<String, Object> map, String migration) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record nowRd = getSumMoney_now(map, siteId);
		Record historyRd = getSumMoney_history(map, siteId);
		Record finalRd = ActiveRecordUtil.combineRecord(nowRd, historyRd);
		return finalRd;
	}

	public Record getSumMoney_now(Map<String, Object> map, String siteId) {
		Record rd = new Record();
		rd.set("dataMark", "420");
		Result rt = checkYears(map);
		if ("200".equals(rt.getCode())) {
			// migration = rt.getData().toString();
			StringBuilder sf = new StringBuilder();
			sf.append("SELECT  ");
			sf.append("SUM(b.factory_money) AS factory_money, ");
			sf.append("SUM(b.profits) AS profits,");
			sf.append("SUM(b.sum_money) AS sum_money,");
			sf.append("SUM(b.payment_amount) AS payment_amount");
			sf.append(" FROM crm_order a ");
			sf.append("JOIN crm_order_settlement b ON a.id= b.order_id and b.site_id=a.site_id ");
			sf.append("WHERE a.status IN('5', '3','4')  ");
			sf.append("AND a.site_id =? ");
			sf.append(getOrderRevenueFilter(map));
			rd = Db.findFirst(sf.toString(), siteId);
			rd.set("dataMark", "200");
		}
		return rd;
	}

	public Record getSumMoney_history(Map<String, Object> map, String siteId) {
		if (!tableSplitMapper.exists(siteId)) {
			return new Record();
		}
		Record rd = new Record();
		rd.set("dataMark", "420");
		Result rt = checkYears(map);
		if ("200".equals(rt.getCode())) {
			// migration = rt.getData().toString();
			StringBuilder sf = new StringBuilder();
			sf.append("SELECT  ");
			sf.append("SUM(b.factory_money) AS factory_money, ");
			sf.append("SUM(b.profits) AS profits,");
			sf.append("SUM(b.sum_money) AS sum_money,");
			sf.append("SUM(b.payment_amount) AS payment_amount");
			sf.append(" FROM ").append(tableSplitMapper.mapOrder(siteId)).append(" a ");
			sf.append("JOIN ").append(tableSplitMapper.mapOrderSettlement(siteId)).append(" b ON a.id= b.order_id and b.site_id=a.site_id ");
			sf.append("WHERE a.status IN('5', '3','4')  ");
			sf.append("AND a.site_id =? ");
			sf.append(getOrderRevenueFilter(map));
			rd = Db.findFirst(sf.toString(), siteId);
			rd.set("dataMark", "200");
		}
		return rd;
	}

	public List<Record> getEmployeGoodsDetail(Page<Record> page, Map<String, Object> map, String siteId) {
		StringBuffer sb = new StringBuffer();
		sb.append(
				"SELECT a.*,b.number as orderNumber,b.purchase_num,b.sales_commissions as salesCommissionsAll,b.confirmor,b.confirm_time,b.outstock_time,b.confirm_amount,b.customer_name,b.customer_contact,b.customer_address FROM crm_goods_siteself_order_deduct_detail a inner JOIN  crm_goods_siteself_order b ON a.site_order_id=b.id WHERE a.site_id='"
						+ siteId + "' AND a.status='0' and b.status != '0'  ");
		sb.append(getEmployeGoodsDetailconditions(map));
		sb.append(" ORDER BY a.create_time DESC  ");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sb.toString());
	}

	public List<Record> getOrderRevenueListByEmp(Page<Map<String, Object>> page, Map<String, Object> map, String siteId, String employeId) {
		StringBuffer sb = new StringBuffer();
		sb.append(
				"select a.number,a.service_type,a.warranty_type,a.appliance_brand,a.appliance_category,a.customer_name,a.customer_mobile,a.customer_address,a.repair_time,a.end_time,b.settlement_time,b.cost_detail,b.service_measures as deMeasures,b.sum_money as deSumMoney,b.employe_name as deEmployeName,b.create_time as deCreateTime from crm_order_settlement_detail b  left join crm_order a on b.order_id=a.id  where b.site_id='"
						+ siteId + "'");
		sb.append(" and b.employe_id='" + employeId + "' ");
		sb.append(getEmployeDetailconditions(map));
		/*
		 * if(page!=null){ sb.append(" limit " + page.getPageSize() + " offset " +
		 * (page.getPageNo()-1) * page.getPageSize()); }
		 */
		return Db.find(sb.toString());
	}

	public List<Record> getSumMoneyAndEmpName(Page<Record> page, Map<String, Object> map, String siteId) {
		return getSumMoneyAndEmpName(page, map, siteId, "");
	}

	public List<Record> getSumMoneyAndEmpName(Page<Record> page, Map<String, Object> map, String siteId, String migration) {
		StringBuilder sb = new StringBuilder();
		// StringBuffer sf = new StringBuffer();
		// sf.append("SELECT DISTINCT (t.employe_name) AS empId FROM
		// ").append(tableMapper.mapOrderSettlementDetail(migration)).append(" t LEFT
		// JOIN ").append(tableMapper.mapOrder(migration)).append(" d ON t.order_id =
		// d.id LEFT JOIN crm_employe e ON e.id = t.employe_id WHERE t.site_id = ? and
		// e.status='0' ");
		// sf.append(getEmployeDetailconditions2(map));
		// if(page!=null){
		// sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)
		// * page.getPageSize());
		// }
		// List<Record> list1 = Db.find(sf.toString(),siteId);
		// String employeId = "";
		// for(Record rd : list1){
		// if(StringUtils.isNotBlank(rd.getStr("empId"))){
		// if("".equals(employeId)){
		// employeId="'"+rd.getStr("empId")+"'";
		// }else{
		// employeId=employeId+",'"+rd.getStr("empId")+"'";
		// }
		// }
		// }
		// if(StringUtils.isBlank(employeId)){
		// employeId="''";
		// }
		/*
		 * sb.
		 * append("SELECT SUM(CASE WHEN b.service_measures='当日支付' THEN b.sum_money  ELSE 0 END) AS todayMoney,SUM(CASE WHEN b.service_measures='扣款' THEN b.sum_money  ELSE 0 END) AS kkMoney,  (SUM(CASE WHEN b.service_measures!= '扣款' THEN b.sum_money  ELSE 0 END)+SUM(CASE WHEN b.service_measures='扣款' THEN b.sum_money  ELSE 0 END)) AS allMoney,(SUM(CASE WHEN b.service_measures!='扣款' THEN b.sum_money  ELSE 0 END)+SUM(CASE WHEN b.service_measures='扣款' THEN b.sum_money  ELSE 0 END)-SUM(CASE WHEN b.service_measures='当日支付' THEN b.sum_money  ELSE 0 END)) AS relMoney,b.employe_name FROM crm_order_settlement_detail b LEFT JOIN crm_order a ON b.order_id = a.id  "
		 * );
		 */
		/*
		 * sb.
		 * append("SELECT SUM( CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END ) AS todayMoney, SUM( CASE WHEN b.service_measures = '扣款'  THEN b.sum_money ELSE 0 END ) AS kkMoney,(SUM(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money ELSE 0 END ) ) AS allMoney,(SUM(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money ELSE 0 END )  - SUM( CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END ) ) AS relMoney, b.employe_name FROM "
		 * ) .append(tableMapper.mapOrderSettlementDetail(migration)).
		 * append(" b LEFT JOIN ").append(tableMapper.mapOrder(migration)).
		 * append(" a ON b.order_id = a.id   ");
		 * sb.append(" WHERE b.site_id = ? and a.`status` !='8'  "); // AND
		 * b.`employe_id` IN ("+employeId+") sb.append(getEmployeDetailconditions(map));
		 * sb.append(" GROUP BY b.`employe_name` "); if (page != null) {
		 * sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() -
		 * 1) * page.getPageSize()); } return Db.find(sb.toString(), siteId);
		 */

		List<Record> nowRds = getSumMoneyAndEmpName_now(page, map, siteId, migration);
		List<Record> historyRds = Lists.newArrayList();
		if (tableSplitMapper.exists(siteId)) {
			historyRds = getSumMoneyAndEmpName_history(page, map, siteId, migration);
		}
		List<Record> finalRds = ActiveRecordUtil.combineRecords("employe_name", nowRds, historyRds);
		List<Record> retRds = Lists.newArrayList();

		if (page != null && finalRds != null && finalRds.size() > 0) {
			int len = finalRds.size() < page.getPageSize() ? finalRds.size() : page.getPageNo() * page.getPageSize();
			for (int i = (page.getPageNo() - 1) * page.getPageSize(); i < len; i++) {
				if (i > finalRds.size() - 1) {
					break;
				}
				Record rd = finalRds.get(i);
				retRds.add(rd);
			}
		}
		return retRds;
	}

	public List<Record> getSumMoneyAndEmpName_now(Page<Record> page, Map<String, Object> map, String siteId, String migration) {
		StringBuilder sb = new StringBuilder("");
		sb.append(
				"SELECT SUM( CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END ) AS todayMoney, SUM( CASE WHEN b.service_measures = '扣款'  THEN b.sum_money ELSE 0 END ) AS kkMoney,(SUM(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money ELSE 0 END ) ) AS allMoney,(SUM(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money ELSE 0 END )  - SUM( CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END ) ) AS relMoney, b.employe_name FROM ")
				.append(" crm_order_settlement_detail b LEFT JOIN ").append(" crm_order a ON b.order_id = a.id   ");
		sb.append(" WHERE b.site_id = ? and a.`status` !='8'  "); // AND b.`employe_id` IN ("+employeId+")
		sb.append(getEmployeDetailconditions(map));
		sb.append(" GROUP BY b.`employe_name` ");
		/*
		 * if (page != null) { sb.append(" limit " + page.getPageSize() + " offset " +
		 * (page.getPageNo() - 1) * page.getPageSize()); }
		 */
		return Db.find(sb.toString(), siteId);
	}

	public List<Record> getSumMoneyAndEmpName_history(Page<Record> page, Map<String, Object> map, String siteId, String migration) {
		StringBuilder sb = new StringBuilder("");
		sb.append(
				"SELECT SUM( CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END ) AS todayMoney, SUM( CASE WHEN b.service_measures = '扣款'  THEN b.sum_money ELSE 0 END ) AS kkMoney,(SUM(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money ELSE 0 END ) ) AS allMoney,(SUM(CASE WHEN b.service_measures != '当日支付' THEN b.sum_money ELSE 0 END )  - SUM( CASE WHEN b.service_measures = '当日支付' THEN b.sum_money ELSE 0 END ) ) AS relMoney, b.employe_name FROM ")
				.append(tableSplitMapper.mapOrderSettlementDetail(siteId)).append(" b LEFT JOIN ").append(tableSplitMapper.mapOrder(siteId)).append(" a ON b.order_id = a.id   ");
		sb.append(" WHERE b.site_id = ? and a.`status` !='8'  "); // AND b.`employe_id` IN ("+employeId+")
		sb.append(getEmployeDetailconditions(map));
		sb.append(" GROUP BY b.`employe_name` ");
		/*
		 * if (page != null) { sb.append(" limit " + page.getPageSize() + " offset " +
		 * (page.getPageNo() - 1) * page.getPageSize()); }
		 */
		return Db.find(sb.toString(), siteId);
	}

	public String getEmployeGoodsDetailconditions(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String employeName = getTrimmedParamValue(map, "employeName");// 服务工程师
			if (StringUtils.isNotEmpty(employeName)) {
				sf.append(" and a.salesman_id = '" + employeName + "' ");
			}
			String confirmTimeTimeMin = getTrimmedParamValue(map, "confirmTimeTimeMin");// 确认收款时间
			if (StringUtils.isNotEmpty(confirmTimeTimeMin)) {
				sf.append(" and b.confirm_time >= '" + confirmTimeTimeMin + " 00:00:00' ");
			}
			String confirmTimeTimeMax = getTrimmedParamValue(map, "confirmTimeTimeMax");
			if (StringUtils.isNotEmpty(confirmTimeTimeMax)) {
				sf.append(" and b.confirm_time <= '" + confirmTimeTimeMax + " 23:59:59' ");
			}

			String goodName = getTrimmedParamValue(map, "goodName");// 商品名称
			if (StringUtils.isNotEmpty(goodName)) {
				sf.append(" and a.good_name like '%" + goodName + "%' ");
			}

			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");// 零售时间
			if (StringUtils.isNotEmpty(createTimeMin)) {
				sf.append(" and a.create_time >= '" + createTimeMin + " 00:00:00' ");
			}
			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
			if (StringUtils.isNotEmpty(createTimeMax)) {
				sf.append(" and a.create_time <= '" + createTimeMax + " 23:59:59' ");
			}

			String outstockTimeMin = getTrimmedParamValue(map, "outstockTimeMin");// 出库时间
			if (StringUtils.isNotEmpty(outstockTimeMin)) {
				sf.append(" and b.outstock_time >= '" + outstockTimeMin + " 00:00:00' ");
			}
			String outstockTimeMax = getTrimmedParamValue(map, "outstockTimeMax");
			if (StringUtils.isNotEmpty(outstockTimeMax)) {
				sf.append(" and b.outstock_time <= '" + outstockTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public String getEmployeDetailconditions2(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String employeName = getTrimmedParamValue(map, "employeName");// 服务工程师
			if (StringUtils.isNotEmpty(employeName)) {
				sf.append(" and e.name = '" + employeName + "' ");
			}
			String endTimeMin = getTrimmedParamValue(map, "endTimeMin");// 完工时间
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sf.append(" and d.end_time >= '" + endTimeMin + " 00:00:00' ");
			}
			String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sf.append(" and d.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
			String settlementTimeMin = getTrimmedParamValue(map, "settlementTimeMin");// 结算归属时间
			if (StringUtils.isNotEmpty(settlementTimeMin)) {
				sf.append(" and t.settlement_time >= '" + settlementTimeMin + " 00:00:00' ");
			}
			String settlementTimeMax = getTrimmedParamValue(map, "settlementTimeMax");
			if (StringUtils.isNotEmpty(settlementTimeMax)) {
				sf.append(" and t.settlement_time <= '" + settlementTimeMax + " 23:59:59' ");
			}
			// 报修时间
			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				sf.append(" and d.repair_time >= '" + repairTimeMin + " 00:00:00' ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				sf.append(" and d.repair_time <= '" + repairTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public Long getEmployeDetailcount(Map<String, Object> map, String siteId) {
		Tuple<Long, Long> tuple = getEmployeDetailcount(map, siteId, "");
		return tuple.getVal1() + tuple.getVal2();
	}

	public Tuple<Long, Long> getEmployeDetailcount(Map<String, Object> map, String siteId, String migration) {
		/*
		 * StringBuffer sb = new StringBuffer();
		 * sb.append("select count(*) from ").append(tableMapper.
		 * mapOrderSettlementDetail(migration)).append(" b left join  ").append(
		 * tableMapper.mapOrder(migration))
		 * .append(" a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3')  where b.site_id='"
		 * + siteId + "' and a.status != '8'  ");
		 * sb.append(getEmployeDetailconditions(map)); return
		 * Db.queryLong(sb.toString());
		 */

		StringBuffer sb = new StringBuffer();
		sb.append(
				"select count(*) from crm_order_settlement_detail b left join  crm_order a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3')  where b.site_id='"
						+ siteId + "' and a.status != '8'  ");
		sb.append(getEmployeDetailconditions(map));
		long l1 = Db.queryLong(sb.toString());

		long l2 = 0l;
		if (tableSplitMapper.exists(siteId)) {
			StringBuffer sb2 = new StringBuffer();
			sb2.append("select count(*) from " + tableSplitMapper.mapOrderSettlementDetail(siteId) + " b left join  " + tableSplitMapper.mapOrder(siteId)
					+ " a on b.order_id=a.id left join crm_employe e on e.id=b.employe_id and e.status in('0','3')  where b.site_id='" + siteId + "' and a.status != '8'  ");
			sb2.append(getEmployeDetailconditions(map));
			l2 = Db.queryLong(sb2.toString());
		}
		return new Tuple<>(l1, l2);
	}

	public Long getEmployeGoodsDetailcount(Map<String, Object> map, String siteId) {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT count(*) FROM crm_goods_siteself_order_deduct_detail a inner JOIN  crm_goods_siteself_order b ON a.site_order_id=b.id WHERE a.site_id='" + siteId
				+ "' AND a.status='0' and b.status != '0'  ");
		sb.append(getEmployeGoodsDetailconditions(map));
		return Db.queryLong(sb.toString());
	}

//	public Long countOrderRevenue(Map<String, Object> map) {
//		return countOrderRevenue(map, "");
//	}

	public Tuple<Long, Long> countOrderRevenue(Map<String, Object> map, String siteId, Page<Record> page) {
		long t = System.currentTimeMillis();
		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(1) as count from ( ");
		sb.append("select a.id, b.id as sid from crm_order a left join crm_order_settlement b on b.order_id = a.id ");
		sb.append(" where a.status in('3', '4', '5') ");
		sb.append(" and a.site_id =? ");
		sb.append(getOrderRevenueFilter(map));
		sb.append(" ) as ot1");
		Long count1 = Db.queryLong(sb.toString(), siteId);
		Long count2 = 0L;
		logger.info("::revenue count step1:"  + (System.currentTimeMillis() - t) + "ms");

		long t1 = System.currentTimeMillis();
		if (tableSplitMapper.exists(siteId)) {
			StringBuilder sb1 = new StringBuilder("");
			sb1.append(" select count(1) as count from ( ");
			sb1.append("select a.id, b.id as sid from " + tableSplitMapper.mapOrder(siteId) + " a left join " + tableSplitMapper.mapOrderSettlement(siteId)
					+ " b on b.order_id = a.id ");
			sb1.append(" where a.status in('3', '4', '5') ");
			sb1.append(" and a.site_id =? ");
			sb1.append(getOrderRevenueFilter(map));
			sb1.append(" ) as ot0 ");
			count2 = Db.queryLong(sb1.toString(), siteId);
		}
		logger.info("::revenue count step2:"  + (System.currentTimeMillis() - t1) + "ms");
		return new Tuple<>(count1, count2);

	}

	public String getOrderRevenueConditions(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				sf.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:00'  ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				sf.append(" and a.repair_time <= '" + repairTimeMax + "  23:59:59' ");
			}
			String dtType = getTrimmedParamValue(map, "dtType");
			if ("2".equals(dtType)) {
				// 结算归属时间
				String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
				if (StringUtils.isNotEmpty(endTimeMax)) {// 接入时间
					sf.append(" and b.settlement_time <= '" + endTimeMax + " 23:59:59' ");
				}
				String endTimeMin = getTrimmedParamValue(map, "endTimeMin");
				if (StringUtils.isNotEmpty(endTimeMin)) {
					sf.append(" and b.settlement_time >= '" + endTimeMin + " 00:00:00' ");
				}
			} else {
				// 完工时间
				String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
				if (StringUtils.isNotEmpty(endTimeMax)) {
					sf.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
				}
				String endTimeMin = getTrimmedParamValue(map, "endTimeMin");
				if (StringUtils.isNotEmpty(endTimeMin)) {
					sf.append(" and a.end_time >= '" + endTimeMin + " 00:00:00'  ");
				}
			}
			// 服务工程师
			String employeName = getTrimmedParamValue(map, "employeName");
			if (StringUtils.isNotEmpty(employeName)) {// 服务工程师
				sf.append(" and e.id='" + employeName + "' ");
			}

		}
		return sf.toString();
	}

	public String getOrderRevenueFilter(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String number = getTrimmedParamValue(map, "number");
			if (StringUtils.isNotEmpty(number)) {
				sf.append(" and a.number like '%" + number + "%' ");
			}
			String customerName = getTrimmedParamValue(map, "customerName");
			if (StringUtils.isNotEmpty(customerName)) {
				sf.append(" and a.customer_name like '%" + customerName + "%' ");
			}
			String customerMobile = getTrimmedParamValue(map, "customerMobile");
			if (StringUtils.isNotEmpty(customerMobile)) {
				sf.append(" and (a.customer_mobile like '%" + customerMobile + "%' or a.customer_telephone like '%" + customerMobile + "%' or a.customer_telephone2 like '%"
						+ customerMobile + "%') ");
			}
			String customerAddress = getTrimmedParamValue(map, "customerAddress");
			if (StringUtils.isNotEmpty(customerAddress)) {
				sf.append(" and a.customer_address like '%" + customerAddress + "%' ");
			}
			String applianceBrand = getTrimmedParamValue(map, "applianceBrand");
			if (StringUtils.isNotEmpty(applianceBrand)) {
				sf.append(" and a.appliance_brand like '%" + applianceBrand + "%'");
			}
			String applianceCategory = getTrimmedParamValue(map, "applianceCategory");
			if (StringUtils.isNotEmpty(applianceCategory)) {
				sf.append(" and a.appliance_category like '%" + applianceCategory + "%' ");
			}
			String serviceType = getTrimmedParamValue(map, "serviceType");
			if (StringUtils.isNotEmpty(serviceType)) {
				sf.append(" and a.service_type = '" + serviceType + "' ");
			}
			String origin = getTrimmedParamValue(map, "origin");
			if (StringUtils.isNotEmpty(origin)) {
				sf.append(" and a.origin = '" + origin + "' ");
			}
			String orderType = getTrimmedParamValue(map, "orderType");
			if (StringUtils.isNotEmpty(orderType)) {
				sf.append(" and a.order_type = '" + orderType + "' ");
			}
			String warrantyType = getTrimmedParamValue(map, "warrantyType");
			if (StringUtils.isNotEmpty(warrantyType)) {
				sf.append(" and a.warranty_type = '" + warrantyType + "' ");
			}
			String promiseTime = getTrimmedParamValue(map, "promiseTime");
			if (StringUtils.isNotEmpty(promiseTime)) {
				sf.append(" and a.promise_time = '" + ((String[]) map.get("promiseTime"))[0] + "' ");
			}
			String level = getTrimmedParamValue(map, "level");
			if (StringUtils.isNotEmpty(level)) {
				sf.append(" and a.level = '" + level + "' ");
			}
			String messengerName = getTrimmedParamValue(map, "messengerName");
			if (StringUtils.isNotEmpty(messengerName)) {// 登记人
				sf.append(" and a.messenger_name = '" + messengerName + "' ");
			}
			String status = getTrimmedParamValue(map, "status");

			if (StringUtils.isNotEmpty(status)) {// 工单状态
				sf.append(" and a.status = '" + status + "' ");
			}
			String employeName = getTrimmedParamValue(map, "employeName");
			if (StringUtils.isNotEmpty(employeName)) {// 服务工程师
				sf.append(" and find_in_set('" + employeName + "',a.employe_id) ");
			}
			String whetherCollection = getTrimmedParamValue(map, "whetherCollection");
			if (StringUtils.isNotEmpty(whetherCollection)) {// 交款情况
				if ("1".equals(whetherCollection)) {
					sf.append(" and a.whether_collection = '" + whetherCollection + "' ");
				} else if ("0".equals(whetherCollection)) {
					sf.append(" and a.whether_collection = '0' and (a.warranty_cost>0 or a.auxiliary_cost >0 or a.serve_cost >0) ");
				} else {
					sf.append(" and a.whether_collection = '0' and a.warranty_cost = 0 and a.auxiliary_cost = 0 and  a.serve_cost = 0  ");
				}

			}
			String returnCard = getTrimmedParamValue(map, "returnCard");
			if (StringUtils.isNotEmpty(returnCard)) {
				sf.append(" and a.return_card = '" + returnCard + "' ");
			}
			String settleJiesuan = getTrimmedParamValue(map, "settleJiesuan");
			if (StringUtils.isNotEmpty(settleJiesuan)) {
				if ("1".equals(settleJiesuan)) {
					sf.append(" and b.settlement_time is not null ");
				} else {
					sf.append(" and  b.settlement_time is null ");
				}
			}
			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				sf.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:00'  ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				sf.append(" and a.repair_time <= '" + repairTimeMax + "  23:59:59' ");
			}
			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
			if (StringUtils.isNotEmpty(createTimeMax)) {// 接入时间
				sf.append(" and b.settlement_time <= '" + createTimeMax + " 23:59:59' ");
			}
			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
			if (StringUtils.isNotEmpty(createTimeMin)) {
				sf.append(" and b.settlement_time >= '" + createTimeMin + " 00:00:00' ");
			}
			String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sf.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
			String endTimeMin = getTrimmedParamValue(map, "endTimeMin");
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sf.append(" and a.end_time >= '" + endTimeMin + " 00:00:00'  ");
			}
			String review = getTrimmedParamValue(map, "review");
			if (StringUtils.isNotEmpty(review)) {
				if ("0".equals(review)) {
					sf.append(" and (a.review = '0' or a.review is null) ");
				} else {
					sf.append(" and a.review = '" + review + "' ");
				}
			}
		}
		String reviewTimeMin = getTrimmedParamValue(map, "reviewTimeMin");
		if (StringUtils.isNotEmpty(reviewTimeMin)) {
			sf.append(" and a.review_time >= '" + reviewTimeMin + " 00:00:00'  ");
		}
		String reviewTimeMax = getTrimmedParamValue(map, "reviewTimeMax");
		if (StringUtils.isNotEmpty(reviewTimeMax)) {
			sf.append(" and a.review_time <= '" + reviewTimeMax + "  23:59:59' ");
		}

		String payTimeMin = getTrimmedParamValue(map, "payTimeMin");
		if (StringUtils.isNotEmpty(payTimeMin)) {
			sf.append(" and a.pay_time >= '" + payTimeMin + " 00:00:00'  ");
		}
		String payTimeMax = getTrimmedParamValue(map, "payTimeMax");
		if (StringUtils.isNotEmpty(payTimeMax)) {
			sf.append(" and a.pay_time <= '" + payTimeMax + "  23:59:59' ");
		}
		return sf.toString();
	}

	public List<Record> getGoodsRevenueList(Page<Record> page, Map<String, Object> map, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT a.*," + " CASE  WHEN a.status = '3' AND a.outstock_type='3' THEN '待确认' " + " WHEN a.status = '5' AND a.outstock_type='3' THEN '已确认' "
				+ " WHEN a.status = '1' AND a.outstock_type !='3' AND b.good_brand!='浩泽'  THEN '待收款' "
				+ " WHEN a.status = '4' AND a.outstock_type !='3' AND b.good_brand!='浩泽'  THEN '待收款' "
				+ " WHEN a.status = '2' AND a.outstock_type !='3' AND b.good_brand!='浩泽'  THEN '已完成' "
				+ "	WHEN a.status = '3' AND a.outstock_type !='3' AND b.good_brand!='浩泽'  THEN '已完成' " + "	WHEN a.status = '1'  AND b.good_brand='浩泽'  THEN '待收款待出库' "
				+ "	WHEN (a.status='4' AND a.outstock_type IN('0','1')) AND b.good_brand='浩泽'  THEN '待收款已出库' "
				+ " 	WHEN (a.status='4' AND a.outstock_type = '2') AND b.good_brand='浩泽'  THEN '待收款已下单' "
				+ " 	WHEN a.status = '3' AND a.outstock_type = '2' AND b.good_brand='浩泽'  THEN '已下单' "
				+ " 	WHEN a.status = '3' AND a.outstock_type = '1' AND b.good_brand='浩泽'  THEN '已出库' " + "	ELSE '已完成' END AS orderstatus  "
				+ " FROM crm_goods_siteself_order a " + " LEFT JOIN crm_goods_siteself_order_goods_detail b ON a.id=b.site_order_id AND b.status='0' "
				+ " WHERE a.site_id=? AND a.status !='0' ");
		sf.append(getGoodsRevenueFilter(map));
		sf.append("  GROUP BY a.id  order by a.placing_order_time desc");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		return Db.find(sf.toString(), siteId);
	}

	public Long countGoodsRevenue(Map<String, Object> map, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) FROM crm_goods_siteself_order a  "
				// + " LEFT JOIN crm_goods_siteself gs ON gs.id=a.good_id AND gs.site_id=? "
				+ " WHERE a.site_id=? AND a.status !='0' ");
		sf.append(getGoodsRevenueFilter(map));
		return Db.queryLong(sf.toString(), siteId);
	}

	/* 商品订单明细 */
	public List<Record> getOrderGoodsDetail(String orderId, String siteId) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT * FROM crm_goods_siteself_order_goods_detail a  ");
		sf.append(" WHERE a.status='0' AND a.site_order_id=? AND a.site_id=? ");
		return Db.find(sf.toString(), orderId, siteId);
	}

	private String getParamValue(Map<String, Object> map, String param) {
		Object value = map.get(param);
		return value == null ? null : (map.get(param).toString());
	}

	private String getTrimmedParamValue(Map<String, Object> map, String param) {
		return StringUtils.trim(getParamValue(map, param));
	}

	// 商品收支明细查询条件
	public String getGoodsRevenueFilter(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String goodName = getTrimmedParamValue(map, "goodName");
			if (StringUtils.isNotEmpty(goodName)) {
				sf.append(" and a.good_name = '" + goodName + "' ");
			}
			String goodSource = getTrimmedParamValue(map, "goodSource");
			if (StringUtils.isNotEmpty(goodSource)) {
				sf.append(" and a.good_source like '%" + goodSource + "%' ");
			}
			String customerMobile = getTrimmedParamValue(map, "customerMobile");
			if (StringUtils.isNotEmpty(customerMobile)) {
				sf.append(" and (a.customer_contact like '%" + customerMobile + "%') ");
			}
			String status = getTrimmedParamValue(map, "status");
			if (StringUtils.isNotEmpty(status)) {
				if ("1".equals(status)) {
					sf.append(" and a.status in('2','3') ");
				}
				if ("2".equals(status)) {
					sf.append(" and a.status in('1','4')");
				}
			}
			String placingName = getTrimmedParamValue(map, "placingName");
			if (StringUtils.isNotEmpty(placingName)) {
				sf.append(" and a.placing_name like '%" + placingName + "%' ");
			}
			String goodCategory = getTrimmedParamValue(map, "goodCategory");
			if (StringUtils.isNotEmpty(goodCategory)) {
				sf.append(" and a.good_category like '%" + goodCategory + "%' ");
			}
			String goodBrand = getTrimmedParamValue(map, "goodBrand");
			if (StringUtils.isNotEmpty(goodBrand)) {
				sf.append(" and a.good_brand = '" + goodBrand + "' ");
			}
			String customerName = getTrimmedParamValue(map, "customerName");
			if (StringUtils.isNotEmpty(customerName)) {
				sf.append(" and a.customer_name like '%" + customerName + "%' ");
			}

			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
			if (StringUtils.isNotEmpty(createTimeMin)) {// 接入时间
				sf.append(" and a.placing_order_time >= '" + createTimeMin + " 00:00:00' ");
			}
			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");

			if (StringUtils.isNotEmpty(createTimeMax)) {
				sf.append(" and a.placing_order_time <= '" + createTimeMax + " 23:59:59' ");
			}

		}
		return sf.toString();
	}

	public String getEmployeDetailconditions(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String employeName = getTrimmedParamValue(map, "employeName");// 服务工程师
			if (StringUtils.isNotEmpty(employeName)) {
				sf.append(" and b.employe_id = '" + employeName + "' ");
			}
			String endTimeMin = getTrimmedParamValue(map, "endTimeMin");// 完工时间
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sf.append(" and a.end_time >= '" + endTimeMin + " 00:00:00' ");
			}
			String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sf.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
			String settlementTimeMin = getTrimmedParamValue(map, "settlementTimeMin");// 结算归属时间
			if (StringUtils.isNotEmpty(settlementTimeMin)) {
				sf.append(" and b.settlement_time >= '" + settlementTimeMin + " 00:00:00' ");
			}
			String settlementTimeMax = getTrimmedParamValue(map, "settlementTimeMax");
			if (StringUtils.isNotEmpty(settlementTimeMax)) {
				sf.append(" and b.settlement_time <= '" + settlementTimeMax + " 23:59:59' ");
			}
			// 报修时间
			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				sf.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:00' ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				sf.append(" and a.repair_time <= '" + repairTimeMax + " 23:59:59' ");
			}
			String review = getTrimmedParamValue(map, "review");// 服务工程师
			if (StringUtils.isNotEmpty(review)) {
				if ("0".equals(review)) {
					sf.append(" and (a.review = '" + review + "' or a.review is null) ");
				} else {
					sf.append(" and a.review = '" + review + "' ");
				}
			}
			String category = getTrimmedParamValue(map, "applianceCategory");
			if (StringUtils.isNotEmpty(category)) {
				sf.append(" and a.appliance_category = '" + category + "' ");
			}
			String warrantyType = getTrimmedParamValue(map, "warrantyType");
			if (StringUtils.isNotEmpty(warrantyType)) {
				sf.append(" and a.warranty_type = '" + warrantyType + "' ");
			}
			String serviceType = getTrimmedParamValue(map, "serviceType");
			if (StringUtils.isNotEmpty(serviceType)) {
				sf.append(" and a.service_type = '" + serviceType + "' ");
			}
			String brand = getTrimmedParamValue(map, "applianceBrand");
			if (StringUtils.isNotEmpty(brand)) {
				sf.append(" and a.appliance_brand = '" + brand + "' ");
			}
			/*
			 * if(StringUtil.checkParamsValid(map.get("applianceBrand"))){ String[]
			 * applianceBrand=((map.get("applianceBrand").toString())).split(",");
			 * if(applianceBrand.length>0) {
			 * sf.append("and (a.appliance_brand like "+StringUtil.joinInSqlforselforder(
			 * xiaoNames)+")"); } }
			 */
		}
		return sf.toString();
	}

	public Long getEmplistCount(Map<String, Object> map, String siteId) {
		return getEmplistCount(map, siteId, "");
	}

	public Long getEmplistCount(Map<String, Object> map, String siteId, String migration) {
		/*
		 * StringBuffer sf = new StringBuffer();
		 * sf.append("SELECT count(DISTINCT(a.employe_name)) FROM ").append(tableMapper.
		 * mapOrderSettlementDetail(migration)).append(" a left join ")
		 * .append(tableMapper.mapOrder(migration)).
		 * append(" b on b.id=a.order_id WHERE a.site_id='" + siteId +
		 * "' and b.`status`!='8' "); sf.append(getEmployeDetailconditions1(map));
		 * return Db.queryLong(sf.toString());
		 */

		StringBuffer sf = new StringBuffer();
		sf.append(" select count(1) from ( ");
		sf.append("SELECT DISTINCT e.name as employe_name FROM crm_order_settlement_detail a left join ").append(
				" crm_order b on b.id=a.order_id left join crm_employe e on e.id=a.employe_id and e.status in('0','3') WHERE a.site_id='" + siteId + "' and b.`status`!='8' ");
		sf.append(getEmployeDetailconditions1(map));
		if (tableSplitMapper.exists(siteId)) {
			sf.append(" union ");

			sf.append("SELECT DISTINCT e.name as employe_name FROM " + tableSplitMapper.mapOrderSettlementDetail(siteId) + " a left join ")
					.append(tableSplitMapper.mapOrder(siteId))
					.append(" b on b.id=a.order_id left join crm_employe e on e.id=a.employe_id and e.status in('0','3') WHERE a.site_id='" + siteId + "' and b.`status`!='8' ");
			sf.append(getEmployeDetailconditions1(map));
		}
		sf.append(" ) as ot ");

		return Db.queryLong(sf.toString());

	}

	public List<Record> getEmplist1(Page<Map<String, Object>> page, Map<String, Object> map, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				"select count(DISTINCT(e.id)) from crm_order_settlement_detail a left join crm_order b on a.order_id=b.id left join crm_employe e on e.id=a.employe_id where a.site_id='"
						+ siteId + "' ");
		sf.append(getEmployeDetailconditions1(map));
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public String getEmployeDetailconditions1(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String employeName = getTrimmedParamValue(map, "employeName");// 服务工程师
			if (StringUtils.isNotEmpty(employeName)) {
				sf.append(" and a.employe_name = '" + employeName + "' ");
			}
			String endTimeMin = getTrimmedParamValue(map, "endTimeMin");// 完工时间
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sf.append(" and b.end_time >= '" + endTimeMin + " 00:00:00' ");
			}
			String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sf.append(" and b.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
			String settlementTimeMin = getTrimmedParamValue(map, "settlementTimeMin");// 结算归属时间
			if (StringUtils.isNotEmpty(settlementTimeMin)) {
				sf.append(" and a.settlement_time >= '" + settlementTimeMin + " 00:00:00' ");
			}
			String settlementTimeMax = getTrimmedParamValue(map, "settlementTimeMax");
			if (StringUtils.isNotEmpty(settlementTimeMax)) {
				sf.append(" and a.settlement_time <= '" + settlementTimeMax + " 23:59:59' ");
			}
			// 报修时间
			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				sf.append(" and b.repair_time >= '" + repairTimeMin + " 00:00:00' ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				sf.append(" and b.repair_time <= '" + repairTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public List<Record> getsettledetaillist(String orderid) {
		return getsettledetaillist(orderid, "");
	}

	public List<Record> getsettledetaillist(String orderId, String migration) {
		String sql = "select * from crm_order_settlement_detail where order_id=? and site_id=? ";
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> rds = Db.find(sql, orderId, siteId);
		if ((rds == null || rds.size() == 0) && tableSplitMapper.exists(siteId)) {
			rds = Db.find("select * from " + tableSplitMapper.mapOrderSettlementDetail(siteId) + " where order_id=? and site_id=? ", orderId, siteId);
		}
		return rds;
	}

	public List<Record> getSiteSettleDetailListInOrderIds(String orderIds, String siteId) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select * from crm_order_settlement_detail where order_id in (").append(orderIds).append(") and site_id = ? ");
		if (tableSplitMapper.exists(siteId)) {
			sb.append(" union all ");
			sb.append(" select * from ").append(tableSplitMapper.mapOrderSettlementDetail(siteId)).append(" where order_id in (").append(orderIds).append(") and site_id = ? ");
		}
		if (tableSplitMapper.exists(siteId)) {
			return Db.find(sb.toString(), siteId, siteId);
		} else {
			return Db.find(sb.toString(), siteId);
		}
	}

	public List<Record> getSiteSettleListInOrderIds(String orderIds, String siteId) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select * from crm_order_settlement where order_id in (" + orderIds + ") and site_id = ? ");
		if (tableSplitMapper.exists(siteId)) {
			sb.append(" union all ");
			sb.append(" select * from "+tableSplitMapper.mapOrderSettlement(siteId)+" where order_id in (" + orderIds + ") and site_id = ? ");
		}
		if (tableSplitMapper.exists(siteId)) {
			return Db.find(sb.toString(), siteId, siteId);
		} else {
			return Db.find(sb.toString(), siteId);
		}
	}

	public List<Record> getSiteSettleDetailListInOrderId(List<Record> detailList, String orderId) {
		List<Record> retList = Lists.newArrayList();
		for (Record rd : detailList) {
			if (StringUtil.isNotBlank(orderId) && orderId.equalsIgnoreCase(rd.getStr("order_id"))) {
				retList.add(rd);
			}
		}
		return retList;
	}

	public Record getSiteSettleListInOrderId(List<Record> settleList, String orderId) {
		for (Record rd : settleList) {
			if (StringUtil.isNotBlank(orderId) && orderId.equalsIgnoreCase(rd.getStr("order_id"))) {
				return rd;
			}
		}
		return null;
	}

	public List<Record> getsettlementlist(String orderid) {
		return getsettlementlist(orderid, "");
	}

	public List<Record> getsettlementlist(String orderid, String migration) {
		String sql = "select * from crm_order_settlement where order_id=? and site_id=? ";
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> rds = Db.find(sql, orderid, siteId);
		if ((rds == null || rds.size() == 0) && tableSplitMapper.exists(siteId)) {
			rds = Db.find(" select * from " + tableSplitMapper.mapOrderSettlement(siteId) + " where order_id=? and site_id=?  ");
		}
		return rds;
	}

	// 审核不通过
	public int reviewFailed(String id, String reviewRemark) {
		return reviewFailed(id, reviewRemark, "");
	}

	public int reviewFailed(String id, String reviewRemark, String migration) {
		/*
		 * String sql = ""; Date reviewtime = new Date(); if
		 * (StringUtil.isNotBlank(reviewRemark)) { sql = "update " +
		 * tableMapper.mapOrder(migration) +
		 * " set review='2',review_time=?,review_remark=? where id=?"; return
		 * Db.update(sql, reviewtime, reviewRemark, id); } else { sql = "update " +
		 * tableMapper.mapOrder(migration) + " set review='2',review_time=? where id=?";
		 * return Db.update(sql, reviewtime, id); }
		 */
		return review_ext(id, reviewRemark, "2");
	}

	public int review_ext(String id, String reviewRemark, String status){
		Order order = orderDao.get(id);
		String table = "crm_order";
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (order == null) {
			table = tableSplitMapper.mapOrder(siteId);
		}
		if (table == null) {
			throw new IllegalStateException();
		}

		StringBuilder sb = new StringBuilder("");
		sb.append(" update ").append(table).append(" set review='"+status+"', review_time=? ");
		if(StringUtil.isNotBlank(reviewRemark)){
			sb.append(",review_remark=? where id = ? ");
			return Db.update(sb.toString(), new Date(), reviewRemark, id);
		} else {
			sb.append(" where id = ? ");
			return Db.update(sb.toString(), new Date(), id);
		}
	}

	public int reviewFailed2017(String id, String reviewRemark) {
		/*
		 * String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser()); String
		 * orderTable = tableMapper.mapOrder(siteId); if (orderTable == null) { return
		 * 0; }
		 *
		 * if (StringUtil.isNotBlank(reviewRemark)) { String sql = "update " +
		 * orderTable + " set review='2',review_time=?,review_remark=? where id=?";
		 * return Db.update(sql, new Date(), reviewRemark, id); } else { String sql =
		 * "update " + orderTable + " set review='2',review_time=? where id=?"; return
		 * Db.update(sql, new Date(), id); }
		 */
		return review_ext(id, reviewRemark, "2");
	}

	// 审核通过
	public int reviewPass(String id, String reviewRemark) {
		return reviewPass(id, reviewRemark, "");
	}

	public int reviewPass(String id, String reviewRemark, String migration) {
		/*
		 * if (StringUtil.isNotBlank(reviewRemark)) { String sql = "update " +
		 * tableMapper.mapOrder(migration) +
		 * " set review='1',review_time=?,review_remark=? where id=?"; return
		 * Db.update(sql, new Date(), reviewRemark, id); } else { String sql = "update "
		 * + tableMapper.mapOrder(migration) +
		 * " set review='1',review_time=? where id=?"; return Db.update(sql, new Date(),
		 * id); }
		 */
		return review_ext(id, reviewRemark, "1");
	}

	public int reviewPass2017(String id, String reviewRemark) {
		/*
		 * String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser()); String
		 * orderTable = tableMapper.mapOrder(siteId); if (orderTable == null) { return
		 * 0; }
		 *
		 * if (StringUtil.isNotBlank(reviewRemark)) { String sql = "update " +
		 * orderTable + " set review='1',review_time=?,review_remark=? where id=?";
		 * return Db.update(sql, new Date(), reviewRemark, id); } else { String sql =
		 * "update " + orderTable + " set review='1',review_time=? where id=?"; return
		 * Db.update(sql, new Date(), id); }
		 */
		return review_ext(id, reviewRemark, "1");
	}

	public Long getEmplistGoodsCount(Map<String, Object> map1, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				"SELECT count(DISTINCT(a.salesman)) FROM crm_goods_siteself_order_deduct_detail a left join crm_goods_siteself_order b on b.id=a.site_order_id left join crm_employe e on e.user_id=a.salesman_id WHERE a.status='0'and b.status!='0'and a.site_id='"
						+ siteId + "'  ");
		sf.append(getEmployeGoodsDetailconditions(map1));
		return Db.queryLong(sf.toString());
	}

	public List<Record> employeGoodsCount(Page<Record> page, Map<String, Object> map1, String siteId) {
		StringBuffer sd = new StringBuffer();
		sd.append("SELECT a.salesman,SUM(a.sales_commissions) as ticheng," + "SUM(a.paid_commissions) AS commissions  " + "FROM crm_goods_siteself_order_deduct_detail a "
				+ "LEFT JOIN crm_goods_siteself_order b ON a.site_order_id=b.id " + "WHERE a.status='0'and b.status!='0'and a.site_id='" + siteId + "' ");
		sd.append(getEmployeGoodsDetailconditions(map1));
		sd.append(" GROUP BY a.salesman_id ");
		if (page != null) {
			sd.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sd.toString());
	}

	public Result checkYears(Map<String, Object> map) {
		Result rt = new Result();
		Object tMin = map.get("repairTimeMin");
		Object tMax = map.get("repairTimeMax");
		if (tMin == null || tMax == null || StringUtils.isBlank(tMin.toString()) || StringUtils.isBlank(tMax.toString())) {
			rt.setCode("420");
			rt.setData("error");
			return rt;
		}
		if (!tMin.toString().substring(0, 4).equals(tMax.toString().substring(0, 4))) {
			rt.setCode("421");
			rt.setData("error");
			return rt;
		}
		;
		rt.setData(Long.valueOf(tMax.toString().substring(0, 4)) < 2018 ? "2017" : "2018");
		rt.setCode("200");
		return rt;
	}

	public String empJSCountOrderConditions(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String endTimeMin = getTrimmedParamValue(map, "endTimeMin");// 完工时间
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sf.append(" and a.end_time >= '" + endTimeMin + " 00:00:00' ");
			}
			String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sf.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
			// 报修时间
			String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
			if (StringUtils.isNotEmpty(repairTimeMin)) {
				sf.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:00' ");
			}
			String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
			if (StringUtils.isNotEmpty(repairTimeMax)) {
				sf.append(" and a.repair_time <= '" + repairTimeMax + " 23:59:59' ");
			}
			String settlementTimeMin = getTrimmedParamValue(map, "settlementTimeMin");// 结算归属时间
			if (StringUtils.isNotEmpty(settlementTimeMin)) {
				sf.append(" and c.settlement_time >= '" + settlementTimeMin + " 00:00:00' ");
			}
			String settlementTimeMax = getTrimmedParamValue(map, "settlementTimeMax");
			if (StringUtils.isNotEmpty(settlementTimeMax)) {
				sf.append(" and c.settlement_time <= '" + settlementTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	// 没用到
	// @Deprecated
	/*
	 * public String sqlNormal(String empId, String siteId, Map<String, Object> map,
	 * String migration, String status) { StringBuilder sb = new StringBuilder();
	 * sb.append("SELECT count(*) FROM ").append(tableMapper.mapOrder(migration)).
	 * append(" as a left join ").append(tableMapper.mapOrderSettlementDetail(
	 * migration)) .append(" as c on a.id=c.order_id WHERE a.site_id='" + siteId +
	 * "' AND FIND_IN_SET('" + empId + "',a.employe_id) and a.status in (" + status
	 * + ")"); sb.append(empJSCountOrderConditions(map));
	 * sb.append(" order by a.id"); return sb.toString(); }
	 */

	// 没用到
	// @Deprecated
	/*
	 * public String sqlNormal1(String empId, String siteId, Map<String, Object>
	 * map, String migration) { StringBuilder sb = new StringBuilder();
	 * sb.append("SELECT count(*) FROM ").append(tableMapper.mapOrder(migration)).
	 * append(" as a  inner join ").append(tableMapper.mapOrderCallback(migration))
	 * .append("" + " as b on a.id=b.order_id left join ").append(tableMapper.
	 * mapOrderSettlementDetail(migration))
	 * .append(" as c on a.id=c.order_id  WHERE a.site_id='" + siteId +
	 * "' AND FIND_IN_SET('" + empId +
	 * "',a.employe_id) and b.service_attitude in ('1','2') ");
	 * sb.append(empJSCountOrderConditions(map)); sb.append(" order by a.id");
	 * return sb.toString(); }
	 */

	// 已结算和未结算的工单数-工单为单位
	// @Deprecated
	/*
	 * public String sqlJs(String empId, String siteId, Map<String, Object> map,
	 * String migration, String type) { StringBuilder sb = new StringBuilder();
	 * sb.append(" SELECT count(*) FROM ").append(tableMapper.mapOrder(migration)).
	 * append(" as a LEFT JOIN ").append(tableMapper.mapOrderSettlementDetail(
	 * migration)) .append(" as c ON a.id=c.order_id WHERE a.site_id='" + siteId +
	 * "' "); sb.append(" AND a.status IN ('3','4','5') AND a.employe_id='" + empId
	 * + "' "); sb.append(empJSCountOrderConditions(map)); if ("1".equals(type)) {//
	 * sb.append(" and c.id is not null"); } if ("2".equals(type)) {
	 * sb.append(" and c.id is null"); } sb.append(" GROUP BY a.id"); return
	 * sb.toString(); }
	 */

	// 已结算和未结算的工单金额取值-工单为单位
	// 没用到
	/*
	 * public String sqlJsMoney(String empId, String siteId, Map<String, Object>
	 * map, String migration, String type) { StringBuilder sb = new StringBuilder();
	 * sb.
	 * append("select SUM(tt.serve_cost+tt.warranty_cost+tt.auxiliary_cost) AS serve_cost_yjs,SUM(tt.confirm_cost) AS confirm_cost_yjs from ("
	 * ); sb.
	 * append(" SELECT a.serve_cost,a.auxiliary_cost,a.warranty_cost,a.confirm_cost FROM "
	 * ).append(tableMapper.mapOrder(migration)).append(" as a LEFT JOIN ")
	 * .append(tableMapper.mapOrderSettlementDetail(migration)).
	 * append(" as c ON a.id=c.order_id WHERE a.site_id='" + siteId + "' ");
	 * sb.append(" AND a.status IN ('3','4','5') AND a.employe_id='" + empId +
	 * "' "); sb.append(empJSCountOrderConditions(map)); if ("1".equals(type)) {//
	 * sb.append(" and c.id is not null"); } if ("2".equals(type)) {
	 * sb.append(" and c.id is null"); } sb.append(" GROUP BY a.id ) as tt"); return
	 * sb.toString(); }
	 */

	// 已结算结算金额取值-工程师结算为单位为单位
	// @Deprecated
	/*
	 * public String sqlJsSettleOnlyMoney(String empId, String siteId, Map<String,
	 * Object> map, String migration) { StringBuilder sb = new StringBuilder();
	 * sb.append("SELECT SUM(tt.drzhMny) AS drzhMny,SUM(tt.jsMny) AS jsMny FROM ( "
	 * ); sb.
	 * append(" SELECT a.id,c.id AS cid,c.service_measures,CASE WHEN c.service_measures='当日支付' THEN c.sum_money ELSE 0 END AS drzhMny,"
	 * ); sb.
	 * append(" CASE WHEN c.service_measures!='当日支付' THEN c.sum_money ELSE 0 END AS jsMny FROM "
	 * ).append(tableMapper.mapOrder(migration)).append(" as a INNER JOIN ")
	 * .append(tableMapper.mapOrderSettlementDetail(migration)).
	 * append(" as c ON a.id=c.order_id WHERE a.site_id='" + siteId + "' ");
	 * sb.append(empJSCountOrderConditions(map));
	 * sb.append(" AND a.status IN ('3','4','5') AND a.employe_id='" + empId +
	 * "'  GROUP BY c.id ) AS tt"); return sb.toString(); }
	 */

	public List<Record> getEmpJSCountOrderList(Page<Record> page, String siteId, Map<String, Object> map, String migration) {
		List<Record> nowRds = getEmpJSCountOrderList_now(page, siteId, map, migration);
		List<Record> historyRds = Lists.newArrayList();
		if (tableSplitMapper.exists(siteId)) {
			historyRds = getEmpJSCountOrderList_history(page, siteId, map, migration);
		}
		List<Record> finalRds = ActiveRecordUtil.combineRecords("empId", nowRds, historyRds);
		List<Record> retRds = Lists.newArrayList();

		if (page != null && finalRds != null && finalRds.size() > 0) {
			int len = finalRds.size() < page.getPageSize() ? finalRds.size() : page.getPageNo() * page.getPageSize();
			for (int i = (page.getPageNo() - 1) * page.getPageSize(); i < len; i++) {
				// System.out.println(len + " >> " + i);
				if (i > finalRds.size() - 1) {
					break;
				}
				Record rd = finalRds.get(i);
				retRds.add(rd);
			}
		}
		return retRds;
	}

	public List<Record> getEmpJSCountOrderList_now(Page<Record> page, String siteId, Map<String, Object> map, String migration) {
		StringBuilder sb = new StringBuilder();
		String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
		String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
		String endTimeMin = getTrimmedParamValue(map, "endTimeMin");// 完工时间
		String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
		String dtType = getTrimmedParamValue(map, "dtType");
		String employeName = getTrimmedParamValue(map, "employeName");

		sb.append(
				" SELECT cep.id AS empId,cep.name AS empName,ot3.* ,Round((ot3.shortMoney - ot3.yjsShortMny ),2) AS mny1,(ot3.shortHasMoney - ot3.yjsHasMny ) AS mny2,(ot3.sfze - ot3.yjsJsMny) AS mny3,(ot3.sm - ot3.smd) AS mny4,(ot3.wjs) AS mny5 FROM crm_employe cep ");
		sb.append(" LEFT JOIN (SELECT ot1.emp_name,ot1.emp_id,ot1.total,ot1.ywc,ot1.wwc,ot1.wxgd,IFNULL(ot1.shortMoney,0) AS shortMoney,ot1.bmyd,ot1.wjs, "
				+ " ot1.bmyOrder,IFNULL(ot1.sfze,0) AS sfze,ot1.totalCost,ot2.orderCnt AS yjs,IFNULL(ot2.sum_money,0) AS sm ,IFNULL(ot2.sum_money_drzf,0) AS smd, IFNULL(ot2.yjsJsMny,0) AS yjsJsMny ,ot2.yjsJsCost,IFNULL(ot1.shortHasMoney,0) AS shortHasMoney,IFNULL(ot2.yjsShortMny,0) AS yjsShortMny, IFNULL(ot2.yjsHasMny,0) AS yjsHasMny "
				+ " FROM (SELECT odrel.emp_name,odrel.emp_id,COUNT(cd.id) AS total, ");
		sb.append(" COUNT( CASE WHEN a.status IN ('3', '4', '5') THEN 1 END ) AS ywc, ");
		sb.append(" COUNT( CASE WHEN cd.status IN ('1', '2', '4') AND a.`status` = '2' THEN 1  END ) AS wwc, ");
		sb.append(" COUNT( CASE WHEN a.status = '8' THEN 1 END) AS wxgd, ");
		sb.append(" COUNT( CASE WHEN b.service_attitude IN ('1', '2') THEN 1 END ) AS bmyd, ");
		sb.append(" COUNT( CASE WHEN a.status IN ('3', '4') THEN 1 END ) AS wjs, ");
		sb.append(" SUM( CASE WHEN (a.status IN ('3', '4', '5')) THEN (a.serve_cost + a.auxiliary_cost + a.warranty_cost) ELSE 0.00 END ) AS sfze, ");
		sb.append(" SUM(  CASE WHEN (a.status IN ('3', '4', '5')) THEN (a.confirm_cost) ELSE 0.00 END ) AS totalCost , ");
		sb.append(" COUNT( CASE WHEN (b.service_attitude IN ('1','2')) THEN 1 ELSE 0  END ) AS bmyOrder, ");
		sb.append(
				"  SUM(CASE WHEN (a.status IN ('3', '4', '5') AND (a.whether_collection='0' OR a.whether_collection IS NULL OR a.whether_collection=''  ) ) THEN a.serve_cost+a.auxiliary_cost+a.warranty_cost ELSE 0.00 END ) AS shortMoney ");
		sb.append(" ,SUM(CASE WHEN a.status IN ('3', '4', '5') AND a.whether_collection='1' THEN a.confirm_cost ELSE 0.00 END ) AS shortHasMoney");
		sb.append(" FROM crm_order_dispatch cd INNER JOIN ").append(" crm_order a  ON a.id = cd.order_id AND a.site_id = cd.site_id AND a.status != '6'  ");
		if ("2".equals(dtType)) {
			sb.append(" inner join ").append(" crm_order_settlement_detail bb1 on a.id=bb1.order_id ");
		}
		sb.append(" INNER JOIN ").append(" crm_order_dispatch_employe_rel odrel ON odrel.dispatch_id = cd.id AND odrel.order_id = a.id AND odrel.site_id = cd.site_id  ");
		sb.append(" LEFT JOIN ").append(" crm_order_callback b ON b.order_id = a.id AND b.site_id = cd.site_id WHERE a.site_id = ?  ");
		sb.append(" AND cd.status IN ('1', '2', '4', '5') AND a.status != '6'  ");

		if (StringUtils.isNotEmpty(repairTimeMin)) {
			sb.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:01' ");
		}
		if (StringUtils.isNotEmpty(repairTimeMax)) {
			sb.append(" and a.repair_time <= '" + repairTimeMax + " 23:59:59' ");
		}
		if ("1".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and a.end_time >= '" + endTimeMin + " 00:00:01' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
		}
		if ("2".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and bb1.settlement_time >= '" + endTimeMin + "' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and bb1.settlement_time <= '" + endTimeMax + "' ");
			}
		}
		sb.append(" GROUP BY odrel.emp_id) ot1 LEFT JOIN (SELECT iot.id, iot.order_id,iot.employe_id,SUM(iot.sum_money) AS sum_money,SUM(iot.sum_money_drzf) AS sum_money_drzf, ");
		sb.append(" COUNT(iot.order_id) AS orderCnt,SUM(iot.serve_cost+iot.auxiliary_cost+iot.warranty_cost) AS yjsJsMny,SUM(iot.confirm_cost) AS yjsJsCost, ");
		sb.append(" SUM(iot.yjsShortMny) AS  yjsShortMny,SUM(iot.yjsHasMny) AS  yjsHasMny ");
		sb.append("  FROM (SELECT a2.id,SUM( CASE WHEN a2.service_measures != '当日支付' THEN a2.sum_money  ELSE 0 END ) AS sum_money, ");
		sb.append(" SUM(CASE WHEN a2.service_measures = '当日支付' THEN a2.sum_money  ELSE 0 END ) AS sum_money_drzf, ");
		sb.append(" a2.order_id,a2.employe_id,b.serve_cost,b.auxiliary_cost,b.warranty_cost,b.confirm_cost,b.whether_collection,  ");
		sb.append(
				" CASE WHEN (b.whether_collection = '0' OR b.whether_collection IS NULL OR b.whether_collection = '') THEN b.serve_cost + b.auxiliary_cost + b.warranty_cost ELSE 0.00 END AS yjsShortMny, ");
		sb.append(" CASE WHEN (b.whether_collection = '1') THEN b.confirm_cost ELSE 0.00 END AS yjsHasMny");
		sb.append(" FROM ").append(" crm_order_settlement_detail a2,").append(" crm_order b,").append(" crm_order_dispatch c");
		sb.append(
				"  WHERE b.id = a2.order_id  AND b.site_id = a2.site_id AND c.site_id = a2.site_id AND  b.status in ('3','4','5') and  c.status='5' and c.order_id = a2.order_id AND a2.employe_id != 'null'  ");
		sb.append(" AND a2.employe_id IS NOT NULL  AND a2.site_id = ? ");
		if (StringUtils.isNotEmpty(repairTimeMin)) {
			sb.append(" and b.repair_time >= '" + repairTimeMin + " 00:00:01' ");
		}
		if (StringUtils.isNotEmpty(repairTimeMax)) {
			sb.append(" and b.repair_time <= '" + repairTimeMax + " 23:59:59' ");
		}
		if ("1".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and b.end_time >= '" + endTimeMin + " 00:00:01' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and b.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
		}
		if ("2".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and a2.settlement_time >= '" + endTimeMin + "' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and a2.settlement_time <= '" + endTimeMax + "' ");
			}
		}
		sb.append(" GROUP BY a2.order_id,a2.employe_id) iot WHERE 1 = 1 GROUP BY iot.employe_id) ot2 ON ot2.employe_id = ot1.emp_id) ot3  ");
		sb.append(" ON cep.id = ot3.emp_id WHERE cep.status in ('0','3') AND cep.site_id = ? ");

		if (StringUtils.isNotBlank(employeName)) {
			sb.append(" and cep.id in (" + StringUtil.joinInSql(employeName.split(",")) + ")");
		}
		// if (page != null) {sb.append(" limit " + page.getPageSize() + " offset " +
		// (page.getPageNo() - 1) * page.getPageSize());}
		return Db.find(sb.toString(), siteId, siteId, siteId);
	}

	public List<Record> getEmpJSCountOrderList_history(Page<Record> page, String siteId, Map<String, Object> map, String migration) {
		StringBuilder sb = new StringBuilder();
		String repairTimeMin = getTrimmedParamValue(map, "repairTimeMin");
		String repairTimeMax = getTrimmedParamValue(map, "repairTimeMax");
		String endTimeMin = getTrimmedParamValue(map, "endTimeMin");// 完工时间
		String endTimeMax = getTrimmedParamValue(map, "endTimeMax");
		String dtType = getTrimmedParamValue(map, "dtType");
		String employeName = getTrimmedParamValue(map, "employeName");

		sb.append(
				" SELECT cep.id AS empId,cep.name AS empName,ot3.* ,Round((ot3.shortMoney - ot3.yjsShortMny ),2) AS mny1,(ot3.shortHasMoney - ot3.yjsHasMny ) AS mny2,(ot3.sfze - ot3.yjsJsMny) AS mny3,(ot3.sm - ot3.smd) AS mny4,(ot3.wjs) AS mny5 FROM crm_employe cep ");
		sb.append(" LEFT JOIN (SELECT ot1.emp_name,ot1.emp_id,ot1.total,ot1.ywc,ot1.wwc,ot1.wxgd,IFNULL(ot1.shortMoney,0) AS shortMoney,ot1.bmyd,ot1.wjs, "
				+ " ot1.bmyOrder,IFNULL(ot1.sfze,0) AS sfze,ot1.totalCost,ot2.orderCnt AS yjs,IFNULL(ot2.sum_money,0) AS sm ,IFNULL(ot2.sum_money_drzf,0) AS smd, IFNULL(ot2.yjsJsMny,0) AS yjsJsMny ,ot2.yjsJsCost,IFNULL(ot1.shortHasMoney,0) AS shortHasMoney,IFNULL(ot2.yjsShortMny,0) AS yjsShortMny, IFNULL(ot2.yjsHasMny,0) AS yjsHasMny "
				+ " FROM (SELECT odrel.emp_name,odrel.emp_id,COUNT(cd.id) AS total, ");
		sb.append(" COUNT( CASE WHEN a.status IN ('3', '4', '5') THEN 1 END ) AS ywc, ");
		sb.append(" COUNT( CASE WHEN cd.status IN ('1', '2', '4') AND a.`status` = '2' THEN 1  END ) AS wwc, ");
		sb.append(" COUNT( CASE WHEN a.status = '8' THEN 1 END) AS wxgd, ");
		sb.append(" COUNT( CASE WHEN b.service_attitude IN ('1', '2') THEN 1 END ) AS bmyd, ");
		sb.append(" COUNT( CASE WHEN a.status IN ('3', '4') THEN 1 END ) AS wjs, ");
		sb.append(" SUM( CASE WHEN (a.status IN ('3', '4', '5')) THEN (a.serve_cost + a.auxiliary_cost + a.warranty_cost) ELSE 0.00 END ) AS sfze, ");
		sb.append(" SUM(  CASE WHEN (a.status IN ('3', '4', '5')) THEN (a.confirm_cost) ELSE 0.00 END ) AS totalCost , ");
		sb.append(" COUNT( CASE WHEN (b.service_attitude IN ('1','2')) THEN 1 ELSE 0  END ) AS bmyOrder, ");
		sb.append(
				"  SUM(CASE WHEN (a.status IN ('3', '4', '5') AND (a.whether_collection='0' OR a.whether_collection IS NULL OR a.whether_collection=''  ) ) THEN a.serve_cost+a.auxiliary_cost+a.warranty_cost ELSE 0.00 END ) AS shortMoney ");
		sb.append(" ,SUM(CASE WHEN a.status IN ('3', '4', '5') AND a.whether_collection='1' THEN a.confirm_cost ELSE 0.00 END ) AS shortHasMoney");
		sb.append(" FROM " + tableSplitMapper.mapOrderDispatch(siteId) + " cd INNER JOIN " + tableSplitMapper.mapOrder(siteId)
				+ " a  ON a.id = cd.order_id AND a.site_id = cd.site_id AND a.status != '6'  ");
		if ("2".equals(dtType)) {
			sb.append(" inner join ").append(tableSplitMapper.mapOrderSettlementDetail(siteId)).append(" bb1 on a.id=bb1.order_id ");
		}
		sb.append(" INNER JOIN ").append(tableSplitMapper.mapOrderDispatchEmployeRel(siteId))
				.append(" odrel ON odrel.dispatch_id = cd.id AND odrel.order_id = a.id AND odrel.site_id = cd.site_id  ");
		sb.append(" LEFT JOIN ").append(tableSplitMapper.mapOrderCallback(siteId)).append(" b ON b.order_id = a.id AND b.site_id = cd.site_id WHERE a.site_id = ?  ");
		sb.append(" AND cd.status IN ('1', '2', '4', '5') AND a.status != '6'  ");

		if (StringUtils.isNotEmpty(repairTimeMin)) {
			sb.append(" and a.repair_time >= '" + repairTimeMin + " 00:00:01' ");
		}
		if (StringUtils.isNotEmpty(repairTimeMax)) {
			sb.append(" and a.repair_time <= '" + repairTimeMax + " 23:59:59' ");
		}
		if ("1".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and a.end_time >= '" + endTimeMin + " 00:00:01' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and a.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
		}
		if ("2".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and bb1.settlement_time >= '" + endTimeMin + "' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and bb1.settlement_time <= '" + endTimeMax + "' ");
			}
		}
		sb.append(" GROUP BY odrel.emp_id) ot1 LEFT JOIN (SELECT iot.id, iot.order_id,iot.employe_id,SUM(iot.sum_money) AS sum_money,SUM(iot.sum_money_drzf) AS sum_money_drzf, ");
		sb.append(" COUNT(iot.order_id) AS orderCnt,SUM(iot.serve_cost+iot.auxiliary_cost+iot.warranty_cost) AS yjsJsMny,SUM(iot.confirm_cost) AS yjsJsCost, ");
		sb.append(" SUM(iot.yjsShortMny) AS  yjsShortMny,SUM(iot.yjsHasMny) AS  yjsHasMny ");
		sb.append("  FROM (SELECT a2.id,SUM( CASE WHEN a2.service_measures != '当日支付' THEN a2.sum_money  ELSE 0 END ) AS sum_money, ");
		sb.append(" SUM(CASE WHEN a2.service_measures = '当日支付' THEN a2.sum_money  ELSE 0 END ) AS sum_money_drzf, ");
		sb.append(" a2.order_id,a2.employe_id,b.serve_cost,b.auxiliary_cost,b.warranty_cost,b.confirm_cost,b.whether_collection,  ");
		sb.append(
				" CASE WHEN (b.whether_collection = '0' OR b.whether_collection IS NULL OR b.whether_collection = '') THEN b.serve_cost + b.auxiliary_cost + b.warranty_cost ELSE 0.00 END AS yjsShortMny, ");
		sb.append(" CASE WHEN (b.whether_collection = '1') THEN b.confirm_cost ELSE 0.00 END AS yjsHasMny");
		sb.append(" FROM ").append(tableSplitMapper.mapOrderSettlementDetail(siteId)).append(" a2,").append(tableSplitMapper.mapOrder(siteId)).append(" b,")
				.append(tableSplitMapper.mapOrderDispatch(siteId)).append(" c");
		sb.append(
				"  WHERE b.id = a2.order_id  AND b.site_id = a2.site_id AND c.site_id = a2.site_id AND b.status in ('3','4','5') and  c.status='5' and c.order_id = a2.order_id AND a2.employe_id != 'null'  ");
		sb.append(" AND a2.employe_id IS NOT NULL  AND a2.site_id = ? ");
		if (StringUtils.isNotEmpty(repairTimeMin)) {
			sb.append(" and b.repair_time >= '" + repairTimeMin + " 00:00:01' ");
		}
		if (StringUtils.isNotEmpty(repairTimeMax)) {
			sb.append(" and b.repair_time <= '" + repairTimeMax + " 23:59:59' ");
		}
		if ("1".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and b.end_time >= '" + endTimeMin + " 00:00:01' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and b.end_time <= '" + endTimeMax + " 23:59:59' ");
			}
		}
		if ("2".equals(dtType)) {
			if (StringUtils.isNotEmpty(endTimeMin)) {
				sb.append(" and a2.settlement_time >= '" + endTimeMin + "' ");
			}
			if (StringUtils.isNotEmpty(endTimeMax)) {
				sb.append(" and a2.settlement_time <= '" + endTimeMax + "' ");
			}
		}
		sb.append(" GROUP BY a2.order_id,a2.employe_id) iot WHERE 1 = 1 GROUP BY iot.employe_id) ot2 ON ot2.employe_id = ot1.emp_id) ot3  ");
		sb.append(" ON cep.id = ot3.emp_id WHERE cep.status in ('0','3') AND cep.site_id = ? ");

		if (StringUtils.isNotBlank(employeName)) {
			sb.append(" and cep.id in (" + StringUtil.joinInSql(employeName.split(",")) + ")");
		}
		// if (page != null) {sb.append(" limit " + page.getPageSize() + " offset " +
		// (page.getPageNo() - 1) * page.getPageSize());}
		return Db.find(sb.toString(), siteId, siteId, siteId);
	}

	public Long getEmpJSCountOrderCount(String siteId, Map<String, Object> map) {
		StringBuilder sb1 = new StringBuilder();
		String employeName = getTrimmedParamValue(map, "employeName");// 服务工程师
		sb1.append("SELECT count(*) FROM crm_employe a  WHERE a.status IN ('0','3') and a.site_id=?  ");
		if (StringUtils.isNotBlank(employeName)) {
			sb1.append(" and a.id in (" + StringUtil.joinInSql(employeName.split(",")) + ")");
		}
		return Db.queryLong(sb1.toString(), siteId);
	}

	public List<Record> goodsSellDetailList(Page<Record> page, Map<String, Object> map1, String siteId) {
		StringBuffer sd = new StringBuffer();
		sd.append(
				"SELECT a.id AS detailId,a.good_name,o.number AS orderNumber,round(b.comms,2) AS paidCommissions,round(a.sales_commissions,2) as sales_commissions,round(a.real_amount,2) as real_amount, ");
		sd.append(
				" a.purchase_num,a.good_cost,round((a.real_amount-a.sales_commissions-a.good_cost),2)AS profitsAll,a.creator,DATE_FORMAT(a.create_time,'%Y-%m-%d %H:%i') as createTime ");
		sd.append(" FROM crm_goods_siteself_order_goods_detail a INNER JOIN crm_goods_siteself_order o ON a.site_order_id=o.id LEFT JOIN ");
		sd.append(" ( SELECT SUM(m.paid_commissions) AS comms,m.site_order_goods_detail_id,m.status,m.good_id,m.site_order_id FROM crm_goods_siteself_order_deduct_detail m ");
		sd.append(" WHERE m.status='0' AND m.site_id=?  GROUP BY m.site_order_goods_detail_id,m.good_id)");
		sd.append(" as b ON a.site_order_id=b.site_order_id AND b.status='0' AND b.site_order_goods_detail_id=a.id  AND a.good_id=b.good_id");
		sd.append(" WHERE  a.status='0' AND o.status!='0' AND a.site_id=?");
		sd.append(goodsSellConditions(map1));
		sd.append(" order by a.create_time desc");
		if (page != null) {
			sd.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sd.toString(), siteId, siteId);
	}

	public Long goodsSellDetailCount(Map<String, Object> map1, String siteId) {
		StringBuffer sd = new StringBuffer();
		sd.append("SELECT count(*) ");
		sd.append(" FROM crm_goods_siteself_order_goods_detail a INNER JOIN crm_goods_siteself_order o ON a.site_order_id=o.id ");
		sd.append(" WHERE  a.status='0' AND o.status!='0' AND a.site_id=?");
		sd.append(goodsSellConditions(map1));
		return Db.queryLong(sd.toString(), siteId);
	}

	public String goodsSellConditions(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String goodName = getTrimmedParamValue(map, "goodName");// 商品名称
			if (StringUtils.isNotEmpty(goodName)) {
				sf.append(" and a.good_name like '%" + goodName + "%' ");
			}
			String goodCategory = getTrimmedParamValue(map, "goodCategory");// 商品品类
			if (StringUtils.isNotEmpty(goodCategory)) {
				sf.append(" and a.good_category = '" + goodCategory + "' ");
			}
			String goodBrand = getTrimmedParamValue(map, "goodBrand");// 商品品牌
			if (StringUtils.isNotEmpty(goodBrand)) {
				sf.append(" and a.good_brand like '%" + goodBrand + "%' ");
			}
			// 零售时间
			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
			if (StringUtils.isNotEmpty(createTimeMin)) {
				sf.append(" and a.create_time >= '" + createTimeMin + " 00:00:00' ");
			}
			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
			if (StringUtils.isNotEmpty(createTimeMax)) {
				sf.append(" and a.create_time <= '" + createTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public List<Record> goodsSellAllList(Page<Record> page, Map<String, Object> map1, String siteId) {
		StringBuffer sd = new StringBuffer();
		sd.append(" select  from ( ");
		sd.append(
				"SELECT a.id AS detailId,a.good_name,o.number AS orderNumber,round(b.comms,2) AS paidCommissions,round(a.sales_commissions,2) as sales_commissions,round(a.real_amount,2) as real_amount, ");
		sd.append(" a.purchase_num,a.good_cost,round((a.real_amount-a.sales_commissions-a.good_cost),2)AS profitsAll,a.good_id ");
		sd.append(" FROM crm_goods_siteself_order_goods_detail a left JOIN crm_goods_siteself_order o ON a.site_order_id=o.id LEFT JOIN ");
		sd.append(" ( SELECT SUM(m.paid_commissions) AS comms,m.site_order_goods_detail_id,m.status,m.good_id,m.site_order_id FROM crm_goods_siteself_order_deduct_detail m ");
		sd.append(" WHERE m.status='0' AND m.site_id=?  GROUP BY m.site_order_goods_detail_id,m.good_id)");
		sd.append(" as b ON a.site_order_id=b.site_order_id AND b.status='0' AND b.site_order_goods_detail_id=a.id  AND a.good_id=b.good_id");
		sd.append(" WHERE  a.status='0' AND o.status!='0' AND a.site_id=?");
		sd.append(goodsSellConditions(map1));
		sd.append(" ) as tt group by tt.good_id  ");
		if (page != null) {
			sd.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sd.toString(), siteId, siteId);
	}

	public Long goodsSellAllCount(Map<String, Object> map1, String siteId) {
		StringBuffer sd = new StringBuffer();
		sd.append("SELECT count(*) ");
		sd.append(" FROM crm_goods_siteself_order_goods_detail a INNER JOIN crm_goods_siteself_order o ON a.site_order_id=o.id ");
		sd.append(" WHERE  a.status='0' AND o.status!='0' AND a.site_id=?");
		sd.append(goodsSellConditions(map1));
		return Db.queryLong(sd.toString(), siteId);
	}

	public Record getGoodsTotal(Map<String, Object> map, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT SUM(a.purchase_num) AS purchase_num,");
		sf.append("SUM(a.real_amount) AS real_amount,");
		sf.append("SUM(a.confirm_amount) AS confirm_amount,");
		sf.append("SUM(a.real_amount - a.confirm_amount) AS shortNeedMoney,");
		sf.append("SUM(a.sales_commissions) AS sales_commissions,");
		sf.append("SUM(a.paid_commissions) AS paid_commissions,");
		sf.append("SUM(a.goods_cost) AS goods_cost,");
		sf.append("SUM(a.real_amount - a.sales_commissions - a.goods_cost) AS salesProfit,");
		sf.append("SUM(a.confirm_amount - a.sales_commissions - a.goods_cost) AS realProfit");
		sf.append(" FROM crm_goods_siteself_order a  ");
		sf.append(" WHERE a.site_id=? AND a.status !='0' ");
		sf.append(getGoodsRevenueFilter(map));
		return Db.findFirst(sf.toString(), siteId);
	}

}
