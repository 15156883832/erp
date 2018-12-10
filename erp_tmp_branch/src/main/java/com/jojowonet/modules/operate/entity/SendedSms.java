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


@Entity
@Table(name = "crm_sended_sms")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SendedSms  implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id;
	private String sendid;//对应短信接口中调用的sendedid
	private String templateId;//短信模板的id
	private String mobile;//短信接收的手机号
	private String content;//短信类容
	private String sign;//短信签名
	private String orderId;//工单id
	private String type;//发送短信类型
	private Date createTime;//创建时间
	private Date sendTime;//发送时间
	private Date receiveTime;//短信接收时间
	private String status;//状态：0 未发送 1已发送 2接收成功 3接收失败 4已删除
	private String createBy;//
	private String  siteId;
	private String createType;
	private String orderNumber;
	private String siteMobile;
	private String extno;//扩展码，对应短信模板的标记tag值，如果是自定义的短信则该值为99
	private Integer smsNum;//使用短信数量
	
	
	public Integer getSmsNum() {
		return smsNum;
	}
	public void setSmsNum(Integer smsNum) {
		this.smsNum = smsNum;
	}
	public SendedSms() {
		super();
		this.createTime=new Date();
		this.status="0";
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	public Date getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	public String getCreateType() {
		return createType;
	}
	public void setCreateType(String createType) {
		this.createType = createType;
	}
	public String getSiteMobile() {
		return siteMobile;
	}
	public void setSiteMobile(String siteMobile) {
		this.siteMobile = siteMobile;
	}
	public String getExtno() {
		return extno;
	}
	public void setExtno(String extno) {
		this.extno = extno;
	}
	public String getSendid() {
		return sendid;
	}
	public void setSendid(String sendid) {
		this.sendid = sendid;
	}


	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
}
