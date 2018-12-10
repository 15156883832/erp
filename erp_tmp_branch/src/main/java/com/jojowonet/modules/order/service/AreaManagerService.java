package com.jojowonet.modules.order.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.order.dao.AreaManagerDao;
import com.jojowonet.modules.order.entity.AreaManager;
import com.jojowonet.modules.sys.dao.RoleDao;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.sys.service.SystemService;


@Component
@Transactional(readOnly = true)
public class AreaManagerService extends BaseService {
	@Autowired
	private AreaManagerDao areaManagerDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private NonServicemanService nonServicemanService;
	
	//区域管理人员的列表查询
	public Page<Record> findAreaManager(Page<Record> page,Map<String,Object> map){
		List<Record> list=areaManagerDao.getAreaManagerList(page, map);
		long count=areaManagerDao.getListCount(map);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	public Record getAreaManagerByUserid(String userid) {
		return areaManagerDao.getAreaManagerByUserid(userid);
	}
	
	////在添加和修改时当为二级区管时获取上级区管的列表
	public List<Record> changedistrict() {
		return areaManagerDao.changedistrict();
		
	}
	public List<Record> areamanagerList() {
		return areaManagerDao.areamanagerList();
		
	}

	//查询条件中获取所有区域列表
	public List<Record> getarealist() {
		return areaManagerDao.getarealist();
	}
	
	//分享服务商个数列表
	public Page<Record> getsiteList(Page<Record> page,String id){
		List<Record> list=areaManagerDao.getsiteList(page, id);
		long count=areaManagerDao.getsiteListCount(id);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	//关联服务商个数列表
	public Page<Record> getbindingsiteList(Page<Record> page,String id){
		List<Record> list=areaManagerDao.getbindingsiteList(page, id);
		long count=areaManagerDao.getbindingsiteCount(id);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	//启用和停用区域人员的方法
	public Integer updateStatus(String id, String status) {
		String userId="";
		if(areaManagerDao.getAreaManagerById(id).getStr("user_id")!=null){
			 userId=areaManagerDao.getAreaManagerById(id).getStr("user_id");
		}
		if(StringUtils.isNotBlank(userId)){
			areaManagerDao.updateUser(userId,status);
		}
		
		return areaManagerDao.updatestatus(id, status);
		
	}

//在调用save方法保存修改或者添加的数据时调用方法，分为以下几步1：查询分享码是否符合条件（查重复） 2：查询手机号是否重复 3：将信息放入user表中保存 
	 //                        4：将信息保存到crm_area_mananger表中并将user_id与sys_user表中的id关联起来，5：保存信息到sys_user_role表中
	public String save(String superiorDistrict, String name, String phone,
			String area, String code,String id,String oldname,String loginName,String password) {
		String result="";
		long count = nonServicemanService.checkValid3(loginName);//user loginName 唯一
		if(count>0){//登陆名重复
			return result="login";
		}else if(areaManagerDao.queryName(name,id)>=1){
			result="姓名已存在";
		}else if(areaManagerDao.querycode(code,id)>=1){
			result="激活码重复，请修改";
		}else if(areaManagerDao.queryphone(phone,id)>=1){
				result="该手机号已存在";
		}else{//当id不为空执行修改操作
			if(StringUtils.isNotBlank(id)){
				String userId=areaManagerDao.getAreaManagerById(id).getStr("user_id");//获取改id的区域管理人员的user_id
				 User user = userDao.get(userId);	 
				/* user.setLoginName(phone);
				 user.setPassword(SystemService.entryptPassword(phone));//设置密码（md5加密）*/	
				 //2018-5-22修改 ，登陆账号不给修改
				if(StringUtils.isNotBlank(password)) {
					user.setPassword(SystemService.entryptPassword(password));//设置密码（md5加密）
				}
				 user.setUpdateTime(new Date());
			     user.setMobile(phone);
			     userDao.save(user);
				AreaManager areaManager=areaManagerDao.get(id);
				if(StringUtils.isNotBlank(superiorDistrict)){
					areaManager.setSuperiorDistrict(superiorDistrict);
				}
				areaManager.setName(name);
				areaManager.setPhone(phone);
				areaManager.setArea(area);
				areaManager.setCode(code);
				areaManagerDao.save(areaManager);
		       result="ok";
			}else{//id为空执行添加操作
				
				 User user = new User();	 
				/* user.setLoginName(phone);
				 user.setPassword(SystemService.entryptPassword(password));//设置密码（md5加密）*/		
				 user.setLoginName(loginName);
				 user.setPassword(SystemService.entryptPassword(password));//设置密码（md5加密）
				 user.setUpdateTime(new Date());
			     user.setCreateDate(new Date());
			     user.setMobile(phone);
			     user.setCreateType(2);//添加方式为web端添加
			     user.setStatus("0");//状态默认正常
			     user.setUserType("5");//区域管理人员
			     userDao.save(user);
				AreaManager areaManager=new AreaManager();
				if(StringUtils.isNotBlank(superiorDistrict)){
					areaManager.setSuperiorDistrict(superiorDistrict);
				}
				areaManager.setName(name);
				areaManager.setPhone(phone);
				areaManager.setArea(area);
				areaManager.setCode(code);
				
			   
			     areaManager.setUserId(user.getId());
			     areaManagerDao.assignUserToRole(roleDao.findByName("区域管理员"), user.getId());//添加到sys_user_role表中
				areaManagerDao.save(areaManager);
		       result="ok";
			}
			
		}
		
	return result;
		
		
	}


	public Record getAreaManagerById(String id) {
		Record rd=areaManagerDao.getAreaManagerById(id);
		return rd;
	}

	public Object checkAreaManager(String ids) {
		Map<String,Object> mass = Maps.newHashMap(); 
		Map<String,Object> map = areaManagerDao.getareaManagerMap();
		StringBuilder sf = new StringBuilder();
		String siteIds[] = ids.split(",");
		String check = "ok";
		for(String id : siteIds) {
			if(map.containsKey(id)) {
				sf.append(map.get(id)).append("<br>");
			}
		}
		if(StringUtils.isNotBlank(sf)) {
			check = "no";
			mass.put("data", sf.toString());
		}
		mass.put("check", check);
		return mass;
	}
	
	public int  insertareaManagerSite(String siteIds,String areaId) {
		return areaManagerDao.insertareaManagerSite(siteIds, areaId);
	}
	public String getCheckBinding(String siteId) {
		return areaManagerDao.getCheckBinding(siteId);
	}
	
	//删除绑定关系
	public int  deleteareaManagerSite(String siteIds) {
		return areaManagerDao.deleteareaManagerSite(siteIds);
	}
}
