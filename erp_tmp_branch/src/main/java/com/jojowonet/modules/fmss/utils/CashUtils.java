package com.jojowonet.modules.fmss.utils;

import java.util.HashMap;
import java.util.Map;

public class CashUtils {

	private static final String UNIT = "万千佰拾亿千佰拾万千佰拾元角分";
	private static final String DIGIT = "零壹贰叁肆伍陆柒捌玖";
	private static final double MAX_VALUE = 9999999999999.99D;

	public static String cash2Upper(Double v) {
		if (v < 0 || v > MAX_VALUE) {
			return "参数非法!";
		}
		long l = Math.round(v * 100);
		if (l == 0) {
			return "零元整";
		}
		String strValue = l + "";
		// i用来控制数
		int i = 0;
		// j用来控制单位
		int j = UNIT.length() - strValue.length();
		String rs = "";
		boolean isZero = false;
		for (; i < strValue.length(); i++, j++) {
			char ch = strValue.charAt(i);
			if (ch == '0') {
				isZero = true;
				if (UNIT.charAt(j) == '亿' || UNIT.charAt(j) == '万'
						|| UNIT.charAt(j) == '元') {
					rs = rs + UNIT.charAt(j);
					isZero = false;
				}
			} else {
				if (isZero) {
					rs = rs + "零";
					isZero = false;
				}
				rs = rs + DIGIT.charAt(ch - '0') + UNIT.charAt(j);
			}
		}
		if (!rs.endsWith("分")) {
			rs = rs + "整";
		}
		rs = rs.replaceAll("亿万", "亿");
		return rs;
	}
	
	public static void main(String[] args) {
		
		String upperCash = cash2Upper(12.03);

		Map<String, String> map = new HashMap<String, String>();
		
		int qidx = upperCash.indexOf("仟");
		boolean isZero = false;
		if(qidx != -1){
			map.put("cs5", String.valueOf(upperCash.charAt(qidx-1)));
			isZero = true;
		}else{
			map.put("cs5", "_");
		}
		
		int bidx = upperCash.indexOf("佰");
		if(bidx != -1){
			map.put("cs4", String.valueOf(upperCash.charAt(bidx-1)));
			isZero = true;
		}else if(isZero){
			map.put("cs4", "零");
		}else{
			map.put("cs4", "_");
		}
		
		int sidx = upperCash.indexOf("拾");
		if(sidx != -1){
			map.put("cs3", String.valueOf(upperCash.charAt(sidx-1)));
			isZero = true;
		}else if(isZero){
			map.put("cs3", "零");
		}else{
			map.put("cs3", "_");
		}
		
		int yidx = upperCash.indexOf("元");
		if(yidx != -1){
			map.put("cs2", String.valueOf(upperCash.charAt(yidx-1)));
			isZero = true;
		}else if(isZero){
			map.put("cs2", "零");
		}else{
			map.put("cs2", "_");
		}
		
		int jidx = upperCash.indexOf("角");
		if(jidx != -1){
			map.put("cs1", String.valueOf(upperCash.charAt(jidx-1)));
			isZero = true;
		}else if(isZero){
			map.put("cs1", "零");
		}else{
			map.put("cs1", "_");
		}
		
		int fidx = upperCash.indexOf("分");
		if(fidx != -1){
			map.put("cs0", String.valueOf(upperCash.charAt(fidx-1)));
			isZero = true;
		}else if(isZero){
			map.put("cs0", "零");
		}else{
			map.put("cs0", "_");
		}
		
	}
}