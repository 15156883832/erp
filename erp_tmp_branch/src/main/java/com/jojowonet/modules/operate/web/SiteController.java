/**
 */
package com.jojowonet.modules.operate.web;

import com.jfinal.plugin.activerecord.Db;
import ivan.common.config.Global;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alipay.demo.trade.model.result.Result;
import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.BrandService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

/**
 * 服务商Controller
 * @author Ivan
 * @version 2016-08-01
 * @param <T>
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/site")
public class SiteController<T> extends BaseController {

	@Autowired
	private SiteService siteService;
	@Autowired 
	private BrandService brandService;
	@Autowired
	private NonServicemanService nonServicemanService;
	
	@Autowired
    private SiteMsgService siteMsgService;
	@ModelAttribute
	public Site get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return siteService.get(id);
		}else{
			return new Site();
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = {"list", ""})
	public String list(Site site, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Record> page = new Page<>(request, response);
		Map<String, Object> map = request.getParameterMap();
		page = siteService.getsiteList(page, map);
		model.addAttribute("filterMap", map);
		model.addAttribute("page", page);
		model.addAttribute("site", site);
		return "modules/order/siteList";
	}

	@RequestMapping(value = "checkOrderPrintTemplate")
	@ResponseBody
	public String checkOrderPrintTemplate(HttpServletRequest request){
		String ret = "n";
		String siteId = request.getParameter("siteId");
		Record rd = Db.findFirst(" select id from crm_site_print_template a where a.site_id = ? ", siteId);
		if(rd != null && StringUtils.isNotBlank(rd.getStr("id"))){
			ret = "y";
		}
		return ret;
	}

	@RequestMapping(value = "ajaxList")
	@ResponseBody
	public String ajaxList(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Record> page = new Page<>(request, response);
		page = brandService.findBrand(page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	@RequestMapping(value = "export")
    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead("ff808081586cc3d701586ce8bef50003", formPath);
			
            String fileName = "用户数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
            Page<Record> page = new Page<>(request, response);
    		page = brandService.findBrand(page);
    		new ExportJqExcel("用户数据", stf.getTableHeader(), stf.getSortHeader())
    			.setDataList(page.getList()).write(request, response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
    }
	
	@RequestMapping(value = "saveTableHeader")
	@ResponseBody
	public String saveTableHeader(SiteTableHeaderForm headerForm, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		JqGridTableUtils.saveTableHeader(headerForm, siteId);
		return "ok";
	}
	
	@RequestMapping(value = "alarmSetting")
	public String alarmSetting(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		//Map<String, Map<String, Object>> alarmMap = siteService.getSiteAlarm(siteId);
		List<Record> alarmList = siteService.getSiteAlarm(siteId);
//		model.addAttribute("alarmMap", alarmMap);
		model.addAttribute("alarmList", alarmList);
		List<Map<String,String>> listmap1=Lists.newArrayList();
		List<Map<String,String>> listmap2=Lists.newArrayList();
		List<Map<String,String>> listmap3=Lists.newArrayList();
		List<Map<String,String>> listmap4=Lists.newArrayList();
		for(int i=0;i<4;i++){
			if(alarmList.get(i).getStr("receiver_type")!=null){
				if(i==0){
					String list[]=alarmList.get(i).getStr("receiver_type").split(",");
					Arrays.sort(list);
					for(int k=0;k<list.length;k++){
						Map<String,String> map=new HashMap<String, String>();
						map.put("id",list[k]);
						listmap1.add(map);
					}
				}else if(i==1){
					String list[]=alarmList.get(i).getStr("receiver_type").split(",");
					Arrays.sort(list);
					for(int k=0;k<list.length;k++){
						Map<String,String> map=new HashMap<String, String>();
						map.put("id",list[k]);
						listmap2.add(map);
					}
				}else if(i==2){
					String list[]=alarmList.get(i).getStr("receiver_type").split(",");
					Arrays.sort(list);
					for(int k=0;k<list.length;k++){
						Map<String,String> map=new HashMap<String, String>();
						map.put("id",list[k]);
						listmap3.add(map);
					}
				}else if(i==3){
					String list[]=alarmList.get(i).getStr("receiver_type").split(",");
					Arrays.sort(list);
					for(int k=0;k<list.length;k++){
						Map<String,String> map=new HashMap<String, String>();
						map.put("id",list[k]);
						listmap4.add(map);
					}
				}
			}
		}
		model.addAttribute("reciverList1",listmap1);
		model.addAttribute("reciverList2",listmap2);
		model.addAttribute("reciverList3",listmap3);
		model.addAttribute("reciverList4",listmap4);
		
		//获取人员角色信息
		List<Map<String, String>> map=nonServicemanService.getservicemanRoleList(siteId);
		model.addAttribute("roleList",map);
		return "modules/operate/siteAlarm";
	}
	
	@RequestMapping(value = "saveAlarm")
	@ResponseBody
	public String saveAlarm(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> map = getParams(request);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String ret = siteService.saveAlarm(map, siteId);
		return "ok";
	}
	
	@RequestMapping(value="toSecondSiteGrid")
	public String toSecondSiteGrid(HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/operate/secondSiteSet";
	}
	
	@ResponseBody
	@RequestMapping(value="secondSiteList")
	public String  secondSiteList(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request,response);
		Page<Record> page = siteService.secondSiteList(siteId,pages,map);
		return renderJson(new JqGridPage<>(page));
	}
	
	@ResponseBody
	@RequestMapping(value="sendMsgSdSite")
	public String sendMsgSdSite(String mobile,HttpServletRequest request, HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String code = siteMsgService.getCode();
	    request.getSession().setAttribute("secondSiteMsgCode", code);
	    return siteService.checkAndSendMsg(siteId,mobile, code);
	}
	
	@ResponseBody
	@RequestMapping(value="addSecondSiteConfirm")
	public String addSecondSiteConfirm(HttpServletRequest request, HttpServletResponse response){
		String userId = UserUtils.getUser().getId();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String siteName = request.getParameter("siteName");
		String siteMobile = request.getParameter("siteMobile");
		String mobileMsg = request.getParameter("mobileMsg");
		String type = request.getParameter("type");//二级网点类型
		if(StringUtils.isBlank(type)) {
			type = "1";
		}
		Object codeObj = request.getSession().getAttribute("secondSiteMsgCode");
		if(codeObj==null){
			return "420";//验证码有误
		}
		String code = codeObj.toString();
		return siteService.addSecondSiteConfirm(siteId,siteName,siteMobile,code,mobileMsg,userId,type);
	}
	
	@ResponseBody
	@RequestMapping(value="delSecondSite")
	public String delSecondSite(String ids,HttpServletRequest request, HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String userId = UserUtils.getUser().getId();
		if(StringUtils.isBlank(ids)){
			return "420";
		}
		return siteService.delSecondSite(siteId,ids,userId);
	}
}
