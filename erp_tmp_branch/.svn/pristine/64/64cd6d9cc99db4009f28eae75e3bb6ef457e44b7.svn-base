package com.jojowonet.modules.sys.util;

import org.apache.commons.lang.StringUtils;

public class GuardUtils {

    public static void notBlank(String val, String msg) {
        if (StringUtils.isBlank(val)) {
            throw new IllegalArgumentException(msg);
        }
    }

    public static void notNull(Object val, String msg) {
        if (val == null) {
            throw new IllegalArgumentException(msg);
        }
    }

    public static void in(String[] validValues, String val, String msg) {
        for (String v : validValues) {
            if (val.equals(v)) {
                return;
            }
        }

        throw new IllegalArgumentException(msg);
    }

    public static void in(int[] validValues, int val, String msg) {
        for (int v : validValues) {
            if (val == v) {
                return;
            }
        }

        throw new IllegalArgumentException(msg);
    }

    public static void in(long[] validValues, long val, String msg) {
        for (long v : validValues) {
            if (val == v) {
                return;
            }
        }

        throw new IllegalArgumentException(msg);
    }
}
