/**
 */
package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Map;

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
import net.sf.json.JSONObject;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.google.common.collect.Maps;
import com.jojowonet.modules.order.entity.CustomerType;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.CustomerTypeService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

/**
 * 用户类型Controller
 * @author lzp
 * @version 2018-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/order/customerType")
public class CustomerTypeController extends BaseController {

	@Autowired
	private CustomerTypeService customerTypeService;
	
	@RequestMapping(value = {"list", ""})
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		return "modules/" + "order/customerTypeList";
	}
	
	@RequestMapping(value="customerTypeList")
	@ResponseBody
	public String serviceTypeList(CustomerType customerType,HttpServletRequest request,HttpServletResponse response,Model model){	
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Page<CustomerType> page = customerTypeService.find(new Page<CustomerType>(request, response), customerType,siteId); 
		JqGridPage<CustomerType> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@RequestMapping(value = "form")
	public String form(CustomerType customerType, Model model) {
		model.addAttribute("customerType", customerType);
		return "modules/" + "order/customerTypeForm";
	}

	@ResponseBody 
	@RequestMapping(value = "save")
	public String save(String[] nameArr, HttpServletRequest request ,  HttpServletResponse response) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		for (int i=0;i<nameArr.length;i++) {
			CustomerType customerType=new CustomerType();
			customerType.setName(nameArr[i]);
			customerType.setSiteId(siteId);
			customerTypeService.save(customerType);	
		}
		return "ok";
	}
	
	@RequestMapping(value = "delete")
	@ResponseBody
	public String delete(String id,HttpServletRequest request,HttpServletResponse response) {
		try {
			customerTypeService.delete(id);
		} catch (Exception e) {
			return "no";
		}
		return "ok";
	}
	
	/*服务商修改*/
	@ResponseBody
	@RequestMapping("siteupdate")
	public Object siteupdate(String names,String id,HttpServletRequest request,HttpServletResponse response){
		try {
			if(StringUtils.isBlank(id)) {
				return "no";
			}
			customerTypeService.siteupdates(names, id);
		} catch (Exception e) {
			return "no";
		}
		return "ok";
	}
	
	
	/*服务商新增是验证*/
	@RequestMapping(value="sitequeryNum")
	public void sitequeryNum(String[] nameArr,HttpServletRequest request,HttpServletResponse response){
		boolean flag=false;
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		for(int i=0;i<nameArr.length;i++){
			 flag = customerTypeService.sitequeryNumByName(nameArr[i],siteId,"");
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
	    flag = customerTypeService.sitequeryNumByName(names,siteId,id);
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

}
