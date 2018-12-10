package com.jojowonet.modules.sys.entity;

import org.apache.commons.lang.StringUtils;

public class SystemMenuRuleItem {

	private String level;//菜单等级，1:一级菜单，2：左侧菜单，3tab页面，4,页面上的按钮
	private String name;//菜单名称
	private String authTag;//页面权限标识，相当与服务商权限中的sys_menu里面的href
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthTag() {
		return authTag;
	}
	public void setAuthTag(String authTag) {
		this.authTag = authTag;
	}
	/**
	 * 该方法判断一级二级菜单，不判断页面上的菜单
	 * @param menuName
	 * @param menulevel
	 * @return 对于一二级的话，返回true则表示显示，false表示在页面不显示
	 */
	public boolean containsMenu(String menuName, String menulevel){
		if(StringUtils.isNotBlank(menuName)){
			return menuName.equals(name) && menulevel.equals(this.level);
		}
		return false;
	}
	
	/**
	 * 
	 * @param authTag
	 * @return 控制页面按钮，true:显示按钮，false不显示按钮
	 */
	public boolean containsPageMenu(String authTag){
		if(StringUtils.isNotBlank(authTag)){
			return authTag.equals(this.authTag);
		}
		return false;
	}
}
