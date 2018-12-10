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

/**
 * 首页系统公告实体类
 * @author yc
 * @version 2017-06-15
 */

@Entity
@Table(name = "crm_announcement")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Announcement implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private String siteId;
	private String type;//公告类型 1.-10为系统公告 10以后为网点公告
	private String content;
	private Date createTime;
	private String status;//0正常 1删除（默认正常）
	private String title;//公告标题
	
	
	public Announcement() {
		super();
		this.createTime=new Date();
		this.status="0";
	}
	@Id
	@GeneratedValue(generator="idGenerator")
	@GenericGenerator(name="idGenerator", strategy="uuid")
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	

}
