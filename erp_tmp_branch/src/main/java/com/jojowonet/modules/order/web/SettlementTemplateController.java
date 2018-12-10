/**
 */
package com.jojowonet.modules.order.web;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jojowonet.modules.operate.service.EmployeService;

import com.jojowonet.modules.order.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ivan.common.web.BaseController;
import ivan.common.entity.mysql.common.User;
import ivan.common.mapper.JsonMapper;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.google.common.collect.Lists;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Category;
import com.jojowonet.modules.order.entity.SettlementTemplate;
import com.jojowonet.modules.order.service.SettlementTemplateService;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;

/**
 * 结算措施Controller
 * @author Ivan
 * @version 2017-05-26
 */
@Controller
@RequestMapping(value = "${adminPath}/order/settlementTemplate")
public class SettlementTemplateController extends BaseController {

	@Autowired
	private SettlementTemplateService settlementTemplateService;

	@ModelAttribute
	public SettlementTemplate get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return settlementTemplateService.get(id);
		}else{
			return new SettlementTemplate();
		}
	}
	
	  @ResponseBody
		@RequestMapping(value = "getsetMea")	
		public String getsetMea(HttpServletRequest request,HttpServletResponse response){
			String serviceMeasures = request.getParameter("serviceMeasures");
			String category = request.getParameter("category");
			String warrantyType = request.getParameter("warranty_type");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			List<Record> list = settlementTemplateService.getListSetMea(category, serviceMeasures, siteId,warrantyType);
			return JsonMapper.nonDefaultMapper().toJson(list);
		}
	  /**
	   * 结算设置列表
	  */
		@RequestMapping(value = {"list", ""})
	    public String list(HttpServletRequest request, HttpServletResponse response, Model model,String servicemeasures,String category) {
	        User user = UserUtils.getUser();
	        String siteId = CrmUtils.getCurrentSiteId(user);
	        if(StringUtils.isNotBlank(servicemeasures)){
		        try {
					servicemeasures =  java.net.URLDecoder.decode(servicemeasures,"UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
	        }
	       // List<Category> list = CategoryUtils.getSiteCategoryList(siteId);
	        List<Category> list = CategoryUtils.getSiteCategoryListfornotnull(siteId);
	        Integer cate =null;
	        //if(category!=null){
	        if(StringUtils.isNotBlank(category)){
	        	cate=Integer.valueOf(category);
	        }else{
	            if(list != null && list.size() > 0) {
                    cate = list.get(0).getId();
                }
	        }
	        Page<HashMap<String, List<SettlementTemplate>>> pagess =  new Page<HashMap<String, List<SettlementTemplate>>>(request, response);
	        Page<HashMap<String, List<SettlementTemplate>>> page = settlementTemplateService.getListSettlementTemplate(siteId, new Page<HashMap<String, List<SettlementTemplate>>>(request, response), cate, servicemeasures);
	        model.addAttribute("cateId", cate);
	        model.addAttribute("catelist", list);
	        model.addAttribute("page", page);
	        if(StringUtils.isNotBlank(servicemeasures)){
	        	 model.addAttribute("sms", servicemeasures);
	        }
			model.addAttribute("pos", "0px");
	        return "modules/" + "order/settlementTemplateList";
	    }
		
		//在列表中点击其他品类
	    @RequestMapping(value = "getlist")
	    public String getlistMal(HttpServletRequest request, HttpServletResponse response, Model model) {
	        User user = UserUtils.getUser();
	        String siteId = CrmUtils.getCurrentSiteId(user);
		       
	        List<Category> list =  CategoryUtils.getSiteCategoryListfornotnull(siteId);
	        String serviceMeasures = request.getParameter("serviceMeasures");
	      
	        Integer cate = null;
	        if (StringUtils.isNotBlank(request.getParameter("categroy"))) {
	        	String category = request.getParameter("categroy");
	        	cate = Integer.valueOf(category);
	        }
	        Page<HashMap<String, List<SettlementTemplate>>> page = settlementTemplateService.getListSettlementTemplate(siteId, new Page<HashMap<String, List<SettlementTemplate>>>(request, response), cate, serviceMeasures);
	        model.addAttribute("cateId", cate);
	        model.addAttribute("catelist", list);
	        model.addAttribute("page", page);
			String pos = request.getParameter("pos");
			if (StringUtil.isBlank(pos)) {
				pos = "0px";
			}
			model.addAttribute("pos", pos);
	        model.addAttribute("serviceMeasures", serviceMeasures);
	        return "modules/" + "order/settlementTemplateList";
	    }
	    
		@RequestMapping(value = "saveset")
	    @ResponseBody
	    public Object saveMal(HttpServletRequest request, HttpServletResponse response) {
			JsonParser parser = new JsonParser();
	    	 String result = request.getParameter("result");
	    	 String solution = request.getParameter("solution");
	    	 String settype = request.getParameter("settype");
	    	 String setamount = request.getParameter("setamount");
		     HashMap<String, String> ret = new HashMap<>();
	    	 try {
	    	JsonArray resu = parser.parse(result).getAsJsonArray();
	    	JsonArray solu = parser.parse(solution).getAsJsonArray();
	    	JsonArray stype = parser.parse(settype).getAsJsonArray();
	    	JsonArray sam = parser.parse(setamount).getAsJsonArray();
	    	 String serviceMeasures = request.getParameter("serviceMeasures");//服务措施
	    	 String warrantyType = request.getParameter("warrantyType");//保修类型
	    	 String categ = request.getParameter("cate");//品类
	    	 User user = UserUtils.getUser();
	    	 List<SettlementTemplate> list = Lists.newArrayList();
	    	 for(int i=0;i<resu.size();i++){
	    		 String chargeName = resu.get(i).getAsString();
	    		 String basis_type = solu.get(i).getAsString();//收费依据
	    		 String charge_amount = stype.get(i).getAsString();//结算方式（金额或比例）
	    		 String charge_proportion = sam.get(i).getAsString();//提成金额或提成比例
	    		 SettlementTemplate mal = new SettlementTemplate();
	                mal.setSiteId(CrmUtils.getCurrentSiteId(user));
	                mal.setCreateBy(user.getId());
	                mal.setWarrantyType(warrantyType);
	                mal.setServiceMeasures(serviceMeasures);
	                mal.setCategory(categ);
	                mal.setChargeName(chargeName);
	                if("服务费".equals(basis_type)){
	                	mal.setBasisType("1");
	                }else if("辅材费".equals(basis_type)){
	                	mal.setBasisType("2");
	                }else if("延保费".equals(basis_type)){
	                	mal.setBasisType("3");
	                }else if("辅材费-入库价格".equals(basis_type)){
	                	mal.setBasisType("4");
	                }else if("厂家结算费".equals(basis_type)) {
	                	mal.setBasisType("5");
					} else if("辅材费-工程师价格".equals(basis_type)) {
						mal.setBasisType("6");
					}
	                else if(StringUtils.isNotEmpty(basis_type)||basis_type==""||basis_type.length()==0){
	                	mal.setBasisType("0");
	            		if(StringUtils.isNumeric(basis_type)){
							mal.setBasisAmount(new Double(basis_type));
						}else{
							mal.setBasisAmount(new Double("0"));
						}
	                	
	                }
	                if("1".equals(charge_amount)){//按金额
	            		if(charge_proportion==""||charge_proportion.length()==0){
							mal.setChargeAmount(new Double("0"));
						}else{
							mal.setChargeAmount(new Double(charge_proportion));
						}
	                }else if("2".equals(charge_amount)){//按比例
	                	if(charge_proportion==""||charge_proportion.length()==0){
							mal.setChargeProportion(0);
						}else{
							mal.setChargeProportion(Integer.valueOf(charge_proportion));
						}
	                }
	                list.add(mal);
	    	 }
	    	 		settlementTemplateService.saveList(list);
	    	  	ret.put("ok", "true");
	    	 	} catch (Exception e) {
	    		 ret.put("ok", "false");
				}
	  
	        return ret;
	    }
		//修改
		@RequestMapping(value = "getupSettel")
		@ResponseBody
		public Object getupSettel(HttpServletRequest request, HttpServletResponse response,String cate) {
			JsonParser parser = new JsonParser();
			String result = request.getParameter("result");
			String solution = request.getParameter("solution");
			String settype = request.getParameter("settype");
			String setamount = request.getParameter("setamount");
		    String xinservice = request.getParameter("xintype");//修改后的结算措施
			String serviceMeasures = request.getParameter("serviceMeasures");
			HashMap<String, String> ret = new HashMap<>();
			try {
				JsonArray resu = parser.parse(result).getAsJsonArray();
				JsonArray solu = parser.parse(solution).getAsJsonArray();
				JsonArray stype = parser.parse(settype).getAsJsonArray();
				JsonArray sam = parser.parse(setamount).getAsJsonArray();
				
				//String serviceMeasures = request.getParameter("serviceMeasures");//之前服务措施
				//serviceMeasures;
				String warrantyType = request.getParameter("warrantyType");//保修类型
				//String categ = request.getParameter("cate");//品类
				String categ=cate;
				User user = UserUtils.getUser();
				String siteId = CrmUtils.getCurrentSiteId(user);
				List<SettlementTemplate> list = Lists.newArrayList();
				for(int i=0;i<resu.size();i++){
					String chargeName = resu.get(i).getAsString();
					String basis_type = solu.get(i).getAsString();//收费依据
					String charge_amount = stype.get(i).getAsString();//结算方式（金额或比例）
					String charge_proportion = sam.get(i).getAsString();//提成金额或提成比例
					SettlementTemplate mal = new SettlementTemplate();
					mal.setSiteId(siteId);
					mal.setCreateBy(user.getId());
					mal.setWarrantyType(warrantyType);
					mal.setServiceMeasures(xinservice);
					mal.setCategory(categ);
					mal.setChargeName(chargeName);
					if("服务费".equals(basis_type)){
						mal.setBasisType("1");
					}else if("辅材费".equals(basis_type)){
						mal.setBasisType("2");
					}else if("延保费".equals(basis_type)){
						mal.setBasisType("3");
					}else if("辅材费-入库价格".equals(basis_type)){
	                	mal.setBasisType("4");
	                }else if("辅材费-工程师价格".equals(basis_type)){
						mal.setBasisType("6");
					}else if("厂家结算费".equals(basis_type)) {
						mal.setBasisType("5");
					}else if(StringUtils.isNotEmpty(basis_type)||basis_type==""||basis_type.length()==0){
						mal.setBasisType("0");
						if(StringUtils.isNumeric(basis_type)){
							mal.setBasisAmount(new Double(basis_type));
						}else{
							mal.setBasisAmount(new Double("0"));
						}
						
					}
					if("1".equals(charge_amount)){//按金额
						if(charge_proportion==""||charge_proportion.length()==0){
							mal.setChargeAmount(new Double("0"));
						}else{
							mal.setChargeAmount(new Double(charge_proportion));
						}
						
					}else if("2".equals(charge_amount)){//按比例
						if(charge_proportion==""||charge_proportion.length()==0){
							mal.setChargeProportion(0);
						}else{
							mal.setChargeProportion(Integer.valueOf(charge_proportion));
						}
					}
					list.add(mal);
				}
				//settlementTemplateService.saveList(list);
				settlementTemplateService.delete(categ,siteId,serviceMeasures,list);
				
				ret.put("ok", "true");
			} catch (Exception e) {
				ret.put("ok", "false");
			}
			
			return ret;
		}
		
			//删除结算措施
		 @RequestMapping(value = "delectSettel")
		 public void delectSettel(HttpServletRequest request, HttpServletResponse sponser,String serviceMeasures,String cate) {
		        //String type = request.getParameter("type");
		        //String category = request.getParameter("cate");
		        User user = UserUtils.getUser();
		        settlementTemplateService.delete(cate, CrmUtils.getCurrentSiteId(user),serviceMeasures,null);
		   }
		 //删除结算费用
		 @RequestMapping(value = "delectSettelChargeCame")
		 public void delectSettelChargeCame(HttpServletRequest request, HttpServletResponse sponser) {
			 String set_amount = request.getParameter("set_amount");
			 JsonParser parser = new JsonParser();
			 JsonArray resu = parser.parse(set_amount).getAsJsonArray();
			 settlementTemplateService.delectChargeName(resu);
		 }
	  
}
