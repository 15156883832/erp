package com.jojowonet.modules.order.form.vo;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.form.AddedSettlementItem;
import com.jojowonet.modules.order.utils.MathUtils;

import java.util.List;

public class OrderSettlement2017Vo {
    private List<EntryItem<String, String>> jiesuanItems;
    private List<AddedSettlementItem> addedJisuan;
    private Record orderSettlement;
    private List<Record> dispEmpSettlementDetail;
    private List<Record> addedEmpSettlementDetail;
    private Record order;

    public List<AddedSettlementItem> getAddedJisuan() {
        return addedJisuan;
    }

    public void setAddedJisuan(List<AddedSettlementItem> addedJisuan) {
        this.addedJisuan = addedJisuan;
    }

    public Record getOrder() {
        return order;
    }

    public void setOrder(Record order) {
        this.order = order;
    }

    public Record getOrderSettlement() {
        return orderSettlement;
    }

    public void setOrderSettlement(Record orderSettlement) {
        this.orderSettlement = orderSettlement;
    }

    public List<Record> getDispEmpSettlementDetail() {
        return dispEmpSettlementDetail;
    }

    public void setDispEmpSettlementDetail(List<Record> dispEmpSettlementDetail) {
        this.dispEmpSettlementDetail = dispEmpSettlementDetail;
    }

    public List<Record> getAddedEmpSettlementDetail() {
        return addedEmpSettlementDetail;
    }

    public void setAddedEmpSettlementDetail(List<Record> addedEmpSettlementDetail) {
        this.addedEmpSettlementDetail = addedEmpSettlementDetail;
    }

    public double getOrderMoney() {
        return MathUtils.sum(order.getBigDecimal("warranty_cost"), order.getBigDecimal("auxiliary_cost"), order.getBigDecimal("serve_cost"));
    }

    public List<EntryItem<String, String>> getJiesuanItems() {
        return jiesuanItems;
    }

    public void setJiesuanItems(List<EntryItem<String, String>> jiesuanItems) {
        this.jiesuanItems = jiesuanItems;
    }
}
