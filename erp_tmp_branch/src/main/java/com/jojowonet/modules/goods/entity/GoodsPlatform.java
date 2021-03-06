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
 * 平台产品Entity
 *@author dongqing
 */
@Entity
@Table(name = "crm_goods_platform")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsPlatform  implements Serializable{
	private static final long serialVersionUID = 1L;

	public static final String DIS_TYPE_AUTO = "1";
	public static final String DIS_TYPE_MANUALLY = "2";

	private String id;
	private int sortNum;
	private String number;
	private String name;
	private String brand;
	private String model;
	private String category;
	private String unit;
	private String unitType;
	private String description;
	private String icon;
	private String imgs;
	private BigDecimal sitePrice;
	private BigDecimal noVipPrice;
	private BigDecimal advicePrice;
	private BigDecimal platformPrice;
	private BigDecimal profit;
	private String sellFlag;
	private String type;
	private String distributionType;
	private BigDecimal stocks;
	private BigDecimal sales;
	private String status;
	private String html;
	private String goodSign;
	private String repairTerm;
	private String jdSellerLink;
	private String tmallSellerLink;
	private Date createTime;

	public GoodsPlatform(){
		super();
		this.sellFlag="2";
		this.stocks=BigDecimal.valueOf(Double.valueOf("0"));
		this.createTime=new Date();
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
	public int getSortNum() {
		return sortNum;
	}
	public void setSortNum(int sortNum) {
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
	public void setModel(String model) {
		this.model = model;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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

	public String getSellFlag() {
		return sellFlag;
	}
	public void setSellFlag(String sellFlag) {
		this.sellFlag = sellFlag;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDistributionType() {
		return distributionType;
	}
	public void setDistributionType(String distributionType) {
		this.distributionType = distributionType;
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
	public BigDecimal getProfit() {
		return profit;
	}
	public void setProfit(BigDecimal profit) {
		this.profit = profit;
	}
	public BigDecimal getStocks() {
		return stocks;
	}
	public void setStocks(BigDecimal stocks) {
		this.stocks = stocks;
	}
	public BigDecimal getSales() {
		return sales;
	}
	public void setSales(BigDecimal sales) {
		this.sales = sales;
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


	public BigDecimal getNoVipPrice() {
		return noVipPrice;
	}

	public void setNoVipPrice(BigDecimal noVipPrice) {
		this.noVipPrice = noVipPrice;
	}

	public String getGoodSign() {
		return goodSign;
	}

	public void setGoodSign(String goodSign) {
		this.goodSign = goodSign;
	}

	public String getRepairTerm() {
		return repairTerm;
	}

	public void setRepairTerm(String repairTerm) {
		this.repairTerm = repairTerm;
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

	public BigDecimal getAdvicePrice() {
		return advicePrice;
	}

	public void setAdvicePrice(BigDecimal advicePrice) {
		this.advicePrice = advicePrice;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
