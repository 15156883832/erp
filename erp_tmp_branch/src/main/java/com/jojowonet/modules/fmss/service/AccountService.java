package com.jojowonet.modules.fmss.service;


import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.fmss.dao.AccountDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.RandomUtil;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.sys.dao.RoleDao;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.sys.service.SystemService;

import ivan.common.entity.mysql.common.User;
import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;


@Service(value = "AccountService")
@Transactional(readOnly = true)
public class AccountService extends BaseService {

	@Autowired
	private AccountDao accountDao;

	@Autowired
	private SiteDao siteDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	@Autowired
	private SystemService systemService;

	public User get(String id) {
		return accountDao.get(id);
	}

	public User getSiteByUserId(String id) {
		
		return accountDao.getSiteByUserId(id);
	}

	@Transactional
	public void saveSiteUser(User user, String siteName) {
		accountDao.save(user);
		systemService.assignUserToRole(roleDao.findByName("售后服务商"), user.getId());
		Site site = new Site();
		site.setName(siteName);
		site.setNumber(getSiteNumber());
		site.setUser(user);
		site.setUpdateTime(new Date());
		site.setCreateTime(new Date());
		site.setMobile(user.getMobile());
		site.setCheckFlag("0");
		site.setStatus("0");
		siteDao.save(site);
	}

	private static String getSiteNumber() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return sdf.format(new Date()) + RandomUtil.getPositiveRandomWithRang(4);
	}

	public User getUserByMobile(String mobile) {
		return userDao.findByMobile(mobile);
	}

	public User getUserByMail(String mail) {
		return userDao.findByMail(mail);
	}

	public User getUserByToken(String mail, String token) {
		return userDao.findByToken(mail, token);
	}

	public boolean isMailExists(String mail) {
		return getUserByMail(mail) != null;
	}

	public boolean isMobileExists(String mobile) {
		return getUserByMobile(mobile) != null;
	}

	public boolean isTokenValid(String mail, String token) {
		return getUserByToken(mail, token) != null;
	}

	@Transactional()
	public void save(User account) {
		userDao.save(account);
	}

	public long countEmployeByName(String siteId, String name) {
		SqlKit kit = new SqlKit()
				.append("SELECT COUNT(1) as count")
				.append("FROM crm_employe AS e")
				.append("where `site_id`=? and `name`=? and `status`='0'");
		return Db.queryLong(kit.toString(), siteId, name);
	}

    public long countEmployeByName2(String siteId, String name, String empid) {
        SqlKit kit = new SqlKit()
                .append("SELECT COUNT(1) as count")
                .append("FROM crm_employe AS e")
                .append("where `site_id`=? and `name`=? and `status`='0' and id<>?");
        return Db.queryLong(kit.toString(), siteId, name, empid);
    }
}
