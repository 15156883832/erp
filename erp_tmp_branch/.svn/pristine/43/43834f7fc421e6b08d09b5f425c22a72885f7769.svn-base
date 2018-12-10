package com.jojowonet.modules.fmss.utils;

import java.util.List;

import com.google.common.collect.Lists;

public class DbBatchBean {

	private List<DbBatchItem> dbis;
	
	public DbBatchBean() {
		super();
		if(dbis == null){
			dbis = Lists.newArrayList();
		}
	}

	public List<DbBatchItem> getDbis() {
		return dbis;
	}

	public void setDbis(List<DbBatchItem> dbis) {
		this.dbis = dbis;
	}

	public void appendDBI(DbBatchItem dbi){
		this.dbis.add(dbi);
	}
}
