package com.jojowonet.modules.sys.util;

import java.io.Serializable;

public class NotificationMessage implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String title; // 通知消息标题 
	private String description; // 通知消息的简要描述
	
	private int objectType; // 发送对象的类型
	private String registrationIds;  // 发送对象的类型
	
	private int pushTimeType; // 推送时间的类型
	private String startTime; // 开始时间
	private String endTime; // 结束时间
	
	private int nextActionType; // 通知点击的后续动作
	private String nextActionParam; // 通知点击的后续动作的参数
	
	private String alertType; // 消息提醒类型
	private String alertParam; //  消息提醒类型的参数
	
	private String extra; // 用户自定义字段
	
	private String packageName; // 应用的包名

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getObjectType() {
		return objectType;
	}

	public void setObjectType(int objectType) {
		this.objectType = objectType;
	}

	public String getRegistrationIds() {
		return registrationIds;
	}

	public void setRegistrationIds(String registrationIds) {
		this.registrationIds = registrationIds;
	}

	public int getPushTimeType() {
		return pushTimeType;
	}

	public void setPushTimeType(int pushTimeType) {
		this.pushTimeType = pushTimeType;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getNextActionType() {
		return nextActionType;
	}

	public void setNextActionType(int nextActionType) {
		this.nextActionType = nextActionType;
	}

	public String getNextActionParam() {
		return nextActionParam;
	}

	public void setNextActionParam(String nextActionParam) {
		this.nextActionParam = nextActionParam;
	}

	public String getAlertType() {
		return alertType;
	}

	public void setAlertType(String alertType) {
		this.alertType = alertType;
	}

	public String getAlertParam() {
		return alertParam;
	}

	public void setAlertParam(String alertParam) {
		this.alertParam = alertParam;
	}

	public String getExtra() {
		return extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	@Override
	public String toString() {
		return "NotificationMessage [title=" + title + ", description="
				+ description + ", objectType=" + objectType
				+ ", registrationIds=" + registrationIds + ", pushTimeType="
				+ pushTimeType + ", startTime=" + startTime + ", endTime="
				+ endTime + ", nextActionType=" + nextActionType
				+ ", nextActionParam=" + nextActionParam + ", alertType="
				+ alertType + ", alertParam=" + alertParam + ", extra=" + extra
				+ ", packageName=" + packageName + "]";
	}
	
}
