/**
 */
package com.jojowonet.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.web.BaseController;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.ProLimit;
import com.jojowonet.modules.order.entity.SiteSuperviseSetting;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SiteSuperviseSettingService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

/**
 * 监督事项信息Controller
 * @author Ivan
 * @version 2018-04-19
 */
@Controller
@RequestMapping(value = "${adminPath}/order/siteSuperviseSetting")
public class SiteSuperviseSettingController extends BaseController {

	@Autowired
	private SiteSuperviseSettingService siteSuperviseSettingService;
	
	@RequestMapping(value = {"list", ""})
	public String list(SiteSuperviseSetting siteSuperviseSetting, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
    	model.addAttribute("headerData", stf);
		return "modules/" + "order/siteSuperviseSettingList";
	}
	
	@RequestMapping(value = "superviseSettingList")
	@ResponseBody
	public String superviseSettingList(ProLimit proLimit, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Record> page = new Page<>(request, response);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		page = siteSuperviseSettingService.find(new Page<Record>(request, response),siteId);
		model.addAttribute("page",page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@ResponseBody
	@RequestMapping(value = "getSuperviseByid")
	public Object form(HttpServletRequest request,HttpServletResponse response) {
		String id = request.getParameter("id");
		SiteSuperviseSetting siteing =siteSuperviseSettingService.get(id);
		return siteing;
	}
	
	@ResponseBody
	@RequestMapping(value = "update")
	public String update(HttpServletRequest request,HttpServletResponse response) {
		try {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		User user = UserUtils.getUser();
		if(StringUtils.isNotBlank(id)) {
			SiteSuperviseSetting sing = siteSuperviseSettingService.get(id);
			sing.setName(name);
			siteSuperviseSettingService.save(sing);
			//修改
		}else{
			//新增
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			SiteSuperviseSetting sing = new SiteSuperviseSetting();
			sing.setName(name);
			sing.setCreateBy(user.getId());
			sing.setSiteId(siteId);
			siteSuperviseSettingService.save(sing);
		}
			} catch (Exception e) {
			return "no";
		}
		return "ok";
	}
	
	/*
	 * 删除，如果是平台默认的，则新增一条删除记录，否则只是更改状态
	*/
	@RequestMapping(value = "deleteMall")
    @ResponseBody
	public String delete(String[] idArr,HttpServletRequest request,HttpServletResponse response) {
		if(idArr!=null&&idArr.length>0){
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		siteSuperviseSettingService.delete(idArr,siteId,user.getId());
		return "ok";
		}
		return "no";
	}
	
}
