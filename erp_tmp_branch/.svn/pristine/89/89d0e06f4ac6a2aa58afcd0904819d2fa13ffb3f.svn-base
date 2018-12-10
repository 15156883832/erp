/**
 */
package com.jojowonet.modules.order.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * 派工Entity
 * @author Ivan
 * @version 2017-05-04
 */
@Entity
@Table(name = "crm_order_parent_callback")
public class OrderParentCallBack implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String orderId;
	private Date createTime;
	private String  createBy;
	private String createName;
	private String  safetyEvaluation;
	private String  serviceAttitude;
	private String  multipleDropin;
	private String  resirveMoneyFlag;
	private Double  resirveMoney;
	private String remarks;
	private String siteId;
	private String parentSiteId;
	private String result;

	public OrderParentCallBack() {
		super();
		this.createTime = new Date();
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

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
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

	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	public String getSafetyEvaluation() {
		return safetyEvaluation;
	}

	public void setSafetyEvaluation(String safetyEvaluation) {
		this.safetyEvaluation = safetyEvaluation;
	}

	public String getServiceAttitude() {
		return serviceAttitude;
	}

	public void setServiceAttitude(String serviceAttitude) {
		this.serviceAttitude = serviceAttitude;
	}

	public String getMultipleDropin() {
		return multipleDropin;
	}

	public void setMultipleDropin(String multipleDropin) {
		this.multipleDropin = multipleDropin;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getParentSiteId() {
		return parentSiteId;
	}

	public void setParentSiteId(String parentSiteId) {
		this.parentSiteId = parentSiteId;
	}

	public Double getResirveMoney() {
		return resirveMoney;
	}

	public void setResirveMoney(Double resirveMoney) {
		this.resirveMoney = resirveMoney;
	}

	public String getResirveMoneyFlag() {
		return resirveMoneyFlag;
	}

	public void setResirveMoneyFlag(String resirveMoneyFlag) {
		this.resirveMoneyFlag = resirveMoneyFlag;
	}
}


