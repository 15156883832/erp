package com.jojowonet.modules.operate.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by cdq on 2018/1/15 0015.
 */
@Entity
@Table(name = "crm_site_parent_rel")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteParentRel implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String parentSiteId;//一级网点id
    private String siteId;//二级网点id
    private Date createTime;
    private String createBy;
    private String createName;
    private Date cancelTime;
    private String cancelName;
    private String cancelId;
    private String status;
    private String siteType;

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name ="idGenerator" , strategy ="uuid")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParentSiteId() {
        return parentSiteId;
    }

    public void setParentSiteId(String parentSiteId) {
        this.parentSiteId = parentSiteId;
    }

    public String getSiteId() {
        return siteId;
    }

    
    public String getSiteType() {
		return siteType;
	}

	public void setSiteType(String siteType) {
		this.siteType = siteType;
	}

	public void setSiteId(String siteId) {
        this.siteId = siteId;
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

    public String getCancelName() {
        return cancelName;
    }

    public void setCancelName(String cancelName) {
        this.cancelName = cancelName;
    }

    public String getCancelId() {
        return cancelId;
    }

    public void setCancelId(String cancelId) {
        this.cancelId = cancelId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(Date cancelTime) {
        this.cancelTime = cancelTime;
    }
}
