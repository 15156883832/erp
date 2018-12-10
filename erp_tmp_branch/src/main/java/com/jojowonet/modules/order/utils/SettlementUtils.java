package com.jojowonet.modules.order.utils;

import java.util.Map;

import com.google.common.collect.Maps;

public class SettlementUtils {

	public static final Map<String, String> settlementTemplate = Maps.newHashMap();
	static {
		settlementTemplate.put("1", "服务费:%s;辅材费:%s;延保费:%s;其他费:%s");
	}
	
	public static String parseSettlementTemplate(String templateId, Object... objs){
		if(settlementTemplate.containsKey(templateId)){
			return String.format(settlementTemplate.get(templateId), objs);
		}
		return "";
	}
}
