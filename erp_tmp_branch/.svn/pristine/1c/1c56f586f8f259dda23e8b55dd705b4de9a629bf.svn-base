package com.jojowonet.modules.operate.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteAddtimeRecordDao;
import com.jojowonet.modules.operate.dao.SiteManagerDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.entity.SiteAddtimeRecord;
import com.jojowonet.modules.operate.utils.DateUtils;
import com.jojowonet.modules.order.dao.AreaManagerDao;
import com.jojowonet.modules.order.entity.AreaManager;
import com.jojowonet.modules.sys.dao.RoleDao;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.sys.service.SystemService;

/**
 * 服务商管理Service
 * @author yc
 * @version 2017-08-04
 */
@Component
@Transactional(readOnly = true)
public class SiteManagerService extends BaseService{
	@Autowired
	private SiteManagerDao siteManagerDao;
	@Autowired
	private AreaManagerDao areaManagerDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private SystemService systemService;
	@Autowired
	private SiteAddtimeRecordDao siteAddtimeRecordDao;
	
	public Page<Record> findsiteManager(Page<Record> page,Map<String,Object> map){
		List<Record> list=siteManagerDao.siteList(page, map);
		String sitename;
		String parenttype;

		for (Record rd : list) {
			if(StringUtils.isNotBlank(rd.getStr("share_code_site_parent_id"))){
				if(siteManagerDao.querySiteByid(rd.getStr("share_code_site_parent_id"))!=null){
					sitename=siteManagerDao.querySiteByid(rd.getStr("share_code_site_parent_id")).getStr("name");
					parenttype="售后服务商";
					rd.set("shareParentName", sitename);
					rd.set("shareParenttype", parenttype);
			       }

				}else{
					if(StringUtils.isNotBlank(rd.getStr("area_manager_id"))){
						if(rd.getStr("area_manager_id")!=null){
							sitename=areaManagerDao.getAreaManagerById(rd.getStr("area_manager_id")).getStr("name");
							parenttype="区域管理员";
							rd.set("shareParentName", sitename);
							rd.set("shareParenttype", parenttype);
						}
					
				}
				
			}
     }

     setWxOpenAuthorization(list);
		long count=siteManagerDao.getListCount(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 微信授权
	private void setWxOpenAuthorization(List<Record> list) {
		List<String> siteIds = new ArrayList<>();
		for (Record rd : list) {
			siteIds.add(rd.getStr("id"));
		}
		//Map<String, String> map = new HashMap<>();
		if (list.size() > 0) {
//			List<Record> settings = Db.find("select * from crm_site_common_setting as s where s.site_id in(" + CrmUtils.joinInSql(siteIds) + ") and s.`type`=?", "16");
			List<Record> settings = Db.find("select * from crm_site_common_setting as s where s.site_id in(" + CrmUtils.joinInSql(siteIds) + ") and s.`type` in ('16','17') ");
				for (Record rd : list) {
					if(settings.size() > 0) {
					String siteId = rd.getStr("id");
					rd.set("bangshou", "否");
					rd.set("wx", "否");
					for (Record setting : settings) {
						if(setting.getStr("site_id").equals(siteId)) {
							String typeva = setting.getStr("type");
							String val = setting.getStr("set_value");
							String value= "否";
							//微信是否授权
							if("16".equals(typeva)) {
								value = (val == null || "1".equals(val)) ? "否" : "是";
								rd.set("wx", value);
							}else if("17".equals(typeva)) {//是否授权帮手
								value = (val == null || "0".equals(val)) ? "否" : "是";
								rd.set("bangshou", value);
							}else {
								rd.set("bangshou", "否");
								rd.set("wx", "否");
							}
						}
						//map.put(setting.getStr("site_id"), setting.getStr("set_value"));
					}
				}else {
					rd.set("bangshou", "否");
					rd.set("wx", "否");
				}
				
			}
		}
	}

	//添加服务商操作分为一下几步：1查询信息是否存在 2，将相关信息插入到user表中 
	//3将相关信息添加到crm-site表中 4将相关信息添加到添加时长记录表中
	public String addsiteManager(String name, String telephone, String duetime,
			String loginName, String password, String province, String city,
			String area, String address,String code) {
		
	    String result="result";
	/*	if(siteManagerDao.queryName(name)>=1){
			result="服务商名已存在";
		}else*/ if(siteManagerDao.queryphone(telephone,null,null)>=1){	
			result="该手机号已存在";
		}else if(siteManagerDao.queryloginname(loginName,null)>=1){//
			result="登陆名重复，请修改";
		}else if(areaManagerDao.querycode(code, "")>=1){
		    result="激活码已存在";
		}else{
			User user = new User();	 
			 user.setLoginName(loginName);
			 user.setPassword(SystemService.entryptPassword(password));//设置密码（md5加密）
			 user.setUpdateTime(new Date());
		     user.setCreateDate(new Date());
		     user.setMobile(telephone);
		     user.setCreateType(2);//添加方式为web端添加
		     user.setStatus("0");//状态默认正常
		     user.setUserType("2");//网点人员
		     userDao.save(user);//添加信息到user表中
		    Site site=new Site();
			if(StringUtils.isNotBlank(duetime)){
				Date dueTime=DateUtils.gettime(duetime);
				site.setDueTime(dueTime);
			}
			site.setName(name);
			site.setProvince(province);
			site.setCity(city);
			site.setArea(area);
			site.setAddress(address);
			site.setMobile(telephone);
			site.setTelephone(telephone);
			site.setStatus("0");
			site.setCreateTime(new Date());
			site.setCreateBy(UserUtils.getUser().getId());
			site.setCheckFlag("0");
			site.setLevel("0");
			site.setType("0");
			site.setSmsAvailableAmount(0);
			if(StringUtils.isNotBlank(code)){
				site.setShareCode(code);
			}
			String share_code_site_parent_id=siteManagerDao.queryIdByname("思方科技");
			if(StringUtils.isNotBlank(share_code_site_parent_id)){
				site.setShareCodeSiteParentId(share_code_site_parent_id);
			}
		    site.setUser(user);
		    areaManagerDao.assignUserToRole(roleDao.findByName("售后服务商"), user.getId());//添加到sys_user_role表中
			siteManagerDao.save(site);//添加信息到crm_site表中
			
			if(StringUtils.isNotBlank(duetime)){
				SiteAddtimeRecord siteAddTimeRecord=new SiteAddtimeRecord();
				siteAddTimeRecord.setSiteId(site.getId());
				siteAddTimeRecord.setAddBy(UserUtils.getUser().getId());
				siteAddTimeRecord.setTimeAdd(Integer.parseInt(duetime));
				siteAddTimeRecord.setStartTime(site.getCreateTime());
				if(site.getDueTime()!=null){
					siteAddTimeRecord.setEndTime(site.getDueTime());
				}
				siteAddtimeRecordDao.save(siteAddTimeRecord);//添加信息到时长添加记录表中
			}

		
	       result="ok";     		
	}
	
  return result;
}
//停用服务商
	public void stops(String siteId) {
		String userId=siteManagerDao.getUserIdBysiteId(siteId);
		siteManagerDao.stops(siteId,userId);
		
	}
//启用服务商
	public String start(String siteId) {
		  String result="result";
		
		  Record rd=siteManagerDao.querySiteByid(siteId);
		  String loginName=siteManagerDao.queryUserBysiteId(rd.getStr("user_id"));
		  if(siteManagerDao.queryphone(rd.getStr("mobile"),siteId,rd.getStr("user_id"))>=1){	
				result="登录名："+loginName+"正在被使用无法启用";
			}
		  else if(siteManagerDao.queryloginname(loginName,rd.getStr("user_id"))>=1){//
			  result="登录名："+loginName+"服务商正在被使用无法启用";
			}else{
				String userId=siteManagerDao.getUserIdBysiteId(siteId);
				siteManagerDao.start(siteId,userId);
			}
		
		return result;
	}
//根据id查询服务商所分享的服务商列表
	public List<Record> getsiteList(String id) {
		List<Record> list=siteManagerDao.getsiteList(id);
		for (Record rd : list) {
			String loginName=siteManagerDao.queryUserBysiteId(rd.getStr("user_id"));
			rd.set("loginName",loginName );
		}
		return list;
	}
//根据id查询服务商的信息
	public Record querySiteByid(String id) {
		Record site=siteManagerDao.querySiteByid(id);
		if(site.getDate("due_time")!=null){
			Date duetime=site.getDate("due_time");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String dueTime=sdf.format(duetime);
			site.set("due_time", dueTime);
		}else{
			Date duetime2=new Date();
			SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
			String dueTime2=sdf2.format(duetime2);
			site.set("due_time", dueTime2);
		}

		return site;
	}

	//在添加时长功能中添加相关信息到延长时长记录表中 并且更新该服务商的到期时间
	public void updateSiteDuetime(String id, String duetime, String adddueTime) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String suffix=" 23:59:59";
		String newduetime=adddueTime+suffix;
		siteManagerDao.updateSiteDuetime(id,newduetime);
		SiteAddtimeRecord siteAddTimeRecord=new SiteAddtimeRecord();
		siteAddTimeRecord.setSiteId(id);
		siteAddTimeRecord.setAddBy(UserUtils.getUser().getId());
		if(StringUtils.isNotBlank(adddueTime)){
			siteAddTimeRecord.setTimeAdd(DateUtils.differentDays(duetime, adddueTime));
			try {
				siteAddTimeRecord.setStartTime(sdf.parse(duetime));
				siteAddTimeRecord.setEndTime(sdf.parse(adddueTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		siteAddtimeRecordDao.save(siteAddTimeRecord);
		
		
	}
//查询延长时长记录表记录
	public Page<Record> findsitesiteAddTimeRecord(Page<Record> page,Map<String, Object> map) {
		List<Record> list=siteAddtimeRecordDao.getlist(page, map);
		long count=siteAddtimeRecordDao.getListCount(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}
//根据id查询服务商详情
	public Record querySiteMsgByid(String id) {
		Record rd=siteManagerDao.queryMsgSiteByid(id);
		Date now = new Date();
		String sitename;
		if (rd.getDate("due_time") == null) {
			rd.set("version", "免费版");
		} else {
			if (rd.getDate("due_time").getTime() >= now.getTime()) {
				rd.set("version", "收费版");
			} else {
				rd.set("version", "免费版");
			}
		}
		if(StringUtils.isNotBlank(rd.getStr("share_code_site_parent_id"))){
			if(siteManagerDao.querySiteByid(rd.getStr("share_code_site_parent_id"))!=null){
				sitename=siteManagerDao.querySiteByid(rd.getStr("share_code_site_parent_id")).getStr("name");
				rd.set("shareParentName", sitename);
		       }

			}else{
				if(StringUtils.isNotBlank(rd.getStr("area_manager_id"))){
					if(rd.getStr("area_manager_id")!=null){
						sitename=areaManagerDao.getAreaManagerById(rd.getStr("area_manager_id")).getStr("name");
						rd.set("shareParentName", sitename);
					}
				
			}	
		}
		return rd;
	}

	
}
