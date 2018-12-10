package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Map;

import ivan.common.config.Global;
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
import com.jojowonet.modules.order.entity.OrderType;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.OrderTypeService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

@Controller
@RequestMapping(value="${adminPath}/order/orderType")
public class OrderTypeController extends BaseController {
	
	@Autowired
	private OrderTypeService orderTypeService;
	
	@ModelAttribute
	public OrderType get(@RequestParam(required=false) String id) {
		if (!"0".equals(id)&&StringUtils.isNotBlank(id)){
			return orderTypeService.get(id);
		}else{
			return new OrderType();
		}
	}
	
	
	@RequestMapping(value = {"list", ""})
	public String list(OrderType orderType,HttpServletRequest request,HttpServletResponse response,Model model){
		//需要涉及到表头设置时才调用，如果不需要使用表头设置，则不需
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/orderTypeList";
		/*return "modules/" + "order/orderOriginList";*/
	}
	
	@RequestMapping(value="orderTypeList")
	@ResponseBody
	public String orderTypeList(Model model,HttpServletRequest request,HttpServletResponse response,OrderType orderType){
		Page<OrderType> page = new Page<>(request, response);
		page = orderTypeService.find(new Page<OrderType>(request, response)); 
		model.addAttribute("page",page);
		JqGridPage<OrderType> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	@RequestMapping(value="form")
	public String form(OrderType orderType,Model model){
		
		model.addAttribute("orderType",orderType);
		return "modules/" + "order/orderTypeForm";
	}
	
	@RequestMapping(value="save")
	public String save(OrderType orderType,RedirectAttributes redirectAttributes,HttpServletResponse response){
			orderTypeService.save(orderType);
			addMessage(redirectAttributes, "保存来源'" + orderType.getName() + "'成功");
			
		return "redirect:"+Global.getAdminPath()+"/order/orderType";
	}
	
	@RequestMapping(value="delete")
	public String delete(String id){
		
			orderTypeService.delete(id);
		return "redirect:"+Global.getAdminPath()+"/order/orderType";
	}
	
	@RequestMapping(value="queryNum")
	public void queryNumByName(@RequestParam(value="rname") String rname,HttpServletRequest request,HttpServletResponse response){
		boolean flag = orderTypeService.queryNumByName(rname);
		Map<String,Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
