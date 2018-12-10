/**
 */
package com.jojowonet.modules.operate.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.*;

import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;


/**
 * 二维码Entity
 * @author cdq
 * @version 2017-10-21
 */
@Entity
@Table(name = "crm_code")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Code implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id; 			// 编号
	private int sequence;
	private String code;
	private String siteId;
	private Date createTime;
	private String createBy;
	private Date useTime;
	private String user;
	private String userType;
	private String userId;
	private Date deleteTime;
	private String status;
	private String applianceId;
	private String customerName;
	private String customerMobile;
	private String customerAddress;
	private String applianceCategory;
	private String applianceBrand;
	private String applianceModel;
	private String applianceInvoice;
	private String applianceBarcodeId;
	private String applianceMachineCode;
	private String applianceBuyTime;
	private String sourceType;
	private String source;
	private String isPrint;

	public Code(String id, String code) {
		this.id = id;
		this.code = code;
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

	public Date getUseTime() {
		return useTime;
	}

	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getDeleteTime() {
		return deleteTime;
	}

	public void setDeleteTime(Date deleteTime) {
		this.deleteTime = deleteTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getApplianceId() {
		return applianceId;
	}

	public void setApplianceId(String applianceId) {
		this.applianceId = applianceId;
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

	public String getApplianceModel() {
		return applianceModel;
	}

	public void setApplianceModel(String applianceModel) {
		this.applianceModel = applianceModel;
	}

	public String getApplianceInvoice() {
		return applianceInvoice;
	}

	public void setApplianceInvoice(String applianceInvoice) {
		this.applianceInvoice = applianceInvoice;
	}



	public String getApplianceMachineCode() {
		return applianceMachineCode;
	}

	public void setApplianceMachineCode(String applianceMachineCode) {
		this.applianceMachineCode = applianceMachineCode;
	}



	public String getSourceType() {
		return sourceType;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getApplianceBarcodeId() {
		return applianceBarcodeId;
	}

	public void setApplianceBarcodeId(String applianceBarcodeId) {
		this.applianceBarcodeId = applianceBarcodeId;
	}

	public String getApplianceBuyTime() {
		return applianceBuyTime;
	}

	public void setApplianceBuyTime(String applianceBuyTime) {
		this.applianceBuyTime = applianceBuyTime;
	}

	public int getSequence() {
		return sequence;
	}

	public void setSequence(int sequence) {
		this.sequence = sequence;
	}

	public String getIsPrint() {
		return isPrint;
	}

	public void setIsPrint(String isPrint) {
		this.isPrint = isPrint;
	}
}


