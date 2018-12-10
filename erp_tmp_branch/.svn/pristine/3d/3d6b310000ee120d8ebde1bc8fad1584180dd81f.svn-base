/**
 * 码道
 */
package com.jojowonet.modules.fmss.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;

/**
 * 概要：email工具类
 * @author xsg
 * @version 1.0.0 2015-3-7
 */
public class EmailUtil {
	
	/**
	 * email分隔符
	 */
	private static final String SPLITER = "@";
	
	/**
	 * 获得email名
	 * @param email
	 * @return
	 */
	public static String getLocal(String email){
		if(StringUtils.hasText(email)){
			String[] emailArr = email.split(SPLITER);
			if(emailArr.length == 2){
				return emailArr[0];
			}
		}
		return null;
	}
	
	/**
	 * 获得email类型
	 * @param email
	 * @return
	 */
	public static String getDomain(String email){
		if(StringUtils.hasText(email)){
			String[] emailArr = email.split(SPLITER);
			if(emailArr.length == 2){
				return emailArr[1];
			}
		}
		return null;
	}
	
	/**
	 * 更具local和domain生成email
	 * @param local
	 * @param domain
	 * @return
	 */
	public static String getEmail(String local, String domain) {
		String target = null;
		if (StringUtils.hasText(local) && StringUtils.hasText(domain)) {
			target = local + SPLITER + domain;
		}
		return target;
	}
	
	
	/**
	 * 检查email格式是否正确
	 * @param email
	 * @return
	 */
	public static boolean isEmail(String email) {
		if(StringUtils.hasText(email)){
			Pattern pattern = Pattern
					.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
			Matcher matcher = pattern.matcher(email);
			if (matcher.matches()) {
				return true;
			}
		}
		
		return false;
	}
	
	    // 转化字符串为十六进制编码
		public static String toHexString(String s){
		String str="";
		for (int i=0;i<s.length();i++)
		{
		int ch = (int)s.charAt(i);
		String s4 = Integer.toHexString(ch);
		str = str + s4;
		}
		return str;
		}
		
		
		// 转化十六进制编码为字符串
		public static String toStringHex(String s) {
			byte[] baKeyword = new byte[s.length() / 2];
			for (int i = 0; i < baKeyword.length; i++) {
				try {
					baKeyword[i] = (byte) (0xff & Integer.parseInt(
							s.substring(i * 2, i * 2 + 2), 16));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			try {
				s = new String(baKeyword, "utf-8");// UTF-16le:Not
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			return s;
		}

}
