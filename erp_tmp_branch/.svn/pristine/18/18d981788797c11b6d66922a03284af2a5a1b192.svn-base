package com.jojowonet.modules.order.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.AnnouncementDao;
import com.jojowonet.modules.order.entity.Announcement;

/**
 * 系统公告service层
 * @author yc
 * @version 2017-06-15
 */

@Component
@Transactional(readOnly = true)
public class AnnouncementService extends BaseService{
	@Autowired
	private AnnouncementDao announcementDao;
	public List<Record> getAnnouncementlist(String siteId){
		Date date=new Date();
		String timer=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		List<Record> announcementlist=announcementDao.getAnnouncementlist(siteId,timer);
		for (Record rd : announcementlist) {//处理时间格式
			String createtime=rd.getDate("create_time").toString();
			int index=createtime.indexOf(":");
			index=createtime.indexOf(":", index+1);
			String createTime=createtime.substring(0,index);
			rd.set("create_time", createTime);
			//处理是否已读状态
			String id=rd.getStr("id");
			Record flagrd=announcementDao.querySiteAnnou(id,siteId);
			if(flagrd==null){
				rd.set("flag", "0");//未读
			}else{
				rd.set("flag", "1");//已读
			}
		}
		return announcementlist;
	}
	//system查询公告列表
	public Page<Record> getannouncementsyslist(Page<Record> page, String type) {
		List<Record> announcementlist=announcementDao.getannouncementSysList(page,type);
		for (Record rd : announcementlist) {//处理时间格式
			String createtime=rd.getDate("create_time").toString();
			int index=createtime.indexOf(":");
			index=createtime.indexOf(":", index+1);
			String createTime=createtime.substring(0,index);
			rd.set("create_time", createTime);
		}
		long count=announcementDao.getListCount(type);
		page.setList(announcementlist);
		page.setCount(count);
		return page;
	}
	//system添加公告
	public boolean addAnnouncement(String type, String title, String content,
			String createTime) {
		Announcement announcement=new Announcement();
		announcement.setType(type);
		announcement.setTitle(title);
		announcement.setContent(content);
		//处理时间格式
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
		announcementDao.save(announcement);
		return true;
	}
	//删除公告
	public Integer deleteannouncement(String id) {
		Integer i=announcementDao.deleteAnnouncement(id);
		return i;
	}
	//通过id查询公告
	public Record getAnnouncementByid(String id) {
		Record announcement=announcementDao.getAnnouncementByid(id);
		String createtime=announcement.getDate("create_time").toString();
		int index=createtime.indexOf(" ");
		String createTime=createtime.substring(0,index);
		announcement.set("create_time", createTime);
		return announcement;
	}
	//跟新公告
	public void updateAnnouncement(Announcement announcement) {
		announcementDao.save(announcement);
		
	}
	//网点查询公告列表
	public Page<Record> getAnnouncementPlatlist(Page<Record> page, String type,
			String siteId) {
		Date date=new Date();
		String timer=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		List<Record> announcementlist=announcementDao.getannouncementPlateList(page, type,timer);
		
		for (Record rd : announcementlist) {//处理时间格式
			String createtime=rd.getDate("create_time").toString();
			int index=createtime.indexOf(":");
			index=createtime.indexOf(":", index+1);
			String createTime=createtime.substring(0,index);
			rd.set("create_time", createTime);
			//处理是否已读状态
			String id=rd.getStr("id");
			Record flagrd=announcementDao.querySiteAnnou(id,siteId);
			if(flagrd==null){
				rd.set("flag", "0");//未读
			}else{
				rd.set("flag", "1");//已读
			}
		}
		long count=announcementDao.getListCountforplat(type, timer);
		page.setList(announcementlist);
		page.setCount(count);
		return page;
	}
	//标记系统公告为已读（往标记表中插入数据）
	public void addtositeAnnouncement(String id, String siteId) {
		Record flagrd=announcementDao.querySiteAnnou(id,siteId);
		if(flagrd==null){
			announcementDao.addtositeAnnouncement(id,siteId);
		}
	}

}
