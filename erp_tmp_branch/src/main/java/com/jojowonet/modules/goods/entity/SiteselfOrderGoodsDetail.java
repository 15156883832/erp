package com.jojowonet.modules.goods.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "crm_goods_siteself_order_goods_detail")
public class SiteselfOrderGoodsDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	private String id;
	private String siteOrderId;

	private String goodId;
	private String goodNumber;
	private String goodName;
	private String goodIcon;
	private String goodBrand;
	private String goodModel;
	private String goodCategory;
	private String goodSource;
	private String orderId;
	private String orderNumber;

	private BigDecimal goodCost;
	private BigDecimal purchaseNum;
	private BigDecimal goodAmount;
	private BigDecimal realAmount;
	private BigDecimal salesCommissions;
	private Date createTime;

	private String commissionsRemarks;
	private String outstockType;
	private String status;

	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSiteOrderId() {
		return siteOrderId;
	}

	public void setSiteOrderId(String siteOrderId) {
		this.siteOrderId = siteOrderId;
	}

	public String getGoodId() {
		return goodId;
	}

	public void setGoodId(String goodId) {
		this.goodId = goodId;
	}

	public String getGoodNumber() {
		return goodNumber;
	}

	public void setGoodNumber(String goodNumber) {
		this.goodNumber = goodNumber;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	public String getGoodIcon() {
		return goodIcon;
	}

	public void setGoodIcon(String goodIcon) {
		this.goodIcon = goodIcon;
	}

	public String getGoodBrand() {
		return goodBrand;
	}

	public void setGoodBrand(String goodBrand) {
		this.goodBrand = goodBrand;
	}

	public String getGoodModel() {
		return goodModel;
	}

	public void setGoodModel(String goodModel) {
		this.goodModel = goodModel;
	}

	public String getGoodCategory() {
		return goodCategory;
	}

	public void setGoodCategory(String goodCategory) {
		this.goodCategory = goodCategory;
	}

	public String getGoodSource() {
		return goodSource;
	}

	public void setGoodSource(String goodSource) {
		this.goodSource = goodSource;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public BigDecimal getGoodCost() {
		return goodCost;
	}

	public void setGoodCost(BigDecimal goodCost) {
		this.goodCost = goodCost;
	}

	public BigDecimal getPurchaseNum() {
		return purchaseNum;
	}

	public void setPurchaseNum(BigDecimal purchaseNum) {
		this.purchaseNum = purchaseNum;
	}

	public BigDecimal getGoodAmount() {
		return goodAmount;
	}

	public void setGoodAmount(BigDecimal goodAmount) {
		this.goodAmount = goodAmount;
	}

	public BigDecimal getRealAmount() {
		return realAmount;
	}

	public void setRealAmount(BigDecimal realAmount) {
		this.realAmount = realAmount;
	}

	public BigDecimal getSalesCommissions() {
		return salesCommissions;
	}

	public void setSalesCommissions(BigDecimal salesCommissions) {
		this.salesCommissions = salesCommissions;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCommissionsRemarks() {
		return commissionsRemarks;
	}

	public void setCommissionsRemarks(String commissionsRemarks) {
		this.commissionsRemarks = commissionsRemarks;
	}

	public String getOutstockType() {
		return outstockType;
	}

	public void setOutstockType(String outstockType) {
		this.outstockType = outstockType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	private String siteId;
	private String creator;
	private String createBy;
	private String cancelReason;

}
