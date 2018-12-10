package com.jojowonet.modules.goods.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jojowonet.modules.order.utils.*;
import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.goods.dao.GoodsEmployeOwnDao;
import com.jojowonet.modules.goods.dao.GoodsEmployeOwnDetailDao;
import com.jojowonet.modules.goods.dao.GoodsSiteSelfOrderDeductDetailDao;
import com.jojowonet.modules.goods.dao.GoodsSiteselfDetailDao;
import com.jojowonet.modules.goods.dao.GoodsSiteselfProfitDetailDao;
import com.jojowonet.modules.goods.dao.SiteselfOrderDao;
import com.jojowonet.modules.goods.dao.SiteselfOrderGoodsDetailDao;
import com.jojowonet.modules.goods.entity.GoodsEmployeOwn;
import com.jojowonet.modules.goods.entity.GoodsEmployeOwnDetail;
import com.jojowonet.modules.goods.entity.GoodsSiteSelfOrderDeductDetail;
import com.jojowonet.modules.goods.entity.GoodsSiteselfDetail;
import com.jojowonet.modules.goods.entity.GoodsSiteselfOrder;
import com.jojowonet.modules.goods.entity.GoodsSiteselfProfitDetail;
import com.jojowonet.modules.goods.entity.SiteselfOrderGoodsDetail;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.sys.dao.UserDao;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class SiteselfOrderService extends BaseService {
	private static final Logger logger = Logger.getLogger(SiteselfOrderService.class);
	@Autowired
	private SiteselfOrderDao siteselfOrderDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private GoodsSiteselfDetailDao goodsSiteselfDetailDao;
	@Autowired
	private SiteService siteService;
	@Autowired
	private NonServicemanService nonService;
	@Autowired
	private GoodsSiteSelfOrderDeductDetailDao goodsSiteSelfOrderDeductDetailDao;
	@Autowired
	private SiteselfOrderGoodsDetailDao siteselfOrderGoodsDetailDao;
	@Autowired
	private GoodsEmployeOwnDetailDao goodsEmployeOwnDetailDao;
	@Autowired
	private GoodsEmployeOwnDao goodsEmployeOwnDao;
	@Autowired
	TableSplitMapper tableSplitMapper;

	@Autowired
	private GoodsSiteselfProfitDetailDao goodsSiteselfProfitDetailDao;

	public Page<Record> siteselfOrderList(Page<Record> page, String siteId, Map<String, Object> map, String orderType) {// 服务商权限 订单信息 列表
		if (map.get("pageSize") != null) {
			if (StringUtils.isNotBlank(map.get("pageSize").toString())) {
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = siteselfOrderDao.getSiteSelfGoodsOrderList(page, siteId, map, orderType);
		for (Record rd : list) {
			StringBuilder sf = new StringBuilder();
			sf.append("select a.* from crm_goods_siteself_order_goods_detail a where a.status='0' and a.site_id=? and a.site_order_id=?  ");
			if (map != null) {
				if (StringUtils.isNotEmpty((CharSequence) map.get("goodName"))) {
					String goodsName = map.get("goodName").toString().trim();
					sf.append(" and a.good_name like '%" + goodsName + "%' ");
				}
			}
			List<Record> list2 = Db.find(sf.toString(), siteId, rd.getStr("id"));
			rd.set("firstIcon", "");
			for (Record rd1 : list2) {
				if (StringUtils.isNotBlank(rd1.getStr("good_icon"))) {
					rd1.set("firstIcon", rd1.getStr("good_icon").split(",")[0]);// 商品列表显示图片
				}
			}
			rd.set("detailList", list2);
		}
		Long count = siteselfOrderDao.getSiteSelfGoodsOrderCount(siteId, map, orderType);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	
	public Page<Record> ExportgoodsOrder(Page<Record> page, String siteId, Map<String, Object> map, String orderType){
		List<Record> list = siteselfOrderDao.getSiteSelfGoodsOrderList(page, siteId, map, orderType);
		page.setList(list);
		return page;
	}
	
	public List<Record> getGoodsOrdersDet(String siteId, Map<String, Object> map){
		StringBuilder sf = new StringBuilder();
		sf.append("select a.* from crm_goods_siteself_order_goods_detail a where a.status='0' and a.site_id=?   ");
		if (map != null) {
			if (StringUtils.isNotEmpty((CharSequence) map.get("goodName"))) {
				String goodsName = map.get("goodName").toString().trim();
				sf.append(" and a.good_name like '%" + goodsName + "%' ");
			}
		}
		List<Record> list2 = Db.find(sf.toString(), siteId );
	return list2;
	}
	
	

	public Page<Record> siteselfOrderListHaoze(Page<Record> page, String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表
		if (map.get("pageSize") != null) {
			if (StringUtils.isNotBlank(map.get("pageSize").toString())) {
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = siteselfOrderDao.getSiteSelfGoodsOrderHaozeList(page, siteId, map);
		for (Record rd : list) {
			StringBuilder sf = new StringBuilder();
			sf.append("select a.* from crm_goods_siteself_order_goods_detail a where a.status='0' and a.site_id=? and a.site_order_id=? ");
			if (map != null) {
				if (StringUtils.isNotEmpty((CharSequence) map.get("goodName"))) {
					String goodsName = map.get("goodName").toString().trim();
					sf.append(" and a.good_name like '%" + goodsName + "%' ");
				}
			}
			List<Record> list2 = Db.find(sf.toString(), siteId, rd.getStr("id"));
			rd.set("firstIcon", "");
			for (Record rd1 : list2) {
				if (StringUtils.isNotBlank(rd1.getStr("good_icon"))) {
					rd.set("firstIcon", rd1.getStr("good_icon").split(",")[0]);// 商品列表显示图片
				}
			}
			rd.set("detailList", list2);
		}
		Long count = siteselfOrderDao.getSiteSelfGoodsOrderHaozeCount(siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Record> siteselfOrderList(String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表
		return siteselfOrderListExcel(null, siteId, map);
	}

	public List<Record> categoryType(String siteId) {// 网点商品类别
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("SELECT * FROM crm_goods_category WHERE status='0' AND site_id='" + siteId + "' order by sort ");
		return Db.find(stringBuilder.toString());
	}

	public List<Record> categoryType1() {// 平台合作商品类别
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("SELECT a.* FROM crm_goods_category a WHERE a.site_id IS NULL AND a.status='0'  ");
		return Db.find(stringBuilder.toString());
	}

	public List<Record> categoryType2() {// 短信类别
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("SELECT a.* FROM crm_goods_category a WHERE a.site_id IS NULL AND a.status='0' AND a.name like '%短信%'  ");
		return Db.find(stringBuilder.toString());
	}

	public List<Record> categoryType3() {// 来电弹屏类别
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("SELECT a.* FROM crm_goods_category a WHERE a.site_id IS NULL AND a.status='0' AND a.name like '%来电弹屏%'  ");
		return Db.find(stringBuilder.toString());
	}

	public List<Record> siteselfOrderList1(Page<Record> page, String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表具体查询
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append(
				"SELECT oc.id as ocId,oc.imgs as ocImgs,DATE_FORMAT(a.placing_order_time,'%Y-%m-%d %H:%i:%s') as xiadanTime,DATE_FORMAT(a.confirm_time,'%Y-%m-%d %H:%i:%s') as confirmTime,a.*,b.stocks,b.unit,s.name as siteName FROM crm_goods_siteself_order a left join crm_goods_siteself b on a.good_id=b.id left join crm_site s on a.site_id=s.id LEFT JOIN crm_order_collections oc ON oc.order_id=a.id AND oc.status='0' AND oc.source='1'  WHERE a.outstock_type!='3' and a.good_brand!='浩泽'  and a.site_id='"
						+ siteId + "'");
		stringBuilder.append(siteselfOrderSql(map));
		stringBuilder.append(" order by a.placing_order_time desc");
		if (page != null) {
			stringBuilder.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(stringBuilder.toString());
	}

	public List<Record> employeBuyBySelfOrderList(Page<Record> page, String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表具体查询
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append(
				"SELECT oc.id as ocId,oc.imgs as ocImgs,DATE_FORMAT(a.placing_order_time,'%Y-%m-%d %H:%i:%s') as xiadanTime,DATE_FORMAT(a.confirm_time,'%Y-%m-%d %H:%i:%s') as confirmTime,a.*,b.stocks,b.unit,s.name as siteName FROM crm_goods_siteself_order a left join crm_goods_siteself b on a.good_id=b.id left join crm_site s on a.site_id=s.id LEFT JOIN crm_order_collections oc ON oc.order_id=a.id AND oc.status='0' AND oc.source='1'  WHERE a.outstock_type='3'  and a.site_id='"
						+ siteId + "'");
		stringBuilder.append(siteselfOrderSqlZg(map));
		stringBuilder.append(" order by a.placing_order_time desc");
		if (page != null) {
			stringBuilder.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(stringBuilder.toString());
	}

	public List<Record> siteselfOrderListExcel(Page<Record> page, String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表具体查询
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("SELECT a.* FROM crm_goods_siteself_order a  WHERE  a.good_brand!='浩泽' AND a.site_id='" + siteId + "'");
		stringBuilder.append(siteselfOrderSql(map));
		stringBuilder.append(" order by a.placing_order_time desc");
		if (page != null) {
			stringBuilder.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(stringBuilder.toString());
	}

	public String siteselfOrderSql(Map<String, Object> map) {// 查询条件
		StringBuilder stringBuilder = new StringBuilder();
		if (StringUtils.isNotEmpty((CharSequence) map.get("number"))) {
			String numb = map.get("number").toString().trim();
			stringBuilder.append(" and a.number like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("customerName"))) {
			String numb = map.get("customerName").toString().trim();
			stringBuilder.append(" and a.customer_name like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("customerMobile"))) {
			String numb = map.get("customerMobile").toString().trim();
			stringBuilder.append(" and a.customer_contact like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("status"))) {
			String st = map.get("status").toString().trim();
			if (st.equals("1z")) {
				stringBuilder.append(" and (a.status in ('1','4'))");
			} else if (st.equals("2z")) {
				stringBuilder.append(" and a.status in ('2','3') ");
			} else if (st.equals("0z")) {
				stringBuilder.append(" and a.status = '0' ");
			}
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("placingOrderBy"))) {
			String numb = map.get("placingOrderBy").toString().trim();
			stringBuilder.append(" and a.creator like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("goodName"))) {
			String numb = map.get("goodName").toString().trim();
			stringBuilder.append(" and a.good_name like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("goodCategory"))) {
			String numb = map.get("goodCategory").toString().trim();
			stringBuilder.append(" and a.good_category = '" + numb + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("xiaoNames"))) {
			String[] xiaoNames = ((map.get("xiaoNames").toString())).split(",");
			if (xiaoNames.length > 0) {
				stringBuilder.append("and (a.placing_name like " + StringUtil.joinInSqlforselforder(xiaoNames) + ")");
			}
		}
		if (StringUtil.checkParamsValid(map.get("placingOrderTimeMin"))) {
			String placingOrderTimeMin = map.get("placingOrderTimeMin").toString().trim();
			stringBuilder.append(" and a.placing_order_time >= '" + placingOrderTimeMin + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("placingOrderTimeMax"))) {
			String placingOrderTimeMax = map.get("placingOrderTimeMax").toString().trim();
			stringBuilder.append(" and a.placing_order_time <= '" + placingOrderTimeMax + " 23:59:59' ");
		}
		if (StringUtil.checkParamsValid(map.get("confirmTimeMin"))) {
			String confirmTimeMin = map.get("confirmTimeMin").toString().trim();
			stringBuilder.append(" and a.confirm_time >= '" + confirmTimeMin + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("confirmTimeMax"))) {
			String confirmTimeMax = map.get("confirmTimeMax").toString().trim();
			stringBuilder.append(" and a.confirm_time <= '" + confirmTimeMax + " 23:59:59' ");
		}
		return stringBuilder.toString();
	}

	public String siteselfOrderSqlZg(Map<String, Object> map) {// 查询条件
		StringBuilder stringBuilder = new StringBuilder();
		if (StringUtils.isNotEmpty((CharSequence) map.get("number"))) {
			String numb = map.get("number").toString().trim();
			stringBuilder.append(" and a.number like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("customerName"))) {
			String numb = map.get("customerName").toString().trim();
			stringBuilder.append(" and a.customer_name like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("customerMobile"))) {
			String numb = map.get("customerMobile").toString().trim();
			stringBuilder.append(" and a.customer_contact like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("status"))) {
			String st = map.get("status").toString().trim();
			stringBuilder.append(" and a.status='" + st + "'");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("placingOrderBy"))) {
			String numb = map.get("placingOrderBy").toString().trim();
			stringBuilder.append(" and a.creator like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("goodName"))) {
			String numb = map.get("goodName").toString().trim();
			stringBuilder.append(" and a.good_name like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) map.get("goodCategory"))) {
			String numb = map.get("goodCategory").toString().trim();
			stringBuilder.append(" and a.good_category = '" + numb + "' ");
		}

		if (StringUtil.checkParamsValid(map.get("xiaoNames"))) {
			String[] xiaoNames = ((map.get("xiaoNames").toString())).split(",");
			if (xiaoNames.length > 0) {
				stringBuilder.append("and (a.placing_name like " + StringUtil.joinInSqlforselforder(xiaoNames) + ")");
			}
		}

		if (StringUtil.checkParamsValid(map.get("placingOrderTimeMin"))) {
			String placingOrderTimeMin = map.get("placingOrderTimeMin").toString().trim();
			stringBuilder.append(" and a.placing_order_time >= '" + placingOrderTimeMin + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("placingOrderTimeMax"))) {
			String placingOrderTimeMax = map.get("placingOrderTimeMax").toString().trim();
			stringBuilder.append(" and a.placing_order_time <= '" + placingOrderTimeMax + " 23:59:59' ");
		}
		if (StringUtil.checkParamsValid(map.get("confirmTimeMin"))) {
			String confirmTimeMin = map.get("confirmTimeMin").toString().trim();
			stringBuilder.append(" and a.confirm_time >= '" + confirmTimeMin + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid(map.get("confirmTimeMax"))) {
			String confirmTimeMax = map.get("confirmTimeMax").toString().trim();
			stringBuilder.append(" and a.confirm_time <= '" + confirmTimeMax + " 23:59:59' ");
		}

		return stringBuilder.toString();
	}

	private String getParamValue(Map<String, Object> map, String param) {
		Object value = map.get(param);
		return value == null ? null : ((String[]) map.get(param))[0];
	}

	private String getTrimmedParamValue(Map<String, Object> map, String param) {
		return org.apache.commons.lang.StringUtils.trim(getParamValue(map, param));
	}

	public Long queryCount(String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表数据总数
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT count(*) FROM crm_goods_siteself_order a  WHERE a.outstock_type!='3' and a.good_brand!='浩泽' AND a.site_id='" + siteId + "'");
		sb.append(siteselfOrderSql(map));
		return Db.queryLong(sb.toString());
	}

	public Long queryCountEbbsol(String siteId, Map<String, Object> map) {// 服务商权限 订单信息 列表数据总数
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT count(*) FROM crm_goods_siteself_order a  WHERE a.outstock_type='3'  AND a.site_id='" + siteId + "'");
		sb.append(siteselfOrderSqlZg(map));
		return Db.queryLong(sb.toString());
	}

	public Record queryById(String rowId) {// 服务商权限 订单信息 列表中点击收款操作 查出详细信息

		StringBuffer sb = new StringBuffer();
		sb.append(
				"SELECT d.good_icon,d.commissions_remarks, c.payment_type AS zfType, c.id AS zfId, c.imgs AS zfImg, c.payment_amount AS zfMoney, a.*, b.site_price, b.ratio_deduct_val, b.unit, b.deduct_type, b.employe_price");
		sb.append(" FROM crm_goods_siteself_order_goods_detail d ");
		sb.append(" LEFT JOIN  crm_goods_siteself_order a ON a.id=d.site_order_id ");
		sb.append(" LEFT JOIN crm_goods_siteself b ON d.good_id = b.id ");
		sb.append(" LEFT JOIN crm_order_collections c ON a.id = c.order_id AND c.status = '0' AND c.source = '1' ");
		sb.append(" WHERE a.id = ? ");
		return Db.findFirst(sb.toString(), rowId);

	}

	public Record getQueryGoodsById(String rowId) {// 服务商权限 订单信息 列表中点击收款操作 查出详细信息
		return Db.findFirst(
				"SELECT d.good_number,d.good_name,d.good_icon,d.good_brand,d.good_model,d.good_category,d.purchase_num,c.payment_type as zfType," + "c.id as zfId,c.imgs as zfImg,c.payment_amount as zfMoney,b.site_price,b.deduct_type," + "a.*" + "FROM crm_goods_siteself_order a "
						+ " left join crm_goods_siteself_order_goods_detail d on a.id=d.site_order_id " + "left join crm_goods_siteself b on d.good_id=b.id "
						+ "left join crm_order_collections c on a.id=c.order_id and c.status='0' and c.source='1' " + "WHERE  a.id='" + rowId + "'");
	}

	/* 确认收款页面收款详情 */
	public List<Record> getGoodOrderDetail(String orderId, String siteId) {
		StringBuilder sf = new StringBuilder();

		sf.append(" SELECT a.*,b.site_price,b.employe_price,b.customer_price FROM crm_goods_siteself_order_goods_detail a  ");
		sf.append(" LEFT JOIN crm_goods_siteself b ON b.id = a.good_id ");
		sf.append(" WHERE a.status='0' AND a.site_order_id=? AND a.site_id=? ");

		return Db.find(sf.toString(), orderId, siteId);
	}

	/* 新版自营商品确认收款 */
	@Transactional(rollbackFor = Exception.class)
	public String savegoodsReceivables(HttpServletRequest request, HttpServletResponse response) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Date da = new Date();
		String dat = DateUtils.formatDateTime(da);
		String orderId = request.getParameter("orderId");// id
		String confirmAmount = request.getParameter("confirmAmount");// 实收金额
		String salesCommissions = request.getParameter("salesCommissions");// 提成总额
		String paidCommissions = request.getParameter("paidCommissions");// 当日支付总金额
		String placingName = request.getParameter("placingName");// 销售人员名称
		String placingUserId = request.getParameter("UserId");// 销售人员userId
		String goWhere = request.getParameter("goWhere");//
		String createName = CrmUtils.getCreateName(user);
		Target ta = new Target();
		// try {

		GoodsSiteselfOrder order = siteselfOrderDao.get(orderId);
		if (!"detailPage".equals(goWhere)) {
			if (!"1".equals(order.getStatus()) && !"4".equals(order.getStatus())) {
				return "420";
			}
		}
		ta.setName(createName);// 操作人
		ta.setTime(dat);
		ta.setType(99);
		String content = "";
		/* 修改订单表信息 */
		order.setConfirmTime(da);
		order.setConfirmBy(user.getId());
		order.setConfirmor(createName);
		order.setPayMark(request.getParameter("payMark"));
		order.setConfirmAmount(Double.valueOf(confirmAmount));
		order.setSalesCommissions(Double.valueOf(salesCommissions));
		order.setPaidCommissions(new BigDecimal(paidCommissions));
		order.setPlacingName(placingName);
		order.setPlacingOrderBy(placingUserId);
		order.setStatus("3");

		content += "修改销售人员：" + placingName + "。  销售备注:" + order.getPayMark() + "。  实收金额:" + confirmAmount + "。  提成总额:" + salesCommissions;
		content += "。 当日支付：" + paidCommissions;
		JsonParser parser = new JsonParser();
		String salesmanId = request.getParameter("salesmanId");// id
		String salesmanName = request.getParameter("salesmanName");// 提成人员姓名
		String adjustGoodsId = request.getParameter("adjustGoodsId");// 商品详情id
		String everyTicheng = request.getParameter("everyTicheng");// 销售提成
		String paid_commissions = request.getParameter("paid_commissions");// 当日支付
		JsonArray saleId = parser.parse(salesmanId).getAsJsonArray();
		JsonArray names = parser.parse(salesmanName).getAsJsonArray();
		JsonArray goodsId = parser.parse(adjustGoodsId).getAsJsonArray();
		JsonArray saless = parser.parse(everyTicheng).getAsJsonArray();
		JsonArray paid_commi = parser.parse(paid_commissions).getAsJsonArray();
		/* 订单工程师提成明细记录生成 */
		List<GoodsSiteSelfOrderDeductDetail> listGssodd = new ArrayList<GoodsSiteSelfOrderDeductDetail>();
		/* 删除当前订单下所有提成明细 */
		Db.update("UPDATE crm_goods_siteself_order_deduct_detail  SET STATUS = '1' WHERE site_order_id =? AND site_id=? AND STATUS='0' ", orderId, siteId);
		logger.info("savegoodsReceivables:删除当前订单下所有提成明细【order:" + orderId + "】+time:" + dat);
		for (int i = 0; i < goodsId.size(); i++) {
			BigDecimal comm = new BigDecimal("0.00");
			// 订单商品详情信息
			String orderdetailId = goodsId.get(i).getAsString();
			SiteselfOrderGoodsDetail sogdCopy = siteselfOrderGoodsDetailDao.get(orderdetailId);
			// 当前订单下所有利润明细
			List<Record> rds = Db.find("SELECT * FROM crm_goods_siteself_profit_detail a " + "WHERE a.site_id=? AND a.site_order_id =?  AND a.status='0'", siteId, orderId);

			for (int j = 0; j < saleId.size(); j++) {
				int m = i * saleId.size() + j;
				content += "。   修改销售人员(" + names.get(j).getAsString() + ")的商品" + sogdCopy.getGoodName() + "， 提成金额:" + saless.get(m).getAsString() + "，  当日支付:"
						+ paid_commi.get(m).getAsString();
				/* 工程师对应商品生成的销售人员（工程师和信息员）提成明细 */
				GoodsSiteSelfOrderDeductDetail gssodd = new GoodsSiteSelfOrderDeductDetail();
				gssodd.setSiteOrderId(order.getId());
				gssodd.setSiteOrderGoodsDetailId(sogdCopy.getId());
				gssodd.setGoodId(sogdCopy.getGoodId());
				gssodd.setGoodNumber(sogdCopy.getGoodNumber());
				gssodd.setGoodName(sogdCopy.getGoodName());
				gssodd.setSalesmanId(saleId.get(j).getAsString());
				gssodd.setSalesman(names.get(j).getAsString());
				gssodd.setSalemanType(userDao.get(gssodd.getSalesmanId()).getUserType());
				gssodd.setCreateTime(da);
				gssodd.setStatus("0");
				gssodd.setSiteId(siteId);
				gssodd.setCreator(createName);
				gssodd.setPaidCommissions(new BigDecimal(paid_commi.get(m).getAsString()));
				gssodd.setSalesCommissions(new BigDecimal(saless.get(m).getAsString()));
				listGssodd.add(gssodd);
				comm = comm.add(gssodd.getSalesCommissions());
			}

			// 修改单个商品提成金额
			sogdCopy.setSalesCommissions(comm);
			for (Record rd : rds) {
				if (orderdetailId.equals(rd.getStr("site_order_goods_detail_id"))) {
					/* 销售成本 */
					BigDecimal cb = (rd.getBigDecimal("site_price").multiply(rd.getBigDecimal("good_num"))).add(comm);
					/* 修改服务商商品销售利润明细表 */
					Db.update("UPDATE crm_goods_siteself_profit_detail SET profit = (gross_sales -" + cb + ") , cost_sales = " + cb + "WHERE site_id=? AND site_order_id =? "
							+ "AND site_order_goods_detail_id=? AND status='0'", siteId, orderId, orderdetailId);
					logger.info("savegoodsReceivables:修改服务商商品销售利润明细表【order:" + orderId + "】+time:" + dat);
				}
			}

		}
		ta.setContent(createName + content);
		String strs = WebPageFunUtils.appendProcessDetail(ta, order.getEditDetail());
		order.setEditDetail(strs);
		order.setEditTime(da);
		siteselfOrderDao.save(order);
		// 添加新的提成明细
		goodsSiteSelfOrderDeductDetailDao.save(listGssodd);
		logger.info("content:修改服务商商品详情信息【content:" + content + "】+time:" + dat);
		return "200";

		/*
		 * } catch (Exception e) {
		 * logger.info("content:确认收款抛异常【Message:"+e.getMessage()+"】+time:"+dat);
		 */
	}

	// 自营商品订单确认收款
	@Transactional(rollbackFor = Exception.class)
	public String confirmAmount(String rowId, String confirmAmount, String status, String gId, Double pNum, String uid, String uname, String salesCommissions, String oneTch,
			String idsArr, String nameArrs, String marks, String commissionsRemarks) {// 服务商权限 订单信息 点击收款按钮确定付款，可以更改实交金额
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String dat = sf.format(now);
		BigDecimal allTc = new BigDecimal(0);
		String[] oneArr = oneTch.split(",");
		for (String my : oneArr) {
			allTc = allTc.add(new BigDecimal(my));
		}
		confirmAmount = confirmAmount.trim();
		if (StringUtils.isBlank(salesCommissions)) {
			salesCommissions = "0";
		}
		Record order = Db.findFirst(
				"select a.*,b.site_price as sitePrice from crm_goods_siteself_order a left join crm_goods_siteself b on a.good_id=b.id where a.id=? and a.status in ('1','4') ",
				rowId);
		if (order == null) {
			return "420";
		}
		/*
		 * if (status.equals("1")) {//公司库存，1:待收款待出库 SQLQuery sqlQuery3 =
		 * goodsSiteselfDetailDao.getSession().
		 * createSQLQuery("UPDATE crm_goods_siteself_order a SET a.status='2',a.confirm_time='"
		 * +dat+"', a.confirm_amount='"+confirmAmount+"',a.confirm_by='"+uid+
		 * "',a.confirmor='"+uname+"',a.sales_commissions='"+allTc+
		 * "',a.placing_order_by='"+idsArr+"',a.placing_name='"+
		 * nameArrs+"' WHERE a.id='"+rowId+"'"); sqlQuery3.executeUpdate(); } else if
		 * (status.equals("4")) {//工程师库存，4:待收款已出库
		 */ SQLQuery sqlQuery3 = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself_order a SET a.status='3',a.confirm_time='" + dat + "',a.pay_mark='" + marks + "', a.confirm_amount='" + confirmAmount
						+ "',a.confirm_by='" + uid + "',a.confirmor='" + uname + "',a.sales_commissions='" + allTc + "',a.placing_order_by='" + idsArr + "',a.placing_name='"
						+ nameArrs + "',a.commissions_remarks='" + commissionsRemarks + "' WHERE a.id='" + rowId + "'");
		sqlQuery3.executeUpdate();
		SQLQuery sqlQuery4 = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself a set a.sales=(a.sales+'" + pNum + "') WHERE a.status='0' AND a.id='" + gId + "'");
		sqlQuery4.executeUpdate();
		// }

		Long detailCount = Db.queryLong("select count(*) from crm_goods_siteself_detail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
		if (detailCount > 0) {
			SQLQuery sqlQuery2 = goodsSiteselfDetailDao.getSession().createSQLQuery(
					"update crm_goods_siteself_detail a set a.pay_money='" + confirmAmount + "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
			sqlQuery2.executeUpdate();
		}
		Long detailEmp = Db.queryLong("select count(*) from crm_goods_employe_owndetail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='"
				+ order.getStr("site_id") + "' and a.type='1' and a.status='0'");
		if (detailEmp > 0) {
			SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_employe_owndetail a set a.pay_money='" + confirmAmount
					+ "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='" + order.getStr("site_id") + "' and a.type='1' and a.status='0'");
			sqlQuery1.executeUpdate();
		}
		List<String> list = Lists.newArrayList();
		List<GoodsSiteSelfOrderDeductDetail> listAdd = Lists.newArrayList();
		;
		Date nowd = new Date();
		for (int i = 0; i < idsArr.split(",").length; i++) {
			String sql = "";
			Record rdc = Db.findFirst("select a.* from crm_goods_siteself_order_deduct_detail a where a.salesman_id ='" + idsArr.split(",")[i] + "' and a.site_order_id='" + rowId
					+ "' and a.status='0'");
			if (rdc != null) {
				sql = "UPDATE crm_goods_siteself_order_deduct_detail a  SET a.sales_commissions ='" + oneTch.split(",")[i] + "'  WHERE a.salesman_id ='" + idsArr.split(",")[i]
						+ "' and a.site_order_id='" + rowId + "' ";
				// list.add(sql);
				SQLQuery sqlQuery9 = goodsSiteselfDetailDao.getSession().createSQLQuery(sql);
				sqlQuery9.executeUpdate();
			} else {
				Record rdUser = Db.findFirst("select a.* from sys_user a where a.id=?", idsArr.split(",")[i]);
				GoodsSiteSelfOrderDeductDetail sodd = new GoodsSiteSelfOrderDeductDetail();
				sodd.setCreateTime(nowd);
				sodd.setCreator(order.getStr("creator"));
				sodd.setGoodName(order.getStr("good_name"));
				sodd.setGoodNumber(order.getStr("good_number"));
				sodd.setSalemanType(rdUser.getStr("user_type"));
				sodd.setSalesCommissions(new BigDecimal(oneTch.split(",")[i]));
				sodd.setSalesman(nameArrs.split(",")[i]);
				sodd.setSalesmanId(idsArr.split(",")[i]);
				sodd.setSiteId(order.getStr("site_id"));
				sodd.setSiteOrderId(rowId);
				sodd.setStatus("0");
				listAdd.add(sodd);
			}
		}
		String delIds = "";
		for (String str : order.getStr("placing_order_by").split(",")) {
			String mark1 = "0";
			for (int j = 0; j < idsArr.split(",").length; j++) {
				if (str.equals(idsArr.split(",")[j])) {
					mark1 = "1";
				}
			}
			if (!"1".equals(mark1)) {
				if ("".equals(delIds)) {
					delIds = "'" + str + "'";
				} else {
					delIds = delIds + ",'" + str + "'";
				}
			}
		}
		if (StringUtils.isNotBlank(delIds)) {
			SQLQuery sqlQuery0 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("update crm_goods_siteself_order_deduct_detail a set a.status='1' where a.salesman_id in(" + delIds + ") and a.site_order_id='" + rowId + "'");
			sqlQuery0.executeUpdate();
		}
		if (listAdd.size() > 0) {
			goodsSiteSelfOrderDeductDetailDao.save(listAdd);
		}
		/*
		 * if(list.size()>0){//jfinal事务不回滚 Db.batch(list, list.size()); }
		 */
		// 更新利润表
		String nameNow = CrmUtils.getUserXM();// 销售人nameArrs;总额：confirmAmount；工程师提成：allTc；成本：
		Double chenben = Double.valueOf(allTc.toString()) + Double.valueOf(order.getBigDecimal("sitePrice").toString()) * pNum;
		Double lr = Double.valueOf(confirmAmount) - chenben;
		if (lr <= 0) {
			lr = Double.valueOf(0);
		}
		SQLQuery sqlQueryPay = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself_profit_detail a SET a.confirmor='" + nameNow + "', a.confirm_time=NOW(),a.salesman='" + nameArrs + "',a.gross_sales='"
						+ confirmAmount + "',a.cost_sales='" + chenben + "',a.profit='" + lr + "',a.site_price='"
						+ Double.valueOf(order.getBigDecimal("sitePrice").toString()) * pNum + "' WHERE a.site_id='" + order.getStr("site_id") + "' AND a.site_order_id='"
						+ order.getStr("id") + "' AND a.status='0'");
		sqlQueryPay.executeUpdate();
		return "200";
	}

	// 自营商品订单确认收款
	@Transactional(rollbackFor = Exception.class)
	public String confirmAmountHz(String rowId, String confirmAmount, String status, String gId, Double pNum, String uid, String uname, String salesCommissions, String oneTch,
			String idsArr, String nameArrs, String marks, String commissionsRemarks) {// 服务商权限 订单信息 点击收款按钮确定付款，可以更改实交金额
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String dat = sf.format(now);
		BigDecimal allTc = new BigDecimal(0);
		String[] oneArr = oneTch.split(",");
		for (String my : oneArr) {
			allTc = allTc.add(new BigDecimal(my));
		}
		confirmAmount = confirmAmount.trim();
		if (StringUtils.isBlank(salesCommissions)) {
			salesCommissions = "0";
		}

		StringBuffer sbf = new StringBuffer();
		sbf.append(" SELECT  a.*,b.site_price AS sitePrice FROM crm_goods_siteself_order_goods_detail d  ");
		sbf.append(" LEFT JOIN crm_goods_siteself_order a ON d.`site_order_id` = a.`id`  ");
		sbf.append(" LEFT JOIN crm_goods_siteself b  ON d.good_id = b.id  ");
		sbf.append(" WHERE a.id = ? AND a.status IN ('1', '4') ");
		Record order = Db.findFirst(sbf.toString(), rowId);

		if (order == null) {
			return "420";
		}
		if (status.equals("1")) {// 公司库存，1:待收款待出库
			SQLQuery sqlQuery3 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("UPDATE crm_goods_siteself_order a LEFT JOIN crm_goods_siteself_order_goods_detail b ON a.id=b.`site_order_id`"
							+ "  SET a.status='2',a.confirm_time='" + dat + "',a.pay_mark='" + marks + "', a.confirm_amount='" + confirmAmount + "',a.confirm_by='" + uid
							+ "',a.confirmor='" + uname + "',a.sales_commissions='" + allTc + "',a.placing_order_by='" + idsArr + "',a.placing_name='" + nameArrs
							+ "',b.commissions_remarks='" + commissionsRemarks + "'  WHERE a.id='" + rowId + "'");
			sqlQuery3.executeUpdate();
		} else if (status.equals("4")) {// 工程师库存，4:待收款已出库
			SQLQuery sqlQuery3 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("UPDATE crm_goods_siteself_order a LEFT JOIN crm_goods_siteself_order_goods_detail b ON a.id=b.`site_order_id`"
							+ " SET a.status='3',a.confirm_time='" + dat + "',a.pay_mark='" + marks + "', a.confirm_amount='" + confirmAmount + "',a.confirm_by='" + uid
							+ "',a.confirmor='" + uname + "',a.sales_commissions='" + allTc + "',a.placing_order_by='" + idsArr + "',a.placing_name='" + nameArrs
							+ "',b.commissions_remarks='" + commissionsRemarks + "'  WHERE a.id='" + rowId + "'");
			sqlQuery3.executeUpdate();
			SQLQuery sqlQuery4 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("UPDATE crm_goods_siteself a set a.sales=(a.sales+'" + pNum + "') WHERE a.status='0' AND a.id='" + gId + "'");
			sqlQuery4.executeUpdate();
		}

		Long detailCount = Db.queryLong("select count(*) from crm_goods_siteself_detail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
		if (detailCount > 0) {
			SQLQuery sqlQuery2 = goodsSiteselfDetailDao.getSession().createSQLQuery(
					"update crm_goods_siteself_detail a set a.pay_money='" + confirmAmount + "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
			sqlQuery2.executeUpdate();
		}
		Long detailEmp = Db.queryLong("select count(*) from crm_goods_employe_owndetail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='"
				+ order.getStr("site_id") + "' and a.type='1' and a.status='0'");
		if (detailEmp > 0) {
			SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_employe_owndetail a set a.pay_money='" + confirmAmount
					+ "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='" + order.getStr("site_id") + "' and a.type='1' and a.status='0'");
			sqlQuery1.executeUpdate();
		}
		List<String> list = Lists.newArrayList();
		List<GoodsSiteSelfOrderDeductDetail> listAdd = Lists.newArrayList();
		;
		Date nowd = new Date();
		for (int i = 0; i < idsArr.split(",").length; i++) {
			String sql = "";
			Record rdc = Db.findFirst("select a.* from crm_goods_siteself_order_deduct_detail a where a.salesman_id ='" + idsArr.split(",")[i] + "' and a.site_order_id='" + rowId
					+ "' and a.status='0'");
			if (rdc != null) {
				sql = "UPDATE crm_goods_siteself_order_deduct_detail a  SET a.sales_commissions ='" + oneTch.split(",")[i] + "'  WHERE a.salesman_id ='" + idsArr.split(",")[i]
						+ "' and a.site_order_id='" + rowId + "' ";
				// list.add(sql);
				SQLQuery sqlQuery9 = goodsSiteselfDetailDao.getSession().createSQLQuery(sql);
				sqlQuery9.executeUpdate();
			} else {
				Record rdUser = Db.findFirst("select a.* from sys_user a where a.id=?", idsArr.split(",")[i]);
				GoodsSiteSelfOrderDeductDetail sodd = new GoodsSiteSelfOrderDeductDetail();
				sodd.setCreateTime(nowd);
				sodd.setCreator(order.getStr("creator"));
				sodd.setGoodName(order.getStr("good_name"));
				sodd.setGoodNumber(order.getStr("good_number"));
				sodd.setSalemanType(rdUser.getStr("user_type"));
				sodd.setSalesCommissions(new BigDecimal(oneTch.split(",")[i]));
				sodd.setSalesman(nameArrs.split(",")[i]);
				sodd.setSalesmanId(idsArr.split(",")[i]);
				sodd.setSiteId(order.getStr("site_id"));
				sodd.setSiteOrderId(rowId);
				sodd.setStatus("0");
				listAdd.add(sodd);
			}
		}
		String delIds = "";
		for (String str : order.getStr("placing_order_by").split(",")) {
			String mark1 = "0";
			for (int j = 0; j < idsArr.split(",").length; j++) {
				if (str.equals(idsArr.split(",")[j])) {
					mark1 = "1";
				}
			}
			if (!"1".equals(mark1)) {
				if ("".equals(delIds)) {
					delIds = "'" + str + "'";
				} else {
					delIds = delIds + ",'" + str + "'";
				}
			}
		}
		if (StringUtils.isNotBlank(delIds)) {
			SQLQuery sqlQuery0 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("update crm_goods_siteself_order_deduct_detail a set a.status='1' where a.salesman_id in(" + delIds + ") and a.site_order_id='" + rowId + "'");
			sqlQuery0.executeUpdate();
		}
		if (listAdd.size() > 0) {
			goodsSiteSelfOrderDeductDetailDao.save(listAdd);
		}
		/*
		 * if(list.size()>0){//jfinal事务不回滚 Db.batch(list, list.size()); }
		 */
		// 更新利润表
		String nameNow = CrmUtils.getUserXM();// 销售人nameArrs;总额：confirmAmount；工程师提成：allTc；成本：
		Double chenben = Double.valueOf(allTc.toString()) + Double.valueOf(order.getBigDecimal("sitePrice").toString()) * pNum;
		Double lr = Double.valueOf(confirmAmount) - chenben;
		if (lr <= 0) {
			lr = Double.valueOf(0);
		}
		SQLQuery sqlQueryPay = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself_profit_detail a SET a.confirmor='" + nameNow + "', a.confirm_time=NOW(),a.salesman='" + nameArrs + "',a.gross_sales='"
						+ confirmAmount + "',a.cost_sales='" + chenben + "',a.profit='" + lr + "',a.site_price='"
						+ Double.valueOf(order.getBigDecimal("sitePrice").toString()) * pNum + "' WHERE a.site_id='" + order.getStr("site_id") + "' AND a.site_order_id='"
						+ order.getStr("id") + "' AND a.status='0'");
		sqlQueryPay.executeUpdate();
		return "200";
	}

	// 平台商品订单确认收款
	@Transactional(rollbackFor = Exception.class)
	public Boolean confirmAmount1(String rowId, String confirmAmount, String status, String pNum, String gId, String uid, String uname, String salesCommissions, String oneTch,
			String idsArr, String nameArrs) {// 服务商权限 订单信息 点击收款按钮确定付款，可以更改实交金额
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String dat = sf.format(now);
		BigDecimal allTc = new BigDecimal(0);
		String[] oneArr = oneTch.split(",");
		for (String my : oneArr) {
			allTc = allTc.add(new BigDecimal(my));
		}
		confirmAmount = confirmAmount.trim();
		if (StringUtils.isBlank(salesCommissions)) {
			salesCommissions = "0";
		}
		Record order = Db.findFirst("select * from crm_goods_siteself_order where id=? ", rowId);
		/*
		 * if (status.equals("1")) {//公司库存，1:待收款待出库 SQLQuery sqlQuery3 =
		 * goodsSiteselfDetailDao.getSession().
		 * createSQLQuery("UPDATE crm_goods_siteself_order a SET a.status='2',a.confirm_time='"
		 * +dat+"', a.confirm_amount='"+confirmAmount+"',a.confirm_by='"+uid+
		 * "',a.confirmor='"+uname+"',a.sales_commissions='"+allTc+
		 * "',a.placing_order_by='"+idsArr+"',a.placing_name='"+
		 * nameArrs+"' WHERE a.id='"+rowId+"'"); sqlQuery3.executeUpdate(); } else if
		 * (status.equals("4")) {//工程师库存，4:待收款已出库
		 */ SQLQuery sqlQuery3 = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself_order a SET a.status='3',a.confirm_time='" + dat + "', a.confirm_amount='" + confirmAmount + "',a.confirm_by='" + uid
						+ "',a.confirmor='" + uname + "',a.sales_commissions='" + allTc + "',a.placing_order_by='" + idsArr + "',a.placing_name='" + nameArrs + "' WHERE a.id='"
						+ rowId + "'");
		sqlQuery3.executeUpdate();
		SQLQuery sqlQuery4 = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself a set a.sales=(a.sales+'" + pNum + "') WHERE a.status='0' AND a.id='" + gId + "'");
		sqlQuery4.executeUpdate();
		// }

		Long detailCount = Db.queryLong("select count(*) from crm_goods_siteself_detail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
		if (detailCount > 0) {
			SQLQuery sqlQuery2 = goodsSiteselfDetailDao.getSession().createSQLQuery(
					"update crm_goods_siteself_detail a set a.pay_money='" + confirmAmount + "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
			sqlQuery2.executeUpdate();
		}
		Long detailEmp = Db.queryLong("select count(*) from crm_goods_employe_owndetail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='"
				+ order.getStr("site_id") + "' and a.type='1' and a.status='0'");
		if (detailEmp > 0) {
			SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_employe_owndetail a set a.pay_money='" + confirmAmount
					+ "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='" + order.getStr("site_id") + "' and a.type='1' and a.status='0'");
			sqlQuery1.executeUpdate();
		}
		List<String> list = Lists.newArrayList();
		List<GoodsSiteSelfOrderDeductDetail> listAdd = Lists.newArrayList();
		;
		Date nowd = new Date();
		for (int i = 0; i < idsArr.split(",").length; i++) {
			String sql = "";
			Record rdc = Db.findFirst("select a.* from crm_goods_siteself_order_deduct_detail a where a.salesman_id ='" + idsArr.split(",")[i] + "' and a.site_order_id='" + rowId
					+ "' and a.status='0'");
			if (rdc != null) {
				sql = "UPDATE crm_goods_siteself_order_deduct_detail a  SET a.sales_commissions ='" + oneTch.split(",")[i] + "'  WHERE a.salesman_id ='" + idsArr.split(",")[i]
						+ "' and a.site_order_id='" + rowId + "' ";
				// list.add(sql);
				SQLQuery sqlQuery9 = goodsSiteselfDetailDao.getSession().createSQLQuery(sql);
				sqlQuery9.executeUpdate();
			} else {
				Record rdUser = Db.findFirst("select a.* from sys_user a where a.id=?", idsArr.split(",")[i]);
				GoodsSiteSelfOrderDeductDetail sodd = new GoodsSiteSelfOrderDeductDetail();
				sodd.setCreateTime(nowd);
				sodd.setCreator(order.getStr("creator"));
				sodd.setGoodName(order.getStr("good_name"));
				sodd.setGoodNumber(order.getStr("good_number"));
				sodd.setSalemanType(rdUser.getStr("user_type"));
				sodd.setSalesCommissions(new BigDecimal(oneTch.split(",")[i]));
				sodd.setSalesman(nameArrs.split(",")[i]);
				sodd.setSalesmanId(idsArr.split(",")[i]);
				sodd.setSiteId(order.getStr("site_id"));
				sodd.setSiteOrderId(rowId);
				sodd.setStatus("0");
				listAdd.add(sodd);
			}
		}
		String delIds = "";
		for (String str : order.getStr("placing_order_by").split(",")) {
			String mark1 = "0";
			for (int j = 0; j < idsArr.split(",").length; j++) {
				if (str.equals(idsArr.split(",")[j])) {
					mark1 = "1";
				}
			}
			if (!"1".equals(mark1)) {
				if ("".equals(delIds)) {
					delIds = "'" + str + "'";
				} else {
					delIds = delIds + ",'" + str + "'";
				}
			}
		}
		if (StringUtils.isNotBlank(delIds)) {
			SQLQuery sqlQuery0 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("update crm_goods_siteself_order_deduct_detail a set a.status='1' where a.salesman_id in(" + delIds + ") and a.site_order_id='" + rowId + "'");
			sqlQuery0.executeUpdate();
		}
		if (listAdd.size() > 0) {
			goodsSiteSelfOrderDeductDetailDao.save(listAdd);
		}
		/*
		 * if(list.size()>0){//jfinal事务不回滚 Db.batch(list, list.size()); }
		 */
		return true;
	}

	public Record detailMsg(String rowId) {// 服务商权限 订单信息 订单(出库)详情
		StringBuffer sb = new StringBuffer();
		sb.append(
				"SELECT d.good_icon,d.good_category,d.good_number,d.good_amount,a.*,(a.purchase_num * b.site_price) AS jiage, b.stocks, b.source, b.unit, b.customer_price, b.rebate_price, b.stocks");
		sb.append(" FROM crm_goods_siteself_order a ");
		sb.append(" LEFT JOIN crm_goods_siteself_order_goods_detail d ON a.`id`=d.`site_order_id` ");
		sb.append(" LEFT JOIN crm_goods_siteself b ON d.good_id = b.id ");
		sb.append(" where a.id=? ");
		return Db.findFirst(sb.toString(), rowId);

	}

	public Record detailMsgEdit(String rowId) {// 服务商权限 订单信息 订单(出库)详情
		StringBuffer sb = new StringBuffer();
		sb.append(
				"SELECT d.good_category,d.good_model,d.good_number,d.good_icon,a.id, b.site_price, b.employe_price, c.payment_type AS zfType, c.id AS zfId, c.imgs AS zfImg, c.payment_amount AS zfMoney, a.*, (a.purchase_num * b.site_price) AS jiage, b.stocks, b.source, b.unit, b.customer_price, b.rebate_price, b.stocks");
		sb.append(" FROM crm_goods_siteself_order_goods_detail d ");
		sb.append(" LEFT JOIN crm_goods_siteself_order a ON a.id=d.site_order_id ");
		sb.append(" LEFT JOIN crm_goods_siteself b ON d.good_id = b.id ");
		sb.append(" LEFT JOIN crm_order_collections c ON a.id = c.order_id ");
		sb.append(" AND c.status = '0' AND c.source = '1' ");
		sb.append(" WHERE a.id = ? ");
		Record rd = Db.findFirst(sb.toString(), rowId);

		String emIds = rd.getStr("placing_order_by");
		String moneys = "";
		if (StringUtils.isNotBlank(emIds)) {
			for (String st : emIds.split(",")) {
				Record rds = Db.findFirst("select * from  crm_goods_siteself_order_deduct_detail a where a.site_order_id='" + rowId + "' and a.salesman_id='" + st + "'");
				if (rds != null) {
					if (StringUtils.isBlank(moneys)) {
						moneys = rds.getBigDecimal("sales_commissions").toString();
					} else {
						moneys = moneys + "," + rds.getBigDecimal("sales_commissions").toString();
					}
				}
			}
		}
		rd.set("moneys", moneys);
		return rd;
	}

	@Transactional(rollbackFor = Exception.class)
	public String outStock(String rowId, String goodId, Double purchaseNum) {// 服务商权限 订单信息 出库操作
		User user = UserUtils.getUser();
		Record rd = Db.findFirst(
				"select a.*,b.source,b.stocks,b.number as goodNumber,e.id as emId from crm_goods_siteself_order a left join crm_goods_siteself b on a.good_id=b.id left join crm_employe e on e.user_id=a.create_by  where a.id=? and e.status='0'",
				rowId);
		String status = rd.getStr("status");
		if (!"2".equals(status) && !"1".equals(status)) {
			return "yck";
		}
		if ("2".equals(rd.getStr("source"))) {// 如果是平台商品，则校验有库存够不够
			BigDecimal stks = rd.getBigDecimal("stocks");
			if (stks == null) {
				return "noStocks";
			} else {
				Double goodsStocks = Double.valueOf(rd.getBigDecimal("stocks").toString());
				int i = purchaseNum.compareTo(goodsStocks);
				if (i == 1) {
					return "noStocks";
				}
			}
		}
		String stats = "3";// 默认出库后的状态是已完成
		if ("1".equals(status)) {// 如果当前状态是待收款待出库，则出库之后是状态4：待收款已出库状态
			stats = "4";
		}
		String string = "UPDATE crm_goods_siteself a SET a.stocks=(a.stocks-'" + purchaseNum + "'),a.sales=(a.sales+'" + purchaseNum + "') WHERE a.status='0' AND a.id='" + goodId
				+ "'";// 公司库存减少
		SQLQuery sqlQuery8 = goodsSiteselfDetailDao.getSession().createSQLQuery(string);
		sqlQuery8.executeUpdate();
		// 出库后订单状态改3:已完成
		SQLQuery sqlQuery7 = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself_order a SET a.status='" + stats + "',a.outstock_time=NOW(),a.outstock_type='1' WHERE a.id='" + rowId + "'");
		sqlQuery7.executeUpdate();
		String rt = detailEntity(goodId, rowId, rd.getBigDecimal("confirm_amount"));// 出入库明细里新增一条入库数据

		List<GoodsEmployeOwnDetail> listAdd = new ArrayList<>();
		Date dt = new Date();
		GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
		geod.setAmount(purchaseNum);
		geod.setCreateBy(user.getId());
		geod.setCreateTime(dt);
		geod.setEmployeId(rd.getStr("emId"));
		geod.setGoodId(goodId);
		geod.setGoodNumber(rd.getStr("good_number"));
		geod.setOrderId(rowId);
		geod.setPayMoney(rd.getBigDecimal("confirm_amount"));
		geod.setSiteId(rd.getStr("site_id"));
		geod.setType("1");// 领用
		geod.setMark("1");
		listAdd.add(geod);

		GoodsEmployeOwnDetail geod1 = new GoodsEmployeOwnDetail();
		geod1.setAmount(purchaseNum);
		geod1.setCreateBy(user.getId());
		geod1.setCreateTime(dt);
		geod1.setEmployeId(rd.getStr("emId"));
		geod1.setGoodId(goodId);
		geod1.setGoodNumber(rd.getStr("good_number"));
		geod1.setOrderId(rowId);
		// geod1.setPayMoney(rd.getBigDecimal("confirm_amount"));
		geod1.setSiteId(rd.getStr("site_id"));
		geod1.setType("2");// 零售
		geod1.setMark("1");
		listAdd.add(geod1);
		goodsEmployeOwnDetailDao.save(listAdd);// 添加服务工程师出入库明细
		// 查看这个工程师有没有维护这个商品
		Long countE = Db.queryLong("select count(*) from crm_goods_employe_own a  where a.site_id='" + rd.getStr("site_id") + "' and a.good_id='" + goodId + "' and a.employe_id='"
				+ rd.getStr("emId") + "'");
		if (countE < 1) {// 小于1说明这个工程师并没有维护这个商品，则给他维护上
			GoodsEmployeOwn geo = new GoodsEmployeOwn();
			geo.setEmployeId(rd.getStr("emId"));
			geo.setGoodId(goodId);
			geo.setGoodNumber(rd.getStr("goodNumber"));
			geo.setReceives(purchaseNum);
			geo.setSales(purchaseNum);
			geo.setSiteId(rd.getStr("site_id"));
			geo.setStocks(0);
			goodsEmployeOwnDao.save(geo);
		} else {// 否则已经维护改商品，对应的销售数量和领取数量改变
			String sqlOwn = "update crm_goods_employe_own a set a.sales=(a.sales+'" + purchaseNum + "'),a.receives=(a.receives+'" + purchaseNum + "') where a.site_id='"
					+ rd.getStr("site_id") + "' and a.good_id='" + goodId + "' and a.employe_id='" + rd.getStr("emId") + "'";
			SQLQuery sqlQueryOwn = goodsSiteselfDetailDao.getSession().createSQLQuery(sqlOwn);
			sqlQueryOwn.executeUpdate();
		}
		if ("no".equals(rt)) {
			return "yxj";// 商品信息有误
		}
		return "ok";
	}

	public Record querySiteselfById(String goodId, String rowId) {// 根据商品Id查出商品基本信息
		String sql = "SELECT a.*,b.purchase_num,b.id as odId,b.placing_name,b.creator as oCreator FROM crm_goods_siteself a LEFT JOIN crm_goods_siteself_order b ON a.id=b.good_id WHERE  b.id='"
				+ rowId + "'";
		return Db.findFirst(sql);
	}

	public String detailEntity(String goodId, String rowId, BigDecimal confirmAmount) {// 公司出入库明细表中新增一条出库数据
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		Record rd = querySiteselfById(goodId, rowId);
		if (rd != null) {
			String name = "";
			if (User.USER_TYPE_SIT.equals(user.getUserType())) {
				name = siteService.getUserSite(user.getId()).getName();
			} else {
				name = nonService.getNonServiceman(user).getName();
			}
			gsd.setGoodId(rd.getStr("id"));
			gsd.setGoodNumber(rd.getStr("number"));
			gsd.setGoodName(rd.getStr("name"));
			gsd.setGoodBrand(rd.getStr("brand"));
			gsd.setGoodModel(rd.getStr("model"));
			gsd.setGoodCategory(rd.getStr("category"));
			;
			gsd.setUnit(rd.getStr("unit"));
			gsd.setType("2");// 1入库：2出库
			gsd.setSitePrice(rd.getBigDecimal("site_price"));
			gsd.setEmployePrice(rd.getBigDecimal("employe_price"));
			gsd.setCustomerPrice(rd.getBigDecimal("customer_price"));
			gsd.setAmount(rd.getBigDecimal("purchase_num"));
			gsd.setApplicant(rd.getStr("oCreator"));
			gsd.setSiteId(siteId);
			gsd.setCreateTime(new Date());
			gsd.setOrderId(rowId);
			gsd.setApplyTime(new Date());
			gsd.setConfirmor(name);
			gsd.setConfirmTime(new Date());
			gsd.setPayMoney(confirmAmount);
			goodsSiteselfDetailDao.save(gsd);
			String string = "UPDATE crm_goods_siteself_profit_detail a SET a.siteself_detail_id='" + gsd.getId() + "' WHERE a.status='0' and a.site_order_id='" + rowId
					+ "' AND a.site_id='" + siteId + "'";// 浩泽净水公司库存出库是更新服务商利润表中的明细id
			SQLQuery sqlQuery = goodsSiteselfDetailDao.getSession().createSQLQuery(string);
			sqlQuery.executeUpdate();
			logger.info("site goodsOrder outStocks detail(服务商自营商品出库生成明细)--" + rd.getBigDecimal("purchase_num"));
			return "ok";
		}
		return "no";
	}

	// 添加公司库存出库时的工程师出入库明细记录
	public String addEmployeDetail() {
		List<Record> list = Db.find(
				"SELECT a.*,u.emId,s.user_id as uId FROM crm_goods_siteself_order a LEFT JOIN (SELECT m.id,m.user_type,n.id AS emId FROM sys_user m LEFT JOIN crm_employe n ON m.id=n.user_id) u  ON u.id=a.create_by left join crm_site s on s.id=a.site_id WHERE a.status IN('3','4') AND a.outstock_type='1' AND u.user_type='4'");
		List<GoodsEmployeOwnDetail> listAdd = new ArrayList<>();
		for (Record rd : list) {
			String type = "1";
			Long count1 = Db.queryLong("select count(*) from crm_goods_employe_owndetail where order_id=? and `type`='1' and `status`='0'", rd.getStr("id"));
			Long count2 = Db.queryLong("select count(*) from crm_goods_employe_owndetail where order_id=? and `type`='2' and `status`='0'", rd.getStr("id"));
			if (count1 < 1) {
				if ("1".equals(type)) {
					listAdd.add(bornEntity(rd, "1"));
				}
			}
			type = "2";
			if (count2 < 1) {
				if ("2".equals(type)) {
					listAdd.add(bornEntity(rd, "2"));
				}
			}
		}
		if (listAdd.size() > 0) {
			goodsEmployeOwnDetailDao.save(listAdd);
		}
		return "success";
	}

	public GoodsEmployeOwnDetail bornEntity(Record rd, String type) {
		GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
		geod.setAmount(rd.getBigDecimal("purchase_num").doubleValue());
		geod.setCreateTime(rd.getDate("placing_order_time"));
		geod.setSiteId(rd.getStr("site_id"));
		geod.setOrderId(rd.getStr("id"));
		geod.setEmployeId(rd.getStr("emId"));
		if ("1".equals(type)) {
			geod.setPayMoney(rd.getBigDecimal("confirm_amount"));
		}
		geod.setGoodId(rd.getStr("good_id"));
		geod.setGoodNumber(rd.getStr("good_number"));
		geod.setType(type);
		geod.setCreateBy(rd.getStr("uId"));
		return geod;
	}

	// 取消商品订单
	@Transactional(rollbackFor = Exception.class)
	public Result<T> cancelGoodsOrder(String ids, String reason) {
		List<Record> list = Db.find(
				"select e.id as emId,a.*,b.id as orderId,b.status as orderStatus from crm_goods_siteself_order_goods_detail a inner join crm_goods_siteself_order b on a.site_order_id=b.id left join crm_employe e on e.user_id=a.create_by  where a.status='0' and b.status!=0 and a.site_order_id in ("
						+ ids + ")");
		User user = UserUtils.getUser();
		Result<T> rt = new Result<>();
		String sqlUp = "update crm_goods_siteself_order a set a.status='0',a.cancel_reason='" + reason + "' where a.id in(" + ids + ")";// 更新商品订单状态为0，删除状态
		String confirmSql = "update crm_goods_siteself_order_deduct_detail a set a.status='1' where a.site_order_id in (" + ids + ") and a.site_id='"
				+ CrmUtils.getCurrentSiteId(user) + "' and a.status='0'";

		/* 一个订单多商品调整时添加的逻辑 */
		String sqlOrderDetail = "update crm_goods_siteself_order_goods_detail a set a.cancel_reason='" + reason + "' where a.site_order_id in(" + ids + ") and a.status='0'";

		for (Record rd : list) {
			String status = rd.getStr("orderStatus");
			String osType = rd.getStr("outstock_type");
			String sql = "";
			String wxSql = "";
			GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
			GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
			if (("3".equals(status) || "4".equals(status)) || "5".equals(status) && !"2".equals(osType)) {// 如果状态为已出库（osType：1公司库存出库 0工程师库存出库3工程师自购库存）
				if ("0".equals(osType)) {// 0：工程师库存出库,工程师库存加
					// 工程师库存加回去
					sql = "update crm_goods_employe_own a set a.stocks=(a.stocks+'" + rd.getBigDecimal("purchase_num") + "'),a.sales=(a.sales-'" + rd.getBigDecimal("purchase_num")
							+ "') where a.employe_id='" + rd.getStr("emId") + "' and a.good_id='" + rd.getStr("good_id") + "' and a.site_id='" + rd.getStr("site_id") + "'";
					// 工程师出入库明细置为无效
					wxSql = "update crm_goods_employe_owndetail a set a.status='1' where a.employe_id='" + rd.getStr("emId") + "' and a.site_id='" + rd.getStr("site_id")
							+ "' and a.order_id='" + rd.getStr("orderId") + "'";
				}
				if ("1".equals(osType)) {// 1：公司库存出库，（包括两种类型：1pc端零售 2工程师提交订单公司库存出库）
					// 公司库存加回去
					sql = "update crm_goods_siteself a set a.stocks=(a.stocks+'" + rd.getBigDecimal("purchase_num") + "'),a.sales=(a.sales-'" + rd.getBigDecimal("purchase_num")
							+ "') where a.id='" + rd.getStr("good_id") + "' and a.site_id='" + rd.getStr("site_id") + "' and a.status='0' ";
					// 公司出入明细置为无效
					wxSql = "update crm_goods_siteself_detail a set a.status='1' where a.order_id='" + rd.getStr("orderId") + "' and a.site_id='" + rd.getStr("site_id") + "' ";
				}
				if ("3".equals(osType)) {
					// 工程师库存加回去
					sql = "update crm_goods_employe_own a set a.zg_stocks=(a.zg_stocks+'" + rd.getBigDecimal("purchase_num") + "'),a.zg_sales=(a.zg_sales-'"
							+ rd.getBigDecimal("purchase_num") + "') where a.employe_id='" + rd.getStr("emId") + "' and a.good_id='" + rd.getStr("good_id") + "' and a.site_id='"
							+ rd.getStr("site_id") + "'";
					// 工程师出入库明细置为无效
					wxSql = "update crm_goods_employe_owndetail a set a.status='1' where a.employe_id='" + rd.getStr("emId") + "' and a.site_id='" + rd.getStr("site_id")
							+ "' and a.order_id='" + rd.getStr("orderId") + "'";
				}
			}
			if (!"".equals(sql)) {
				SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery(sql);// 对应的库存添加
				sqlQuery1.executeUpdate();
			}
			if (!"".equals(wxSql)) {
				SQLQuery sqlQuery2 = goodsSiteselfDetailDao.getSession().createSQLQuery(wxSql);// 删除订单对应的出库记录
				sqlQuery2.executeUpdate();
			}
			if (!"".equals(confirmSql)) {
				SQLQuery sqlQuery4 = goodsSiteselfDetailDao.getSession().createSQLQuery(confirmSql);// 删除订单对应的出库记录
				sqlQuery4.executeUpdate();
			}
			logger.info("服务商手动取消订单，订单编号为：" + rd.getStr("id") + ",商品good_id为：" + rd.getStr("good_id") + ",数量amount为：" + rd.getBigDecimal("purchase_num"));
		}
		SQLQuery sqlQuery = goodsSiteselfDetailDao.getSession().createSQLQuery(sqlUp);// 更新订单状态为0删除状态
		sqlQuery.executeUpdate();

		SQLQuery sqlQueryDetail = goodsSiteselfDetailDao.getSession().createSQLQuery(sqlOrderDetail);// 更新订单明细的取消原因
		sqlQueryDetail.executeUpdate();

		SQLQuery sqlQueryProfit = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("update crm_goods_siteself_profit_detail a set a.status='1' where a.site_order_id in (" + ids + ")");// 服务商利润表置为删除状态
		sqlQueryProfit.executeUpdate();
		/*
		 * if(listDt.size()>0){ goodsSiteselfDetailDao.save(listDt);//服务商出入库如明细 }
		 * if(listDet.size()>0){ goodsEmployeOwnDetailDao.save(listDet);//工程师出入库如明细 }
		 */
		rt.setCode("200");
		rt.setMsg("cancel success!");
		return rt;
	}

	/* 工单关联商品销售 */
	public List<Record> orderVsGoods(String siteId, String orderNumber) {
		List<Record> list = Db.find(
				"select a.id,a.number,a.placing_name,a.placing_order_time,a.status,a.real_amount,a.confirm_amount from crm_goods_siteself_order a left join crm_order o on o.id=a.order_id  where a.site_id=? and o.site_id=? and o.number=? order by a.placing_order_time desc",
				siteId, siteId, orderNumber);
		for (Record rd : list) {
			String id = rd.getStr("id");
			List<Record> list2 = Db.find(
					"select a.*,b.site_price,b.source as goodSource,b.stocks from crm_goods_siteself_order_goods_detail a left join crm_goods_siteself b on a.good_id=b.id and b.status='0' where a.site_order_id=? and a.status='0'",
					id);
			rd.set("detailList", list2);
		}
		return list;
	}

	/* 工单关联商品销售 */
	public List<Record> orderVsGoods2017(String siteId, String orderNumber) {
		String table = tableSplitMapper.mapOrder(siteId);
		if (table == null)  {
			return new ArrayList<>();
		}

		List<Record> list = Db.find(
				"select a.id,a.number,a.placing_name,a.placing_order_time,a.status,a.real_amount,a.confirm_amount from crm_goods_siteself_order a left join "  + table + " o on o.id=a.order_id  where a.site_id=? and o.site_id=? and o.number=? order by a.placing_order_time desc",
				siteId, siteId, orderNumber);
		for (Record rd : list) {
			String id = rd.getStr("id");
			List<Record> list2 = Db.find(
					"select a.*,b.site_price,b.source as goodSource,b.stocks from crm_goods_siteself_order_goods_detail a left join crm_goods_siteself b on a.good_id=b.id and b.status='0' where a.site_order_id=? and a.status='0'",
					id);
			rd.set("detailList", list2);
		}
		return list;
	}

	public List<Record> queryTichByOrderId(String siteId, String id) {
		return Db.find("select a.* from  crm_goods_siteself_order_deduct_detail a where a.status='0' and a.site_order_id=? and a.site_id=?", id, siteId);
	}
	
	public List<Record> getHzByOrderId(String siteId, String orderId) {
		// 订单详情
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT b.good_icon, b.`good_name`, b.`good_number`,c.`site_price`,c.employe_price,c.customer_price,b.purchase_num,b.real_amount,b.sales_commissions,b.good_model,b.good_category ");
		sb.append(" FROM crm_goods_siteself_order a ");
		sb.append(" LEFT JOIN crm_goods_siteself_order_goods_detail b ON a.id=b.`site_order_id`");
		sb.append(" LEFT JOIN crm_goods_siteself c ON b.`good_id`=c.`id`");
		sb.append("WHERE a.id=? AND a.site_id=? ");
		List<Record> orderDetailList = Db.find(sb.toString(), orderId, siteId);
		for(Record rd:orderDetailList) {
			String icon = rd.getStr("good_icon");
			if(StringUtils.isNotBlank(icon)) {
				rd.set("good_icon", icon.split(",")[0]);
			}
		}
		return orderDetailList;
	}
	
	

	/**
	 * 订单详情所需数据
	 * 
	 * @return
	 */
	public Map<String, Object> getAllData(String orderId, String siteId) {
		Map<String, Object> map = Maps.newHashMap();
		// 订单总信息
		Record siteOrder = Db.findFirst("select * from crm_goods_siteself_order a where a.site_id=? and a.id=? ", siteId, orderId);

		// 订单详情
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT b.`good_name`,c.`site_price`,c.employe_price,c.customer_price,b.purchase_num,b.real_amount,b.sales_commissions ");
		sb.append(" FROM crm_goods_siteself_order a ");
		sb.append(" LEFT JOIN crm_goods_siteself_order_goods_detail b ON a.id=b.`site_order_id`");
		sb.append(" LEFT JOIN crm_goods_siteself c ON b.`good_id`=c.`id`");
		sb.append("WHERE a.id=? AND a.site_id=? ");
		List<Record> orderDetailList = Db.find(sb.toString(), orderId, siteId);

		List<Record> dataList = Db.find("select a.id,a.good_id,a.good_name from crm_goods_siteself_order_goods_detail a where a.site_order_id=? ", orderId);

		StringBuffer sbdeduct = new StringBuffer();
		sbdeduct.append("SELECT b.id,b.good_id,b.id,c.salesman,c.salesman_id,c.good_id,c.good_name,c.sales_commissions,c.paid_commissions,c.id as deductId");
		sbdeduct.append(" from crm_goods_siteself_order_goods_detail b ");
		sbdeduct.append(" LEFT JOIN  crm_goods_siteself_order_deduct_detail c ON b.id=c.site_order_goods_detail_id ");
		sbdeduct.append(" WHERE b.site_order_id=? AND c.status='0' ");
		List<Record> deductList = Db.find(sbdeduct.toString(), orderId);

		map.put("siteOrder", siteOrder);
		map.put("orderDetailList", orderDetailList);
		map.put("dataList", dataList);
		map.put("deductList", deductList);
		map.put("deductListCount", deductList.size());
		return map;
	}

	@Transactional(rollbackFor = Exception.class)
	public String deleteGoodsOrders(String ids) {
		SQLQuery sqlQueryProfit = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("delete from crm_goods_siteself_order where id in (" + StringUtil.joinInSql(ids.split(",")) + ") and status='0'");// 彻底删除这条订单：王总说的
		sqlQueryProfit.executeUpdate();

		SQLQuery sqlQueryDetail = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("delete from crm_goods_siteself_order_goods_detail where site_order_id in (" + StringUtil.joinInSql(ids.split(",")) + ") and status='0'");// 彻底删除这条订单：王总说的
		sqlQueryDetail.executeUpdate();
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public String confirmOrder(String id) {
		SQLQuery sqlQueryProfit = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("update crm_goods_siteself_order a set a.status='5',a.confirm_time=NOW(),a.confirmor='" + CrmUtils.getUserXM() + "' where a.id='" + id + "' ");
		sqlQueryProfit.executeUpdate();
		return "200";
	}

	// 批量打印
	public List<Record> getPrintDataByIds(String ids, String siteId) {
		List<Record> list = Db.find(
				"select a.confirm_time,a.placing_name,a.placing_order_time,a.status,a.id,a.number,a.customer_name,a.customer_contact,a.customer_address,a.order_id,a.order_number,a.real_amount,a.paid_commissions,a.confirm_amount,a.confirmor,a.cancel_reason,a.creator,a.placing_order_by from crm_goods_siteself_order a where a.id in ("
						+ StringUtil.joinInSql(ids.split(",")) + ") order by a.placing_order_time desc ");
		for (Record rd : list) {
			StringBuilder sf = new StringBuilder();
			sf.append(
					"select a.good_brand,a.good_name,a.purchase_num,b.unit,b.customer_price,a.real_amount from crm_goods_siteself_order_goods_detail a left join crm_goods_siteself b on a.good_id=b.id  where a.status='0' and a.site_id=? and a.site_order_id=? ");
			List<Record> list2 = Db.find(sf.toString(), siteId, rd.getStr("id"));
			rd.set("detailList", list2);
		}
		return list;
	}

	// 修改商品订单
	@Transactional(rollbackFor = Exception.class)
	public String editGoodsOrder(String rowId, String confirmAmount, String status, String gId, Double pNum, String uid, String uname, String salesCommissions, String oneTch,
			String idsArr, String nameArrs, String marks, String commissionsRemarks) {// 服务商权限 订单信息 点击收款按钮确定付款，可以更改实交金额
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String dat = sf.format(now);
		BigDecimal allTc = new BigDecimal(0);
		String[] oneArr = oneTch.split(",");
		for (String my : oneArr) {
			allTc = allTc.add(new BigDecimal(my));
		}
		confirmAmount = confirmAmount.trim();
		if (StringUtils.isBlank(salesCommissions)) {
			salesCommissions = "0";
		}
		Target ta = new Target();

		Record order = Db.findFirst(
				"select a.*,b.site_price as sitePrice from crm_goods_siteself_order a left join crm_goods_siteself b on a.good_id=b.id where a.id=? and a.status in ('2','3') ",
				rowId);
		if (order == null) {
			return "420";
		}
		String delIds = "";
		String delNames = "";
		String[] oldNames = order.getStr("placing_name").split(",");
		int h = 0;
		for (String str : order.getStr("placing_order_by").split(",")) {
			String mark1 = "0";
			for (int j = 0; j < idsArr.split(",").length; j++) {
				if (str.equals(idsArr.split(",")[j])) {
					mark1 = "1";
				}
			}
			if (!"1".equals(mark1)) {
				if ("".equals(delIds)) {
					delIds = "'" + str + "'";
					delNames = oldNames[h];
				} else {
					delIds = delIds + ",'" + str + "'";
					delNames = delNames + "," + oldNames[h];
				}
			}
			h++;
		}
		String logName = CrmUtils.getUserXM();
		ta.setName(logName);// 操作人
		ta.setTime(dat);
		ta.setType(99);
		String content = "";
		BigDecimal oldConfirmAmount = order.getBigDecimal("confirm_amount");// 订单原实收金额
		BigDecimal oldSalesCommissions = order.getBigDecimal("sales_commissions");// 订单原工程师总提成金额
		String oldPlacingOrderBy = order.getStr("placing_order_by");// 订单原销售人员
		String oldMarks = order.getStr("pay_mark") != null ? order.getStr("pay_mark") : "";// 订单原收款备注
		String editMark = "1";
		if (oldConfirmAmount.compareTo(new BigDecimal(confirmAmount)) != 0) {// 等于1表示实收金额没改变，不等于1表示实收金额改变
			content += "修改实收金额为：" + confirmAmount + "元，原实收金额为：" + oldConfirmAmount + "元；";
			editMark = "2";
		}
		if (oldSalesCommissions.compareTo(new BigDecimal(salesCommissions)) != 0) {// 等于1表示工程师提成总金额没改变，不等于1表示工程师提成总金额改变
			content += "修改工程师提成总金额为：" + salesCommissions + "元，原工程师提成总金额为：" + oldSalesCommissions + "元；";
			editMark = "2";
		}
		if (StringUtils.isNotBlank(marks) || StringUtils.isNotBlank(oldMarks)) {
			if (!oldMarks.equals(marks)) {// 修改备注的过程信息
				// content+="修改备注为："+(marks!=null ? marks : "")+"，原备注为："+oldMarks+"；";
				content += "将原备注为" + oldMarks + "修改为" + (marks != null ? marks : "") + "；";
				editMark = "2";
			}
		}
		String edits = "";// 修改
		String adds = "";// 新增
		String deletes = "";// 删除
		for (int q = 0; q < idsArr.split(",").length; q++) {
			String thisTch = oneArr[q];
			Record rdDutail = Db.findFirst("select a.* from crm_goods_siteself_order_deduct_detail a where a.salesman_id ='" + idsArr.split(",")[q] + "' and a.site_order_id='"
					+ rowId + "' and a.status='0' ");
			if (rdDutail != null) {
				BigDecimal thisSalesCommissions = rdDutail.getBigDecimal("sales_commissions");
				if (thisSalesCommissions.compareTo(new BigDecimal(thisTch)) != 0) {// 修改
					// edits+="修改"+rdDutail.getStr("salesman")+"的提成金额为："+thisTch+"元，原提成金额为："+thisSalesCommissions+"元；";
					edits += "将" + rdDutail.getStr("salesman") + "的原提成金额" + thisSalesCommissions + "元修改为" + thisTch + "元；";
				}
			} else {// 新增
				adds += "添加销售人员" + nameArrs.split(",")[q] + "，提成金额为：" + thisTch + "元；";
			}
		}
		if (StringUtils.isNotBlank(delNames)) {// 删除
			deletes += "删除销售人员：" + delNames + "；";
		}
		if (StringUtils.isNotBlank(edits)) {
			content += edits;
			editMark = "2";
		}
		if (StringUtils.isNotBlank(adds)) {
			content += adds;
			editMark = "2";
		}
		if (StringUtils.isNotBlank(deletes)) {
			content += deletes;
			editMark = "2";
		}

		String sqlOrder = "UPDATE crm_goods_siteself_order a SET a.status='3',a.pay_mark='" + marks + "', a.confirm_amount='" + confirmAmount + "',a.sales_commissions='" + allTc
				+ "',a.placing_order_by='" + idsArr + "',a.placing_name='" + nameArrs + "',a.commissions_remarks='" + commissionsRemarks + "' WHERE a.id='" + rowId + "'";
		if ("2".equals(editMark)) {// 如果有修改痕迹
			ta.setContent(logName + content);
			String strs = WebPageFunUtils.appendProcessDetail(ta, order.getStr("edit_detail"));
			sqlOrder = "UPDATE crm_goods_siteself_order a SET a.status='3',a.pay_mark='" + marks + "', a.confirm_amount='" + confirmAmount + "',a.sales_commissions='" + allTc
					+ "',a.placing_order_by='" + idsArr + "',a.placing_name='" + nameArrs + "',a.commissions_remarks='" + commissionsRemarks + "',a.edit_time='" + dat
					+ "',a.edit_detail='" + strs + "' WHERE a.id='" + rowId + "'";
		}
		SQLQuery sqlQuery3 = goodsSiteselfDetailDao.getSession().createSQLQuery(sqlOrder);
		sqlQuery3.executeUpdate();// 更新order表信息
		/*
		 * SQLQuery sqlQuery4 = goodsSiteselfDetailDao.getSession().
		 * createSQLQuery("UPDATE crm_goods_siteself a set a.sales=(a.sales+'" + pNum +
		 * "') WHERE a.status='0' AND a.id='" + gId + "'"); sqlQuery4.executeUpdate();
		 */// 商品库存的调整除去

		Long detailCount = Db.queryLong("select count(*) from crm_goods_siteself_detail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
		if (detailCount > 0) {
			SQLQuery sqlQuery2 = goodsSiteselfDetailDao.getSession().createSQLQuery(
					"update crm_goods_siteself_detail a set a.pay_money='" + confirmAmount + "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.status='0'");
			sqlQuery2.executeUpdate();
		}
		Long detailEmp = Db.queryLong("select count(*) from crm_goods_employe_owndetail a where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='"
				+ order.getStr("site_id") + "' and a.type='1' and a.status='0'");
		if (detailEmp > 0) {
			SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_employe_owndetail a set a.pay_money='" + confirmAmount
					+ "' where a.order_id='" + rowId + "' and a.good_id='" + gId + "' and a.site_id='" + order.getStr("site_id") + "' and a.type='1' and a.status='0'");
			sqlQuery1.executeUpdate();
		}
		List<GoodsSiteSelfOrderDeductDetail> listAdd = Lists.newArrayList();
		;
		Date nowd = new Date();
		for (int i = 0; i < idsArr.split(",").length; i++) {
			String sql = "";
			Record rdc = Db.findFirst("select a.* from crm_goods_siteself_order_deduct_detail a where a.salesman_id ='" + idsArr.split(",")[i] + "' and a.site_order_id='" + rowId
					+ "' and a.status='0'");
			if (rdc != null) {
				sql = "UPDATE crm_goods_siteself_order_deduct_detail a  SET a.sales_commissions ='" + oneTch.split(",")[i] + "'  WHERE a.salesman_id ='" + idsArr.split(",")[i]
						+ "' and a.site_order_id='" + rowId + "' ";
				// list.add(sql);
				SQLQuery sqlQuery9 = goodsSiteselfDetailDao.getSession().createSQLQuery(sql);
				sqlQuery9.executeUpdate();
			} else {
				Record rdUser = Db.findFirst("select a.* from sys_user a where a.id=?", idsArr.split(",")[i]);
				GoodsSiteSelfOrderDeductDetail sodd = new GoodsSiteSelfOrderDeductDetail();
				sodd.setCreateTime(nowd);
				sodd.setCreator(order.getStr("creator"));
				sodd.setGoodName(order.getStr("good_name"));
				sodd.setGoodNumber(order.getStr("good_number"));
				sodd.setSalemanType(rdUser.getStr("user_type"));
				sodd.setSalesCommissions(new BigDecimal(oneTch.split(",")[i]));
				sodd.setSalesman(nameArrs.split(",")[i]);
				sodd.setSalesmanId(idsArr.split(",")[i]);
				sodd.setSiteId(order.getStr("site_id"));
				sodd.setSiteOrderId(rowId);
				sodd.setStatus("0");
				listAdd.add(sodd);
			}
		}

		if (StringUtils.isNotBlank(delIds)) {
			SQLQuery sqlQuery0 = goodsSiteselfDetailDao.getSession()
					.createSQLQuery("update crm_goods_siteself_order_deduct_detail a set a.status='1' where a.salesman_id in(" + delIds + ") and a.site_order_id='" + rowId + "'");
			sqlQuery0.executeUpdate();
		}
		if (listAdd.size() > 0) {
			goodsSiteSelfOrderDeductDetailDao.save(listAdd);
		}
		/*
		 * if(list.size()>0){//jfinal事务不回滚 Db.batch(list, list.size()); }
		 */
		// 更新利润表
		String nameNow = CrmUtils.getUserXM();// 销售人nameArrs;总额：confirmAmount；工程师提成：allTc；成本：
		Double chenben = Double.valueOf(allTc.toString()) + Double.valueOf(order.getBigDecimal("sitePrice").toString()) * pNum;
		Double lr = Double.valueOf(confirmAmount) - chenben;
		if (lr <= 0) {
			lr = Double.valueOf(0);
		}
		SQLQuery sqlQueryPay = goodsSiteselfDetailDao.getSession()
				.createSQLQuery("UPDATE crm_goods_siteself_profit_detail a SET a.confirmor='" + nameNow + "', a.confirm_time=NOW(),a.salesman='" + nameArrs + "',a.gross_sales='"
						+ confirmAmount + "',a.cost_sales='" + chenben + "',a.profit='" + lr + "',a.site_price='"
						+ Double.valueOf(order.getBigDecimal("sitePrice").toString()) * pNum + "' WHERE a.site_id='" + order.getStr("site_id") + "' AND a.site_order_id='"
						+ order.getStr("id") + "' AND a.status='0'");
		sqlQueryPay.executeUpdate();
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public String saveMarks(String orderId, String marks) {
		SQLQuery sqlQuery = goodsSiteselfDetailDao.getSession().createSQLQuery("UPDATE crm_goods_siteself_order a SET a.pay_mark=:payMark WHERE a.id=:orderId");
		sqlQuery.setParameter("payMark", marks);
		sqlQuery.setParameter("orderId", orderId);
		sqlQuery.executeUpdate();
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public Result<T> saveSales(String siteId, Map<String, Object> map, User user) {
		Result<T> rt = new Result<T>();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date dt = null;
		String pdTime = map.get("placingOrderTime").toString().trim() + ":00";// 下单时间
		try {
			dt = format.parse(pdTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (dt == null) {
			rt.setCode("420");
			return rt;
		}
		String[] goodsIds = map.get("goods1Id").toString().split(",");
		String[] salesNum = map.get("goods3Num").toString().split(",");
		String[] sitePrices = map.get("goods5SitePrice").toString().split(",");
		String[] goodsUnit = map.get("goods5Unit").toString().split(",");
		String[] goodsNames = map.get("goods5Name").toString().split(",");
		String[] salesComm = map.get("goods5SalesComm").toString().split(",");
		String[] realAmount = map.get("goods4RealNum").toString().split(",");
		String[] eIds = map.get("eIds").toString().split(",");
		String[] eNames = map.get("eNames").toString().split(",");
		String[] gOneTch = map.get("gOneTch").toString().split(",");
		String[] gOneDrzf = map.get("gOneDrzf").toString().split(",");

		String goodsInfo = "";
		double purchaseNumAll = 0;
		double goodsCost = 0;
		for (int j = 0; j < salesNum.length; j++) {
			if (StringUtils.isBlank(goodsInfo)) {
				goodsInfo = goodsNames[j] + " × " + salesNum[j] + (!"no".equals(goodsUnit[j]) ? goodsUnit[j] : "个");
			} else {
				goodsInfo += "\n" + goodsNames[j] + " × " + salesNum[j] + (!"no".equals(goodsUnit[j]) ? goodsUnit[j] : "个");
			}
			purchaseNumAll = purchaseNumAll + Double.valueOf(salesNum[j]);
			goodsCost = goodsCost + new BigDecimal(salesNum[j]).multiply(new BigDecimal(sitePrices[j])).setScale(2).doubleValue();
		}

		// 生成主订单
		String nowName = CrmUtils.getUserXM();
		// Date dt = new Date();
		String numberAuto = "PO" + DateUtils.formatDate(new Date(), "yyMMddHHmmssSS");
		GoodsSiteselfOrder gsd = new GoodsSiteselfOrder();
		gsd.setNumber(numberAuto);
		gsd.setCustomerName(map.get("customerName").toString());
		gsd.setCustomerContact(map.get("customerMobile").toString());
		gsd.setCustomerAddress(map.get("customerAddress") != null ? map.get("customerAddress").toString() : "");
		gsd.setPurchaseNum(purchaseNumAll);// 购买商品总数
		gsd.setRealAmount(Double.valueOf(map.get("realAmount").toString()));
		gsd.setConfirmAmount(Double.valueOf(map.get("confirmAmount").toString()));
		gsd.setGoodsCost(goodsCost);
		gsd.setPaidCommissions(new BigDecimal(map.get("paidCommissions").toString()));
		gsd.setSalesCommissions(Double.valueOf(map.get("salesCommissions").toString()));
		gsd.setPlacingOrderBy(map.get("empIdsStr").toString());
		gsd.setPlacingName(map.get("empNamesStr").toString());
		gsd.setPlacingOrderTime(dt);
		gsd.setOutstockType("1");
		gsd.setConfirmBy(user.getId());
		gsd.setConfirmor(nowName);
		gsd.setConfirmTime(dt);
		gsd.setOutstockTime(dt);
		gsd.setStatus("3");
		gsd.setSiteId(siteId);
		gsd.setCreator(nowName);
		gsd.setGoodsInfo("（" + goodsInfo + "）");
		gsd.setCreateBy(user.getId());
		siteselfOrderDao.save(gsd);
		logger.info("改版的商品零售-订单编号" + gsd.getNumber() + "数据参数：goodsIds==" + goodsIds + ",goodsNames==" + goodsNames + ",salesNum==" + salesNum + "");
		List<SiteselfOrderGoodsDetail> list = new ArrayList<SiteselfOrderGoodsDetail>();
		List<GoodsSiteselfProfitDetail> listGspd = new ArrayList<GoodsSiteselfProfitDetail>();
		for (int i = 0; i < goodsIds.length; i++) {
			Record rd = Db.findFirst("select a.* from crm_goods_siteself a where a.id=? limit 1 ", goodsIds[i]);
			String numn = salesNum[i];
			String price = sitePrices[i];
			String goodsSalesComm = salesComm[i];
			String realAmountThis = realAmount[i];
			// 销售成本=工程师提成 + 商品成本
			double costSales = Double.valueOf(rd.getBigDecimal("site_price").toString()) * Double.valueOf(numn) + Double.valueOf(goodsSalesComm);
			double profit = Double.valueOf(realAmountThis) - costSales;
			SQLQuery sqlStocks = siteselfOrderDao.getSession().createSQLQuery("update crm_goods_siteself  set stocks=(stocks-" + numn + "),sales=(sales+" + numn + ") where id='"
					+ goodsIds[i] + "' and status='0' and site_id='" + siteId + "'");
			sqlStocks.executeUpdate();

			/* 商品出库明细记录 */
			GoodsSiteselfDetail gsdetail = new GoodsSiteselfDetail();
			gsdetail.setGoodId(goodsIds[i]);
			gsdetail.setGoodNumber(rd.getStr("number"));
			gsdetail.setGoodName(rd.getStr("name"));
			gsdetail.setGoodBrand(rd.getStr("brand"));
			gsdetail.setGoodCategory(rd.getStr("category"));
			gsdetail.setGoodModel(rd.getStr("model"));
			gsdetail.setUnit(rd.getStr("unit"));
			gsdetail.setType("3");
			gsdetail.setSitePrice(rd.getBigDecimal("site_price") != null ? rd.getBigDecimal("site_price") : new BigDecimal(0));
			gsdetail.setEmployePrice(rd.getBigDecimal("employe_price") != null ? rd.getBigDecimal("employe_price") : new BigDecimal(0));
			gsdetail.setCustomerPrice(rd.getBigDecimal("customer_price") != null ? rd.getBigDecimal("customer_price") : new BigDecimal(0));
			gsdetail.setAmount(new BigDecimal(numn));
			gsdetail.setStocks(rd.getBigDecimal("stocks"));
			gsdetail.setApplicant(nowName);
			gsdetail.setApplyTime(dt);
			gsdetail.setConfirmor(nowName);
			gsdetail.setConfirmTime(dt);
			gsdetail.setOrderId(gsd.getId());
			gsdetail.setCreateTime(dt);
			gsdetail.setSiteId(siteId);
			gsdetail.setStatus("0");
			gsdetail.setPayMoney(new BigDecimal(realAmountThis));
			goodsSiteselfDetailDao.save(gsdetail);
			logger.info("siteSelf goods sell(商品改版后-自营商品零售生成出库明细-" + rd.getStr("name") + ",对应订单Id/number：" + gsd.getId() + "/" + gsd.getNumber() + ")--" + numn + ",原"
					+ rd.getStr("name") + "的库存为：" + rd.getBigDecimal("stocks"));

			/* 订单明细表 */
			SiteselfOrderGoodsDetail sogd = new SiteselfOrderGoodsDetail();
			sogd.setSiteOrderId(gsd.getId());
			sogd.setGoodId(goodsIds[i]);
			sogd.setGoodNumber(rd.getStr("number"));
			sogd.setGoodBrand(rd.getStr("brand"));
			sogd.setGoodCategory(rd.getStr("category"));
			sogd.setGoodIcon(rd.getStr("icon"));
			sogd.setGoodName(rd.getStr("name"));
			sogd.setGoodModel(rd.getStr("model"));
			sogd.setGoodSource(rd.getStr("source"));
			sogd.setGoodCost(rd.getBigDecimal("site_price").multiply(new BigDecimal(numn)).setScale(2));
			sogd.setPurchaseNum(new BigDecimal(numn));
			sogd.setGoodAmount(new BigDecimal(numn).multiply(new BigDecimal(price)).setScale(2));
			sogd.setSalesCommissions(new BigDecimal(salesComm[i]));
			sogd.setRealAmount(new BigDecimal(realAmount[i]));
			sogd.setCreateTime(dt);
			sogd.setOutstockType("1");
			sogd.setStatus("0");
			sogd.setSiteId(siteId);
			sogd.setCreator(nowName);
			sogd.setCreateBy(user.getId());
			siteselfOrderGoodsDetailDao.save(sogd);
			list.add(sogd);

			/* 服务商商品收益表 */
			GoodsSiteselfProfitDetail gspd = new GoodsSiteselfProfitDetail();
			gspd.setNumber(RandomUtil.SiteGoodsProfitNumber());
			gspd.setGoodId(goodsIds[i]);
			gspd.setGoodNumber(rd.getStr("number"));
			gspd.setGoodNum(Double.valueOf(numn));
			gspd.setProfit(profit > 0 ? profit : 0.00);// 销售利润
			gspd.setSalesman(map.get("empNamesStr").toString());
			gspd.setCreator(nowName);
			gspd.setCreateTime(dt);
			gspd.setSalesType("0");
			gspd.setSitePrice(rd.getBigDecimal("site_price") != null ? rd.getBigDecimal("site_price").doubleValue() : 0);
			gspd.setCostSales(costSales);// 销售成本
			gspd.setGrossSales(Double.valueOf(realAmountThis));
			gspd.setStatus("0");
			gspd.setConfirmor(nowName);
			gspd.setConfirmTime(dt);
			gspd.setSiteId(siteId);
			gspd.setSiteOrderId(gsd.getId());
			gspd.setSiteOrderGoodsDetailId(sogd.getId());
			gspd.setSiteselfDetailId(gsdetail.getId());
			listGspd.add(gspd);
		}
		goodsSiteselfProfitDetailDao.save(listGspd);// 服务商商品收益

		/* 订单工程师提成明细记录生成 */
		List<GoodsSiteSelfOrderDeductDetail> listGssodd = new ArrayList<GoodsSiteSelfOrderDeductDetail>();
		for (int i = 0; i < goodsIds.length; i++) {
			SiteselfOrderGoodsDetail sogdCopy = (SiteselfOrderGoodsDetail) list.get(i);
			for (int j = 0; j < eIds.length; j++) {
				int m = i * eIds.length + j;
				/* 工程师对应商品生成的销售人员（工程师和信息员）提成明细 */
				GoodsSiteSelfOrderDeductDetail gssodd = new GoodsSiteSelfOrderDeductDetail();
				gssodd.setSiteOrderId(gsd.getId());
				gssodd.setSiteOrderGoodsDetailId(sogdCopy.getId());
				gssodd.setGoodId(sogdCopy.getGoodId());
				gssodd.setGoodNumber(sogdCopy.getGoodNumber());
				gssodd.setGoodName(sogdCopy.getGoodName());
				gssodd.setSalesmanId(eIds[j]);
				gssodd.setSalesman(eNames[j]);
				gssodd.setSalemanType(userDao.get(eIds[j]).getUserType());
				gssodd.setCreateTime(dt);
				gssodd.setStatus("0");
				gssodd.setSiteId(siteId);
				gssodd.setCreator(nowName);
				gssodd.setPaidCommissions(new BigDecimal(gOneDrzf[m]));
				gssodd.setSalesCommissions(new BigDecimal(gOneTch[m]));
				listGssodd.add(gssodd);
			}
		}
		goodsSiteSelfOrderDeductDetailDao.save(listGssodd);
		rt.setCode("200");
		rt.setMsg("success!");
		return rt;
	}

	public Result<T> checkSalesPcLs(Map<String, Object> map, String siteId) {
		Result<T> rt = new Result<T>();
		String[] goodsIds = map.get("goods1Id").toString().split(",");
		String[] salesNum = map.get("goods3Num").toString().split(",");
		String code = "200";
		String errorMsg = "";
		for (int i = 0; i < goodsIds.length; i++) {
			Record rd = Db.findFirst("select a.id,a.stocks,a.name from crm_goods_siteself a where a.id=? and a.status='0' limit 1 ", goodsIds[i]);
			if (rd == null) {
				code = "420";// 商品信息有误
				errorMsg = "商品信息有误！";
				break;
			}
			if (rd.getBigDecimal("stocks").compareTo(new BigDecimal(salesNum[i])) == -1) {// 库存小于零售数量，即库存不足
				code = "421";// 商品信息有误
				errorMsg = "商品“" + rd.getStr("name") + "”库存不足！";
				break;
			}
		}
		rt.setCode(code);
		rt.setErrMsg(errorMsg);
		return rt;
	}

}