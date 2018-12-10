package com.jojowonet.modules.fitting.entity;

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

import com.jojowonet.modules.order.entity.Order;

/**
 * 旧件Entity
 * 创建时间2017-5-22
 */
@Entity
@Table(name = "crm_site_old_fitting")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OldFitting implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String id;//主键
	private String number;//编号
	private String code;//旧件条码
	private String name;//名称
	private String brand;//品牌
	//private String category;//品类
	private String suitCategory;//试用品类
	private String suitMode;//试用家电型号
	private String img;//旧件图片地址
	private String version;//旧件型号
	private String malfunctionType;//出现故障从工单中获取
	private String remarks;//备注
	private BigDecimal num;//登记数量
	private String unit;//单位名称

	private String unitType;//单位类型

	private Double unitPrice;//旧件价格

	private String orderId;//关联的工单id
	private String orderNumber;//工单编号
	private String customerName;//用户姓名
	private String customerMobile;//用户联系方式
	private String customerAddress;//用户详细地址
	private String applianceCategory;//家电品类
	private String applianceBrand;//家电品牌
	private String warrantyType;//保修类型
	//private String orderStatus;//工单状态
	
	private String usedRecordId;//关联的旧件使用记录
	private String yrpzFlag;//是否原配标记：1是2否，默认1
	private String employeId;//工程师id
	private String status;//状态：0已登记 1已入库2已删除，默认0
	private String siteId;//服务商id
	private Date createTime;//创建时间
	private String createName;//创建人
	//private String finishedTime;//完工时间
	private Date confirmTime;//入库时间
	private String confirmName;//入库操作人
	//private String mobile;//工程师联系方式
	private String employeName;
	/*public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}*/
	
	

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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	/*public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}*/
	public String getSuitCategory() {
		return suitCategory;
	}
	public void setSuitCategory(String suitCategory) {
		this.suitCategory = suitCategory;
	}
	public String getSuitMode() {
		return suitMode;
	}
	public void setSuitMode(String suitMode) {
		this.suitMode = suitMode;
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
	public String getMalfunctionType() {
		return malfunctionType;
	}
	public void setMalfunctionType(String malfunctionType) {
		this.malfunctionType = malfunctionType;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public BigDecimal getNum() {
		return num;
	}
	public void setNum(BigDecimal num) {
		this.num = num;
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
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerMobile() {
		return customerMobile;
	}
	public void setCustomerMobile(String customerMobile) {
		this.customerMobile = customerMobile;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public String getApplianceCategory() {
		return applianceCategory;
	}
	public void setApplianceCategory(String applianceCategory) {
		this.applianceCategory = applianceCategory;
	}
	public String getApplianceBrand() {
		return applianceBrand;
	}
	public void setApplianceBrand(String applianceBrand) {
		this.applianceBrand = applianceBrand;
	}
	public String getWarrantyType() {
		return warrantyType;
	}
	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}
	
	public String getUsedRecordId() {
		return usedRecordId;
	}
	public void setUsedRecordId(String usedRecordId) {
		this.usedRecordId = usedRecordId;
	}
	public String getYrpzFlag() {
		return yrpzFlag;
	}
	public void setYrpzFlag(String yrpzFlag) {
		this.yrpzFlag = yrpzFlag;
	}
	public String getEmployeId() {
		return employeId;
	}
	public void setEmployeId(String employeId) {
		this.employeId = employeId;
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
	public String getCreateName() {
		return createName;
	}
	public void setCreateName(String createName) {
		this.createName = createName;
	}
	public String getEmployeName() {
		return employeName;
	}
	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}
	public Date getConfirmTime() {
		return confirmTime;
	}
	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}

	public String getConfirmName() {
		return confirmName;
	}
	public void setConfirmName(String confirmName) {
		this.confirmName = confirmName;
	}
	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}
}
