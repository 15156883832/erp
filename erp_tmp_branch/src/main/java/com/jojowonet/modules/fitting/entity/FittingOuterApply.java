/**
 */
package com.jojowonet.modules.fitting.entity;


import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 备件申请Entity
 * @author DQChen
 * @version 2018-01-22
 */
@Entity
@Table(name = "crm_site_fitting_outer_apply")
public class FittingOuterApply implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id; 		// 编号
    private String number;
    private String type;
    private String applySiteId;
    private String targetSiteId;
    private String applicantId;
    private String applicantName;
    private String applicantFeedback;
    private String message;
    private String auditor;
    private String auditorId;
    private String auditMarks;
    private String shipmentName;
    private String shipmentId;
    private String stockingName;
    private String stockingId;
    private String orderNumber;
    private String customerName;
    private String status;
    private String applyFittingId;
    private String shipmentFittingId;
    private String suitMode;
    private String orderId;
    private String applyFittingCode;
    private String applyFittingVersion;
    private String applyFittingBrand;
    private String applyFittingName;
    private String applyFittingType;
    private String applyFittingImg;
    private Double applyFittingNum;
    private Double auditFittingNum;
    private String oldFittingFlag;
    private Date createTime;
    private Date auditTime;
    private Date confirmTime;
    private Date endTime;
    private String creator;
    private Date updateTime;
    private String updateName;
    private String refuseReason;
    private String suitCategory;
    private String customerMobile;
    private String customerAddress;
    private String applianceCategory;
    private String applianceBrand;
    private String warrantyType;
    private String applianceModel;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getApplySiteId() {
        return applySiteId;
    }

    public void setApplySiteId(String applySiteId) {
        this.applySiteId = applySiteId;
    }

    public String getTargetSiteId() {
        return targetSiteId;
    }

    public void setTargetSiteId(String targetSiteId) {
        this.targetSiteId = targetSiteId;
    }

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getApplicantFeedback() {
        return applicantFeedback;
    }

    public void setApplicantFeedback(String applicantFeedback) {
        this.applicantFeedback = applicantFeedback;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getAuditor() {
        return auditor;
    }

    public void setAuditor(String auditor) {
        this.auditor = auditor;
    }

    public String getAuditorId() {
        return auditorId;
    }

    public void setAuditorId(String auditorId) {
        this.auditorId = auditorId;
    }

    public String getAuditMarks() {
        return auditMarks;
    }

    public void setAuditMarks(String auditMarks) {
        this.auditMarks = auditMarks;
    }

    public String getShipmentName() {
        return shipmentName;
    }

    public void setShipmentName(String shipmentName) {
        this.shipmentName = shipmentName;
    }

    public String getShipmentId() {
        return shipmentId;
    }

    public void setShipmentId(String shipmentId) {
        this.shipmentId = shipmentId;
    }

    public String getStockingName() {
        return stockingName;
    }

    public void setStockingName(String stockingName) {
        this.stockingName = stockingName;
    }

    public String getStockingId() {
        return stockingId;
    }

    public void setStockingId(String stockingId) {
        this.stockingId = stockingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getApplyFittingId() {
        return applyFittingId;
    }

    public void setApplyFittingId(String applyFittingId) {
        this.applyFittingId = applyFittingId;
    }

    public String getShipmentFittingId() {
        return shipmentFittingId;
    }

    public void setShipmentFittingId(String shipmentFittingId) {
        this.shipmentFittingId = shipmentFittingId;
    }

    public String getSuitMode() {
        return suitMode;
    }

    public void setSuitMode(String suitMode) {
        this.suitMode = suitMode;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getApplyFittingCode() {
        return applyFittingCode;
    }

    public void setApplyFittingCode(String applyFittingCode) {
        this.applyFittingCode = applyFittingCode;
    }

    public String getApplyFittingVersion() {
        return applyFittingVersion;
    }

    public void setApplyFittingVersion(String applyFittingVersion) {
        this.applyFittingVersion = applyFittingVersion;
    }

    public String getApplyFittingName() {
        return applyFittingName;
    }

    public void setApplyFittingName(String applyFittingName) {
        this.applyFittingName = applyFittingName;
    }

    public String getApplyFittingImg() {
        return applyFittingImg;
    }

    public void setApplyFittingImg(String applyFittingImg) {
        this.applyFittingImg = applyFittingImg;
    }

    public Double getApplyFittingNum() {
        return applyFittingNum;
    }

    public void setApplyFittingNum(Double applyFittingNum) {
        this.applyFittingNum = applyFittingNum;
    }

    public Double getAuditFittingNum() {
        return auditFittingNum;
    }

    public void setAuditFittingNum(Double auditFittingNum) {
        this.auditFittingNum = auditFittingNum;
    }

    public String getOldFittingFlag() {
        return oldFittingFlag;
    }

    public void setOldFittingFlag(String oldFittingFlag) {
        this.oldFittingFlag = oldFittingFlag;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public Date getConfirmTime() {
        return confirmTime;
    }

    public void setConfirmTime(Date confirmTime) {
        this.confirmTime = confirmTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getUpdateName() {
        return updateName;
    }

    public void setUpdateName(String updateName) {
        this.updateName = updateName;
    }

    public String getRefuseReason() {
        return refuseReason;
    }

    public void setRefuseReason(String refuseReason) {
        this.refuseReason = refuseReason;
    }

    public String getSuitCategory() {
        return suitCategory;
    }

    public void setSuitCategory(String suitCategory) {
        this.suitCategory = suitCategory;
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

    public String getApplianceModel() {
        return applianceModel;
    }

    public void setApplianceModel(String applianceModel) {
        this.applianceModel = applianceModel;
    }

    public String getApplyFittingBrand() {
        return applyFittingBrand;
    }

    public void setApplyFittingBrand(String applyFittingBrand) {
        this.applyFittingBrand = applyFittingBrand;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getApplyFittingType() {
        return applyFittingType;
    }

    public void setApplyFittingType(String applyFittingType) {
        this.applyFittingType = applyFittingType;
    }
}


