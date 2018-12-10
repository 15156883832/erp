package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Announcement;



/**
 * 系统公告DAO接口
 * @author yc
 * @version 2017-06-15
 */
@Repository
public class AnnouncementDao extends BaseDao<Announcement>  {
	public List<Record> getAnnouncementlist(String siteId,String time){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM crm_announcement a WHERE a.site_id IS null AND status='0'");
		sf.append(" AND a.create_time<='"+time+"'  ORDER BY a.create_time DESC");
		return Db.find(sf.toString());
	}
//system权限查询的公告
	public List<Record> getannouncementSysList(Page<Record> page,String type) {
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM crm_announcement AS a WHERE a.status='0'");
		if(type != null&&type.length()!=0){
			sf.append(" AND a.type = '"+type+"' ");
		}
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		
		return Db.find(sf.toString());
	}
	public long getListCount(String type) {
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(*) FROM crm_announcement AS a WHERE a.status='0' ");
		if(type != null&&type.length()!=0){
			sf.append(" AND a.type = '"+type+"' ");
		}
		return Db.queryLong(sf.toString());
	}
	
	
	//网点权限查询公告
	public List<Record> getannouncementPlateList(Page<Record> page, String type,String time) {
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM crm_announcement AS a WHERE a.status='0'");
		if(type != null&&type.length()!=0){
			sf.append(" AND a.type = '"+type+"' ");
		}
		sf.append(" AND a.create_time<='"+time+"'");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		
		return Db.find(sf.toString());
	}
	public long getListCountforplat(String type,String time) {
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(*) FROM crm_announcement AS a WHERE a.status='0' ");
		if(type != null&&type.length()!=0){
			sf.append(" AND a.type = '"+type+"' ");
		}
		sf.append(" AND a.create_time<='"+time+"'");
		return Db.queryLong(sf.toString());
	}
	//删除公告
	public Integer deleteAnnouncement(String id) {
		String sql="UPDATE crm_announcement SET status='1' WHERE id='"+id+"'";
		return Db.update(sql);
		
	}
 //根据id查询公告
	public Record getAnnouncementByid(String id) {
		String sql="SELECT * FROM crm_announcement WHERE id='"+id+"'";
		return Db.findFirst(sql);
	}
	//根据公告id查询在已读表中是否存在该公告用来判断是否已读
	public Record querySiteAnnou(String id, String siteId) {
		String sql="SELECT * FROM crm_announcement_site_read WHERE announcement_id=? AND site_id=?";
		return Db.findFirst(sql,id,siteId);
		
	}
	//向读取状态表中插入数据
	public void addtositeAnnouncement(String id, String siteId) {
		String sql="INSERT INTO crm_announcement_site_read VALUES(MD5(UUID()) , ? , ?)";
		Db.update(sql,id,siteId);
		
	}





}
