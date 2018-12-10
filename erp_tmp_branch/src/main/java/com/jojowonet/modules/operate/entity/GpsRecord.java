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
 * 用户经纬度记录表Entity
 * @author Ivan
 * @version 2017-6-15
 */
@Entity
@Table(name = "crm_gps_record")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GpsRecord implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id;
	private String siteId;
	private String roleId;
	private String roleType;
	private String roleMobile;
	private String longitude;
	private String latitude;
	private Date createDate;
	
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
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public String getRoleMobile() {
		return roleMobile;
	}
	public void setRoleMobile(String roleMobile) {
		this.roleMobile = roleMobile;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	
	
	

}
