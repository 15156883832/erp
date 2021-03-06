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
 * 结算措施Entity
 * @author Ivan
 * @version 2017-05-26
 */
@Entity
@Table(name = "crm_site_settlement_template")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SettlementTemplate implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String siteId; 
	private String status; 
	private String category; 
	private String warrantyType; 
	private String serviceMeasures; 
	private String chargeName; 
	private String basisType; 
	private Double basisAmount; 
	private Double chargeAmount; 
	private Integer chargeProportion;
	private Date createTime; 
	private String createBy; 
	private Date updateTime;
	

	public SettlementTemplate() {
		super();
		this.basisAmount=0.00;
		this.chargeAmount=0.00;
		this.createTime= new Date();
		this.status="0";
	}

	@Id
	@GeneratedValue(generator="idGenerator")
	@GenericGenerator(name="idGenerator", strategy="uuid")
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


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getWarrantyType() {
		return warrantyType;
	}


	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}


	public String getServiceMeasures() {
		return serviceMeasures;
	}


	public void setServiceMeasures(String serviceMeasures) {
		this.serviceMeasures = serviceMeasures;
	}


	public String getChargeName() {
		return chargeName;
	}


	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}


	public String getBasisType() {
		return basisType;
	}


	public void setBasisType(String basisType) {
		this.basisType = basisType;
	}


	public Double getBasisAmount() {
		return basisAmount;
	}


	public void setBasisAmount(Double basisAmount) {
		this.basisAmount = basisAmount;
	}


	public Double getChargeAmount() {
		return chargeAmount;
	}


	public void setChargeAmount(Double chargeAmount) {
		this.chargeAmount = chargeAmount;
	}


	public Integer getChargeProportion() {
		return chargeProportion;
	}


	public void setChargeProportion(Integer chargeProportion) {
		this.chargeProportion = chargeProportion;
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


	public Date getUpdateTime() {
		return updateTime;
	}


	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	
}
