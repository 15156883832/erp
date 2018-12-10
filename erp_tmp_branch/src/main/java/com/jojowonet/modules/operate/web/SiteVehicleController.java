/**
 */
package com.jojowonet.modules.operate.web;

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
import com.jojowonet.modules.operate.entity.SiteVehicle;
import com.jojowonet.modules.operate.service.SiteVehicleService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

/**
 * 车辆信息Controller
 * @author lzp
 * @version 2018-10-31
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/siteVehicle")
public class SiteVehicleController extends BaseController {

	@Autowired
	private SiteVehicleService siteVehicleService;
	
	@RequestMapping(value = {"list", ""})
	public String list(SiteVehicle siteVehicle, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "operate/siteVehicleList";
	}
	
	@ResponseBody
	@RequestMapping(value = "siteVehicleList")
	public String getWwgList(SiteVehicle siteVehicle,HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Page<SiteVehicle> page = siteVehicleService.find(new Page<SiteVehicle>(request, response), siteVehicle,siteId); 
	    model.addAttribute("page", page);
		return renderJson(new JqGridPage<>(page));
	}
	
	@RequestMapping(value = "form")
	public String form(SiteVehicle siteVehicle, Model model) {
		
		return "modules/" + "operate/siteVehicleForm";
	}
	
	/*服务上新增时验证*/
	@RequestMapping(value="sitequeryNum")
	public void sitequeryNum(String[] nameArr,HttpServletRequest request,HttpServletResponse response){
		boolean flag=false;
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		for(int i=0;i<nameArr.length;i++){
			 flag = siteVehicleService.getCheckNumber(nameArr[i],siteId);
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

	@ResponseBody
	@RequestMapping(value = "save")
	public String save(String[] number,HttpServletRequest request,HttpServletResponse response) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		
	return siteVehicleService.save(number,siteId,user.getId());

	}
	@ResponseBody
	@RequestMapping(value = "deleteVehicle")
	public String deleteVehicle(String id,HttpServletRequest request,HttpServletResponse response) {
		if(StringUtils.isBlank(id)) {
			return "no";
		}
		siteVehicleService.deleteVehicle(id);
		return "ok";
		
	}
	
	
	
}
