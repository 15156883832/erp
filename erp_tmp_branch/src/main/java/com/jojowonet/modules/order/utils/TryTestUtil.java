package com.jojowonet.modules.order.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;

import com.alibaba.druid.sql.visitor.functions.Char;


public class TryTestUtil {
	
	
	/*
	 * 获取某范围内的任意一个值， 返回String
	 * 200~100范围类的任意值 :big=200,small=100
	 */
	
	public static String getRandNumber(int big, int small){
		Random rd = new Random();
		Integer num = rd.nextInt(big - small) + small;
		return String.valueOf(num);
	}
	
	/*
	 * 提取字符串中的所有字母或数字
	 */
	public static String getAllChar(String str){
		StringBuilder sb = new StringBuilder();//字母
		StringBuilder sf = new StringBuilder();//数字
		StringBuilder sd = new StringBuilder();//提取特定的字符
		for(int i=0;i<str.length();i++){
			char c = str.charAt(i);
			if((c>='a' && c<='z') || (c>='A' && c<='Z')){
				sb.append(c);
			}
			if((c>='0' && c<='9') ){
				sf.append(c);
			}
			if(c=='n'){
				sd.append(c);
			}
		}
		return "所有字母："+sb.toString()+";所有数字:"+sf.toString()+";提取字符n:"+sd+"("+sd.length()+"个)";
	}
	
	/**
	 * 获取随机数
	 */
	public static String getRandomNums(String str){
		char[] ch = getChars(str);
		String nums = RandomStringUtils.randomAlphanumeric(5);//获取随机五个数字、字母的组合
		String nums1 = RandomStringUtils.randomNumeric(5);//获取随机五个数字组合
		String nums2 = "";
		if(ch.length>0){
			nums2 = RandomStringUtils.random(5,ch);//指定字符的随机组合
		}
		return "字母加数字组合："+nums+";数字组合"+nums1+";指定字符的随机组合:"+nums2;
	}
	
	/**
	 * 一个字符串转成char型数组
	 * @param str
	 * @return
	 */
	public static char[] getChars(String str){
		char[] ch = new char[str.length()];
		if(StringUtils.isNotBlank(str)){
			for(int i=0;i<str.length();i++){
				ch[i]=str.substring(i,i+1).charAt(0);
			}
		}
		return ch;
	}
	
	/**
	 * 编号的生成
	 */
	public static String getNumber(){
		String number = new String();
		SimpleDateFormat sDate = new SimpleDateFormat("yyMMddHHmmssSSS");
		number = sDate.format(new Date()).toString()+RandomStringUtils.random(4,getChars("0123456789"));
		return "NO"+number;
	}
	
	
	
	
	
}
