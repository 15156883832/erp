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
@Table(name="crm_area_manager")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class AreaManager implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	private String phone;
	private String area;//区域
	private String code;//优惠码（唯一，四个数字或者英文字符）
	private Integer discountAmount;//优惠金额
	private String userId;
	private String bankAccount;//银行账号
	private String bankAccountName;//银行账号用户名
	private String bankName;//银行开户行
	private String bankBranch;//开户行支行
	private Date createTime;
	private String status;//状态 0 正常 1 停用
	private String superiorDistrict;//上级区管
	
	public AreaManager(){
		super();
		this.status="0";
		this.createTime=new Date();
		
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getDiscountAmount() {
		return discountAmount;
	}
	public void setDiscountAmount(Integer discountAmount) {
		this.discountAmount = discountAmount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getBankAccountName() {
		return bankAccountName;
	}
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankBranch() {
		return bankBranch;
	}
	public void setBankBranch(String bankBranch) {
		this.bankBranch = bankBranch;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSuperiorDistrict() {
		return superiorDistrict;
	}
	public void setSuperiorDistrict(String superiorDistrict) {
		this.superiorDistrict = superiorDistrict;
	}
	
	
	

}