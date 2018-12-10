package com.jojowonet.modules.unipay.weixin;

import com.jojowonet.modules.unipay.core.*;
import org.apache.log4j.Logger;
import weixin.popular.api.PayMchAPI;
import weixin.popular.bean.paymch.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author gaols
 */
public class WxUnifyOrderService implements UnifyOrderService {

    private static final WxUnifyOrderService service = new WxUnifyOrderService();
    private static final Logger logger = Logger.getLogger(WxUnifyOrderService.class);

    @Override
    public PushOrderResult unifyOrder(OrderContext context, Order order) {
        logger.error("Unify order START: " + order.toString());

        Unifiedorder unifiedorder = new Unifiedorder();
        unifiedorder.setAppid(Configs.getAppId());
        unifiedorder.setMch_id(Configs.getMchId());
        unifiedorder.setNonce_str(NonceStr.gen());
        unifiedorder.setBody(order.getSubject());
        unifiedorder.setOut_trade_no(order.getOutTradeNo());
        unifiedorder.setTotal_fee(String.valueOf(order.getTotalFee()));
        String ip = context.getPayerIp();
        logger.error(String.format("Unify order::payer ip is: %s", ip));
        unifiedorder.setSpbill_create_ip(ip);
        unifiedorder.setNotify_url(context.getNotifyUrl());
        unifiedorder.setTrade_type("NATIVE"); // optimize trade type to support other type of trade.
        unifiedorder.setDetail(createDetail(order));

        UnifiedorderResult result = PayMchAPI.payUnifiedorder(unifiedorder, Configs.getPartnerKey());
        logger.error(String.format("Wx result: return_msg=%s,return_code=%s,sign_status=%s,desc=%s", result.getReturn_msg(), result.getReturn_code(), result.getSign_status(), result.getReturn_msg()));
        logUnifyOrderResult(result, order);

        PushOrderResult ret = new PushOrderResult();
        ret.setPushOrderStatus(parsePushOrderStatus(result));
        Map<String, Object> resp = new HashMap<>();
        if (PushOrderStatus.SUCCESS == ret.getPushOrderStatus()) {
            resp.put("qr_code_url", result.getCode_url());
            resp.put("prepay_id", result.getPrepay_id());
            ret.setResponse(resp);
        }
        return ret;
    }

    private void logUnifyOrderResult(UnifiedorderResult result, Order order) {
        String rtc = result.getReturn_code();
        String rsc = result.getResult_code();
        String ec = result.getErr_code();
        String ecd = result.getErr_code_des();
        String tid = order.getOutTradeNo();
        logger.error(String.format("Unify order[%s] DONE:return_code=%s,result_code=%s,err_code=%s,err_code_desc=%s", tid, rtc, rsc, ec, ecd));
    }

    private Detail createDetail(Order order) {
        List<LineItem> lineItems = order.getLineItemList();
        if (lineItems == null || lineItems.isEmpty()) {
            return null;
        }

        Detail detail = new Detail();
        detail.setCost_price((int) order.getTotalFee());
        List<GoodsDetail> details = new ArrayList<>();
        for (LineItem item : lineItems) {
            GoodsDetail detail1 = new GoodsDetail();
            detail1.setGoods_name(item.getGoodsName());
            detail1.setGoods_id(item.getGoodsId());
            detail1.setBody(item.getBody());
            detail1.setPrice((int) item.getPrice());
            detail1.setQuantity(item.getQuantity());
            details.add(detail1);
        }
        detail.setGoods_detail(details);
        return detail;
    }

    private PushOrderStatus parsePushOrderStatus(UnifiedorderResult result) {
        String returnCode = result.getReturn_code();
        String resultCode = result.getResult_code();
        return isAllSuccess(returnCode, resultCode) ? PushOrderStatus.SUCCESS : PushOrderStatus.FAILED;
    }

    @Override
    public TradeStatus queryOrderStatus(String outTradeNo) {
        MchOrderquery query = new MchOrderquery();
        query.setOut_trade_no(outTradeNo);
        query.setAppid(Configs.getAppId());
        query.setMch_id(Configs.getMchId());
        query.setNonce_str(NonceStr.gen());
        MchOrderInfoResult result = PayMchAPI.payOrderquery(query, Configs.getPartnerKey());
        logger.info(String.format("Wx trade[%s] state is: %s", outTradeNo, result.getTrade_state()));
        return TradeStatusTranslator.translateWxTradeStatus(result.getTrade_state());
    }

    /**
     * 微信在下单五分钟之内是不允许撤销的。
     *
     * @param outTradeNo 订单编号
     */
    @Override
    public void cancelOrder(String outTradeNo) {
        Closeorder closeorder = new Closeorder();
        closeorder.setOut_trade_no(outTradeNo);
        closeorder.setAppid(Configs.getAppId());
        closeorder.setMch_id(Configs.getMchId());
        closeorder.setNonce_str(NonceStr.gen());
        MchBaseResult mchBaseResult = PayMchAPI.payCloseorder(closeorder, Configs.getPartnerKey());
        logger.error(String.format("cancel order[%s] with resp.status[%s]", outTradeNo, mchBaseResult.getResult_code()));
    }

    private WxUnifyOrderService() {
        Configs.init("wx.properties");
    }

    public static WxUnifyOrderService create() {
        return service;
    }

    private static boolean isAllSuccess(String... values) {
        for (String v : values) {
            if (!"SUCCESS".equals(v)) {
                return false;
            }
        }
        return true;
    }
}
