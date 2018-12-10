package com.jojowonet.modules.unipay.weixin;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

/**
 * @author gaols
 */
public class Configs {
    private static String partnerKey;
    private static String appId;
    private static String mchId;
    private static Configuration configs;
    private static String notifyUrl;

    public static String getPartnerKey() {
        return partnerKey;
    }

    public static String getAppId() {
        return appId;
    }

    public static String getMchId() {
        return mchId;
    }

    public static String getNotifyUrl() {
        return notifyUrl;
    }

    public synchronized static void init(String filePath) {
        if (configs == null) {
            try {
                configs = new PropertiesConfiguration(filePath);
            } catch (ConfigurationException var2) {
                // intentionally ignore
            }

            if (configs == null) {
                throw new IllegalStateException("can't find file by path:" + filePath);
            } else {
                appId = configs.getString("app_id");
                mchId = configs.getString("mch_id");
                partnerKey = configs.getString("partner_key");
                notifyUrl = configs.getString("notify_url");
            }
        }
    }
}
