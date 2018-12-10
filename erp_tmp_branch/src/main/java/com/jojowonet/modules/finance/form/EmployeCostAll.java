package com.jojowonet.modules.finance.form;

import ivan.common.utils.excel.annotation.ExcelField;

import java.math.BigDecimal;

import javax.persistence.ManyToOne;

public class EmployeCostAll {
	
	private String employeName;
	private BigDecimal sumMoney;
	private BigDecimal todayMoney;
	private BigDecimal relMoney;
	
	@ManyToOne
	@ExcelField(title="服务工程师", align=2, sort=10)
	public String getEmployeName() {
		return employeName;
	}
	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}
	
	@ManyToOne
	@ExcelField(title="结算金额", align=2, sort=20)
	public BigDecimal getSumMoney() {
		return sumMoney;
	}
	public void setSumMoney(BigDecimal sumMoney) {
		this.sumMoney = sumMoney;
	}
	@ManyToOne
	@ExcelField(title="当日支付", align=2, sort=30)
	public BigDecimal getTodayMoney() {
		return todayMoney;
	}
	public void setTodayMoney(BigDecimal todayMoney) {
		this.todayMoney = todayMoney;
	}
	@ManyToOne
	@ExcelField(title="应付金额", align=2, sort=40)
	public BigDecimal getRelMoney() {
		return relMoney;
	}
	public void setRelMoney(BigDecimal relMoney) {
		this.relMoney = relMoney;
	}
	
	
}
