package com.jojowonet.modules.statistics.form;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;

public class HighMapsProvince {
	public static final Map<String, String> provinceMap = Maps.newHashMap();
	
	static {
		provinceMap.put("北京", "110000");
		provinceMap.put("天津", "120000");
		provinceMap.put("河北", "130000");
		provinceMap.put("山西", "140000");
		provinceMap.put("内蒙古", "150000");
		provinceMap.put("辽宁", "210000");
		provinceMap.put("吉林", "220000");
		provinceMap.put("黑龙江", "230000");
		provinceMap.put("上海", "310000");
		provinceMap.put("江苏", "320000");
		provinceMap.put("浙江", "330000");
		provinceMap.put("安徽", "340000");
		provinceMap.put("福建", "350000");
		provinceMap.put("江西", "360000");
		provinceMap.put("山东", "370000");
		provinceMap.put("河南", "410000");
		provinceMap.put("湖北", "420000");
		provinceMap.put("湖南", "430000");
		provinceMap.put("广东", "440000");
		provinceMap.put("广西", "450000");
		provinceMap.put("海南", "460000");
		provinceMap.put("重庆", "500000");
		provinceMap.put("四川", "510000");
		provinceMap.put("贵州", "520000");
		provinceMap.put("云南", "530000");
		provinceMap.put("西藏", "540000");
		provinceMap.put("陕西", "610000");
		provinceMap.put("甘肃", "620000");
		provinceMap.put("青海", "630000");
		provinceMap.put("宁夏", "640000");
		provinceMap.put("新疆", "650000");
		provinceMap.put("台湾", "710000");
		provinceMap.put("香港", "810000");
		provinceMap.put("澳门", "820000");
		provinceMap.put("南海诸岛", "710000");
	}

	public static String  parseProvince(String province){
		String ret = ""; 
		if(StringUtils.isBlank(province)){
			return ret;
		}
		for(Map.Entry<String, String> ent : provinceMap.entrySet()){
			String key = ent.getKey();
			if(province.indexOf(key) != -1){
				ret = key;
				break;
			}
		}
		return ret;
	}
}
