package com.jojowonet.modules.unipay.utils;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;

/**
 * @author gaols
 */
public class IpUtils {

    private static Logger logger = Logger.getLogger(IpUtils.class);

    public static String getRealIp(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        logger.info(String.format("x-forwarded-for ip: %s", ip));
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
            logger.info(String.format("Proxy-Client-IP ip: %s", ip));
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
            logger.info(String.format("WL-Proxy-Client-IP ip: %s", ip));
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            logger.info(String.format("remote address ip: %s", ip));
        }
        if (ip.contains(",")) {
            String[] ips = ip.split(",");
            ip = ips[0];
        }
        return ip;
    }

    public static String getRealIpV2(HttpServletRequest request) {
        String accessIP = request.getHeader("x-forwarded-for");
        if (accessIP == null) {
            accessIP = request.getRemoteAddr();
        }
        return accessIP;
    }
}
