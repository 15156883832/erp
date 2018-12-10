package com.jojowonet.modules.finance.entity;

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
 * Created by Administrator on 2017/12/29.
 * 发票寄送地址实体类
 */
@Entity
@Table(name="crm_invoice_address")
//@Cache(usage= CacheConcurrencyStrategy.READ_WRITE)
public class InvoiceAddress  implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id;
    private String siteId;
    private String userId;
    private String receiverName;//收件人姓名
    private String receiverProvince;//收件人省
    private String recevierCity;//市
    private String receiverArea;//区
    private String recevierAddress;//收件人详细地址
    private String postcode;//邮政编码
    private String recevierMobile;
    private String status;
    private Date createTime;
    private Date updateTime;

    public InvoiceAddress() {
        super();
        this.status = "0";
        this.createTime = new Date();
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverProvince() {
        return receiverProvince;
    }

    public void setReceiverProvince(String receiverProvince) {
        this.receiverProvince = receiverProvince;
    }

    public String getRecevierCity() {
        return recevierCity;
    }

    public void setRecevierCity(String recevierCity) {
        this.recevierCity = recevierCity;
    }

    public String getReceiverArea() {
        return receiverArea;
    }

    public void setReceiverArea(String receiverArea) {
        this.receiverArea = receiverArea;
    }

    public String getRecevierAddress() {
        return recevierAddress;
    }

    public void setRecevierAddress(String recevierAddress) {
        this.recevierAddress = recevierAddress;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getRecevierMobile() {
        return recevierMobile;
    }

    public void setRecevierMobile(String recevierMobile) {
        this.recevierMobile = recevierMobile;
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

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
