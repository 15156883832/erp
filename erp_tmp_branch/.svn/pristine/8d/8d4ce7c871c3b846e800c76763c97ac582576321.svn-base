package com.jojowonet.modules.operate.utils;

import javax.persistence.ManyToOne;

import ivan.common.utils.excel.annotation.ExcelField;

public class SignRecord {

	private String employeName;
	private String date;
	private String signNum;
	private String signTime;
	private String signType;
	private String signResult;
	private String outTime;
	private String signAddress;
	private String reason;

	@ManyToOne
	@ExcelField(title = "服务工程师", align = 2, sort = 10)
	public String getEmployeName() {
		return employeName;
	}

	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}

	@ManyToOne
	@ExcelField(title = "打卡日期", align = 2, sort = 20)
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	@ManyToOne
	@ExcelField(title = "考勤班次", align = 2, sort = 30)
	public String getSignNum() {
		return signNum;
	}

	public void setSignNum(String signNum) {
		this.signNum = signNum;
	}

	@ManyToOne
	@ExcelField(title = "打卡时间", align = 2, sort = 40)
	public String getSignTime() {
		return signTime;
	}

	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}

	@ManyToOne
	@ExcelField(title = "打卡类别", align = 2, sort = 50)
	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	@ManyToOne
	@ExcelField(title = "打卡状态", align = 2, sort = 60)
	public String getSignResult() {
		return signResult;
	}

	public void setSignResult(String signResult) {
		this.signResult = signResult;
	}

	@ManyToOne
	@ExcelField(title = "迟到时间（分）", align = 2, sort = 70)
	public String getOutTime() {
		return outTime;
	}

	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}

	@ManyToOne
	@ExcelField(title = "打卡地点", align = 2, sort = 80)
	public String getSignAddress() {
		return signAddress;
	}

	public void setSignAddress(String signAddress) {
		this.signAddress = signAddress;
	}

	@ManyToOne
	@ExcelField(title = "请假事由", align = 2, sort = 100)
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

}
