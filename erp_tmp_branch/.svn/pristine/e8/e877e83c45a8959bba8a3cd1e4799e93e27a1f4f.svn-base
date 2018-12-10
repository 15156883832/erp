package com.jojowonet.modules.unipay.core;

import com.alipay.demo.trade.model.TradeStatus;

public class TradeStatusTranslator {
    public static PushOrderStatus translateAlipayPushOrderStatus(TradeStatus status) {
        PushOrderStatus retStatus;
        switch (status) {
            case SUCCESS:
                retStatus = PushOrderStatus.SUCCESS;
                break;
            case FAILED:
                retStatus = PushOrderStatus.FAILED;
                break;
            default:
                retStatus = PushOrderStatus.UNKNOWN;
                break;
        }
        return retStatus;
    }

    public static com.jojowonet.modules.unipay.core.TradeStatus translateAlipayTradeStatus(TradeStatus status) {
        com.jojowonet.modules.unipay.core.TradeStatus retStatus;
        switch (status) {
            case SUCCESS:
                retStatus = com.jojowonet.modules.unipay.core.TradeStatus.SUCCESS;
                break;
            case FAILED:
                retStatus = com.jojowonet.modules.unipay.core.TradeStatus.PAYERROR;
                break;
            default:
                retStatus = com.jojowonet.modules.unipay.core.TradeStatus.UNKNOWN;
                break;
        }
        return retStatus;
    }

    public static com.jojowonet.modules.unipay.core.TradeStatus translateWxTradeStatus(String status) {
        com.jojowonet.modules.unipay.core.TradeStatus retStatus = com.jojowonet.modules.unipay.core.TradeStatus.UNKNOWN;
        if ("SUCCESS".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.SUCCESS;
        } else if ("REFUND".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.REFUND;
        } else if ("NOTPAY".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.WAIT_BUYER_PAY;
        } else if ("CLOSED".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.CLOSED;
        } else if ("REVOKED".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.REVOKED;
        } else if ("USERPAYING".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.USERPAYING;
        } else if ("PAYERROR".equals(status)) {
            retStatus = com.jojowonet.modules.unipay.core.TradeStatus.PAYERROR;
        }
        return retStatus;
    }
}
