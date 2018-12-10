package com.jojowonet.modules.unipay;

import com.jojowonet.modules.unipay.alipay.AlipayNotifyHandler;
import com.jojowonet.modules.unipay.core.NotifyHandler;
import com.jojowonet.modules.unipay.weixin.WxNotifyHandler;

/**
 * @author gaols
 */
public class NotifyHandlerFactory {

    public static NotifyHandler getNotifyHandler(PayType type) {
        switch (type) {
            case wx:
                return new WxNotifyHandler();
            case alipay:
                return new AlipayNotifyHandler();
        }

        throw new RuntimeException("unsupported pay type: " + type);
    }

    public static NotifyHandler getNotifyHandler(String type) {
        if ("wx".equals(type)) {
            return new WxNotifyHandler();
        } else if ("alipay".equals(type)) {
            return new AlipayNotifyHandler();
        }

        throw new RuntimeException("unsupported pay type: " + type);
    }
}
