package com.jojowonet.modules.order.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "crm_order_callback_2017")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class CrmOrderCallback2017 implements Serializable {
  private static final long serialVersionUID = 1L;
  private String id;
  private String orderId;
  private String dispatchId;
  private Date createTime;
  private String createBy;
  private String createName;
  private String safetyEvaluation;
  private String serviceAttitude;
  private String multipleDropin;
  private String result;
  private String remarks;
  private String siteId;

  @Id
  @GeneratedValue(generator = "idGenerator")
  @GenericGenerator(name ="idGenerator" , strategy ="uuid")
  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }


  public String getOrderId() {
    return orderId;
  }

  public void setOrderId(String orderId) {
    this.orderId = orderId;
  }


  public String getDispatchId() {
    return dispatchId;
  }

  public void setDispatchId(String dispatchId) {
    this.dispatchId = dispatchId;
  }


  public Date getCreateTime() {
    return createTime;
  }

  public void setCreateTime(Date createTime) {
    this.createTime = createTime;
  }


  public String getCreateBy() {
    return createBy;
  }

  public void setCreateBy(String createBy) {
    this.createBy = createBy;
  }


  public String getCreateName() {
    return createName;
  }

  public void setCreateName(String createName) {
    this.createName = createName;
  }


  public String getSafetyEvaluation() {
    return safetyEvaluation;
  }

  public void setSafetyEvaluation(String safetyEvaluation) {
    this.safetyEvaluation = safetyEvaluation;
  }


  public String getServiceAttitude() {
    return serviceAttitude;
  }

  public void setServiceAttitude(String serviceAttitude) {
    this.serviceAttitude = serviceAttitude;
  }


  public String getMultipleDropin() {
    return multipleDropin;
  }

  public void setMultipleDropin(String multipleDropin) {
    this.multipleDropin = multipleDropin;
  }


  public String getResult() {
    return result;
  }

  public void setResult(String result) {
    this.result = result;
  }


  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }


  public String getSiteId() {
    return siteId;
  }

  public void setSiteId(String siteId) {
    this.siteId = siteId;
  }

}
