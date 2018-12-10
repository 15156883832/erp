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
 * 配送信息Entity
 * @author lzp
 * @version 2018-10-31
 */
@Entity
@Table(name = "crm_order_distribution")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Distribution implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String siteId; 
	private String orderId; 
	private String driverId; 
	private String driverName; 
	private String vehicleId; 
	private String plateNumber; 
	private String distributionNumber; 
	private Date distributionTime; 
	private Date createTime; 
	private String createBy;

	public Distribution() {
		super();
		this.createTime = new Date();
	}

	public Distribution(String id){
		this();
		this.id = id;
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

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	

	public String getDriverId() {
		return driverId;
	}

	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public String getVehicleId() {
		return vehicleId;
	}

	public void setVehicleId(String vehicleId) {
		this.vehicleId = vehicleId;
	}

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public String getDistributionNumber() {
		return distributionNumber;
	}

	public void setDistributionNumber(String distributionNumber) {
		this.distributionNumber = distributionNumber;
	}

	public Date getDistributionTime() {
		return distributionTime;
	}

	public void setDistributionTime(Date distributionTime) {
		this.distributionTime = distributionTime;
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
	
}


