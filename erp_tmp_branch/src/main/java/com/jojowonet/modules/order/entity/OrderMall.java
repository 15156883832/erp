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

/**
 * Created by Administrator on 2018/1/25.
 * 购机商场实体类
 */
@Entity
@Table(name = "crm_site_order_mall")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderMall implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id; 		// 编号
    private String mallName; 	// 名称
    private String siteId;
    private Date createTime;
    private String status;
    private Integer sort;
    private Date updateTime;
    private String createBy;

    public OrderMall() {
        super();
        this.createTime = new Date();;
        this.status = "0";
        this.sort=1;
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

    public String getMallName() {
        return mallName;
    }

    public void setMallName(String mallName) {
        this.mallName = mallName;
    }

    public String getSiteId() {
        return siteId;
    }

    public void setSiteId(String siteId) {
        this.siteId = siteId;
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

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
}
