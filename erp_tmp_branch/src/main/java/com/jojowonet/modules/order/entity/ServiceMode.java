package com.jojowonet.modules.order.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="crm_service_mode")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class ServiceMode {
	
	private Integer id;
	
	private String name;
	
	private Date create_time;
	
	private String status;
	
	private String create_by;
	
	private Integer sort;
	
	private String siteId;
	
	private String parentId;
	private String isDefault;

	@Id
	@GeneratedValue(generator="idincrement")
	@GenericGenerator(name="idincrement",strategy="increment")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public ServiceMode() {
		super();
		this.create_time = new Date();
		this.status = "0";
		this.create_by="1";
		this.sort=1;
		this.isDefault ="0";
	}
	

}
