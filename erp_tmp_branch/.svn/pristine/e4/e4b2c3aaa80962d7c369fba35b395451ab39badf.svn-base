package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import ivan.common.config.Global;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
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
import com.jojowonet.modules.order.entity.Unit;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.UnitService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;


@Controller
@RequestMapping(value = "${adminPath}/order/unit")
public class UnitController extends  BaseController{
	
	@Autowired
	private UnitService unitService;

	
	@ModelAttribute
	public Unit get(@RequestParam(required=false) Integer id) {
		if (id!=null){
			return unitService.get(id);
		}else{
			return new Unit();
		}
	}
	
	@RequestMapping(value={"list",""})
	public Object list(Unit unit,HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/unit";
	}
	
	@RequestMapping(value="unitList")
	@ResponseBody
	public String unitList(Unit unit,HttpServletRequest request,HttpServletResponse response,Model model){
		Page<Unit> page = new Page<>(request, response);
		page = unitService.find(new Page<Unit>(request, response),unit);
		model.addAttribute("page",page);
		JqGridPage<Unit> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	@RequestMapping(value = "form")
	public String form(Unit unit, Model model) {
		model.addAttribute("unit", unit);
		return "modules/" + "order/unitForm";
	}
	
	@RequestMapping(value="edite")
	public String edite(String id,Model model){
		Integer ids=Integer.valueOf(id);
		Record rd=unitService.getUnitById(ids);
		model.addAttribute("unit",rd);
		return "modules/" + "order/unitEdite";
	}
	
	@RequestMapping(value = "save")
	public @ResponseBody String save(String[] nameArr, String[] typeArr, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes ) {
		String userId = UserUtils.getUser().getId();
		for (int i=0;i<nameArr.length;i++) {
      Unit unit=new Unit();
      unit.setCreateBy(userId);
      unit.setName(nameArr[i]);
			if(typeArr.length>0&&typeArr[i].length()!=0){
				unit.setType(typeArr[i]);
			}
			unitService.save(unit);	
		}
		return null;
	}
	
	@RequestMapping("update")
	public void update(String names,String type,String id){
      if(type.length()==0){
	      type="d";
       }
      Integer ids=Integer.valueOf(id);
      unitService.updates(names,type,ids);	
	}
	
	@RequestMapping(value = "deleteunit")
	public String delete(String id, RedirectAttributes redirectAttributes) {
			Integer ids=Integer.valueOf(id);
			unitService.delete(ids);
		return "redirect:"+Global.getAdminPath()+"/order/unit";
	}
	@RequestMapping(value="queryNums")
	public void queryNumByNames(String[] nameArr,String id,HttpServletRequest request,HttpServletResponse response){
		Integer ids;
        if(id!=null){
            ids=Integer.valueOf(id);
         }else{
            ids=null;
         }
		boolean flag=false;
		for(int i=0;i<nameArr.length;i++){
			 flag = unitService.queryNumByNames(nameArr[i],ids);
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
}
