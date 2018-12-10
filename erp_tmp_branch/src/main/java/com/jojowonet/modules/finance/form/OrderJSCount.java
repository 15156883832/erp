package com.jojowonet.modules.finance.form;

import javax.persistence.ManyToOne;

import ivan.common.utils.excel.annotation.ExcelField;

public class OrderJSCount {

	private String orderType;
	private Long m1;
	private double m2;
	private double m3;
	private double m4;
	private double m5;
	private double m6;
	private double m7;
	private double m8;
	private double m9;
	private double m10;
	private double m11;
	private double m12;

	@ManyToOne
	@ExcelField(title = "工单类型", align = 2, sort = 10)
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}


	@ManyToOne
	@ExcelField(title = "工单数量", align = 2, sort = 12)
	public Long getM1() {
		return m1;
	}

	public void setM1(Long m1) {
		this.m1 = m1;
	}

	@ManyToOne
	@ExcelField(title = "服务费", align = 2, sort = 13)
	public double getM2() {
		return m2;
	}

	public void setM2(double m2) {
		this.m2 = m2;
	}

	@ManyToOne
	@ExcelField(title = "辅材费", align = 2, sort = 14)
	public double getM3() {
		return m3;
	}

	public void setM3(double m3) {
		this.m3 = m3;
	}

	@ManyToOne
	@ExcelField(title = "延保费", align = 2, sort = 15)
	public double getM4() {
		return m4;
	}

	public void setM4(double m4) {
		this.m4 = m4;
	}

	@ManyToOne
	@ExcelField(title = "交款总额", align = 2, sort = 16)
	public double getM5() {
		return m5;
	}

	public void setM5(double m5) {
		this.m5 = m5;
	}

	@ManyToOne
	@ExcelField(title = "回访总额", align = 2, sort = 17)
	public double getM6() {
		return m6;
	}

	public void setM6(double m6) {
		this.m6 = m6;
	}

	@ManyToOne
	@ExcelField(title = "实收总额", align = 2, sort = 18)
	public double getM7() {
		return m7;
	}

	public void setM7(double m7) {
		this.m7 = m7;
	}

	@ManyToOne
	@ExcelField(title = "厂家结算", align = 2, sort = 19)
	public double getM8() {
		return m8;
	}

	public void setM8(double m8) {
		this.m8 = m8;
	}

	@ManyToOne
	@ExcelField(title = "结算支出", align = 2, sort = 20)
	public double getM9() {
		return m9;
	}

	public void setM9(double m9) {
		this.m9 = m9;
	}

	@ManyToOne
	@ExcelField(title = "当日支付", align = 2, sort = 21)
	public double getM10() {
		return m10;
	}

	public void setM10(double m10) {
		this.m10 = m10;
	}

	@ManyToOne
	@ExcelField(title = "辅材成本", align = 2, sort = 22)
	public double getM11() {
		return m11;
	}

	public void setM11(double m11) {
		this.m11 = m11;
	}

	@ManyToOne
	@ExcelField(title = "利润", align = 2, sort = 23)
	public double getM12() {
		return m12;
	}

	public void setM12(double m12) {
		this.m12 = m12;
	}

}
