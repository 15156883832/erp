package com.jojowonet.modules.finance.form;

import javax.persistence.ManyToOne;

import ivan.common.utils.excel.annotation.ExcelField;

public class OrderJSEmpCount {
	private String enpName;
	private Integer m1;
	private Integer m2;
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
	private double m13;

	@ManyToOne
	@ExcelField(title = "服务工程师", align = 2, sort = 10)
	public String getEnpName() {
		return enpName;
	}

	public void setEnpName(String enpName) {
		this.enpName = enpName;
	}

	@ManyToOne
	@ExcelField(title = "已完工", align = 2, sort = 11)
	public Integer getM1() {
		return m1;
	}

	public void setM1(Integer m1) {
		this.m1 = m1;
	}

	@ManyToOne
	@ExcelField(title = "已结算", align = 2, sort = 12)
	public Integer getM2() {
		return m2;
	}

	public void setM2(Integer m2) {
		this.m2 = m2;
	}

	@ManyToOne
	@ExcelField(title = "交款总额", align = 2, sort = 13)
	public double getM3() {
		return m3;
	}

	public void setM3(double m3) {
		this.m3 = m3;
	}

	@ManyToOne
	@ExcelField(title = "实收总额", align = 2, sort = 14)
	public double getM4() {
		return m4;
	}

	public void setM4(double m4) {
		this.m4 = m4;
	}

	@ManyToOne
	@ExcelField(title = "未交款总额(已结算)", align = 2, sort = 15)
	public double getM5() {
		return m5;
	}

	public void setM5(double m5) {
		this.m5 = m5;
	}

	@ManyToOne
	@ExcelField(title = "结算金额", align = 2, sort = 16)
	public double getM6() {
		return m6;
	}

	public void setM6(double m6) {
		this.m6 = m6;
	}

	@ManyToOne
	@ExcelField(title = "当日支付", align = 2, sort = 17)
	public double getM7() {
		return m7;
	}

	public void setM7(double m7) {
		this.m7 = m7;
	}

	@ManyToOne
	@ExcelField(title = "应发金额", align = 2, sort = 18)
	public double getM8() {
		return m8;
	}

	public void setM8(double m8) {
		this.m8 = m8;
	}

	@ManyToOne
	@ExcelField(title = "未结算", align = 2, sort = 19)
	public double getM9() {
		return m9;
	}

	public void setM9(double m9) {
		this.m9 = m9;
	}

	@ManyToOne
	@ExcelField(title = "交款总额", align = 2, sort = 20)
	public double getM10() {
		return m10;
	}

	public void setM10(double m10) {
		this.m10 = m10;
	}

	@ManyToOne
	@ExcelField(title = "未交款总额(未结算)", align = 2, sort = 21)
	public double getM11() {
		return m11;
	}

	public void setM11(double m11) {
		this.m11 = m11;
	}

	@ManyToOne
	@ExcelField(title = "无效工单", align = 2, sort = 22)
	public double getM12() {
		return m12;
	}

	public void setM12(double m12) {
		this.m12 = m12;
	}

	@ManyToOne
	@ExcelField(title = "不满意工单", align = 2, sort = 23)
	public double getM13() {
		return m13;
	}

	public void setM13(double m13) {
		this.m13 = m13;
	}

}
