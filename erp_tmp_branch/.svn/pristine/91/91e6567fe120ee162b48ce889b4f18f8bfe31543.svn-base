package com.jojowonet.modules.operate.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DateJson {
	public static void main(String[] args) {
		getDateJsonList("2017-07-15", "2017-07-18");
	}

	public static List<String> getDateJsonList(String startTime, String endTime) {// startTime 和 endTime 都不能为空 格式："2017-07-15", "2017-07-18"
		List<String> list = new ArrayList<String>();
		if (startTime.equals(endTime)) {
			list.add(startTime);
			return list;
		}

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = null;
		Date date2 = null;
		try {
			date1 = format.parse(startTime);
			date2 = format.parse(endTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Integer days = differentDaysByMillisecond(date1, date2);// 时间相差多少天
		Long endLong = date2.getTime();
		for (int i = 0; i <= days; i++) {
			long changeDate = 1000 * 3600 * 24;
			long timeStamp = (long) (endLong - (long) (changeDate * i));
			String sd = sdf.format(new Date(timeStamp));
			list.add(sd.substring(0, 10));
		}
		return list;
	}

	public static int differentDaysByMillisecond(Date date1, Date date2) {
		int days = (int) ((date2.getTime() - date1.getTime()) / (1000 * 3600 * 24));
		return days;
	}

}
