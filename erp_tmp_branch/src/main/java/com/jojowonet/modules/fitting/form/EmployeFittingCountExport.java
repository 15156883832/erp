package com.jojowonet.modules.fitting.form;

import org.hibernate.validator.constraints.Length;

import ivan.common.utils.excel.annotation.ExcelField;

public class EmployeFittingCountExport {

	private String employeName;
	private Object cateAmount;
	private Object stocks;
	private Object instoksMoney;
	private Object empStocksMoney;
	private Object waitHxNumber;
	private Object waitHxMoney;
	private Object waitHxEmpMoney;
	private Object waitReturnNumber;

	@Length(min = 1, max = 50)
	@ExcelField(title = "工程师", align = 2, sort = 0)
	public String getEmployeName() {
		return employeName;
	}

	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "种类", align = 2, sort = 1)
	public Object getCateAmount() {
		return cateAmount;
	}

	public void setCateAmount(Object cateAmount) {
		this.cateAmount = cateAmount;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "库存量", align = 2, sort = 2)
	public Object getStocks() {
		return stocks;
	}

	public void setStocks(Object stocks) {
		this.stocks = stocks;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "入库总额", align = 2, sort = 3)
	public Object getInstoksMoney() {
		return instoksMoney;
	}

	public void setInstoksMoney(Object instoksMoney) {
		this.instoksMoney = instoksMoney;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "工程师总额", align = 2, sort = 4)
	public Object getEmpStocksMoney() {
		return empStocksMoney;
	}

	public void setEmpStocksMoney(Object empStocksMoney) {
		this.empStocksMoney = empStocksMoney;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "待核销数", align = 2, sort = 5)
	public Object getWaitHxNumber() {
		return waitHxNumber;
	}

	public void setWaitHxNumber(Object waitHxNumber) {
		this.waitHxNumber = waitHxNumber;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "待核销总额", align = 2, sort = 6)
	public Object getWaitHxMoney() {
		return waitHxMoney;
	}

	public void setWaitHxMoney(Object waitHxMoney) {
		this.waitHxMoney = waitHxMoney;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "待核销工程师总额", align = 2, sort = 6)
	public Object getWaitHxEmpMoney() {
		return waitHxEmpMoney;
	}

	public void setWaitHxEmpMoney(Object waitHxEmpMoney) {
		this.waitHxEmpMoney = waitHxEmpMoney;
	}

	@Length(min = 1, max = 50)
	@ExcelField(title = "待返还数", align = 2, sort = 7)
	public Object getWaitReturnNumber() {
		return waitReturnNumber;
	}

	public void setWaitReturnNumber(Object waitReturnNumber) {
		this.waitReturnNumber = waitReturnNumber;
	}
}
