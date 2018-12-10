package com.jojowonet.modules.order.web;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.web.BaseController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.ViewManagerService;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;

@Controller
public class ViewManagerController extends  BaseController{
	@Autowired
	private ViewManagerService viewManagerService;
	
	//弹屏设备管理表头
	@RequestMapping(value ="${adminPath}/order/viewManager")
	public String getWwg(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		//String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(null, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/order/viewManage/viewManager";
	}
	
	// 数据
	@ResponseBody
	@RequestMapping(value = "${adminPath}/order/getViewList")
	public String getWwgList(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = null;
		page = viewManagerService.getViewManagerList(pages, map);
		return renderJson(new JqGridPage<>(page));
	}
	
	//去重复
	@ResponseBody
	@RequestMapping(value="${adminPath}/order/quRepeat")
	public String quRepeat(HttpServletRequest request){
		String result="no";
		String seriNo=request.getParameter("seriNo");
		String oldserino=request.getParameter("oldserino");
		String deviceId=request.getParameter("deviceId");
		if(StringUtils.isNotBlank(oldserino)){
			String sql="select * from crm_site_tele_device where serial_no='"+seriNo+"' and status='0' and id !='"+deviceId+"' ";
			List<Record> re=Db.find(sql);
			if(re.size()>=1){
				result="ok";
			}
		}else{
			String sql="select * from crm_site_tele_device where serial_no='"+seriNo+"' and status='0' ";
			Record re=Db.findFirst(sql);
			if(re!=null){
				result="ok";
			}
		}
		return result;
	}
	
	
	
	//根据id获取信息
	@ResponseBody
	@RequestMapping(value="${adminPath}/order/getDevice")
	public Record getDevice(HttpServletRequest request){
		String id=request.getParameter("id");
		String sql="select a.id,a.serial_no,b.name from  crm_site_tele_device a left join crm_site b on a.site_id=b.id where a.id='"+id+"' and a.status='0' ";
		Record re=Db.findFirst(sql);
		return re;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value="${adminPath}/order/deleteMsg")
	public String deleteMsg(HttpServletRequest request){
		String result="no";
		String id=request.getParameter("id");
		Boolean res=Db.deleteById("crm_site_tele_device", id);
		if(res){
			result="ok";
		}
		return result;
	}
	
	//添加/修改 （服务商序列号）
	@ResponseBody
	@RequestMapping(value="${adminPath}/order/addPingView")
	public String addPingView(HttpServletRequest request){
		String result="ok";
		String id=request.getParameter("id").trim();
		String oldserino=request.getParameter("oldserino").trim();//旧的序列号
		String name=request.getParameter("name").trim();
		String seriNo=request.getParameter("seriNo").trim();
		
		result = Check(seriNo,oldserino,id);
		if(result!="ok"){
			result=viewManagerService.addPingView(id,oldserino,name,seriNo);
		}else{
			result="no";
		}
		
		return result;
	}
	public String Check(String seriNo,String oldserino,String deviceId){
		String result="no";
		if(StringUtils.isNotBlank(oldserino)){
			List<Record> re=viewManagerService.oldserino(seriNo,deviceId);
			if(re.size()==1){
				result="ok";
			}
		}else{
			Record re=viewManagerService.oldserinoNoId(seriNo);
			if(re!=null){
				result="ok";
			}
		}
		return result;
	}
	
}
