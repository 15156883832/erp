package com.jojowonet.modules.order.form.vo;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.sys.util.TranslationUtils;

public class ExtendedCallback {
    private final Record callback;

    public ExtendedCallback(Record r) {
        this.callback = r;
    }

    public Record getCallback() {
        return callback;
    }

    public String getTranslatedSafeEval() {
        if (callback != null) {
            String eval = callback.getStr("safety_evaluation");
            return TranslationUtils.translateSafeEval(eval);
        }
        return "";
    }

    public String getTranslatedServiceAttitude() {
        if (callback != null) {
            String attitude = callback.getStr("service_attitude");
            return TranslationUtils.translateServiceAttitude(attitude);
        }
        return "";
    }

    public String getTranslatedMultipleDropIn() {
        if (callback != null) {
            String multipleDropin = callback.getStr("multiple_dropin");
            if ("1".equals(multipleDropin)) {
                return "是";
            } else if ("0".equals(multipleDropin)) {
                return "否";
            }
        }
        return "";
    }

    public String getTranslatedResult() {
        if (callback != null) {
            String returnCard = callback.getStr("result");
            if ("1".equals(returnCard)) {
                return "已完工";
            } else if ("2".equals(returnCard)) {
                return "仍需上门";
            } else if ("3".equals(returnCard)) {
                return "待回访";
            }
        }
        return "";
    }

}
