package com.jojowonet.modules.order.form.vo;

import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.sys.util.TranslationUtils;

public class ExtendedOrder {

    private final Order order;

    public ExtendedOrder(Order order) {
        this.order = order;
    }

    public Order getOrder() {
        return order;
    }

    public String getTranslatedReturnCard() {
        String returnCard = order.getReturnCard();
        if ("1".equals(returnCard)) {
            return "是";
        } else if ("2".equals(returnCard) || "0".equals(returnCard)) {
            return "否";
        }
        return "";
    }

    public String getTranslatedWarrantyType() {
        return TranslationUtils.translateWarrantyType(order.getWarrantyType());
    }

    public String getTranslatedWhetherCollection() {
        String returnCard = order.getWhetherCollection();
        if ("1".equals(returnCard)) {
            return "是";
        } else if ("2".equals(returnCard) || "0".equals(returnCard)) {
            return "否";
        }
        return "";
    }
}
