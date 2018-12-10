package com.jojowonet.modules.operate.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * 关系Entity
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_non_serviceman_role_rel")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class NonServicemanRoleRel implements Serializable{
	 
	private static final long serialVersionUID = 1L;
	private String id;
	private String servicemanId;
	private String siteRoleId;
	
	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getServicemanId() {
		return servicemanId;
	}
	public void setServicemanId(String servicemanId) {
		this.servicemanId = servicemanId;
	}
	public String getSiteRoleId() {
		return siteRoleId;
	}
	public void setSiteRoleId(String siteRoleId) {
		this.siteRoleId = siteRoleId;
	}
	
	
}
