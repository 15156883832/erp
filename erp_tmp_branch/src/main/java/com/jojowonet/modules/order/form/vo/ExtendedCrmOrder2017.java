package com.jojowonet.modules.order.form.vo;

import com.jojowonet.modules.order.entity.CrmOrder2017;
import com.jojowonet.modules.sys.util.TranslationUtils;

public class ExtendedCrmOrder2017 {
    private final CrmOrder2017 order;

    public ExtendedCrmOrder2017(CrmOrder2017 order) {
        this.order = order;
    }

    public CrmOrder2017 getOrder() {
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
