/**
 */
package com.jojowonet.modules.operate.entity;

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
 * 车辆信息Entity
 * @author lzp
 * @version 2018-10-31
 */
@Entity
@Table(name = "crm_site_vehicle")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteVehicle implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String siteId; 		// 编号
	private String plateNumber; 	// 名称
	private Date createTime;
	private String createBy;

	public SiteVehicle() {
		super();
		this.createTime = new Date();
	}

	public SiteVehicle(String id){
		this();
		this.id = id;
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

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
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


