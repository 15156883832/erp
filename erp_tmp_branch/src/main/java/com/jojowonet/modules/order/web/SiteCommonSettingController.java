/**
 */
package com.jojowonet.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ivan.common.config.Global;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.web.BaseController;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.entity.SiteCommonSetting;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SiteCommonSettingService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

import java.util.Map;

/**
 * 类型信息Controller
 * @author Ivan
 * @version 2017-10-25
 */
@Controller
@RequestMapping(value = "${adminPath}/order/commonsetting")
public class SiteCommonSettingController extends BaseController {

	@Autowired
	private SiteCommonSettingService commentSettingService;
	@Autowired
	private SiteService siteService;

	@RequestMapping("settingtable")
	public String getSettletable(SiteTableHeaderForm headerForm, HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/order/commonSetting";
	}
	
	@RequestMapping("settingList")
	@ResponseBody
	public String getSettleList(HttpServletRequest request, HttpServletResponse response, Model model){
	String type=request.getParameter("serviceType");


		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record>	page =commentSettingService .getCommenSetting(new Page<Record>(request, response),siteId,type);
		return renderJson(new JqGridPage<>(page));
	}

	@RequestMapping("updatesetting")//关闭
	public @ResponseBody String updatesetting(String id,HttpServletRequest request,HttpServletResponse response) {
		commentSettingService.updatesetting(id);
		String close="已关闭";
		return close;
	
	}
	
	@RequestMapping("updatesettings")//开启
	public @ResponseBody String updatesettings(String id,HttpServletRequest request,HttpServletResponse response) {
		commentSettingService.updatesettings(id);
		String open="已开启";
		return open;
	
	}
	/*
	 * app端结算显示设置
	*/
	@RequestMapping("settingvalue")
	public String getsettingvalue( HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		//Site site = siteService.get(siteId);
		/*if(site.getSmsAvailableAmount()<1){
			//无购买短信，跳转到提示页面
			//	return "";
		}*/
		Record rd = commentSettingService.getCommensetting(siteId,"3");
		Record rd1 = commentSettingService.getCommensetting(siteId,"1");
		model.addAttribute("rds", rd);
		model.addAttribute("rds1", rd1);
		return "modules/order/jscommonSetting";
	}
	
	/*
	 *结算条件设置
	*/
	@RequestMapping("conditionsSet")
	public String getConditionsSet(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record rd1 = commentSettingService.getCommensetting(siteId, "5");
		Record gsTimeSetting = commentSettingService.getCommensetting(siteId, "15");
		model.addAttribute("rds1", rd1);
		model.addAttribute("gss", getGsTimeSetting(gsTimeSetting));
		return "modules/order/jsConditionsSet";
	}

	private String getGsTimeSetting(Record gsTimeSetting) {
		if (gsTimeSetting == null) {
			return "1";
		}
		return gsTimeSetting.getStr("set_value");
	}
	
	/*
	 * 保存设置
	*/
	@RequestMapping("setSaveCommen")
	@ResponseBody
	public String setSaveCommen(HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String id1 = request.getParameter("id1");//结算明细显示
		String setValue = request.getParameter("setvalue");
		String showFlag = request.getParameter("showFlag");//结算明细显示
		return commentSettingService.dealCommenSetSave(id,id1,setValue,showFlag,siteId);
	}
	/*
	 * 保存结算条件设置
	 */
	@RequestMapping("setSaveCommenConditons")
	@ResponseBody
	public String setSaveCommenConditons(HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id1 = request.getParameter("id1");//结算明细显示
		String showFlag = request.getParameter("showFlag");//结算明细显示
		Map<String, Object> paras = getParams(request);
		return commentSettingService.SaveCommenConditons(id1,showFlag,siteId, paras);
	}
	/*
	 * 派工发送短信设置
	 */
	@RequestMapping("getShortmessage")
	public String getShortmessage( HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record rd = commentSettingService.getCommensetting(siteId,"4");
		model.addAttribute("rds", rd);
		return "modules/order/syscommonSetting";
	}
	/*
	 * 保存设置
	 */
	@RequestMapping("setSMSsettings")
	@ResponseBody
	public String setSMSsettings(HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String set_value = request.getParameter("setvalue");
		if(StringUtils.isBlank(id)){
			SiteCommonSetting com = new SiteCommonSetting();
			com.setSiteId(siteId);
			com.setSetValue(set_value);
			com.setType("4");
			commentSettingService.save(com);
		}else{
			commentSettingService.updateSetvalue(id, set_value);
		}
		return "ok";
	}
	
	/*
	 * 查询是否已开通
	*/
	@RequestMapping("shifoukaitong")
	@ResponseBody
	public Record shifoukaitong(HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return commentSettingService.getCommensetting(siteId,"4");
	}
	
	

}
