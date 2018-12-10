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
 * Created by yc on 2017/12/25.
 * 流水收支entity
 */

@Entity
@Table(name="crm_site_balance")
//@Cache(usage= CacheConcurrencyStrategy.READ_WRITE)
public class BalanceManager implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id;
    private String siteId;
    private String exacctId;//费用科目
    private String exacctName;//费用科目名
    private String costType;//费用类型
    private BigDecimal  costTotal;//费用总额
    private String billType;//票据类型
    private Integer billAmount;//票据数量
    private String detailContent;//详细类容
    private String costProducer;//费用发生人user_id
    private String costProducerName;//费用发生人姓名
    private Date   occurTime;//发生时间
    private String createBy;//记账人
    private String createByName;//记账人姓名
    private Date createTime;//创建时间
    private String collectionId;//工单收款信息id
    private String createType;//来源类型（默认0新建，1工单收款新增提成）
    private String status;
    private String exacctBrand;
    private String imgs;

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

    public String getExacctId() {
        return exacctId;
    }

    public void setExacctId(String exacctId) {
        this.exacctId = exacctId;
    }

    public String getExacctName() {
        return exacctName;
    }

    public void setExacctName(String exacctName) {
        this.exacctName = exacctName;
    }

    public String getCostType() {
        return costType;
    }

    public void setCostType(String costType) {
        this.costType = costType;
    }

    public BigDecimal getCostTotal() {
        return costTotal;
    }

    public void setCostTotal(BigDecimal costTotal) {
        this.costTotal = costTotal;
    }

    public String getBillType() {
        return billType;
    }

    public void setBillType(String billType) {
        this.billType = billType;
    }

    public Integer getBillAmount() {
        return billAmount;
    }

    public void setBillAmount(Integer billAmount) {
        this.billAmount = billAmount;
    }

    public String getDetailContent() {
        return detailContent;
    }

    public void setDetailContent(String detailContent) {
        this.detailContent = detailContent;
    }

    public String getCostProducer() {
        return costProducer;
    }

    public void setCostProducer(String costProducer) {
        this.costProducer = costProducer;
    }

    public String getCostProducerName() {
        return costProducerName;
    }

    public void setCostProducerName(String costProducerName) {
        this.costProducerName = costProducerName;
    }

    public Date getOccurTime() {
        return occurTime;
    }

    public void setOccurTime(Date occurTime) {
        this.occurTime = occurTime;
    }

   
    public String getCreateByName() {
        return createByName;
    }

    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(String collectionId) {
        this.collectionId = collectionId;
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

	public String getExacctBrand() {
		return exacctBrand;
	}

	public void setExacctBrand(String exacctBrand) {
		this.exacctBrand = exacctBrand;
	}

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }
}

