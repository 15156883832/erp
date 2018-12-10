package com.jojowonet.modules.operate.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Category;
import com.jojowonet.modules.order.entity.SiteAlarm;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SiteAlarmService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

/**
 * 系统预警信息Controller
 * @author Ivan
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/siteAlarm")
public class SiteAlarmController extends BaseController{
	@Autowired
	private SiteAlarmService siteAlarmService;

	@RequestMapping(value="alarmCount")
	public String getAlarmCount(HttpServletRequest request,HttpServletResponse response,Model model){
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Long employeCount = siteAlarmService.queryEmployeCount(siteId);//派工
		Long finishedCount = siteAlarmService.queryFinishedCount(siteId);//服务完工超时
		Long storeCount = siteAlarmService.queryStoreCount(siteId) ;//库存
		Long shortCount = siteAlarmService.queryShortCount(siteId);//缺件
		Boolean peiJian = CrmUtils.isPeijianMan(user);
		Boolean xinXi = CrmUtils.isXinxiMan(user);
		model.addAttribute("employeCount", employeCount);
		model.addAttribute("finishedCount", finishedCount);
		model.addAttribute("storeCount", storeCount);
		model.addAttribute("shortCount", shortCount);
		model.addAttribute("peiJian", peiJian);
		model.addAttribute("xinXi", xinXi);
		return "modules/operate/sysSiteAlarm";
	}
	
	/*
	 * 获取 预警明细 列表的表头header
	 * */
	@RequestMapping(value ="headerList")
	public String getHeaderList(SiteAlarm siteAlarm,HttpServletRequest request,HttpServletResponse response,Model model){
		User user = UserUtils.getUser();
	     String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	     String type = request.getParameter("type");
	     Boolean peiJian = CrmUtils.isPeijianMan(user);
			Boolean xinXi = CrmUtils.isXinxiMan(user);
	     if(type==null){
	     }else{
	    	 model.addAttribute("markType", type); 
	     }
	 	Long employeCount = siteAlarmService.queryEmployeCount(siteId);//派工
		Long finishedCount = siteAlarmService.queryFinishedCount(siteId);//服务完工超时
		Long storeCount = siteAlarmService.queryStoreCount(siteId) ;//库存
		Long shortCount = siteAlarmService.queryShortCount(siteId);//缺件
		model.addAttribute("employeCount", employeCount);
		model.addAttribute("finishedCount", finishedCount);
		model.addAttribute("storeCount", storeCount);
		model.addAttribute("shortCount", shortCount);
	     SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		 model.addAttribute("headerData", stf);
		 model.addAttribute("peiJian", peiJian);
		 model.addAttribute("xinXi", xinXi);
		 return "modules/operate/siteAlarmDetail";
	}
	
	/*
	 * 获取服务品类总的列表
	 * */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "alarmDetailList")
	public  String getAlarmDetailList(HttpServletRequest request,HttpServletResponse response){
	    String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	    Map<String,Object> map =request.getParameterMap();
		Page<Record> pages = new Page<Record>(request,response);
		Page<Record> page = siteAlarmService.getAlarmDetailList(pages,siteId,map);
		return renderJson(new JqGridPage<>(page));
	}
	
	/*
	 * 取消预警
	 * */
	@ResponseBody
	@RequestMapping(value = "cancelAlarm")
	public  String cancelAlarm(String rowId,HttpServletRequest request,HttpServletResponse response){
		return siteAlarmService.cancelAlarm(rowId);
	}
	/*
	 * 批量取消预警
	 * */
	@ResponseBody
	@RequestMapping(value = "plcancelAlarm")
	public  boolean plcancelAlarm(String[] idArr,HttpServletRequest request,HttpServletResponse response){
		for(int i=0;i<idArr.length;i++){
		
			siteAlarmService.plcancelAlarm(idArr[i]);
		}
		return true;
	}
	
	/*
	 * 是否置顶
	 * */
	@ResponseBody
	@RequestMapping(value = "isTop")
	public  String isTop(String rowId,String isTop,HttpServletRequest request,HttpServletResponse response){
		return siteAlarmService.isTop(rowId,isTop);
	}
	//标记
	@ResponseBody
	@RequestMapping(value = "isFlag")
	public  String isFlag(String rowId,String isflag,HttpServletRequest request,HttpServletResponse response){
		return siteAlarmService.isFlag(rowId,isflag);
	}
	//批量标记
	@ResponseBody
	@RequestMapping(value = "pltop")
	public  boolean pltop(String[] idArr,HttpServletRequest request,HttpServletResponse response){
		for(int i=0;i<idArr.length;i++){
			
			siteAlarmService.plflag(idArr[i]);
		}
		return true;
	}
	//批量取消标记
	@ResponseBody
	@RequestMapping(value = "plcanceltop")
	public  boolean plcancelflag(String[] idArr,HttpServletRequest request,HttpServletResponse response){
		for(int i=0;i<idArr.length;i++){
			
			siteAlarmService.plcancelflag(idArr[i]);
		}
		return true;
	}
	
}
