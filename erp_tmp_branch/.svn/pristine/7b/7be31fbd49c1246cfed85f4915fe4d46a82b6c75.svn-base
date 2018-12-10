package com.jojowonet.modules.order.form;

import java.util.Date;

import ivan.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;

public class SettlementStatisticsForm {
	
	private String number;
	private String employeName;
	private String whetherSettlement;
	private String sumMoney; 
	private Date endTime;
	private String origin;
	private String costDetail;
	private String serviceType;
	
	private String applianceCategory;
	private String applianceBrand;
	
	@Length(min = 1, max = 50)
	@ExcelField(title = "工单编号", align = 2, sort=0)
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "工单来源", align = 2, sort=1)
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	
	@Length(min = 1, max = 50)
	@ExcelField(title = "家电品类", align = 2, sort=2)
	public String getApplianceCategory() {
		return applianceCategory;
	}
	public void setApplianceCategory(String applianceCategory) {
		this.applianceCategory = applianceCategory;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "家电品牌", align = 2, sort=3)
	public String getApplianceBrand() {
		return applianceBrand;
	}
	public void setApplianceBrand(String applianceBrand) {
		this.applianceBrand = applianceBrand;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "工程师姓名", align = 2, sort=5)
	public String getEmployeName() {
		return employeName;
	}
	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "是否结算", align = 2, sort=6)
	public String getWhetherSettlement() {
		return whetherSettlement;
	}
	public void setWhetherSettlement(String whetherSettlement) {
		this.whetherSettlement = whetherSettlement;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "结算金额(元)", align = 2, sort=7)
	public String getSumMoney() {
		return sumMoney;
	}
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}
	@ExcelField(title = "结算明细", align = 2, sort=8)
	public String getCostDetail() {
		return costDetail;
	}
	public void setCostDetail(String costDetail) {
		this.costDetail = costDetail;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title = "完工时间", align = 2, sort=9)
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	@Length(min = 1, max = 50)
	@ExcelField(title = "保修类型", align = 2, sort=4)
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	
	
	

}
