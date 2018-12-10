/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * 反馈Entity
 * @author Ivan
 * @version 2017-05-13
 */
@Entity
@Table(name = "crm_order_feedback")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderFeedback implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	//private String name; 	// 名称
	private String orderId; 
	private String dispatchId; 
	private Date feedbackTime; 
	private String feedbackId;
	private String feedbackName; 
	private String userType; 
	private String feedback; 
	private String feedbackResult; 
	private String feedbackImg; 
	private String remarks; 
	private String siteId;
	private String feedbackType;//反馈类型
	
	public OrderFeedback() {
		super();
		this.feedbackTime= new Date();
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
	/*public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}*/
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getDispatchId() {
		return dispatchId;
	}
	public void setDispatchId(String dispatchId) {
		this.dispatchId = dispatchId;
	}
	public Date getFeedbackTime() {
		return feedbackTime;
	}
	public void setFeedbackTime(Date feedbackTime) {
		this.feedbackTime = feedbackTime;
	}
	public String getFeedbackId() {
		return feedbackId;
	}
	public void setFeedbackId(String feedbackId) {
		this.feedbackId = feedbackId;
	}
	public String getFeedbackName() {
		return feedbackName;
	}
	public void setFeedbackName(String feedbackName) {
		this.feedbackName = feedbackName;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getFeedback() {
		return feedback;
	}
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	public String getFeedbackResult() {
		return feedbackResult;
	}
	public void setFeedbackResult(String feedbackResult) {
		this.feedbackResult = feedbackResult;
	}
	public String getFeedbackImg() {
		return feedbackImg;
	}
	public void setFeedbackImg(String feedbackImg) {
		this.feedbackImg = feedbackImg;
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
	public String getFeedbackType() {
		return feedbackType;
	}
	public void setFeedbackType(String feedbackType) {
		this.feedbackType = feedbackType;
	}


	
}


