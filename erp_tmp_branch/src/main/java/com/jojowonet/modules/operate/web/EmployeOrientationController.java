package com.jojowonet.modules.operate.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.EmployeOrientationService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.utils.Apiutils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;


/**
 * 工程师定位Controller
 * @author Ivan
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/employeOrientation")
public class EmployeOrientationController extends BaseController {
	@Autowired
	private EmployeOrientationService employeOrientationService;
	@Autowired
	private SiteService siteService;

	/*
	 * 工程师定位
	 * */
	@RequestMapping(value = "firstPage")
	public String getFirstPage(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Site site = siteService.get(siteId);
		List<Record> employeList = employeOrientationService.getEmployeList(siteId);//获取服务商下所有的正常服务工程师列表queryHavePointCount
		List<Record> list = employeOrientationService.discEmploye(siteId, "");
		List<Record> list1 = employeOrientationService.discEmployeNoPoint(siteId);
		Long count = employeOrientationService.queryNoPointCount(siteId);
		model.addAttribute("employeList", employeList);//条件查询
		model.addAttribute("list", list);
		model.addAttribute("list1", list1);
		model.addAttribute("count", count);
		model.addAttribute("site", site);
		String address = site.getAddress();
		if (StringUtils.isBlank(address) || (StringUtil.isNotBlank(address) && address.length() < 12)) {
			model.addAttribute("siteAddress", site.getProvince() + site.getCity() + site.getArea() + site.getAddress());
		} else {
			model.addAttribute("siteAddress", address);
		}
		model.addAttribute("alternateAddress", site.getProvince() + site.getCity() + site.getAddress());
		return "modules/operate/employeOrientation";
	}
	
	/*
	 * 获取工程师当天最新上传的定位信息
	 * */
	@ResponseBody
	@RequestMapping(value ="discEmploye")
	public List<Record> discEmploye(HttpServletRequest request,HttpServletResponse response){//获取服务工程师今天最近的定位信息
		String empId = request.getParameter("empId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return employeOrientationService.discEmploye(siteId,empId);
	}
	
	/*
	 * 获取工程师当天最新上传的定位信息
	 * */
	@ResponseBody
	@RequestMapping(value ="createDate")
	public Boolean createDate(String createDate,HttpServletRequest request,HttpServletResponse response){//获取服务工程师今天最近的定位信息
		return employeOrientationService.createDate(createDate);
	}
	
	/*
	 * 轨迹查询
	 * 
	 * */
	@ResponseBody
	@RequestMapping(value ="orbitSearch")
	public Map<String,Object> orbitSearch(String empId,HttpServletRequest request,HttpServletResponse response){//获取该服务工程师所有未完工订单消息
		Map<String,Object> map = new HashMap<>();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orbitDate = request.getParameter("orbitDate");
		List<Record> records = employeOrientationService.orbitSearch(siteId,empId);
		List<Record> recordsEnd=null;
		if(StringUtils.isNotBlank(orbitDate)){
			recordsEnd = employeOrientationService.orbitSearchEnd(siteId,empId,orbitDate);
		}else {
			recordsEnd = employeOrientationService.orbitSearchEnd(siteId,empId,null);
		}
		if (StringUtil.isBlank(orbitDate)) {
			orbitDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		}
		Record dateLine = employeOrientationService.dateLine(empId, siteId, orbitDate);
		String lngLatMinMax = employeOrientationService.getSimpleMinMax(dateLine);
		map.put("lngLatMinMax", lngLatMinMax);
		map.put("records", records);
		map.put("recordsEnd", recordsEnd);
		map.put("todayLine", dateLine!=null ? dateLine.getStr("lnglat_info") : "[]");
		map.put("countContinue", records.size());
		map.put("countEnd", recordsEnd.size());
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value ="orbitSearchEnd")
	public List<Record> orbitSearchEnd(String empId,HttpServletRequest request,HttpServletResponse response){//获取该服务工程师所有今天完工订单消息
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return employeOrientationService.orbitSearchEnd(siteId,empId,null);
	}
	
	@ResponseBody
	@RequestMapping(value ="getLocations")
	public double[] getLocations(String address) {
		if (StringUtil.isBlank(address)) {
			return null;
		}
		return Apiutils.addressToGPS(address);
	}
}
