package com.jojowonet.modules.unipay.core;

/**
 * 默认实现是抛出异常，以提示API使用者使用正确的实现。
 */
public class DefaultUnifyOrderService implements UnifyOrderService {

    private final String payType;

    @Override
    public PushOrderResult unifyOrder(OrderContext context, Order order) {
        throw new IllegalStateException("unknown pay type:" + this.payType);
    }

    @Override
    public TradeStatus queryOrderStatus(String outTradeNo) {
        throw new IllegalStateException("unknown out trade no");
    }

    @Override
    public void cancelOrder(String outTradeNo) {
        throw new IllegalStateException("unknown out trade no");
    }

    public DefaultUnifyOrderService(String payType) {
        this.payType = payType;
    }
}
