package com.jojowonet.modules.goods.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 平台产品出入库明细Entity
 */
@Entity
@Table(name = "crm_goods_platform_detail")
public class GoodsPlatformDetail implements Serializable{
	private static final long serialVersionUID = 1L;

	private String id;
	private String goodId;
	private String orderId;
	private String goodNumber;
	private String goodName;
	private String goodBrand;
	private String goodModel;
	private String goodCategory;
	private String goodType;
	private String unit;
	private String type;
	private String outStockType;
	private BigDecimal sitePrice;
	private BigDecimal platformPrice;
	private BigDecimal amount;
	private BigDecimal endStocks;
	private BigDecimal profit;
	private String confirmor;
	private String creator;
	private Date confirmTime;
	private Date createTime;
	private String status;

	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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

	public String getGoodType() {
		return goodType;
	}

	public void setGoodType(String goodType) {
		this.goodType = goodType;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public BigDecimal getSitePrice() {
		return sitePrice;
	}

	public void setSitePrice(BigDecimal sitePrice) {
		this.sitePrice = sitePrice;
	}

	public BigDecimal getPlatformPrice() {
		return platformPrice;
	}

	public void setPlatformPrice(BigDecimal platformPrice) {
		this.platformPrice = platformPrice;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getConfirmor() {
		return confirmor;
	}

	public void setConfirmor(String confirmor) {
		this.confirmor = confirmor;
	}

	public Date getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public BigDecimal getProfit() {
		return profit;
	}

	public void setProfit(BigDecimal profit) {
		this.profit = profit;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOutStockType() {
		return outStockType;
	}

	public void setOutStockType(String outStockType) {
		this.outStockType = outStockType;
	}

	public BigDecimal getEndStocks() {
		return endStocks;
	}

	public void setEndStocks(BigDecimal endStocks) {
		this.endStocks = endStocks;
	}
}
