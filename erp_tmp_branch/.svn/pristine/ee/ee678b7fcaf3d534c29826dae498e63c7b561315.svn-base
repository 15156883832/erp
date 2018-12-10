package com.jojowonet.modules.order.utils;

import org.springframework.util.StringUtils;

import java.net.URLDecoder;
import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Pattern;

/**
 * 字符串处理工具类
 * @author xsg
 *
 */
public class StringUtil extends org.apache.commons.lang3.StringUtils{
	
	public static final Pattern PHONE_MASK = Pattern.compile("^(\\d{3})\\d{4}");
	public static final Pattern PATT_MOBILE = Pattern.compile("^1\\d{10}$");
	
	/**
	 *  根据分隔符分割字符串，去除空
	 *  需要分割的字符为特殊"|", "*", "+" 如不是特殊字符不能用此方法
	 * @param str  需要分割的字符串
	 * @param Separator 分割符
	 * @return 分割后的集合
	 */
	public static ArrayList<String> splitStr(String str , String Separator){
		ArrayList<String> strList = new ArrayList<String>();
		if(StringUtils.hasText(str)){
			String[] s = str.split("\\\\"+Separator);
			for(String st :s){
				if(StringUtils.hasText(st)){
					strList.add(st);
				}
			}
		}
		return strList;
	}
	
	public static String xiaoshuToBaifenbi(Double d) {
		String result = "";
		if(d != null)
		{
			result = d*100+"%";
		}
		return result;
	}
	
	public static String maskPhone(String phone) {
		if (ivan.common.utils.StringUtils.isBlank(phone)) {
			return phone;
		}
		if (phone.length() <= 4) {
			return phone;
		}
		return PHONE_MASK.matcher(phone).replaceFirst("$1****");
	}
	
	public static String converList2StringUseSymbol(List<String> strs, String symbol)
	{
		String result = "";
		if(strs != null && symbol != null)
		{
			for(String str : strs)
			{
				if(result.isEmpty())
					result += str;
				else
					result += symbol + str;
			}
		}
		return result;
	}
	
	public static String decodeChinese(String china)
	{
		String result = "";
		if(china != null && !china.isEmpty())
		{
			try
			{
				result = new String(china.getBytes("iso-8859-1"),"utf-8");
				result = URLDecoder.decode(result, "UTF-8");//.decode(result, "UTF-8");
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public static String getSuffix(String name) {
		int i =  name.lastIndexOf(".");
		String suffix = name.substring(i, name.length());
		return suffix;
	}
	
	public static String getName(String name) {
		int i =  name.lastIndexOf(".");
		name = name.substring(0, i);
		return name;
	}
	
	public static List<String> splitByRegex(String str, String regex)
	{
		List<String> lists = new ArrayList<String>();
		if(str != null && !str.isEmpty() && regex != null && !regex.isEmpty())
		{
			try
			{
				String[] array = str.split(regex);
				for(String a : array)
				{
					if(!a.isEmpty())
						lists.add(a);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return lists;
	}
	
	/**
	 * 判断保修的声音是来自app还是微信
	 * @param url 声音url
	 * @return app 来自app wx 来自微信
	 */
	public static String checkVoiceFrom(String url) {
		final String appFlag = "userfiles";
		if(ivan.common.utils.StringUtils.isNotBlank(url)){
			if(url.contains(appFlag)){
				return "app";
			} else {
				return "wx";
			}
		}
		
		return "";
	}
	
	/**
	 * 隐藏号码中间四位
	 * @param mobile
	 * @return
	 */
	public static String hideMobile(String mobile) {
		if (ivan.common.utils.StringUtils.isBlank(mobile)) {
			return mobile;
		}
		if (mobile.length() < 11) {
			return mobile;
		}
		String a = mobile.substring(0, 3);
		String b = mobile.substring(7, 11);
		StringBuffer sf = new StringBuffer();
		sf.append(a);
		sf.append("****");
		sf.append(b);
		return sf.toString();
	}

	public static String join(String[] els) {
        if (els == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (String el : els) {
            sb.append(el);
            sb.append(",");
        }
        String ret = sb.toString();
        if (ret.endsWith(",")) {
            ret = ret.substring(0, ret.length() - 1);
        }
        return ret;
    }
	
	public static String joinInSql(String[] els) {
        if (els == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (String el : els) {
        	if(StringUtil.isNotBlank(el)) {
        		sb.append("'").append(el).append("'");
        		sb.append(",");
        	}
        }
        String ret = sb.toString();
        if (ret.endsWith(",")) {
            ret = ret.substring(0, ret.length() - 1);
        }
        return ret;
    }

	public static String joinInSqlforllist(List<String> list) {
//		if (list == null) {
//			return "";
//		}
//		StringBuilder sb = new StringBuilder();
//		for (String el : list) {
//			sb.append("'").append(el).append("'");
//			sb.append(",");
//		}
//		String ret = sb.toString();
//		if (ret.endsWith(",")) {
//			ret = ret.substring(0, ret.length() - 1);
//		}
//		return ret;
		return CrmUtils.joinInSql(list);
	}

    public static String joinInSqlforselforder(String[] xiaoNames){
		if (xiaoNames == null) {
			return "";
		}
		StringBuilder stringBuilder = new StringBuilder();
		for(String el : xiaoNames){
			stringBuilder.append(" '%"+el+"%' ");
			stringBuilder.append("or a.placing_name like");
		}
		String ret = stringBuilder.toString();
		if (ret.endsWith("or a.placing_name like")) {
			ret = ret.substring(0, ret.length() - 22);
		}
		return ret;
	}
	
	
	//取出制表符，换行和回车
	public static String removeRTN(String str){
	    return str.replaceAll("[\\t\\n\\r]", "");
	}
	
	public static Object wrapSqlParams(Object obj){
		if(obj instanceof String){
			if(isNotBlank(String.valueOf(obj))){
				return "'"+String.valueOf(obj) + "'";
			}
		}else if(obj instanceof Integer){
			return "'"+obj + "'";
		}else if(obj instanceof Long){
			return "'"+obj + "'";
		}
		return "NULL";
	}
	
	public static boolean checkParamsValid(Object obj){
		if(obj != null && isNotBlank(String.valueOf(obj))){
			return true;
		}
		return false;
	}
	
	public static boolean strInCollection(String str, Collection<?> col){
		if(StringUtils.isEmpty(str) || col == null){
			return false;
		}
		Iterator<?> itr = col.iterator();
		boolean result = false;
		while(itr.hasNext()){
			Object obj = itr.next();
			if(str.equalsIgnoreCase(String.valueOf(obj))){
				result = true;
				break;
			}
		}
		return result;
	}
	
	public static boolean strInStrs(String str, String colStr, String splitor){
		if(StringUtils.isEmpty(str) || colStr == null){
			return false;
		}
		String[] strArr = colStr.split(splitor);
		for(String st : strArr){
			if(str.equalsIgnoreCase(st)){
				return true;
			}
		}
		return false;
	}
	
	public static String getFileExtName(String fileName){
		if(isNotBlank(fileName)){
			int idx = fileName.lastIndexOf(".");
			if(idx != -1){
				return fileName.substring(idx+1, fileName.length());
			}
		}
		return "";
	}
	
	public static String mapKey2Str(Map<?, ?> map){
		if(map == null || map.isEmpty()){
			return "";
		}
		StringBuilder sb = new StringBuilder("");
		for(Entry<?, ?> ent : map.entrySet()){
			sb.append(",").append(ent.getKey());
		}
		return sb.toString().substring(1);
	}

	public static String uniqueJoin(String sep, String... paras) {
		List<String> list = uniqueList(sep, paras);
		return join(list, sep);
	}

	public static List<String> uniqueList(String sep, String... paras) {
		List<String> list = new ArrayList<>();
		String joined = join(paras, sep);
		if (joined != null) {
			String[] tmp = joined.split(sep);
			for (String s : tmp) {
				if (isNotBlank(s) && !list.contains(s)) {
					list.add(s);
				}
			}
		}
		return list;
	}

	public static boolean equalsAny(String val, String... str) {
		if (str.length == 0) {
			return true;
		}
		if (val == null) {
			throw new IllegalArgumentException("invalid param val");
		}
		for (String s : str) {
			if (val.equals(s)) {
				return true;
			}
		}
		return false;
	}

	public static List<String> tolist(String str){
		List<String> strList = null;
		if(isNotBlank(str)){
			String[] strArray = str.split(",");
			if(strArray!=null && strArray.length>0){
				strList = Arrays.asList(strArray);
			}
		}
		return strList;
	}

	public static String objectAsString(Object obj) {
		if (obj == null) {
			return null;
		}
		return obj.toString();
	}

	public static boolean isMobile(Object val) {
		if(val == null || !(val instanceof String)) {
			return false;
		}

		String mobile = (String) val;
		return StringUtil.isNotBlank(mobile) && mobile.startsWith("1") && mobile.length() == 11;
	}

}
