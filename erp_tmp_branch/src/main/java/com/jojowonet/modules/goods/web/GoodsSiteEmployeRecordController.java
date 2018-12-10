package com.jojowonet.modules.goods.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.service.GoodsSiteEmployeRecordService;
import com.jojowonet.modules.goods.service.GoodsSiteSelfService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value="${adminPath}/goods/siteEmployerecord")
public class GoodsSiteEmployeRecordController extends BaseController {
	@Autowired
	private GoodsSiteSelfService goodsSiteSelfService;
	@Autowired
	private GoodsSiteEmployeRecordService goodsSiteEmployeRecordService;

	@RequestMapping(value="waitReturn")
	public String waitReturn(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("employes", goodsSiteEmployeRecordService.getEmployes(siteId));
		model.addAttribute("headerData", stf);
		return  "modules/goods/waitReturn";		
	}
	
	@ResponseBody
	@RequestMapping(value="waitReturnList")
	public String waitReturnList(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsSiteEmployeRecordService.waitReturnList(pages, map,siteId);
		return renderJson(new JqGridPage<>(page));
	}
	
	@ResponseBody
	@RequestMapping(value="allCount")
	public Long allCount(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return goodsSiteEmployeRecordService.allCount(siteId);
	}
	
	@ResponseBody
	@RequestMapping(value="confirmInStocks")
	public String confirmInStocks(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String amount = request.getParameter("amount");
		String goodId = request.getParameter("goodId");
		return goodsSiteEmployeRecordService.confirmInStocks(id,amount,goodId,siteId);
	}
	
	@RequestMapping(value="todetail")
	public String toDetail(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String goodId = request.getParameter("goodId");
		Record rd = goodsSiteEmployeRecordService.getDetailById(id,goodId,siteId);
		model.addAttribute("siteSelf", rd);
		model.addAttribute("returnGoods", goodsSiteEmployeRecordService.getDetailByIdReturn(id,goodId,siteId));
		return "modules/goods/waitReturnDetail";	
	}
}
