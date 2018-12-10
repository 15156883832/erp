package com.jojowonet.modules.fitting.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 工程师备件库存Entity
 * @author Ivan
 * @version 2017-05-23
 */
@Entity
@Table(name = "crm_employe_fitting")
public class EmployeFitting implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String fittingId; 
	private String type; 
	private String suitCategory; 
	private String employeId; 
	private String suitBrand; 
	private String status; 
	private String siteId; 
	private Date createTime;
	private String createBy; 
	private BigDecimal warning;
	private BigDecimal number; 
	private BigDecimal total; 
	private BigDecimal cjnum;
	private Date newestKeepTime;//最新出库时间

	public EmployeFitting() {
		super();
		this.createTime= new Date();
		this.type = "1";
		this.status = "1";
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

	public String getFittingId() {
		return fittingId;
	}

	public void setFittingId(String fittingId) {
		this.fittingId = fittingId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSuitCategory() {
		return suitCategory;
	}

	public void setSuitCategory(String suitCategory) {
		this.suitCategory = suitCategory;
	}

	public String getEmployeId() {
		return employeId;
	}

	public void setEmployeId(String employeId) {
		this.employeId = employeId;
	}

	public String getSuitBrand() {
		return suitBrand;
	}

	public void setSuitBrand(String suitBrand) {
		this.suitBrand = suitBrand;
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

	public BigDecimal getWarning() {
		return warning;
	}

	public void setWarning(BigDecimal warning) {
		this.warning = warning;
	}

	public BigDecimal getNumber() {
		return number;
	}

	public void setNumber(BigDecimal number) {
		this.number = number;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public BigDecimal getCjnum() {
		return cjnum;
	}

	public void setCjnum(BigDecimal cjnum) {
		this.cjnum = cjnum;
	}

	public Date getNewestKeepTime() {return newestKeepTime;}
	public void setNewestKeepTime(Date newestKeepTime) {this.newestKeepTime = newestKeepTime;}

	@Override
	public String toString() {
		return "EmployeFitting{" +
				"id='" + id + '\'' +
				", fittingId='" + fittingId + '\'' +
				", type='" + type + '\'' +
				", suitCategory='" + suitCategory + '\'' +
				", employeId='" + employeId + '\'' +
				", suitBrand='" + suitBrand + '\'' +
				", status='" + status + '\'' +
				", siteId='" + siteId + '\'' +
//				", createTime=" + createTime +
//				", createBy='" + createBy + '\'' +
				", warning=" + warning +
				", number=" + number +
				", total=" + total +
				", cjnum=" + cjnum +
//				", newestKeepTime=" + newestKeepTime +
				'}';
	}
}
