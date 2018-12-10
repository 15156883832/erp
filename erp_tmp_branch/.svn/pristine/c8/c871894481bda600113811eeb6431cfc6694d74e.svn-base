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


@Entity
@Table(name="crm_unit")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class Unit implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;//单位名称
	private String type;//单位类型i整数，d实数
	private String status;
	private Date createTime;
	private String createBy;
	
	
	
	public Unit() {
		super();
		this.status="0";
		this.createTime=new Date();
	}
	
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
