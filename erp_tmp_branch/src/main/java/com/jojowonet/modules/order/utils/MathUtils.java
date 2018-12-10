package com.jojowonet.modules.order.utils;

import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;

public class MathUtils {

    /**
     * 获取Object 转换后的
     *
     * @param val
     * @return
     */
    public static Double getDouble(Object val) {
        if (val != null && StringUtils.isNumeric(String.valueOf(val))) {
            try {
                return Double.valueOf(String.valueOf(val));
            } catch (Exception e) {
                return 0d;
            }
        }
        return 0d;
    }

    /**
     * @param val   原始数值
     * @param scale 保留的小数点
     * @return 保留小数点后几位，小数点后几位是四舍五入
     */
    public static Double getDouble(Double val, int scale) {
        BigDecimal b = new BigDecimal(val);
        return b.setScale(scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static Double getDouble(BigDecimal val, int scale) {
        return val == null ? 0d : val.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static double sum(BigDecimal... values) {
        BigDecimal sum = sumBigDecimal(values);
        return sum.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static BigDecimal sumBigDecimal(BigDecimal... values) {
        BigDecimal s = new BigDecimal("0");
        for (BigDecimal v : values) {
            if (v != null) {
                s = s.add(v);
            }
        }
        return s;
    }

    public static BigDecimal asBigDecimal(String val) {
        val = StringUtils.defaultIfEmpty(val, "").trim();
        if (StringUtil.isBlank(val)) {
            return new BigDecimal("0");
        }
        return new BigDecimal(val);
    }

    /**
     * 保留两位小数点，小数点后面的四舍五入
     */
    public static Double getNormalDouble(Object val) {
        try {
            Double dv = Double.valueOf(String.valueOf(val));
            BigDecimal b = new BigDecimal(dv);
            return b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        } catch (Exception e) {
            return 0d;
        }
    }

    public static Double convertToDouble(Object val) {
        Double dv = Double.valueOf(String.valueOf(val));
        BigDecimal b = new BigDecimal(dv);
        return b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

}
