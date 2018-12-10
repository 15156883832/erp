package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Map;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
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
import com.jfinal.plugin.activerecord.Record;

import com.jojowonet.modules.order.entity.ServiceMode;
import com.jojowonet.modules.order.entity.ServiceType;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.ServiceTypeService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

@Controller
@RequestMapping(value="${adminPath}/order/serviceType")
public class ServiceTypeController extends BaseController {

	@Autowired
	private ServiceTypeService serviceTypeService;
	
	@ModelAttribute
	public ServiceType get(@RequestParam(required=false) Integer id) {
		if (id!=null){
			return serviceTypeService.get(id);
		}else{
			return new ServiceType();
		}
	}
	
	@RequestMapping(value={"list",""})
	public String list(ServiceType serviceType,HttpServletRequest request,HttpServletResponse response,Model model){		
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		if(StringUtils.isNotBlank(siteId)) {
			return "modules/" + "order/siteServiceTypeList";
		}
		return "modules/" + "order/serviceTypeList";
	}
	
	
	@RequestMapping(value="serviceTypeList")
	@ResponseBody
	public String serviceTypeList(ServiceType serviceType,HttpServletRequest request,HttpServletResponse response,Model model){	
		Page<ServiceType> page  = serviceTypeService.find(new Page<ServiceType>(request, response),serviceType);
		JqGridPage<ServiceType> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	/*服务商自定义*/
	@RequestMapping(value="siteServiceTypeList")
	@ResponseBody
	public String siteServiceTypeList(HttpServletRequest request,HttpServletResponse response){	
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record> page = serviceTypeService.getServiceTypePage(new Page<Record>(request, response),siteId);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	/*
	 * 删除，如果是平台默认的，则新增一条删除记录，否则只是更改状态
	*/
	@RequestMapping(value = "deleteMall")
    @ResponseBody
	public String delete(String id,HttpServletRequest request,HttpServletResponse response) {
		if(StringUtils.isNotBlank(id)){
			Integer ids=Integer.valueOf(id);
			serviceTypeService.deleteServiceType(ids);
		return "ok";
		}
		return "no";
	}
	
	/*服务商自定义添加*/
	@RequestMapping(value = "siteServiceTypeForm")
	public String siteServiceTypeForm(ServiceType serviceType, Model model) {
		User user =UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		model.addAttribute("siteId", siteId);
		model.addAttribute("serviceType", serviceType);
		return "modules/" + "order/siteServiceTypeForm";
	}
	
	@RequestMapping(value = "saveServiceType")
	public @ResponseBody String saveServiceType(String[] nameArr, String[] sortsArr, String[] isDefaultArr, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes ) {
		try {
			for (int i=0;i<nameArr.length;i++) {
				User user =UserUtils.getUser();
				String siteId = CrmUtils.getCurrentSiteId(user);
				ServiceType serviceType=new ServiceType();
				serviceType.setName(nameArr[i]);
				if(sortsArr.length>0&&sortsArr[i].length()!=0){
					if(sortsArr[i].equals("0")){
						sortsArr[i]="0";
					}
					serviceType.setSort(Integer.valueOf(sortsArr[i]));
				}
				serviceType.setIsDefault(isDefaultArr[i]);
				serviceType.setSiteId(siteId);
				serviceType.setCreateBy(user.getId());
				serviceTypeService.save(serviceType);	
			}
		} catch (Exception e) {
			return "no";
			
		}
		return "ok";
	}
	
	/*服务商新增是验证*/
	@RequestMapping(value="sitequeryNum")
	public void sitequeryNum(String[] nameArr,HttpServletRequest request,HttpServletResponse response){
		boolean flag=false;
		String siteId = request.getParameter("siteId");
		for(int i=0;i<nameArr.length;i++){
			 flag = serviceTypeService.sitequeryNumByName(nameArr[i],siteId,null);
			 if(flag){
			break;
			 }
		}	
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*服务商修改时验证*/
	@RequestMapping(value="siteUpdaqueryNums")
	public void siteUpdaqueryNums(String names,String id,HttpServletRequest request,HttpServletResponse response){
		boolean flag=false;
		String siteId = request.getParameter("siteId");
		Integer ids=Integer.valueOf(id);
	    flag = serviceTypeService.sitequeryNumByName(names,siteId,ids);
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*服务商修改*/
	@ResponseBody
	@RequestMapping("siteupdate")
	public Object siteupdate(String names,String sorts,String id,HttpServletRequest request,HttpServletResponse response){
		try {
			String isDef = request.getParameter("isDef");
			if(StringUtils.isBlank(id)) {
				return "no";
			}
			if(sorts.length()==0||sorts.equals("0")){
				sorts="0";
			}
			Integer ids=Integer.valueOf(id);
			serviceTypeService.siteupdates(names, sorts, ids, isDef);
			
		} catch (Exception e) {
			return "no";
		}
		return "ok";
	}
	
	
	@RequestMapping(value = "form")
	public String form(ServiceType serviceType, Model model) {
		model.addAttribute("serviceType", serviceType);
		return "modules/" + "order/serviceTypeForm";
	}
	
	@RequestMapping(value="edite")
	public String edite(String id,Model model){	
		User user = UserUtils.getUser();
		Integer ids=Integer.valueOf(id);
		Record rd=serviceTypeService.getServiceTypeById(ids);
		model.addAttribute("serviceType",rd);
		if(user.getUserType().equals(User.USER_TYPE_YYS)) {
			return "modules/" + "order/serviceTypeEdite";
		}
		String siteId = CrmUtils.getCurrentSiteId(user);
		model.addAttribute("siteId",siteId);
		return "modules/" + "order/siteServiceTypeEdite";
	}
	
	@RequestMapping(value = "save")
	public @ResponseBody String save(String[] nameArr, String[] sortsArr, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes ) {
		for (int i=0;i<nameArr.length;i++) {
      ServiceType serviceType=new ServiceType();
      serviceType.setName(nameArr[i]);
			if(sortsArr.length>0&&sortsArr[i].length()!=0){
				if(sortsArr[i].equals("0")){
					sortsArr[i]="0";
				}
				serviceType.setSort(Integer.valueOf(sortsArr[i]));
			}
			serviceType.setSiteId("0");
			serviceTypeService.save(serviceType);	
		}
		return null;
	}
	
	@RequestMapping("update")
	public void update(String names,String sorts,String id){
      if(sorts.length()==0||sorts.equals("0")){
	      sorts="0";
       }
      Integer ids=Integer.valueOf(id);
      serviceTypeService.updates(names,sorts,ids);
	}
	
	@RequestMapping(value = "deleteserviceType")
	public String delete(String id, RedirectAttributes redirectAttributes) {
			Integer ids=Integer.valueOf(id);
			serviceTypeService.delete(ids);
		    return "redirect:"+Global.getAdminPath()+"/order/serviceType";
	}
	
	@RequestMapping(value="queryNum")
	public void queryNumByName(String[] nameArr,HttpServletRequest request,HttpServletResponse response){
		boolean flag=false;
		for(int i=0;i<nameArr.length;i++){
			 flag = serviceTypeService.queryNumByName(nameArr[i]);
			 if(flag){
			break;
			 }
		}	
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="queryNums")
	public void queryNumByNames(String names,String id,HttpServletRequest request,HttpServletResponse response){
		boolean flag=false;
		Integer ids=Integer.valueOf(id);
	    flag = serviceTypeService.queryNumByNames(names,ids);
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
}
