package com.jojowonet.modules.operate.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.UserCustom;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.Date;

/**
 * 服务商DAO接口
 * 
 * @version 2016-08-01
 */
@Repository
public class UserCustomDao extends BaseDao<UserCustom> {

	public String getSkin(User user) {
		String userId = user.getId();
		if(StringUtils.isBlank(userId)) {
			return "blue"; //default-style;
		}

		Record userCustom = Db.findFirst("select * from crm_user_custom where user_id=? limit 1", user.getId());
		return userCustom == null ? "blue" : userCustom.getStr("style");
	}

	public void updateSkin(String userId, String style) {
		Record userCustom = Db.findFirst("select * from crm_user_custom where user_id=? limit 1", userId);
		if(userCustom == null) {
			UserCustom custom = new UserCustom();
			custom.setStyle(style);
			custom.setCreateTime(new Date());
			custom.setUserId(userId);
			save(custom);
		} else {
			Db.update("update crm_user_custom set style=? where user_id=?", style, userId);
		}
	}
}
