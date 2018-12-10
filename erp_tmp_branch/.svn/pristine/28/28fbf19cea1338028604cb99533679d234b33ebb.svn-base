package com.jojowonet.modules.order.form.vo;

import com.jojowonet.modules.order.service.SiteScheduleService;
import com.jojowonet.modules.order.service.SiteSettlementService;

import java.math.BigDecimal;

public class SettlementItem {
    private String name;
    private BigDecimal cost;
    private boolean proportion; // cost是否是比例，用于批量结算。
    private String id;
    private String type; // 结算模板中basis_type。
    private double factoryPV = -1; // 厂家结算费用的比例，当type为5，此值有效。-1表示按固定金额，否则表示按比例。

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public boolean isProportion() {
        return proportion;
    }

    public void setProportion(boolean proportion) {
        this.proportion = proportion;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getFactoryPV() {
        return factoryPV;
    }

    public void setFactoryPV(double factoryPV) {
        this.factoryPV = factoryPV;
    }

    public boolean isFactoryFeeProportionBasedItem() {
        return proportion && "5".equals(type);
    }
}
