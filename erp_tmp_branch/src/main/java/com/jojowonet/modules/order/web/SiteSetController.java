package com.jojowonet.modules.order.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SiteSetService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/order/siteSet")
public class SiteSetController extends BaseController{
	@Autowired
	private SiteSetService siteSetService;
	
	@Autowired
	private SiteMsgService siteMsgService;
	
	@RequestMapping(value = { "list", "" })
	public String list(Site site, HttpServletRequest request,HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId,request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/siteSet";
	}
	
	@RequestMapping(value = "siteSetList")
	@ResponseBody
	public String siteSetList(HttpServletRequest request,HttpServletResponse response, Model model) {
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page =null;
    	page = siteSetService.siteSetList(pages); 
		return renderJson(new JqGridPage<>(page));
	}
	
	@RequestMapping(value = "save")
	@ResponseBody
	public String save(HttpServletRequest request,HttpServletResponse response, Model model) {
		Map<String,Object> map = request.getParameterMap();
		return siteSetService.save(map);
	}
	
	@ResponseBody
	@RequestMapping(value="deleteSite")
	public Boolean deleteSite(String id,HttpServletRequest request,HttpServletResponse response){
		return siteSetService.deleteSite(id);
	}
	
	@ResponseBody
	@RequestMapping(value="siteDetail")
	public Record getDetail(HttpServletRequest request,HttpServletResponse response){
		String siteId = request.getParameter("siteId");
		return siteSetService.getDetail(siteId);
	}
	
	@RequestMapping(value="openForm")
	public String openForm(String id,HttpServletRequest request,HttpServletResponse response,Model model){
		
		String type="";
		String oId="";
		if(StringUtils.isBlank(id)){
			type="2";//新增
			List<Record> provincelist=siteMsgService.getprovincelist();
			List<Record> cities = siteMsgService.getCities();
			List<Record> districts = siteMsgService.getDistrincts();
			model.addAttribute("cities", cities);
			model.addAttribute("districts", districts);
			model.addAttribute("provincelist", provincelist);
			model.addAttribute("oId", "");
		}else{
			type="1";//编辑
			Record rd=siteMsgService.getSiteId(id);
			List<Record> provincelist=siteMsgService.getprovincelist();
			List<Record> cities = siteMsgService.getCitiesByProvince(rd.getStr("province")); 
			List<Record> districts = siteMsgService.getDistrinctsProvince(rd.getStr("city")); 
			model.addAttribute("cities", cities);
			model.addAttribute("districts", districts);
			model.addAttribute("provincelist", provincelist);
			Record record = siteSetService.getDetail(id);
			
			model.addAttribute("record", record);
			model.addAttribute("oId", id);
		}
		model.addAttribute("type", type);
		return "modules/" + "order/siteSetForm";
	}
	
	@RequestMapping(value="repairPhoneSet")
	public String toRepairPhoneSet(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		model.addAttribute("site", siteSetService.getSiteMsg(siteId));
		return "modules/" + "operate/repairPhoneSet";
	}
	
	@ResponseBody
	@RequestMapping(value="updateRrepairPhone")
	public Result<T> updateRrepairPhone(HttpServletRequest request){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String repairPhone = request.getParameter("smsPhone");
		return siteSetService.updateRrepairPhone(repairPhone,siteId);
	}
}
