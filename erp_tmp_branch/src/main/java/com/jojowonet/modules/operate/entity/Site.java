/**
 */
package com.jojowonet.modules.operate.entity;

import ivan.common.entity.mysql.common.User;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.google.common.collect.Lists;


/**
 * 服务商Entity
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_site")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Site implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private User user;
	private String number;
	private String name; 	// 名称
	private String licenseNumber; 
	private String licenseImg;
	private String contacts;    //联系人
	private String email;     
	private String corporator;
	private String province; 
	private String city; 
	private String area;
	private String address; 
	private String lnglat;
	private String category;
	/*private String mode; */
	private String mobile; 
	private String telephone; 
	/*private String description;*/
	/*private String imgs;*/
	private String status; 
	private String checkFlag; 
	private String remarks; 
	private String createBy; 
	private Date createTime; 
	private Date updateTime;
	private Date dueTime;
	private String shareCode;
	private String shareCodeSiteParentId;
	private String level;
	private Integer smsAvailableAmount;
	private String areaManagerId;
	private String repairPhone;
	private String type;
	private String smsSign;
	private String smsPhone;
	
	
	@Transient
	private String createTimeStart;
	
	@Transient
	private String createTimeEnd;


	public Site() {
		super();
		this.createTime = new Date();
	}

	public Site(String id){
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
	 /**
     * @OneToOne：一对一关联
      * cascade：级联,它可以有有五个值可选,分别是：
      * CascadeType.PERSIST：级联新建
      * CascadeType.REMOVE : 级联删除
      * CascadeType.REFRESH：级联刷新
      * CascadeType.MERGE  ： 级联更新
      * CascadeType.ALL    ： 以上全部四项
      * @JoinColumn:主表外键字段
      * cid：Person所映射的表中的一个字段
      */
	@OneToOne(cascade = CascadeType.ALL , optional = false , fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id" , insertable = true , unique = true)
	@NotFound(action = NotFoundAction.IGNORE)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLnglat() {
		return lnglat;
	}

	public void setLnglat(String lnglat) {
		this.lnglat = lnglat;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCheckFlag() {
		return checkFlag;
	}

	public void setCheckFlag(String checkFlag) {
		this.checkFlag = checkFlag;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	
	
	
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	@Transient
	public String getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeStart(String createTimeStart) {
		this.createTimeStart = createTimeStart;
	}

	@Transient
	public String getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(String createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	/** The category id list. */
	private List<Long> categoryIdList = Lists.newArrayList();

	/**
	 * Gets the category id list.
	 *
	 * @return the category id list
	 */
	@Transient
	public List<Long> getCategoryIdList() {
		if (StringUtils.isNotBlank(category)) {
			String[] ids = StringUtils.split(category, ",");
			for (String id : ids) {
				categoryIdList.add(Long.valueOf(id));
			}
		}
		return categoryIdList;
	}

	/**
	 * Sets the category id list.
	 *
	 * @param list the new category id list
	 */
	@Transient
	public void setCategoryIdList(List<Long> list) {
		category = "," + StringUtils.join(list, ",") + ",";
	}

	public Date getDueTime() {
		return dueTime;
	}

	public void setDueTime(Date dueTime) {
		this.dueTime = dueTime;
	}

	public String getShareCode() {
		return shareCode;
	}

	public void setShareCode(String shareCode) {
		this.shareCode = shareCode;
	}

	public String getShareCodeSiteParentId() {
		return shareCodeSiteParentId;
	}

	public void setShareCodeSiteParentId(String shareCodeSiteParentId) {
		this.shareCodeSiteParentId = shareCodeSiteParentId;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public Integer getSmsAvailableAmount() {
		return smsAvailableAmount;
	}

	public void setSmsAvailableAmount(Integer smsAvailableAmount) {
		this.smsAvailableAmount = smsAvailableAmount;
	}

	public String getLicenseNumber() {
		return licenseNumber;
	}

	public void setLicenseNumber(String licenseNumber) {
		this.licenseNumber = licenseNumber;
	}

	public String getLicenseImg() {
		return licenseImg;
	}

	public void setLicenseImg(String licenseImg) {
		this.licenseImg = licenseImg;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCorporator() {
		return corporator;
	}

	public void setCorporator(String corporator) {
		this.corporator = corporator;
	}

	public String getAreaManagerId() {
		return areaManagerId;
	}

	public void setAreaManagerId(String areaManagerId) {
		this.areaManagerId = areaManagerId;
	}

	public String getRepairPhone() {
		return repairPhone;
	}

	public void setRepairPhone(String repairPhone) {
		this.repairPhone = repairPhone;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSmsSign() {
		return smsSign;
	}

	public void setSmsSign(String smsSign) {
		this.smsSign = smsSign;
	}

	public String getSmsPhone() {
		return smsPhone;
	}

	public void setSmsPhone(String smsPhone) {
		this.smsPhone = smsPhone;
	}
	
	
	
	
}
