package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Brand;
import com.jojowonet.modules.order.entity.Category;
import com.jojowonet.modules.order.entity.Unit;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.BrandService;
import com.jojowonet.modules.order.service.BrandSettleService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;


@Controller
@RequestMapping(value = "${adminPath}/order/brandsettle")
public class BrandSettleController extends BaseController {
	@Autowired
	private BrandSettleService brandSettleService;
	
	
	@RequestMapping(value={"list",""})
	public String list(Brand brand,HttpServletRequest request,HttpServletResponse response,Model model){		
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/brandsettlelist";
	}
	
	@RequestMapping(value="brandsettleList")
	@ResponseBody
	public String brandsettleListList(Brand brand,HttpServletRequest request,HttpServletResponse response,Model model){
		String categoryid=request.getParameter("categoryid");
		String brands=request.getParameter("brand");
		Page<Record> page = new Page<>(request, response);
		page = brandSettleService.findbrand(page,brands,categoryid);	
		model.addAttribute("page",page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	@RequestMapping(value = "form")//跳转到添加页面
	public String form(Model model) {
		return "modules/" + "order/brandSettleForm";
	}
	@RequestMapping(value = "addBrand")//添加数据
	public @ResponseBody String save(String img,String names,String sorts,String[] categorylist,String vendor,String first_letter,HttpServletRequest request ) {
//String upload=request.getParameter("pickerImg");
		   if(sorts.length()==0){
			      sorts="0";
		   }
      Brand brand=new Brand();
      brand.setName(names);
      brand.setSort(sorts);
      brand.setVendor(vendor);
      brand.setFirstLetter(first_letter);
      brand.setImg(img);
      brandSettleService.save(brand,categorylist);

		return null;
	}
	
@RequestMapping("deletebrand")//根据id删除品牌
public String deletebrand(String id, RedirectAttributes redirectAttributes) {
		Integer ids=Integer.valueOf(id);
		brandSettleService.deleteBrandById(ids);
	return "redirect:"+Global.getAdminPath()+"/order/brandsettle";
}

@RequestMapping("editebrand")//跳转到修改品牌页面
public String editebrand(String id,Model model){
	Integer ids=Integer.valueOf(id);
	Record rd=brandSettleService.getBrandById(ids);
	List<String> categoryList=Arrays.asList(rd.getStr("category"));
	model.addAttribute("brandSettle",rd);
	model.addAttribute("categorylist", categoryList);
	return "modules/" + "order/brandSettleEdite";
}

@RequestMapping("updateBrand")//修改品牌
public  void updateBrand(String img,String names,String id,String sorts,String[] categorylist,String vendor,String first_letter,HttpServletRequest request){
	//String upload=request.getParameter("pickerImg");
    if(sorts.length()==0){
	      sorts="0";
   }
  Integer ids=Integer.valueOf(id);
  brandSettleService.updatesBrand(names,ids,sorts,categorylist,vendor,first_letter,img);
}



@RequestMapping("queryBrandById")//根据id，name，vendor查询修改和添加是否重名
public void queryBrandById(String names,String id,HttpServletRequest request,HttpServletResponse response){
	Integer ids;
	if(id!=null){
		ids=Integer.valueOf(id);
	}else{
		ids=null;
	}
	boolean flag=false;
	flag=brandSettleService.queryBrandById(names,ids);
	Map<String,Boolean> map = Maps.newHashMap();
	map.put("flag", flag);
	try {
		response.getWriter().print(JSONObject.fromObject(map));
	} catch (IOException e) {
		e.printStackTrace();
	}
}
}
