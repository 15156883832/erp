package com.jojowonet.modules.order.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SiteVenderAccount;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SitetVenderAccountService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 网点的厂家账号信息表Controller
 * @author Ivan
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/order/siteVenderAccount")
public class SitetVenderAccountController extends BaseController {
    @Autowired
    private SitetVenderAccountService sitetVenderAccountService;
	
	@RequestMapping(value ={"List",""})
	public String getHeaderList(SiteVenderAccount siteVenderAccount,HttpServletRequest request,HttpServletResponse response,Model model){
	     String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	     SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
	     //List<Record> venderInfo = sitetVenderAccountService.getVenderInfo();
		 model.addAttribute("headerData", stf);
		// model.addAttribute("vender", venderInfo);
		 return "modules/order/siteVenderAccount";
	}
	
	@ResponseBody
	@RequestMapping(value ="siteVenderAccountGrid")
	public String getSiteVenderAccountGrid(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record> pages = new Page<Record>(request,response);
		Page<Record> page = sitetVenderAccountService.getSiteVenderAccountGrid(siteId,pages);
		model.addAttribute("page",page);
		return renderJson(new JqGridPage<>(page));
	}
	
	@ResponseBody
	@RequestMapping(value ="delOne")
	public Boolean delOne(String rowId,HttpServletRequest request,HttpServletResponse response,Model model){
		Boolean boolean1 = sitetVenderAccountService.delOne(rowId);
		return boolean1;
	}
	
	@ResponseBody
	@RequestMapping(value ="editOne")
	public Record editOne(String rowId,HttpServletRequest request,HttpServletResponse response,Model model){
		Record vender = sitetVenderAccountService.editOne(rowId);
		return vender;
	}
	
	@ResponseBody
	@RequestMapping(value ="saveEdit")
	public String saveEdit(String rowId,String loginName,String password,HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record r=sitetVenderAccountService.querybyid(siteId, loginName, rowId);
		if(r!=null){
			return "exit";
		}else{
			sitetVenderAccountService.saveEdit(rowId,loginName,password);
			return "ok";
		}
	}
	@RequestMapping(value="sitevenderForm")
	public String tositevenderForm(Model model){
		List<Record> venderInfo = sitetVenderAccountService.getVenderInfo();
		model.addAttribute("vender", venderInfo);
		 return "modules/order/sitevenderForm";
	}
	
	@ResponseBody
	@RequestMapping(value ="addSave")
	public String addSave(String getSelectedId,String loginName,String password,HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Integer count = sitetVenderAccountService.queryAccountByName(siteId,loginName);
		if(count>0){//该账号名已存在
			return "ok";
		}else{
			Boolean resul= sitetVenderAccountService.addSave(siteId,getSelectedId,loginName,password);
			if(resul){
				return "true";
			}else{
				return "false";
			}
		}
	}
	@ResponseBody
	@RequestMapping(value ="queryAccountByName")
	public Integer queryAccountByName(String loginName,HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return sitetVenderAccountService.queryAccountByName(siteId,loginName);
	}
	
	@ResponseBody
	@RequestMapping(value ="querybyid")
	public Integer querybyid(String names,String id,HttpServletRequest request,HttpServletResponse response,Model model){
		Integer i=0;
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record r=sitetVenderAccountService.querybyid(siteId, names, id);
		if(r!=null){
			i=1;
		}
		return i;
	}
	
}
