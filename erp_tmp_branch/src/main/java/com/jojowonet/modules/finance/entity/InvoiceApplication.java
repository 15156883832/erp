package com.jojowonet.modules.finance.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2018/1/3.
 * 发票申请记录申请表
 */
@Entity
@Table(name="crm_invoice_application")
//@Cache(usage= CacheConcurrencyStrategy.READ_WRITE)
public class InvoiceApplication  implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String siteId;
    private String userId;
    private String invoicemsgId;//'发票信息表id',
    private String invoiceaddressId;//发票寄送地址表id'
    private BigDecimal invoiceValue;//开票金额
    private String orderIds;//订单的id集合
    private String orderGoodsCate;//订单商品种类集合
    private String invoiceNature;//发票性质0纸质发票
    private String invoiceTitle;//发票抬头
    private String invoiceType;//发票类型（0增值税普通发票1增值税专用发票）
    private String receiverName;//收件人姓名
    private String receiverMobile;//收件人手机号
    private String receiverAddress;//收件人地址
    private String postcode;//邮政编码
    private Date createTime;
    private String reviewStatus;//审核状态（0待开票，1已开票，2审核未通过）
    private Date reviewTime;//审核时间
    private String reviewRemark;//审核备注
    private String reviewMan;//审核人id
    private String status;
    private String logisticsNames;
    private String logisticsNumber;
    private String kpMan;//开票方0思方科技1其他
    private String orderNumbers;//订单编号集合

    public InvoiceApplication() {
        super();
        this.createTime = new Date();
        this.reviewStatus = "3";
        this.status="0";
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

    public String getInvoicemsgId() {
        return invoicemsgId;
    }

    public void setInvoicemsgId(String invoicemsgId) {
        this.invoicemsgId = invoicemsgId;
    }

    public String getInvoiceaddressId() {
        return invoiceaddressId;
    }

    public void setInvoiceaddressId(String invoiceaddressId) {
        this.invoiceaddressId = invoiceaddressId;
    }

    public BigDecimal getInvoiceValue() {
        return invoiceValue;
    }

    public void setInvoiceValue(BigDecimal invoiceValue) {
        this.invoiceValue = invoiceValue;
    }

    public String getOrderIds() {
        return orderIds;
    }

    public void setOrderIds(String orderIds) {
        this.orderIds = orderIds;
    }

    public String getOrderGoodsCate() {
        return orderGoodsCate;
    }

    public void setOrderGoodsCate(String orderGoodsCate) {
        this.orderGoodsCate = orderGoodsCate;
    }

    public String getInvoiceNature() {
        return invoiceNature;
    }

    public void setInvoiceNature(String invoiceNature) {
        this.invoiceNature = invoiceNature;
    }

    public String getInvoiceTitle() {
        return invoiceTitle;
    }

    public void setInvoiceTitle(String invoiceTitle) {
        this.invoiceTitle = invoiceTitle;
    }

    public String getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(String invoiceType) {
        this.invoiceType = invoiceType;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverMobile() {
        return receiverMobile;
    }

    public void setReceiverMobile(String receiverMobile) {
        this.receiverMobile = receiverMobile;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(String reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public Date getReviewTime() {
        return reviewTime;
    }

    public void setReviewTime(Date reviewTime) {
        this.reviewTime = reviewTime;
    }

    public String getReviewRemark() {
        return reviewRemark;
    }

    public void setReviewRemark(String reviewRemark) {
        this.reviewRemark = reviewRemark;
    }

    public String getReviewMan() {
        return reviewMan;
    }

    public void setReviewMan(String reviewMan) {
        this.reviewMan = reviewMan;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLogisticsNames() {
        return logisticsNames;
    }

    public void setLogisticsNames(String logisticsNames) {
        this.logisticsNames = logisticsNames;
    }

    public String getLogisticsNumber() {
        return logisticsNumber;
    }

    public void setLogisticsNumber(String logisticsNumber) {
        this.logisticsNumber = logisticsNumber;
    }

    public String getKpMan() {
        return kpMan;
    }

    public void setKpMan(String kpMan) {
        this.kpMan = kpMan;
    }

    public String getOrderNumbers() {
        return orderNumbers;
    }

    public void setOrderNumbers(String orderNumbers) {
        this.orderNumbers = orderNumbers;
    }
}
