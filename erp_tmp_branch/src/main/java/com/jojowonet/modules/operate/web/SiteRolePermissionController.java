package com.jojowonet.modules.operate.web;

import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteRolePermissionService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.form.ZtreeNode;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.sys.util.AuthUtils;

@Controller
@RequestMapping(value="${adminPath}/operate/siteRolePermission")
public class SiteRolePermissionController extends BaseController{
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private SiteRolePermissionService siteRolePermissionService;
	
	/*
	 * 服务商权限  点击tab角色权限管理时显示的角色权限列表，同时也是点击默认角色时展示权限的方法
	 */
	@RequestMapping(value = "existRolePermission")
    public String crmLogin(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String sysRoleId = "1";//默认展示信息员对应的权限
		String requestSrId = request.getParameter("sysRoleId");
		if(requestSrId != null && requestSrId != ""){//如果sysRoleId有从前台传过来，则不为null，给sysRoleId赋值，没有的话还是初始化的值
			sysRoleId = requestSrId;
		}
		
    	List<ZtreeNode> nodes = siteRolePermissionService.getAllSiteMenus(siteId,sysRoleId);//下拉树的展示，且判断出那些权限已被勾选
    	List<Record> records = siteRolePermissionService.getDefineRole(siteId);//查出所有的自定义角色（除去已存在表中系统默认的）列表
    	model.addAttribute("list", records);
    	model.addAttribute("siteRoleName", sysRoleId);//角色名称展示
    	model.addAttribute("type", "1");//用于区分点击的是 2自定义角色，1默认权限，3新增角色权限
    	model.addAttribute("nodes", JSONArray.fromObject(nodes));
        return "modules/operate/siteRolePermission";
    }
	
	/*
	 * 服务商权限 点击自定义角色时展示权限的方法
	 */
	@RequestMapping(value = "defineRoleRolePermission")
    public String crmLogin1(HttpServletRequest request, Model model) {
//		String requestSrId = request.getParameter("sysRoleId");
		String sysRolePermissionId = request.getParameter("sysRolePermissionId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	List<ZtreeNode> nodes = siteRolePermissionService.getAllSiteMenus1(siteId,sysRolePermissionId);
    	List<Record> records = siteRolePermissionService.getDefineRole(siteId);//查出所有的自定义角色（出系统默认的）列表
    	Record record = siteRolePermissionService.queryById(siteId,sysRolePermissionId);
    	Record record1 = siteRolePermissionService.ifExist1(sysRolePermissionId);
    	if(record1!=null){
    		model.addAttribute("list", records);
        	model.addAttribute("siteRoleName", record);//角色名称展示
        	model.addAttribute("sort", record.get("sort"));
        	model.addAttribute("type", "2");//用于区分点击的是 2自定义角色，1默认权限，3新增角色权限
        	model.addAttribute("nodes", JSONArray.fromObject(nodes));
    	}else{//新增角色权限页面
    		model.addAttribute("type", "3");
        	model.addAttribute("list", records);
        	model.addAttribute("nodes", JSONArray.fromObject(nodes));
    	}
        return "modules/operate/siteRolePermission";
    }
	
	/*
	 * 删除自定义角色权限
	 */
	@ResponseBody
	@RequestMapping(value = "deleteRole")
    public Boolean deleteRole(String sysRolePermissionId,HttpServletRequest request,HttpServletResponse response, Model model) {
		boolean result = siteRolePermissionService.deleteRole(sysRolePermissionId);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		AuthUtils.clearUserCache(siteId);
		return result;
    }
	
	/*
	 * 点击新增时展示的页面
	 */
	@RequestMapping(value = "defineRoleRolePermission1")//新增
    public String crmLogin2(HttpServletRequest request, Model model) {
		String sysRolePermissionId = request.getParameter("sysRolePermissionId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	List<ZtreeNode> nodes = siteRolePermissionService.getAllSiteMenus3(siteId,sysRolePermissionId);
    	List<Record> records = siteRolePermissionService.getDefineRole(siteId);
    	model.addAttribute("type", "3");
    	model.addAttribute("list", records);
    	model.addAttribute("nodes", JSONArray.fromObject(nodes));
        return "modules/operate/siteRolePermission";
    }
	/*
	 * 新增、修改角色权限的保存事件
	 */
	@RequestMapping(value = "addSave")
    @ResponseBody
    public String addSave(String permissions,String siteRoleName,String addOrEdit, String defaultAddOrEdit,String siteRolePermissionId1, 
    		HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> params = getParams(request);
    	String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	String result = "1";
    	boolean isReturn = false;
    	if("1".equals(addOrEdit)){//修改自定义角色权限
    		result = siteRolePermissionService.saveEditDefine(permissions,siteRolePermissionId1,siteRoleName, params);
    	}else if("2".equals(addOrEdit)){//新增自定义角色权限
    		result = siteRolePermissionService.addDefineRolePermission(siteId,permissions,siteRoleName, params);
    	}else if("3".equals(addOrEdit)){//系统默认的角色权限修改和新增
    		List<Record> records = siteRolePermissionService.ifExist(siteId);
    		for(Record rd : records){
    			if(defaultAddOrEdit.equals(rd.getStr("sys_role_id"))){//系统默认的角色权限修改
    				isReturn = true;
    				result = siteRolePermissionService.saveEditDefault(permissions,siteId,defaultAddOrEdit, params);
    				break;
    			}
    		}
    		if(!isReturn){
    			result = siteRolePermissionService.addDefaultRolePermission(siteId,permissions,siteRoleName,defaultAddOrEdit, params);//系统默认的角色权限添加
    		}
    	}
		AuthUtils.clearUserCache(siteId);
    	return result;
    }
	
	
}
