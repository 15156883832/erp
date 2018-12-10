/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.Length;


/**
 * 品牌Entity
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_brand")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Brand implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private Integer id; 		// 编号
	private String name; 	// 名称
	private String img;                //品牌图标
	private String vendor;             // 厂商
	private String delFlag;            // 删除标记
	private Date updateTime;           //更新时间
	private String firstLetter;        //品牌名称的首字母，要大写
	private String sort;               //  排序
	@Transient
	private String category;
	@Transient
	private ArrayList<Integer> categorys;

	public Brand() {
		super();
		this.delFlag = "0";
		this.updateTime = new Date();
	}

	public Brand(Integer id){
		this();
		this.id = id;
	}
	
	@Id
	@GeneratedValue(generator = "custom-id")
	@GenericGenerator(name = "custom-id", strategy = "increment")
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true, length = 20)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Length(min=1, max=200)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	@Column(name="first_letter")
	public String getFirstLetter() {
		return firstLetter;
	}

	public void setFirstLetter(String firstLetter) {
		this.firstLetter = firstLetter;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	@Transient
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	@Transient
	public List<Integer> getCategorys() {
		return categorys;
	}

	public void setCategorys(ArrayList<Integer> categorys) {
		this.categorys = categorys;
	}
	
	
}


