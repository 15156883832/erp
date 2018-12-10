package com.jojowonet.modules.goods.service;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsEmployeOwnDao;
import com.jojowonet.modules.goods.dao.GoodsEmployeOwnDetailDao;
import com.jojowonet.modules.goods.dao.GoodsSiteSelfDao;
import com.jojowonet.modules.goods.dao.GoodsSiteSelfOrderDeductDetailDao;
import com.jojowonet.modules.goods.dao.GoodsSiteselfDetailDao;
import com.jojowonet.modules.goods.dao.GoodsSiteselfProfitDetailDao;
import com.jojowonet.modules.goods.dao.GoodsUsedRecordDao;
import com.jojowonet.modules.goods.dao.SiteselfOrderDao;
import com.jojowonet.modules.goods.entity.GoodsEmployeOwn;
import com.jojowonet.modules.goods.entity.GoodsEmployeOwnDetail;
import com.jojowonet.modules.goods.entity.GoodsSiteSelf;
import com.jojowonet.modules.goods.entity.GoodsSiteSelfOrderDeductDetail;
import com.jojowonet.modules.goods.entity.GoodsSiteselfDetail;
import com.jojowonet.modules.goods.entity.GoodsSiteselfOrder;
import com.jojowonet.modules.goods.entity.GoodsSiteselfProfitDetail;
import com.jojowonet.modules.goods.entity.GoodsUsedRecord;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.dao.GoodsCategoryDao;
import com.jojowonet.modules.order.entity.GoodsCategory;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.RandomUtil;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class GoodsSiteSelfService extends BaseService {

	@Autowired
	private GoodsSiteSelfDao goodsSiteSelfDao;

	@Autowired
	private GoodsSiteselfDetailDao goodsSiteselfDetailDao;

	@Autowired
	private GoodsEmployeOwnDetailDao goodsEmployeOwnDetailDao;

	@Autowired
	private GoodsEmployeOwnDao goodsEmployeOwnDao;

	@Autowired
	private SiteselfOrderDao siteselfOrderDao;

	@Autowired
	private SiteService siteService;
	@Autowired
	private NonServicemanService nonService;

	@Autowired
	private GoodsCategoryDao goodsCategoryDao;

	@Autowired
	private GoodsUsedRecordDao goodsUsedRecordDao;

	@Autowired
	private GoodsSiteselfProfitDetailDao goodsSiteselfProfitDetailDao;

	@Autowired
	private GoodsSiteSelfOrderDeductDetailDao goodsSiteSelfOrderDeductDetailDao;

	// 公司库存信息
	public Page<Record> getAllSiteInfo(Page<Record> page, String siteId, Map<String, Object> map) {
		List<Record> list = goodsSiteSelfDao.getAllSiteInfo(page, siteId, map);
		long count = goodsSiteSelfDao.getCount(siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 商品上架
	public void doSJ(String id) {
		String sql = "update crm_goods_siteself set sell_flag='" + 1 + "' where id='" + id + "'";
		Db.update(sql);
	}

	// 商品下架
	public void doXJ(String id) {
		String sql = "update crm_goods_siteself set sell_flag='" + 2 + "' where id='" + id + "'";
		Db.update(sql);
	}

	// 显示编辑信息
	public Record getGoodsDetail(String id) {
		Record re = Db.findFirst("select a.*,p.good_sign from crm_goods_siteself a left join crm_goods_platform p on a.number=p.number where a.id='" + id + "'");
		return re;
	}

	// 显示编辑信息
	@Transactional(readOnly = false)
	public Record showBJ(String id) {
		Record rds = new Record();
		Record re = Db.findFirst("select a.*,p.good_sign from crm_goods_siteself a left join crm_goods_platform p on a.number=p.number where a.id='" + id + "' and a.brand!='浩泽'");
		if (re != null) {
			String gSign = re.getStr("good_sign");
			if ("LB20180106".equals(gSign) || "LB20180105".equals(gSign) || "BS20180108".equals(gSign) || "BS20180107".equals(gSign) || "CZ20180117".equals(gSign)) {
				re.set("allowEdit", "ok");
			} else {
				re.set("allowEdit", "no");
			}
			rds = re;
		} else {
			rds.set("allowEdit", "ok");
		}
		return rds;
	}

	// 确认出库(领用登记)
	@Transactional(rollbackFor = Exception.class)
	public String doChuKu(Map<String, Object> map) {
		Double num = Double.valueOf(map.get("num").toString());
		Double cnum = Double.valueOf(map.get("cnum").toString());
		Date dt = new Date();
		if (cnum > num) {
			return "noStocks";
		}
		// 工程师库存信息(判断是否已有该商品库存，若有库存则增加数量，否则新增)
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record re = Db.findFirst("select * from crm_goods_siteself where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");// 获取该商品所有信息
		long result = goodsEmployeOwnDao.getByGoodId(map.get("id").toString(), map.get("empId").toString(), site_id);
		if (result > 0) {
			// goodsEmployeOwnDao.LQ(map);
			SQLQuery sqls = goodsEmployeOwnDao.getSession().createSQLQuery("update crm_goods_employe_own set stocks=(stocks+" + map.get("cnum") + "),receives=(receives+"
					+ map.get("cnum") + ") where good_id='" + map.get("id") + "' and employe_id='" + map.get("empId") + "' and site_id='" + site_id + "'");
			sqls.executeUpdate();
		} else {
			GoodsEmployeOwn geo = new GoodsEmployeOwn();
			geo.setGoodId(map.get("id").toString());
			geo.setGoodNumber(re.getStr("number"));
			geo.setEmployeId(map.get("empId").toString());
			geo.setStocks(Double.valueOf(map.get("cnum").toString()));
			geo.setReceives(Double.valueOf(map.get("cnum").toString()));
			geo.setSiteId(site_id);
			geo.setCreateTime(dt);
			goodsEmployeOwnDao.save(geo);
		}
		// 工程师出入库明细
		GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
		geod.setAmount(Double.valueOf(map.get("cnum").toString()));
		geod.setCreateBy(UserUtils.getUser().getId());
		geod.setCreateTime(new Date());
		geod.setEmployeId(map.get("empId").toString());
		geod.setSiteId(site_id);
		geod.setType("1");
		geod.setGoodId(re.getStr("id"));
		geod.setGoodNumber(re.getStr("number"));
		if (map.get("jkMoney") != null) {// 领用登记时工程师的交款金额
			String jkMoney = map.get("jkMoney").toString().trim();
			if (StringUtils.isNotEmpty(jkMoney)) {
				geod.setPayMoney(new BigDecimal(jkMoney));
			}
		}
		goodsEmployeOwnDetailDao.save(geod);
		// 自营商品库存数量减少
		SQLQuery sql2 = goodsEmployeOwnDetailDao.getSession().createSQLQuery("update crm_goods_siteself set stocks=(stocks-" + map.get("cnum") + "),receives=(receives+"
				+ map.get("cnum") + ") where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");
		sql2.executeUpdate();
		logger.info("employe receive goods (工程师领用登记公司库存改变)--" + map.get("cnum"));
		// 服务商出入库明细表新增信息
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setGoodId(map.get("id").toString());
		gsd.setGoodNumber(re.getStr("number"));
		gsd.setGoodName(re.getStr("name"));
		gsd.setGoodBrand(re.getStr("brand"));
		gsd.setGoodModel(re.getStr("model"));
		gsd.setGoodCategory(re.getStr("category"));
		gsd.setUnit(re.getStr("unit"));
		gsd.setType("2");
		if (map.get("jkMoney") != null) {// 领用登记时工程师的交款金额
			String jkMoney = map.get("jkMoney").toString().trim();
			if (StringUtils.isNotEmpty(jkMoney)) {
				gsd.setPayMoney(new BigDecimal(jkMoney));
			}
		}
		gsd.setSitePrice(re.getBigDecimal(("site_price")));
		gsd.setEmployePrice(re.getBigDecimal("employe_price"));
		gsd.setCustomerPrice(re.getBigDecimal("customer_price"));
		gsd.setAmount(BigDecimal.valueOf(Double.valueOf(map.get("cnum").toString())));
		Record rd = Db.findFirst("select * from crm_employe a where a.id='" + map.get("empId").toString() + "'");
		String emName = rd.getStr("name");
		gsd.setApplicant(emName);// 申请人
		gsd.setApplyTime(dt);// 申请时间
		gsd.setConfirmor(CrmUtils.getUserXM());// 操作确认人
		gsd.setConfirmTime(dt); // 操作确认时间
								// 关联商品销售订单number
		gsd.setCreateTime(dt);// 创建时间
		gsd.setSiteId(site_id);
		goodsSiteselfDetailDao.save(gsd);
		logger.info("employe receive goods detail (工程师领用登记生成公司库存出库记录)--" + map.get("cnum"));
		return "ok";
	}

	// 确认出库(工程师自购)
	@Transactional(rollbackFor = Exception.class)
	public String doChuKugm(Map<String, Object> map) {
		Double num = Double.valueOf(map.get("num").toString());
		Double cnum = Double.valueOf(map.get("cnum").toString());
		Date dt = new Date();
		if (cnum > num) {
			return "noStocks";
		}
		// 工程师库存信息(判断是否已有该商品库存，若有库存则增加数量，否则新增)
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record re = Db.findFirst("select * from crm_goods_siteself where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");// 获取该商品所有信息
		long result = goodsEmployeOwnDao.getByGoodId(map.get("id").toString(), map.get("empId").toString(), site_id);
		if (result > 0) {// 有库存
			// goodsEmployeOwnDao.LQ(map);
			SQLQuery sqls = goodsEmployeOwnDao.getSession().createSQLQuery("update crm_goods_employe_own set zg_stocks=(zg_stocks+" + map.get("cnum") + "),zg_total=(zg_total+"
					+ map.get("cnum") + ") where good_id='" + map.get("id") + "' and employe_id='" + map.get("empId") + "' and site_id='" + site_id + "'");
			sqls.executeUpdate();
		} else {// 无库存
			GoodsEmployeOwn geo = new GoodsEmployeOwn();
			geo.setGoodId(map.get("id").toString());
			geo.setGoodNumber(re.getStr("number"));
			geo.setEmployeId(map.get("empId").toString());
			geo.setZgStocks(Double.valueOf(map.get("cnum").toString()));
			geo.setZgTotal(Double.valueOf(map.get("cnum").toString()));
			geo.setSiteId(site_id);
			geo.setCreateTime(dt);
			goodsEmployeOwnDao.save(geo);
		}
		// 工程师出入库明细
		GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
		geod.setAmount(Double.valueOf(map.get("cnum").toString()));
		geod.setCreateBy(UserUtils.getUser().getId());
		geod.setCreateTime(new Date());
		geod.setEmployeId(map.get("empId").toString());
		geod.setSiteId(site_id);
		geod.setType("4");
		geod.setStocksType("1");
		geod.setGoodId(re.getStr("id"));
		geod.setGoodNumber(re.getStr("number"));
		if (map.get("jkMoney") != null) {// 领用登记时工程师的交款金额
			String jkMoney = map.get("jkMoney").toString().trim();
			if (StringUtils.isNotEmpty(jkMoney)) {
				geod.setPayMoney(new BigDecimal(jkMoney));
			}
		}
		goodsEmployeOwnDetailDao.save(geod);
		// 自营商品库存数量减少
		SQLQuery sql2 = goodsEmployeOwnDetailDao.getSession().createSQLQuery("update crm_goods_siteself set stocks=(stocks-" + map.get("cnum") + "),sales=(sales+" + map.get("cnum")
				+ ") where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");
		sql2.executeUpdate();
		logger.info("employe receive goods (工程师领用登记公司库存改变)--" + map.get("cnum"));
		// 服务商出入库明细表新增信息
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setGoodId(map.get("id").toString());
		gsd.setGoodNumber(re.getStr("number"));
		gsd.setGoodName(re.getStr("name"));
		gsd.setGoodBrand(re.getStr("brand"));
		gsd.setGoodModel(re.getStr("model"));
		gsd.setGoodCategory(re.getStr("category"));
		gsd.setUnit(re.getStr("unit"));
		gsd.setType("8");
		if (map.get("jkMoney") != null) {// 领用登记时工程师的交款金额
			String jkMoney = map.get("jkMoney").toString().trim();
			if (StringUtils.isNotEmpty(jkMoney)) {
				gsd.setPayMoney(new BigDecimal(jkMoney));
			}
		}
		gsd.setSitePrice(re.getBigDecimal(("site_price")));
		gsd.setEmployePrice(re.getBigDecimal("employe_price"));
		gsd.setCustomerPrice(re.getBigDecimal("customer_price"));
		gsd.setAmount(BigDecimal.valueOf(Double.valueOf(map.get("cnum").toString())));
		Record rd = Db.findFirst("select * from crm_employe a where a.id='" + map.get("empId").toString() + "'");
		String emName = rd.getStr("name");
		gsd.setApplicant(emName);// 申请人
		gsd.setApplyTime(dt);// 申请时间
		gsd.setConfirmor(CrmUtils.getUserXM());// 操作确认人
		gsd.setConfirmTime(dt); // 操作确认时间
		// 关联商品销售订单number
		gsd.setCreateTime(dt);// 创建时间
		gsd.setSiteId(site_id);
		goodsSiteselfDetailDao.save(gsd);
		logger.info("employe receive goods detail (工程师领用登记生成公司库存出库记录)--" + map.get("cnum"));
		// 生成服务商利润记录
		GoodsSiteselfProfitDetail gspd = new GoodsSiteselfProfitDetail();
		gspd.setStatus("0");
		gspd.setConfirmor(CrmUtils.getUserXM());
		gspd.setConfirmTime(dt);
		if (map.get("jkMoney") != null) {// 自购时工程师的交款金额
			String jkMoney = map.get("jkMoney").toString().trim();
			if (StringUtils.isNotEmpty(jkMoney)) {
				gspd.setGrossSales(Double.valueOf(jkMoney));// 销售总额
			}
		}
		Double dl = Double.valueOf(re.getBigDecimal("site_price").toString()) * Double.valueOf(map.get("cnum").toString());
		gspd.setCostSales(dl);// 销售成本
		gspd.setCreateTime(dt);
		gspd.setConfirmTime(dt);
		gspd.setCreator(CrmUtils.getUserXM());
		gspd.setGoodId(re.getStr("id"));
		gspd.setGoodNumber(re.getStr("number"));
		gspd.setNumber(RandomUtil.SiteGoodsProfitNumber());// 流水号
		if ((gspd.getGrossSales() - dl) > Double.valueOf(0)) {
			gspd.setProfit(gspd.getGrossSales() - dl);// 利润
		} else {
			gspd.setProfit(Double.valueOf("0.00"));
		}
		gspd.setGoodNum(Double.valueOf(map.get("cnum").toString()));
		gspd.setSalesman(CrmUtils.getUserXM());// 销售人姓名
		gspd.setSalesType("1");// 工程师自购
		gspd.setSitePrice(Double.valueOf(re.getBigDecimal("site_price").toString()));
		gspd.setSiteselfDetailId(gsd.getId());
		gspd.setSiteId(site_id);
		goodsSiteselfProfitDetailDao.save(gspd);
		return "ok";
	}

	// 判断该商品是否有订单及状态
	public String checkHave(String siteId, String goodId) {
		String result = "ok";
		String sql = "SELECT g.status FROM  crm_goods_siteself_order g  WHERE g.id IN ( select a.site_order_id from crm_goods_siteself_order_goods_detail a  where a.site_id='"
				+ siteId + "' and a.good_id='" + goodId + "' AND a.site_order_id IS NOT NULL) ";
		List<Record> re = Db.find(sql);
		if (re != null) {
			for (Record r : re) {

				if ("1".equals(r.getStr("status")) || "4".equals(r.getStr("status"))) {
					result = "daiShou";// 该商品有待收款
				} else if ("2".equals(r.getStr("status"))) {
					result = "daiChu";// 该商品有待出库
				}
			}
		}
		return result;
	}

	// 删除商品
	@Transactional(rollbackFor = Exception.class)
	public String doSC(String id) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record rd = Db.findFirst("select * from crm_goods_siteself  a where a.id='" + id + "' and a.status='0' and a.site_id='" + siteId + "'");
		if (rd == null) {
			return "421";// 商品信息有误
		}
		SQLQuery sql1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_siteself set status='" + 1 + "' where id='" + id + "'");
		logger.info("delete siteSelf goods(删除自营商品)");
		sql1.executeUpdate();
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setSiteId(rd.getStr("site_id"));
		gsd.setGoodBrand(rd.getStr("brand"));
		gsd.setGoodCategory(rd.getStr("category"));
		gsd.setGoodId(rd.getStr("id"));
		gsd.setGoodModel(rd.getStr("model"));
		gsd.setGoodName(rd.getStr("name"));
		gsd.setGoodNumber(rd.getStr("number"));
		gsd.setOrderId("");
		gsd.setSitePrice(rd.getBigDecimal("site_price"));
		gsd.setType("4");
		gsd.setUnit(rd.getStr("unit"));
		gsd.setEmployePrice(rd.getBigDecimal("employe_price"));
		gsd.setCustomerPrice(rd.getBigDecimal("customer_price"));
		gsd.setCreateTime(new Date());
		gsd.setConfirmTime(new Date());
		gsd.setConfirmor(CrmUtils.getUserXM());
		gsd.setAmount(rd.getBigDecimal("stocks"));
		goodsSiteselfDetailDao.save(gsd);
		logger.info("delete siteSelf goods detail(删除自营商品明细生成)--" + rd.getBigDecimal("stocks"));
		return "ok";
	}

	// 商品入库
	@Transactional(rollbackFor = Exception.class)
	public String doRuKu(Map<String, Object> map) {
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record re = Db.findFirst("select * from crm_goods_siteself where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");// 获取该商品所有信息
		if (re == null) {
			return "420";// 商品信息有误
		}
		if (map.get("num") == null) {
			return "421";// 入库数量要求大于0
		}
		if (Double.valueOf(map.get("num").toString()) <= 0) {
			return "421";// 入库数量要求大于0
		}
		SQLQuery sqls = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_siteself  set stocks=(stocks+" + map.get("num") + "),site_price=" + map.get("rPrice")
				+ " where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");
		sqls.executeUpdate();
		logger.info("siteSelfGoods instocks（自营商品网点人员手动入库！）--" + map.get("num"));
		// 商品出入库明细表-入库
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setGoodId(map.get("id").toString());
		gsd.setGoodNumber(re.getStr("number"));
		gsd.setGoodName(re.getStr("name"));
		gsd.setGoodBrand(re.getStr("brand"));
		gsd.setGoodModel(re.getStr("model"));
		gsd.setGoodCategory(re.getStr("category"));
		gsd.setUnit(re.getStr("unit"));
		gsd.setType("1");
		gsd.setSitePrice(new BigDecimal(map.get("rPrice").toString()));
		gsd.setEmployePrice(re.getBigDecimal("employe_price"));
		gsd.setCustomerPrice(re.getBigDecimal("customer_price"));
		gsd.setAmount(BigDecimal.valueOf(Double.valueOf(map.get("num").toString())));
		// 申请人
		// 申请时间
		String uname = CrmUtils.getUserXM();
		gsd.setConfirmor(uname);// 操作确认人
		gsd.setApplicant(uname);// 申请人
		gsd.setConfirmTime(new Date()); // 操作确认时间
		// 关联商品销售订单number
		gsd.setCreateTime(new Date());// 创建时间
		gsd.setSiteId(site_id);
		// gsd.setStatus("0");
		goodsSiteselfDetailDao.save(gsd);
		logger.info("siteSelfGoods instocks detail（自营商品网点人员手动入库明细记录生成！）--" + map.get("num"));
		return "ok";
	}

	// 零售(自营商品)
	@Transactional(rollbackFor = Exception.class)
	public void doLS(Map<String, Object> map) {
		Date dt = new Date();
		User user = UserUtils.getUser();
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record re = Db.findFirst("select * from crm_goods_siteself where id='" + map.get("id") + "' and status='0' and site_id='" + site_id + "'");// 获取该商品所有信息
		Double num = Double.valueOf(map.get("lsNum").toString());
		SQLQuery sqls = siteselfOrderDao.getSession().createSQLQuery("update crm_goods_siteself  set stocks=(stocks-" + num + "),sales=(sales+" + num + ") where id='"
				+ map.get("id") + "' and status='0' and site_id='" + site_id + "'");
		sqls.executeUpdate();
		logger.info("siteSelfGoods sell(自营商品零售减库存)--" + num);
		String numberAuto = "PO" + DateUtils.formatDate(new Date(), "yyMMddHHmmssSS");
		String name = "";
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = siteService.getUserSite(user.getId()).getName();
		} else {
			name = nonService.getNonServiceman(user).getName();
		}
		List<GoodsSiteSelfOrderDeductDetail> lt = new ArrayList<>();
		// 订单明细表
		GoodsSiteselfOrder gso = new GoodsSiteselfOrder();
		gso.setSalesCommissions(Double.valueOf(map.get("tichengPrice").toString()));
		gso.setNumber(numberAuto);// 订单编号
		/*
		 * gso.setGoodId(map.get("id").toString());
		 * gso.setGoodNumber(re.getStr("number")); gso.setGoodName(re.getStr("name"));
		 * gso.setGoodIcon(re.getStr("icon")); gso.setGoodBrand(re.getStr("brand"));
		 * gso.setCommissionsRemarks(map.get("commissionsRemarks") != null ?
		 * map.get("commissionsRemarks").toString() : "");
		 * gso.setGoodModel(re.getStr("model"));
		 * gso.setGoodCategory(re.getStr("category"));
		 */
		gso.setCustomerName(map.get("userName").toString());
		gso.setCustomerContact(map.get("mobile").toString());
		gso.setCustomerAddress(map.get("address").toString());
		gso.setPurchaseNum(Double.valueOf(map.get("lsNum").toString()));
		// gso.setGoodAmount(Double.valueOf(map.get("lsPrice").toString()));// 商品金额
		// gso.setGoodSource(re.getStr("source"));// 商品来源
		gso.setCreator(CrmUtils.getUserXM());// 订单创建人姓名
		gso.setCreateBy(user.getId());// 订单创建人userId
		gso.setConfirmTime(dt);
		gso.setConfirmBy(user.getId());// 确认收款人userId
		gso.setConfirmor(name);// 确认收款人姓名
		gso.setRealAmount(Double.valueOf(map.get("ssPrice").toString()));// 交款金额
		gso.setConfirmAmount(Double.valueOf(map.get("ssPrice").toString()));// 实收金额
		String xsNames = map.get("xiaoName").toString();
		String everyTch = map.get("everyTch").toString();
		String[] names = xsNames.split(",");
		String[] everyTchs = everyTch.split(",");
		List<Record> list = Db.find("select a.* from sys_user a where id in(" + StringUtil.joinInSql(names) + ") ");
		String sellNames = "";
		Integer h = 0;
		for (Record rds : list) {
			// 订单提成明细
			String moneyTch = "0";
			if (StringUtils.isNotBlank(everyTchs[h])) {
				moneyTch = everyTchs[h];
			}
			GoodsSiteSelfOrderDeductDetail odd = new GoodsSiteSelfOrderDeductDetail();
			odd.setGoodName(re.getStr("name"));
			;
			odd.setGoodNumber(re.getStr("number"));
			odd.setSalesCommissions(new BigDecimal(moneyTch));// 提成金额
			odd.setSalesmanId(rds.getStr("id"));// 销售人userId
			odd.setCreateTime(dt);
			odd.setCreator(CrmUtils.getUserXM());// 创建人姓名
			odd.setStatus("0");
			odd.setSiteId(site_id);
			String sqlName = "SELECT a.name,u.user_type FROM crm_employe a LEFT JOIN sys_user u ON u.id=a.user_id WHERE a.user_id=? AND a.status='0' AND u.status='0' UNION ALL SELECT a.name,u.user_type FROM `crm_non_serviceman` a LEFT JOIN sys_user u ON u.id=a.user_id WHERE a.user_id=? AND a.status='0' AND u.status='0' ";
			List<Record> pcRd = Db.find(sqlName.toString(), rds.getStr("id"), rds.getStr("id"));
			String nowName = pcRd.get(0).getStr("name");
			String userType = pcRd.get(0).getStr("user_type");
			if ("".equals(sellNames)) {
				sellNames = nowName;
			} else {
				sellNames = sellNames + "," + nowName;
			}
			odd.setSalemanType(userType);// 销售人类型
			odd.setSalesman(nowName);// 销售人姓名
			lt.add(odd);
			h++;
		}
		gso.setPlacingOrderBy(map.get("xiaoName").toString());// 销售人user_id
		gso.setPlacingName(sellNames); // 销售人姓名
		gso.setPlacingOrderTime(dt);
		gso.setStatus("3"); // 订单状态(已完成)
		gso.setSiteId(site_id);
		gso.setOutstockType("1");// 出库方式(公司库存)
		gso.setOutstockTime(dt);

		siteselfOrderDao.save(gso);
		for (GoodsSiteSelfOrderDeductDetail gsodd : lt) {
			gsodd.setSiteOrderId(gso.getId());
		}
		goodsSiteSelfOrderDeductDetailDao.save(lt);
		// 商品出入库明细表
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setGoodId(map.get("id").toString());
		gsd.setGoodNumber(re.getStr("number"));
		gsd.setGoodName(re.getStr("name"));
		gsd.setGoodBrand(re.getStr("brand"));
		gsd.setGoodModel(re.getStr("model"));
		gsd.setGoodCategory(re.getStr("category"));
		gsd.setUnit(re.getStr("unit"));
		gsd.setAmount(BigDecimal.valueOf(Double.valueOf(map.get("lsNum").toString())));
		gsd.setApplicant(CrmUtils.getUserXM()); // 申请人
		gsd.setType("3");
		gsd.setSitePrice(re.getBigDecimal(("site_price")));
		gsd.setEmployePrice(re.getBigDecimal("employe_price"));
		gsd.setCustomerPrice(re.getBigDecimal("customer_price"));
		gsd.setApplyTime(dt); // 申请时间
		gsd.setConfirmor(CrmUtils.getUserXM());// 操作确认人 // 操作确认人
		gsd.setCreateTime(dt); // 操作确认时间
		gsd.setConfirmTime(dt); // 创建时间
		gsd.setSiteId(site_id);
		gsd.setOrderId(gso.getId());
		gsd.setPayMoney(new BigDecimal(gso.getConfirmAmount()));
		goodsSiteselfDetailDao.save(gsd);
		// 服务商利润记录生成
		GoodsSiteselfProfitDetail gspd = new GoodsSiteselfProfitDetail();
		gspd.setStatus("0");
		gspd.setConfirmor(CrmUtils.getUserXM());
		gspd.setConfirmTime(dt);
		if (map.get("jkMoney") != null) {// 自购时工程师的交款金额
			String jkMoney = map.get("jkMoney").toString().trim();
			if (StringUtils.isNotEmpty(jkMoney)) {
				gspd.setGrossSales(Double.valueOf(jkMoney));// 销售总额
			}
		}
		Double emptc = Double.valueOf(map.get("tichengPrice").toString());
		Double dl = Double.valueOf(re.getBigDecimal("site_price").toString()) * Double.valueOf(map.get("lsNum").toString());
		gspd.setCostSales(dl + emptc);// 销售成本
		gspd.setCreateTime(dt);
		gspd.setConfirmTime(dt);
		gspd.setCreator(CrmUtils.getUserXM());
		gspd.setGoodId(re.getStr("id"));
		gspd.setGoodNumber(re.getStr("number"));
		gspd.setNumber(RandomUtil.SiteGoodsProfitNumber());// 流水号
		Double dbsh = Double.valueOf(map.get("ssPrice").toString());// 页面传过来的实收金额

		Double lrje = dbsh - (dl + emptc);// 服务商利润 = 实收金额-销售成本
		if (lrje > Double.valueOf(0)) {
			gspd.setProfit(lrje);// 利润
		} else {
			gspd.setProfit(Double.valueOf("0.00"));
		}
		gspd.setGrossSales(dbsh);// 销售总额=实收金额
		gspd.setGoodNum(Double.valueOf(map.get("lsNum").toString()));
		gspd.setSalesman(sellNames);// 销售人姓名
		gspd.setSalesType("0");// 0服务商商品订单
		gspd.setSitePrice(Double.valueOf(re.getBigDecimal("site_price").toString()));
		gspd.setSiteselfDetailId(gsd.getId());
		gspd.setSiteId(site_id);
		gspd.setSiteOrderId(gso.getId());
		goodsSiteselfProfitDetailDao.save(gspd);

		logger.info("siteSelf goods sell(自营商品零售生成出库明细)--" + map.get("lsNum").toString());
	}

	// 新增
	@Transactional(rollbackFor = Exception.class)
	public String addGoods(GoodsSiteSelf gss, Map<String, Object> map) {
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String newNumber = map.get("number").toString().trim();
		Long count1 = Db.queryLong("select count(*) from crm_goods_siteself a where a.status='0' and a.site_id=? and a.number=? ", site_id, newNumber);
		if (count1 > 0) {
			return "existNumber";
		}
		Long platGoodsNumCount = Db.queryLong("select count(*) from crm_goods_platform a where a.status='0' and a.number=? ", newNumber);
		if (platGoodsNumCount > 0) {
			return "existPlatNumber";
		}
		// 自营商品新增商品
		if (StringUtils.isNotBlank(map.get("gstocks").toString())) {
			gss.setStocks(Double.valueOf(map.get("gstocks").toString()));
		}
		if (StringUtils.isNotBlank(map.get("grebatePrice").toString())) {
			gss.setRebatePrice(Double.valueOf(map.get("grebatePrice").toString()));
		}
		if (StringUtils.isNotBlank(map.get("gnormalDeductAmount").toString())) {
			gss.setNormalDeductAmount(Double.valueOf(map.get("gnormalDeductAmount").toString()));
		}
		gss.setSitePrice(Double.valueOf(map.get("gsitePrice").toString()));
		if (StringUtils.isNotBlank(map.get("gemployePrice").toString())) {
			gss.setEmployePrice(Double.valueOf(map.get("gemployePrice").toString()));
		}
		gss.setCustomerPrice(Double.valueOf(map.get("gcustomerPrice").toString()));

		if (map.get("deductType").toString().equals("1")) {
			gss.setDeductType("1");
			// gss.setNormalDeductAmount(Double.valueOf(map.get("gnormalDeductAmount").toString()));
			gss.setRatioDeductVal(null);
		} else if (map.get("deductType").toString().equals("2")) {
			gss.setDeductType("2");
			// gss.setRatioDeductVal(Integer.valueOf(map.get("ratioDeductVal").toString()));
			gss.setNormalDeductAmount(0);
		}
		/*
		 * if (map.get("gnormalDeductAmount") != null) { gss.setDeductType("1"); } else
		 * {
		 * 
		 * }
		 */
		gss.setStatus("0");
		gss.setSource("1");
		gss.setSiteId(site_id);
		// gss.setSellFlag("2");
		String sfsf = gss.getSellFlag();
		String img = gss.getIcon();
		String imgs1 = gss.getImgs();
		String imgs = gss.getImgs();
		gss.setImgs(imgs);
		gss.setCreateTime(new Date());
		goodsSiteSelfDao.save(gss);
		// 出入库明细表新增信息-入库
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setGoodId(gss.getId());
		gsd.setGoodNumber(gss.getNumber());
		gsd.setGoodName(gss.getName());
		gsd.setGoodBrand(gss.getBrand());
		gsd.setGoodModel(gss.getModel());
		gsd.setGoodCategory(gss.getCategory());
		gsd.setUnit(gss.getUnit());
		gsd.setAmount(BigDecimal.valueOf(Double.valueOf(gss.getStocks())));
		gsd.setType("1");
		gsd.setSitePrice(BigDecimal.valueOf(gss.getSitePrice()));
		gsd.setEmployePrice(BigDecimal.valueOf(gss.getEmployePrice()));
		gsd.setCustomerPrice(BigDecimal.valueOf(gss.getCustomerPrice()));
		String uname = CrmUtils.getUserXM();
		gsd.setApplicant(uname); // 申请人
		gsd.setApplyTime(new Date()); // 申请时间
		gsd.setConfirmor(uname); // 操作确认人
		gsd.setConfirmTime(new Date());// 操作确认时间
		gsd.setCreateTime(new Date()); // 创建时间
		gsd.setSiteId(site_id);
		goodsSiteselfDetailDao.save(gsd);
		logger.info("site add goods (服务商新增商品时生成入库明细记录)--" + gss.getStocks());
		return "ok";
	}

	// 平台商品-转自营
	@Transactional(rollbackFor = Exception.class)
	public Boolean platCastForGoods(GoodsSiteSelf gss, Map<String, Object> map) {
		Date dt = new Date();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		// 自营商品新增商品
		if (StringUtils.isNotEmpty((String) map.get("gstocks"))) {
			gss.setStocks(Double.valueOf(map.get("gstocks").toString()));
		}
		if (StringUtils.isNotEmpty((String) map.get("gnormalDeductAmount"))) {
			gss.setNormalDeductAmount(Double.valueOf(map.get("gnormalDeductAmount").toString()));
		}
		if (StringUtils.isNotEmpty((String) map.get("gsitePrice"))) {
			gss.setSitePrice(Double.valueOf(map.get("gsitePrice").toString()));
		}
		if (StringUtils.isNotEmpty((String) map.get("gemployePrice"))) {
			gss.setEmployePrice(Double.valueOf(map.get("gemployePrice").toString()));
		}
		if (StringUtils.isNotEmpty((String) map.get("gcustomerPrice"))) {
			gss.setCustomerPrice(Double.valueOf(map.get("gcustomerPrice").toString()));
		}
		if (StringUtils.isNotEmpty((String) map.get("grebatePrice").toString())) {
			gss.setRebatePrice(Double.valueOf(map.get("grebatePrice").toString()));
		}
		if (map.get("deductType").toString().equals("1")) {
			gss.setDeductType("1");
			// gss.setNormalDeductAmount(Double.valueOf(map.get("gnormalDeductAmount").toString()));
			gss.setRatioDeductVal(null);
		} else if (map.get("deductType").toString().equals("2")) {
			gss.setDeductType("2");
			// gss.setRatioDeductVal(Integer.valueOf(map.get("ratioDeductVal").toString()));
			gss.setNormalDeductAmount(0);
		}
		gss.setStatus("0");
		gss.setSortNum(1);
		gss.setCreateTime(dt);
		gss.setSource("2");// 商品来源——平台
		if (StringUtils.isNotEmpty((String) map.get("oldCategory"))) {
			if ("插座".equals((String) map.get("oldCategory"))) {
				gss.setSource("1");// 商品来源——完全转为自接，南岛插座特殊处理
			}
		}
		gss.setSiteId(siteId);
		gss.setIcon(map.get("icon").toString());// 商品图片
		Iterator keys = map.keySet().iterator();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			if ("imgs".equals(key)) {
				gss.setImgs(map.get("imgs").toString());// 商品详情图片（多张）
			}
		}
		if ("浩泽家用反渗透直饮机".equals(gss.getName())) {
			gss.setRebateFlag("1");// 特殊商品默认开启折扣价
		}
		if (StringUtils.isNotBlank((String) map.get("jdSellerLink"))) {
			gss.setJdSellerLink(map.get("jdSellerLink").toString());
		}
		if (StringUtils.isNotBlank((String) map.get("tmallSellerLink"))) {
			gss.setTmallSellerLink(map.get("tmallSellerLink").toString());
		}
		goodsSiteSelfDao.save(gss);
		// 出入库明细表新增信息
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setGoodId(gss.getId());
		gsd.setGoodNumber(gss.getNumber());
		gsd.setGoodName(gss.getName());
		gsd.setGoodBrand(gss.getBrand());
		gsd.setGoodModel(gss.getModel());
		gsd.setGoodCategory(gss.getCategory());
		/*
		 * if(StringUtils.isNotBlank(gss.getUnit().split(",")[0])){ }
		 */
		gsd.setUnit(gss.getUnit());
		if (StringUtils.isNotEmpty((String) map.get("gstocks"))) {
			gsd.setAmount(BigDecimal.valueOf(Double.valueOf(gss.getStocks())));
		}
		if (StringUtils.isNotEmpty((String) map.get("gsitePrice"))) {
			gsd.setSitePrice(BigDecimal.valueOf(gss.getSitePrice()));
		}
		if (StringUtils.isNotEmpty((String) map.get("gemployePrice"))) {
			gsd.setEmployePrice(BigDecimal.valueOf(gss.getEmployePrice()));
		}
		if (StringUtils.isNotEmpty((String) map.get("gcustomerPrice"))) {
			gsd.setCustomerPrice(BigDecimal.valueOf(gss.getCustomerPrice()));
		}
		gsd.setType("1");// 类型——入库
		gsd.setApplicant(map.get("userName").toString()); // 申请人
		gsd.setApplyTime(dt); // 申请时间
		gsd.setConfirmor(CrmUtils.getUserXM()); // 操作确认人
		gsd.setConfirmTime(dt); // 操作确认时间
		gsd.setCreateTime(dt); // 创建时间
		gsd.setSiteId(siteId);
		if (map.get("gstocks") != null && StringUtils.isNotBlank(map.get("gstocks").toString())) {
			goodsSiteselfDetailDao.save(gsd);
		}
		return true;
	}

	public long getByNumberCount(String siteId, String number) {
		String sql = "select count(*) from crm_goods_siteself a where a.status='0' and a.site_id='" + siteId + "' and a.number='" + number + "' ";
		return Db.queryLong(sql);
	}

	// 编辑操作
	@Transactional(rollbackFor = Exception.class)
	public String doBJ(GoodsSiteSelf gss, Map<String, Object> map) {
		String html = gss.getHtml();
		String icon = gss.getIcon();
		gss = goodsSiteSelfDao.get(gss.getId());

		Integer loggers = 1;
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String oldNumber = map.get("oldNumber").toString().trim();
		String newNumber = map.get("number").toString().trim();
		String brand = map.get("brand") != null ? map.get("brand").toString().trim() : "";
		String category = map.get("category") != null ? map.get("category").toString().trim() : "";
		if (!oldNumber.equals(newNumber)) {
			Long count1 = Db.queryLong("select count(*) from crm_goods_siteself a where a.status='0' and a.site_id=? and a.number=? ", site_id, newNumber);
			if (count1 > 0) {
				return "existNumber";
			}
			Long platGoodsNumCount = Db.queryLong("select count(*) from crm_goods_platform a where a.status='0' and a.number=? ", newNumber);
			if (platGoodsNumCount > 0) {
				return "existPlatNumber";
			}
		}
		if (!"浩泽家用反渗透直饮机".equals(gss.getName())) {
			if (StringUtils.isNotBlank(map.get("oldStocks").toString())) {
				if (!Double.valueOf(map.get("oldStocks").toString()).equals(gss.getStocks())) {
					return "444";
				}
			}
		}
		gss.setIcon(icon);
		gss.setHtml(html);
		gss.setNumber(newNumber);
		gss.setBrand(brand);
		gss.setCategory(category);
		gss.setModel(map.get("model") != null ? map.get("model").toString().trim() : "");
		gss.setUnit(map.get("unit") != null ? map.get("unit").toString().trim() : "");
		gss.setLocation(map.get("location") != null ? map.get("location").toString().trim() : "");
		gss.setSellFlag(map.get("sellFlag") != null ? map.get("sellFlag").toString().trim() : "1");
		gss.setSortNum(map.get("sortNum") != null ? Integer.valueOf(map.get("sortNum").toString()) : 1);
		gss.setRepairTerm(map.get("repairTerm") != null ? map.get("repairTerm").toString().trim() : "1");
		gss.setName(map.get("name") != null ? map.get("name").toString().trim() : "");
		gss.setJdSellerLink(map.get("jdSellerLink") != null ? map.get("jdSellerLink").toString().trim() : "");
		gss.setTmallSellerLink(map.get("tmallSellerLink") != null ? map.get("tmallSellerLink").toString().trim() : "");
		if (map.containsKey("gstocks")) {
			if (StringUtils.isNotBlank(map.get("gstocks").toString())) {
				gss.setStocks(Double.valueOf(map.get("gstocks").toString()));
			}
		}
		if (map.containsKey("gnormalDeductAmount")) {
			if (StringUtils.isNotBlank(map.get("gnormalDeductAmount").toString())) {
				gss.setNormalDeductAmount(Double.valueOf(map.get("gnormalDeductAmount").toString()));
			}
		}
		if (map.containsKey("grebatePrice")) {
			if (StringUtils.isNotBlank(map.get("grebatePrice").toString())) {
				gss.setRebateFlag("1");
				gss.setRebatePrice(Double.valueOf(map.get("grebatePrice").toString()));
			}
		}
		if (map.containsKey("gsitePrice")) {
			if (StringUtils.isNotBlank(map.get("gsitePrice").toString())) {
				gss.setSitePrice(Double.valueOf(map.get("gsitePrice").toString()));
			}
		}
		if (map.containsKey("gemployePrice")) {
			if (StringUtils.isNotBlank(map.get("gemployePrice").toString())) {
				gss.setEmployePrice(Double.valueOf(map.get("gemployePrice").toString()));
			}
		}
		if (map.get("createTime") != null) {
			if (StringUtils.isNotBlank(map.get("createTime").toString())) {
				// gss.setCreateTime(Date.parse(arg0));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				try {
					Date daten = sdf.parse(map.get("createTime").toString());
					gss.setCreateTime(daten);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}

		gss.setCustomerPrice(Double.valueOf(map.get("gcustomerPrice").toString()));
		if (map.get("deductType") != null) {
			if (map.get("deductType").toString().equals("1")) {
				gss.setDeductType("1");
				// gss.setNormalDeductAmount(Double.valueOf(map.get("gnormalDeductAmount").toString()));
				gss.setRatioDeductVal(null);
			} else if (map.get("deductType").toString().equals("2")) {
				gss.setDeductType("2");
				// gss.setRatioDeductVal(Integer.valueOf(map.get("ratioDeductVal").toString()));
				gss.setRatioDeductVal(map.get("ratioDeductVal") != null ? Integer.valueOf(map.get("ratioDeductVal").toString()) : null);
				gss.setNormalDeductAmount(0);
			}
		}
		gss.setStatus("0");
		if (StringUtils.isNotBlank(map.get("source").toString())) {
			gss.setSource(map.get("source").toString());
		}

		if ("浩泽家用反渗透直饮机".equals(gss.getName())) {
			gss.setNumber(map.get("yuanNumber").toString());
			gss.setSortNum(1);
		}

		if (map.containsKey("rebateFlag")) {
			gss.setRebateFlag(map.get("rebateFlag").toString());// 是否有折扣价
		}

		gss.setSiteId(site_id);
		// gss.setIcon(map.get("icon").toString());
		Iterator keys = map.keySet().iterator();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			if ("imgs".equals(key)) {
				gss.setImgs(map.get("imgs").toString());
			}
		}
		goodsSiteSelfDao.save(gss);
		loggers = 2;
		logger.info("商品" + gss.getName() + "编辑时库存改变,原库存为" + map.get("oldStocks") + ",修改库存为" + map.get("gstocks"));
		/*
		 * StringBuilder sf = new StringBuilder();
		 * sf.append("update crm_goods_siteself a set a."); goodsSiteSelfDao.update("");
		 */
		if (!"浩泽家用反渗透直饮机".equals(gss.getName())) {
			if (StringUtils.isNotBlank(map.get("gstocks").toString()) && StringUtils.isNotBlank(map.get("oldStocks").toString())) {
				if (!Double.valueOf(map.get("gstocks").toString()).equals(Double.valueOf(map.get("oldStocks").toString()))) {
					BigDecimal gstocks = new BigDecimal(map.get("gstocks").toString());
					BigDecimal oldStocks = new BigDecimal(map.get("oldStocks").toString());
					BigDecimal reduce = gstocks.subtract(oldStocks);
					Record rd = Db.findFirst("select * from crm_goods_siteself a where a.id='" + gss.getId() + "'");
					GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
					gsd.setSiteId(rd.getStr("site_id"));
					gsd.setGoodBrand(rd.getStr("brand"));
					gsd.setGoodCategory(rd.getStr("category"));
					gsd.setGoodId(rd.getStr("id"));
					gsd.setGoodModel(rd.getStr("model"));
					gsd.setGoodName(rd.getStr("name"));
					gsd.setGoodNumber(rd.getStr("number"));
					gsd.setSitePrice(rd.getBigDecimal("site_price"));
					gsd.setType("5");
					gsd.setUnit(rd.getStr("unit"));
					gsd.setEmployePrice(rd.getBigDecimal("employe_price"));
					gsd.setCustomerPrice(rd.getBigDecimal("customer_price"));
					gsd.setCreateTime(new Date());
					gsd.setConfirmTime(new Date());
					gsd.setConfirmor(CrmUtils.getUserXM());
					gsd.setAmount(reduce);
					goodsSiteselfDetailDao.save(gsd);// IdGen.uuid()
					// goodsSiteselfDetailDao.update("insert into");
					logger.info("商品" + gss.getName() + "编辑时库存改变,生成明细数量为" + reduce + "loggers应该为2，loggers==" + loggers);
				}
			}
		}
		return "ok";
	}

	// 销售人员提成明细
	public Map<String, Object> getsiteselfOrderDeductDetailList(String siteId, String orderId) {// 网点人员列表
		Map<String, Object> map = Maps.newHashMap();
		List<Record> dataList = Db.find("select a.id,a.good_id,a.good_name from crm_goods_siteself_order_goods_detail a where a.site_order_id=? ", orderId);

		StringBuffer sbdeduct = new StringBuffer();
		sbdeduct.append("SELECT b.id,b.good_id,b.id,c.salesman,c.salesman_id,c.good_id,c.good_name,c.sales_commissions,c.paid_commissions,c.id as deductId");
		sbdeduct.append(" from crm_goods_siteself_order_goods_detail b ");
		sbdeduct.append(" LEFT JOIN  crm_goods_siteself_order_deduct_detail c ON b.id=c.site_order_goods_detail_id ");
		sbdeduct.append(" WHERE b.site_order_id=? AND c.status='0' and b.site_id =? ");
		List<Record> deductList = Db.find(sbdeduct.toString(), orderId, siteId);
		map.put("dataList", dataList);
		map.put("deductList", deductList);
		return map;
	}

	public List<Record> getSiteServiceInfoList(String siteId) {// 网点人员列表
		return Db.find("select a.name,u.id as uId,a.id from crm_non_serviceman a inner join sys_user u on a.user_id=u.id where u.status='0' and a.status='0' and a.site_id='"
				+ siteId + "'");
	}

	public List<Record> getSiteEmployeList(String siteId) {// 服务工程师和网点人员
		return Db.find(
				"select a.name,u.id as uId,a.id from crm_employe a inner join sys_user u on a.user_id=u.id where u.status='0' and a.status='0' and a.site_id='" + siteId + "'");
	}

	public Record getSiteName(String siteId) {// 服务工程师
		return Db.findFirst("select *,a.user_id as uId from crm_site a where a.status='0' and a.id='" + siteId + "'");
	}

	public String checkSelfGoodsNum(String siteId) {
		Long count = Db.queryLong("select count(*) from crm_goods_siteself a where a.status='0' and a.source='1' and a.site_id='" + siteId + "'");
		if (count > 1) {
			return "hide";
		} else {
			return "show";
		}
	}

	/*
	 * public List<Map<String,Object>> goodsAnalyseChild(Page<Map<String,Object>>
	 * page,Map<String,Object> map1){ List<Map<String,Object>> list = new
	 * ArrayList<>(); StringBuilder sf = new StringBuilder(); sf.
	 * append("SELECT a.* FROM crm_site  a LEFT JOIN sys_user u ON a.user_id=u.id WHERE u.status='0' AND a.status='0'"
	 * ); if(map1!=null){ sf.append(getQueryGoodsAnalyse(map1)); }
	 * sf.append(" order by a.create_time asc"); if(page!=null){ sf.append(" limit "
	 * + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
	 * } List<Record> list1 = Db.find(sf.toString()); for(Record rd : list1){
	 * Map<String,Object> map = new HashMap<String, Object>(); map.put("siteName",
	 * rd.getStr("name")); StringBuilder sf1 = new StringBuilder(); StringBuilder
	 * sf2 = new StringBuilder(); StringBuilder sf3 = new StringBuilder(); sf2.
	 * append("select count(*) from crm_goods_siteself_order a where a.site_id='"+rd
	 * .getStr("id")+"'"); if(map1!=null){ sf2.append(getQueryGoodsAnalyse2(map1));
	 * } sf3.
	 * append("select count(*) from crm_order_collections a where a.status='0' and a.site_id='"
	 * +rd.getStr("id")+"'"); if(map1!=null){
	 * sf3.append(getQueryGoodsAnalyse3(map1)); } Long selfGoodsCount = Db.
	 * queryLong("select count(*) from crm_goods_siteself a where a.status='0' and a.site_id='"
	 * +rd.getStr("id")+"'"); Long goodsOrderCount = Db.queryLong(sf2.toString());
	 * Long ewmCount = Db.queryLong(sf3.toString()); map.put("selfGoodsCount",
	 * selfGoodsCount); map.put("goodsOrderCount", goodsOrderCount);
	 * map.put("ewmCount", ewmCount); map.put("address",
	 * rd.getStr("province")+rd.getStr("city")+rd.getStr("area")+rd.getStr("address"
	 * )); list.add(map); } return list; }
	 * 
	 * public Long longCount(Map<String,Object> map){ StringBuilder sf = new
	 * StringBuilder(); sf.
	 * append("select count(*) from  crm_site  a LEFT JOIN sys_user u ON a.user_id=u.id  WHERE u.status='0' AND a.status='0' "
	 * ); if(map!=null){ sf.append(getQueryGoodsAnalyse(map)); } return
	 * Db.queryLong(sf.toString()); }
	 */

	public Page<Record> goodsAnalyse(Page<Record> page, Map<String, Object> map) {
		List<Record> list = goodsAnalyseList(page, map);
		Date now = new Date();
		for (Record rd : list) {
			if (rd.getDate("due_time") == null) {
				rd.set("version", "免费版");
			} else {
				if (rd.getDate("due_time").getTime() >= now.getTime()) {
					rd.set("version", "收费版");
				} else {
					rd.set("version", "免费版");
				}
			}
		}
		page.setList(list);
		page.setCount(longCount(map));
		return page;
	}

	public List<Record> goodsAnalyseList(Page<Record> page, Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT s.id, s.name,s.province,s.city,s.area,s.address,s.due_time,(SELECT COUNT(1) FROM crm_goods_siteself_order WHERE site_id=s.id ");
		sf.append(getQueryGoodsAnalyse3(map));
		sf.append(
				") AS goodsOrder,(SELECT COUNT(1) FROM crm_goods_siteself WHERE site_id=s.id AND `status`='0' ) AS selfGoods,(SELECT COUNT(1) FROM crm_order_collections WHERE site_id=s.id AND `status`='0'");
		sf.append(getQueryGoodsAnalyse2(map));
		sf.append(") AS collections,");
		sf.append(" (SELECT m.name FROM `crm_area_manager` AS m WHERE m.id=s.`area_manager_id`) AS areamanager ");
		sf.append(" FROM crm_site AS s INNER JOIN sys_user AS u ON s.user_id=u.id WHERE s.status='0' AND u.status='0'");
		sf.append(getQueryGoodsAnalyse(map));
		sf.append("ORDER BY s.create_time desc");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		List<Record> list = Db.find(sf.toString());
		/*
		 * for(Record rd : list){
		 * 
		 * if(StringUtils.isNotBlank(rd.getStr("province")) &&
		 * StringUtils.isNotBlank(rd.getStr("city"))){
		 * if(rd.getStr("province").equals(rd.getStr("city"))){
		 * rd.set("address",formatString(rd.getStr("province"))+formatString(rd.getStr(
		 * "area"))+formatString(rd.getStr("address")) ); }else{
		 * rd.set("address",formatString(rd.getStr("province"))+formatString(rd.getStr(
		 * "city"))+formatString(rd.getStr("area"))+formatString(rd.getStr("address"))
		 * ); } }else{
		 * rd.set("address",formatString(rd.getStr("province"))+formatString(rd.getStr(
		 * "city"))+formatString(rd.getStr("area"))+formatString(rd.getStr("address"))
		 * ); } }
		 */
		return list;
	}

	public String formatString(String str) {
		if (StringUtils.isBlank(str)) {
			str = "";
		}
		return str;
	}

	public Long longCount(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT count(*) FROM crm_site AS s INNER JOIN sys_user AS u ON s.user_id=u.id WHERE s.status='0' AND u.status='0'");
		sf.append(getQueryGoodsAnalyse(map));
		return Db.queryLong(sf.toString());
	}

	public String getQueryGoodsAnalyse(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String name = getTrimmedParamValue(map, "name");// 服务工程师
			if (StringUtils.isNotEmpty(name)) {
				sf.append(" and s.name like '%" + name + "%' ");
			}
			if (StringUtils.isNotEmpty(getTrimmedParamValue(map, "area"))) {
				sf.append(" and s.province like '%" + getTrimmedParamValue(map, "area") + "%' ");
			}
		}
		return sf.toString();
	}

	public String getQueryGoodsAnalyse2(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
			if (StringUtils.isNotEmpty(createTimeMin)) {
				sf.append(" and create_time >= '" + createTimeMin + " 00:00:00' ");
			}
			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
			if (StringUtils.isNotEmpty(createTimeMax)) {
				sf.append(" and create_time <= '" + createTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	public String getQueryGoodsAnalyse3(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
			if (StringUtils.isNotEmpty(createTimeMin)) {
				sf.append(" and placing_order_time >= '" + createTimeMin + " 00:00:00' ");
			}
			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
			if (StringUtils.isNotEmpty(createTimeMax)) {
				sf.append(" and placing_order_time <= '" + createTimeMax + " 23:59:59' ");
			}
		}
		return sf.toString();
	}

	private String getParamValue(Map<String, Object> map, String param) {
		Object value = map.get(param);
		return value == null ? null : (map.get(param).toString());
	}

	private String getTrimmedParamValue(Map<String, Object> map, String param) {
		return StringUtils.trim(getParamValue(map, param));
	}

	public GoodsCategory addCategory(String siteId, String category) {
		GoodsCategory gcs = new GoodsCategory();
		Long count = Db.queryLong("select count(*) from crm_goods_category where site_id=? and `status`=0 and `name`=?", siteId, category);
		if (count < 1) {
			gcs.setCreateBy(UserUtils.getUser().getId());
			gcs.setStatus("0");
			gcs.setCreateTime(new Date());
			gcs.setSiteId(siteId);
			gcs.setName(category);
			goodsCategoryDao.save(gcs);
		}
		return gcs;
	}

	public Page<Record> ewmCollectionList(Page<Record> page, Map<String, Object> map) {
		List<Record> list = getEwmCollectionGrid(page, map);
		;
		Long count = getEwmCount(map);
		page.setList(list);
		page.setCount(count);
		return page;

	}

	public List<Record> getEwmCollectionGrid(Page<Record> page, Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT a.*,s.name as siteName FROM `crm_order_collections` a LEFT JOIN crm_site s ON a.site_id=s.id WHERE a.status='0' ");
		sf.append(ewmUqery(map));
		sf.append("order by a.create_time desc ");
		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString());
	}

	public Long getEwmCount(Map<String, Object> map) {
		StringBuilder sf = new StringBuilder();
		sf.append("SELECT count(*) FROM `crm_order_collections` a LEFT JOIN crm_site s ON a.site_id=s.id WHERE a.status='0' ");
		sf.append(ewmUqery(map));
		return Db.queryLong(sf.toString());
	}

	public String ewmUqery(Map<String, Object> ma) {
		StringBuffer sf = new StringBuffer();
		if (StringUtil.checkParamsValid((CharSequence) ma.get("name"))) {
			String name = ma.get("name").toString().trim();
			List<Record> list = Db.find("select * from crm_site where `name` like '%" + name + "%'");
			String ids = "";
			for (Record rd : list) {
				if (StringUtils.isNotBlank(rd.getStr("id"))) {
					if (StringUtils.isBlank(ids)) {
						ids = "'" + rd.getStr("id") + "'";
					} else {
						ids = ids + ",'" + rd.getStr("id") + "'";
					}
				}
			}
			if (StringUtils.isNotBlank(ids)) {
				sf.append(" and a.site_id in (" + ids + ") ");
			} else {
				sf.append(" and a.site_id ='' ");
			}
		}
		if (StringUtil.checkParamsValid((CharSequence) ma.get("createTimeMin"))) {
			sf.append(" and a.create_time >= '" + ma.get("createTimeMin") + " 00:00:00' ");
		}
		if (StringUtil.checkParamsValid((CharSequence) ma.get("createTimeMax"))) {
			sf.append(" and a.create_time <= '" + ma.get("createTimeMax") + " 23:59:59' ");
		}
		return sf.toString();
	}

	public String checkNumberEdit(String id) {
		Record rd = Db.findFirst("select a.* from crm_goods_siteself a where a.id=?", id);
		Long count = Db.queryLong("select count(*) from crm_goods_platform a where a.number=? and a.status='0'", rd.getStr("number"));
		if (count > 0) {
			return "ok";
		}
		return "no";
	}

	public Long getPlatCountNumber(String number) {
		return Db.queryLong("select count(*) from crm_goods_platform a where a.status='0' and a.number=?", number);
	}

	public Page<Record> loadSiteGoodsList(Map<String, Object> map, String siteId, Page<Record> page) {
		if (map.get("pageSize") != null) {
			if (StringUtils.isNotBlank(map.get("pageSize").toString())) {
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = goodsSiteSelfDao.loadSiteGoodsList(map, siteId, page);
		for (Record rd : list) {
			rd.set("firstIcon", "");
			String icons = rd.getStr("icon");
			if (StringUtils.isNotBlank(icons)) {
				rd.set("firstIcon", icons.split(",")[0]);
			}
		}
		Long count = goodsSiteSelfDao.loadSiteGoodsListCount(map, siteId);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	public String checkIfAllowAddGoods(String siteId) {
		Record rd = Db.findFirst("select * from crm_site a where a.status='0' and a.id='" + siteId + "'");
		Long count = Db.queryLong("select count(*) from crm_goods_siteself a where a.site_id=? and a.status='0' and a.source='1' ", siteId);
		Date dueTime = rd.getDate("due_time");
		Date now = new Date();
		if (dueTime == null) {
			if (count >= 2) {
				return "showPop";
			}
		} else {
			if (dueTime.getTime() >= now.getTime()) {
				return "hidePop";
			} else {
				if (count >= 2) {
					return "showPop";
				}
			}
		}
		return "hidePop";
	}

	public String checkGoodsIfExist(String id) {
		Long count = Db.queryLong("select count(*) from crm_goods_siteself a where a.id=? and a.status='0'", id);
		if (count < 1) {
			return "420";
		}
		return "200";
	}

	public Record queryEmpGoodsStocks(String id, String siteId) {
		return Db.findFirst(
				"select e.name as empName,a.*,b.icon as gIcon,b.number as gNumber,b.name as gName,b.brand as gBrand,b.model as gModel,b.category as gCategory,b.id as gId,b.unit as gUnit from crm_goods_employe_own a left join crm_goods_siteself b on a.good_id=b.id and b.site_id=? and b.status='0' left join crm_employe e on e.id=a.employe_id and e.status='0'   where a.id=?",
				siteId, id);
	}

	// 领取返还入库
	@Transactional(rollbackFor = Exception.class)
	public String doReturnGoods(String siteId, String id, String nums) {
		Record geo = Db.findFirst(
				"select e.name as empName,a.*,b.icon as gIcon,b.number as gNumber,b.name as gName,b.brand as gBrand,b.model as gModel,b.category as gCategory,b.id as gId,b.unit as gUnit from crm_goods_employe_own a left join crm_goods_siteself b on a.good_id=b.id and b.site_id=? and b.status='0' left join crm_employe e on e.id=a.employe_id and e.status='0'   where a.id=?",
				siteId, id);
		if (geo == null) {// 无此商品的库存记录
			return "421";
		}
		if (Double.valueOf(geo.getBigDecimal("stocks").toEngineeringString()) < Double.valueOf(nums)) {// 返还数大于库存数的时候
			return "422";
		}
		Record gss = Db.findFirst("select a.* from crm_goods_siteself a where a.status=0 and a.id=? ", geo.getStr("good_id"));
		if (gss == null) {// 服务商没有该商品，商品已经删除
			return "423";
		}
		// 生成工程师商品出库记录
		Date dt = new Date();
		String userId = UserUtils.getUser().getId();
		String nowName = CrmUtils.getUserXM();
		GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
		geod.setAmount(Double.valueOf(nums));
		geod.setCreateBy(userId);
		geod.setCreateTime(dt);
		geod.setEmployeId(geo.getStr("employe_id"));
		geod.setGoodId(geo.getStr("good_id"));
		geod.setGoodNumber(geo.getStr("good_number"));
		geod.setMark("0");
		// geod.setOrderId(orderId);
		// geod.setPayMoney(payMoney);
		geod.setSiteId(siteId);
		geod.setStatus("0");
		geod.setType("3");
		geod.setStocksType("0");
		goodsEmployeOwnDetailDao.save(geod);
		;

		// 生成工程师商品使用记录
		GoodsUsedRecord gud = new GoodsUsedRecord();
		gud.setCheckTime(dt);// 核销时间
		gud.setConfirmor(nowName);// 核销人
		gud.setConfirmorId(userId);// 核销人对应的userId
		gud.setCreateBy(userId);
		gud.setEmployeId(geo.getStr("employe_id"));
		gud.setEmployeName(geo.getStr("empName"));
		gud.setGoodBrand(gss.getStr("brand"));
		gud.setGoodCategory(gss.getStr("category"));
		gud.setGoodIcon(gss.getStr("icon"));
		gud.setGoodId(geo.getStr("good_id"));
		gud.setGoodModel(gss.getStr("model"));
		gud.setGoodName(gss.getStr("name"));
		gud.setGoodNumber(geo.getStr("good_number"));
		gud.setGoodSource(gss.getStr("source"));
		gud.setSiteId(siteId);
		gud.setStatus("2");// 已核销
		gud.setType("1");
		gud.setUsedNum(Double.valueOf(nums));
		gud.setUsedTime(dt);
		gud.setStotcksType("0");// 0-领取库存
		goodsUsedRecordDao.save(gud);

		// 改变工程师商品自有库存
		Query sql = goodsUsedRecordDao.getSession()
				.createSQLQuery("update crm_goods_employe_own a set a.stocks=(a.stocks-'" + nums + "'),a.refunds=(a.refunds+'" + nums + "') where a.id='" + id + "'");
		sql.executeUpdate();

		// 公司库存加，销售数量减
		SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery("update crm_goods_siteself a set a.stocks=(a.stocks+" + nums + "),a.receives=(a.receives-" + nums
				+ ") where a.id='" + geo.getStr("good_id") + "' and a.status='0'");
		sqlQuery1.executeUpdate();

		// 公司出入库明细新增一条入库数据
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setAmount(new BigDecimal(nums));
		gsd.setApplicant(geo.getStr("empName"));
		gsd.setApplyTime(dt);
		gsd.setConfirmor(nowName);
		gsd.setConfirmTime(dt);
		gsd.setCreateTime(dt);
		gsd.setCustomerPrice(gss.getBigDecimal("customer_price"));
		gsd.setEmployePrice(gss.getBigDecimal("employe_price"));
		gsd.setGoodBrand(gss.getStr("brand"));
		gsd.setGoodCategory(gss.getStr("category"));
		gsd.setGoodId(geo.getStr("good_id"));
		gsd.setGoodModel(gss.getStr("model"));
		gsd.setGoodName(gss.getStr("name"));
		gsd.setGoodNumber(geo.getStr("good_number"));
		gsd.setUnit(gss.getStr("unit"));
		gsd.setType("6");
		gsd.setSitePrice(gss.getBigDecimal("site_price"));
		gsd.setSiteId(siteId);
		gsd.setRefundsFlag("0");// 0领取库存返还
		gsd.setStocks(gss.getBigDecimal("stocks"));
		goodsSiteselfDetailDao.save(gsd);
		return "200";
	}

	// 自购返还入库
	@Transactional(rollbackFor = Exception.class)
	public String doReturnGoodsZg(String siteId, String id, String nums, String thMoney) {
		Record geo = Db.findFirst(
				"select e.name as empName,a.*,b.icon as gIcon,b.number as gNumber,b.name as gName,b.brand as gBrand,b.model as gModel,b.category as gCategory,b.id as gId,b.unit as gUnit from crm_goods_employe_own a left join crm_goods_siteself b on a.good_id=b.id and b.site_id=? and b.status='0' left join crm_employe e on e.id=a.employe_id and e.status='0'   where a.id=?",
				siteId, id);
		if (geo == null) {// 无此商品的库存记录
			return "421";
		}
		if (Double.valueOf(geo.getBigDecimal("zg_stocks").toEngineeringString()) < Double.valueOf(nums)) {// 返还数大于库存数的时候
			return "422";
		}
		Record gss = Db.findFirst("select a.* from crm_goods_siteself a where a.status=0 and a.id=? ", geo.getStr("good_id"));
		if (gss == null) {// 服务商没有该商品，商品已经删除
			return "423";
		}
		// 生成工程师商品出库记录
		Date dt = new Date();
		String userId = UserUtils.getUser().getId();
		String nowName = CrmUtils.getUserXM();
		GoodsEmployeOwnDetail geod = new GoodsEmployeOwnDetail();
		geod.setAmount(Double.valueOf(nums));
		geod.setCreateBy(userId);
		geod.setCreateTime(dt);
		geod.setEmployeId(geo.getStr("employe_id"));
		geod.setGoodId(geo.getStr("good_id"));
		geod.setGoodNumber(geo.getStr("good_number"));
		geod.setMark("0");
		// geod.setOrderId(orderId);
		geod.setPayMoney(new BigDecimal(thMoney));// 返还时的退还金额
		geod.setSiteId(siteId);
		geod.setStatus("0");
		geod.setType("3");
		geod.setStocksType("1");// 1-自购库存
		goodsEmployeOwnDetailDao.save(geod);
		;

		// 生成工程师商品使用记录
		GoodsUsedRecord gud = new GoodsUsedRecord();
		gud.setCheckTime(dt);// 核销时间
		gud.setConfirmor(nowName);// 核销人
		gud.setConfirmorId(userId);// 核销人对应的userId
		gud.setCreateBy(userId);
		gud.setEmployeId(geo.getStr("employe_id"));
		gud.setEmployeName(geo.getStr("empName"));
		gud.setGoodBrand(gss.getStr("brand"));
		gud.setGoodCategory(gss.getStr("category"));
		gud.setGoodIcon(gss.getStr("icon"));
		gud.setGoodId(geo.getStr("good_id"));
		gud.setGoodModel(gss.getStr("model"));
		gud.setGoodName(gss.getStr("name"));
		gud.setGoodNumber(geo.getStr("good_number"));
		gud.setGoodSource(gss.getStr("source"));
		gud.setSiteId(siteId);
		gud.setStatus("2");// 已核销
		gud.setType("1");
		gud.setUsedNum(Double.valueOf(nums));
		gud.setUsedTime(dt);
		gud.setStotcksType("1");// 1-自购库存
		goodsUsedRecordDao.save(gud);

		// 改变工程师商品自有库存
		Query sql = goodsUsedRecordDao.getSession()
				.createSQLQuery("update crm_goods_employe_own a set a.zg_stocks=(a.zg_stocks-'" + nums + "'),a.zg_refunds=(a.zg_refunds+'" + nums + "') where a.id='" + id + "'");
		sql.executeUpdate();

		// 公司库存加，销售数量减
		SQLQuery sqlQuery1 = goodsSiteselfDetailDao.getSession().createSQLQuery(
				"update crm_goods_siteself a set a.stocks=(a.stocks+" + nums + "),a.sales=(a.sales-" + nums + ") where a.id='" + geo.getStr("good_id") + "' and a.status='0'");
		sqlQuery1.executeUpdate();

		// 公司出入库明细新增一条入库数据
		GoodsSiteselfDetail gsd = new GoodsSiteselfDetail();
		gsd.setAmount(new BigDecimal(nums));
		gsd.setApplicant(geo.getStr("empName"));
		gsd.setApplyTime(dt);
		gsd.setConfirmor(nowName);
		gsd.setConfirmTime(dt);
		gsd.setCreateTime(dt);
		gsd.setCustomerPrice(gss.getBigDecimal("customer_price"));
		gsd.setEmployePrice(gss.getBigDecimal("employe_price"));
		gsd.setGoodBrand(gss.getStr("brand"));
		gsd.setGoodCategory(gss.getStr("category"));
		gsd.setGoodId(geo.getStr("good_id"));
		gsd.setGoodModel(gss.getStr("model"));
		gsd.setGoodName(gss.getStr("name"));
		gsd.setGoodNumber(geo.getStr("good_number"));
		gsd.setUnit(gss.getStr("unit"));
		gsd.setType("6");
		gsd.setSitePrice(gss.getBigDecimal("site_price"));
		gsd.setSiteId(siteId);
		gsd.setRefundsFlag("1");// 0领取库存返还
		gsd.setStocks(gss.getBigDecimal("stocks"));
		gsd.setPayMoney(new BigDecimal(thMoney));
		goodsSiteselfDetailDao.save(gsd);

		// 服务商利润记录生成
		GoodsSiteselfProfitDetail gspd = new GoodsSiteselfProfitDetail();
		gspd.setStatus("0");
		gspd.setConfirmor(nowName);
		gspd.setConfirmTime(dt);
		Double dl = Double.valueOf(gss.getBigDecimal("site_price").toString()) * Double.valueOf(nums);
		gspd.setGrossSales(Double.valueOf(thMoney));// 退还金额
		gspd.setCostSales(dl);
		Double lrje = Double.valueOf(thMoney) - dl;// 服务商利润 = 退还金额-销售成本
		if (lrje > Double.valueOf(0)) {
			gspd.setProfit(lrje);// 利润
		} else {
			gspd.setProfit(Double.valueOf("0.00"));
		}
		gspd.setCreateTime(dt);
		gspd.setConfirmTime(dt);
		gspd.setCreator(nowName);
		gspd.setGoodId(geo.getStr("good_id"));
		gspd.setGoodNumber(geo.getStr("good_number"));
		gspd.setNumber(RandomUtil.SiteGoodsProfitNumber());// 流水号
		gspd.setGoodNum(Double.valueOf(nums));
		gspd.setSalesman(nowName);// 销售人姓名---自购和自购返还时是网点人员，pc端零售时销售人是选取的人员（网点人员和工程师）
		gspd.setSalesType("2");// 2工程师自购库存返还
		gspd.setSitePrice(Double.valueOf(gss.getBigDecimal("site_price").toString()));
		gspd.setSiteselfDetailId(gsd.getId());
		gspd.setSiteId(siteId);
		goodsSiteselfProfitDetailDao.save(gspd);
		return "200";
	}

	public List<Record> getDefaultSaleGoodsList(String goodsId) {
		return Db.find("select a.* from crm_goods_siteself a where a.id in (" + StringUtil.joinInSql(goodsId.split(","))
				+ ") and a.status='0' and a.sell_flag=1 order by a.sort_num asc,a.create_time desc");
	}

	public List<Record> getSiteGoodsList(String siteId, Map<String, Object> map) {
		StringBuilder sb = new StringBuilder();
		sb.append(
				"select a.id,a.name,a.model,a.category,a.stocks,a.ratio_deduct_val,a.unit,a.customer_price,a.site_price,a.employe_price,a.normal_deduct_amount,a.deduct_type,a.rebate_flag,a.rebate_price from crm_goods_siteself a where a.site_id=? and a.status='0' and a.brand!='浩泽' and a.sell_flag=1 and a.id not in ("
						+ StringUtil.joinInSql(map.get("alreadySelectedIds").toString().split(",")) + ") ");
		if (map.get("goodsName") != null && StringUtils.isNotBlank(map.get("goodsName").toString())) {
			sb.append(" and a.name like '%" + map.get("goodsName") + "%' ");
		}
		sb.append(" order by a.sort_num asc,a.create_time desc ");
		return Db.find(sb.toString(), siteId);
	}

}