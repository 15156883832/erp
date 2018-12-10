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
 * 乡镇信息Entity
 * @author Ivan
 * @version 2018-01-20
 */
@Entity
@Table(name = "crm_site_order_township")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Township implements  Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String name; 	// 名称
	private String siteId; 	
	private Date createTime; 	
	private String createBy; 	
	private String status; 	
	private Integer sort; 	

	public Township() {
		super();
		this.status="1";
		this.sort=1;
		this.createTime = new Date();
	}

	public Township(String id){
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	
}


