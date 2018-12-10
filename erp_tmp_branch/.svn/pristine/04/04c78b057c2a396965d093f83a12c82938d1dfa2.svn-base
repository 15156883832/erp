/**
 * 码道
 */
package com.jojowonet.modules.fmss.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

/**
 * 概要：
 * @author xsg
 * @version 1.0.0 2014-4-30
 */
public class TimeUtil {

	public static final String DATE_PARSE_TYPE_DAY_TIME_SECOND_STR = "yyyy-MM-dd HH:mm";
	
	/**
	 * 计算距离现在小时数
	 * @param time
	 * @return
	 */
	public static float  betweenHours(long time){
		Date date = new Date();
		long now = date.getTime();
		long between = now-time;
		float times = between/60/60/1000;
		return times;
	}
	
	/**
     * 字符串转Date,精确到日
     * @param dateStr
     * @return
     */
    public static Date strToDate(String dateStr) {    	
    	
    	if(StringUtils.isEmpty(dateStr)) {
    		return null;
    	}

    	SimpleDateFormat sdf = new SimpleDateFormat(DATE_PARSE_TYPE_DAY_TIME_SECOND_STR);
    	Date date = null;
		try {
			date = (Date) sdf.parseObject(dateStr);
		} catch (ParseException e) {
			return null;
		}
    	return date;
    }
    
	
	/**
     * Date转字符串
     * @param date
     * @return
     */
    public static String dateToStr(Date date, String format) {
    	if(date == null) {
    		return null;
    	}
    	
    	String dateStr = null;
    	
    	SimpleDateFormat sdf = new SimpleDateFormat(format);
    	dateStr = sdf.format(date);
    	
    	return dateStr;
    }
    
    /**
     * 当前时间延后
     * @param date
     * @param hours
     * @return
     */
    public static Date delayed(Date date, int hours){
		long endTime = date.getTime() + hours*60*60*1000L;
		Date endTimes = new Date(endTime);
    	return endTimes;
    }
    
    /**
     * 获得三个月后日期
     * @param months
     * @return
     */
    public static Date beforeMonths(int months){
    	Calendar calendar = Calendar.getInstance();
	    calendar.add(Calendar.MONTH, -months);
	    Date formNow3Month = calendar.getTime();
    	return formNow3Month;
    }
    
}
