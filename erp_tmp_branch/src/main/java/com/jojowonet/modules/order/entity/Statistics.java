/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


/**
 * 统计信息Entity
 * @author Ivan
 * @version 2018-01-03
 */
@Entity
@Table(name = "crm_use_statistics")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Statistics implements Serializable  {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String siteId;
	private String loginName;
	private Integer shareNum;
	private Integer employeNum; 
	private Integer staffNum;
	private Integer erpOrderNum; 
	private Integer maOrderNum; 
	private Integer fittingNum;
	private Integer goodsNum;
	private Integer notCoveredCount;
	private Integer notCoveredNum; 
	private Integer receivablesNum; 
	private Integer vcardNum;
	private Integer smsNum;
	private Date purchaseTime;
	private Date promiseTime;
	private String usage; 
	private String shareSite;
	private String followUpMethod; 
	private String followUpDetailed; 
	private String contactResults; 
	private Date updateTime;
	private String contacts; 

	public Statistics() {
		super();
	}

	public Statistics(String id){
		this();
		this.id = id;
	}
	
	
	 public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	public String getUsage() {
		return usage;
	}

	public void setUsage(String usage) {
		this.usage = usage;
	}

	public String getShareSite() {
		return shareSite;
	}

	public void setShareSite(String shareSite) {
		this.shareSite = shareSite;
	}

	public String getFollowUpMethod() {
		return followUpMethod;
	}

	public void setFollowUpMethod(String followUpMethod) {
		this.followUpMethod = followUpMethod;
	}

	public String getFollowUpDetailed() {
		return followUpDetailed;
	}

	public void setFollowUpDetailed(String followUpDetailed) {
		this.followUpDetailed = followUpDetailed;
	}

	public String getContactResults() {
		return contactResults;
	}

	public void setContactResults(String contactResults) {
		this.contactResults = contactResults;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getPurchaseTime() {
		return purchaseTime;
	}

	public void setPurchaseTime(Date purchaseTime) {
		this.purchaseTime = purchaseTime;
	}

	
	public Date getPromiseTime() {
		return promiseTime;
	}

	public void setPromiseTime(Date promiseTime) {
		this.promiseTime = promiseTime;
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

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public Integer getShareNum() {
		return shareNum;
	}

	public void setShareNum(Integer shareNum) {
		this.shareNum = shareNum;
	}

	public Integer getEmployeNum() {
		return employeNum;
	}

	public void setEmployeNum(Integer employeNum) {
		this.employeNum = employeNum;
	}

	public Integer getStaffNum() {
		return staffNum;
	}

	public void setStaffNum(Integer staffNum) {
		this.staffNum = staffNum;
	}

	public Integer getErpOrderNum() {
		return erpOrderNum;
	}

	public void setErpOrderNum(Integer erpOrderNum) {
		this.erpOrderNum = erpOrderNum;
	}

	public Integer getMaOrderNum() {
		return maOrderNum;
	}

	public void setMaOrderNum(Integer maOrderNum) {
		this.maOrderNum = maOrderNum;
	}

	public Integer getFittingNum() {
		return fittingNum;
	}

	public void setFittingNum(Integer fittingNum) {
		this.fittingNum = fittingNum;
	}

	public Integer getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(Integer goodsNum) {
		this.goodsNum = goodsNum;
	}

	public Integer getNotCoveredCount() {
		return notCoveredCount;
	}

	public void setNotCoveredCount(Integer notCoveredCount) {
		this.notCoveredCount = notCoveredCount;
	}

	public Integer getNotCoveredNum() {
		return notCoveredNum;
	}

	public void setNotCoveredNum(Integer notCoveredNum) {
		this.notCoveredNum = notCoveredNum;
	}

	public Integer getReceivablesNum() {
		return receivablesNum;
	}

	public void setReceivablesNum(Integer receivablesNum) {
		this.receivablesNum = receivablesNum;
	}

	public Integer getVcardNum() {
		return vcardNum;
	}

	public void setVcardNum(Integer vcardNum) {
		this.vcardNum = vcardNum;
	}

	public Integer getSmsNum() {
		return smsNum;
	}

	public void setSmsNum(Integer smsNum) {
		this.smsNum = smsNum;
	}
	 
	
	
}


