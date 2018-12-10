package com.jojowonet.modules.goods.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
/**
 * 平台商品与供应商关系Entity
 * @author dongqing
 *
 */
@Entity
@Table(name = "crm_goods_platform_supplier_rel")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsPlatformSupplierRel implements Serializable{

	 
	private static final long serialVersionUID = 1L;
	
	private String goodPlatformId;
	private String supplierId;
	private String goodNumber;
	private String supplierName;
	private String remarks;
	
	@Id
	public String getGoodPlatformId() {
		return goodPlatformId;
	}
	public void setGoodPlatformId(String goodPlatformId) {
		this.goodPlatformId = goodPlatformId;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}
