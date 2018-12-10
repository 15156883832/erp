/**
 */
package com.jojowonet.modules.operate.web;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.jojowonet.modules.operate.entity.SiteDriver;
import com.jojowonet.modules.operate.service.SiteDriverService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import net.sf.json.JSONObject;

/**
 * 司机信息Controller
 * @author lzp
 * @version 2018-10-31
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/siteDriver")
public class SiteDriverController extends BaseController {

	@Autowired
	private SiteDriverService siteDriverService;
	

	@RequestMapping(value={"list",""})
	public String list(SiteDriver siteDriver,HttpServletRequest request,HttpServletResponse response,Model model){		
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		
		return "modules/" + "operate/siteDriverList";
	}
	
	@RequestMapping(value="siteDriverList")
	@ResponseBody
	public String serviceTypeList(SiteDriver siteDriver,HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<SiteDriver> page = new Page<>(request, response);
		page = siteDriverService.find(new Page<SiteDriver>(request, response),siteDriver,siteId);
		JqGridPage<SiteDriver> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	@RequestMapping(value = "form")
	public String form(SiteDriver siteDriver, Model model) {
		model.addAttribute("siteDriver", siteDriver);
		return "modules/" + "operate/siteDriverForm";
	}

	/*服务上新增时验证*/
	@RequestMapping(value="siteDriverCheck")
	public void siteDriverCheck(HttpServletRequest request,HttpServletResponse response){
		String names = request.getParameter("names");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		boolean flag=siteDriverService.getCheckNumber(names,siteId);
			
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*服务商自定义添加*/
	@RequestMapping(value = "saveSiteDriver")
	public @ResponseBody String saveSiteDriver(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes ) {
		User user =UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String mobile = request.getParameter("mobile");
		String names = request.getParameter("names");
		try {
				SiteDriver sd = new SiteDriver();
				sd.setDriverName(names);
				sd.setDriverMobile(mobile);
				sd.setSiteId(siteId);
				sd.setCreateBy(user.getId());
				siteDriverService.save(sd);
			
		} catch (Exception e) {
			return "no";
		}
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping(value = "deletesiteDriver")
	public String deletesiteDriver(String id,HttpServletRequest request,HttpServletResponse response) {
		if(StringUtils.isBlank(id)) {
			return "no";
		}
		siteDriverService.deleteSiteDriver(id);
		return "ok";
		
	}
}
