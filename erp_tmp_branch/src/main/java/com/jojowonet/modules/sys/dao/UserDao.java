/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.dao;

import com.jfinal.plugin.activerecord.Db;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Record;


/**
 * 用户DAO接口
 * @version 2013-8-23
 */
@Repository(value="userDaoET")
public class UserDao extends BaseDao<User> {
	
	public List<User> findAllList() {
		return find("from User where status=:p1 order by id", new Parameter(User.DEL_FLAG_NORMAL));
	}
	
	
	public User findByLoginName(String loginName){
		return getByHql("from User where loginName = :p1 and status = :p2", new Parameter(loginName, User.DEL_FLAG_NORMAL));
	}

	public User findByMobile(String mobile) {
		return getByHql("from User where mobile = :p1 and status = :p2", new Parameter(mobile, User.DEL_FLAG_NORMAL));
	}

	public User findByMail(String mail) {
		return getByHql("from User where email = :p1 and status = :p2", new Parameter(mail, User.DEL_FLAG_NORMAL));
	}

	public User findByLoginNamePassword(String loginName,String password) {
		Record userRecord = Db.findFirst("select * from sys_user where (login_name = ? or mobile =? ) and password = ? and status = ? ", loginName,loginName,password, User.DEL_FLAG_NORMAL);
		User user = new User();
		if (userRecord != null) {
			user.setId(userRecord.getStr("id"));
			user.setLoginName(userRecord.getStr("login_name"));
			user.setMobile(userRecord.getStr("mobile"));
			user.setUserType(userRecord.getStr("user_type"));
		}
		return userRecord == null ? null : user;
	}
	
	/**
	 * 通过唯一邮箱验证码和邮箱来找用户
	 */
	public User findByToken(String mail, String token) {
		Record userRecord = Db.findFirst("select * from sys_user where email=? and reset_pwd_token=? and status=?", mail, token, User.DEL_FLAG_NORMAL);
		User user = new User();
		if (userRecord != null) {
			user.setId(userRecord.getStr("id"));
			user.setLoginName(userRecord.getStr("login_name"));
			user.setMobile(userRecord.getStr("mobile"));
		}
		return userRecord == null ? null : user;
	}

	public int updatePasswordById(String newPassword, String id){
		return update("update User set password=:p1 where id = :p2", new Parameter(newPassword, id));
	}
	
	/**
	 * 将record中的Long类型属性的值取出来.
	 *
	 * @param record the record
	 * @param attr 属性名称
	 * @return 默认为long类型的最小值
	 */
	public long getRecordLongValue(Record record, String attr)
	{
		long value = Long.MIN_VALUE;
		if(record != null && attr != null && !attr.isEmpty())
		{
			Long valueL = record.getLong(attr);
			if(valueL != null)
				value = valueL.longValue();
		}
		return value;
	}

	
	//根据登录名和id两个条件查询User
	public User findByLoginNameId(String loginName, String userId) {
		return getByHql("from User where loginName = :p1 and status = :p2 and id!=:p3 ", new Parameter(loginName, User.DEL_FLAG_NORMAL,userId));
	}
	
}
