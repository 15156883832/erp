package com.jojowonet.modules.order.form;

import java.util.List;

public class BatchSettlementForm {
    private List<BatchSettlementItem> sItems;
    private String orderIds;
    private String sMethod;
    private String factoryFee;
    private String settlementDate;
    private String memo;

    public String getFactoryFee() {
        return factoryFee;
    }

    public void setFactoryFee(String factoryFee) {
        this.factoryFee = factoryFee;
    }

    public List<BatchSettlementItem> getsItems() {
        return sItems;
    }

    public void setsItems(List<BatchSettlementItem> sItems) {
        this.sItems = sItems;
    }

    public String getsMethod() {
        return sMethod;
    }

    public void setsMethod(String sMethod) {
        this.sMethod = sMethod;
    }

    public String getOrderIds() {
        return orderIds;
    }

    public void setOrderIds(String orderIds) {
        this.orderIds = orderIds;
    }

    public String getSettlementDate() {
        return settlementDate;
    }

    public void setSettlementDate(String settlementDate) {
        this.settlementDate = settlementDate;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
}
