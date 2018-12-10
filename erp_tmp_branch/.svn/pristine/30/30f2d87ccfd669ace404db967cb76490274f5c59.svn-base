package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Map;

import ivan.common.config.Global;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.jojowonet.modules.order.entity.OrderOrigin;
import com.jojowonet.modules.order.entity.ProLimit;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.ProLimitService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

@Controller
@RequestMapping(value = "${adminPath}/order/proLimit")
public class ProLimitController extends BaseController{

	@Autowired
	private ProLimitService proLimitService;
	
	@ModelAttribute
	public ProLimit get(@RequestParam(required=false) String id) {
		if (!"0".equals(id)&&StringUtils.isNotBlank(id)){
			return proLimitService.get(id);
		}else{
			return new ProLimit();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(ProLimit proLimit,HttpServletRequest request,HttpServletResponse response,Model model){
		//需要涉及到表头设置时才调用，如果不需要使用表头设置，则不需
				String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
				SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		    	model.addAttribute("headerData", stf);
		
		return "modules/" + "order/proLimitList";
	}

	@RequestMapping(value = "proLimitList")
	@ResponseBody
	public String originList(ProLimit proLimit, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProLimit> page = new Page<>(request, response);
		page = proLimitService.find(new Page<ProLimit>(request, response));
		model.addAttribute("page",page);
		JqGridPage<ProLimit> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	@RequestMapping(value = "form")
	public String form(ProLimit proLimit, Model model) {
		model.addAttribute("proLimit", proLimit);
		return "modules/" + "order/proLimitForm";
	}
	
	@RequestMapping(value="save")
	public String save(ProLimit proLimit,RedirectAttributes redirectAttributes){
		proLimitService.save(proLimit);
		addMessage(redirectAttributes, "保存来源'" + proLimit.getName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/order/proLimit";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		proLimitService.delete(id);
		addMessage(redirectAttributes, "删除来源成功");
		return "redirect:"+Global.getAdminPath()+"/order/proLimit";
	}
	
	@RequestMapping(value="queryNum")
	public void queryNumByName(@RequestParam(value="rname") String rname,HttpServletRequest request,HttpServletResponse response){
		boolean flag = proLimitService.queryNumByName( rname);
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
}
