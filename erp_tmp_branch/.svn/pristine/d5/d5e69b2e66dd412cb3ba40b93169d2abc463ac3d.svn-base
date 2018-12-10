package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.config.Global;
import ivan.common.dao.UserDao;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.AreaManagerService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;


@Controller
@RequestMapping(value = "${adminPath}/order/areaManager")
public class AreaManagerController extends BaseController{
     @Autowired
     private AreaManagerService areaManagerService;
 	@Autowired
 	private UserDao userDao;
     
     @RequestMapping(value={"list",""})
     public String list(HttpServletRequest request,HttpServletResponse response, Model model){
 		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
 		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
 				siteId, request.getServletPath());
 		List<Record> provincelist=areaManagerService.getarealist();
 		model.addAttribute("headerData", stf);
 		model.addAttribute("listarea", provincelist);
    	 return "modules/" + "order/areaManagerList";
     }
     
     //查询区域管理人员列表
     @RequestMapping(value="areaManagerList")
     @ResponseBody
     public  String areaManagerList(HttpServletRequest request,
 			HttpServletResponse response, Model model){
    	 Page<Record> page = new Page<>(request, response);
    	 Map<String,Object> map = new TrimMap(getParams(request));
 		page = areaManagerService.findAreaManager(page, map);
 		model.addAttribute("page", page);
 		JqGridPage<Record> jqp = new JqGridPage<>(page);
 		return renderJson(jqp);
     }
	
 	////在添加和修改时当为二级区管时获取上级区管的列表
     @RequestMapping(value = "changedistrict")
 	public void changeBrand(String name, HttpServletRequest request,
 			HttpServletResponse response) {
 		List<String> liststr = Lists.newArrayList();
 		List<Record> list = areaManagerService.changedistrict();
 		Map<String, Object> map = Maps.newHashMap();
 		for (int i = 0; i < list.size(); i++) {
 			liststr.add(list.get(i).getStr("name"));
 		}
 		map.put("changecstr", liststr);
 		try {
 			response.getWriter().print(JSONObject.fromObject(map));
 		} catch (IOException e) {
 			e.printStackTrace();
 		}
 	}
     
     //跳转到服务商分享明细列表
     @RequestMapping(value="topensite")
     public String sitelist(HttpServletRequest request,HttpServletResponse response, Model model,String id){
  		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
  		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
  				siteId, request.getServletPath());
  		model.addAttribute("headerData", stf);
  		model.addAttribute("id", id);
     	 return "modules/" + "order/areaManagerSiteList";
      } 
     
     //获取对应区域管理人员服务商分享明细的列表
     @RequestMapping(value="siteareaManagerList")
     @ResponseBody
     public  String siteareaManagerList(HttpServletRequest request,
 			HttpServletResponse response, Model model,String id){
    	 Page<Record> page = new Page<Record>(request, response);
 		page = areaManagerService.getsiteList(page, id);
 		model.addAttribute("page", page);
 		JqGridPage<Record> jqp = new JqGridPage<>(page);
 		return renderJson(jqp);
     }
     
     
     //跳转到关联服务商明细列表
     @RequestMapping(value="bindingsite")
     public String bindingsite(HttpServletRequest request,HttpServletResponse response, Model model,String id){
    	 String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	 SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
    			 siteId, request.getServletPath());
    	 model.addAttribute("headerData", stf);
    	 model.addAttribute("id", id);
    	 return "modules/" + "order/areabindingSiteList";
     } 
     
     //获取对应区域管理人员关联服务商明细列表
     @RequestMapping(value="bindingsiteList")
     @ResponseBody
     public  String bindingsiteList(HttpServletRequest request,
    		 HttpServletResponse response, Model model,String id){
    	 Page<Record> page = new Page<Record>(request, response);
    	 page = areaManagerService.getbindingsiteList(page, id);
    	 model.addAttribute("page", page);
    	 JqGridPage<Record> jqp = new JqGridPage<>(page);
    	 return renderJson(jqp);
     }
     
     
 	@RequestMapping(value="exports")
	 public String exports(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String id = request.getParameter("id");
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId= CrmUtils.getCurrentSiteId(user);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
           String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
           Page<Record> pages = new Page<Record>(request, response);
           pages.setPageNo(1);
           pages.setPageSize(10000);
           JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
           Page<Record> page = areaManagerService.getbindingsiteList(pages, id);
			List<Record> list =page.getList();
			for(Record re :list ) {
				Date now = new Date();
				  if (re.getDate("due_time") == null) {
                      re.set("due_times", "免费版");
                  } else {
                      if (re.getDate("due_time").getTime() >= now.getTime()) {
                          re.set("due_times", "收费版");
                      } else {
                          re.set("due_times", "免费版");
                      }
                  }
			}
   		new ExportJqExcel(title+"数据",  jarray.toString(), stf.getSortHeader())
   			.setDataList(list).write(request, response, fileName).dispose();
   		return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
   }
     
     //启用或者停用区域管理人员
     @RequestMapping(value="down")
     @ResponseBody
     public String   down(String id,String status){
    	 String result="";
    	 if(StringUtils.isNotBlank(status)){
    		Integer i= areaManagerService.updateStatus(id,status);
    		if(i>0){
    			  result="ok";
    		}else{
    			 result="false";
    		}          
             return result;
    	 }else{
    		 result="false";
    		 return result;
    	 }
     }
	
     //添加区域管理人员
     @RequestMapping(value="addareaManager")
     @ResponseBody
     public String addannouncement(String superiorDistrict,String name,String phone,String area,String code,String id,String oldname,String loginName,String password){
    	 String result=areaManagerService.save(superiorDistrict,name,phone,area,code,id,oldname,loginName,password);
    	return result;
     }
     
     //跳转到修改页面
     @RequestMapping(value="tovareaForm")
     public String tovareaForm(String id,HttpServletRequest request,HttpServletResponse response, Model model){
    	 Record rd=areaManagerService.getAreaManagerById(id);
    	 model.addAttribute("areaManager", rd);
    	 String userId = rd.getStr("user_id");
    	 User us = userDao.get(userId);
    	 model.addAttribute("loginName", us.getLoginName());
    	/* List<Record> supplist = areaManagerService.changedistrict();
    	 model.addAttribute("supplist", supplist);*/
    	return "modules/" + "order/areaManagerForm";
     }
     
     //绑定区域人员
     @RequestMapping(value="areaManagerbindingsite")
     public String areaManagerbindingsite(String id,HttpServletRequest request,HttpServletResponse response, Model model){
    	 String ids = request.getParameter("ids");
    	 model.addAttribute("ids", ids);
    	 List<Record> supplist = areaManagerService.areamanagerList();
    	 model.addAttribute("supplist", supplist);
    	 return "modules/" + "order/areaManagerbindingsite";
     }
     
     /*验证服务商是否已经绑定区域人员
     */
     @ResponseBody
     @RequestMapping(value="checkAreaManager")
     public Object checkAreaManager(HttpServletRequest request,HttpServletResponse response) {
    	 String ids = request.getParameter("ids");
    	 return areaManagerService.checkAreaManager(ids);
     }
     
     @RequestMapping(value="binding")
     @ResponseBody
     public String binding(HttpServletRequest request,HttpServletResponse response){
    	 String siteids= request.getParameter("siteids");
    	 String areaid = request.getParameter("areaid");
    	 String result="";
    	 if(StringUtils.isNotBlank(areaid)){
    		Integer i= areaManagerService.insertareaManagerSite(siteids,areaid);
    		if(i>0){
    			  result="ok";
    		}else{
    			 result="false";
    		}          
             return result;
    	 }else{
    		 result="false";
    		 return result;
    	 }
     }
	
     @RequestMapping(value="getCheckBinding")
     @ResponseBody
     public String getCheckBinding(HttpServletRequest request,HttpServletResponse response){
    	 String siteid= request.getParameter("siteId");
    	 String result= areaManagerService.getCheckBinding(siteid);
    	return result;

     }
     @RequestMapping(value="deleteareaManagerSite")
     @ResponseBody
     public String deleteareaManagerSite(HttpServletRequest request,HttpServletResponse response){
    	 String siteid= request.getParameter("siteId");
    	 String result ="";
    	 if(StringUtils.isNotBlank(siteid)){
    		 Integer i= areaManagerService.deleteareaManagerSite(siteid);
     		if(i>0){
     			  result="ok";
     		}else{
     			 result="false";
     		}          
              return result;
     	 }else{
     		 result="false";
     		 return result;
     	 }
     }
     
     
}
