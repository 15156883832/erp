package com.jojowonet.modules.unipay.alipay;

import com.alipay.api.response.AlipayTradeCancelResponse;
import com.alipay.api.response.AlipayTradePrecreateResponse;
import com.alipay.demo.trade.config.Configs;
import com.alipay.demo.trade.model.builder.AlipayTradeCancelRequestBuilder;
import com.alipay.demo.trade.model.builder.AlipayTradePrecreateRequestBuilder;
import com.alipay.demo.trade.model.builder.AlipayTradeQueryRequestBuilder;
import com.alipay.demo.trade.model.result.AlipayF2FPrecreateResult;
import com.alipay.demo.trade.model.result.AlipayF2FQueryResult;
import com.alipay.demo.trade.service.impl.AlipayTradeServiceImpl;
import com.jojowonet.modules.unipay.core.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * https://docs.open.alipay.com/api_1/alipay.trade.precreate/
 * https://docs.open.alipay.com/194/105322/ -- a must read
 *
 * @author gaols
 */
public class AlipayUnifyOrderService implements UnifyOrderService {

    private static final AlipayUnifyOrderService orderService = new AlipayUnifyOrderService();
    private static final Log logger = LogFactory.getLog(AlipayUnifyOrderService.class);
    private final AlipayTradeServiceImpl impl;

    @Override
    public PushOrderResult unifyOrder(OrderContext context, Order order) {
        logger.error("Unify order START: " + order.toString());

        AlipayUnifyOrderRequestBuilder builder = new AlipayUnifyOrderRequestBuilder(context, order);
        AlipayTradePrecreateRequestBuilder requestBuilder = builder.build();
        AlipayF2FPrecreateResult result = impl.tradePrecreate(requestBuilder);
        logUnifyOrderResult(result, order);

        PushOrderResult ret = new PushOrderResult();
        ret.setPushOrderStatus(TradeStatusTranslator.translateAlipayPushOrderStatus(result.getTradeStatus()));
        AlipayTradePrecreateResponse response = result.getResponse();
        Map<String, Object> resp = new HashMap<>();
        resp.put("qr_code_url", response.getQrCode());
        resp.put("out_trade_no", response.getOutTradeNo());
        ret.setResponse(resp);
        return ret;
    }

    private void logUnifyOrderResult(AlipayF2FPrecreateResult result, Order order) {
        com.alipay.demo.trade.model.TradeStatus tradeStatus = result.getTradeStatus();
        logger.error(String.format("Unify order[%s] DONE:status=%s", order.getOutTradeNo(), tradeStatus));
    }

    @Override
    public com.jojowonet.modules.unipay.core.TradeStatus queryOrderStatus(String outTradeNo) {
        AlipayTradeQueryRequestBuilder builder = new AlipayTradeQueryRequestBuilder().setOutTradeNo(outTradeNo);
        AlipayF2FQueryResult result = impl.queryTradeResult(builder);
        return TradeStatusTranslator.translateAlipayTradeStatus(result.getTradeStatus());
    }

    /**
     * Before cancel this order, we must ensure the order is not paid, if payed success, block it.
     * 每一笔交易一定要闭环，即要么支付成功，要么撤销交易，一定不能有交易一直停留在等待用户付款的状态。
     * 轮询+撤销的流程中，如轮询的结果一直为未付款，撤销一定要紧接着最后一次查询，当中不能有时间间隔。
     *
     * @param outTradeNo 订单编号
     */
    @Override
    public void cancelOrder(String outTradeNo) {
        AlipayTradeCancelRequestBuilder builder = new AlipayTradeCancelRequestBuilder().setOutTradeNo(outTradeNo);
        try {
            Method m = AlipayTradeServiceImpl.class.getMethod("tradeCancel", AlipayTradeCancelRequestBuilder.class);
            AlipayTradeCancelResponse resp = (AlipayTradeCancelResponse) m.invoke(impl, builder);
            logger.error(String.format("cancel order[%s] with action=%s,retry_flag=%s", outTradeNo, resp.getAction(), resp.getRetryFlag()));
        } catch (NoSuchMethodException | InvocationTargetException | IllegalAccessException e) {
            logger.error(String.format("cancel order[%s] failed", outTradeNo));
            throw new RuntimeException(e);
        }
    }

    public static UnifyOrderService create() {
        return orderService;
    }

    private AlipayUnifyOrderService() {
        Configs.init("zfb.properties");
        impl = new AlipayTradeServiceImpl.ClientBuilder().build();
    }
}
