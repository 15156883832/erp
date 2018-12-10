package com.jojowonet.modules.fmss.utils;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;

public class DataUtils {
	
	
	public static Map<String, Object> records2Map(List<Record> list, String key){
		Map<String, Object> map = Maps.newHashMap();
		for(Record rd : list){
			String keyVal = String.valueOf(rd.get(key));
			map.put(keyVal, 1);
		}
		return map;
	}

	/**
	 * 将字符串转成Map,如：“1,2,3” 转成{1=1,2=1,3=1}默认的value都是1	
	 * @param str
	 * @param separator
	 * @return
	 */
	public static Map<String, String> str2Map(String str, String separator){
		Map<String, String> map = Maps.newHashMap();
		if(StringUtils.isBlank(str)){
			return map;
		}
		String[] strArr = str.split(separator);
		for(String s : strArr){
			if(StringUtils.isNotBlank(s)){
				map.put(s, "1");
			}
		}
		return map;
	}
	
	/**
	 * 如：srcMap = {1=1,2=1,3=1}, comparableMap = {1=1,12=1, 13=1}
	 * @param srcMap 需要操作的map
	 * @param comparableMap 作比较的map
	 * @return	去除过不在comparableMap中的元素，如返回{1=1}
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map mapNotInMap(Map srcMap, Map comparableMap){
		Map tmpMap = new HashMap();
		tmpMap.putAll(srcMap);
		if(comparableMap == null || comparableMap.isEmpty()){
			return new HashMap();
		}
		Iterator it = tmpMap.keySet().iterator();
		while(it.hasNext()){
			Object key = it.next();
			if(!comparableMap.containsKey(key)){
				srcMap.remove(key);
			}
		}
		return srcMap;
	}
	
	/**
	 * <p>
	 * 如果pattern为空，则输出默认的yyyy-MM-dd HH:mm:ss
	 * </p>
	 * <p>
	 * 如果date为空，则取当前时间
	 * </p>
	 * @param pattern
	 * @param date
	 * @return
	 */
	public static String date2String(String pattern, Date date){
		
		if(date == null){
			date = new Date();
		}
		String ret = "";
		if(pattern == null){
			pattern = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		try{
			ret = sdf.format(date);
		}catch (Exception e) {
			//e.printStackTrace();
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		}
		ret = sdf.format(date);
		return ret;
	}
	
	public static String wlCodetoCN(String code){
		/**
		 * {"com":"顺丰","no":"sf"},
		 * {"com":"申通","no":"sto"},
		 * {"com":"圆通","no":"yt"},
		 * {"com":"韵达","no":"yd"},
		 * {"com":"天天","no":"tt"},
		 * {"com":"EMS","no":"ems"},
		 * {"com":"中通","no":"zto"},
		 * {"com":"汇通","no":"ht"},
		 * {"com":"全峰","no":"qf"}
		 */
		if("sf".equalsIgnoreCase(code)){
			return "顺丰快递";
		}else if("sto".equalsIgnoreCase(code)){
			return "申通快递";
		}else if("yt".equalsIgnoreCase(code)){
			return "圆通快递";
		}else if("yd".equalsIgnoreCase(code)){
			return "韵达快递";
		}else if("tt".equalsIgnoreCase(code)){
			return "天天快递";
		}else if("ems".equalsIgnoreCase(code)){
			return "EMS快递";
		}else if("zto".equalsIgnoreCase(code)){
			return "中通快递";
		}else if("ht".equalsIgnoreCase(code)){
			return "汇通快递";
		}else if("qf".equalsIgnoreCase(code)){
			return "全峰快递";
		}
		return "";
	}
	
	public static Double doubleIfNull(Double val, Double defaultVal){
		if(val == null){
			return defaultVal.doubleValue();
		}else{
			return val.doubleValue();
		}
	}
	
	public static int doubleToPercent(Double val){
		BigDecimal bd = new BigDecimal(val*100.0);
		return bd.setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
	}
	
	public static int doubleInScale(Double val, int scale){
		BigDecimal bd = new BigDecimal(val);
		return bd.setScale(scale, BigDecimal.ROUND_HALF_UP).intValue();
	}
	
	public static void main(String[] args) {
	}
}
