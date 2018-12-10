package com.jojowonet.modules.unipay.alipay;

import com.alipay.demo.trade.config.Configs;
import com.alipay.demo.trade.model.ExtendParams;
import com.alipay.demo.trade.model.GoodsDetail;
import com.alipay.demo.trade.model.builder.AlipayTradePrecreateRequestBuilder;
import com.jojowonet.modules.unipay.core.LineItem;
import com.jojowonet.modules.unipay.core.Order;
import com.jojowonet.modules.unipay.core.OrderContext;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * @author gaols
 */
public class AlipayUnifyOrderRequestBuilder {

    private static final String STR_SERVICE_PROVIDER_ID = "sys_service_provider_id";
    private final OrderContext context;
    private final Order order;

    public AlipayUnifyOrderRequestBuilder(OrderContext context, Order order) {
        this.context = context;
        this.order = order;
    }

    public AlipayTradePrecreateRequestBuilder build() {
        Configuration configs = Configs.getConfigs();
        AlipayTradePrecreateRequestBuilder builder = new MyAlipayTradePrecreateRequestBuilder()
                .setOutTradeNo(order.getOutTradeNo())
                .setSubject(order.getSubject())
                .setBody(order.getBody())
                .setTotalAmount(convertTotalAmount(order.getTotalFee()))
                .setDiscountableAmount(convertTotalAmount(order.getTotalFee()))
                .setNotifyUrl(StringUtils.defaultIfEmpty(context.getNotifyUrl(), configs.getString("notify_url")))
                .setTimeoutExpress(context.getPayTimeout());
//                .setStoreId(configs.getString("store_id"))

        if (StringUtils.isNotBlank(configs.getString(STR_SERVICE_PROVIDER_ID))) {
            ExtendParams extendParams = new ExtendParams();
            extendParams.setSysServiceProviderId(configs.getString(STR_SERVICE_PROVIDER_ID));
            builder.setExtendParams(extendParams);
        }

        if (StringUtils.isNotBlank(context.getOperatorId())) {
            builder.setOperatorId(context.getOperatorId());
        }

        List<GoodsDetail> goodDetailsList = createGoodDetailsList(order.getLineItemList());
        if (goodDetailsList != null && !goodDetailsList.isEmpty()) {
            builder.setGoodsDetailList(goodDetailsList);
        }
        return builder;
    }

    /**
     * amount是单位是分，这里需要将其转化元。
     *
     * @param amount the amount of cents.
     * @return Yuan
     */
    private static String convertTotalAmount(long amount) {
        double m = amount * 1.0d / 100.0d;
        BigDecimal value = BigDecimal.valueOf(m);
        return new DecimalFormat("#.##").format(value);
    }

    private GoodsDetail createGoodsDetail(LineItem item) {
        return GoodsDetail.newInstance(item.getGoodsId(), item.getGoodsName(), item.getPrice(), item.getQuantity());
    }

    private List<GoodsDetail> createGoodDetailsList(List<LineItem> lineItemList) {
        List<GoodsDetail> goodDetailsList = null;
        boolean hasLineItems = (lineItemList != null && !lineItemList.isEmpty());
        if (hasLineItems) {
            goodDetailsList = new ArrayList<>();
            for (LineItem item : lineItemList) {
                goodDetailsList.add(createGoodsDetail(item));
            }
        }
        return goodDetailsList;
    }
}
