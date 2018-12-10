package com.jojowonet.modules.goods.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.entity.OldFitting;
import com.jojowonet.modules.goods.dao.GoodsPlatFormDao;
import com.jojowonet.modules.goods.dao.GoodsPlatformTransferOrderDao;
import com.jojowonet.modules.goods.entity.GoodsPlatform;
import com.jojowonet.modules.goods.service.GoodsPlatFormService;
import com.jojowonet.modules.goods.service.GoodsPlatformTransferOrderService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

/**
 * 平台商品Controller
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/goods/platform")
public class GoodsPlatFormController extends BaseController {

	@Autowired
	private GoodsPlatFormService goodsPlatFormService;
	@Autowired
	private SiteService siteService;
	@Autowired
	private NonServicemanService nonService;
	@Autowired
	private GoodsPlatFormDao goodsPlatFormDao;
	@Autowired
	private GoodsPlatformTransferOrderService goodsPlatformTransferOrderService;

	@Autowired
	private GoodsPlatformTransferOrderDao goodsPlatformTransferOrderDao;

	/**
	 * 平台商品订单（清洁剂、水龙头、除味剂、美的冰箱）
	 */
	@RequestMapping(value = "getAllPlatformOrdersHead")
	public String getAllPlatformOrdersHead(HttpServletRequest request, HttpServletResponse response, Model model) {
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(null, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/goods/platformAllOrdersSys";
	}

	@ResponseBody
	@RequestMapping(value = "getAllPlatformOrders")
	public String getAllPlatformOrders(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsPlatformTransferOrderService.getAllPlatformOrders(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	/**
	 * 公众号产品订单（）
	 */
	@RequestMapping(value = "getPublicNumberOrdersHead")
	public String getPublicNumberOrdersHead(HttpServletRequest request, HttpServletResponse response, Model model) {
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(null, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/goods/publicNumberOrders";
	}

	/**
	 * 公众号无忧保订单（）
	 */
	@RequestMapping(value = "getWarrantyOrderHeader")
	public String getWarrantyOrderHeader(HttpServletRequest request, HttpServletResponse response, Model model) {
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(null, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/goods/warrantyOrder";
	}

	@ResponseBody
	@RequestMapping(value = "getWarrantyOrderList")
	public String getWarrantyOrderList(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsPlatformTransferOrderService.getWarrantyOrderPage(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	@ResponseBody
	@RequestMapping(value = "getPublicNumberOrders")
	public String getPublicNumberOrders(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsPlatformTransferOrderService.getPublicNumberOrders(pages, map);
		return renderJson(new JqGridPage<>(page));
	}

	// 我的商品公司库存表头
	@RequestMapping(value = "WholePlatHeader")
	public String getHeader(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getPlatGoodsCategoryList();
		model.addAttribute("categoryList", listR);// 商品类别
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		if ("7".equals(user.getUserType())) {
			model.addAttribute("isSupplier", "y");
		}
		model.addAttribute("isSysUser", "1".equals(user.getUserType()));
		return "modules/goods/platformManager";
	}

	// 我的商品公司库存信息
	@ResponseBody
	@RequestMapping(value = "getWholePlat")
	public String list(OldFitting oldFitting, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = getParams(request);
		if ("7".equals(user.getUserType())) {
			// 供应商权限下
			map.put("isSupplier", "y");
			map.put("supplierId", user.getId());
		}
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsPlatFormService.getAllSiteInfo(pages, siteId, map);
		return renderJson(new JqGridPage<>(page));
	}

	// 删除平台商品
	@ResponseBody
	@RequestMapping(value = "doSC")
	public String doSC(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		goodsPlatFormService.doSC(id);
		return "ok";
	}

	// 上架
	@ResponseBody
	@RequestMapping(value = "doSJ")
	public String doSJ(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		goodsPlatFormService.doSJ(id);
		return "ok";
	}

	// 下架
	@ResponseBody
	@RequestMapping(value = "doXJ")
	public String doXJ(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		goodsPlatFormService.doXJ(id);
		return "ok";
	}

	// 弹出新增页面
	@RequestMapping(value = "showXZ")
	public Object showXZ(HttpServletRequest request, HttpServletResponse response, Model model) {
		String zNumber = CrmUtils.Spno();
		model.addAttribute("number", "SF" + zNumber);
		List<Record> listR = GoodsCategoryUtil.getPlatGoodsCategoryList();
		model.addAttribute("categoryList", listR);// 商品类别
		// return "modules/goods/mygoodsTC/ptaddsp";
		return "modules/goods/mygoodsTC/addPlatFormGoods";
	}

	// 判断编号是否已存在
	@ResponseBody
	@RequestMapping(value = "isNull")
	public String isNull(HttpServletRequest request, HttpServletResponse response, Model model) {
		String r = "ok";
		String number = request.getParameter("number");
		long result = goodsPlatFormService.getByNumberCount(number);
		if (result >= 1) {
			r = "fal";
		}
		return r;
	}

	// 新增操作
	@ResponseBody
	@RequestMapping(value = "doXZ", method = RequestMethod.POST)
	public Boolean doXZ(HttpServletRequest request, HttpServletResponse response, GoodsPlatform gpf, Model model) {
		String html = request.getParameter("html");
		gpf.setHtml(html);
		/*
		 * String allHtml = request.getParameter("allHtml"); gpf.setAllHtml(allHtml);
		 */
		Map<String, Object> map = getParams(request);
		return goodsPlatFormService.addPlatGoods(gpf, map);
	}

	// 弹出编辑窗口
	@RequestMapping(value = "showBJ")
	public Object showBJ(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		Record gss = goodsPlatFormService.showPTBJ(id);
		List<Record> listR = GoodsCategoryUtil.getPlatGoodsCategoryList();
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str);
			model.addAttribute("count", str.length);
		} else {
			model.addAttribute("count", 0);
		}
		model.addAttribute("categoryList", listR);// 商品类别
		model.addAttribute("platform", gss);
		if ("7".equals(UserUtils.getUser().getUserType())) {
			return "modules/goods/mygoodsTC/ptspSupplier";
		}
		// return "modules/goods/mygoodsTC/pteditsp";
		return "modules/goods/mygoodsTC/editPlatFormGoods";
	}

	// 编辑操作
	@ResponseBody
	@RequestMapping(value = "doBJ", method = RequestMethod.POST)
	public Boolean doBJ(HttpServletRequest request, HttpServletResponse response, GoodsPlatform gss, Model model) {
		String html = request.getParameter("html");
		gss.setHtml(html);
		Map<String, Object> map = getParams(request);
		return goodsPlatFormService.addPlatGoods(gss, map);
	}

	// 编辑操作
	@ResponseBody
	@RequestMapping(value = "show", method = RequestMethod.POST)
	public GoodsPlatform showPlatformGood(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		return goodsPlatFormService.gerPlatformGood(id);
	}

	@ResponseBody
	@RequestMapping(value = "doRuKu")
	public Result<Void> doRuKu(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> map = getParams(request);
		String uname = CrmUtils.getUserXM();
		map.put("uname", uname);
		logger.info("入库操作前库存数量：" + goodsPlatFormDao.get((String) map.get("id")).getStocks() + "||" + goodsPlatFormDao.get((String) map.get("id")).getName() + "【操作数量："
				+ map.get("num"));
		Result<Void> re = goodsPlatFormService.doRuku(map);
		return re;
	}

	@RequestMapping(value = "toSendGoodsPage")
	public String toSendGoodsPage(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		Record order = Db.findFirst("select a.* from crm_goods_platform_customer_order a where a.id=?", id);
		String status = order.getStr("status");
		String sStatus = order.getStr("synchroniz_status");
		String warrantyType = order.getStr("warranty_type");
		order.set("wType", "电子保单");
		order.set("wStatus", "已完成");
		order.set("wSStatus", "未同步");
		if ("1".equals(sStatus)) {
			order.set("wSStatus", "已同步");
		}
		if ("1".equals(warrantyType)) {
			order.set("wType", "纸质保单");
			if ("1".equals(status)) {
				order.set("wStatus", "待发货");
			}
			if ("2".equals(status)) {
				order.set("wStatus", "已发货");
			}
			if ("4".equals(status)) {
				order.set("wStatus", "用户取消");
			}
		}
		model.addAttribute("order", order);
		return "modules/goods/sendGoods";
	}

	@ResponseBody
	@RequestMapping(value = "outStockWarranty")
	public String outStockWarranty(HttpServletRequest request) {
		Map<String, Object> map = getParams(request);
		return goodsPlatFormService.outStockWarranty(map);
	}

	// 商品购买记录导出
	@RequestMapping(value = "exportWarranty")
	public String exportWarranty(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			String goodType = request.getParameter("goodType");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);
			jarray.remove(14);
			jarray.remove(14);
			jarray.remove(14);
			List<Record> list = goodsPlatformTransferOrderService.getWarrantyOrderPage(pages, map).getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					String status = rd.getStr("status");
					String warrantyType = rd.getStr("warranty_type");
					String sStatus = rd.getStr("synchroniz_status");
					rd.set("status", "已完成");
					rd.set("synchroniz_status", "未同步");
					if ("1".equals(sStatus)) {
						rd.set("synchroniz_status", "已同步");
					}
					rd.set("warranty_type", "电子保单");
					if ("1".equals(warrantyType)) {
						rd.set("warranty_type", "纸质保单");
						if ("1".equals(status)) {
							rd.set("status", "待发货");
						}
						if ("2".equals(status)) {
							rd.set("status", "已发货");
						}
						if ("4".equals(status)) {
							rd.set("status", "用户取消");
						}
					}
					rd.set("customer_address", rd.getStr("province") + rd.getStr("city") + rd.getStr("area") + rd.getStr("customer_address"));
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

	@RequestMapping(value = "printOrder")
	public String printOrder(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		model.addAttribute("order", Db.findFirst("select a.* from crm_goods_platform_customer_order a where a.id=?", id));
		return "modules/goods/printWarrantyOrder";
	}

}
