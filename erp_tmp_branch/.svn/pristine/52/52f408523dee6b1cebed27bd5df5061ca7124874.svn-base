/**
 */
package com.jojowonet.modules.operate.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.mapper.JsonMapper;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Map;


/**
 * 服务工程师Controller
 * @author Ivan
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/employe")
public class EmployeController extends BaseController {

	@Autowired
	private EmployeService employeService;
	@Autowired
	private SiteService siteService;
	
	
	@ModelAttribute
	public Employe get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return employeService.get(id);
		}else{
			return new Employe();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(Employe employe, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = getCurrentSiteId(user);
		List<Employe> list = employeService.getListEmp(employe, siteId);
		model.addAttribute("list", list);
		return "modules/" + "order/employeList";
	}

	@RequestMapping(value = "form")
	public String form(Employe employe, Model model) {
		User user = UserUtils.getUser();
		
		List<Record> emps = employeService.findBySiteId(getCurrentSiteId(user));
		model.addAttribute("employe", emps);
		return "modules/" + "order/employeGpsForm";
	}

	@RequestMapping(value = "save")
	public String save(Employe employe, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, employe)){
			return form(employe, model);
		}
		employeService.save(employe);
		addMessage(redirectAttributes, "保存服务工程师'" + employe.getName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/order/employe/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		employeService.delete(id);
		addMessage(redirectAttributes, "删除服务工程师成功");
		return "redirect:"+Global.getAdminPath()+"/order/employe/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value = "ajaxEmploye")
	public String getajax( HttpServletRequest request, HttpServletResponse response){

		User user = UserUtils.getUser();
		String lnglat = request.getParameter("lnglat");
		String siteId = getCurrentSiteId(user);
     List<Map<String,String>> list = employeService.getEmployeOrder(siteId, lnglat);		
      return JsonMapper.nonDefaultMapper().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value = "isLocEmploye")
	public String isLocEmploye (HttpServletRequest request){
		String empId = request.getParameter("empId");
		return employeService.isLocEmploye(empId);
	}
	
	@RequestMapping(value = "locEmploye")
	public String locEmploye(HttpServletRequest request, Model model){
		String empId = request.getParameter("empId");
		Map<String, Object> map = employeService.locEmploye(empId);
		model.addAttribute("empLoc", map);
		return "modules/order/staff/locEmploye";
	}
	/** 考勤签到统计
	*/
	@RequestMapping(value = "gettodaySign")
	public String gettodaySign(HttpServletRequest request, Model model){
		User user = UserUtils.getUser();
		String siteId = getCurrentSiteId(user);
		Record rd = employeService.gettodaySign(siteId,"1");
		model.addAttribute("rd", rd);
		JSONArray arr = employeService.getCountForms(siteId,"1");
		model.addAttribute("data", arr);
		return "modules/order/staff/empCheckworkAttendance";
	}
	/** 考勤签退统计
	 */
	@RequestMapping(value = "gettodaySignout")
	public String gettodaySignout(HttpServletRequest request, Model model){
		User user = UserUtils.getUser();
		String siteId = getCurrentSiteId(user);
		Record rd = employeService.gettodaySign(siteId,"0");
		model.addAttribute("rdout", rd);
		JSONArray arr = employeService.getCountForms(siteId,"0");
		model.addAttribute("data", arr);
		return "modules/order/staff/empNotCheckworkAttendance";
	}

	/**
	 * 直接派工时，需要显示网点的所有服务工程师。
     */
	@ResponseBody
	@RequestMapping(value = "dispatchList")
	public Object getEmployeList(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String lnglat = request.getParameter("lnglat");
		String category = request.getParameter("category");
		String address = request.getParameter("address");
		String ids = null ;
		String siteId = CrmUtils.getCurrentSiteId(user);
		if (StringUtils.isEmpty(category)) {
		} else {
			ids = CategoryUtils.getSiteCategoryId1(category, siteId);
		}
		return employeService.getEmployeOrder2(siteId, lnglat,ids,address);
	}
	
	@RequestMapping(value="empSearch")
	@ResponseBody
	public Object empSearch(HttpServletRequest request){
		String category = request.getParameter("category");
		String name = request.getParameter("name");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Integer id = null ;
		if(StringUtils.isEmpty(category)){
		}else{
			id = CategoryUtils.getSiteCategoryId(category,siteId);
		}
		return employeService.empSearch(siteId, id, name);
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "getSameDayOnlineEmploye")
	public Object getSameDayOnlineEmploye(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String empId = request.getParameter("empId");
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<Record> list = employeService.getSameDayOnlineEmploye(siteId,empId);
		return list;
	}
	/**
	 * 工程师近一周考勤统计时间
	*/
	@ResponseBody
	@RequestMapping(value = "getEmployeSign")
	public Object getEmployeSign(HttpServletRequest request,HttpServletResponse response) {
		List<String> lis = employeService.getCountForm();
		return lis;
	}

	@ResponseBody
	@RequestMapping(value = "getSiteEmploye")
	public String getSiteEmploye( HttpServletRequest request, HttpServletResponse response){

		User user = UserUtils.getUser();
		String siteId = getCurrentSiteId(user);
        List<Map<String,String>> list = employeService.getSiteEmploye(siteId);		
      return JsonMapper.nonDefaultMapper().toJson(list);
	}
	/**
	 * 如何当前用户为服务商用户，获取当前用户的服务商id
	 * @return 服务商id
	 */
	private String getCurrentSiteId(User user) {
		
		String Id=CrmUtils.getCurrentSiteId(user);
		return Id;
	}

	/**
	 * 获取指定的服务工程师
	 */
	@ResponseBody
	@RequestMapping(value = "show/{id}")
	public Employe show(@PathVariable("id") String id) {
		return employeService.get(id);
	}

	//查询短信发送记录
	@RequestMapping(value="getsended")
	public String getSended(HttpServletRequest  request,HttpServletResponse response,Model moble){
		User user = UserUtils.getUser();
		String siteId = getCurrentSiteId(user); 
		Page<Record> page = employeService.getSmsSended(siteId, new Page<Record>(request, response));
		moble.addAttribute("page", page);
		return "modules/order/sms/smsRecordList";
	}
}
