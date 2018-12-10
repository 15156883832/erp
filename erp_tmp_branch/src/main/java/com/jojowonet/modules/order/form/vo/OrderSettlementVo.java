package com.jojowonet.modules.order.form.vo;

import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderSettlement;
import com.jojowonet.modules.order.entity.OrderSettlementDetail;
import com.jojowonet.modules.order.form.AddedSettlementItem;

import java.util.List;

public class OrderSettlementVo {
    private List<EntryItem<String, String>> jiesuanItems;
    private List<AddedSettlementItem> addedJisuan;
    private OrderSettlement orderSettlement;
    private List<OrderSettlementDetail> dispEmpSettlementDetail;
    private List<OrderSettlementDetail> addedEmpSettlementDetail;
    private Order order;

    public List<AddedSettlementItem> getAddedJisuan() {
        return addedJisuan;
    }

    public void setAddedJisuan(List<AddedSettlementItem> addedJisuan) {
        this.addedJisuan = addedJisuan;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public OrderSettlement getOrderSettlement() {
        return orderSettlement;
    }

    public void setOrderSettlement(OrderSettlement orderSettlement) {
        this.orderSettlement = orderSettlement;
    }

    public List<OrderSettlementDetail> getDispEmpSettlementDetail() {
        return dispEmpSettlementDetail;
    }

    public void setDispEmpSettlementDetail(List<OrderSettlementDetail> dispEmpSettlementDetail) {
        this.dispEmpSettlementDetail = dispEmpSettlementDetail;
    }

    public List<OrderSettlementDetail> getAddedEmpSettlementDetail() {
        return addedEmpSettlementDetail;
    }

    public void setAddedEmpSettlementDetail(List<OrderSettlementDetail> addedEmpSettlementDetail) {
        this.addedEmpSettlementDetail = addedEmpSettlementDetail;
    }

    public double getOrderMoney() {
        return order.getWarrantyCost() + order.getAuxiliaryCost() + order.getServeCost();
    }

    public List<EntryItem<String, String>> getJiesuanItems() {
        return jiesuanItems;
    }

    public void setJiesuanItems(List<EntryItem<String, String>> jiesuanItems) {
        this.jiesuanItems = jiesuanItems;
    }
}
