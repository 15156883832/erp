package com.jojowonet.modules.order.utils;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;

public class ProcessFormatter {

	public static final String JIESUAN_FMT = "%s#@%s结算工单";
	public static final String JIESUAN_TAG = "js";
	public static final Map<String, String> processFormatterMap = Maps.newHashMap();
	static {
		processFormatterMap.put(JIESUAN_TAG, JIESUAN_FMT);
	}
	
	public static String getProcess(String tag, Object... strs){
		if(processFormatterMap.containsKey(tag)){
			return String.format(processFormatterMap.get(tag), strs);
		}
		return "";
	}
	
	public static String getLatestProcess(String tag, Object... strs){
		String proStr = getProcess(tag, strs);
		if(StringUtils.isNotBlank(proStr) && proStr.indexOf("#@") != -1){
			return proStr.split("#@")[1];
		}
		return proStr;
	}
	
	public static String appendProcess(String origin, String content){
		if(StringUtils.isNotBlank(origin)){//已经存在值，直接追加即可
			return origin.concat("@#@").concat(content);
		}
		return content;
	}
}
