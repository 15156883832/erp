package com.jojowonet.modules.order.entity;

import org.hibernate.annotations.*;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2018/1/15.
 * 短信模板创建实体类
 */
@Entity
@Table(name = "crm_site_sms_template")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SmsTemplet implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id;
    private String number;//对应短信接口中的tid
    private String name;
    private String content;
    private Date createTime;
    private String status;
    private String createBy;
    private String createType;//对应user表中的user_type
    private int tag;//标记（通过标记可确定短信模板，用于存储扩展码）
    private String siteId;
    private String reviewsmsStatus;//审核状态（0待审核1审核通过2审核未通过）
    private String failedReason;//审核未通过原因
    private String deleteBy;//删除人
    private Date deleteTime;//删除时间

    public SmsTemplet() {
        super();
        this.status = "0";
        this.createTime = new Date();
        this.tag=0;
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

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateType() {
        return createType;
    }

    public void setCreateType(String createType) {
        this.createType = createType;
    }

    public int getTag() {
        return tag;
    }

    public void setTag(int tag) {
        this.tag = tag;
    }

    public String getSiteId() {
        return siteId;
    }

    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }

    public String getReviewsmsStatus() {
        return reviewsmsStatus;
    }

    public void setReviewsmsStatus(String reviewsmsStatus) {
        this.reviewsmsStatus = reviewsmsStatus;
    }

    public String getFailedReason() {
        return failedReason;
    }

    public void setFailedReason(String failedReason) {
        this.failedReason = failedReason;
    }

    public String getDeleteBy() {
        return deleteBy;
    }

    public void setDeleteBy(String deleteBy) {
        this.deleteBy = deleteBy;
    }

    public Date getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(Date deleteTime) {
        this.deleteTime = deleteTime;
    }
}
