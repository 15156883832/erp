package com.jojowonet.modules.unipay;

import com.jojowonet.modules.unipay.alipay.AlipayUnifyOrderService;
import com.jojowonet.modules.unipay.core.UnifyOrderService;
import com.jojowonet.modules.unipay.weixin.WxUnifyOrderService;

/**
 * @author gaols
 */
public class UniPayOrderServiceFactory {

    public static UnifyOrderService getUnipayOrderService(PayType type) {
        switch (type) {
            case wx:
                return WxUnifyOrderService.create();
            case alipay:
                return AlipayUnifyOrderService.create();
        }

        throw new IllegalArgumentException("Unknown pay type:" + type);
    }

    public static UnifyOrderService getUnipayOrderService(String type) {
        if (Constants.PAY_TYPE_WX.equals(type)) {
            return getUnipayOrderService(PayType.wx);
        } else if (Constants.PAY_TYPE_ALIPAY.equals(type)) {
            return getUnipayOrderService(PayType.alipay);
        }

        throw new IllegalArgumentException("Unknown pay type:" + type);
    }
}
