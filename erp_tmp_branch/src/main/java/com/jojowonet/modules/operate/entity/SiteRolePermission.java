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
 * 网点角色权限Entity
 * @author dongqing
 *
 */
@Entity
@Table(name = "crm_site_role_permission")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteRolePermission implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String siteId;
	private String permissions;
	private String siteRoleName;
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
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getPermissions() {
		return permissions;
	}
	public void setPermissions(String permissions) {
		this.permissions = permissions;
	}
	public String getSiteRoleName() {
		return siteRoleName;
	}
	public void setSiteRoleName(String siteRoleName) {
		this.siteRoleName = siteRoleName;
	}
	public String getSiteRoleId() {
		return siteRoleId;
	}
	public void setSiteRoleId(String siteRoleId) {
		this.siteRoleId = siteRoleId;
	}
	
	

}
