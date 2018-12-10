package com.jojowonet.modules.goods.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.service.GoodsSiteSelfService;
import com.jojowonet.modules.goods.service.SiteGoodsKeepService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/goods/siteGoodsKeep")
public class SiteGoodsKeepController extends BaseController{

	@Autowired
	private SiteGoodsKeepService siteGoodsKeepService;
	@Autowired
	private GoodsSiteSelfService goodsSiteSelfService;
	

	//获取服务商商品出入库明细表头
	@RequestMapping(value="list")
	public String list(HttpServletRequest request, Model model, HttpServletResponse response) {
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> rd2 = goodsSiteSelfService.getSiteEmployeList(siteId);//服务工程师
		model.addAttribute("headerData",stf);
		model.addAttribute("siteId",siteId);
		Map<String,Object> map = request.getParameterMap();
		Map<String,Object> mapHui =getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = siteGoodsKeepService.getSiteGoodsKeep(pages,siteId,map);
		model.addAttribute("page",page);
		model.addAttribute("map",mapHui);
		model.addAttribute("rd2",rd2);
		return "modules/" + "goods/siteGoodsKeepList";
	}
	
	//获取工程师领取商品出入库明细表头
	@RequestMapping(value="empList")
	public String empList(HttpServletRequest request, Model model,HttpServletResponse response) {
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData",stf);
		model.addAttribute("siteId",siteId);
		Map<String,Object> map = request.getParameterMap();
		Map<String,Object> mapHui =getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = siteGoodsKeepService.getEmpKeepList(pages,siteId,map);
		model.addAttribute("page",page);
		model.addAttribute("map",mapHui);
		return "modules/" + "goods/employeKeepList";
	}
	
	//获取工程师自购商品出入库明细表头
	@RequestMapping(value="buyEmpList")
	public String buyEmpList(HttpServletRequest request, Model model,HttpServletResponse response) {
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData",stf);
		model.addAttribute("siteId",siteId);
		Map<String,Object> map = request.getParameterMap();
		Map<String,Object> mapHui =getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = siteGoodsKeepService.getEmpKeepListgm(pages,siteId,map);
		model.addAttribute("page",page);
		model.addAttribute("map",mapHui);
		return "modules/" + "goods/employeBuyKeepList";
	}
	
	//获取工程师出入库明细数据
	@ResponseBody
	@RequestMapping(value ="getEmpKeepList")
	public String getEmpKeepList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		Map<String,Object> map = request.getParameterMap();
		String siteId= CrmUtils.getCurrentSiteId(user);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = siteGoodsKeepService.getEmpKeepList(pages,siteId,map);
		return renderJson(new JqGridPage<>(page));
	}
	//获取服务商商品出入库明细数据
	@ResponseBody
	@RequestMapping(value ="getSiteGoodsKeepList")
	public String getSiteFitKeepList(HttpServletRequest request, HttpServletResponse response, Model model) {
			User user = UserUtils.getUser();
			Map<String,Object> map = request.getParameterMap();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			Page<Record> page = siteGoodsKeepService.getSiteGoodsKeep(pages,siteId,map);
			return renderJson(new JqGridPage<>(page));
	}
	
	
	//公司库存出入库明细导出
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "export")
    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Map<String,Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
	        pages.setPageSize(10000);
			String title = stf.getExcelTitle();
			
            String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
            String str1="";
            String str2="";
			List<Record> list = siteGoodsKeepService.getSiteGoodsKeep(pages,siteId,map).getList();
			 for (Record re : list) {
				String type = re.getStr("type");
				if("2".equals(type) || "6".equals(type) || "8".equals(type) ) {
					re.set("applicant", re.getStr("applicant"));
				}else {
					re.set("applicant", "");
				}
				if(type.equals("1")){
					str1="入库";
					str2="+";
				}else if(type.equals("2")){
					str1="出库";
					str2="-";
				}else if(type.equals("3")){
					str1="零售";
					str2="-";
				}else if(type.equals("4")){
					str1="删除";
					str2="-";
				}else if(type.equals("5")){
					str1="调整";
					str2="";
				}else if(type.equals("6")){
					str1="返还入库";
					str2="+";
				}else if(type.equals("7")){
					str1="取消订单入库";
					str2="+";
				}else if(type.equals("8")){
					str1="自购";
					str2="-";
				}
				
				String s="";
				if(re.getBigDecimal("amount")!=null){
					s=re.getBigDecimal("amount").toString();
				}
				re.set("type", str1);
				re.set("amount", str2+s);
					
			 }
    		new ExportJqExcel(title+"数据", stf.getTableHeader(), stf.getSortHeader())
    			.setDataList(list).write(request, response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
    }
	
	//工程师领取库存明细导出
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "exportEmp")
	public String exportEmp(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Map<String,Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			String title = stf.getExcelTitle();
			Page<Record> page = siteGoodsKeepService.getEmpKeepList(pages,siteId,map);
			String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
			String str1="";
			String str2="";
			List<Record> list = page.getList();
			for (Record re : list) {
				re.set("creator", re.getStr("empName"));
				re.set("confirmor", re.getStr("siteName"));
				if(StringUtils.isNotBlank(re.getStr("employeName"))){
					re.set("confirmor", re.getStr("employeName"));
				}
				if(StringUtils.isNotBlank(re.getStr("cnsName"))){
					re.set("confirmor", re.getStr("cnsName"));
				}
				if(re.getStr("type").equals("1")){
					re.set("type", "领用");
					re.set("amount", "+"+re.getBigDecimal("amount"));
				}else if(re.getStr("type").equals("2")){
					re.set("type", "零售");
					re.set("amount", "-"+re.getBigDecimal("amount"));
				}else if(re.getStr("type").equals("3")){
					re.set("type", "返还");
					re.set("amount", "-"+re.getBigDecimal("amount"));
				}
			}
			new ExportJqExcel(title+"数据", stf.getTableHeader(), stf.getSortHeader())
			.setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}
	
	//工程师自购库存明细导出
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "exportEmpZg")
	public String exportEmpZg(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Map<String,Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			String title = stf.getExcelTitle();
			Page<Record> page = siteGoodsKeepService.getEmpKeepListgm(pages,siteId,map);
			String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
			String str1="";
			String str2="";
			List<Record> list = page.getList();
			for (Record re : list) {
				re.set("creator", re.getStr("empName"));
				re.set("confirmor", re.getStr("siteName"));
				if(StringUtils.isNotBlank(re.getStr("employeName"))){
					re.set("confirmor", re.getStr("employeName"));
				}
				if(StringUtils.isNotBlank(re.getStr("cnsName"))){
					re.set("confirmor", re.getStr("cnsName"));
				}
				if(re.getStr("type").equals("4")){
					re.set("type", "自购");
					re.set("amount", "+"+re.getBigDecimal("amount"));
				}else if(re.getStr("type").equals("2")){
					re.set("type", "零售");
					re.set("amount", "-"+re.getBigDecimal("amount"));
				}else if(re.getStr("type").equals("3")){
					re.set("type", "返还");
					re.set("amount", "-"+re.getBigDecimal("amount"));
				}
			}
			new ExportJqExcel(title+"数据", stf.getTableHeader(), stf.getSortHeader())
			.setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}
	
}
	