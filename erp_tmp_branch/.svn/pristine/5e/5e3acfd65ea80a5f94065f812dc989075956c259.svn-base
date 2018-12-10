package com.jojowonet.modules.fitting.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.entity.EmpFittingKeep;
import com.jojowonet.modules.fitting.service.EmpFittingKeepService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
@RequestMapping(value="${adminPath}/fitting/empFittingKeep")
public class EmpFittingKeepController extends BaseController{
	
	@Autowired
	private EmpFittingKeepService empFittingKeepService;

	@ModelAttribute
	public EmpFittingKeep get(@RequestParam(required=false) String id){
		if(StringUtils.isNotBlank(id)){
			return empFittingKeepService.get(id);
		}else{
			return new EmpFittingKeep();
		}
	}
	//获取工程师明细表头
	@RequestMapping(value="list")
	public String list(EmpFittingKeep empFittingKeep,HttpServletRequest request,HttpServletResponse response,Model model){
		
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData",stf);
		model.addAttribute("siteId",siteId);
		
		return "modules/" + "fitting/empFittingKeepList";
	}
	//获取工程师明细数据
	@ResponseBody
	@RequestMapping(value ="getEmpFitKeepList")
	public String getEmpFitKeepList(EmpFittingKeep empFittingKeep, HttpServletRequest request, HttpServletResponse response, Model model) {
			User user = UserUtils.getUser();
			Map<String,Object> map = request.getParameterMap();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			Page<Record> page =null;
			page = empFittingKeepService.getEmpFittingKeep(pages,siteId,map);
			return renderJson(new JqGridPage<>(page));
	}
	
	
}
