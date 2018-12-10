package com.jojowonet.modules.operate.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.ReceivedSmsService;

import com.jojowonet.modules.order.form.SiteTableHeaderForm;

import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;


@Controller
@RequestMapping(value = "${adminPath}/operate/receivedSms")
public class ReceivedController  extends BaseController{
	@Autowired
	private ReceivedSmsService receivedSmsService;

	
	@RequestMapping(value={"list",""})
	public String list(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId=CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "operate/receivedsmslist";
	}
	@RequestMapping(value="receivedsmslist")
	@ResponseBody
	public String receivedSmslist(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId=CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,Object> map = request.getParameterMap();
		Page<Record> page = new Page<>(request, response);
		page = receivedSmsService.getReceivedList(page, siteId, map);
		
		model.addAttribute("page",page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
}
