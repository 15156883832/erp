package com.jojowonet.modules.fitting.utils;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class SiteListUtils {
	
	public static List<Record> getSiteList(){
		String sql="select * from crm_site where status='0' ";
		return Db.find(sql);
	}
}
