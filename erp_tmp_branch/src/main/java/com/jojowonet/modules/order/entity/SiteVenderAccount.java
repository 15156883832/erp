/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;


/**
 * 厂家账号Entity
 * @author Ivan
 * @version 2016-10-24
 */
@Entity
@Table(name = "crm_site_vender_account")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteVenderAccount implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String venderId; 	// 名称
	private String siteId; 
	private String loginName; 
	private String password; 
	private String status;
	private String name;
	private String link;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public SiteVenderAccount() {
		super();
		this.status="0";
	}

	public SiteVenderAccount(String id){
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

	

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getVenderId() {
		return venderId;
	}

	public void setVenderId(String venderId) {
		this.venderId = venderId;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	 
	
	
}

