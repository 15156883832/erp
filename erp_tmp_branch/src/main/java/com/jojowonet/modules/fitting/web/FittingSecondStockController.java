package com.jojowonet.modules.fitting.web;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.service.FittingSecondStockService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;

import ivan.common.config.Global;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "${adminPath}/fitting/fittingSecondStock")
public class FittingSecondStockController extends BaseController {
	@Autowired
	private FittingSecondStockService fittingSecondStockService;

	@RequestMapping(value = "secondStockHeader")
	public String secondStockHeader(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getDefaultTableHead(request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("headerData", stf);
		model.addAttribute("listR", listR);
		model.addAttribute("secondSiteList", fittingSecondStockService.getSecondSiteList(siteId));
		return "modules/fitting/secondSiteFittingApply/secondFittingStocks";
	}

	@ResponseBody
	@RequestMapping(value = "getSecondStockList")
	public String getSecondStockList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = getParams(request);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record> page = new Page<>(request, response);
		page = fittingSecondStockService.findStockPage(page, params, siteId);
		return renderJson(new JqGridPage<>(page));
	}

	@ResponseBody
	@RequestMapping(value = "getFittingAllStocks")
	public Map<String, Object> getFittingAllStocks(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		return fittingSecondStockService.getFittingAllStocks(siteId, map);
	}

	@RequestMapping(value = "export")
	public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			Map<String, Object> params = new TrimMap(getParams(request));
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			Page<Record> page1 = new Page<>(request, response);
			page1.setPageNo(1);
			page1.setPageSize(10000);
			Page<Record> pages = fittingSecondStockService.findStockPage(page1, params, siteId);
			List<Record> list = pages.getList();
			for (Record fit : list) {
				if ("1".equals(fit.getStr("type"))) {
					fit.set("type", "配件");
				} else if ("2".equals(fit.getStr("type"))) {
					fit.set("type", "耗材");
				} else {
					fit.set("type", "其他");
				}
				if (fit.getBigDecimal("site_price") != null) {
					BigDecimal bd = fit.getBigDecimal("site_price");
					bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
					fit.set("site_price", bd.doubleValue());
				} else {
					fit.set("site_price", 0.00);
				}
				if (fit.getBigDecimal("employe_price") != null) {
					BigDecimal bd = fit.getBigDecimal("employe_price");
					bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
					fit.set("employe_price", bd.doubleValue());
				} else {
					fit.set("employe_price", 0.00);
				}

				if (fit.getBigDecimal("customer_price") != null) {
					BigDecimal bd = fit.getBigDecimal("customer_price");
					bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
					fit.set("customer_price", bd.doubleValue());
				} else {
					fit.set("customer_price", 0.00);
				}
			}
			new ExportJqExcel(title, jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

}
