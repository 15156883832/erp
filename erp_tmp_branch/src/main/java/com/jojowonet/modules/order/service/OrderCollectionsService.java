package com.jojowonet.modules.order.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.OrderCollectionsDao;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

/**
 * 二维码收款Service
 * 
 * @author Ivan
 * @version 2017-05-04
 */
@Component
@Transactional(readOnly = true)
public class OrderCollectionsService extends BaseService {

	@Autowired
	private OrderCollectionsDao orderCollectionsDao;
	@Autowired
	private OrderService orderService;

	public Page<Record> orderCollectionsList(Page<Record> page, String siteId, Map<String, Object> map) {
		List<Record> list = orderCollectionsDao.orderCollectionsList(page, siteId, map);
		Long count = orderCollectionsDao.queryCount(siteId, map);

		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Record> employeList(String siteId) {
		return Db.find("select * from crm_employe a where a.status='0' and a.site_id='" + siteId + "'");
	}

	public BigDecimal orderCollectionsSumamount(String siteId, Map<String, Object> map) {
		BigDecimal sum = orderCollectionsDao.orderCollectionsSumamount(siteId, map);
		return sum;
	}

	public BigDecimal commissionSumanount(String siteId, Map<String, Object> map) {
		BigDecimal sum = orderCollectionsDao.commissionSumanount(siteId, map);
		return sum;
	}

	public Record getDetailbyid(String id) {
		return orderCollectionsDao.getDetailbyid(id);
	}

	public String confirmdz(String id) {
		String result = "";
		int i = orderCollectionsDao.confirmdz(id);
		if (i > 0) {
			result = "ok";
		}
		return result;
	}

	public String saveCommission(String id, String commissionMoney, String marks) {
		String result = "";
		if (StringUtil.isEmpty(commissionMoney)) {
			commissionMoney = "0";
		}
		// BigDecimal bd=new BigDecimal(commissionMoney);
		int i = orderCollectionsDao.saveCommission(id, commissionMoney, marks);
		if (i > 0) {
			result = "ok";
		}
		return result;
	}

	public Double getOrderByIdConfirmMoney(String orderId, String siteId) {
		Record rd = orderService.findOrderById(orderId, siteId);
		BigDecimal all = new BigDecimal(0);
		if (rd != null) {
			all = rd.getBigDecimal("serve_cost").add(rd.getBigDecimal("auxiliary_cost")).add(rd.getBigDecimal("warranty_cost"));
		}
		return all != null ? all.doubleValue() : 0;
	}

	public Double getOrderByNumberConfirmMoney(String orderNumber, String siteId) {
		Record rd = orderService.findOrderByNumberIfHistory(orderNumber, siteId);
		BigDecimal all = new BigDecimal(0);
		if (rd != null) {
			all = rd.getBigDecimal("serve_cost").add(rd.getBigDecimal("auxiliary_cost")).add(rd.getBigDecimal("warranty_cost"));
		}
		return all != null ? all.doubleValue() : 0;
	}

	@Transactional(rollbackFor = Exception.class)
	public String saveMarks(String id, String marks) {
		SQLQuery sqlQuery = orderCollectionsDao.getSession().createSQLQuery("update crm_order_collections a set a.marks=:marks where a.id=:ids");
		sqlQuery.setParameter("marks", marks);
		sqlQuery.setParameter("ids", id);
		sqlQuery.executeUpdate();
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public String confirmEditMoney(String id, String tpaymentAmount) {
		Record rd = Db.findFirst("select a.* from crm_order_collections a where  a.id=? and a.status='0' limit 1 ", id);
		if (rd == null) {
			return "450";// 不存在
		}
		Double nes = Double.valueOf(tpaymentAmount);
		if ("1".equals(rd.getStr("confirm"))) {// 如果已确认到账，则收款金额不能修改
			Double old = rd.getBigDecimal("payment_amount").doubleValue();
			if (old != nes) {// 前后金额不一致，则不允许执行操作
				return "451";// 不存在
			}
		}
		if ("0".equals(rd.getStr("confirm"))) {// 尚未确认到账
			String source = rd.getStr("source");
			if ("0".equals(source)) {// 工单收款
				Record rdMny = Db.findFirst(
						"SELECT SUM(tt.payment_amount) as countMny FROM ((SELECT a.payment_amount FROM crm_order_collections a WHERE a.status='0' and a.id!=? AND a.order_id=?) AS tt) ",
						id, rd.getStr("order_id"));
				BigDecimal mny = rdMny.getBigDecimal("countMny") != null ? rdMny.getBigDecimal("countMny") : new BigDecimal("0");
				Double countMny = (mny != null ? mny.doubleValue() : 0) + nes;// 该工单的二维码收款总额
				Double orderMny = getOrderByIdConfirmMoney(rd.getStr("order_id"), rd.getStr("site_id"));// 工单的收款总额
				if (orderMny < countMny) {
					return "460";// 收款金额不得大于工单的收款总额
				}
			}
			if ("1".equals(source)) {// 商品订单收款
				Record rdGoods = Db.findFirst("select a.* from crm_goods_siteself_order a where a.id=? limit 1", rd.getStr("order_id"));
				BigDecimal mny = rdGoods != null ? rdGoods.getBigDecimal("real_amount") : new BigDecimal("0");// 商品订单的成交总额
				Double orderMny = Double.valueOf(mny != null ? mny.toString() : "0");// 该商品订单的二维码收款总额
				if (orderMny < nes) {// 商品一个订单只有一次无现金收款
					return "461";// 收款金额不得大于商品订单的成交总额
				}
			}
			if ("3".equals(source)) {// 备件零售收款
				String orderNumber = rd.getStr("order_number");
				if (StringUtils.isNotBlank(orderNumber)) {// 关联工单收款
					Record rdMny = Db.findFirst(
							"SELECT SUM(tt.payment_amount) as countMny FROM ((SELECT a.payment_amount FROM crm_order_collections a WHERE a.status='0' and a.id!=? and a.site_id=? AND a.order_number=?) AS tt) ",
							id, rd.getStr("site_id"), rd.getStr("order_number"));
					BigDecimal mny = rdMny.getBigDecimal("countMny") != null ? rdMny.getBigDecimal("countMny") : new BigDecimal("0");
					Double countMny = (mny != null ? mny.doubleValue() : 0) + nes;// 该工单的二维码收款总额
					Double orderMny = getOrderByNumberConfirmMoney(orderNumber, rd.getStr("site_id"));// 工单的收款总额
					if (orderMny < countMny) {
						return "462";// 收款金额不得大于工单的收款总额
					}
				}
			}

		}
		SQLQuery sqlQuery = orderCollectionsDao.getSession().createSQLQuery("update crm_order_collections a set a.payment_amount=:paymentAmount where a.id=:ids");
		sqlQuery.setParameter("ids", id);
		sqlQuery.setParameter("paymentAmount", tpaymentAmount);
		sqlQuery.executeUpdate();
		return "200";
	}
}
