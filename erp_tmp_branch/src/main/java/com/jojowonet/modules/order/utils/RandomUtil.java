package com.jojowonet.modules.order.utils;

import org.apache.commons.lang3.RandomStringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class RandomUtil {

    public static String getPositiveRandomWithRang(int max, int min) {
        String r = "1234";
        if (max > 0 && min > 0 && max >= min) {
            Random random = new Random();
            int s = random.nextInt(max) % (max - min + 1) + min;
            r = String.valueOf(s);
        }
        return r;
    }

    public static String getPositiveRandomWithRang(int count) {
        StringBuffer sb = new StringBuffer();
        String str = "0123456789";
        Random r = new Random();
        for (int i = 0; i < count; i++) {
            int num = r.nextInt(str.length());
            sb.append(str.charAt(num));
            str = str.replace((str.charAt(num) + ""), "");
        }
        return sb.toString();
    }

    /**
     * 获取一定范围内的值
     *
     * @param start 起始值
     * @param end   结束值
     * @return
     */
    public static int getRandomMoney(int start, int end) {
        Random rand = new Random();
        int randNum = rand.nextInt(end - 1) + start;
        return randNum;
    }

    public static String randomOrderNumber() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
        String s = RandomStringUtils.randomNumeric(5);
        return sdf.format(new Date()) + s;
    }
    
    public static String SiteGoodsProfitNumber() {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
    	String s = RandomStringUtils.randomNumeric(5);
    	return sdf.format(new Date()) + s;
    }

}