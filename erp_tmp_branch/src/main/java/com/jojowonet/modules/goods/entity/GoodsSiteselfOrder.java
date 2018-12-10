package com.jojowonet.modules.goods.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 服务商商品 订单信息表Entity
 * 
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_goods_siteself_order")
// @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsSiteselfOrder implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private String number;
	private String goodsInfo;
	private String customerName;
	private String customerContact;
	private String customerAddress;
	private double purchaseNum;
	private double realAmount;
	private double confirmAmount;
	private double goodsCost;
	private String placingOrderBy;
	private Date placingOrderTime;
	private String confirmBy;
	private Date confirmTime;
	private Date outstockTime;
	private String status;
	private String siteId;
	private String creator;
	private String outstockType;
	private String placingName;
	private String confirmor;
	private double salesCommissions;
	private BigDecimal paidCommissions;
	private String createBy;
	private String payMark;
	private String editDetail;
	private Date editTime;

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public double getSalesCommissions() {
		return salesCommissions;
	}

	public void setSalesCommissions(double salesCommissions) {
		this.salesCommissions = salesCommissions;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getPlacingName() {
		return placingName;
	}

	public void setPlacingName(String placingName) {
		this.placingName = placingName;
	}

	public String getConfirmor() {
		return confirmor;
	}

	public void setConfirmor(String confirmor) {
		this.confirmor = confirmor;
	}

	public String getOutstockType() {
		return outstockType;
	}

	public void setOutstockType(String outstockType) {
		this.outstockType = outstockType;
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

	public double getPurchaseNum() {
		return purchaseNum;
	}

	public void setPurchaseNum(double purchaseNum) {
		this.purchaseNum = purchaseNum;
	}

	public double getRealAmount() {
		return realAmount;
	}

	public void setRealAmount(double realAmount) {
		this.realAmount = realAmount;
	}

	public double getConfirmAmount() {
		return confirmAmount;
	}

	public void setConfirmAmount(double confirmAmount) {
		this.confirmAmount = confirmAmount;
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

	public String getConfirmBy() {
		return confirmBy;
	}

	public void setConfirmBy(String confirmBy) {
		this.confirmBy = confirmBy;
	}

	public Date getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}

	public Date getOutstockTime() {
		return outstockTime;
	}

	public void setOutstockTime(Date outstockTime) {
		this.outstockTime = outstockTime;
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

	public String getPayMark() {
		return payMark;
	}

	public void setPayMark(String payMark) {
		this.payMark = payMark;
	}

	public String getEditDetail() {
		return editDetail;
	}

	public void setEditDetail(String editDetail) {
		this.editDetail = editDetail;
	}

	public Date getEditTime() {
		return editTime;
	}

	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}

	public String getGoodsInfo() {
		return goodsInfo;
	}

	public void setGoodsInfo(String goodsInfo) {
		this.goodsInfo = goodsInfo;
	}

	public double getGoodsCost() {
		return goodsCost;
	}

	public void setGoodsCost(double goodsCost) {
		this.goodsCost = goodsCost;
	}

	public BigDecimal getPaidCommissions() {
		return paidCommissions;
	}

	public void setPaidCommissions(BigDecimal paidCommissions) {
		this.paidCommissions = paidCommissions;
	}

}
