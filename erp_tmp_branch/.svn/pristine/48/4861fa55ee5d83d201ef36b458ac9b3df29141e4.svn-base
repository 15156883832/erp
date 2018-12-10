package com.jojowonet.modules.goods.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 服务商自营商品 基础信息表Entity
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_goods_siteself")
public class GoodsSiteSelf implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private Integer sortNum;
	private String number;
	private String name;
	private String brand;
	private String model;
	private String category;
	private String location;
	private String unit;
	private String unitType;
	private String description;
	private String icon;
	private String imgs;
	private double sitePrice;
	private double employePrice;
	private double customerPrice;
	private double rebatePrice;
	private String rebateFlag;//是否有折扣价
	private String deductType;
	private double normalDeductAmount;
	private String ratioDeductRadix;
	private Integer ratioDeductVal;
	private String sellFlag;
	private String source;
	private double stocks;
	private double sales;
	private double receives;
	private String siteId;
	private String status;
	private String html;
	private Date createTime;
	private String jdSellerLink;
	private String tmallSellerLink;
	private String repairTerm;
	
	public GoodsSiteSelf(){
		super();
		this.sortNum=1;
		this.rebateFlag="0";
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
	
	
	public String getJdSellerLink() {
		return jdSellerLink;
	}


	public void setJdSellerLink(String jdSellerLink) {
		this.jdSellerLink = jdSellerLink;
	}


	public String getTmallSellerLink() {
		return tmallSellerLink;
	}


	public void setTmallSellerLink(String tmallSellerLink) {
		this.tmallSellerLink = tmallSellerLink;
	}


	public Integer getSortNum() {
		return sortNum;
	}
	public void setSortNum(Integer sortNum) {
		this.sortNum = sortNum;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getModel() {
		return model;
	}
	public String getRatioDeductRadix() {
		return ratioDeductRadix;
	}
	public void setRatioDeductRadix(String ratioDeductRadix) {
		this.ratioDeductRadix = ratioDeductRadix;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getUnitType() {
		return unitType;
	}
	public void setUnitType(String unitType) {
		this.unitType = unitType;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	public double getSitePrice() {
		return sitePrice;
	}
	public void setSitePrice(double sitePrice) {
		this.sitePrice = sitePrice;
	}
	public double getEmployePrice() {
		return employePrice;
	}
	public void setEmployePrice(double employePrice) {
		this.employePrice = employePrice;
	}
	public double getCustomerPrice() {
		return customerPrice;
	}
	public void setCustomerPrice(double customerPrice) {
		this.customerPrice = customerPrice;
	}
	
	public String getRebateFlag() {
		return rebateFlag;
	}

	public void setRebateFlag(String rebateFlag) {
		this.rebateFlag = rebateFlag;
	}


	public double getRebatePrice() {
		return rebatePrice;
	}
	public void setRebatePrice(double rebatePrice) {
		this.rebatePrice = rebatePrice;
	}
	public String getDeductType() {
		return deductType;
	}
	public void setDeductType(String deductType) {
		this.deductType = deductType;
	}
	public double getNormalDeductAmount() {
		return normalDeductAmount;
	}
	public void setNormalDeductAmount(double normalDeductAmount) {
		this.normalDeductAmount = normalDeductAmount;
	}
	public Integer getRatioDeductVal() {
		return ratioDeductVal;
	}
	public void setRatioDeductVal(Integer ratioDeductVal) {
		this.ratioDeductVal = ratioDeductVal;
	}
	public String getSellFlag() {
		return sellFlag;
	}
	public void setSellFlag(String sellFlag) {
		this.sellFlag = sellFlag;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public double getStocks() {
		return stocks;
	}
	public void setStocks(double stocks) {
		this.stocks = stocks;
	}
	public double getSales() {
		return sales;
	}
	public void setSales(double sales) {
		this.sales = sales;
	}
	public double getReceives() {
		return receives;
	}
	public void setReceives(double receives) {
		this.receives = receives;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}


	public Date getCreateTime() {
		return createTime;
	}


	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public String getRepairTerm() {
		return repairTerm;
	}


	public void setRepairTerm(String repairTerm) {
		this.repairTerm = repairTerm;
	}


	
	
	
	
	
}
