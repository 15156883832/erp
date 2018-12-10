package com.jojowonet.modules.order.dao;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.entity.SiteSchedule;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;

/*
 * 服务商待办事项Dao
 * */
@Repository
public class SiteScheduleDao extends BaseDao<SiteSchedule>{
	@Autowired
	private SiteService siteService;
	@Autowired
	private NonServicemanService nonService;

	private static Logger logger = Logger.getLogger(SiteScheduleDao.class);
	
	public List<Record> siteScheduleList(String siteId) {//获取服务商待办事项列表
		Date dt=new Date();
	   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	   String nowtime=sdf.format(dt);
	   String starttime=nowtime+" 00:00:00";
	   String endtime=nowtime+" 23:59:59";
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE a.site_id=? AND a.status='0' and a.user_id=? and a.type='0'  and a.start_time>=?  order by a.start_time asc");
			list = Db.find(sf.toString(),siteId,userId,starttime);
		}else{
			sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE (a.site_id is null or a.site_id='' ) AND a.status='0' and a.user_id=? and a.type='0' and a.start_time>=? order by a.start_time asc");
			list = Db.find(sf.toString(),userId,starttime);
		}
		return list;
	}


	public List<Record> siteScheduleOtherList(String siteId) {//获取其他待办事项列表
		Date dt=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String nowtime=sdf.format(dt);
		String starttime=nowtime+" 00:00:00";
		String endtime=nowtime+" 23:59:59";
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE a.site_id=? AND a.status='0'  and a.type='1' and a.start_time>=?  order by a.start_time asc");
			list = Db.find(sf.toString(),siteId,starttime);
		}else{
			sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE (a.site_id is null or a.site_id='' ) AND a.status='0' and a.type='1' and a.start_time>=? order by a.start_time asc");
			list = Db.find(sf.toString(),starttime);
		}
		return list;
	}
	
	public List<Record> allsiteScheduleList(String siteId) {
			User user = UserUtils.getUser();
			String userId = user.getId();
			StringBuilder sf = new StringBuilder();
			List<Record> list = new ArrayList<Record>();
			if(StringUtils.isNotEmpty(siteId)){
				sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE a.site_id=? AND a.status='0' and a.user_id=? and a.type='0' order by a.start_time asc  ");
				list = Db.find(sf.toString(),siteId,userId);
			}else{
				sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE (a.site_id is null or a.site_id='' ) AND a.status='0' and a.user_id=?  and a,type='0' order by a.start_time asc ");
				list = Db.find(sf.toString(),userId);
			}
			return list;
	}


	public List<Record> allsiteScheduleotherList(String siteId) {//获取全部的其他事项
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE a.site_id=? AND a.status='0' and a.type='1' order by a.start_time asc  ");
			list = Db.find(sf.toString(),siteId);
		}else{
			sf.append("SELECT a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime FROM crm_site_schedule a WHERE (a.site_id is null or a.site_id='' ) AND a.status='0' and a.type='1' order by a.start_time asc ");
			list = Db.find(sf.toString());
		}
		return list;
	}
	public String saveSiteSchedule(String siteId,String content,String startTime,String endTime,String id,String type){//保存新增的待办事项
		User user = UserUtils.getUser();
		String name = "";
		String ids="";
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = siteService.getUserSite(user.getId()).getName();
		} else {
			name = nonService.getNonServiceman(user).getName();
		}
		SiteSchedule siteSchedule = new SiteSchedule();
		if(StringUtils.isNotBlank(id)){
			siteSchedule.setId(id);
		}
		siteSchedule.setContent(content);
		siteSchedule.setStatus("0");
		siteSchedule.setSiteId(siteId);
		siteSchedule.setUserId(user.getId());
		siteSchedule.setType(type);
		DateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    	try {
			siteSchedule.setStartTime(sf.parse(startTime));
			siteSchedule.setEndTime(sf.parse(endTime));
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	siteSchedule.setCreateName(name);
		
		save(siteSchedule);
		//this.getSession().flush();
		ids=siteSchedule.getId();
    	return ids;
	}
	
	public List<Record> siteScheduleTime(String siteId) {//获取有待办事项的时间日期集合
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			sf.append(" SELECT a.start_time FROM crm_site_schedule a WHERE a.site_id=? AND a.status='0'  and a.user_id=?  and a.type='0'");
			list = Db.find(sf.toString(), siteId,userId);
		}else{
			sf.append(" SELECT a.start_time FROM crm_site_schedule a WHERE (a.site_id is null or a.site_id='') AND a.status='0'  and a.user_id=? and a.type='0'");
			list = Db.find(sf.toString(), userId);
		}
		return list;
	}

	public List<Record> siteScheduleOtherTime(String siteId) {//获取其他有待办事项的时间日期集合
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			sf.append(" SELECT a.start_time FROM crm_site_schedule a WHERE a.site_id=? AND a.status='0' and a.type='1'");
			list = Db.find(sf.toString(), siteId);
		}else{
			sf.append(" SELECT a.start_time FROM crm_site_schedule a WHERE (a.site_id is null or a.site_id='') AND a.status='0' and a.type='1'");
			list = Db.find(sf.toString());
		}
		return list;
	}
	
	
	public List<Record> backOrAhead(String siteId,String recordDate,String mark) {//点击日历上个月或者下个月
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			if(mark.equals("1")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE a.site_id='"+siteId+"' AND a.status='0' AND SUBSTR(('"+recordDate+"'+ INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.user_id=? and a.type='0'");
			}else if(mark.equals("2")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE a.site_id='"+siteId+"' AND a.status='0' AND SUBSTR(('"+recordDate+"'- INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.user_id=? and a.type='0' ");
			}
			list = Db.find(sf.toString(),userId);
		}else{
			if(mark.equals("1")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE (a.site_id='' or a.site_id is null) AND a.status='0' AND SUBSTR(('"+recordDate+"'+ INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.user_id=? and a.type='0'");
			}else if(mark.equals("2")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE (a.site_id='' or a.site_id is null) AND a.status='0' AND SUBSTR(('"+recordDate+"'- INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.user_id=? and a.type='0'");
			}
			list = Db.find(sf.toString(), userId);
		}
		
		
		
		
		return Db.find(sf.toString(),userId);
	}


	public List<Record> backOrAheadother(String siteId,String recordDate,String mark) {//点击日历上个月或者下个月
		User user = UserUtils.getUser();
		String userId = user.getId();
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		if(StringUtils.isNotEmpty(siteId)){
			if(mark.equals("1")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE a.site_id='"+siteId+"' AND a.status='0' AND SUBSTR(('"+recordDate+"'+ INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.type='1'");
			}else if(mark.equals("2")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE a.site_id='"+siteId+"' AND a.status='0' AND SUBSTR(('"+recordDate+"'- INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.type='1' ");
			}
			list = Db.find(sf.toString());
		}else{
			if(mark.equals("1")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE (a.site_id='' or a.site_id is null) AND a.status='0' AND SUBSTR(('"+recordDate+"'+ INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.type='1'");
			}else if(mark.equals("2")){
				sf.append("SELECT a.* FROM crm_site_schedule a WHERE (a.site_id='' or a.site_id is null) AND a.status='0' AND SUBSTR(('"+recordDate+"'- INTERVAL '1' MONTH),1,7)=SUBSTR(a.start_time,1,7) and a.type='1' ");
			}
			list = Db.find(sf.toString());
		}




		return Db.find(sf.toString());
	}
	
	public Record recordDate(String recordDate,String mark) {
		StringBuilder sf = new StringBuilder();
		DateFormat sfd = new SimpleDateFormat("yyyy-MM-dd");
		if(mark.equals("1")){
			try {
				Date testDate = sfd.parse(recordDate);
				String realDate = DateUtils.formatDate(testDate, "yyyy-MM-dd");
				sf.append("SELECT SUBSTR(('"+realDate+"'+ INTERVAL '1' MONTH),1,10) AS recordDate");
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(mark.equals("2")){
			sf.append("SELECT SUBSTR(('"+recordDate+"'- INTERVAL '1' MONTH),1,10) AS recordDate");
		}
		return Db.findFirst(sf.toString());
	}
	
	public List<Record> dailySchedule(String siteId,String compareDate){
		User user = UserUtils.getUser();
		DateFormat sfd = new SimpleDateFormat("yyyy-MM-dd");
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		try {
			Date cDate = sfd.parse(compareDate);
			String realDate = DateUtils.formatDate(cDate, "yyyy-MM-dd");
			if(StringUtils.isNotBlank(siteId)){
				sf.append("select a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime from crm_site_schedule a where a.site_id=? and  a.status='0' and SUBSTR(a.start_time,1,10)='"+realDate+"' and a.user_id=? and a.type='0'");
				list= Db.find(sf.toString(),siteId,user.getId());
			}else{
				sf.append("select a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime from crm_site_schedule a where (a.site_id='' or a.site_id is null) and  a.status='0' and SUBSTR(a.start_time,1,10)='"+realDate+"' and a.user_id=?  and a.type='0'");
				list= Db.find(sf.toString(),user.getId());
			}
		} catch (ParseException e) {
			logger.error(String.format("dailySchedule:: parse date failed, compareDate is %s", compareDate));
			e.printStackTrace();
		}
		return list;
	}

	public List<Record> dailyScheduleOther(String siteId,String compareDate){
		User user = UserUtils.getUser();
		DateFormat sfd = new SimpleDateFormat("yyyy-MM-dd");
		StringBuilder sf = new StringBuilder();
		List<Record> list = new ArrayList<Record>();
		try {
			Date cDate = sfd.parse(compareDate);
			String realDate = DateUtils.formatDate(cDate, "yyyy-MM-dd");
			if(StringUtils.isNotBlank(siteId)){
				sf.append("select a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime from crm_site_schedule a where a.site_id=? and  a.status='0' and SUBSTR(a.start_time,1,10)='"+realDate+"' and a.type='1' ");
				list= Db.find(sf.toString(),siteId);
			}else{
				sf.append("select a.*,SUBSTR(a.start_time,1,16) AS trSatrtTime,SUBSTR(SUBSTR(a.end_time,12,16),1,5) AS trEndTime from crm_site_schedule a where (a.site_id='' or a.site_id is null) and  a.status='0' and SUBSTR(a.start_time,1,10)='"+realDate+"' and a.type='1' ");
				list= Db.find(sf.toString());
			}
		} catch (ParseException e) {
			logger.error(String.format("dailySchedule:: parse date failed, compareDate is %s", compareDate));
			e.printStackTrace();
		}
		return list;
	}

	public boolean deleteSiteSchedule(String id, String siteId) {
        String sql="update crm_site_schedule set status='1' where id=? and site_id=?";
        Db.update(sql, id,siteId);
		return true;
	}




}
