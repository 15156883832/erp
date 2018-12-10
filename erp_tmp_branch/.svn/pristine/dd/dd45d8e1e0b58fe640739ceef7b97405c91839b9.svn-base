package com.jojowonet.modules.order.web;

import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.solr.common.util.Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.service.SiteScheduleService;
import com.jojowonet.modules.order.utils.CrmUtils;
/*
 * 服务商待办事项Controller
 * */
@Controller
@RequestMapping(value = "${adminPath}/order/siteSchedule")
public class SiteScheduleController extends BaseController{
	@Autowired
	private SiteScheduleService siteScheduleService;
	
	/*
	 * 查询出待办事项的列表
	 * */
	@RequestMapping(value="siteScheduleList")
	public String getSiteScheduleList(HttpServletRequest request,HttpServletResponse response,Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> listDaiban = siteScheduleService.siteScheduleList(siteId);
		String[] listDate = siteScheduleService.siteScheduleTime(siteId);
		String json = JSONArray.fromObject(listDate).toString();
		model.addAttribute("listDaiban", listDaiban);
		model.addAttribute("listDate", JSONArray.fromObject(listDate).toString());
		return "modules/order/siteSchedule";
	}
	@ResponseBody
	@RequestMapping(value="allSchedule")
	public List<Record> allSchedule(HttpServletRequest request,HttpServletResponse response,Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return siteScheduleService.allsiteScheduleList(siteId);
	}
	@ResponseBody
	@RequestMapping(value="allOtherSchedule")
	public List<Record> allOtherSchedule(HttpServletRequest request,HttpServletResponse response,Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return siteScheduleService.allsiteScheduleOtherList(siteId);
	}


	
	@ResponseBody
	@RequestMapping(value="saveSiteSchedule")
	public Map<String,String> saveSiteSchedule(String content,String startTime,String endTime,String id,HttpServletRequest request,HttpServletResponse response,String type){
		Map<String, String> params = request.getParameterMap();
		String ff = request.getParameter("sg");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,String> result2=new HashMap<String, String>();
		String ids="";
		if(StringUtils.isNotBlank(id)){
			ids = siteScheduleService.saveSiteSchedule(siteId, content, startTime, endTime,id,type);
			result2.put("result","ok1");
			result2.put("id",ids);
			return result2;
		}else{
			ids= siteScheduleService.saveSiteSchedule(siteId, content, startTime, endTime,id,type);
			result2.put("result","ok2");
			result2.put("id",ids);
			return result2;
		}
		
		
	}
	
	@ResponseBody
	@RequestMapping(value="backOrAhead")
	public String backOrAhead(String recordDate,String mark,HttpServletRequest request,HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String[] listDate = siteScheduleService.backOrAhead(siteId, recordDate, mark);
		return JSONArray.fromObject(listDate).toString();
	}

	@ResponseBody
	@RequestMapping(value="backOrAheadother1")
	public String backOrAheadother1(String recordDate,String mark,HttpServletRequest request,HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String[] listDate = siteScheduleService.backOrAheadother(siteId, recordDate, mark);
		return JSONArray.fromObject(listDate).toString();
	}
	
	@ResponseBody
	@RequestMapping(value="newDate")
	public String newDate(HttpServletRequest request,HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String[] listDate = siteScheduleService.siteScheduleTime(siteId);
		return JSONArray.fromObject(listDate).toString();
	}
	
	@ResponseBody
	@RequestMapping(value="recordDate")
	public String recordDate(String recordDate,String mark,HttpServletRequest request,HttpServletResponse response) {
		Record record = siteScheduleService.recordDate(recordDate, mark);
		return record.getStr("recordDate");
	}
	
	/*
	 * 点击日历的某一天显示的待办事情展示
	 * */
	@ResponseBody
	@RequestMapping(value="dailySchedule")
	public List<Record> dailySchedule(String compareDate,HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return siteScheduleService.dailySchedule(siteId,compareDate);
	}
	@ResponseBody
	@RequestMapping(value="dailyScheduleOther")
	public List<Record> dailyScheduleOther(String compareDate,HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return siteScheduleService.dailyScheduleOther(siteId,compareDate);
	}



	
	@ResponseBody
	@RequestMapping(value="deleteSiteSchedule")
	public String deleteSiteSchedule(String id,HttpServletRequest request,HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		boolean listDate = siteScheduleService.deleteSiteSchedule(id,siteId);
		return "ok";
	}
	
}
