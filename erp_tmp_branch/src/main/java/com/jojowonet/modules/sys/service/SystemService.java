/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.utils.DataUtils;
import com.jojowonet.modules.fmss.utils.HttpUtils;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.form.ZtreeNode;
import com.jojowonet.modules.order.utils.RandomUtil;
import com.jojowonet.modules.sys.dao.MenuDao;
import com.jojowonet.modules.sys.dao.RoleDao;
import com.jojowonet.modules.sys.dao.UserDao;

import ivan.common.entity.mysql.common.Menu;
import ivan.common.entity.mysql.common.Role;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.security.SystemAuthorizingRealm;
import ivan.common.service.BaseService;
import ivan.common.utils.MD5;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @version 2013-5-15
 */
@Service(value="systemServiceET")
@Transactional(readOnly = true)
public class SystemService extends BaseService  {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;
	private static String SIM_PASSWORD_MD5_16 = "012A124E5AD7E8BC";
	private static String SIM_LOGIN_NAME = "jojowo88";
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private SystemAuthorizingRealm systemRealm;
	
	/*@Autowired
	private IdentityService identityService;*/

	//-- User Service --//
	
	public User getUser(String id) {
		return userDao.get(id);
	}

	@Transactional(readOnly = false)
	public void updateLoginTime(String userId){
		Db.update(" update sys_user set update_time = ? where id = ? ", new Date(), userId);
	}
	
	public Page<User> findUser(Page<User> page, User user) {
		DetachedCriteria dc = userDao.createDetachedCriteria();
		User currentUser = UserUtils.getUser();
		// 如果不是超级管理员，则不显示超级管理员用户
		if (!currentUser.isAdmin()){
			dc.add(Restrictions.ne("id", "1")); 
		}
		dc.add(dataScopeFilter(currentUser, "office", ""));
		if (StringUtils.isNotEmpty(user.getLoginName())){
			dc.add(Restrictions.like("loginName", "%"+user.getLoginName()+"%"));
		}
		if (StringUtils.isNotEmpty(user.getLoginName())){
			dc.add(Restrictions.like("name", "%"+user.getLoginName()+"%"));
		}
		dc.add(Restrictions.eq("status", "0"));
		return userDao.find(page, dc);
	}

	//取用户的数据范围
	public String getDataScope(User user){
		return dataScopeFilterString(user, "office", "");
	}
	
	/**
	 * 根据loginName查询用户
	 * @param loginName 用户名
	 * @return
	 */
	public User getUserByLoginName(String loginName) {
		return userDao.findByLoginName(loginName);
	}
	public User findByMobile(String loginName) {
		return userDao.findByMobile(loginName);
	}
	public User findByLoginNamePassword(String loginName,String password) {
		return userDao.findByLoginNamePassword(loginName,password);
	}

	@Transactional(readOnly = false)
	public void saveUser(User user) {
		userDao.clear();
		userDao.save(user);
		systemRealm.clearAllCachedAuthorizationInfo();
		// 同步到Activiti
		//saveActiviti(user);
	}

	@Transactional(readOnly = false)
	public void deleteUser(String id) {
		userDao.deleteById(id);
		// 同步到Activiti
		//deleteActiviti(userDao.get(id));
	}
	
	public Record getorderNumber(String number, String siteId){
		return orderDao.getorderNumber(number, siteId);
	}
	
	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String loginName, String newPassword) {
		userDao.updatePasswordById(entryptPassword(newPassword), id);
		systemRealm.clearCachedAuthorizationInfo(loginName);
	}
	
	@Transactional(readOnly = false)
	public void updatePassword(String id, String newPassword) {
		userDao.updatePasswordById(entryptPassword(newPassword), id);
	}
	
	/***
	 * 
	 * @param id
	 * @param provinces 存放在sys_user的permission中，运营帐号的权限相当与省市区
	 */
	public void updateSysUserProvinces(Object id, Object provinces){
		Db.update(" update sys_user set permission = ? where id = ? ", provinces, id);
	}
	
	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		return MD5.MD5(plainPassword);
	}
	
	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		return password.equals(MD5.MD5(plainPassword));
	}
	
	//-- Role Service --//
	
	public Role getRole(String id) {
		return roleDao.get(id);
	}

	public Role findRoleByName(String name) {
		return roleDao.findByName(name);
	}
	
	public List<Role> findAllRole(){
		return UserUtils.getRoleList();
	}
	
	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		roleDao.clear();
		roleDao.save(role);
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
		// 同步到Activiti
		//saveActiviti(role);
	}

	@Transactional(readOnly = false)
	public void deleteRole(String id) {
		roleDao.deleteById(id);
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
		// 同步到Activiti
		//deleteActiviti(roleDao.get(id));
	}
	
	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, String userId) {
		User user = userDao.get(userId);
		List<String> roleIds = user.getRoleIdList();
		List<Role> roles = user.getRoleList();
		// 
		if (roleIds.contains(role.getId())) {
			roles.remove(role);
			saveUser(user);
			return true;
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, String userId) {
		User user = userDao.get(userId);
		List<String> roleIds = user.getRoleIdList();
		if (roleIds.contains(role.getId())) {
			return null;
		}
		user.getRoleList().add(role);
		saveUser(user);		
		return user;
	}

	//-- Menu Service --//
	
	public Menu getMenu(String id) {
		return menuDao.get(id);
	}

	public List<Menu> findAllMenu(){
		return UserUtils.getAllMenuList();
	}
	
	@Transactional(readOnly = false)
	public void saveMenu(Menu menu) {
		menu.setParent(this.getMenu(menu.getParent().getId()));
		String oldParentIds = menu.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		menu.setParentIds(menu.getParent().getParentIds()+menu.getParent().getId()+",");
		menuDao.clear();
		menuDao.save(menu);
		// 更新子节点 parentIds
		List<Menu> list = menuDao.findByParentIdsLike("%,"+menu.getId()+",%");
		for (Menu e : list){
			e.setParentIds(e.getParentIds().replace(oldParentIds, menu.getParentIds()));
		}
		menuDao.save(list);
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		// 同步到Activiti
		//saveActiviti(menu);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(String id) {
		menuDao.deleteById(id, "%,"+id+",%");
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		// 同步到Activiti
		//deleteActiviti(id);
	}
	
	public List<User> findAllList(){
		return userDao.findAllList();
		
	}

	public Map<String, Object> SendSim(String mobile) {
		Map<String, Object> res = new HashMap<String,Object>();
		if(mobile != null && !mobile.isEmpty()) {
			String valcode = RandomUtil.getPositiveRandomWithRang(4);
			String content = "尊敬的用户您好，欢迎使用智惠家，手机验证码为："+valcode+"。回TD退订【智惠家科技】";
			try {
				content = URLEncoder.encode(content, "gb2312");
			} catch (UnsupportedEncodingException e) {
			}
			String url = "http://sdk.zyer.cn/SmsService/SmsService.asmx/SendEx?LoginName="+SIM_LOGIN_NAME
					+"&Password="+SIM_PASSWORD_MD5_16
					+"&SmsKind=803&SendSim="+mobile
					+"&ExpSmsId=&MsgContext="+content;
			HttpUtils.doGet(url, null,"utf-8");
			res.put("valcode", valcode);
		}
		return res;
	}

	public boolean getUserByMobileForSite(String mobile) {
		return siteDao.isMobileExists(mobile);
	}
	
	public List<ZtreeNode> getAllMenusByRoleIdInZt(String roleId){
		List<Menu> menus = UserUtils.getAllMenuList();
		List<Record> menusRd = getAllMenusByRoleId(roleId);
		Map<String, Object> seletedMenus = DataUtils.records2Map(menusRd, "id");
		List<ZtreeNode> nodes = Lists.newArrayList();
		for(Menu mu : menus){
			if(StringUtils.isNotBlank(mu.getId())){
				ZtreeNode zn = new ZtreeNode(mu);
				if(seletedMenus.containsKey(zn.getId())){
					if(("3".equals(roleId) || "4".equals(roleId)) && StringUtils.isNotBlank(mu.getTarget())){
						zn.setChecked(true);
					}else{
						if(StringUtils.isBlank(mu.getTarget())){
							zn.setChecked(true);
						}
					}
				}
				nodes.add(zn);
			}
		}
		return nodes;
	}
	
	public List<Record> getSysUserList(List<Record> provinces){
		StringBuilder sb = new StringBuilder("");
		sb.append(" select * from sys_user a where a.user_type = '1' and a.status = '0' order by a.create_date asc ");
		List<Record> retList = Db.find(sb.toString());
		for(Record rd : retList){
			String permission = rd.getStr("permission");
			if(StringUtils.isNotBlank(permission)){
				String[] provIds = permission.split(",");
				StringBuilder psb = new StringBuilder("");
				for(String proId : provIds){
					for(Record provRd : provinces){
						if(proId.equalsIgnoreCase(String.valueOf(provRd.get("ProvinceID")))){
							psb.append(",").append(provRd.getStr("ProvinceName"));
							break;
						}
					}
				}
				if(psb.toString().indexOf(",") != -1){
					rd.set("provinceName", psb.toString().substring(1));
				}
			}
		}
		return retList;
	}
	
	public List<Record> getAllMenusByRoleId(String roleId){
		StringBuilder sb = new StringBuilder("");
		sb.append(" select * from (  ");
		sb.append(" select a.id, a.parent_id, a.name, a.sort, a.target from sys_menu a, sys_role_menu b where b.menu_id = a.id and b.role_id = '"+roleId+"' and a.is_show = '1' ");
		sb.append(" and exists (select 1 from sys_menu c where c.id = a.parent_id and c.status = '0') ");
		sb.append(" and a.status = '0' ");
		sb.append(" union all ");
		sb.append(" select a.id, a.parent_id, a.name, a.sort, a.target ");
		sb.append(" from sys_menu a where a.target in ('1', '2') ");
		sb.append(" and a.status = '0' and a.is_show = '1' ");
		sb.append(" ) ot order by ot.sort asc ");
		return Db.find(sb.toString());
	}
}
