package com.jojowonet.modules.order.entity;


import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class CrmOrderDispatchEmployeRel2017 implements Serializable {
  private static final long serialVersionUID = 1L;
  private String id;
  private String orderId;
  private String dispatchId;
  private String empId;
  private String empName;
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


  public String getEmpId() {
    return empId;
  }

  public void setEmpId(String empId) {
    this.empId = empId;
  }


  public String getEmpName() {
    return empName;
  }

  public void setEmpName(String empName) {
    this.empName = empName;
  }


  public String getSiteId() {
    return siteId;
  }

  public void setSiteId(String siteId) {
    this.siteId = siteId;
  }

}
