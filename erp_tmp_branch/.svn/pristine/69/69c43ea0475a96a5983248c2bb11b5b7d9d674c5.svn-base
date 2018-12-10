package com.jojowonet.modules.fitting.form;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import ivan.common.utils.excel.annotation.ExcelField;

public class EmpFittingExport {
	// 主要用于导出
	private String empName;
	private String code;
	private String name;
	private String version;
	private String warning;
	private String employeNumber;

	private String unit;
	private String type;
	private String brand;

	private String category;
	private BigDecimal sitePrice;
	private BigDecimal customerPrice;

	@Length(min = 1, max = 50)
	@ExcelField(title = "工程师", align = 2, sort = 0)
	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "备件条码", align = 2, sort = 1)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "备件名称", align = 2, sort = 3)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "备件型号", align = 2, sort = 4)
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "库存量", align = 2, sort = 5)
	public String getWarning() {
		return warning;
	}

	public void setWarning(String warning) {
		this.warning = warning;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "待核销数", align = 2, sort = 6)
	public String getEmployeNumber() {
		return employeNumber;
	}

	public void setEmployeNumber(String employeNumber) {
		this.employeNumber = employeNumber;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "计量单位", align = 2, sort = 7)
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "备件类型", align = 2, sort = 8)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "备件品牌", align = 2, sort = 9)
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "适用品类", align = 2, sort = 10)
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "入库单价", align = 2, sort = 11)
	public BigDecimal getSitePrice() {
		return sitePrice;
	}

	public void setSitePrice(BigDecimal sitePrice) {
		this.sitePrice = sitePrice;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "零售价格", align = 2, sort = 11)
	public BigDecimal getCustomerPrice() {
		return customerPrice;
	}

	public void setCustomerPrice(BigDecimal customerPrice) {
		this.customerPrice = customerPrice;
	}

}
