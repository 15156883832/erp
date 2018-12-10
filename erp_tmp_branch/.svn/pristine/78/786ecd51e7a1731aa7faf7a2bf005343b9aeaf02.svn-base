package com.jojowonet.modules.order.form;

import org.apache.commons.lang3.StringUtils;

import com.jfinal.plugin.activerecord.Record;

import ivan.common.entity.mysql.common.Menu;

public class ZtreeNode {

	private String id;
    private Integer state;
    private String pid;
    private String icon;
    private String iconClose;
    private String iconOpen;
    private String name;
    private boolean open;
    private boolean isParent;
    private boolean checked;
    
	public ZtreeNode() {
		super();
	}
	
	public ZtreeNode(Menu menu) {
		if(menu != null){
			this.setId(menu.getId());
			if(menu.getParent() != null && StringUtils.isNotBlank(menu.getParent().getId())){
				this.setPid(menu.getParent().getId());
			}
			this.setName(menu.getName());
			if(menu.getChildList() != null && menu.getChildList().size() > 0){
				this.setParent(true);
			}
		}
	}
	
	public ZtreeNode(Record record) {
		if(record != null){
			this.setId(record.getStr("id"));
			if(StringUtils.isNotBlank(record.getStr("parent_id"))){
				this.setPid(record.getStr("parent_id"));
			}
			this.setName(record.getStr("name"));
		}
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIconClose() {
		return iconClose;
	}
	public void setIconClose(String iconClose) {
		this.iconClose = iconClose;
	}
	public String getIconOpen() {
		return iconOpen;
	}
	public void setIconOpen(String iconOpen) {
		this.iconOpen = iconOpen;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public boolean isParent() {
		return isParent;
	}
	public void setParent(boolean isParent) {
		this.isParent = isParent;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
    
}
