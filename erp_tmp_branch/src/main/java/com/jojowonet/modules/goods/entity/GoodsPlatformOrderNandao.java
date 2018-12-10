package com.jojowonet.modules.goods.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * 平台产品南岛插座明细Entity
 * @author dongqing
 *
 */
@Entity
@Table(name = "crm_goods_platform_order_nandao")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsPlatformOrderNandao implements Serializable{
 
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String number;
	private String goodId;
	private String goodNumber;
	private String goodName;
	private String goodIcon;
	private String goodBrand;
	private String goodModel;
	private String goodCategory;
	private String customerName;
	private String customerContact;
	private String customerAddress;
	private BigDecimal purchaseNum;
	private BigDecimal goodAmount;
	private String placingOrderBy;
	private Date placingOrderTime;
	private String payer;
	private Date paymentTime;
	private String status;
	private String paymentType;
	private String tradeNo;
	private String logisticsName;
	private String logisticsNo;
	private String siteId;
	private String creator;
	private String siteselfOrderId;
	private String payStatus;
	private String supplierId;
	private Date confirmTime;
	private Date sendgoodTime;
	private Date finishTime;
	private String payConfirm;
	
	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	
	public Date getConfirmTime() {
		return confirmTime;
	}
	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}
	public Date getSendgoodTime() {
		return sendgoodTime;
	}
	public void setSendgoodTime(Date sendgoodTime) {
		this.sendgoodTime = sendgoodTime;
	}
	public Date getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}
	public String getGoodId() {
		return goodId;
	}
	public void setGoodId(String goodId) {
		this.goodId = goodId;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	
	public String getPayStatus() {
		return payStatus;
	}
	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}
	public String getSiteselfOrderId() {
		return siteselfOrderId;
	}
	public void setSiteselfOrderId(String siteselfOrderId) {
		this.siteselfOrderId = siteselfOrderId;
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
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerContact() {
		return customerContact;
	}
	public void setCustomerContact(String customerContact) {
		this.customerContact = customerContact;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
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
	public String getPlacingOrderBy() {
		return placingOrderBy;
	}
	public void setPlacingOrderBy(String placingOrderBy) {
		this.placingOrderBy = placingOrderBy;
	}
	public Date getPlacingOrderTime() {
		return placingOrderTime;
	}
	public void setPlacingOrderTime(Date placingOrderTime) {
		this.placingOrderTime = placingOrderTime;
	}
	public String getPayer() {
		return payer;
	}
	public void setPayer(String payer) {
		this.payer = payer;
	}
	public Date getPaymentTime() {
		return paymentTime;
	}
	public void setPaymentTime(Date paymentTime) {
		this.paymentTime = paymentTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getTradeNo() {
		return tradeNo;
	}
	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}
	public String getLogisticsName() {
		return logisticsName;
	}
	public void setLogisticsName(String logisticsName) {
		this.logisticsName = logisticsName;
	}
	public String getLogisticsNo() {
		return logisticsNo;
	}
	public void setLogisticsNo(String logisticsNo) {
		this.logisticsNo = logisticsNo;
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
	public String getPayConfirm() {
		return payConfirm;
	}
	public void setPayConfirm(String payConfirm) {
		this.payConfirm = payConfirm;
	}
	
	
	
}
