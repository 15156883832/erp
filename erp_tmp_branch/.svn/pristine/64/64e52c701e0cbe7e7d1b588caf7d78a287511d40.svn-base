package com.jojowonet.modules.order.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Brand;
import com.jojowonet.modules.order.entity.Vender;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.VenderService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;



@Controller
@RequestMapping(value = "${adminPath}/order/VendorSet")
public class VenderController extends BaseController{
	@Autowired
	private VenderService venderService;
	
	
	@RequestMapping(value = { "list", "" })
	public String list(Brand brand, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		List<String> venderName=venderService.getVenderName();
		model.addAttribute("nameList", venderName);
		model.addAttribute("headerData", stf);
		return "modules/" + "order/venderList";
	}

	@RequestMapping(value = "venderList")
	@ResponseBody
	public String brandsettleListList(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Record> page = new Page<>(request, response);
		page = venderService.findVenderList(page);
		model.addAttribute("page", page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	
	//跳转到添加厂家资料框
	@RequestMapping(value = "tovenderForm")
	public String tovenderForm(Model model){
		List<String> venderName=venderService.getVenderName();
		model.addAttribute("nameList", venderName);
		return "modules/" + "order/venderForm";
	}
	//根据id查询厂家资料
	@RequestMapping(value = "getVenderById")
	@ResponseBody
	public Record getVenderById(String id,Model model){
		Record rd =venderService.findVenderById(id);
		return rd;
	}
	
	//保存添加或者修改的厂家资料
	@RequestMapping(value = "saveVender")
	@ResponseBody
	public boolean saveVender(String name,String url,String id,Model model){

		boolean flag;
		if(StringUtils.isEmpty(id)){
			Vender vender=new Vender();
			vender.setName(name);
			vender.setUrl(url);
			flag=venderService.save(vender);
		}else{
			Vender vender=new Vender();
			vender.setId(id);
			vender.setName(name);
			vender.setUrl(url);
			flag=venderService.save(vender);
		}
		return flag;
	}
	
	//删除厂家
	@RequestMapping(value = "delete")
	@ResponseBody
	public Integer delete(String id){
		Integer i=null;
		i=venderService.delete(id);
		return i;
	}

}
