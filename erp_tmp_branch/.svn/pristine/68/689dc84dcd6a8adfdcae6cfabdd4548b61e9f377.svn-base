/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;


/**
 * 故障类别Entity
 * @author Ivan
 * @version 2016-08-02
 */
@Entity
@Table(name = "crm_malfunction")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Malfunction implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String category; 
	private String type; 
	private String solution; 
	private Date createTime; 
	private String createBy; 
	private String status;
	private String siteId;
	private String userType;
	private String description; 
	@Transient
	private HashMap<String,List<Malfunction>>  hashmap ;

	public Malfunction() {
		super();
	}

	public Malfunction(String id){
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
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

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public HashMap<String, List<Malfunction>> getHashmap() {
		return hashmap;
	}

	public void setHashmap(HashMap<String, List<Malfunction>> hashmap) {
		this.hashmap = hashmap;
	}
}
