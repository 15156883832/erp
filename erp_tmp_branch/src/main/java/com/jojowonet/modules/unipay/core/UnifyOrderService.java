package com.jojowonet.modules.unipay.core;

/**
 * @author gaols
 */
public interface UnifyOrderService {
    /**
     * 统一下单接口。
     *
     * @param order   订单信息
     * @param context The servlet context for this order.
     * @return 下单结果
     */
    PushOrderResult unifyOrder(OrderContext context, Order order);

    /**
     * 查询订单支付状态。
     *
     * @param outTradeNo 订单编号
     * @return 订单支付状态。
     */
    TradeStatus queryOrderStatus(String outTradeNo);

    /**
     * 取消订单。
     *
     * @param outTradeNo 订单编号
     */
    void cancelOrder(String outTradeNo);
}
