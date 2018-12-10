package com.jojowonet.modules.fitting.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.NotBlank;

/**
 * 备件Entity
 * @author Ivan
 * @version 2017-05-20
 */
@Entity
@Table(name = "crm_site_fitting")
public class Fitting implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String id;
	@NotBlank
	private String code;//备件条码
	private String type;//备件类型
	private String name;//备件名称
	private String brand;//备件品牌
	private String suitCategory;//适用品类
	private String suitBrand;
	private String img;
	private String version;//备件型号
	private String supplier;//备件来源
	private String remarks;
	private String location;//库位
	private String unit;//计量单位(默认为件)
	private String unitType;//单位类型：i整型  d实数型
	private String refundOldFlag;//返还旧件
	private String status;
	private String siteId;
	private Date createTime;//创建时间
	private String createBy;//创建人user_id
	private String keyword;
	private Double warning;//入库数量
	private Double number;//已领取未核销数量，默认0
	private Double alertNum;//预警
	private Double auditedSum;
	private Double unreceivedNum;
	private Double cjnum;
	private Double sitePrice;//入库价格
	private Double employePrice;//工程师价格
	private Double customerPrice;//零售价格
	private Double total;
	private Date newestKeepTime;//最新出库时间
	private String factoryId;


	public Fitting() {
		super();
		this.createTime = new Date();
		this.warning = 0.00;
		this.total=0.00;
		this.number=0.00;
		this.auditedSum=0.00;
		this.unreceivedNum=0.00;
		this.cjnum=0.00;
		this.sitePrice=0.00;
		this.employePrice=0.00;
		this.customerPrice=0.00;
		this.status = "1";
		this.type = "1";
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getSuitCategory() {
		return suitCategory;
	}
	public void setSuitCategory(String suitCategory) {
		this.suitCategory = suitCategory;
	}
	public String getSuitBrand() {
		return suitBrand;
	}
	public void setSuitBrand(String suitBrand) {
		this.suitBrand = suitBrand;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	public String getRefundOldFlag() {
		return refundOldFlag;
	}
	public void setRefundOldFlag(String refundOldFlag) {
		this.refundOldFlag = refundOldFlag;
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
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Double getWarning() {
		return warning;
	}
	public void setWarning(Double warning) {
		this.warning = warning;
	}
	public Double getNumber() {
		return number;
	}
	public void setNumber(Double number) {
		this.number = number;
	}
	public Double getAuditedSum() {
		return auditedSum;
	}
	public void setAuditedSum(Double auditedSum) {
		this.auditedSum = auditedSum;
	}
	public Double getCjnum() {
		return cjnum;
	}
	public void setCjnum(Double cjnum) {
		this.cjnum = cjnum;
	}
	public Double getSitePrice() {
		return sitePrice;
	}
	public void setSitePrice(Double sitePrice) {
		this.sitePrice = sitePrice;
	}
	public Double getEmployePrice() {
		return employePrice;
	}
	public void setEmployePrice(Double employePrice) {
		this.employePrice = employePrice;
	}
	public Double getCustomerPrice() {
		return customerPrice;
	}
	public void setCustomerPrice(Double customerPrice) {
		this.customerPrice = customerPrice;
	}
	public Double getUnreceivedNum() {
		return unreceivedNum;
	}
	public void setUnreceivedNum(Double unreceivedNum) {
		this.unreceivedNum = unreceivedNum;
	}

	public Double getAlertNum() {
		return alertNum;
	}

	public void setAlertNum(Double alertNum) {
		this.alertNum = alertNum;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}
	public Date getNewestKeepTime() {return newestKeepTime;}

	public void setNewestKeepTime(Date newestKeepTime) {this.newestKeepTime = newestKeepTime;}

	@Override
	public String toString() {
		return "Fitting{" +
				"id='" + id + '\'' +
				", code='" + code + '\'' +
				", type='" + type + '\'' +
				", name='" + name + '\'' +
				", brand='" + brand + '\'' +
				", suitCategory='" + suitCategory + '\'' +
				", suitBrand='" + suitBrand + '\'' +
//				", img='" + img + '\'' +
				", version='" + version + '\'' +
				", supplier='" + supplier + '\'' +
//				", remarks='" + remarks + '\'' +
//				", location='" + location + '\'' +
//				", unit='" + unit + '\'' +
//				", unitType='" + unitType + '\'' +
//				", refundOldFlag='" + refundOldFlag + '\'' +
				", status='" + status + '\'' +
				", siteId='" + siteId + '\'' +
//				", createTime=" + createTime +
//				", createBy='" + createBy + '\'' +
//				", keyword='" + keyword + '\'' +
				", warning=" + warning +
				", number=" + number +
				", alertNum=" + alertNum +
				", auditedSum=" + auditedSum +
				", unreceivedNum=" + unreceivedNum +
				", cjnum=" + cjnum +
//				", sitePrice=" + sitePrice +
//				", employePrice=" + employePrice +
//				", customerPrice=" + customerPrice +
				", total=" + total +
//				", newestKeepTime=" + newestKeepTime +
//				", factoryId='" + factoryId + '\'' +
				'}';
	}

	public String getFactoryId() {
		return factoryId;
	}

	public void setFactoryId(String factoryId) {
		this.factoryId = factoryId;
	}
}
