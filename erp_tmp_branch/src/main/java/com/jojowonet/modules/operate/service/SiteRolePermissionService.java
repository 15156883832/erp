package com.jojowonet.modules.operate.service;

import java.util.*;

import com.jojowonet.modules.order.utils.SFIMCache;
import ivan.common.entity.mysql.common.Menu;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteRolePermissionDao;
import com.jojowonet.modules.order.form.ZtreeNode;
import com.jojowonet.modules.order.utils.CrmUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.service.BaseService;
import ivan.common.utils.IdGen;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class SiteRolePermissionService extends BaseService {
	
	@Autowired
	private NonServicemanService nonServicemanService;
	
	@Autowired
	private SiteRolePermissionDao siteRolePermissionDao;
	
	/*
	 * 服务商权限  点击tab角色权限管理时显示的角色权限列表，同时也是点击默认角色时展示权限的方法
	 */
	public List<ZtreeNode> getAllSiteMenus(String siteId,String sysRoleId){//系统默认角色
		Record record = defaultRole(siteId,sysRoleId); 
		Map<String, String> perMap = Maps.newHashMap();
		List<Record> menusRd = siteRolePermissionDao.getSystemSiteRoleMenus();//所有的菜单
		Map<String, String> defaultNonservicePermissions = siteRolePermissionDao.getSiteDefaultNonservicemanPermissions(sysRoleId);
		List<ZtreeNode> nodes = Lists.newArrayList();
    	if(record==null){
    		perMap = getSitePermissionArr();//如果用户没有自定义系统默认角色对应的权限，则权限为系统默认角色对应的权限
    	}else{
    		perMap = getSitePermissionArr1(siteId,sysRoleId);//如果用户自定义过系统默认角色对应的权限，则权限为自定义已存在表crm_site_role+permissions中的权限
    	}
    	List<Record> specialPermissionList = siteRolePermissionDao.getSpecialPermissionList();
    	menusRd.addAll(specialPermissionList);
    	filterUserAvailPerms(menusRd, UserUtils.getUser());
    	for(Record rd : menusRd){
			String id = rd.getStr("id");
			if(StringUtils.isNotBlank(id) && !id.contains(",")){
				ZtreeNode zn = new ZtreeNode(rd);
				//zn.setName(zn.getName() + "_" + id);
				if(record == null){//如果用户没有自定义系统默认角色对应的权限，则取我们定义的角色权限
					if(defaultNonservicePermissions.containsKey(id)){//打勾
						zn.setChecked(true);
					}
				}else {//如果用户自定义过系统默认角色对应的权限，则权限为自定义已存在表crm_site_role+permissions中的权限，打勾
					if(perMap.containsKey(zn.getId())){
						zn.setChecked(true);
					}
				}
				nodes.add(zn);
			}
		}
		return nodes;
	}

	@SuppressWarnings("unchecked")
	private static void filterUserAvailPerms(List<Record> userAvailMenu, User user) {
		// 这一部分是过滤一二级网点相关联的工单
		Map<String, Record> map1 = (Map<String, Record>) SFIMCache.get("L1SITE");
		if (map1 == null) {
			throw new RuntimeException("read cache error");
		}
		Map<String, Record> map2 = (Map<String, Record>) SFIMCache.get("L2SITE");
		if (map2 == null) {
			throw new RuntimeException("read cache error");
		}

		boolean isUserBelongsL1Site = CrmUtils.isUserBelongsL1Site(user);
		boolean isUserBelongsL2Site = CrmUtils.isUserBelongsL2Site(user);
		Iterator<Record> iterator = userAvailMenu.iterator();
		while (iterator.hasNext()) {
			Record menu = iterator.next();
			if (map1.containsKey(menu.getStr("id")) && !isUserBelongsL1Site) {
				iterator.remove();
			}
			if (map2.containsKey(menu.getStr("id")) && !isUserBelongsL2Site) {
				iterator.remove();
			}
		}

		// 这是一部分是过滤小厂家相关联的工单
		Map<String, Map<String, Record>> factoryMenuMap = (Map<String, Map<String, Record>>) SFIMCache.get("micro_factory_binding_menu");
		if (factoryMenuMap == null) {
			throw new RuntimeException("read cache error");
		}
		Set<String> bindingFactorys = CrmUtils.getUserBindingFactorys(user);
		Set<String> availFactoryMenus = new HashSet<>(); // common factory menus + 绑定厂家的相应菜单
		Map<String, Record> allFactoryMenus = factoryMenuMap.get("all");
		for (String fid : bindingFactorys) {
			Map<String, Record> menus = factoryMenuMap.get(fid);
			if (menus != null) {
				availFactoryMenus.addAll(menus.keySet());
			}
		}
		if (bindingFactorys.size() > 0) {
			availFactoryMenus.addAll(factoryMenuMap.get("common").keySet());
		}
		Iterator<Record> iterator2 = userAvailMenu.iterator();
		while (iterator2.hasNext()) {
			Record menu = iterator2.next();
			if (allFactoryMenus.containsKey(menu.getStr("id")) && !availFactoryMenus.contains(menu.getStr("id"))) {
				iterator2.remove();
			}
		}

		//去掉2级网点下的工单管理->其他权限菜单(先写死，没法改)
		Iterator<Record> iteratorL2Others = userAvailMenu.iterator();
		while (iteratorL2Others.hasNext()) {
			Record menu = iteratorL2Others.next();
			if (isUserBelongsL2Site && ("da24504e54788935aa2d4bf4b20d1122".equalsIgnoreCase(menu.getStr("id"))
					|| "da24504e54788935aa2d4bf4b20d1122".equalsIgnoreCase(menu.getStr("parent_id"))
					)//去掉这个factory_id为小厂家公共菜单的 !!!! 不明何意
					) {
				iteratorL2Others.remove();
			}
		}
	}
	
	/*
	 * 服务商权限 点击自定义角色时展示权限的方法
	 */
	public List<ZtreeNode> getAllSiteMenus1(String siteId,String sysRolePermissionId){//系统默认角色
//		StringBuilder sb = new StringBuilder("");
		Map<String, String> perMap = new HashedMap() ;
		/*sb.append(" select * from (  ");
		sb.append(" select a.id, a.parent_id, a.name, a.sort from sys_menu a, sys_role_menu b where b.menu_id = a.id and b.role_id = '3' and a.is_show = '1' ");
		sb.append(" and exists (select 1 from sys_menu c where c.id = a.parent_id and c.status = '0') ");
		sb.append(" and a.status = '0' ");
		sb.append(" union all ");
		sb.append(" select a.id, a.parent_id, a.name, a.sort ");
		sb.append(" from sys_menu a where a.target in ('1', '2') ");
		sb.append(" and a.status = '0' and a.is_show = '1' ");
		sb.append(" ) ot order by ot.sort asc ");*/
		Record record = ifExist1(sysRolePermissionId);
		if(record!=null){
			perMap = getSitePermissionArr2(siteId,sysRolePermissionId);//用户自定义角色对应的角色权限
		}else{
			perMap = getSitePermissionArr();
		}
		List<Record> menusRd = siteRolePermissionDao.getSystemSiteRoleMenus();//所有的菜单
		List<Record> specialPermissionList = siteRolePermissionDao.getSpecialPermissionList();
		menusRd.addAll(specialPermissionList);
		filterUserAvailPerms(menusRd, UserUtils.getUser());
		List<ZtreeNode> nodes = Lists.newArrayList();
		for(Record rd : menusRd){
			if(StringUtils.isNotBlank(rd.getStr("id")) && rd.getStr("id").indexOf(",") == -1){
				ZtreeNode zn = new ZtreeNode(rd);
				if(perMap.containsKey(zn.getId())){
					zn.setChecked(true);
				}
				nodes.add(zn);
			}
		}
		return nodes;
	}
	
	/*
	 * 点击新增时展示的页面
	 */
	public List<ZtreeNode> getAllSiteMenus3(String siteId,String sysRoleId){//系统默认角色
		Map<String, String> perMap = getSitePermissionArr();
		List<Record> menusRd = siteRolePermissionDao.getSystemSiteRoleMenus();//所有的菜单
		List<Record> specialPermissionList = siteRolePermissionDao.getSpecialPermissionList();
		menusRd.addAll(specialPermissionList);
		filterUserAvailPerms(menusRd, UserUtils.getUser());
		List<ZtreeNode> nodes = Lists.newArrayList();
		for(Record rd : menusRd){
			if(StringUtils.isNotBlank(rd.getStr("id")) && !rd.getStr("id").contains(",")){
				ZtreeNode zn = new ZtreeNode(rd);
				if(perMap.containsKey(zn.getId())){
					zn.setChecked(true);
				}
				if("3".equals(rd.get("target")) || "4".equals(rd.get("target"))){
					zn.setChecked(true);
				}
				nodes.add(zn);
			}
		}
		return nodes;
	}
	
	public Record  defaultRole(String siteId,String sysRoleId){//根据sys_role_id和site_id查表，看这条默认角色是否已在表中存在
		return Db.findFirst("SELECT a.* FROM crm_site_role_permission a WHERE a.sys_role_id='"+sysRoleId+"' AND a.site_id='"+siteId+"'");
	}
	
	public  Map<String, String> getSitePermissionArr1(String siteId,String sysRoleId){//查询已存在表中的平台默认角色权限
		Record record = defaultRole(siteId,sysRoleId); 
		String permissionStr = record.getStr("permissions");
		Map<String, String> map = Maps.newHashMap();
		String[] perArr = permissionStr.split(",");
		for(int i = 0; i < perArr.length; i++){
			map.put(perArr[i], "1");
		}
		return map;
	}
	
	public  Map<String, String> getSitePermissionArr2(String siteId,String sysRolePermissionId){//用户自定义角色对应的角色权限
		Record record = queryById(siteId,sysRolePermissionId); 
		String permissionStr = record.getStr("permissions");
		Map<String, String> map = Maps.newHashMap();
		String[] perArr = permissionStr.split(",");
		for(int i = 0; i < perArr.length; i++){
			map.put(perArr[i], "1");
		}
		return map;
	}
	
	public List<Record> getDefineRole(String siteId){//查出所有的自定义角色（除去已存在表中系统默认的）列表
		return Db.find("SELECT a.* FROM crm_site_role_permission a WHERE a.sys_role_id IS NULL AND a.site_id='"+siteId+"' order by a.sort desc");
	}
	
	public Record  queryById(String siteId,String sysRolePermissionId){//根据主键id查一条数据
		return Db.findFirst("SELECT a.* FROM crm_site_role_permission a WHERE a.id='"+sysRolePermissionId+"' AND a.site_id='"+siteId+"'");
	}
	
	public Boolean deleteRole(String sysRolePermissionId) {//删除自定义的角色以及对应的权限
		Db.update("DELETE FROM crm_site_role_permission  WHERE id='"+sysRolePermissionId+"'");
		Db.update("DELETE FROM crm_non_serviceman_role_rel WHERE site_role_id ='"+sysRolePermissionId+"'");
		/*String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		
		List<Record> selRoles = siteRolePermissionDao.getAllNonServicemanSelectedRoles(siteId);
		for(Record rd : selRoles){
			String selRoleIds = rd.getStr("selRoleIds");
			String userId = rd.getStr("user_id");
			Map<String, String> perMap = nonServicemanService.getPCManPermissionInRoles(selRoleIds, siteId);
			String upermissions = nonServicemanService.getPermissionStr(perMap);
			Db.update("UPDATE sys_user a SET a.permission='"+upermissions+"' WHERE a.id='"+userId+"'");
		}*/
		return true;
	
    }
	
	 public static String[] union(String[] arr1, String[] arr2) {   
	        Set<String> set = new HashSet<String>();   
	        for (String str : arr1) {   
	            set.add(str);   
	        }   
	        for (String str : arr2) {   
	            set.add(str);   
	        }   
	        String[] result = {};   
	        return set.toArray(result);   
	    }
	 
	public Record  querySiteRoleName(String siteId,String sysRoleId){//根据两个变量唯一确定查出一条数据
		return Db.findFirst("SELECT a.* FROM crm_site_role_permission a WHERE a.sys_role_id='"+sysRoleId+"' AND a.site_id='"+siteId+"'");
	}
	
	public List<Record> ifExist(String siteId){//查询某个服务商下所有的角色权限
		return Db.find("SELECT a.* FROM crm_site_role_permission a WHERE  a.site_id='"+siteId+"'");
	}
	
	public Record  queryPermissions(String siteRolePermissionId1){//根据主键id查一条数据
		return Db.findFirst("SELECT a.* FROM crm_site_role_permission a WHERE a.id='"+siteRolePermissionId1+"'");
	}
	
	public String saveEditDefault(String permissions,String siteId,String defaultAddOrEdit, Map<String, Object> params) {//修改自定义默认的角色时的保存方法
		if(StringUtils.isNotBlank(params.get("sort").toString())){
			Db.update("UPDATE crm_site_role_permission  SET permissions='"+permissions+"', sort='"+params.get("sort")+"' WHERE sys_role_id='"+defaultAddOrEdit+"' AND site_id='"+siteId+"'");
		}else{
			Db.update("UPDATE crm_site_role_permission  SET permissions='"+permissions+"', sort='1' WHERE sys_role_id='"+defaultAddOrEdit+"' AND site_id='"+siteId+"'");
		}
		
		Record rd = Db.findFirst(" select a.id from crm_site_role_permission a where a.site_id = ? and a.sys_role_id = ? ", siteId, defaultAddOrEdit);
		if(rd != null){
			StringBuilder sb = new StringBuilder("");
			sb.append(" select a.`id` , a.`site_role_id`, b.`name`  ");
			sb.append(" from `crm_non_serviceman_role_rel` a, `crm_non_serviceman`  b ");
			sb.append(" where a.`serviceman_id`  = b.`id` ");
			sb.append(" and a.`site_role_id` = '"+defaultAddOrEdit+"' ");
			sb.append(" and b.`site_id`  = '"+siteId+"' ");
			List<Record> oldRds = Db.find(sb.toString());
			if(oldRds != null && oldRds.size() > 0){
				StringBuilder usb = new StringBuilder("");
				for(Record itemRd : oldRds){
					String relId = itemRd.getStr("id");
					usb.append(",").append("'"+relId+"'");
				}
				if(StringUtils.isNotBlank(usb.toString())){
					Db.update(" update crm_non_serviceman_role_rel set site_role_id = '"+rd.getStr("id")+"' where id in ("+usb.toString().substring(1)+") ");
				}
			}
		}
		
		/*List<Record> selRoles = siteRolePermissionDao.getAllNonServicemanSelectedRoles(siteId);
		for(Record rd : selRoles){
			String selRoleIds = rd.getStr("selRoleIds");
			String userId = rd.getStr("user_id");
			Map<String, String> perMap = nonServicemanService.getPCManPermissionInRoles(selRoleIds, siteId);
			String upermissions = nonServicemanService.getPermissionStr(perMap);
			Db.update("UPDATE sys_user a SET a.permission='"+upermissions+"' WHERE a.id='"+userId+"'");
		}*/
		return "2";
		
    }
	
	public String saveEditDefine(String permissions,String siteRolePermissionId1,String siteRoleName, Map<String, Object> params) {//修改自定义添加的角色时的保存方法
		Db.update("UPDATE crm_site_role_permission a SET a.site_role_name='"+siteRoleName+"',a.permissions='"+permissions+"', sort='"+String.valueOf(params.get("sort"))+"' WHERE a.id='"+siteRolePermissionId1+"'");
        
		/*String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> selRoles = siteRolePermissionDao.getAllNonServicemanSelectedRoles(siteId);
		for(Record rd : selRoles){
			String selRoleIds = rd.getStr("selRoleIds");
			String nonsmUId = rd.getStr("user_id");
			Map<String, String> perMap = nonServicemanService.getPCManPermissionInRoles(selRoleIds, siteId);
			String upermissions = nonServicemanService.getPermissionStr(perMap);
			Db.update("UPDATE sys_user a SET a.permission='"+upermissions+"' WHERE a.id='"+nonsmUId+"'");
		}*/
		return "2";
	}
	
	public String addDefineRolePermission(String siteId,String permissions,String siteRoleName, Map<String, Object> params){//新增自定义角色权限
		StringBuilder sb = new StringBuilder("");
		sb.append(" insert into crm_site_role_permission(id, site_id, permissions, site_role_name, sort) values ( ")
    	.append("?, ?, ?, ?, ?")
    	.append(" ) ");
    	Db.update(sb.toString(), IdGen.uuid(), siteId, permissions,siteRoleName, NumberUtils.toInt(String.valueOf(params.get("sort")), 10));
    	return "2";
	}
	
	public String addDefaultRolePermission(String siteId,String permissions,String siteRoleName,String defaultAddOrEdit, Map<String, Object> params){//新增默认角色权限
		String newPermissionId = IdGen.uuid();
		StringBuilder sb = new StringBuilder("");
		sb.append(" insert into crm_site_role_permission(id, site_id, permissions, site_role_name,sys_role_id, sort) values ( ")
    	.append("?, ?, ?, ?, ?, ?")
    	.append(" ) ");
    	Db.update(sb.toString(), newPermissionId, siteId, permissions,siteRoleName,defaultAddOrEdit, NumberUtils.toInt(String.valueOf(params.get("sort")), 10));
    	
    	//需要更新原先端role_rel表中的site_role_id为具体的值
    	List<Record> nonmanRoleRels = siteRolePermissionDao.getSiteNonservicemanRoleRel(siteId);
    	for(Record rd : nonmanRoleRels){
    		if(rd.getStr("site_role_id").equalsIgnoreCase(defaultAddOrEdit)){
    			Db.update("UPDATE crm_non_serviceman_role_rel SET site_role_id=? WHERE id=? ", newPermissionId, rd.getStr("id"));//替换掉默认的site_role_id
    		}
    	}
    	
    	//再更新网点下的人员的permission
		/*List<Record> selRoles = siteRolePermissionDao.getAllNonServicemanSelectedRoles(siteId);
		for(Record rd : selRoles){
			String selRoleIds = rd.getStr("selRoleIds");
			String nonsmUId = rd.getStr("user_id");
			Map<String, String> perMap = nonServicemanService.getPCManPermissionInRoles(selRoleIds, siteId);
			String upermissions = nonServicemanService.getPermissionStr(perMap);
			Db.update("UPDATE sys_user a SET a.permission='"+upermissions+"' WHERE a.id='"+nonsmUId+"'");
		}*/
		return "2";
	}

    public Map<String, String> getSitePermissionArr() {//用户默认角色对应的权限
//		User user = UserUtils.getUser();
//		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
//		String userId = user.getId();
        List<Record> records = siteRolePermissionDao.getSystemSiteRoleMenus();// Db.find(" SELECT * FROM (   SELECT a.id, a.parent_id, a.name, a.sort FROM sys_menu a, sys_role_menu b WHERE b.menu_id = a.id AND b.role_id = '3' AND a.is_show = '1'  AND EXISTS (SELECT 1 FROM sys_menu c WHERE c.id = a.parent_id AND c.status = '0')  AND a.status = '0'  UNION ALL  SELECT a.id, a.parent_id, a.name, a.sort  FROM sys_menu a WHERE a.target IN ('1', '2')  AND a.status = '0' AND a.is_show = '1'  ) ot ORDER BY ot.sort ASC ");
//        StringBuilder st = new StringBuilder();
//        for (Record rd : records) {
//            st.append(",").append(rd.getStr("id"));
//        }
        Map<String, String> map = Maps.newHashMap();
//        String permissionStr = st.toString();
//        if (StringUtils.isNotBlank(permissionStr)) {
//            String[] perArr = permissionStr.split(",");
//            for (String aPerArr : perArr) {
//                map.put(aPerArr, "1");
//            }
//        }


        for (Record rd : records) {
//            st.append(",").append(rd.getStr("id"));
            map.put(rd.getStr("id"), "1");
        }


        return map;
    }

    public Record ifExist1(String sysRolePermissionId){//查询某个服务商下所有的角色权限
		return Db.findFirst("SELECT a.* FROM crm_site_role_permission a WHERE  a.id='"+sysRolePermissionId+"'");
	}
}
