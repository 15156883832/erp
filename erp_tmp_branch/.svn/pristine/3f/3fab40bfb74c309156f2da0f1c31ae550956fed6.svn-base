package com.jojowonet.modules.fmss.utils;

import java.util.List;

import com.google.common.collect.Lists;

public class DbBatchItem {

	private String sql;
	private List<Object[]> params;
	
	public DbBatchItem() {
		super();
		if(params == null){
			params = Lists.newArrayList();
		}
	}
	
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public List<Object[]> getParams() {
		return params;
	}
	public void setParams(List<Object[]> params) {
		this.params = params;
	}

	public void appendParams(Object[] param){
		this.params.add(param);
	}
}
