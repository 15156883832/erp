/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.drew.lang.annotations.NotNull;

/**
 * 派工Entity
 * @author Ivan
 * @version 2017-05-04
 */
@Entity
@Table(name = "crm_order_dispatch")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderDispatch implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private Order order; 
	private Date dispatchTime; 
	private Date  processTime; 
	private String status; 
	private Date  endTime; 
	private Date  dropInTime; 
	private Date  updateTime; 
	private String updateBy; 
	private String remarks; 
	private String messengerId; 
	private String messengerName; 
	private String employeId;
	private String employeName; 
	private String siteId;
	private String promiseFlag;

	public OrderDispatch() {
		super();
		this.dispatchTime = new Date();
		this.status = "1";
		this.promiseFlag="0";
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
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "order_id")
	@NotFound(action = NotFoundAction.IGNORE)
	@NotNull
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Date getDispatchTime() {
		return dispatchTime;
	}

	public void setDispatchTime(Date dispatchTime) {
		this.dispatchTime = dispatchTime;
	}

	
	
	public String getPromiseFlag() {
		return promiseFlag;
	}

	public void setPromiseFlag(String promiseFlag) {
		this.promiseFlag = promiseFlag;
	}

	public Date getProcessTime() {
		return processTime;
	}

	public void setProcessTime(Date processTime) {
		this.processTime = processTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getDropInTime() {
		return dropInTime;
	}

	public void setDropInTime(Date dropInTime) {
		this.dropInTime = dropInTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getMessengerId() {
		return messengerId;
	}

	public void setMessengerId(String messengerId) {
		this.messengerId = messengerId;
	}

	public String getMessengerName() {
		return messengerName;
	}

	public void setMessengerName(String messengerName) {
		this.messengerName = messengerName;
	}

	public String getEmployeId() {
		return employeId;
	}

	public void setEmployeId(String employeId) {
		this.employeId = employeId;
	}

	public String getEmployeName() {
		return employeName;
	}

	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}


	
}


