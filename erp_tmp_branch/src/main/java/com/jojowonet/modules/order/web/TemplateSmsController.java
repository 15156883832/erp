package com.jojowonet.modules.order.web;

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
import com.jojowonet.modules.order.entity.Brand;
import com.jojowonet.modules.order.entity.TemplateSms;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.TemplateSmsService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;


@Controller
@RequestMapping(value = "${adminPath}/order/smsTemplate")
public class TemplateSmsController extends  BaseController{
@Autowired
private TemplateSmsService templateSmsService;

@RequestMapping(value = { "list", "" })
public String list(HttpServletRequest request,HttpServletResponse response, Model model) {
	String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
	model.addAttribute("headerData", stf);
	return "modules/" + "order/smsTemplatelist";
}

@RequestMapping(value = "smsTemplatelist")
@ResponseBody
public String smsTemplatelist(HttpServletRequest request,
		HttpServletResponse response, Model model) {
	//String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	Page<Record> page = new Page<>(request, response);
	page = templateSmsService.getTemplatelist(page);
	model.addAttribute("page", page);
	JqGridPage<Record> jqp = new JqGridPage<>(page);
	return renderJson(jqp);
}
//添加模板
@RequestMapping("addtemplate")
public void addtemplate(String tid,String name,String tag,String content,HttpServletRequest request,HttpServletResponse response){
	String siteId=CrmUtils.getCurrentSiteId(UserUtils.getUser());
	TemplateSms temsms=new TemplateSms();
	temsms.setNumber(tid);
	temsms.setName(name);
	temsms.setContent(content);
	temsms.setCreateBy(UserUtils.getUser().getId());
	temsms.setCreateType(UserUtils.getUser().getUserType());
	temsms.setTag(tag);
	temsms.setSite_id(siteId);
	templateSmsService.save(temsms);
	
	
}
//根据id查找模板
@RequestMapping("gettemplatebyid")
@ResponseBody
public Record getTemplateById(String id){
	Record templatesms=templateSmsService.queryTemplateById(id);
	return templatesms;
}
//更新模板
@RequestMapping("updatetemplate")
public void updateTemplate(String id,String tid,String tag,String content,String name){
	templateSmsService.updateTemplate(id,tid,tag,content,name);
}
//删除模板
@RequestMapping("deletetemplate")
public void deletetemplate(String[] idArr){
	for(int i=0;i<idArr.length;i++){
		templateSmsService.delete(idArr[i]);
	}
	
}
	
	
}
