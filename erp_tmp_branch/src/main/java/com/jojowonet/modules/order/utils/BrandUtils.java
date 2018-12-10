package com.jojowonet.modules.order.utils;

import ivan.common.utils.SpringContextHolder;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.BrandDao;

public class BrandUtils {
	
	private static BrandDao brandDao = SpringContextHolder.getBean(BrandDao.class);

	
	public static Map<String, String> getBrand() {
		LinkedHashMap<String, String> brand = new LinkedHashMap<String, String>();
		try {
			String query = "SELECT id,name FROM crm_brand ORDER BY sort DESC ";
			List<Record> records = Db.find(query);
			if(records != null) {
				for(Record record : records) {
					String name = record.getStr("name");
					brand.put(name, name);
				}
			}
		}
		catch(Exception e) {}
		return brand;
	}

	public static Map<String, String> getSiteBrand(String siteId, Integer cate) {//cate为categoryId
		Map<String, String> map = new HashMap<>();
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT DISTINCT a.brand_id, b.name FROM crm_site_brand_rel a  ");
		sb.append(" INNER JOIN crm_brand b ON b.id = a.brand_id AND b.del_flag = '0' ");
		sb.append(" WHERE a.site_id = '" + siteId + "' ");
		if (cate != null) {
			sb.append(" AND a.category_id='" + cate + "' ");
		}

		List<Record> re = Db.find(sb.toString());
		if (re != null) {
			for (Record rdco : re) {
				String name = rdco.getStr("name");
				map.put(name, name);
			}
		}
		return map;
	}

	public static Integer getBrandId(String name) {
		String query = "SELECT id FROM crm_brand WHERE NAME='" + name + "' and del_flag='0' ";
		Record record = Db.findFirst(query);
		if (record != null) {
			return record.getInt("id");
		}
		return null;
	}

}