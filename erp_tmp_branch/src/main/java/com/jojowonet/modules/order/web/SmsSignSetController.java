package com.jojowonet.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.service.SmsSignSetService;
import com.jojowonet.modules.order.utils.CrmUtils;



import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

/**
 * 
 * @author yc
 * 短信签名controller
 * 
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/order/smsSignSet")
public class SmsSignSetController extends BaseController{
	@Autowired
	private SmsSignSetService smsSignSetService;
	
	@RequestMapping(value = { "list", "" })
	public String list(HttpServletRequest request,HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record site=smsSignSetService.getSiteSmsSign(siteId);
		Record re = smsSignSetService.getSignInfo(siteId);
		model.addAttribute("signInfo", re);
		model.addAttribute("site", site);

		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		model.addAttribute("siteSign",smsSignSetService.getSiteSmsSign(siteId));
		return "modules/" + "order/smsSign";
	}

	//修改手机号
	@RequestMapping(value="updatePhone")
	@ResponseBody
	public boolean updatePhone(String smsPhone,String smsSign){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		boolean flag;
		int i=smsSignSetService.updateMobile(siteId,smsPhone);
		if(i>0){
			flag=true;
		}else{
			flag=false;
		}
		return flag;

	}

	//修改签名
	@RequestMapping(value="smsSignUpdate")
	@ResponseBody
	public Result smsSignUpdate(String smsPhone, String smsSign){
		Result ret = new Result();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		ret = smsSignSetService.updateSiteSign(siteId, smsSign);
		return ret;
		
	}

}
