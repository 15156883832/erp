package com.jojowonet.modules.order.form;


import ivan.common.utils.DateUtils;
import ivan.common.utils.excel.annotation.ExcelField;

import com.jfinal.plugin.activerecord.Record;

public class ExpEmpDailySignForm {
    
    private String id;
    private String dateStr;
    private String signinAddress;
    private String signinTime;
    private String signoutAddress;
    private String signoutTime;
    private String employeId;
    private String employeName;
    private String createTime;
    private String siteId;
    private String status;
    
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@ExcelField(title = "考勤日期", align = 2, sort=20)
	public String getDateStr() {
		return dateStr;
	}
	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
	}
	
	@ExcelField(title = "签到地址", align = 2, sort=40)
	public String getSigninAddress() {
		return signinAddress;
	}
	public void setSigninAddress(String signinAddress) {
		this.signinAddress = signinAddress;
	}
	
	@ExcelField(title = "签到时间", align = 2, sort=30)
	public String getSigninTime() {
		return signinTime;
	}
	public void setSigninTime(String signinTime) {
		this.signinTime = signinTime;
	}
	
	@ExcelField(title = "签退地址", align = 2, sort=60)
	public String getSignoutAddress() {
		return signoutAddress;
	}
	public void setSignoutAddress(String signoutAddress) {
		this.signoutAddress = signoutAddress;
	}
	
	@ExcelField(title = "签退时间", align = 2, sort=50)
	public String getSignoutTime() {
		return signoutTime;
	}
	public void setSignoutTime(String signoutTime) {
		this.signoutTime = signoutTime;
	}
	public String getEmployeId() {
		return employeId;
	}
	public void setEmployeId(String employeId) {
		this.employeId = employeId;
	}
	
	@ExcelField(title = "工程师", align = 2, sort=10)
	public String getEmployeName() {
		return employeName;
	}
	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	public ExpEmpDailySignForm() {
		super();
	}
	
	public ExpEmpDailySignForm(Record rd) {
		this.id = rd.getStr("id");
		if(rd.getDate("date") != null){
			this.dateStr = DateUtils.formatDate(rd.getDate("date"), "yyyy-MM-dd");
		}
		this.signinAddress = rd.getStr("signin_address");
		if(rd.getDate("signin_time") != null){
			this.signinTime = DateUtils.formatDate(rd.getDate("signin_time"), "yyyy-MM-dd HH:mm:ss");
		}
		this.signoutAddress = rd.getStr("signout_address");
		if(rd.getDate("signout_time") != null){
			this.signoutTime = DateUtils.formatDate(rd.getDate("signout_time"), "yyyy-MM-dd HH:mm:ss");
		}
		this.employeId = rd.getStr("employe_id");
		this.employeName = rd.getStr("employe_name");
		this.createTime = DateUtils.formatDate(rd.getDate("create_time"), "yyyy-MM-dd HH:mm:ss");
		this.siteId = rd.getStr("site_id");
		this.status = rd.getStr("status");
	}
	
}
