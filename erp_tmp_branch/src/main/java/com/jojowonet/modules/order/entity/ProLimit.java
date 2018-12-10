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
@Table(name = "crm_promise_limit")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProLimit implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private Date create_time;
	private String status;
	private String create_by;
	private int sort;
	
	@Id
	@GeneratedValue(generator = "proLimit-id")
	@GenericGenerator(name = "proLimit-id", strategy = "increment")
	public Integer getId() {
		return id;
	}
	public ProLimit() {
		super();
		this.create_time = new Date();
		this.status = "0";
		this.create_by = "1";
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreate_by() {
		return create_by;
	}
	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}
	@GeneratedValue(generator = "sort_increment")
	@GenericGenerator(name = "sort_increment", strategy = "increment")
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	

}
