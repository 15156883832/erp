package com.jojowonet.modules.operate.entity;

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
 * 服务商添加时间记录Entity
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_site_addtime_record")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteAddtimeRecord  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String siteId;
	private Integer timeAdd;//添加时长；
	private String addBy;//添加人；
	private Date createTime;//添加时间；
	private Date startTime;//添加起始时间；
	private Date endTime;//添加结束时间;
	
	
	public SiteAddtimeRecord() {
		super();
		this.createTime=new Date();
		this.timeAdd=0;
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
	public Integer getTimeAdd() {
		return timeAdd;
	}
	public void setTimeAdd(Integer timeAdd) {
		this.timeAdd = timeAdd;
	}
	public String getAddBy() {
		return addBy;
	}
	public void setAddBy(String addBy) {
		this.addBy = addBy;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	
	
	

}
