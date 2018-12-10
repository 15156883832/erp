package com.jojowonet.modules.order.form.vo;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.sys.util.TranslationUtils;

import java.util.Map;

public class ExtendedOrder2017Record {
    private final Map<String, Object> order;

    public ExtendedOrder2017Record(Record order) {
        this.order = order.getColumns();
    }

    public Map<String, Object> getOrder() {
        return order;
    }

    public String getTranslatedReturnCard() {
        String returnCard = (String) order.get("return_card");
        if ("1".equals(returnCard)) {
            return "是";
        } else if ("2".equals(returnCard) || "0".equals(returnCard)) {
            return "否";
        }
        return "";
    }

    public String getTranslatedWarrantyType() {
        return TranslationUtils.translateWarrantyType((String) order.get("warranty_type"));
    }

    public String getTranslatedWhetherCollection() {
        String returnCard = (String) order.get("whether_collection");
        if ("1".equals(returnCard)) {
            return "是";
        } else if ("2".equals(returnCard) || "0".equals(returnCard)) {
            return "否";
        }
        return "";
    }
}
