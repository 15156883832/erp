package com.jojowonet.modules.fitting.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * 备件申请计划
 * Created by DQChen on 2018/1/29 0029.
 */
@Entity
@Table(name = "crm_site_fitting_apply_plan")
public class FittingApplyPlan implements Serializable{
    private static final long serialVersionUID = 1L;

    private String id;
    private String status;
    private Date planTime;
    private String planApplicantId;
    private String planApplicant;
    private String marks;
    private Double planNum;
    private String creatorId;
    private String creator;
    private Date createTime;
    private String fittingApplyId;
    private String fittingKeepId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPlanTime() {
        return planTime;
    }

    public void setPlanTime(Date planTime) {
        this.planTime = planTime;
    }

    public String getPlanApplicantId() {
        return planApplicantId;
    }

    public void setPlanApplicantId(String planApplicantId) {
        this.planApplicantId = planApplicantId;
    }

    public String getPlanApplicant() {
        return planApplicant;
    }

    public void setPlanApplicant(String planApplicant) {
        this.planApplicant = planApplicant;
    }

    public String getMarks() {
        return marks;
    }

    public void setMarks(String marks) {
        this.marks = marks;
    }

    public Double getPlanNum() {
        return planNum;
    }

    public void setPlanNum(Double planNum) {
        this.planNum = planNum;
    }

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getFittingApplyId() {
        return fittingApplyId;
    }

    public void setFittingApplyId(String fittingApplyId) {
        this.fittingApplyId = fittingApplyId;
    }

    public String getFittingKeepId() {
        return fittingKeepId;
    }

    public void setFittingKeepId(String fittingKeepId) {
        this.fittingKeepId = fittingKeepId;
    }

    public String getSiteId() {
        return siteId;
    }

    public void setSiteId(String siteId) {
        this.siteId = siteId;
    }

}
