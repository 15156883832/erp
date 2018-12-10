package com.jojowonet.modules.statistics.service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.jojowonet.modules.order.utils.*;
import com.jojowonet.modules.sys.util.ActiveRecordUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.fmss.utils.DataUtils;
import com.jojowonet.modules.fmss.utils.HttpUtils;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.statistics.dao.OrderStatDao;
import com.jojowonet.modules.statistics.form.HighMapsProvince;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import net.sf.json.JSONArray;

@Component
@Transactional(readOnly = true)
public class OrderStatService extends BaseService {

	@Autowired
	private OrderStatDao orderStatDao;
	@Autowired
	private NonServicemanDao nonDao;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private SiteMsgService siteMsgService;

	@Autowired
	TableSplitMapper tableSplitMapper;

	/**
	 *
	 * @param siteId
	 *            :网点ID
	 * @param year
	 *            :查询年份
	 * @return
	 */
	public Map<String, Object> getAllOrderStat(String siteId, String year) {
		Map<String, Object> retMap = Maps.newHashMap();
		List<Record> rds = orderStatDao.getAllOrderStat(siteId, year);
		List<String> monthList = Lists.newArrayList();
		List<Map<String, Long>> totalList = Lists.newArrayList();
		for (Record rd : rds) {
			String monthStr = rd.getStr("month");
			monthList.add(monthStr + "月");
			Map<String, Long> totalItem = Maps.newHashMap();
			Long total = rd.getLong("total");
			totalItem.put("y", total);
			totalList.add(totalItem);
			BigDecimal totalHour = rd.getBigDecimal("totalHours");
			BigDecimal avgs = new BigDecimal(totalHour.doubleValue() / total);
			rd.set("avgs", avgs.setScale(2, BigDecimal.ROUND_HALF_UP));
		}
		retMap.put("monthList", JSONArray.fromObject(monthList));
		retMap.put("totalList", JSONArray.fromObject(totalList));
		retMap.put("items", rds);
		return retMap;
	}

	/***
	 * 服務工程師統計
	 * 
	 * @param siteId
	 * @param start
	 * @param end
	 * @param params
	 * @return
	 */
	public Map<String, Object> getAllEmployeOrderStat(String siteId, String start, String end, String empIds, Map<String, String> params) {
		Map<String, Object> retMap = Maps.newHashMap();
		List<Record> rds = orderStatDao.getAllEmployeOrderStat(siteId, start, end, empIds, params);

		// List<Record> emps = employeDao.findBySiteId(siteId);
		// Map<String, Object> empMap = DataUtils.records2Map(emps, "id");

		List<String> cates = Lists.newArrayList();
		List<Integer> wcs = Lists.newArrayList();
		List<Double> avgHour = Lists.newArrayList();

		/*
		 * int empCount = emps.size(); for(Record emp : emps){
		 * 
		 * String rdEmpId = rd.getStr("employe_id");
		 * 
		 * 
		 * String empId = emp.getStr("id"); int ywcs = 0; Double avg = 0d; Double
		 * totalHours = 0d; Long total = 0l; Double totalCost = 0d; Long bmyd = 0l;
		 * for(Record rd : rds){ if(rd.getStr("employe_id").indexOf(empId) !=
		 * -1){//当前的服务工程师有工单 bmyd += rd.getLong("bmyd"); ywcs +=
		 * rd.getLong("ywc").intValue(); total += rd.getLong("total"); BigDecimal bd =
		 * rd.getBigDecimal("totalHours"); totalHours += bd.doubleValue(); totalCost +=
		 * rd.getBigDecimal("totalCost").doubleValue(); } } if(ywcs != 0){ avg = new
		 * BigDecimal(totalHours/ywcs).setScale(2,
		 * BigDecimal.ROUND_HALF_UP).doubleValue(); } cates.add(emp.getStr("name"));
		 * emp.set("wcs", ywcs); emp.set("total", total); wcs.add(ywcs);
		 * avgHour.add(avg); emp.set("avg", avg); emp.set("bmyd", bmyd);
		 * emp.set("totalCost", totalCost); }
		 */

		// retMap.put("empCount", empCount);
		retMap.put("list", rds);
		retMap.put("cates", JSONArray.fromObject(cates));
		retMap.put("wcs", JSONArray.fromObject(wcs));
		retMap.put("avgHour", JSONArray.fromObject(avgHour));
		return retMap;
	}

	public Page<Record> getStockStat(Page<Record> page, String siteId, String fittingCode, String fittingName, String whoStatistics) {
		Map<String, Object> retMap = Maps.newHashMap();
		List<Record> rds = null;
		Long count = (long) 0;
		if ("1".equals(whoStatistics)) {// 公司库存总资产盘点
			rds = orderStatDao.getStockStat(siteId, fittingCode, fittingName, page);
			count = orderStatDao.getStockStatCount(siteId, fittingCode, fittingName);
		} else if ("2".equals(whoStatistics)) {// 工程师库存总资产盘点
			rds = orderStatDao.getEmpStockStat(siteId, fittingCode, fittingName, page);
			count = orderStatDao.getEmpStockStatCount(siteId, fittingCode, fittingName);
		} else {// 旧件库存总资产盘点
			rds = orderStatDao.getOldStockStat(siteId, fittingCode, fittingName, page);
			count = orderStatDao.getOldStockStatCount(siteId, fittingCode, fittingName);
		}
		page.setList(rds);
		page.setCount(count);
		return page;
	}

	public Map<String, Object> getTotalCount(String siteId) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT  a.warning as allWarning,a.site_price as allPrice ");
		sb.append(" FROM crm_site_fitting a");
		sb.append(" LEFT JOIN crm_site_fitting_used_record b ON b.fitting_id = a.id");
		sb.append(" WHERE a.status='1' AND a.`site_id`='" + siteId + "' GROUP BY a.id ");
		List<Record> res = Db.find(sb.toString());
		Map<String, Object> map = Maps.newHashMap();
		Double warning = 0d;
		Double price = 0d;
		Double priceal = 0d;// 每个备件的总价
		Double totalPrice = 0d;// 所有配件的终极价格
		if (res != null) {
			for (Record re : res) {
				if (re.getBigDecimal("allWarning") != null) {
					warning = re.getBigDecimal("allWarning").doubleValue();
				} else {
					warning = 0d;
				}
				if (re.getBigDecimal("allPrice") != null) {
					price = re.getBigDecimal("allPrice").doubleValue();
				} else {
					price = 0d;
				}
				priceal = warning * price;
				totalPrice += priceal;
			}
		}
		map.put("complanyPrice", totalPrice);// 公司库存总资产
		map.put("empPrice", getEmpCounts(siteId));// 工程师库存总资产
		map.put("oldPrice", getOldFittigStockPrice(siteId));// 工程师库存总资产
		return map;
	}

	// 工程师库存总资产
	public Double getEmpCounts(String siteId) {
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT a.warning,b.site_price ");
		sb.append(" FROM crm_employe_fitting a ");
		sb.append(" LEFT JOIN crm_site_fitting b ON a.fitting_id=b.`id` ");
		sb.append(" LEFT JOIN crm_employe_fitting_keep c ON c.fitting_id = a.fitting_id ");
		sb.append(" WHERE a.status='1' AND a.site_id = ? ");
		sb.append("  group by a.id");
		List<Record> res = Db.find(sb.toString(), siteId);
		Double warning = 0d;
		Double price = 0d;
		Double priceal = 0d;// 每个备件的总价
		Double totalPrice = 0d;// 所有配件的总价
		if (res != null) {
			for (Record re : res) {
				if (re.getBigDecimal("warning") != null) {
					warning = re.getBigDecimal("warning").doubleValue();
				} else {
					warning = 0d;
				}
				if (re.getBigDecimal("site_price") != null) {
					price = re.getBigDecimal("site_price").doubleValue();
				} else {
					price = 0d;
				}
				priceal = warning * price;
				totalPrice += priceal;
			}
		}
		return totalPrice;
	}

	public Double getOldFittigStockPrice(String siteId) {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.num,a.unit_price FROM crm_site_old_fitting a ");
		sb.append(" WHERE a.status='1' and a.site_id=? ");
		sb.append(" GROUP BY a.id ");
		List<Record> res = Db.find(sb.toString(), siteId);
		Double warning = 0d;
		Double price = 0d;
		Double priceal = 0d;// 每个备件的总价
		Double totalPrice = 0d;// 所有配件的总价
		if (res != null) {
			for (Record re : res) {
				if (re.getBigDecimal("num") != null) {
					warning = re.getBigDecimal("num").doubleValue();
				} else {
					warning = 0d;
				}
				if (re.getBigDecimal("unit_price") != null) {
					price = re.getBigDecimal("unit_price").doubleValue();
				} else {
					price = 0d;
				}
				priceal = warning * price;
				totalPrice += priceal;
			}
		}
		return totalPrice;
	}

	public Map<String, Object> getOrderCompleteStat(String siteId, String startStr, String endStr) {
		Record rd = orderStatDao.getOrderCompleteStat(siteId, startStr, endStr);
		Record dispRd = orderStatDao.getOrderDispatchStat(siteId, startStr, endStr);
		List<Record> serviceTypeStats = orderStatDao.getServiceTypeSum(siteId, startStr, endStr);
		Map<String, Object> retMap = Maps.newHashMap();
		Long total = rd.getLong("total");
		Long disTotal = dispRd.getLong("total");
		Long disJDJS = dispRd.getLong("jdjs");
		int jdjs = 0;
		if (disTotal != 0) {
			jdjs = DataUtils.doubleToPercent(disJDJS.doubleValue() / disTotal);
		}
		int jdbjs = 100 - jdjs;
		retMap.put("jdjs", jdjs);
		retMap.put("jdbjs", jdbjs);
		retMap.put("total", total);
		if (total > 0) {
			retMap.put("baonei", DataUtils.doubleToPercent(rd.getLong("baonei").doubleValue() / total));
			retMap.put("baowai", DataUtils.doubleToPercent(rd.getLong("baowai").doubleValue() / total));
			// retMap.put("anzhuang",
			// DataUtils.doubleToPercent(rd.getLong("anzhuang").doubleValue()/total));
			// retMap.put("weixiu",
			// DataUtils.doubleToPercent(rd.getLong("weixiu").doubleValue()/total));
			// retMap.put("baoyang",
			// DataUtils.doubleToPercent(rd.getLong("baoyang").doubleValue()/total));
			retMap.put("zcshangmen", DataUtils.doubleToPercent(rd.getLong("zcshangmen").doubleValue() / total));
			retMap.put("duocishangmen", DataUtils.doubleToPercent(rd.getLong("duocishangmen").doubleValue() / total));
			retMap.put("zcpaigong", DataUtils.doubleToPercent(rd.getLong("zcpaigong").doubleValue() / total));
			retMap.put("duocipaigong", DataUtils.doubleToPercent(rd.getLong("duocipaigong").doubleValue() / total));
			retMap.put("sfbmy", DataUtils.doubleToPercent(rd.getLong("sfbmy").doubleValue() / total));
			retMap.put("bmy", DataUtils.doubleToPercent(rd.getLong("bmy").doubleValue() / total));
			retMap.put("ybmy", DataUtils.doubleToPercent(rd.getLong("ybmy").doubleValue() / total));
			retMap.put("my", DataUtils.doubleToPercent(rd.getLong("my").doubleValue() / total));
			retMap.put("sfmy", DataUtils.doubleToPercent(rd.getLong("sfmy").doubleValue() / total));
		}
		if (rd.getLong("totalYS") != null) {
			retMap.put("totalYS", rd.getLong("totalYS").doubleValue());
		}
		if (rd.getBigDecimal("YS24") != null) {
			retMap.put("YS24", rd.getBigDecimal("YS24").doubleValue());
		}
		if (rd.getBigDecimal("YS48") != null) {
			retMap.put("YS48", rd.getBigDecimal("YS48").doubleValue());
		}
		if (rd.getBigDecimal("YS72") != null) {
			retMap.put("YS72", rd.getBigDecimal("YS72").doubleValue());
		}
		if (rd.getBigDecimal("YSOV72") != null) {
			retMap.put("YSOV72", rd.getBigDecimal("YSOV72").doubleValue());
		}

		/*
		 * retMap.put("YS24", rd.getBigDecimal("YS24").doubleValue());
		 * retMap.put("YS48", rd.getBigDecimal("YS48").doubleValue());
		 * retMap.put("YS72", rd.getBigDecimal("YS72").doubleValue());
		 * retMap.put("YSOV72", rd.getBigDecimal("YSOV72").doubleValue());
		 */

		retMap.put("saf1", rd.getLong("saf1").doubleValue());
		retMap.put("saf2", rd.getLong("saf2").doubleValue());
		retMap.put("saf3", rd.getLong("saf3").doubleValue());
		retMap.put("saf4", rd.getLong("saf4").doubleValue());
		retMap.put("serviceTypeStats", serviceTypeStats);
		return retMap;
	}

	public Map<String, Object> getAllGoodsStat(String siteId, String saleTime, String goodCatetgory) {
		StringBuilder sb = new StringBuilder();
		sb.append(" select a.id AS good_id,a.name AS good_name,a.number AS good_number,a.category AS good_category, ");
		sb.append(" a.stocks,b.purchaseNum,b.saleMoney,b.outstock_time,b.placing_order_time ");
		sb.append(" FROM crm_goods_siteself a LEFT JOIN ");
		sb.append(" ((SELECT m.good_id,dd.outstock_time,dd.placing_order_time,SUM(m.real_amount) AS saleMoney ,");
		sb.append("SUM(m.purchase_num) AS purchaseNum FROM  crm_goods_siteself_order_goods_detail m INNER JOIN crm_goods_siteself_order dd ON m.site_order_id=dd.id  WHERE ");
		sb.append("m.outstock_type IN ('0','1','2') AND dd.status IN ('2','3') and m.status='0' GROUP BY m.good_id) AS b)");

		sb.append(" ON a.id = b.good_id AND a.status = '0' WHERE a.status ='0' AND a.site_id = ? ");
		if (StringUtils.isNotBlank(saleTime)) {// 2017-6
			String[] arr = saleTime.split(",");
			String times = "";
			for (int i = 0; i < arr.length; i++) {
				if (i == 0) {
					String as;
					if (arr[0].length() == 6) {
						as = arr[0].substring(0, 5) + "0" + arr[0].substring(5, 6);
						times = "'" + as + "'";
					} else {
						times = "'" + arr[0] + "'";
					}
				} else {
					String as;
					if (arr[i].length() == 6) {
						as = arr[i].substring(0, 5) + "0" + arr[i].substring(5, 6);
						times = times + ",'" + as + "'";
					} else {
						times = times + ",'" + arr[i] + "'";
					}
				}
			}

			sb.append(" and ( DATE_FORMAT(b.outstock_time,'%Y-%m') in (" + times + ")  or  DATE_FORMAT(b.placing_order_time,'%Y-%m') in (" + times + ")  )");
		}
		if (StringUtils.isNotBlank(goodCatetgory)) {
			sb.append(" and a.category = '" + goodCatetgory + "' ");
		}

		List<Record> rds = Db.find(sb.toString(), siteId);
		Double numTotal = 0d;
		Double moneyTotal = 0d;
		for (Record item : rds) {
			Double db = (item.getBigDecimal("purchaseNum") != null ? item.getBigDecimal("purchaseNum") : new BigDecimal(0)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			numTotal += db;
			item.set("purchaseNum", DataUtils.doubleInScale(db, 2));
			db = (item.getBigDecimal("saleMoney") != null ? item.getBigDecimal("saleMoney") : new BigDecimal(0)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			moneyTotal += db;
			item.set("saleMoney", DataUtils.doubleInScale(db, 2));
		}
		Record rd = orderStatDao.getStockInfo(siteId);
		BigDecimal empStockBd = rd.getBigDecimal("empStocks");
		BigDecimal empMoneyBd = rd.getBigDecimal("empMoney");
		if (empStockBd == null) {
			empStockBd = BigDecimal.valueOf(0);
		}
		if (empMoneyBd == null) {
			empMoneyBd = BigDecimal.valueOf(0);
		}

		BigDecimal siteStocksBd = rd.getBigDecimal("siteStocks");
		BigDecimal siteMoneyBd = rd.getBigDecimal("siteMoney");
		if (siteStocksBd == null) {
			siteStocksBd = BigDecimal.valueOf(0);
		}
		if (siteMoneyBd == null) {
			siteMoneyBd = BigDecimal.valueOf(0);
		}
		Double totalStock = empStockBd.doubleValue() + siteStocksBd.doubleValue();
		Double totalMoney = empMoneyBd.doubleValue() + siteMoneyBd.doubleValue();
		rd.set("totalStock", DataUtils.doubleInScale(totalStock, 2));
		rd.set("totalMoney", DataUtils.doubleInScale(totalMoney, 2));
		rd.set("siteMoney", DataUtils.doubleInScale(siteMoneyBd.doubleValue(), 2));
		rd.set("empMoney", DataUtils.doubleInScale(empMoneyBd.doubleValue(), 2));
		rd.set("siteStocks", DataUtils.doubleInScale(siteStocksBd.doubleValue(), 2));
		rd.set("empStocks", DataUtils.doubleInScale(empStockBd.doubleValue(), 2));

		rd.set("numTotal", DataUtils.doubleInScale(numTotal, 2));
		rd.set("moneyTotal", DataUtils.doubleInScale(moneyTotal, 2));
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("stockInfo", rd);
		retMap.put("list", rds);
		return retMap;
	}

	public Page<Record> getbmygdlist(Page<Record> page, String year, String month, String siteId) {
		List<Record> list = orderStatDao.getbmygdlist(page, year, month, siteId);
		long count = orderStatDao.getbmycount(year, month, siteId);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Record> getEmplist(String siteId) {
		return Db.find("select a.* from crm_employe a where a.site_id=? and a.status='0' ", siteId);
	}

	public Page<Record> employeGoodsAnalyseList(Page<Record> page, Map<String, Object> map, String siteId) {
		List<Record> rds = orderStatDao.getEmpGoodsList(page, map, siteId);
		Long count = orderStatDao.countEmpGoodsRevenue(map, siteId);
		page.setList(rds);
		page.setCount(count);
		return page;
	}

	public List<Record> getPrintGoodsList(Map<String, Object> map, String siteId) {
		return orderStatDao.getEmpGoodsList(null, map, siteId);

	}

	public Page<Record> getSiteRankList(Page<Record> page, Map<String, Object> params) {
		List<Record> list = orderStatDao.getSiteRankList(page, params);
		Long count = orderStatDao.countSiteRank(page, params);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public String getSiteLoubaoMonthData(Map<String, Object> params) {
		List<Record> rds = orderStatDao.getSiteLoubaoMonthList(params);
		Map<String, Object> map = wrapSiteLoubaoMonthData(rds, params);
		return new Gson().toJson(map);
	}

	private Map<String, Object> wrapSiteLoubaoMonthData(List<Record> rds, Map<String, Object> params) {
		Map<String, Object> retMap = Maps.newHashMap();
		String queryMonth = String.valueOf(params.get("queryMonth"));
		Date now = new Date();
		String nowMonthStr = DateUtils.formatDate(now, "yyyy-MM");
		String[] pattern = { "yyyy-MM" };
		Date date = new Date();
		int total = 0;
		try {
			date = DateUtils.parseDate(queryMonth, pattern);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Calendar cl = Calendar.getInstance();
		cl.setTime(date);
		int curMonthDay = 0;
		if (nowMonthStr.equalsIgnoreCase(queryMonth)) {// 当前月，取当前天数
			cl.setTime(now);
			curMonthDay = cl.get(Calendar.DAY_OF_MONTH);
		} else {
			curMonthDay = cl.getActualMaximum(Calendar.DAY_OF_MONTH);
		}

		String curMonthStr = DateUtils.formatDate(date, "yyyy-MM");
		List<Object[]> retList = Lists.newArrayList();
		if (rds != null && rds.size() > 0) {
			for (int i = 1; i <= curMonthDay; i++) {
				String month = curMonthStr;
				if (i < 10) {
					month = month + "-" + "0" + i;
				} else {
					month = month + "-" + i;
				}
				boolean hasVal = false;
				int subTotal = 0;
				int subCs = 0;
				for (int idx = 0; idx < rds.size(); idx++) {
					Record rd = rds.get(idx);
					String monthStr = DateUtils.formatDate(rd.getDate("paytime"), "yyyy-MM-dd");
					if (month.equalsIgnoreCase(monthStr)) {
						// Double zs = Double.valueOf(String.valueOf(rd.get("totalNum", "0")));//购买总数
						Double zs = rd.getBigDecimal("totalNum").doubleValue();// 购买总数
						total += zs.intValue();
						subTotal += zs.intValue();
						// item[2] = Double.valueOf(String.valueOf(rd.get("cs", "0")));//购买次数
						subCs += Double.valueOf(String.valueOf(rd.get("cs", "0")));// 购买次数
						hasVal = true;
						// break;
					}
				}
				if (!hasVal) {
					Object[] item = new Object[3];
					item[0] = month;
					item[1] = 0d;// 购买总数
					item[2] = 0d;// 购买次数
					retList.add(item);
				} else {
					Object[] item = new Object[3];
					item[0] = month;
					item[1] = subTotal;
					item[2] = subCs;
					retList.add(item);
				}
			}
		}
		retMap.put("items", retList);
		retMap.put("total", total);
		return retMap;
	}

	/**
	 * 获取vip统计图表数据
	 * 
	 * @param params
	 * @return
	 */
	public String getVipChartData(Map<String, Object> params) {
		List<Record> rds = orderStatDao.getVipChartData(params);
		Map<String, Object> map = wrapVipChartData(rds, params);
		return new Gson().toJson(map);
	}

	private Map<String, Object> wrapVipChartData(List<Record> rds, Map<String, Object> params) {
		Map<String, Object> retMap = Maps.newHashMap();
		List<Object[]> retList = Lists.newArrayList();
		int total = 0;
		Calendar curCL = Calendar.getInstance();
		Date now = curCL.getTime();
		List<String> xCategories = Lists.newArrayList();
		if (rds != null && rds.size() > 0) {
			for (int i = 0; i < 25; i++) {
				curCL.setTime(now);
				curCL.add(Calendar.MONTH, i);
				int curYear = curCL.get(Calendar.YEAR);
				int curMonth = curCL.get(Calendar.MONTH) + 1;
				String month = curYear + "-" + curMonth;

				boolean hasVal = false;
				int subTotal = 0;
				for (int idx = 0; idx < rds.size(); idx++) {
					Record rd = rds.get(idx);
					String monthStr = rd.getStr("mt");
					if (month.equalsIgnoreCase(monthStr)) {
						Long cnt = rd.getLong("cnt");// 到期服务商数
						total += cnt.intValue();
						subTotal += cnt.intValue();
						hasVal = true;
						// break;
					}
				}
				xCategories.add(month);
				if (!hasVal) {
					Object[] item = new Object[2];
					item[0] = month;
					item[1] = 0d;// 购买总数
					retList.add(item);
				} else {
					Object[] item = new Object[2];
					item[0] = month;
					item[1] = subTotal;
					retList.add(item);
				}
			}
		}
		retMap.put("items", retList);
		retMap.put("total", total);
		retMap.put("xCategories", xCategories);
		return retMap;
	}

	/**
	 * 获取VIP统计页面的地图信息
	 * 
	 * @param params
	 * @return
	 */
	public String getVipMapJsonData(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		String start = DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss");

		sb.append(" select a.province, count(case when a.due_time >= '" + start + "' then 1 end) as vfws, ");
		sb.append(" count(case when (a.due_time < '" + start + "' or a.due_time is null) then 1 end) as nvfws ");
		sb.append(" from crm_site a where a.status = '0'  ");
		sb.append(" group by a.province ");
		sb.append("  ");

		Map<String, Object> retMap = Maps.newHashMap();
		List<Map<String, Object>> items = Lists.newArrayList();
		int total = 0;
		int nvTotal = 0;
		Map<String, String> countMap = Maps.newHashMap();
		List<Record> rds = Db.find(sb.toString());
		if (rds != null) {
			for (Record rd : rds) {
				String province = rd.getStr("province");
				String proStr = HighMapsProvince.parseProvince(province);
				if (StringUtils.isNotBlank(proStr)) {// 存在于HighMaps的数据中，则需要统计,因为数据库中省份存储的不一致，所以需要总和
					int fws = rd.getLong("vfws").intValue();// vip服务商数
					int nvfws = rd.getLong("nvfws").intValue();// 非vip服务商
					total += fws;
					nvTotal += nvfws;
					if (countMap.containsKey(proStr)) {
						String[] tmpArr = countMap.get(proStr).split("_");
						fws += Integer.valueOf(tmpArr[0]);
						nvfws += Integer.valueOf(tmpArr[1]);
					}
					String cntStr = fws + "_" + nvfws;
					countMap.put(proStr, cntStr);
				}
			}
		}
		for (Entry<String, String> ent : countMap.entrySet()) {
			Map<String, Object> item = Maps.newHashMap();
			String key = ent.getKey();
			String[] vals = ent.getValue().split("_");
			item.put("name", key);
			item.put("value", Integer.valueOf(vals[0]) + Integer.valueOf(vals[1]));
			item.put("vfws", Integer.valueOf(vals[0]));
			item.put("nvfws", Integer.valueOf(vals[1]));
			items.add(item);
		}

		retMap.put("total", total);
		retMap.put("nvTotal", nvTotal);
		retMap.put("items", items);
		return new Gson().toJson(retMap);
	}

	/**
	 * 获取漏保统计页面的地图信息
	 * 
	 * @param params
	 * @return
	 */
	public String getMapJsonData(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select sum(ot.cs) as cs, sum(ot.zs) as zs, ot.province, count(ot.site_id) as fws from ( ");
		sb.append(" select count(a.id) as cs, sum(a.purchase_num) as zs, a.province, a.site_id  ");
		sb.append(" from crm_goods_platform_transfer_order a where a.pay_status='1' and a.good_category like '%插座%' ");
		sb.append(" group by a.province, a.site_id ");
		sb.append(" ) ot ");
		sb.append(" group by ot.province ");

		Map<String, Object> retMap = Maps.newHashMap();
		List<Map<String, Object>> items = Lists.newArrayList();
		// int total = 0;
		Map<String, String> countMap = Maps.newHashMap();
		List<Record> rds = Db.find(sb.toString());
		if (rds != null) {
			for (Record rd : rds) {
				Map<String, Object> map = Maps.newHashMap();
				String province = rd.getStr("province");
				String proStr = HighMapsProvince.parseProvince(province);
				if (StringUtils.isNotBlank(proStr)) {// 存在于HighMaps的数据中，则需要统计,因为数据库中省份存储的不一致，所以需要总和
					int cscnt = rd.getBigDecimal("cs").intValue();// 次数总和
					int zscnt = rd.getBigDecimal("zs").intValue();// 总数总和
					int fws = rd.getLong("fws").intValue();// 服务商数
					// total += zscnt;
					if (countMap.containsKey(proStr)) {
						String[] tmpArr = countMap.get(proStr).split("_");
						cscnt += Integer.valueOf(tmpArr[0]);
						zscnt += Integer.valueOf(tmpArr[1]);
						fws += Integer.valueOf(tmpArr[2]);
					}
					String cntStr = cscnt + "_" + zscnt + "_" + fws;
					countMap.put(proStr, cntStr);
				}
			}
		}
		for (Entry<String, String> ent : countMap.entrySet()) {
			Map<String, Object> item = Maps.newHashMap();
			String key = ent.getKey();
			String[] vals = ent.getValue().split("_");
			item.put("name", key);
			item.put("value", Integer.valueOf(vals[1]));
			item.put("fws", Integer.valueOf(vals[2]));
			item.put("cs", Integer.valueOf(vals[0]));
			item.put("zs", Integer.valueOf(vals[1]));
			items.add(item);
		}
		Record totalRd = Db.findFirst("select sum(a.`purchase_num`) as total from crm_goods_platform_transfer_order a where a.pay_status='1' and a.good_category like '%插座%' ");
		retMap.put("total", totalRd.getBigDecimal("total").intValue());
		retMap.put("items", items);
		return new Gson().toJson(retMap);
	}

	public Map<String, Object> getSiteLoginStatistic(Map<String, Object> queryMap) {
		Date now = new Date();
		String dateStr = DateUtils.formatDate(now, "yyyy-MM");
		String queryMonth = String.valueOf(queryMap.get("queryMonth"));
		Calendar cl = Calendar.getInstance();
		int curMonthDay = 0;
		if (dateStr.equals(queryMonth)) {// 当前月，取当前天数
			cl.setTime(now);
			curMonthDay = cl.get(Calendar.DAY_OF_MONTH);
		} else {
			curMonthDay = cl.getActualMaximum(Calendar.DAY_OF_MONTH);
		}
		Date date = null;
		String[] pattern = { "yyyy-MM" };
		try {
			date = DateUtils.parseDate(queryMonth, pattern);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		StringBuilder sb = new StringBuilder("");
		sb.append(" select * from ( ");
		sb.append(" select a.site_unit_cnt as suCnt, sum(a.site_cnt) as siteCnt, ");
		sb.append(" sum(a.non_serman_cnt) as nsiteCnt,  ");
		sb.append(" sum(a.employe_cnt) as esiteCnt,  ");
		sb.append(" date(a.create_time) as dt ");
		sb.append(" from crm_site_daily_login_statistic a  ");
		if (StringUtil.checkParamsValid(queryMap.get("areaId"))) {
			sb.append(" LEFT JOIN crm_area_manager_site_rel c ON c.site_id = a.site_id  ");
			sb.append("  WHERE c.area_manager_id='" + queryMap.get("areaId") + "' ");
		}
		sb.append(" group by date(a.create_time) ");
		sb.append(" ) ot order by ot.dt desc ");
		List<Record> rds = Db.find(sb.toString());

		List<Object[]> suList = Lists.newArrayList();
		List<Object[]> sList = Lists.newArrayList();
		List<Object[]> nList = Lists.newArrayList();
		List<Object[]> eList = Lists.newArrayList();
		Map<String, Object> retMap = Maps.newHashMap();

		String curMonthStr = DateUtils.formatDate(date, "yyyy-MM");
		for (int i = 1; i <= curMonthDay; i++) {
			String month = curMonthStr;
			if (i < 10) {
				month = month + "-" + "0" + i;
			} else {
				month = month + "-" + i;
			}
			boolean goNext = false;
			for (Record rd : rds) {
				String dt = DateUtils.formatDate(rd.getDate("dt"), "yyyy-MM-dd");
				if (month.equals(dt)) {
					int siteUnitCnt = 0;
					int siteCnt = 0;
					int nsiteCnt = 0;
					int esiteCnt = 0;
					siteUnitCnt = rd.get("suCnt") != null ? Integer.valueOf(rd.getStr("suCnt")) : 0;
					siteCnt = rd.get("siteCnt") != null ? rd.getDouble("siteCnt").intValue() : 0;
					nsiteCnt = rd.get("nsiteCnt") != null ? rd.getDouble("nsiteCnt").intValue() : 0;
					esiteCnt = rd.get("esiteCnt") != null ? rd.getDouble("esiteCnt").intValue() : 0;
					Object[] item = new Object[2];
					item[0] = month;
					item[1] = siteUnitCnt;
					suList.add(item);

					Object[] sitem = new Object[2];
					sitem[0] = month;
					sitem[1] = siteCnt;
					sList.add(sitem);

					Object[] nitem = new Object[2];
					nitem[0] = month;
					nitem[1] = nsiteCnt;
					nList.add(nitem);

					Object[] eitem = new Object[2];
					eitem[0] = month;
					eitem[1] = esiteCnt;
					eList.add(eitem);
					goNext = true;
				}
				if (goNext)
					break;
			}
			if (goNext) {
				continue;
			} else {
				Object[] item = new Object[2];
				item[0] = month;
				item[1] = 0;
				suList.add(item);
				sList.add(item);
				nList.add(item);
				eList.add(item);
			}
		}

		retMap.put("suList", suList);
		retMap.put("sList", sList);
		retMap.put("nList", nList);
		retMap.put("eList", eList);

		return retMap;
	}

	/**
	 * 网点商收入盘点统计
	 */
	public List<Record> getSiteCollectionFee(String siteId, Map<String, Object> map) {

		long s1 = System.currentTimeMillis();

		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT se.id, se.name as empName, ");
		/* 增值商品收费 */
		sb.append(" (SELECT SUM(b.real_amount) from crm_goods_siteself_order b ");
		sb.append(" WHERE b.status > 2 AND b.status <= 4 AND b.create_by = se.user_id AND b.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and b.placing_order_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and b.placing_order_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS allCollection , ");
		/* 增值毛利 */
		sb.append(" (SELECT SUM(b.real_amount-g.site_price*b.purchase_num) ");
		sb.append(" FROM crm_goods_siteself_order_goods_detail b  ");
		sb.append(" LEFT JOIN crm_goods_siteself g ON g.id = b.good_id AND g.site_id = '" + siteId + "' ");
		sb.append(" WHERE b.status = 0 AND b.create_by = se.user_id  AND b.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and b.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and b.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS profix , ");
		/* 增值提成 */
		sb.append(" (SELECT SUM(c.sales_commissions) ");
		//sb.append(" FROM crm_goods_siteself_order_goods_detail b  ");
		sb.append(" from crm_goods_siteself_order_deduct_detail c  ");
		sb.append(" WHERE  c.status = 0 AND c.salesman_id=se.user_id AND c.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and c.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and c.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS salesCommissions, ");
		/* 记录总数 */
		sb.append(" (SELECT COUNT(*) FROM crm_order_collections a WHERE a.employe_id=se.id AND a.status='0' AND a.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and  a.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and  a.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS totalCount, ");
		/* 收款总额 */
		sb.append(" (SELECT SUM(payment_amount) FROM crm_order_collections a WHERE a.employe_id=se.id AND a.status='0' AND a.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and  a.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and  a.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS totalFee, ");
		/* 确认到账 */
		sb.append(" (SELECT SUM(payment_amount) FROM crm_order_collections a WHERE a.employe_id=se.id AND a.status='0' AND a.confirm = '1' AND a.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and  a.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and  a.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS sureInPacage ");

		sb.append("  FROM crm_employe AS se WHERE se.site_id='" + siteId + "' AND se.`status`='0' ");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and se.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}

		List<Record> rds0 = Db.find(sb.toString());

		long s2 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee > rds0 time: " + (s2 - s1));


		List<Record> nowRds = getSiteCollectionFee_now(siteId, map);

		long s3 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee > getSiteCollectionFee_now time: " + (s3 - s2));

		List<Record> historyRds = getSiteCollectionFee_history(siteId, map);

		long s4 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee > getSiteCollectionFee_history time: " + (s4 - s3));

		/*Map<String, String> excludeMap = Maps.newHashMap();
		excludeMap.put("allCollection", "1");
		excludeMap.put("profix", "1");
		excludeMap.put("salesCommissions", "1");
		excludeMap.put("totalCount", "1");
		excludeMap.put("totalFee", "1");
		excludeMap.put("sureInPacage", "1");*/
		List<Record> finalRds = ActiveRecordUtil.combineRecords("empName", nowRds, historyRds);
		for(Record rd : finalRds){
			String empId = rd.getStr("id");
			for(Record rd0 : rds0){
				String empId0 = rd0.getStr("id");
				if(empId.equalsIgnoreCase(empId0)){
					rd.setColumns(rd0);
					break;
				}
			}
		}

		long s5 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee > finalRds time: " + (s5 - s4));
		return  finalRds;
	}

	public List<Record> getSiteCollectionFee_now(String siteId, Map<String, Object> map) {
		if (StringUtils.isBlank((String) map.get("statisticDateMin")) && StringUtils.isBlank((String) map.get("statisticDateMax"))) {
			return Lists.newArrayList();
		}
		long s1 = System.currentTimeMillis();

		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT se.id, se.name as empName, ot.orderCount, ot.serverCost, ot.warrantyCost, ot.fitUsedInDate, ot.fitUsedCollection ");

		sb.append("  FROM crm_employe AS se left join ( ");

		sb.append(" select r.emp_id,  COUNT(1) as orderCount, sum(0) as fitUsedInDate, sum(0) as fitUsedCollection, SUM(o.serve_cost) as serverCost, SUM(o.warranty_cost) as warrantyCost ");
		sb.append("  FROM crm_order AS o ");
		sb.append(" INNER JOIN crm_order_dispatch AS d ON d.order_id=o.id AND d.`status`='5' and o.status in ('3', '4', '5') and d.site_id = '" + siteId + "' ");
		sb.append(" INNER JOIN `crm_order_dispatch_employe_rel` AS r ON r.`dispatch_id`=d.id AND r.site_id = '" + siteId + "' ");
		sb.append(" WHERE 1=1  AND o.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" group by r.emp_id ");
		sb.append(" ) as ot on ot.emp_id = se.id ");
		sb.append(" WHERE se.site_id='" + siteId + "' AND se.`status`='0'  ");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and se.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}

		List<Record> rds1 = Db.find(sb.toString());
		long s2 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee_now > step1 time: " + (s2 - s1));

		sb = new StringBuilder("");
		sb.append("SELECT se.id, se.name as empName, ot.orderCount, ot.serverCost, ot.warrantyCost, ot.fitUsedInDate, ot.fitUsedCollection ");

		sb.append("  FROM crm_employe AS se left join ( ");

		sb.append(" SELECT r.emp_id, count(case when 1 != 1 then 1 end) as orderCount, sum(0) as serverCost, sum(0) as warrantyCost, SUM(case when c.collection_flag = '0' then c.used_num else 0 end) as fitUsedInDate,  ");
		sb.append(" sum(case when c.`collection_flag` = '1' then c.collection_money else 0 end) as fitUsedCollection ");
		sb.append(" FROM crm_order AS o ");
		sb.append(" INNER JOIN crm_order_dispatch AS d ON d.order_id=o.id and d.status='5' and o.status in ('3', '4', '5') and d.site_id = '" + siteId + "' ");
		sb.append(" INNER JOIN `crm_order_dispatch_employe_rel` AS r ON r.`dispatch_id`=d.id and r.site_id = '" + siteId + "' ");
		sb.append(" LEFT JOIN crm_site_fitting_used_record c ON o.id=c.order_id AND c.`type`= 1 ");
		sb.append(" WHERE 1=1 AND o.site_id = '" + siteId + "'");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" group by r.emp_id ");

		sb.append(" ) as ot on ot.emp_id = se.id ");
		sb.append(" WHERE se.site_id='" + siteId + "' AND se.`status`='0' ");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and se.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}
		List<Record> rds2 = Db.find(sb.toString());
		long s3 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee_now > step2 time: " + (s3 - s2));

		List<Record> finalRds = ActiveRecordUtil.combineRecords("id", rds1, rds2);
		return finalRds;

	}

	public List<Record> getSiteCollectionFee_history(String siteId, Map<String, Object> map) {
		if (StringUtils.isBlank((String) map.get("statisticDateMin")) && StringUtils.isBlank((String) map.get("statisticDateMax"))) {
			return Lists.newArrayList();
		}
		if(!tableSplitMapper.exists(siteId)){
			return Lists.newArrayList();
		}

		long s1 = System.currentTimeMillis();
		StringBuilder sb = new StringBuilder("");
		sb.append("SELECT se.id, se.name as empName, ot.orderCount, ot.serverCost, ot.warrantyCost, ot.fitUsedInDate, ot.fitUsedCollection ");

		sb.append("  FROM crm_employe AS se left join ( ");

		sb.append(" select r.emp_id,  COUNT(1) as orderCount, sum(0) as fitUsedInDate, sum(0) as fitUsedCollection, SUM(o.serve_cost) as serverCost, SUM(o.warranty_cost) as warrantyCost ");
		sb.append("  FROM "+tableSplitMapper.mapOrder(siteId)+" AS o ");
		sb.append(" INNER JOIN "+tableSplitMapper.mapOrderDispatch(siteId)+" AS d ON d.order_id=o.id AND d.`status`='5' and o.status in ('3', '4', '5') and d.site_id = '" + siteId + "' ");
		sb.append(" INNER JOIN `"+tableSplitMapper.mapOrderDispatchEmployeRel(siteId)+"` AS r ON r.`dispatch_id`=d.id AND r.site_id = '" + siteId + "' ");
		sb.append(" WHERE 1=1  AND o.site_id = '" + siteId + "' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" group by r.emp_id ");
		sb.append(" ) as ot on ot.emp_id = se.id ");
		sb.append(" WHERE se.site_id='" + siteId + "' AND se.`status`='0'  ");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and se.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}

		List<Record> rds1 = Db.find(sb.toString());
		long s2 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee_history > step1 time: " + (s2 - s1));

		sb = new StringBuilder("");
		sb.append("SELECT se.id, se.name as empName, ot.orderCount, ot.serverCost, ot.warrantyCost, ot.fitUsedInDate, ot.fitUsedCollection ");

		sb.append("  FROM crm_employe AS se left join ( ");

		sb.append(" SELECT r.emp_id, count(case when 1 != 1 then 1 end) as orderCount, sum(0) as serverCost, sum(0) as warrantyCost, SUM(case when c.collection_flag = '0' then c.used_num else 0 end) as fitUsedInDate,  ");
		sb.append(" sum(case when c.`collection_flag` = '1' then c.collection_money else 0 end) as fitUsedCollection ");
		sb.append(" FROM "+tableSplitMapper.mapOrder(siteId)+" AS o ");
		sb.append(" INNER JOIN "+tableSplitMapper.mapOrderDispatch(siteId)+" AS d ON d.order_id=o.id and d.status='5' and o.status in ('3', '4', '5') and d.site_id = '" + siteId + "' ");
		sb.append(" INNER JOIN `"+tableSplitMapper.mapOrderDispatchEmployeRel(siteId)+"` AS r ON r.`dispatch_id`=d.id and r.site_id = '" + siteId + "' ");
		sb.append(" LEFT JOIN crm_site_fitting_used_record c ON o.id=c.order_id AND c.`type`= 1 ");
		sb.append(" WHERE 1=1 AND o.site_id = '" + siteId + "'");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" group by r.emp_id ");

		sb.append(" ) as ot on ot.emp_id = se.id ");
		sb.append(" WHERE se.site_id='" + siteId + "' AND se.`status`='0' ");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and se.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}
		List<Record> rds2 = Db.find(sb.toString());
		long s3 = System.currentTimeMillis();
		System.out.println(" >> getSiteCollectionFee_history > step2 time: " + (s3 - s2));

		List<Record> finalRds = ActiveRecordUtil.combineRecords("id", rds1, rds2);
		return finalRds;
	}

	/**
	 * 网点商收入盘点统计(合计)
	 */
	public Record getTotalCount(String siteId, Map<String, Object> map) {
		long s1 = System.currentTimeMillis();

		String empIds = StringUtil.joinInSql(getEmployesId(siteId, map));
		String empUserIds = StringUtil.joinInSql(getEmployesUserId(siteId, map));
		StringBuilder sb = new StringBuilder("");
		sb.append(" select ");
		sb.append(" (SELECT SUM(b.real_amount) from crm_goods_siteself_order b ");
		sb.append(" WHERE b.status > 2 AND b.status <= 4 AND  b.site_id = '" + siteId + "' ");
		sb.append(" and b.`create_by` IN  (" + empUserIds + ") ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and b.placing_order_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and b.placing_order_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS goodsFeeTotal , ");
		/* 增值毛利 */
		sb.append(" (SELECT SUM(b.real_amount-g.site_price*b.purchase_num) ");
		sb.append(" FROM crm_goods_siteself_order_goods_detail b  ");
		sb.append(" LEFT JOIN crm_goods_siteself g ON g.id = b.good_id AND g.site_id = '" + siteId + "' ");
		sb.append(" WHERE b.status = 0 and b.site_id = '" + siteId + "' ");
		sb.append(" and b.`create_by` IN (" + empUserIds + ") ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and b.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and b.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS goodsProfitTotal , ");
		/* 增值提成 */
		sb.append(" (SELECT SUM(c.sales_commissions) ");
		sb.append(" FROM crm_goods_siteself_order a ");
		sb.append(" LEFT JOIN crm_goods_siteself_order_goods_detail b ON a.id=b.site_order_id ");
		sb.append(" LEFT JOIN crm_goods_siteself_order_deduct_detail  c ON b.id=c.`site_order_goods_detail_id` AND c.`site_order_id`=a.id");
		sb.append(" WHERE  c.status = 0  AND c.site_id = '" + siteId + "' ");
		sb.append(" and c.`salesman_id` IN (" + empUserIds + ") ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and a.confirm_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and a.confirm_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS goodsGetPacTotal, ");
		/* 记录总数 */
		sb.append(" (SELECT COUNT(*) FROM crm_order_collections a WHERE  a.status='0' AND a.site_id = '" + siteId + "' ");
		sb.append(" and a.employe_id IN (" + empIds + ") ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and  a.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and  a.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS noMoneys, ");
		/* 收款总额 */
		sb.append(" (SELECT SUM(payment_amount) FROM crm_order_collections a WHERE  a.status='0' AND a.site_id = '" + siteId + "' ");
		sb.append(" and a.employe_id IN (" + empIds + ") ");
		sb.append(" AND a.status='0'");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and  a.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and  a.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS noMoneyTotal, ");
		/* 确认到账 */
		sb.append(" (SELECT SUM(payment_amount) FROM crm_order_collections a WHERE a.site_id = '" + siteId + "' AND a.confirm = '1' ");
		sb.append(" and a.employe_id IN (" + empIds + ") ");
		sb.append(" AND a.confirm='1' ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and  a.create_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and  a.create_time <= '" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" ) AS noMoneySureTotal ");
		Record rd0 = Db.findFirst(sb.toString());//不涉及2017的记录

		long s2 = System.currentTimeMillis();
		System.out.println(" >> siteFeeCollection > getTotalCount time: " + (s2 - s1));

		Record nowRd = getTotalCount_now(siteId, map);

		long s3 = System.currentTimeMillis();
		System.out.println(" >> siteFeeCollection > getTotalCount_now time: " + (s3 - s2));

		Record historyRd = getTotalCount_history(siteId, map);

		long s4 = System.currentTimeMillis();
		System.out.println(" >> siteFeeCollection > getTotalCount_history time: " + (s4 - s3));
		/*Map<String, String> excludeMap = Maps.newHashMap();
		excludeMap.put("goodsFeeTotal", "1");
		excludeMap.put("goodsProfitTotal", "1");
		excludeMap.put("goodsGetPacTotal", "1");
		excludeMap.put("noMoneys", "1");
		excludeMap.put("noMoneyTotal", "1");
		excludeMap.put("noMoneySureTotal", "1");*/
		Record finalRd = ActiveRecordUtil.combineRecord(nowRd, historyRd);
		finalRd.setColumns(rd0);
		return finalRd;
	}

	public Record getTotalCount_now(String siteId, Map<String, Object> map) {
		if (StringUtils.isBlank((String) map.get("statisticDateMin")) && StringUtils.isBlank((String) map.get("statisticDateMax"))) {
			return new Record();
		}

		String empIds = StringUtil.joinInSql(getEmployesId(siteId, map));

		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT COUNT(1) as totalOrders, sum(o.`serve_cost` ) as serverFeeTotal, sum(o.`warranty_cost`) as warrentyFeeTotal FROM crm_order AS o ");
		sb.append(" INNER JOIN crm_order_dispatch AS d ON d.order_id=o.id AND d.`status`='5' and o.status in ('3', '4', '5') and d.site_id = '" + siteId + "' ");
		sb.append(" INNER JOIN `crm_order_dispatch_employe_rel` AS r ON r.`dispatch_id`=d.id AND r.site_id = '" + siteId + "' ");
		sb.append(" WHERE r.`emp_id` IN (" + empIds + ") and o.site_id = '" + siteId + "' ");

		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}

		Record rd1 = Db.findFirst(sb.toString());

		/* 保内备件使用数量 & 保外备件收费 */
		sb = new StringBuilder("");
		sb.append(" SELECT ");
		sb.append(" SUM( ");
		sb.append(" case when p.`collection_flag` = '0' then p.`used_num`  else 0 end ");
		sb.append(" ) as inDateTotal, ");
		sb.append(" SUM( ");
		sb.append(" case when p.`collection_flag` = '1' then p.`collection_money` else 0 end ");
		sb.append(" ) as outDateTotal FROM crm_order AS o ");
		sb.append(" INNER JOIN crm_order_dispatch AS d ON d.order_id=o.id and d.`site_id`  = o.`site_id`  and d.status='5' and o.status in ('3', '4', '5')  and d.site_id = '"+siteId+"' ");
		sb.append(" INNER JOIN `crm_order_dispatch_employe_rel` AS r ON r.`dispatch_id`=d.id   and r.`site_id`  = o.`site_id` ");
		sb.append(" INNER JOIN crm_site_fitting_used_record AS p ON p.order_id=o.id AND p.`type`= 1 ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" WHERE 1=1 ");
		sb.append(" and o.site_id = '"+siteId+"' ");
		sb.append(" and r.`emp_id` IN ("+empIds+") ");

		Record rd2 = Db.findFirst(sb.toString());
		rd1.setColumns(rd2);
		return rd1;
		//return Db.findFirst(sb.toString());
	}

	public Record getTotalCount_history(String siteId, Map<String, Object> map) {
		if(!tableSplitMapper.exists(siteId)){
			return new Record();
		}
		if (StringUtils.isBlank((String) map.get("statisticDateMin")) && StringUtils.isBlank((String) map.get("statisticDateMax"))) {
			return new Record();
		}
		String empIds = StringUtil.joinInSql(getEmployesId(siteId, map));
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT COUNT(1) as totalOrders, sum(o.`serve_cost` ) as serverFeeTotal, sum(o.`warranty_cost`) as warrentyFeeTotal FROM "+tableSplitMapper.mapOrder(siteId)+" AS o ");
		sb.append(" INNER JOIN "+tableSplitMapper.mapOrderDispatch(siteId)+" AS d ON d.order_id=o.id AND d.`status`='5' and o.status in ('3', '4', '5') and d.site_id = '" + siteId + "' ");
		sb.append(" INNER JOIN `"+tableSplitMapper.mapOrderDispatchEmployeRel(siteId)+"` AS r ON r.`dispatch_id`=d.id AND r.site_id = '" + siteId + "' ");
		sb.append(" WHERE r.`emp_id` IN (" + empIds + ") and o.site_id = '" + siteId + "' ");

		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}

		Record rd1 = Db.findFirst(sb.toString());

		/* 保内备件使用数量 & 保外备件收费 */
		sb = new StringBuilder("");
		sb.append(" SELECT ");
		sb.append(" SUM( ");
		sb.append(" case when p.`collection_flag` = '0' then p.`used_num`  else 0 end ");
		sb.append(" ) as inDateTotal, ");
		sb.append(" SUM( ");
		sb.append(" case when p.`collection_flag` = '1' then p.`collection_money` else 0 end ");
		sb.append(" ) as outDateTotal FROM "+tableSplitMapper.mapOrder(siteId)+" AS o ");
		sb.append(" INNER JOIN "+tableSplitMapper.mapOrderDispatch(siteId)+" AS d ON d.order_id=o.id and d.`site_id`  = o.`site_id`  and d.status='5' and o.status in ('3', '4', '5')  and d.site_id = '"+siteId+"' ");
		sb.append(" INNER JOIN `"+tableSplitMapper.mapOrderDispatchEmployeRel(siteId)+"` AS r ON r.`dispatch_id`=d.id   and r.`site_id`  = o.`site_id` ");
		sb.append(" INNER JOIN crm_site_fitting_used_record AS p ON p.order_id=o.id AND p.`type`= 1 ");
		if (StringUtils.isNotBlank((String) map.get("statisticDateMin"))) {
			sb.append(" and d.end_time >= '" + map.get("statisticDateMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((String) map.get("statisticDateMax"))) {
			sb.append(" and d.end_time <='" + map.get("statisticDateMax") + " 23:59:59' ");
		}
		sb.append(" WHERE 1=1 ");
		sb.append(" and o.site_id = '"+siteId+"' ");
		sb.append(" and r.`emp_id` IN ("+empIds+") ");

		Record rd2 = Db.findFirst(sb.toString());
		rd1.setColumns(rd2);
		return rd1;
	}

	public String[] getEmployesId(String siteId, Map<String, Object> map) {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT id FROM crm_employe AS e WHERE e.site_id='" + siteId + "' AND e.`status`='0'");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and e.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}
		List<Record> reList = Db.find(sb.toString());
		String[] emps = new String[reList.size()];
		for (int i = 0; i < reList.size(); i++) {
			Record re = reList.get(i);
			emps[i] = re.getStr("id");
		}
		return emps;
	}

	public String[] getEmployesUserId(String siteId, Map<String, Object> map) {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT user_id FROM crm_employe AS e WHERE e.site_id='" + siteId + "' AND e.`status`='0'");
		if (StringUtils.isNotBlank((CharSequence) map.get("empIds"))) {
			sb.append(" and e.id in (" + StringUtil.joinInSql(map.get("empIds").toString().split(",")) + ") ");
		}
		List<Record> reList = Db.find(sb.toString());
		String[] emps = new String[reList.size()];
		for (int i = 0; i < reList.size(); i++) {
			Record re = reList.get(i);
			emps[i] = re.getStr("user_id");
		}
		return emps;
	}
	/*思方商城新建工单
	*/

	@Transactional(rollbackFor = Exception.class)
	public Result<Void> saveOrder(String siteId, List<Record> rds,String orderId) {
		User user = UserUtils.getUser();
		Site site = siteDao.get(siteId);
		Result<Void> re = new Result<>();
		try {
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
			for(Record rd : rds) {
				String is_new_order = rd.getStr("is_new_order");
				if("1".equals(is_new_order)) {
					//已经新建过
					re.setCode("205");
					return re;
				}
				Order order = new Order();
				order.setStatus("1");
				order.setOrderType(rd.getStr("order_type"));// 工单来源
				order.setRepairTime(new Date());// 报修时间
				order.setCreateBy(user.getId());// 创建人
				order.setApplianceBrand(rd.getStr("good_brand"));// 家电品牌
				order.setApplianceCategory(rd.getStr("good_category2"));// 家电品类
				order.setApplianceModel(rd.getStr("good_model"));// 家电型号
				order.setApplianceBuyTime(DateUtils.parseDate(rd.getStr("create_time")));// 家电购机时间
				order.setApplianceNum(rd.getDouble("purchase_num").intValue());// 家电数量
				
				order.setCustomerName(rd.getStr("customer_name"));// 用户姓名
				order.setProvince(rd.getStr("province"));// 省
				order.setCity(rd.getStr("city"));// 市
				order.setArea(rd.getStr("area"));// 区县
				order.setCustomerAddress(rd.getStr("customer_address"));// 用户地址
				String mobiles = rd.getStr("customer_contact");
				order.setCustomerMobile(mobiles);// 用户联系方式
				order.setCustomerFeedback("订单安装单");// 用户反馈TradeNoUtils.genOrderNo("V")
				order.setRemarks("订单编号："+rd.getStr("number")+rd.getStr("remarks") != null ? rd.getStr("remarks"):"");// 备注
				order.setOrigin("商城新建");// 信息来源
				order.setServiceType("安装");// 服务类型
				order.setSiteId(siteId);// 网点Id
				order.setSiteName(site.getName());// 网点名称
				order.setMessengerId(msgId);// 信息员Id
				order.setMessengerName(name);// 信息员名称
				order.setNumber(RandomUtil.randomOrderNumber());
				order.setRecordAccount("0");// 未录单
				String code = siteMsgService.ifOpenOrderSet(siteId);
				if ("200".equals(code)) {
					OrderNo odn = CrmUtils.genOrderNo(siteId);
					if (odn != null) {
						order.setNumber(odn.getData());
						order.setSeq(odn.getSeq());
					}
				}
				order.setLatestProcessTime(new Date());
				order.setLatestProcess(name + "思方商城新建工单");// 最新过程信息
				Target ta = new Target();
				ta.setType(Target.NEW_ORDER);// 转自接工单
				ta.setName(name);
				ta.setContent(name + "思方商城新建工单;订单编号："+rd.getStr("number"));
				ta.setTime(DateToStringUtils.DateToString());
				order.setProcessDetail(WebPageFunUtils.appendProcessDetail(ta, ""));// 过程信息
				orderDao.save(order);
			}
			String url = Global.getConfig("sended.marketing.interface.url")+"/upIsNewOrder";
			Map<String, String> params = Maps.newHashMap();
			params.put("orderId", orderId);
			System.out.println(url);
			String retStr = HttpUtils.doPost(url, params);
			Map<String,String> map =  new Gson().fromJson(retStr, new TypeToken<Map<String,String>>(){}.getType());
			if(map.get("code").equals("200")) {
				return Result.ok();
			}else {
				re.setCode(map.get("code"));
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			logger.error("update too many trader order 新建安装单失败, refused ids:" + orderId + ";" + e.getMessage());
			re.setCode("203");
		}
		return re;
	}

	
}
