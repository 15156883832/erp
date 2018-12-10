package com.jojowonet.modules.order.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "crm_order_settlement_2017")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderSettlement2017 implements Serializable {

    private static final long serialVersionUID = 1L;
    private String id; 		// 编号
    private String orderId;
    private String dispatchId;
    private Date createTime;
    private String createBy;
    private String createName;
    private Double sumMoney;
    private String remarks;
    private String serviceMeasures;
    private Double paymentAmount;
    private String costDetail;
    private String siteId;
    private Double fittingCosts;
    private Double factoryMoney;
    private Double profits;
    private String settlementDetail;
    private Date settlementTime;

    public OrderSettlement2017() {
        super();
        this.createTime = new Date();
    }

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name ="idGenerator" , strategy ="uuid")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getDispatchId() {
        return dispatchId;
    }

    public void setDispatchId(String dispatchId) {
        this.dispatchId = dispatchId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getSiteId() {
        return siteId;
    }

    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }

    public Double getSumMoney() {
        return sumMoney;
    }

    public void setSumMoney(Double sumMoney) {
        this.sumMoney = sumMoney;
    }

    public String getServiceMeasures() {
        return serviceMeasures;
    }

    public void setServiceMeasures(String serviceMeasures) {
        this.serviceMeasures = serviceMeasures;
    }

    public String getCostDetail() {
        return costDetail;
    }

    public void setCostDetail(String costDetail) {
        this.costDetail = costDetail;
    }

    public Double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(Double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public Double getFactoryMoney() {
        return factoryMoney;
    }

    public void setFactoryMoney(Double factoryMoney) {
        this.factoryMoney = factoryMoney;
    }

    public Double getProfits() {
        return profits;
    }

    public void setProfits(Double profits) {
        this.profits = profits;
    }

    public Double getFittingCosts() {
        return fittingCosts;
    }

    public void setFittingCosts(Double fittingCosts) {
        this.fittingCosts = fittingCosts;
    }

    public String getSettlementDetail() {
        return settlementDetail;
    }

    public void setSettlementDetail(String settlementDetail) {
        this.settlementDetail = settlementDetail;
    }

    public Date getSettlementTime() {
        return settlementTime;
    }

    public void setSettlementTime(Date settlementTime) {
        this.settlementTime = settlementTime;
    }
}
