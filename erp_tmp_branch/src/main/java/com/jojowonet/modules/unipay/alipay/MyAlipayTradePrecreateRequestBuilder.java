package com.jojowonet.modules.unipay.alipay;

import com.alipay.demo.trade.model.builder.AlipayTradePrecreateRequestBuilder;
import org.apache.commons.lang.StringUtils;

public class MyAlipayTradePrecreateRequestBuilder extends AlipayTradePrecreateRequestBuilder {

    public boolean validate() {
        String subject = getSubject();
        String outTradeNo = getOutTradeNo();
        String totalAmount = getTotalAmount();

        if (StringUtils.isBlank(subject)) {
            throw new NullPointerException("subject should not be NULL");
        }
        if (StringUtils.isBlank(outTradeNo)) {
            throw new NullPointerException("out_trade_no should not be NULL");
        }
        if (StringUtils.isBlank(totalAmount)) {
            throw new NullPointerException("total_amount should not be NULL");
        }

        return true;
    }

}
