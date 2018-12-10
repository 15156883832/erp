package com.jojowonet.modules.finance.form;

import ivan.common.utils.excel.annotation.ExcelField;

import java.math.BigDecimal;

import javax.persistence.ManyToOne;

public class EmployeCostGoodsAll {
	private String salesman;
	private BigDecimal ticheng;
	private BigDecimal commissions;
	private BigDecimal should;
	@ManyToOne
	@ExcelField(title="服务工程师", align=2, sort=10)
	public String getSalesman() {
		return salesman;
	}
	public void setSalesman(String salesman) {
		this.salesman = salesman;
	}
	@ManyToOne
	@ExcelField(title="提成金额", align=2, sort=20)
	public BigDecimal getTicheng() {
		return ticheng;
	}
	public void setTicheng(BigDecimal ticheng) {
		this.ticheng = ticheng;
	}
	@ManyToOne
	@ExcelField(title="当日支付", align=2, sort=30)
	public BigDecimal getCommissions() {
		return commissions;
	}
	public void setCommissions(BigDecimal commissions) {
		this.commissions = commissions;
	}
	@ManyToOne
	@ExcelField(title="应发金额", align=2, sort=40)
	public BigDecimal getShould() {
		return should;
	}
	public void setShould(BigDecimal should) {
		this.should = should;
	}
	

}
