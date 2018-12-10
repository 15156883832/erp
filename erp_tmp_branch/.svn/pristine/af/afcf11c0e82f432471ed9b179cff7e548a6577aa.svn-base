package com.jojowonet.modules.sys.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author gaols
 */
@Entity
@Table(name = "crm_gift_pack")
public class GiftPack implements Serializable {
    private String id;
    private String idc; // 礼品标识码，类似于礼品类型
    private String name;
    private String description;
    private String takeBy;
    private String takeSiteId;
    private Date createTime;
    private Date takeTime;
    private Date dueTime;
    private Integer num;
    private BigDecimal price;

    public enum IDC {
        VIP("00");

        private final String val;

        IDC(String s) {
            this.val = s;
        }

        public String getVal() {
            return this.val;
        }
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

    public String getIdc() {
        return idc;
    }

    public void setIdc(String idc) {
        this.idc = idc;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTakeBy() {
        return takeBy;
    }

    public void setTakeBy(String takeBy) {
        this.takeBy = takeBy;
    }

    public String getTakeSiteId() {
        return takeSiteId;
    }

    public void setTakeSiteId(String takeSiteId) {
        this.takeSiteId = takeSiteId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getTakeTime() {
        return takeTime;
    }

    public void setTakeTime(Date takeTime) {
        this.takeTime = takeTime;
    }

    public Date getDueTime() {
        return dueTime;
    }

    public void setDueTime(Date dueTime) {
        this.dueTime = dueTime;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
