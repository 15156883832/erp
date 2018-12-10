package com.jojowonet.modules.goods.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "crm_goods_siteself_profit_detail")
// @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsSiteselfProfitDetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private String number;
	private String goodId;
	private double goodNum;
	private String goodNumber;
	private double profit;
	private String salesman;
	private String creator;
	private String salesType;
	private Date createTime;
	private Date confirmTime;
	private double sitePrice;
	private double costSales;
	private double grossSales;
	private String confirmor;
	private String status;
	private String siteId;
	private String siteOrderId;
	private String siteselfDetailId;
	private String siteOrderGoodsDetailId;

	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
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

	public String getSalesman() {
		return salesman;
	}

	public void setSalesman(String salesman) {
		this.salesman = salesman;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getSalesType() {
		return salesType;
	}

	public void setSalesType(String salesType) {
		this.salesType = salesType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}

	public String getConfirmor() {
		return confirmor;
	}

	public void setConfirmor(String confirmor) {
		this.confirmor = confirmor;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSiteselfDetailId() {
		return siteselfDetailId;
	}

	public void setSiteselfDetailId(String siteselfDetailId) {
		this.siteselfDetailId = siteselfDetailId;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public double getGoodNum() {
		return goodNum;
	}

	public void setGoodNum(double goodNum) {
		this.goodNum = goodNum;
	}

	public double getProfit() {
		return profit;
	}

	public void setProfit(double profit) {
		this.profit = profit;
	}

	public double getSitePrice() {
		return sitePrice;
	}

	public void setSitePrice(double sitePrice) {
		this.sitePrice = sitePrice;
	}

	public double getCostSales() {
		return costSales;
	}

	public void setCostSales(double costSales) {
		this.costSales = costSales;
	}

	public double getGrossSales() {
		return grossSales;
	}

	public void setGrossSales(double grossSales) {
		this.grossSales = grossSales;
	}

	public String getSiteOrderId() {
		return siteOrderId;
	}

	public void setSiteOrderId(String siteOrderId) {
		this.siteOrderId = siteOrderId;
	}

	public String getSiteOrderGoodsDetailId() {
		return siteOrderGoodsDetailId;
	}

	public void setSiteOrderGoodsDetailId(String siteOrderGoodsDetailId) {
		this.siteOrderGoodsDetailId = siteOrderGoodsDetailId;
	}

}