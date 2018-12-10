package com.jojowonet.modules.goods.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
/**
 * 平台商品和服务商关系Entity
 * @author dongqing
 *
 */
@Entity
@Table(name = "crm_goods_platform_site_rel")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsPlatformSiteRel implements Serializable{
 
	private static final long serialVersionUID = 1L;
	
	private String siteId;
	private String platformId;
	private String selfId;
	
	@Id
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getPlatformId() {
		return platformId;
	}
	public void setPlatformId(String platformId) {
		this.platformId = platformId;
	}
	public String getSelfId() {
		return selfId;
	}
	public void setSelfId(String selfId) {
		this.selfId = selfId;
	}

	
}
