package com.jojowonet.modules.goods.web;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.PlatFormOrderDao;
import com.jojowonet.modules.goods.entity.GoodsPlatformOrder;
import com.jojowonet.modules.goods.entity.GoodsSiteselfOrder;
import com.jojowonet.modules.goods.service.GoodsSiteSelfService;
import com.jojowonet.modules.goods.service.PlatFormOrderService;
import com.jojowonet.modules.goods.service.SiteselfOrderService;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SupplierService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.util.TrimMap;
import com.jojowonet.modules.unipay.UniPayOrderServiceFactory;
import com.jojowonet.modules.unipay.core.Order;
import com.jojowonet.modules.unipay.core.OrderContext;
import com.jojowonet.modules.unipay.core.PushOrderResult;
import com.jojowonet.modules.unipay.core.PushOrderStatus;
import com.jojowonet.modules.unipay.core.UnifyOrderService;
import com.jojowonet.modules.unipay.utils.TradeNoUtils;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

/**
 * 平台合作产品订单信息表Controller
 * 
 * @author Ivan
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/goods/platFormOrder")
public class PlatFormOrderController extends BaseController {

	@Autowired
	private SiteselfOrderService siteselfOrderService;

	@Autowired
	private PlatFormOrderService platFormOrderService;

	@Autowired
	private SupplierService supplierService;

	@Autowired
	private PlatFormOrderDao platFormOrderDao;

	@Autowired
	private GoodsSiteSelfService goodsSiteSelfService;
	@Autowired
	private SiteDao siteDao;

	/*
	 * 网点权限平台商品订单信息列表表头字段的获取
	 */
	@RequestMapping(value = "headerList")
	public String getHeaderList(GoodsSiteselfOrder goodsSiteselfOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> records = siteselfOrderService.categoryType(siteId);
		List<Record> rd2 = goodsSiteSelfService.getSiteEmployeList(siteId);// 服务工程师
		List<Record> rd1 = goodsSiteSelfService.getSiteServiceInfoList(siteId);// 网点人员
		model.addAttribute("rd3", siteDao.get(siteId));
		model.addAttribute("rd2", rd2);
		model.addAttribute("rd1", rd1);
		model.addAttribute("categoryType", records);
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = siteselfOrderService.siteselfOrderListHaoze(pages, siteId, map);
		model.addAttribute("page", page);
		model.addAttribute("map", map);
		return "modules/goods/platformOrder";
	}

	/*
	 * 网点权限平台商品订单信息列表表头字段的获取
	 */
	@RequestMapping(value = "headerListMjl")
	public String getHeaderListMjl(GoodsSiteselfOrder goodsSiteselfOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> records = siteselfOrderService.categoryType(siteId);
		List<Record> rd2 = goodsSiteSelfService.getSiteEmployeList(siteId);// 服务工程师
		List<Record> rd1 = goodsSiteSelfService.getSiteServiceInfoList(siteId);// 网点人员
		model.addAttribute("rd3", siteDao.get(siteId));
		model.addAttribute("rd2", rd2);
		model.addAttribute("rd1", rd1);
		model.addAttribute("categoryType", records);
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.platformOrderListMjl(pages, siteId, map);
		model.addAttribute("page", page);
		model.addAttribute("map", map);
		return "modules/goods/mjlOrder";
	}

	@ResponseBody
	@RequestMapping(value = "vipOrder")
	public Object vipOrder(HttpServletRequest request) {
		String orderId = request.getParameter("id");
		Record rec = Db.findFirst("select * from crm_goods_platform_order where id=?", orderId);
		Record siteRec = Db.findFirst("select * from crm_site where id=?", rec.getStr("site_id"));
		rec.set("site_name", siteRec.getStr("name"));
		return rec.getColumns();
	}

	@ResponseBody
	@RequestMapping(value = "vipOrderMod")
	public Object vipOrderModify(HttpServletRequest request) {
		// 修改vip订单，给vip订单添加赠送时长和优惠金额。
		String orderId = request.getParameter("id");
		GoodsPlatformOrder order = platFormOrderService.get(orderId);
		String amount = request.getParameter("amount");
		if (StringUtils.isNotBlank(amount)) {
			order.setDiscountAmount(new BigDecimal(amount));
		} else {
			order.setDiscountAmount(new BigDecimal("0.00"));
		}
		order.setFreeVipTime(Integer.valueOf(request.getParameter("time")));
		platFormOrderService.save(order);
		return order;
	}

	/*
	 * 网点权限平台商品订单信息详细列表的查询
	 */
	@ResponseBody
	@RequestMapping(value = "platformOrderGrid")
	public String getSiteCategoryList(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.platformOrderList(pages, siteId, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * 下单之后点击立即付款ljfk
	 */
	@Deprecated
	@ResponseBody
	@RequestMapping(value = "ljfk")
	public Boolean ljfk(String rowId, HttpServletRequest request, HttpServletResponse response) {
		// String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		// Map<String,Object> map = request.getParameterMap();
		// String pNum1 = ((String[])map.get("pNum"))[0];
		// double pNum=Double.parseDouble(pNum1);
		// String gId = ((String[])map.get("gId"))[0];
		// return platFormOrderService.ljfk(rowId,siteId,gId,pNum, "");
		return false;
	}

	/*
	 * system权限 平台合作商品 订单信息列表表头字段的获取
	 */
	@RequestMapping(value = "platOrderHeaderList")
	public String platOrderHeaderList(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> records = siteselfOrderService.categoryType1();
		List<Record> records1 = platFormOrderService.orderFenpei();
		model.addAttribute("headerData", stf);
		model.addAttribute("categoryType", records);
		model.addAttribute("orderFenpei", records1);
		return "modules/goods/sysPlatformOrder";
	}

	/*
	 * system权限 短信销售记录信息 列表
	 */
	@ResponseBody
	@RequestMapping(value = "msgGrid")
	public String msgGrid(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.msgGrid(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * system权限 未完成短信销售记录信息 列表
	 */
	@ResponseBody
	@RequestMapping(value = "msgGriderror")
	public String msgGriderror(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.msgGriderror(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * system权限 来电弹屏销售记录信息 列表
	 */
	@ResponseBody
	@RequestMapping(value = "bombScreenGrid")
	public String bombScreenGrid(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.bombScreenGrid(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * system权限短信销售记录列表表头字段的获取
	 */
	@RequestMapping(value = "msgHeaderList")
	public String msgHeaderList(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> records = siteselfOrderService.categoryType2();
		model.addAttribute("headerData", stf);
		model.addAttribute("categoryType", records);
		return "modules/goods/shortMsgSales";
	}

	/*
	 * system权限未完成短信销售记录列表表头字段的获取
	 */
	@RequestMapping(value = "msgHeaderListerror")
	public String msgHeaderListerror(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> records = siteselfOrderService.categoryType2();
		model.addAttribute("headerData", stf);
		model.addAttribute("categoryType", records);
		return "modules/goods/shortMsgSalesError";
	}

	/**
	 * system权限下二维码订单
	 */
	@RequestMapping(value = "sysCodeOrder")
	public String sysCodeOrder(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> records = siteselfOrderService.categoryType3();
		model.addAttribute("headerData", stf);
		model.addAttribute("categoryType", records);
		return "modules/goods/qrCodeOrder";
	}

	@ResponseBody
	@RequestMapping(value = "sysCodeOrderList")
	public String sysCodeOrderList(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.qrCodeOrderList(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * system权限弹屏销售记录列表表头字段的获取
	 */
	@RequestMapping(value = "bombScreenHeaderList")
	public String bombScreenHeaderList(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> records = siteselfOrderService.categoryType3();
		model.addAttribute("headerData", stf);
		model.addAttribute("categoryType", records);
		return "modules/goods/bombScreenSales";
	}

	/*
	 * system权限平台商品订单信息详细列表的查询
	 */
	@ResponseBody
	@RequestMapping(value = "platOrderGrid")
	public String platOrderGrid(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.platOrderGrid(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * system权限平台商品订单分配信息详情
	 */
	@ResponseBody
	@RequestMapping(value = "detailSysMsg")
	public Map<String, Object> detailSysMsg(String rowId, String goodId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashedMap();
		List<Record> records = platFormOrderService.supplierPlatgoodsList(goodId);
		Record record = platFormOrderService.detailSysMsg(rowId);
		map.put("record", record);
		map.put("list", records);
		return map;
	}

	/*
	 * system权限平台商品订单信息详情(供应商权限 订单管理 发货弹出框详情)
	 */
	@ResponseBody
	@RequestMapping(value = "detailSysMsg1")
	public Record detailSysMsg1(String rowId, HttpServletRequest request, HttpServletResponse response) {
		return platFormOrderService.detailSysMsg(rowId);
	}

	/*
	 * system权限根据对应的平台商品id查出对应的供应商列表
	 */
	@ResponseBody
	@RequestMapping(value = "supplierPlatgoodsList")
	public List<Record> supplierPlatgoodsList(String goodId, HttpServletRequest request, HttpServletResponse response, Model model) {
		return platFormOrderService.supplierPlatgoodsList(goodId);
	}

	/*
	 * system权限平台合作商品分配页面点击确认分配
	 */
	@ResponseBody
	@RequestMapping(value = "confirmFenpei")
	public Boolean confirmFenpei(String rowId, String supplierId, HttpServletRequest request, HttpServletResponse response) {
		return platFormOrderService.confirmFenpei(rowId, supplierId);
	}

	/*
	 * system权限 来电弹屏 详情
	 */
	@ResponseBody
	@RequestMapping(value = "detailBombScreen")
	public Map<String, Object> detailBombScreen(String rowId, String siteId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashedMap();
		Record record = platFormOrderService.detailBombScreen(rowId, siteId);
		List<Record> records = platFormOrderService.detailBombScreen1(siteId);
		map.put("record", record);
		map.put("list", records);
		return map;
	}

	/*
	 * system权限 来电弹屏 确认发货执行发货
	 */
	@ResponseBody
	@RequestMapping(value = "confirmSendGood")
	public Boolean confirmSendGood(String rowId, String logisticsName, String logisticsNo, String[] serialNoVals, String siteId, HttpServletRequest request,
			HttpServletResponse response) {
		return platFormOrderService.confirmSendGood(rowId, logisticsName, logisticsNo, serialNoVals, siteId);
	}

	/*
	 * 供应商权限 订单管理 表头字段
	 */
	@RequestMapping(value = "orderManageHeaderList")
	public String orderManageHeaderList(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		String supplierId = supplierService.getSupplierByuserId(UserUtils.getUser().getId()).getStr("id");
		Long count1 = platFormOrderService.getSupplyRel(supplierId);
		model.addAttribute("headerData", stf);
		if (count1 > 0) {
			model.addAttribute("showTab", "ok");
		} else {
			model.addAttribute("showTab", "no");
		}
		return "modules/goods/orderManage";
	}

	/*
	 * 供应商权限 订单管理 列表
	 */
	@ResponseBody
	@RequestMapping(value = "orderManageGrid")
	public String orderManageGrid(GoodsPlatformOrder goodsPlatformOrder, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		String userId = UserUtils.getUser().getId();
		String supplierId = supplierService.getSupplierByuserId(userId).getStr("id");
		Page<Record> page = platFormOrderService.orderManageGrid(pages, map, supplierId);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * 供应商权限 订单管理 确认发货执行发货
	 */
	@ResponseBody
	@RequestMapping(value = "confirmSendGoods")
	public Boolean confirmSendGoods(String rowId, String logisticsName, String logisticsNo, String sendgoodDate, HttpServletRequest request, HttpServletResponse response) {
		return platFormOrderService.confirmSendGoods(rowId, logisticsName, logisticsNo, sendgoodDate);
	}

	/*
	 * 供应商权限 订单管理 确认已完成
	 */
	@ResponseBody
	@RequestMapping(value = "confirmEnd")
	public Boolean confirmEnd(String rowId, HttpServletRequest request, HttpServletResponse response) {
		return platFormOrderService.confirmEnd(rowId);
	}

	// 浩泽净水订单导出数据
	@RequestMapping(value = "export")
	public String exportfile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			map.put("pageSize", 10000);
			map.put("pageNo", 1);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<Record> list = siteselfOrderService.siteselfOrderListHaoze(pages, siteId, map).getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					if ("1".equals(rd.getStr("status"))) {
						rd.set("status", "待收款");
					} else if (rd.getStr("status").equals("2")) {
						if (rd.getBigDecimal("purchase_num") != null && rd.getBigDecimal("stocks") != null) {
							if (rd.getBigDecimal("purchase_num").compareTo(rd.getBigDecimal("stocks")) == 1) {
								rd.set("status", "待下单");
							} else {
								rd.set("status", "待出库");
							}
						}
					} else if ("3".equals(rd.getStr("status"))) {
						if ("1".equals(rd.getStr("outstock_type"))) {
							rd.set("status", "已出库");
						} else if ("2".equals(rd.getStr("outstock_type"))) {
							rd.set("status", "已下单");
						}
					} else if ("4".equals(rd.getStr("status"))) {
						rd.set("status", "待收款");
					} else if ("0".equals(rd.getStr("status"))) {
						rd.set("status", "已取消");
					}
					String otType = rd.getStr("outstock_type");
					if ("0".equals(otType)) {
						rd.set("outstock_type", "工程师领取库存");
					}
					if ("1".equals(otType)) {
						rd.set("outstock_type", "公司库存");
					}
					if ("2".equals(otType)) {
						rd.set("outstock_type", "平台发货");
					}
					if ("3".equals(otType)) {
						rd.set("outstock_type", "工程师自购库存");
					}
				}
			}
			new ExportJqExcel("浩泽净水订单" + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 导出数据
	@RequestMapping(value = "exportMjl")
	public String exportfileMjl(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);
			String title = stf.getExcelTitle();
			String fileName = "美洁力订单" + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

			Page<Record> page = platFormOrderService.platformOrderListMjl(pages, siteId, map);
			List<Record> list = page.getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					if ("1".equals(rd.getStr("status"))) {
						rd.set("status", "待收款");
					} else if (rd.getStr("status").equals("2")) {
						if (rd.getBigDecimal("purchase_num") != null && rd.getBigDecimal("stocks") != null) {
							if (rd.getBigDecimal("purchase_num").compareTo(rd.getBigDecimal("stocks")) == 1) {
								rd.set("status", "待下单");
							} else {
								rd.set("status", "待出库");
							}
						}

					} else if ("3".equals(rd.getStr("status"))) {
						if ("1".equals(rd.getStr("outstock_type"))) {
							rd.set("status", "已出库");
						} else if ("2".equals(rd.getStr("outstock_type"))) {
							rd.set("status", "已下单");
						}
					} else if ("4".equals(rd.getStr("status"))) {
						rd.set("status", "待收款");
					} else if ("0".equals(rd.getStr("status"))) {
						rd.set("status", "已取消");
					}
				}
			}
			new ExportJqExcel("美洁力订单" + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/**
	 * 平台商品下单
	 */
	@RequestMapping(value = "createPFOrder")
	@ResponseBody
	public Object createPFOrder(HttpServletRequest request) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String siteSelfOrderId = request.getParameter("rowId");
		String goodsSiteSelfId = request.getParameter("gId");
		String pNum = request.getParameter("pNum");
		String pName = request.getParameter("pName");
		String goodsAmount = request.getParameter("goodsAmount");
		String xdCustomerName = request.getParameter("xdCustomerName");
		String xdCustomerContact = request.getParameter("xdCustomerContact");
		String xdCustomerAddress = request.getParameter("xdCustomerAddress");
		Order order = new Order();
		order.setSubject("平台商品-" + pName);
		if (CrmUtils.isOnlineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(Double.parseDouble(goodsAmount) * 100));
		}
		String outTradeNo = TradeNoUtils.genUniqueNo("pt");
		order.setOutTradeNo(outTradeNo);
		order.setBody(pName + " *" + pNum);

		String payType = request.getParameter("pType");
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(payType);
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/pt/callback/" + payType);
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate 平台订单 order failed");
		}

		Result<GoodsPlatformOrder> ljfk = platFormOrderService.ljfk(siteSelfOrderId, siteId, goodsSiteSelfId, Double.parseDouble(pNum), outTradeNo, xdCustomerName,
				xdCustomerContact, xdCustomerAddress);
		Result<String[]> ret = new Result<>();

		Map<String, Object> response = pushOrderResult.getResponse();
		String qrCodeUrl = (String) response.get("qr_code_url");
		ret.setCode("200");
		if ("421".equals(ljfk.getCode())) {
			ret.setCode("421");
			ret.setData(new String[] { qrCodeUrl, outTradeNo, "" });
		} else {
			ret.setData(new String[] { qrCodeUrl, outTradeNo, ljfk.getData().getNumber() });
		}

		return ret;
	}

	@RequestMapping(value = "export2")
	public String exportfile2(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			String userId = UserUtils.getUser().getId();
			String supplierId = supplierService.getSupplierByuserId(userId).getStr("id");
			Page<Record> page = platFormOrderService.orderManageGrid(pages, map, supplierId);
			List<Record> list = page.getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					if (rd.getStr("status") != null) {
						String source = rd.getStr("status");
						if (source.equals("0")) {
							rd.set("status", "未支付");
						} else if (source.equals("1")) {
							rd.set("status", "待分配确认");
						} else if (source.equals("2")) {
							rd.set("status", "待发货");
						} else if (source.equals("3")) {
							rd.set("status", "已发货");
						} else if (source.equals("4")) {
							rd.set("status", "已完成");
						} else if (source.equals("5")) {
							rd.set("status", "已取消");
						} else {
							rd.set("status", "异常");
						}
					}
				}
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 短信订单导出 */
	@RequestMapping(value = "export1")
	public String export1(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			if ("短信销售记录".equals(title)) {
				list = platFormOrderService.msgGrid(pages, map).getList();
			} else {
				list = platFormOrderService.msgGriderror(pages, map).getList();
			}

			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 弹屏订单导出 */
	@RequestMapping(value = "export3")
	public String export3(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			Page<Record> page = platFormOrderService.bombScreenGrid(pages, map);
			List<Record> list = page.getList();
			jarray.remove(0);
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 二维码订单导出 */
	@RequestMapping(value = "export5")
	public String export5(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			Page<Record> page = platFormOrderService.sysOrderList(pages, map);
			List<Record> list = page.getList();
			jarray.remove(0);
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 弹屏订单导出 */
	@RequestMapping(value = "export4")
	public String export4(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			Page<Record> page = platFormOrderService.platOrderGrid(pages, map);
			List<Record> list = page.getList();
			for (Record rd : list) {
				if ("0".equals(rd.getStr("pay_status"))) {
					rd.set("status", "待支付");
				} else {
					if ("0".equals(rd.getStr("status"))) {
						rd.set("status", "待支付");
					} else if ("1".equals(rd.getStr("status"))) {
						rd.set("status", "待确认");
					} else if ("2".equals(rd.getStr("status"))) {
						rd.set("status", "待发货");
					} else if ("3".equals(rd.getStr("status"))) {
						rd.set("status", "已发货");
					} else if ("4".equals(rd.getStr("status"))) {
						rd.set("status", "已完成");
					} else if ("5".equals(rd.getStr("status"))) {
						rd.set("status", "已取消");
					}
				}
			}
			jarray.remove(0);
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "saveMsg")
	public Object saveMsg(String goId, String xdCustomerName, String xdCustomerContact, String xdCustomerAddress, HttpServletRequest request, HttpServletResponse response) {
		return platFormOrderService.saveMsg(goId, xdCustomerName, xdCustomerContact, xdCustomerAddress);
	}

	/* vip购买订单 */
	/*
	 * 
	 * */
	@RequestMapping(value = "vipOrderHeader")
	public String getVipOrderHeader(GoodsSiteselfOrder goodsSiteselfOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/goods/vipBuyOrder";
	}

	/*
	 * VIP订单信息详细列表的查询
	 */
	@ResponseBody
	@RequestMapping(value = "vipOrderGrid")
	public String getVipOrderGrid(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.vipOrderList(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * 未支付VIP订单信息详细列表的查询
	 */
	@RequestMapping(value = "nopayvipOrderHeader")
	public String getnopayVipOrderHeader(GoodsSiteselfOrder goodsSiteselfOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/goods/nopayvipBuyOrder";
	}

	/*
	 * 未支付VIP订单信息详细列表的查询
	 */
	@ResponseBody
	@RequestMapping(value = "nopayvipOrderGrid")
	public String getnopayVipOrderGrid(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = platFormOrderService.nopayvipOrderList(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/* VIP订单导出 */
	@RequestMapping(value = "exportVipOrder")
	public String exportVipOrder(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = new TrimMap(getParams(request));
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			Page<Record> page = platFormOrderService.vipOrderList(pages, map);
			List<Record> list = page.getList();
			for (Record rd : list) {
				if ("0".equals(rd.getStr("pay_status"))) {
					rd.set("pay_status", "未支付");
				} else if ("1".equals(rd.getStr("pay_status"))) {
					rd.set("pay_status", "已支付");
				} else {
					rd.set("pay_status", "---");
				}
				if ("0".equals(rd.getStr("payment_type"))) {
					rd.set("payment_type", "微信");
				} else if ("1".equals(rd.getStr("payment_type"))) {
					rd.set("payment_type", "支付宝");
				} else {
					rd.set("payment_type", "---");
				}
				String num = "";
				if (rd.getBigDecimal("purchase_num") != null) {
					num = rd.getBigDecimal("purchase_num").toString();
					if ("1.00".equals(num)) {
						rd.set("purchase_num", "一个月");
					}
					if ("6.00".equals(num)) {
						rd.set("purchase_num", "六个月");
					}
					if ("12.00".equals(num)) {
						rd.set("purchase_num", "一年");
					}
					if ("24.00".equals(num)) {
						rd.set("purchase_num", "两年");
					}
					if ("36.00".equals(num)) {
						rd.set("purchase_num", "三年");
					}
				} else {
					rd.set("purchase_num", "");
				}

			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 未支付VIP订单导出 */
	@RequestMapping(value = "exportnopayVipOrder")
	public String exportnopayVipOrder(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = new TrimMap(getParams(request));
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			Page<Record> page = platFormOrderService.nopayvipOrderList(pages, map);
			List<Record> list = page.getList();
			for (Record rd : list) {
				if ("0".equals(rd.getStr("payment_type"))) {
					rd.set("payment_type", "微信");
				} else if ("1".equals(rd.getStr("payment_type"))) {
					rd.set("payment_type", "支付宝");
				} else {
					rd.set("payment_type", "---");
				}
				String num = "";
				if (rd.getBigDecimal("purchase_num") != null) {
					num = rd.getBigDecimal("purchase_num").toString();
					if ("1.00".equals(num)) {
						rd.set("purchase_num", "一个月");
					}
					if ("6.00".equals(num)) {
						rd.set("purchase_num", "六个月");
					}
					if ("12.00".equals(num)) {
						rd.set("purchase_num", "一年");
					}
					if ("24.00".equals(num)) {
						rd.set("purchase_num", "两年");
					}
					if ("36.00".equals(num)) {
						rd.set("purchase_num", "三年");
					}
				} else {
					rd.set("purchase_num", "");
				}

			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

}
