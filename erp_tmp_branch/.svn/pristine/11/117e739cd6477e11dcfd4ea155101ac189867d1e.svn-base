package com.jojowonet.modules.goods.utils;

import com.drew.lang.annotations.NotNull;
import com.jojowonet.modules.unipay.core.Order;

import javax.validation.constraints.Min;

public class SmsOrderInfo extends Order {
    private String payType;
    private String pid;
    @NotNull
    @Min(1000)
    private Integer msgCount;

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public Integer getMsgCount() {
        return msgCount;
    }

    public void setMsgCount(Integer msgCount) {
        this.msgCount = msgCount;
    }
}
