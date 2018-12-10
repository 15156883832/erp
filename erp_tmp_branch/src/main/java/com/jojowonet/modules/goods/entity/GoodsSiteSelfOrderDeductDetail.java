package com.jojowonet.modules.goods.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 服务商商品订单提成明细表
 * 
 * @author
 * @version
 */
@Entity
@Table(name = "crm_goods_siteself_order_deduct_detail")
// @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GoodsSiteSelfOrderDeductDetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private String siteOrderGoodsDetailId;
	private String siteOrderId;
	private String goodId;
	private String goodNumber;
	private String goodName;
	private BigDecimal salesCommissions;
	private BigDecimal paidCommissions;
	private String salesmanId;
	private String salesman;
	private String salemanType;
	private String status;
	private String siteId;
	private String creator;
	private Date createTime;

	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSiteOrderId() {
		return siteOrderId;
	}

	public void setSiteOrderId(String siteOrderId) {
		this.siteOrderId = siteOrderId;
	}

	public String getGoodNumber() {
		return goodNumber;
	}

	public void setGoodNumber(String goodNumber) {
		this.goodNumber = goodNumber;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	public BigDecimal getSalesCommissions() {
		return salesCommissions;
	}

	public void setSalesCommissions(BigDecimal salesCommissions) {
		this.salesCommissions = salesCommissions;
	}

	public String getSalesmanId() {
		return salesmanId;
	}

	public void setSalesmanId(String salesmanId) {
		this.salesmanId = salesmanId;
	}

	public String getSalesman() {
		return salesman;
	}

	public void setSalesman(String salesman) {
		this.salesman = salesman;
	}

	public String getSalemanType() {
		return salemanType;
	}

	public void setSalemanType(String salemanType) {
		this.salemanType = salemanType;
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

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getSiteOrderGoodsDetailId() {
		return siteOrderGoodsDetailId;
	}

	public void setSiteOrderGoodsDetailId(String siteOrderGoodsDetailId) {
		this.siteOrderGoodsDetailId = siteOrderGoodsDetailId;
	}

	public String getGoodId() {
		return goodId;
	}

	public void setGoodId(String goodId) {
		this.goodId = goodId;
	}

	public BigDecimal getPaidCommissions() {
		return paidCommissions;
	}

	public void setPaidCommissions(BigDecimal paidCommissions) {
		this.paidCommissions = paidCommissions;
	}

}
