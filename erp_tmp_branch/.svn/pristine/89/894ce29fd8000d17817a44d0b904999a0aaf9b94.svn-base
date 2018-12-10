package com.jojowonet.modules.finance.form;

import ivan.common.utils.excel.annotation.ExcelField;
import ivan.common.utils.excel.fieldtype.RoleListType;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;



public class OrderExcel{
	
	private String name;
	private Long yjs;
	private Long wjs;
	private BigDecimal tatol;
	private List<Record> roleList = Lists.newArrayList(); 
	
	@ManyToOne
	@ExcelField(title="工程师姓名", align=2, sort=10)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@ManyToOne
	@ExcelField(title="已结算工单数", align=2, sort=20)
	public Long getYjs() {
		return yjs;
	}
	public void setYjs(Long yjs) {
		this.yjs = yjs;
	}
	@ManyToOne
	@ExcelField(title="未结算工单数", align=2, sort=30)
	public Long getWjs() {
		return wjs;
	}
	public void setWjs(Long wjs) {
		this.wjs = wjs;
	}
	@ManyToOne
	@ExcelField(title="结算金额（元）", align=2, sort=40)
	public BigDecimal getTatol() {
		return tatol;
	}
	public void setTatol(BigDecimal tatol) {
		this.tatol = tatol;
	}

}
