package com.jojowonet.modules.goods.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by yc on 2017/12/19.
 * 礼包实体类
 */
@Entity
@Table(name = "crm_gift_pack")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GiftPacks implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String name;
    private String description;
    private String idc;        //礼包识别码(表示礼包类型)
    private Date createTime;//礼包发送时间
    private Date takeTime; //礼包领取时间
    private String takeBy; //领取人
    private String takeSiteId;//赠与网点
    private Date dueTime;//礼包失效时间
    private Integer num;//奖励个数
    private BigDecimal price;//礼包价值

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name ="idGenerator" , strategy ="uuid")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getIdc() {
        return idc;
    }

    public void setIdc(String idc) {
        this.idc = idc;
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
