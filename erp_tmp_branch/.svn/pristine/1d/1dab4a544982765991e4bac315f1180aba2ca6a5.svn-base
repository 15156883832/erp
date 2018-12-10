package com.jojowonet.modules.order.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Announcement;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.AnnouncementService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/order/announcement")
public class AnnouncementController extends BaseController {
	@Autowired
	private AnnouncementService announcementService;
//system权限设置公告
	@RequestMapping(value = "set")
	public String announcementForSys(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/announcement/announcementforsyslist";
	}

	@RequestMapping(value = "getannouncementsyslist")
	@ResponseBody
	public String getannouncementsyslist(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String type = request.getParameter("type");
		Map<String,Object> map = getParams(request);
		Page<Record> page = new Page<>(request, response);
		model.addAttribute("page", page);
		page = announcementService.getannouncementsyslist(page, type);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);

	}
//添加公告
	@RequestMapping(value = "addannouncement")
	@ResponseBody
	public boolean addAnnouncement(HttpServletRequest request,
			HttpServletResponse response, String type, String title,
			String content, String createTime) {
		String html = request.getParameter("content");
		boolean result=announcementService.addAnnouncement(type,title,html,createTime);
		return result;
	}
	
	//删除公告
	@RequestMapping(value = "delete")
	@ResponseBody
	public String delete(HttpServletRequest request,HttpServletResponse response, String[] idArr) {
		String resulte="";
		Integer rows=0;
		for(int i=0;i<idArr.length;i++){
			announcementService.deleteannouncement(idArr[i]);
			rows++;
		}
		if(rows==idArr.length){
			resulte="ok";
		}
		return resulte;
	}
	
	//根据id查询出公告
	@RequestMapping(value = "getannouncementbyid")
	@ResponseBody
	public Record getAnnouncementByid(HttpServletRequest request,HttpServletResponse response, String id) {
        Record rd=announcementService.getAnnouncementByid(id);
		return rd;
	}
	
	//更新公告
	@RequestMapping(value = "updateannouncement")
	@ResponseBody
	public String updateAnnouncement(HttpServletRequest request,
			HttpServletResponse response, String id, String type, String title,
			String content, String createTime) {
		String resulte="";
		String html = request.getParameter("content");
		Announcement announcement=new Announcement();
		announcement.setId(id);
		announcement.setTitle(title);
		announcement.setType(type);
		announcement.setContent(html);
		Date date=new Date();
		String timer=new SimpleDateFormat("HH:mm:ss").format(date);
		if(createTime!=null&&(!createTime.isEmpty())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				announcement.setCreateTime(sdf.parse(createTime+" "+timer));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		announcementService.updateAnnouncement(announcement);
		resulte="ok";
		return resulte;
	}
	
	
	
	//网点查询公告
	@RequestMapping(value = "read")
	public String announcementForPlat(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/announcement/announcementForPlatlist";
	}

	@RequestMapping(value = "getannouncementplatlist")
	@ResponseBody
	public String getannouncementplatlist(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String type = request.getParameter("type");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record> page = new Page<>(request, response);
		model.addAttribute("page", page);
		page = announcementService.getAnnouncementPlatlist(page, type,siteId);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	
	
	//处理将公告标记为已读的方法;
	@RequestMapping(value = "addtositeAnnouncement")
	@ResponseBody
	public void addtositeAnnouncement(HttpServletRequest request,HttpServletResponse response, String id) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        announcementService.addtositeAnnouncement(id,siteId);
		
	}
	
	
}
