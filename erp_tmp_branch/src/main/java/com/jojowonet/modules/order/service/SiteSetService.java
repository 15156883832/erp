package com.jojowonet.modules.order.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.unipay.utils.TradeNoUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.entity.mysql.common.UserRoleEntity;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.MD5;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class SiteSetService extends BaseService {
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private UserDao userDao;
	
	public Page<Record> siteSetList(Page<Record> page){
		List<Record> list =  siteList(page);
		Long count = siteCount();
		page.setCount(count);
		page.setList(list);
		return page;
	}

	public List<Record> siteList(Page<Record> page){
		StringBuffer sf = new StringBuffer();
		sf.append("select a.*,u.login_name,u.password from crm_site a left join sys_user u on a.user_id=u.id where u.status='0' and a.status='0'");
		sf.append(" order by a.create_time desc");
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		
		return Db.find(sf.toString());
	}
	
	public Long siteCount(){
		return Db.queryLong("select count(*) from crm_site a left join sys_user u on a.user_id=u.id where u.status='0' and a.status='0'");
	}
	
	@Transactional(rollbackFor=Exception.class)
	public String save(Map<String,Object> map){
		User user = UserUtils.getUser();
		String siteId = ((String[])map.get("oId"))[0];
		String type = ((String[])map.get("type"))[0];
		String name="";
		String loginName="";
		String password = "";
		String mobile = "";
		if(StringUtils.isNotBlank(((String[])map.get("name"))[0])){
			name = ((String[])map.get("name"))[0];
		}
		if(StringUtils.isNotBlank(((String[])map.get("loginName"))[0])){
			loginName = ((String[])map.get("loginName"))[0];
		}
		if(StringUtils.isNotBlank(((String[])map.get("password"))[0])){
			password = ((String[])map.get("password"))[0];
		}
		if(StringUtils.isNotBlank(((String[])map.get("mobile"))[0])){
			mobile = ((String[])map.get("mobile"))[0];
		}
		
		try {
			if(type.equals("1")){//编辑
				Long count1 = Db.queryLong("select count(*) from crm_site a where a.status='0' and a.name='"+name+"'");
				Long count2 = Db.queryLong("select count(*) from sys_user a where a.status='0' and a.user_type !='4' and a.login_name='"+loginName+"'");
				Long count3 = Db.queryLong("select count(*) from sys_user a where a.status='0' and a.user_type !='4'  and a.mobile='"+mobile+"'");
				if(!((String[])map.get("oldName"))[0].equals(name)){
					if(count1>0){//服务商名称已存在
						return "existName";
					}
				}
				if(!((String[])map.get("oldLoginName"))[0].equals(loginName)){
					if(count2>0){//登陆账号已存在
						return "existLoginName";
					}
				}
				if(!((String[])map.get("oldMobile"))[0].equals(mobile)){
					if(count3>0){
						return "existMobile";
					}
				}
				Site site = siteDao.get(siteId);
				site.setName(name);
				site.setMobile(mobile);
				site.setUpdateTime(new Date());
				site.setCity(((String[])map.get("cty"))[0]);
				site.setArea(((String[])map.get("distc"))[0]);
				site.setProvince(((String[])map.get("provi"))[0]);
				site.setAddress(((String[])map.get("spanadress"))[0]);
				siteDao.save(site);
				if(StringUtils.isNotBlank(password)){
					Db.update("update sys_user a set a.login_name='"+loginName+"',a.password='"+MD5.MD5(password)+"',a.update_time=now() where a.id='"+site.getUser().getId()+"'");
				}else{
					Db.update("update sys_user a set a.login_name='"+loginName+"',a.update_time=now() where a.id='"+site.getUser().getId()+"'");
				}
			}else if(type.equals("2")){//新增
				Long count1 = Db.queryLong("select count(*) from crm_site a where a.status='0' and a.name='"+name+"'");
				Long count2 = Db.queryLong("select count(*) from sys_user a where a.status='0' and a.user_type !='4' and a.login_name='"+loginName+"'");
				Long count3 = Db.queryLong("select count(*) from sys_user a where a.status='0' and a.user_type !='4'  and a.mobile='"+mobile+"'");
				if(count1>0){//服务商名称已存在
					return "existName";
				}
				if(count2>0){//登陆账号已存在
					return "existLoginName";
				}
				if(count3>0){
					return "existMobile";
				}
				Site site = new Site();
				User user1 = new User();
				user1.setLoginName(loginName);
				user1.setPassword(MD5.MD5(password));
				user1.setCreateBy(user.getId());
				user1.setCreateDate(new Date());
				user1.setUpdateTime(new Date());
				user1.setUserType("2");//网点
				user1.setCreateType(2);//wed端添加
				user1.setStatus("0");
				user1.setMobile(mobile);
				userDao.save(user1);
				
				site.setName(name);
				site.setMobile(mobile);
				site.setNumber(genUniqueNo());
				site.setStatus("0");
				site.setUser(user1);
				site.setCheckFlag("0");
				site.setUpdateTime(new Date());
				site.setCreateTime(new Date());
				site.setCreateBy(user.getId());
				site.setCity(((String[])map.get("cty"))[0]);
				site.setArea(((String[])map.get("distc"))[0]);
				site.setProvince(((String[])map.get("provi"))[0]);
				site.setAddress(((String[])map.get("spanadress"))[0]);
				siteDao.save(site);
				
				Db.update("insert into sys_user_role (user_id,role_id) values ('"+user1.getId()+"','3')");
			}
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}
	
	public Boolean deleteSite(String id){
		try {
			Site site = siteDao.get(id);
			Db.update("update sys_user a set a.status='2' where a.id='"+site.getUser().getId()+"'");
			Db.update("update crm_site a set a.status='1' where a.id='"+id+"'");
			//Db.update("delete from  sys_user_role a where a.user_id='"+site.getUser().getId()+"' and a.role_id='"+id+"'");
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public Record getDetail(String id){
		return Db.findFirst("select *,u.login_name,u.password from crm_site a left join sys_user u on a.user_id=u.id where a.status='0' and u.status='0' and a.id='"+id+"' ");
	}
	
	public static String genUniqueNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        return sdf.format(new Date()) + getPositiveRandomWithRang(4);
    }

    private static String getPositiveRandomWithRang(int count) {
        StringBuilder sb = new StringBuilder();
        String str = "0123456789";
        Random r = new Random();
        for (int i = 0; i < count; i++) {
            int num = r.nextInt(str.length());
            sb.append(str.charAt(num));
            str = str.replace((str.charAt(num) + ""), "");
        }
        return sb.toString();
    }
    
    public Record getSiteMsg(String siteId){
    	return Db.findFirst("select a.* from crm_site a where a.id=? and a.status='0'",siteId);
    }
    
    @Transactional
    public Result<T> updateRrepairPhone(String repairPhone,String siteId){
    	Result<T> rt = new Result<T>();
    	SQLQuery sql = siteDao.getSession().createSQLQuery("update crm_site a set a.repair_phone='"+repairPhone+"' where a.id='"+siteId+"' and a.status='0'");
    	sql.executeUpdate();
    	rt.setCode("200");
    	rt.setMsg("update success");
    	return rt;
    }

}
