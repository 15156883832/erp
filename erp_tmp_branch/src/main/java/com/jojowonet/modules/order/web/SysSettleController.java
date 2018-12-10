package com.jojowonet.modules.order.web;


import java.util.Date;
import java.util.Iterator;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
















import ivan.common.config.Global;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.ProLimit;
import com.jojowonet.modules.order.entity.sysSettle;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SysSettleService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;



@Controller
@RequestMapping(value = "${adminPath}/order/settle")
public class SysSettleController extends BaseController {
	@Autowired
	private SysSettleService sysysettleService;
	
	@RequestMapping("settletable")
	public String getSettletable(SiteTableHeaderForm headerForm, HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/order/sysSettle";
	}
	@RequestMapping("settleList")
	@ResponseBody
	public String getSettleList(HttpServletRequest request, HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record>	page = sysysettleService.getlistSys(new Page<Record>(request, response),siteId);
		//model.addAttribute("page",page);
		return renderJson(new JqGridPage<>(page));
	}
	
	@RequestMapping("toadd")
	public String toadd(){
		return "modules/order/sysSettleadd";
	}
	@RequestMapping("save")
	public String save(String type,String figure,Model model,RedirectAttributes redirectAttributes){
		sysSettle sys=new sysSettle();
		sys.setFigure(figure);
		sys.setStatus("0");
		sys.setType(type);
		sys.setCreateTime(new Date());
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		sys.setSite_id(siteId);
		sysysettleService.save(sys);
		addMessage(redirectAttributes, "保存'" +type + "'成功");
		return "redirect:"+Global.getAdminPath()+"/order/settle/toadd";

	}
@RequestMapping("querytype")
public  @ResponseBody String querytype(String s){
	List<Record> type=sysysettleService.querysettletype();
	String msg="";
	List<String> typelist = Lists.newArrayList();
	if(type != null){
		for(Record tp :type){
			typelist.add(tp.getStr("type"));
		}
	}


		Iterator< String> it=typelist.iterator();
		while(it.hasNext()){
			if(s.equals(it.next())){
				msg="设置名已存在";
			}
		}
	
	return msg;
}
@RequestMapping("deletesettle")
public String deletesettle(String id,HttpServletRequest request,HttpServletResponse response) {
	sysysettleService.deletesettle(id);
	return "redirect:"+Global.getAdminPath()+"/order/settle/settletable";
}
@RequestMapping("updatesettle")
public String updatesettle(String id,HttpServletRequest request,HttpServletResponse response) {
	sysysettleService.updatesettle(id);
	return "redirect:"+Global.getAdminPath()+"/order/settle/settletable";
}
@RequestMapping("updatesettles")
public String updatesettles(String id,HttpServletRequest request,HttpServletResponse response) {
	sysysettleService.updatesettles(id);
	return "redirect:"+Global.getAdminPath()+"/order/settle/settletable";
}
}
