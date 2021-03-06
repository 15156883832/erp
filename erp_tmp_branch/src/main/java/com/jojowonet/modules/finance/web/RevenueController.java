package com.jojowonet.modules.finance.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.service.Order2017Service;
import com.jojowonet.modules.order.service.OrderService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.form.EmployeCostAll;
import com.jojowonet.modules.finance.form.EmployeCostGoodsAll;
import com.jojowonet.modules.finance.form.OrderExcel;
import com.jojowonet.modules.finance.form.OrderJSCount;
import com.jojowonet.modules.finance.form.OrderJSEmpCount;
import com.jojowonet.modules.finance.service.FinanceOrderExcelService;
import com.jojowonet.modules.finance.service.RevenueService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.OrderOriginService;
import com.jojowonet.modules.order.service.SiteSettlementService;
import com.jojowonet.modules.order.utils.BrandUtils;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.ExcelUtilsEx;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportExcel;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "${adminPath}/finance/revenue")
public class RevenueController extends BaseController {

	@Autowired
	private RevenueService revenueService;
	@Autowired
	private FinanceOrderExcelService financeOrderExcelService;
	@Autowired
	private OrderOriginService orderOriginServicce;

	@Autowired
	SiteSettlementService siteSettlementService;
	@Autowired
	Order2017Service order2017Service;
	@Autowired
	OrderService orderService;

	@RequestMapping(value = "order")
	public String orderIndex(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		model.addAttribute("listorigin", listOrigin);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		Map<String, Object> map = getParams(request);
		model.addAttribute("headerData", stf);
		List<Record> employeList = financeOrderExcelService.getEmployeList(siteId);// 获取服务工程师列表
//		String[] str = new String[employeList.size()];
		String createT = DateUtils.formatDate(new Date(), "yyyy");
		/*
		 * if (employeList.size() > 0) { for (int i = 0; i < employeList.size(); i++) {
		 * str[i] = employeList.get(i).getStr("name"); } }
		 */
		if (map.get("repairTimeMin") != null) {

		} else {
			map.put("repairTimeMin", createT + "-01-01");
		}
		if (map.get("repairTimeMax") != null) {

		} else {
			map.put("repairTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		model.addAttribute("employeList", employeList);
		model.addAttribute("map", map);
		model.addAttribute("firstDate", createT + "-01-01");
		model.addAttribute("lastDate", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		return "modules/finance/orderIndex";
	}

	@RequestMapping(value = "orderJSCount")
	public String orderJSCount(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		model.addAttribute("listorigin", listOrigin);
		//SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		Map<String, Object> map = getParams(request);
	//	model.addAttribute("headerData", stf);
		List<Record> employeList = financeOrderExcelService.getEmployeList(siteId);// 获取服务工程师列表
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		String createT1 = DateUtils.formatDate(new Date(), "yyyy");
		if (map.get("endTimeMin") != null) {

		} else {
			map.put("endTimeMin", createT + "-01");
		}
		if (map.get("endTimeMax") != null) {

		} else {
			map.put("endTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		if (map.get("repairTimeMin") != null) {

		} else {
			map.put("repairTimeMin", createT1 + "-01-01");
		}
		if (map.get("repairTimeMax") != null) {

		} else {
			map.put("repairTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		model.addAttribute("employeList", employeList);
		model.addAttribute("map", map);
		model.addAttribute("endTimeMin", createT);
		model.addAttribute("endTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		return "modules/finance/orderJSCountIndex";
	}

	@RequestMapping(value = "toEmpJSCount")
	public String toEmpJSCount(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		model.addAttribute("listorigin", listOrigin);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		Map<String, Object> map = getParams(request);
		model.addAttribute("headerData", stf);
		List<Record> employeList = financeOrderExcelService.getEmployeList(siteId);// 获取服务工程师列表
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		String createT1 = DateUtils.formatDate(new Date(), "yyyy");
		if (map.get("endTimeMin") != null) {

		} else {
			map.put("dtType", "2");
			map.put("endTimeMin", createT + "-01");
		}
		if (map.get("endTimeMax") != null) {

		} else {
			map.put("dtType", "2");
			map.put("endTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		if (map.get("repairTimeMin") != null) {

		} else {
			map.put("repairTimeMin", createT1 + "-01-01");
		}
		if (map.get("repairTimeMax") != null) {

		} else {
			map.put("repairTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		model.addAttribute("employeList", employeList);
		model.addAttribute("map", map);
		model.addAttribute("endTimeMin", createT);
		model.addAttribute("endTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		Page<Record> page = new Page<Record>(request, response);
		page = revenueService.getEmpJSCountPage(page, map, siteId);
		model.addAttribute("page", page);
		return "modules/finance/empJSCount";
	}

	@RequestMapping(value = "goods")
	public String goodsIndex(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String placingName = request.getParameter("placingName");
		String poTime = request.getParameter("placingOrderTime");
		String poTime1 = request.getParameter("placingOrderTime1");
		List<Record> placingNameList = financeOrderExcelService.getPlacingNameList(siteId);
		String[] str = new String[placingNameList.size()];
		if (placingNameList.size() > 0) {
			for (int i = 0; i < placingNameList.size(); i++) {
				str[i] = placingNameList.get(i).getStr("placing_name");
			}
		}
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		if (placingName == null || placingName.equals("")) {
			model.addAttribute("repairTimeMin", createT + "-01");
		}
		List<Record> listR = GoodsCategoryUtil.getSiteGoodsCategoryList(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("listorigin", listR);// 商品类别
		model.addAttribute("headerData", stf);
		model.addAttribute("placingName", placingName);
		model.addAttribute("poTime", poTime);
		model.addAttribute("poTime1", poTime1);
		model.addAttribute("placingNameList", str);
		return "modules/finance/goodsIndex";
	}

	@RequestMapping(value = "orderList")
	@ResponseBody
	public String orderList(HttpServletRequest request, HttpServletResponse response) {
		// Page<Record> page = new Page<>(request, response);
		Map<String, Object> map = getParams(request);
		String siteId = String.valueOf(map.get("siteId"));
		if ("null".equals(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			map.put("siteId", siteId);
		}
		Page<Record> recordPage = new Page<>(request, response);
		Page<Record> page = revenueService.findOrder(recordPage, map);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@ResponseBody
	@RequestMapping(value = "getOrderJSCountList")
	public Map<String, Object> getOrderJSCountList(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		return revenueService.getOrderJSCountList(siteId, map);
	}

	@RequestMapping(value = "orderListCountMoney")
	@ResponseBody
	public Record orderListCountMoney(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = getParams(request);
		String siteId = String.valueOf(map.get("siteId"));
		if ("null".equals(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			map.put("siteId", siteId);
		}
		return revenueService.orderListCountMoney(map, "");
	}
	
	@RequestMapping(value = "getGoodsTotal")
	@ResponseBody
	public Record getGoodsTotal(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = getParams(request);
		String siteId = String.valueOf(map.get("siteId"));
		if (StringUtil.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		return revenueService.getGoodsTotal(map, siteId);
	}

	@RequestMapping(value = "goodsList")
	@ResponseBody
	public String goodsList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Record> page;
		Map<String, Object> map = getParams(request);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		page = revenueService.findGoods(new Page<Record>(request, response), map,siteId);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@RequestMapping(value = "order/export")
	public String exportfileorder(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			// jarray.remove(26);
			jarray.remove(0);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

			Page<Record> page = revenueService.findOrder(pages, map);
			List<Record> list = page.getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					if ("1".equals(rd.getStr("warranty_type"))) {
						rd.set("warranty_type", "保内");
					} else if ("2".equals(rd.getStr("warranty_type"))) {
						rd.set("warranty_type", "保外");
					} else if ("3".equals(rd.getStr("warranty_type"))) {
						rd.set("warranty_type", "保外转保内");
					} else {
						rd.set("warranty_type", "其他");
					}
					if (rd.getStr("appliance_brand") != null && rd.getStr("appliance_category") == null) {
						rd.set("appliance_category", rd.getStr("appliance_brand"));
					} else if (rd.getStr("appliance_brand") == null && rd.getStr("appliance_category") != null) {
						rd.set("appliance_category", rd.getStr("appliance_category"));
					} else if (rd.getStr("appliance_brand") != null && rd.getStr("appliance_category") != null) {
						rd.set("appliance_category", rd.getStr("appliance_brand") + rd.getStr("appliance_category"));
					} else {
						rd.set("appliance_category", "");
					}

					if (rd.getBigDecimal("serve_cost") == null) {
						rd.set("serve_cost", new BigDecimal(0));
					}
					if (rd.getBigDecimal("auxiliary_cost") == null) {
						rd.set("auxiliary_cost", new BigDecimal(0));
					}
					if (rd.getBigDecimal("warranty_cost") == null) {
						rd.set("warranty_cost", new BigDecimal(0));
					}
					rd.set("costs", rd.getBigDecimal("serve_cost").add(rd.getBigDecimal("auxiliary_cost")).add(rd.getBigDecimal("warranty_cost")));

					if (rd.getStr("whether_collection").equals("0")) {
						rd.set("whether_collection", "否");
					} else if (rd.getStr("whether_collection").equals("1")) {
						rd.set("whether_collection", "是");
					} else {
						rd.set("whether_collection", "未知");
					}

					if (StringUtils.isBlank(rd.getStr("settlement_time"))) {
						rd.set("settlementTime", "否");
					} else {
						rd.set("settlementTime", "是");
					}
					if ("1".equals(rd.getStr("order_type"))) {
						rd.set("order_type", "ERP系统录入");
					} else if ("2".equals(rd.getStr("order_type"))) {
						rd.set("order_type", "美的厂家系统");
					} else if ("3".equals(rd.getStr("order_type"))) {
						rd.set("order_type", "惠而浦厂家系统");
					} else if ("4".equals(rd.getStr("order_type"))) {
						rd.set("order_type", "海信厂家系统");
					} else if ("5".equals(rd.getStr("order_type"))) {
						rd.set("order_type", "海尔厂家系统");
					} else {
						rd.set("order_type", "其他");
					}

					if ("i".equals(rd.getStr("type"))) {
						rd.set("type", "整数");
					} else {
						rd.set("type", "实数");
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

	@RequestMapping(value = "goods/export")
	public String exportfilegoods(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			/*
			 * JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			 * jarray.remove(0);
			 */
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

			Page<Record> page = revenueService.findGoods(pages, map, siteId);
			List<Record> list = page.getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					BigDecimal real_amount = rd.getBigDecimal("real_amount");
					BigDecimal confirm_amount = rd.getBigDecimal("confirm_amount");
					BigDecimal sales = rd.getBigDecimal("sales_commissions");
					BigDecimal goods_cost = rd.getBigDecimal("goods_cost");
					rd.set("shortNeedMoney", real_amount.subtract(confirm_amount));
					rd.set("realProfit", confirm_amount.subtract(sales).subtract(goods_cost));
					rd.set("salesProfit", real_amount.subtract(sales).subtract(goods_cost));
					List<Record> rds = rd.get("good_name");
					String good_name = "";
					if (rds.size() > 0) {
						for (Record as : rds) {
							good_name += "【" + as.getStr("good_name") + " * " + as.getBigDecimal("purchase_num") + " " + as.getBigDecimal("good_amount") + "】";
						}
					}
					rd.set("good_name", good_name);
					if ("i".equals(rd.getStr("type"))) {
						rd.set("type", "整数");
					} else {
						rd.set("type", "实数");
					}

					if ("2".equals(rd.getStr("jkstatus"))) {
						rd.set("jkstatus", "是");
					} else if ("3".equals(rd.getStr("jkstatus"))) {
						rd.set("jkstatus", "是");
					} else {
						rd.set("jkstatus", "否");
					}
					if (rd.getDate("outstock_time") != null) {
						rd.set("ifOutstocks", "是");
					} else {
						rd.set("ifOutstocks", "否");
					}
					if ("1".equals(rd.getStr("good_source"))) {
						rd.set("good_source", "自营");
					} else {
						rd.set("good_source", "平台");
					}

				}
			}
			new ExportJqExcel(title + "数据", stf.getTableHeader(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@RequestMapping(value = "toEmployeDetail")
	public String employeDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		if (map1.size() == 0) {
			String createT = DateUtils.formatDate(new Date(), "yyyy");
			map1.put("repairTimeMin", createT + "-01-01");
			map1.put("repairTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		if (map1 != null) {
			String empName = revenueService.getTrimmedParamValue(map1, "employeName");
			if (StringUtils.isNotBlank(empName)) {
				model.addAttribute("empName", empName);
			} else {
				model.addAttribute("empName", "");
			}
			String endTimeMin = revenueService.getTrimmedParamValue(map1, "endTimeMin");// 完工时间
			if (StringUtils.isNotEmpty(endTimeMin)) {
				model.addAttribute("endTimeMin", endTimeMin);
			} else {
				model.addAttribute("endTimeMin", "");
			}
			String endTimeMax = revenueService.getTrimmedParamValue(map1, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				model.addAttribute("endTimeMax", endTimeMax);
			} else {
				model.addAttribute("endTimeMax", "");
			}
			String settlementTimeMin = revenueService.getTrimmedParamValue(map1, "settlementTimeMin");// 结算归属时间
			if (StringUtils.isNotEmpty(settlementTimeMin)) {
				model.addAttribute("settlementTimeMin", settlementTimeMin);
			} else {
				model.addAttribute("settlementTimeMin", "");
			}
			String settlementTimeMax = revenueService.getTrimmedParamValue(map1, "settlementTimeMax");
			if (StringUtils.isNotEmpty(settlementTimeMax)) {
				model.addAttribute("settlementTimeMax", settlementTimeMax);
			} else {
				model.addAttribute("settlementTimeMax", "");
			}
		}
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> list = revenueService.empList(siteId, map1, "");
		model.addAttribute("headerData", stf);
		model.addAttribute("empList", list);
		model.addAttribute("map1", map1);
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		return "modules/finance/employeCostDetail";
	}

	@ResponseBody
	@RequestMapping(value = "toEmployeDetailGrid")
	public String toEmployeDetailGrid(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		Page<Record> page = revenueService.employeDetail(new Page<Record>(request, response), map1, siteId, "");
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@ResponseBody
	@RequestMapping(value = "orderEmployeListCountMoney")
	public Record orderEmployeListCountMoney(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		return revenueService.orderEmployeListCountMoney(map1, siteId, "");
	}

	@RequestMapping(value = "toCostAll")
	public String toCostAll(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		if (map1.size() == 0) {
			String createT = DateUtils.formatDate(new Date(), "yyyy");
			map1.put("repairTimeMin", createT + "-01-01");
			map1.put("repairTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		}
		if (map1 != null) {
			String empName = revenueService.getTrimmedParamValue(map1, "employeName");
			if (StringUtils.isNotBlank(empName)) {
				model.addAttribute("employeName", empName);
			} else {
				model.addAttribute("employeName", "");
			}
			String endTimeMin = revenueService.getTrimmedParamValue(map1, "endTimeMin");// 完工时间
			if (StringUtils.isNotEmpty(endTimeMin)) {
				model.addAttribute("endTimeMin", endTimeMin);
			} else {
				model.addAttribute("endTimeMin", "");
			}
			String endTimeMax = revenueService.getTrimmedParamValue(map1, "endTimeMax");
			if (StringUtils.isNotEmpty(endTimeMax)) {
				model.addAttribute("endTimeMax", endTimeMax);
			} else {
				model.addAttribute("endTimeMax", "");
			}
			String settlementTimeMin = revenueService.getTrimmedParamValue(map1, "settlementTimeMin");// 结算归属时间
			if (StringUtils.isNotEmpty(settlementTimeMin)) {
				model.addAttribute("settlementTimeMin", settlementTimeMin);
			} else {
				model.addAttribute("settlementTimeMin", "");
			}
			String settlementTimeMax = revenueService.getTrimmedParamValue(map1, "settlementTimeMax");
			if (StringUtils.isNotEmpty(settlementTimeMax)) {
				model.addAttribute("settlementTimeMax", settlementTimeMax);
			} else {
				model.addAttribute("settlementTimeMax", "");
			}
		}
		Page<Record> page = revenueService.empCountPage(siteId, new Page<Record>(request, response), map1);
		List<Record> list = revenueService.empList(siteId, map1, "");
		model.addAttribute("empList", list);
		model.addAttribute("page", page);
		model.addAttribute("map1", map1);
		return "modules/finance/employeCostAll";
	}

	@RequestMapping(value = "getSummoney")
	@ResponseBody
	public Object getSummoney(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = getParams(request);
		Record rds = revenueService.getSumMoney(map);
		return rds;
	}

	// 审核不通过
	@RequestMapping(value = "reviewFailed")
	@ResponseBody
	public String reviewFailed(HttpServletRequest request, HttpServletResponse response, String[] id, String reviewRemark) {
		int j = 0;
		for (int i = 0; i < id.length; i++) {
			j = j + revenueService.reviewFailed(id[i], reviewRemark);
		}
		if (j == id.length) {
			return "ok";
		} else {
			return "false";
		}

	}

	// 审核不通过
	@RequestMapping(value = "reviewFailed2017")
	@ResponseBody
	public String reviewFailed2017(HttpServletRequest request, HttpServletResponse response, String[] id, String reviewRemark) {
		int j = 0;
		for (int i = 0; i < id.length; i++) {
			j = j + revenueService.reviewFailed2017(id[i], reviewRemark);
		}
		if (j == id.length) {
			return "ok";
		} else {
			return "false";
		}

	}

	// 审核通过
	@RequestMapping(value = "reviewPass")
	@ResponseBody
	public String reviewPass(HttpServletRequest request, HttpServletResponse response, String[] id, String reviewRemark) {
		int j = 0;
		for (int i = 0; i < id.length; i++) {
			j = j + revenueService.reviewPass(id[i], reviewRemark);
		}
		if (j == id.length) {
			return "ok";
		} else {
			return "false";
		}
	}

	// 审核通过
	@RequestMapping(value = "reviewPass2017")
	@ResponseBody
	public String reviewPass2017(HttpServletRequest request, HttpServletResponse response, String[] id, String reviewRemark) {
		int j = 0;
		for (int i = 0; i < id.length; i++) {
			j = j + revenueService.reviewPass2017(id[i], reviewRemark);
		}
		if (j == id.length) {
			return "ok";
		} else {
			return "false";
		}
	}

	// 审核结算弹出框
	@RequestMapping(value = "showSettlementdetaile")
	public String showSettlementdetaile(HttpServletRequest request) {
		String orderId = request.getParameter("id"); // orderId
		Order order = orderService.get(orderId);
		if (order != null) {
			Record settlement = siteSettlementService.getOrderSettlement(orderId);
			String settlementSource = "order2";
			if (settlement != null) {
				String serviceMeasures = settlement.getStr("service_measures");
				if (settlement.getStr("create_name").equals("__MIGRATION__")) {
					settlementSource = "order1";
				}
				request.setAttribute("serviceMeasures", serviceMeasures);
				request.setAttribute("reviewRemark", order.getReviewRemark());
			}
			request.setAttribute("sittlementSource", settlementSource);
			request.setAttribute("st", siteSettlementService.getSettlementDetails(orderId));
			request.setAttribute("orderId", orderId);
			request.setAttribute("dailyPay", siteSettlementService.getDailyPayByOrderId(orderId));
			return "modules/finance/settlementDetailop";
		} else {
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			Record settlement = siteSettlementService.getOrderSettlement2017(orderId, siteId);
			String reviewRemark = order2017Service.findOrderById(orderId, siteId).getStr("review_remark");
			String settlementSource = "order2";
			if (settlement != null) {
				if (settlement.getStr("create_name").equals("__MIGRATION__")) {
					settlementSource = "order1";
				}
				String serviceMeasures = settlement.getStr("service_measures ");
				request.setAttribute("serviceMeasures", serviceMeasures);
			}
			request.setAttribute("sittlementSource", settlementSource);
			request.setAttribute("st", siteSettlementService.getSettlementDetails2017(orderId,  siteId));
			request.setAttribute("orderId", orderId);
			if (StringUtil.isNotBlank(reviewRemark)) {
				request.setAttribute("reviewRemark", reviewRemark);
			}

			return "modules/order/orderManagement/2017Order/settlementDetailop2017";
		}
	}

	@ResponseBody
	@RequestMapping(value = "employeDetailExport")
	public String employeDetailExport(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> page = revenueService.employeDetail(pages, map, siteId, "");
			List<Record> list = page.getList();
			if (list.size() > 0) {
				for (Record rd : list) {
					if ("1".equals(rd.getStr("warranty_type"))) {
						rd.set("warranty_type", "保内");
					} else if ("2".equals(rd.getStr("warranty_type"))) {
						rd.set("warranty_type", "保外");
					} else {
						rd.set("warranty_type", "");
					}
					rd.set("needMny", rd.getBigDecimal("deSumMoney").subtract(rd.getBigDecimal("drzgMny")));
				}
			}
			new ExportJqExcel(title + "数据", stf.getTableHeader(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "employeCostAllExport")
	public String employeCostAllExport(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "工程师结算汇总" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			String title = "工程师结算汇总";
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Page<Record> page = revenueService.empCountPage(siteId, pages, map);
			List<Record> list = page.getList();
			List<EmployeCostAll> list1 = new ArrayList<>();
			if (list.size() > 0) {
				for (Record rd : list) {
					EmployeCostAll ec = new EmployeCostAll();
					if (StringUtils.isNotBlank(rd.getStr("employe_name"))) {
						ec.setEmployeName(rd.getStr("employe_name"));
					}
					if (rd.getBigDecimal("allMoney") != null) {
						ec.setSumMoney(rd.getBigDecimal("allMoney"));
					}
					if (rd.getBigDecimal("todayMoney") != null) {
						ec.setTodayMoney(rd.getBigDecimal("todayMoney"));
					}
					if (rd.getBigDecimal("relMoney") != null) {
						ec.setRelMoney(rd.getBigDecimal("relMoney"));
					}
					list1.add(ec);
				}
			}
			ExportExcel ee = new ExportExcel(title, EmployeCostAll.class).setDataList(list1);
			new ExcelUtilsEx().write(request, response, fileName, ee).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 商品工程师明细
	@RequestMapping(value = "toEmployeGoodsDetail")
	public String employeGoodsDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> list = revenueService.empGoodsList(siteId);
		List<Record> list1 = revenueService.nonServGoodsList(siteId);
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		if (map1.get("createTimeMin") == null || StringUtils.isBlank(map1.get("createTimeMin").toString())) {
			map1.put("createTimeMin", createT + "-01");
		}
		model.addAttribute("headerData", stf);
		model.addAttribute("empList", list);
		model.addAttribute("nonList", list1);
		model.addAttribute("map1", map1);
		//return "modules/finance/employeCostGoodsDetail";
		return "modules/finance/goodsIndexDetailed";
	}

	// 商品工程师汇总
	@RequestMapping(value = "employeCostGoodsAll")
	public String employeCostGoodsAll(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> list = revenueService.empGoodsList(siteId);
		List<Record> list1 = revenueService.nonServGoodsList(siteId);
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		if (map1.get("createTimeMin") == null || StringUtils.isBlank(map1.get("createTimeMin").toString())) {
			map1.put("createTimeMin", createT + "-01");
		}
		model.addAttribute("empList", list);
		model.addAttribute("nonList", list1);
		model.addAttribute("map1", map1);
		model.addAttribute("headerData", stf);
		return "modules/finance/goodsIndexAll";
	//	return "modules/finance/employeCostGoodsAll";
	}

	@ResponseBody
	@RequestMapping(value = "toEmployeGoodsAllGrid")
	public String toEmployeGoodsAllGrid(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		Page<Record> page = revenueService.empGoodsCountPage(siteId, new Page<Record>(request, response), map1);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@ResponseBody
	@RequestMapping(value = "toEmployeGoodsDetailGrid")
	public String toEmployeGoodsDetailGrid(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		Page<Record> page = revenueService.employeGoodsDetail(new Page<Record>(request, response), map1, siteId);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@ResponseBody
	@RequestMapping(value = "employeGoodsDetailExport")
	public String employeGoodsDetailExport(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> page = revenueService.employeGoodsDetail(pages, map, siteId);
			List<Record> list = page.getList();
			if (list != null && list.size() > 0) {
				for (Record rd : list) {
					Date confirmTime = rd.getDate("confirm_time");
					Date outstockTime = rd.getDate("outstock_time");
					if (confirmTime != null) {
						rd.set("confirmTime", "是");
					} else {
						rd.set("confirmTime", "否");
					}
					if (outstockTime != null) {
						rd.set("outstockTime", "是");
					} else {
						rd.set("outstockTime", "否");
					}
				}
				new ExportJqExcel(title + "数据", stf.getTableHeader(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			}

			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "employeCostGoodsAllExports")
	public String employeCostGoodsAllExports(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "工程师结算汇总" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			String title = "工程师结算汇总";
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Page<Record> page = revenueService.empGoodsCountPage(siteId, pages, map);
			List<Record> list = page.getList();
			List<EmployeCostGoodsAll> list1 = new ArrayList<>();
			if (list.size() > 0) {
				for (Record rd : list) {
					EmployeCostGoodsAll ec = new EmployeCostGoodsAll();
					if (StringUtils.isNotBlank(rd.getStr("salesman"))) {
						ec.setSalesman(rd.getStr("salesman"));
					}
					if (rd.getBigDecimal("ticheng") != null) {
						ec.setTicheng(rd.getBigDecimal("ticheng"));
					}
					if (rd.getBigDecimal("commissions") != null) {
						ec.setCommissions(rd.getBigDecimal("commissions"));
					}
					ec.setShould(ec.getTicheng().subtract(ec.getCommissions()));
					list1.add(ec);
				}
			}
			ExportExcel ee = new ExportExcel(title, EmployeCostGoodsAll.class).setDataList(list1);
			new ExcelUtilsEx().write(request, response, fileName, ee).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 导出
	@RequestMapping(value = "exportJSCount")
	public String exportJSCount(OrderExcel orderExcel, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "工单结算统计" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			Map<String, Object> maps = revenueService.getOrderJSCountList(siteId, map);

			double m2 = 0, m3 = 0, m4 = 0, m5 = 0, m6 = 0, m7 = 0, m8 = 0, m9 = 0, m10 = 0, m11 = 0, m12 = 0;
			Long m1 = (long) 0;
			List<OrderJSCount> list1 = new ArrayList<OrderJSCount>();
			for (int i = 0; i < 2; i++) {
				List<Record> lists1 = new ArrayList<Record>();
				String name = "已结算";
				if (i == 0) {
					lists1 = (List<Record>) maps.get("rdsYjs");
				} else {
					lists1 = (List<Record>) maps.get("rdsWjs");
					name = "未结算";
				}
				if (lists1.size() > 0) {
					for (Record rd : lists1) {
						OrderJSCount oe = new OrderJSCount();
						oe.setOrderType(name);
						oe.setM1(rd.getLong("orderCounts"));
						oe.setM2(Double.valueOf(dealMoneyNull(rd.get("serve_cost_emp"))));
						oe.setM3(Double.valueOf(dealMoneyNull(rd.get("auxiliary_cost_emp"))));
						oe.setM4(Double.valueOf(dealMoneyNull(rd.get("warranty_cost_emp"))));
						oe.setM5(Double.valueOf(dealMoneyNull(rd.get("confirm_cost_emp"))));
						oe.setM6(Double.valueOf(dealMoneyNull(rd.get("callback_cost_emp"))));
						oe.setM7(Double.valueOf(dealMoneyNull(rd.get("costs_emp"))));
						oe.setM8(Double.valueOf(dealMoneyNull(rd.get("factory_money_emp"))));
						oe.setM9(Double.valueOf(dealMoneyNull(rd.get("sum_money_emp"))));
						oe.setM10(Double.valueOf(dealMoneyNull(rd.get("payment_amount_emp"))));
						oe.setM11(Double.valueOf(dealMoneyNull(rd.get("fitting_costs_emp"))));
						oe.setM12(Double.valueOf(dealMoneyNull(rd.get("profits_emp"))));
						m2 += Double.valueOf(dealMoneyNull(rd.get("serve_cost_emp")));
						m1 += rd.getLong("orderCounts");
						m3 += Double.valueOf(dealMoneyNull(rd.get("auxiliary_cost_emp")));
						m4 += Double.valueOf(dealMoneyNull(rd.get("warranty_cost_emp")));
						m5 += Double.valueOf(dealMoneyNull(rd.get("confirm_cost_emp")));
						m6 += Double.valueOf(dealMoneyNull(rd.get("callback_cost_emp")));
						m7 += Double.valueOf(dealMoneyNull(rd.get("costs_emp")));
						m8 += Double.valueOf(dealMoneyNull(rd.get("factory_money_emp")));
						m9 += Double.valueOf(dealMoneyNull(rd.get("sum_money_emp")));
						m10 += Double.valueOf(dealMoneyNull(rd.get("payment_amount_emp")));
						m11 += Double.valueOf(dealMoneyNull(rd.get("fitting_costs_emp")));
						m12 += Double.valueOf(dealMoneyNull(rd.get("profits_emp")));
						list1.add(oe);
					}
				}
			}
			OrderJSCount oe1 = new OrderJSCount();
			oe1.setOrderType("合计");
			oe1.setM1(m1);
			oe1.setM2(m2);
			oe1.setM3(m3);
			oe1.setM4(m4);
			oe1.setM5(m5);
			oe1.setM6(m6);
			oe1.setM7(m7);
			oe1.setM8(m8);
			oe1.setM9(m9);
			oe1.setM10(m10);
			oe1.setM11(m11);
			oe1.setM12(m12);
			list1.add(oe1);

			new ExportExcel("工单结算统计", OrderJSCount.class).setDataList(list1).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出工单报表失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	public String dealMoneyNull(Object val) {
		if (val == null || "".equals(val)) {
			return "0";
		}
		return String.valueOf(val);
	}

	// 导出
	@RequestMapping(value = "exportJSEmpCount")
	public String exportJSEmpCount(OrderExcel orderExcel, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "OrderJSEmpCoun工程师结算统计" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			map.put("pageNo", "1");
			map.put("pageSize", "10000");
			List<Record> list = revenueService.getEmpJSCountPage(new Page<Record>(request, response), map, siteId).getList();
			List<OrderJSEmpCount> list1 = new ArrayList<OrderJSEmpCount>();
			for (Record rd : list) {
				OrderJSEmpCount oe = new OrderJSEmpCount();
				oe.setEnpName(rd.getStr("empName"));
				oe.setM1(rd.get("ywc") != null ? Integer.valueOf(rd.get("ywc").toString()) : 0);
				oe.setM2(rd.get("yjs") != null ? Integer.valueOf(rd.get("yjs").toString()) : 0);
				oe.setM3(rd.get("yjsJsMny") != null ? Double.valueOf(rd.get("yjsJsMny").toString()) : 0.00);
				oe.setM4(rd.get("yjsHasMny") != null ? Double.valueOf(rd.get("yjsHasMny").toString()) : 0.00);
				oe.setM5(rd.get("yjsShortMny") != null ? Double.valueOf(rd.get("yjsShortMny").toString()) : 0.00);
				oe.setM6(rd.get("sm") != null ? Double.valueOf(rd.get("sm").toString()) : 0.00);
				oe.setM7(rd.get("smd") != null ? Double.valueOf(rd.get("smd").toString()) : 0.00);
				oe.setM8(rd.get("mny4") != null ? Double.valueOf(rd.get("mny4").toString()) : 0.00);
				oe.setM9(rd.get("mny5") != null ? Double.valueOf(rd.get("mny5").toString()) : 0);
				oe.setM10(rd.get("mny3") != null ? Double.valueOf(rd.get("mny3").toString()) : 0.00);
				oe.setM11(rd.get("mny1") != null ? Double.valueOf(rd.get("mny1").toString()) : 0.00);
				oe.setM12(rd.get("wxgd") != null ? Double.valueOf(rd.get("wxgd").toString()) : 0);
				oe.setM13(rd.get("bmyd") != null ? Double.valueOf(rd.get("bmyd").toString()) : 0);
				list1.add(oe);
			}

			new ExportExcel("工程师结算统计", OrderJSEmpCount.class).setDataList(list1).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出工单报表失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 商品销售统计明细
	@RequestMapping(value = "toGoodsSellDetail")
	public String toGoodsSellDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> list = revenueService.empGoodsList(siteId);
		List<Record> list1 = revenueService.nonServGoodsList(siteId);
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		if (map1.get("createTimeMin") == null || StringUtils.isBlank(map1.get("createTimeMin").toString())) {
			map1.put("createTimeMin", createT + "-01");
		}
		List<Record> listR = GoodsCategoryUtil.getSiteGoodsCategoryList(siteId);
		model.addAttribute("listorigin", listR);// 商品类别
		model.addAttribute("headerData", stf);
		model.addAttribute("empList", list);
		model.addAttribute("nonList", list1);
		model.addAttribute("map1", map1);
		return "modules/finance/goodsSellDetail";
	}

	// 商品销售统计汇总
	@RequestMapping(value = "toGoodsSellAll")
	public String toGoodsSellAll(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> list = revenueService.empGoodsList(siteId);
		List<Record> list1 = revenueService.nonServGoodsList(siteId);
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		if (map1.get("createTimeMin") == null || StringUtils.isBlank(map1.get("createTimeMin").toString())) {
			map1.put("createTimeMin", createT + "-01");
		}
		List<Record> listR = GoodsCategoryUtil.getSiteGoodsCategoryList(siteId);
		model.addAttribute("listorigin", listR);// 商品类别
		model.addAttribute("empList", list);
		model.addAttribute("nonList", list1);
		model.addAttribute("map1", map1);
		model.addAttribute("headerData", stf);
		return "modules/finance/goodsSellAll";
	}

	@ResponseBody
	@RequestMapping(value = "toGoodsSellAllGrid")
	public String toGoodsSellAllGrid(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		Page<Record> page = revenueService.GoodsSellAllPage(new Page<Record>(request, response), map1, siteId);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@ResponseBody
	@RequestMapping(value = "toGoodsSellDetailGrid")
	public String toGoodsSellDetailGrid(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map1 = getParams(request);
		Page<Record> page = revenueService.goodsSellDetailPage(new Page<Record>(request, response), map1, siteId);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

}
