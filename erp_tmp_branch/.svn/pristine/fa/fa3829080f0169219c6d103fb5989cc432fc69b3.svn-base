package com.jojowonet.modules.sys.entity;

import java.util.List;

/**
 * 在system中简单控制system角色人员的权限
 * @author ivan
 *
 */
public class SystemMenuRule {

	private String userName;
	private List<SystemMenuRuleItem> menuItems;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public List<SystemMenuRuleItem> getMenuItems() {
		return menuItems;
	}

	public void setMenuItems(List<SystemMenuRuleItem> menuItems) {
		this.menuItems = menuItems;
	}

	public boolean isValid(String menuName, String level){
		for(SystemMenuRuleItem item : menuItems){
			if(item.containsMenu(menuName, level)){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 判断页面权限
	 */
	public boolean isPageBtnValid(String authTag){
		if(menuItems != null){
			for(SystemMenuRuleItem item : menuItems){
				if(item.containsPageMenu(authTag)){
					return true;
				}
			}
		}
		return false;
	}
}
