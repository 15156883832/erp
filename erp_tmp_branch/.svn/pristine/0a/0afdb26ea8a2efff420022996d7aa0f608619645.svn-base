/**
 */
package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Map;

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

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.web.BaseController;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.google.common.collect.Maps;
import com.jojowonet.modules.order.entity.Township;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.TownshipService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

/**
 * 乡镇信息Controller
 * @author Ivan
 * @version 2018-01-20
 */
@Controller
@RequestMapping(value = "${adminPath}/order/township")
public class TownshipController extends BaseController {

	@Autowired
	private TownshipService townshipService;
	
	@ModelAttribute
	public Township get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return townshipService.get(id);
		}else{
			return new Township();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(Township township, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
    	model.addAttribute("headerData", stf);
		return "modules/" + "order/townshipList";
	}
	
	@RequestMapping(value = "townshipList")
	@ResponseBody
	public String originList(Township township, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Township> page = new Page<>(request, response);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		page = townshipService.find(new Page<Township>(request, response),siteId);
		model.addAttribute("page",page);
		JqGridPage<Township> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	@RequestMapping(value = "getCheckName")
	@ResponseBody
	public Object getCheckName(HttpServletRequest request, HttpServletResponse response) {
		String name = request.getParameter("name");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return townshipService.getCheckName(siteId, name);
	}
	
	@RequestMapping(value="checkNames")
	public void checkNames(String[] nameArr,HttpServletRequest request,HttpServletResponse response){
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		boolean flag=false;
		for(int i=0;i<nameArr.length;i++){
			 flag = townshipService.getCheckName(site_id, nameArr[i]);
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

	@RequestMapping(value = "form")
	public String form(Township township, Model model) {
		model.addAttribute("township", township);
		return "modules/" + "order/townshipForm";
	}
	
	
	@RequestMapping(value = "edite")
	public String edite(Township township, Model model) {
		model.addAttribute("township", township);
		return "modules/" + "order/townshipEdite";
	}

	@RequestMapping(value = "save")
	@ResponseBody
	public  String save(String[] nameArr, String[] sortsArr, HttpServletResponse response) {
			User user = UserUtils.getUser();
		for (int i=0;i<nameArr.length;i++) {
			Township township=new Township();
			township.setName(nameArr[i]);
			if(sortsArr.length>0&&sortsArr[i].length()!=0){
				if(sortsArr[i].equals("0")){
					sortsArr[i]="0";
				}
				township.setSort(Integer.valueOf(sortsArr[i]));
			}
			String siteId = CrmUtils.getCurrentSiteId(user);
			township.setCreateBy(user.getId());
			township.setSiteId(siteId);
			townshipService.save(township);	
		}
		return null;
	}
	
	@RequestMapping(value = "delete")
	@ResponseBody
	public Boolean delete(String[] idsArr, HttpServletResponse response) {
		for (int i=0;i<idsArr.length;i++) {
			townshipService.delete(idsArr[i]);
		}
		
		
		return true;
	}

	@RequestMapping("update")
	public void update(HttpServletRequest request, String name,String sort,String id){
      if(sort.length()==0||sort.equals("0")){
	      sort="0";
       }
      townshipService.updates(name,sort,id);
		
	}

}
