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
 * 来源Entity
 * @author Ivan
 * @version 2017-05-04
 */
@Entity
@Table(name = "crm_site_order_origin")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderOrigin implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String name; 	// 名称
	private String siteId; 
	private Date createTime;
	private String status;
	private String sort;



	public String getSort() {
		return sort;
	}


	public void setSort(String sort) {
		this.sort = sort;
	}


	public OrderOrigin() {
		super();
		this.status = "0";
		this.createTime = new Date();
		this.sort="0";
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
	/*@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "site_id")
	@NotFound(action = NotFoundAction.IGNORE)
	@NotNull*/
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}


