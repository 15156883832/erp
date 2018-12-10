package com.jojowonet.modules.fitting.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 备件Entity
 * @author Ivan
 * @version 2017-05-20
 */
@Entity
@Table(name = "crm_site_fitting_used_record")
public class FittingUsedRecord {

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name ="idGenerator" , strategy ="uuid")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    private String id;
    private String fittingId;
    private String brand;
    private String category;
    private String siteId;
    private String orderId;
    private String type;
    private String confirmType;
    private BigDecimal usedNum;
    private String status;
    private String employeId;
    private String confirmor;
    private String confirmorId;
    private Date usedTime;
    private Date checkTime;
    private String createBy;
    private String creator;//申请人

    private String oldFittingFlag;
    private String collectionFlag;
    private BigDecimal collectionMoney;
    private BigDecimal confirmedMoney;
    private String userName;//使用人姓名
    
    private String fittingCode;
    private String fittingVersion;
    private String fittingName;
    private String warrantyType;
    private String customerName;
    private String customerMobile;
    private String customerAddress;
    private String orderNumber;
    private String applianceCategory;
    private String applianceBrand;

    public FittingUsedRecord(){
        this.collectionFlag="0";
    }


    public String getWarrantyType() {
        return warrantyType;
    }

    public void setWarrantyType(String warrantyType) {
        this.warrantyType = warrantyType;
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

    public String getFittingCode() {
		return fittingCode;
	}

	public void setFittingCode(String fittingCode) {
		this.fittingCode = fittingCode;
	}

	public String getFittingVersion() {
		return fittingVersion;
	}

	public void setFittingVersion(String fittingVersion) {
		this.fittingVersion = fittingVersion;
	}

	public String getFittingName() {
		return fittingName;
	}

	public void setFittingName(String fittingName) {
		this.fittingName = fittingName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFittingId() {
        return fittingId;
    }

    public void setFittingId(String fittingId) {
        this.fittingId = fittingId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSiteId() {
        return siteId;
    }

    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getUsedNum() {
        return usedNum;
    }

    public void setUsedNum(BigDecimal usedNum) {
        this.usedNum = usedNum;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmployeId() {
        return employeId;
    }

    public void setEmployeId(String employeId) {
        this.employeId = employeId;
    }

    public String getConfirmor() {
        return confirmor;
    }

    public void setConfirmor(String confirmor) {
        this.confirmor = confirmor;
    }

    public String getConfirmorId() {
        return confirmorId;
    }

    public void setConfirmorId(String confirmorId) {
        this.confirmorId = confirmorId;
    }

    public Date getUsedTime() {
        return usedTime;
    }

    public void setUsedTime(Date usedTime) {
        this.usedTime = usedTime;
    }

    public Date getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(Date checkTime) {
        this.checkTime = checkTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getOldFittingFlag() {
        return oldFittingFlag;
    }

    public void setOldFittingFlag(String oldFittingFlag) {
        this.oldFittingFlag = oldFittingFlag;
    }

    public String getCollectionFlag() {
        return collectionFlag;
    }

    public void setCollectionFlag(String collectionFlag) {
        this.collectionFlag = collectionFlag;
    }

    public BigDecimal getCollectionMoney() {
        return collectionMoney;
    }

    public void setCollectionMoney(BigDecimal collectionMoney) {
        this.collectionMoney = collectionMoney;
    }

    public BigDecimal getConfirmedMoney() {
        return confirmedMoney;
    }

    public void setConfirmedMoney(BigDecimal confirmedMoney) {
        this.confirmedMoney = confirmedMoney;
    }
    
    public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
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



	@Override
    public String toString() {
        return "FittingUsedRecord{" +
                "id='" + id + '\'' +
                ", fittingId='" + fittingId + '\'' +
                ", siteId='" + siteId + '\'' +
                ", orderId='" + orderId + '\'' +
                ", usedNum=" + usedNum +
                ", status='" + status + '\'' +
                ", employeId='" + employeId + '\'' +
                '}';
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getConfirmType() {
        return confirmType;
    }

    public void setConfirmType(String confirmType) {
        this.confirmType = confirmType;
    }
}
