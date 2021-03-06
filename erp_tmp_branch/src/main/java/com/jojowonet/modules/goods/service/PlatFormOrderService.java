package com.jojowonet.modules.goods.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.PlatFormOrderDao;
import com.jojowonet.modules.goods.entity.GoodsPlatformOrder;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class PlatFormOrderService extends BaseService {
	@Autowired
	private PlatFormOrderDao platFormOrderDao;

	public Page<Record> platformOrderList(Page<Record> page, String siteId, Map<String, Object> map) {
		if (map.get("pageSize") != null) {
			if (StringUtils.isNotBlank(map.get("pageSize").toString())) {
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = platFormOrderDao.platformOrderList(page, siteId, map);
		for (Record rd : list) {
			rd.set("firstIcon", "");
			if (StringUtils.isNotBlank(rd.getStr("good_icon"))) {
				rd.set("firstIcon", rd.getStr("good_icon").split(",")[0]);// 商品列表显示图片
			}
		}
		Long count = platFormOrderDao.queryCount(siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> platformOrderListMjl(Page<Record> page, String siteId, Map<String, Object> map) {
		if (map.get("pageSize") != null) {
			if (StringUtils.isNotBlank(map.get("pageSize").toString())) {
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = platFormOrderDao.platformOrderListMjl(page, siteId, map);
		for (Record rd : list) {
			rd.set("firstIcon", "");
			if (StringUtils.isNotBlank(rd.getStr("good_icon"))) {
				rd.set("firstIcon", rd.getStr("good_icon").split(",")[0]);// 商品列表显示图片
			}
			// 出库方式
			String status = rd.getStr("status");
			String outstockType = rd.getStr("outstock_type");
			BigDecimal stocks = rd.getBigDecimal("stocks");
			BigDecimal purchaseNum = rd.getBigDecimal("purchase_num");
			if ("0".equals(status) || "1".equals(status) || "2".equals(status)) {

			}
			if ("3".equals(status)) {

			}
		}
		Long count = platFormOrderDao.queryCountMjl(siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> msgGrid(Page<Record> page, Map<String, Object> map) {// 完成短信销售列表
		List<Record> list = platFormOrderDao.msgGrid(page, map);
		Long count = platFormOrderDao.queryCount2(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> msgGriderror(Page<Record> page, Map<String, Object> map) {// 未完成短信销售列表
		List<Record> list = platFormOrderDao.msgGriderror(page, map);
		Long count = platFormOrderDao.queryCounterror2(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> bombScreenGrid(Page<Record> page, Map<String, Object> map) {
		List<Record> list = platFormOrderDao.bombScreenGrid(page, map);
		Long count = platFormOrderDao.queryCount3(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> sysOrderList(Page<Record> page, Map<String, Object> map) {
		List<Record> list = platFormOrderDao.qrCodeOrderList(page, map);
		Long count = platFormOrderDao.queryCount4(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> qrCodeOrderList(Page<Record> page, Map<String, Object> map) {
		List<Record> list = platFormOrderDao.qrCodeOrderList(page, map);
		Long count = platFormOrderDao.queryCount4(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Result<GoodsPlatformOrder> ljfk(String rowId, String siteId, String gId, Double pNum, String tradeNo, String xdCustomerName, String xdCustomerContact,
			String xdCustomerAddress) {// 工程师已出库待确定付款
		return platFormOrderDao.ljfk(rowId, siteId, gId, pNum, tradeNo, xdCustomerName, xdCustomerContact, xdCustomerAddress);
	}

	public void doPLS(Map<String, Object> map) {
		Record pre = Db.findFirst("select gp.id as pid,gs.* from crm_goods_platform gp left join crm_goods_siteself gs on gs.number=gp.number");
		String pNumber = CrmUtils.Spno();// 订单编号

		Date date = new Date();
		String number = "PO" + DateUtils.formatDate(date, "yyMMddHHmmssSS");

		GoodsPlatformOrder gpf = new GoodsPlatformOrder();
		gpf.setNumber(number);// 订单编号
		gpf.setGoodId(pre.getStr("pid"));
		gpf.setGoodName(pre.getStr("name"));
		gpf.setGoodNumber(pre.getStr("number"));
		gpf.setGoodIcon(pre.getStr("icon"));
		gpf.setGoodBrand(pre.getStr("brand"));
		gpf.setGoodModel(pre.getStr("model"));
		gpf.setGoodCategory(pre.getStr("category"));
		gpf.setCustomerName(map.get("userName").toString());
		gpf.setCustomerContact(map.get("mobile").toString());
		gpf.setCustomerAddress(map.get("address").toString());
		gpf.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(map.get("lsNum").toString())));
		gpf.setGoodAmount(BigDecimal.valueOf(Double.valueOf(map.get("lsPrice").toString())));
		gpf.setPlacingOrderBy(map.get("xiaoName").toString());// 下单人
		gpf.setPlacingOrderTime(new Date());
		// 关联的服务商商品 订单信息表主键id
		// 付款人user_id
		// 付款时间
		gpf.setPayStatus("0"); // 支付状态(0待支付 1已支付 2支付取消)
		gpf.setStatus("0"); // 订单状态（0已下单 1待确认 2待发货 3已发货 4已完成 5已取消）
		// 付款方式
		// 交易记录号
		gpf.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		gpf.setCreator(map.get("userName").toString());// 订单创建人姓名
		gpf.setSupplierId(pre.getStr("supplier_id"));
		;// 供应商姓名
		platFormOrderDao.save(gpf);
	}

	public Page<Record> platOrderGrid(Page<Record> page, Map<String, Object> map) {
		User user = UserUtils.getUser();
		Long count = 0l;
		List<Record> list = Lists.newArrayList();
		if ("7".equals(UserUtils.getUser().getUserType())) {
			String supplierId = user.getId();
			count = platFormOrderDao.querySupplierCount(map, supplierId);
			if (count > 0) {
				list = platFormOrderDao.platSupplierOrderGrid(page, map, supplierId);
			}
		} else {
			list = platFormOrderDao.platOrderGrid(page, map);
			count = platFormOrderDao.querySysCount(map);
		}
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Record detailSysMsg(String rowId) {
		return platFormOrderDao.detailSysMsg(rowId);
	}

	public List<Record> supplierPlatgoodsList(String goodId) {
		return platFormOrderDao.supplierPlatgoodsList(goodId);
	}

	public List<Record> orderFenpei() {
		return platFormOrderDao.orderFenpei();
	}

	public Boolean confirmFenpei(String rowId, String supplierId) {
		return platFormOrderDao.confirmFenpei(rowId, supplierId);
	}

	public Record detailBombScreen(String rowId, String siteId) {
		return platFormOrderDao.detailBombScreen(rowId, siteId);
	}

	public List<Record> detailBombScreen1(String siteId) {
		return platFormOrderDao.detailBombScreen1(siteId);
	}

	public Boolean confirmSendGood(String rowId, String logisticsName, String logisticsNo, String[] serialNoVals, String siteId) {
		return platFormOrderDao.confirmSendGood(rowId, logisticsName, logisticsNo, serialNoVals, siteId);
	}

	/*
	 * 供应商权限
	 */
	public Page<Record> orderManageGrid(Page<Record> page, Map<String, Object> map, String supplierId) {
		List<Record> goodslist = platFormOrderDao.getGoodsList(supplierId);
		List<String> goodsstrlist = new ArrayList<String>();
		for (Record rd : goodslist) {
			goodsstrlist.add(rd.getStr("good_platform_id"));
		}
		List<Record> list = platFormOrderDao.orderManageGrid(page, map, supplierId, goodsstrlist);

		Long count = platFormOrderDao.querySysCount2(map, supplierId, goodsstrlist);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Boolean confirmSendGoods(String rowId, String logisticsName, String logisticsNo, String sendgoodDate) {
		return platFormOrderDao.confirmSendGoods(rowId, logisticsName, logisticsNo, sendgoodDate);
	}

	public Boolean confirmEnd(String rowId) {
		return platFormOrderDao.confirmEnd(rowId);
	}

	@Transactional
	public Object saveMsg(String goId, String xdCustomerName, String xdCustomerContact, String xdCustomerAddress) {
		Result rt = new Result();
		Record rd = Db.findFirst("select a.* from crm_goods_siteself_order a where a.id=?", goId);
		if (rd == null) {// 订单信息不存在
			rt.setCode("421");
			rt.setErrMsg("goods Order not exist");
			return rt;
		}
		SQLQuery sqlQuery = platFormOrderDao.getSession()
				.createSQLQuery("update crm_goods_siteself_order a set a.customer_name=:cname,a.customer_contact=:ccontact,a.customer_address=:caddress where a.id=:goId");
		sqlQuery.setParameter("cname", xdCustomerName);
		sqlQuery.setParameter("ccontact", xdCustomerContact);
		sqlQuery.setParameter("caddress", xdCustomerAddress);
		sqlQuery.setParameter("goId", goId);
		sqlQuery.executeUpdate();
		rt.setCode("200");
		rt.setMsg("save success");
		return rt;
	}

	public Long getSupplyRel(String supplierId) {
		return Db.queryLong(
				"select count(*) from crm_goods_platform_supplier_rel a left join crm_goods_platform p on p.id=a.good_platform_id where a.supplier_id=? and p.brand like '%美洁力%' and p.status='0' ",
				supplierId);
	}

	public Page<Record> vipOrderList(Page<Record> page, Map<String, Object> map) {
		List<Record> list = platFormOrderDao.vipOrderList(page, map);
		Long count = platFormOrderDao.queryVipOrderCount(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> nopayvipOrderList(Page<Record> page, Map<String, Object> map) {
		List<Record> list = platFormOrderDao.nopayvipOrderList(page, map);
		Long count = platFormOrderDao.querynopayVipOrderCount(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public GoodsPlatformOrder get(String id) {
		return platFormOrderDao.get(id);
	}

	public void save(GoodsPlatformOrder order) {
		platFormOrderDao.save(order);
	}
}
