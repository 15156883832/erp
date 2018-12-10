/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 类型信息Entity
 * @author Ivan
 * @version 2017-10-25
 */
@Entity
@Table(name = "crm_site_common_setting")
public class SiteCommonSetting implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String siteId; 	// 名称
	private String type; 	// 名称
	private String setValue; 	// 名称
	private String describe; 	// 名称

	public SiteCommonSetting() {
		super();
	}

	public SiteCommonSetting(String id){
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

	@Column(name = "[type]")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	public String getSetValue() {
		return setValue;
	}

	public void setSetValue(String setValue) {
		this.setValue = setValue;
	}

	@Column(name = "[describe]")
	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}
	 
	
}


