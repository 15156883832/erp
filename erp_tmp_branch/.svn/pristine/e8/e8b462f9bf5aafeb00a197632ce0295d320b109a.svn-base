package com.jojowonet.modules.operate.entity;

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
 * 服务商Entity
 *
 * @author gaols
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_site_reminder")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteReminder implements Serializable {

    private static final long serialVersionUID = 1L;
    private String id;
    private String siteId;
    private Date lastRemindTime;
    private String remindType;
    private Date createTime;

    public String getRemindType() {
        return remindType;
    }

    public void setRemindType(String remindType) {
        this.remindType = remindType;
    }

    public Date getLastRemindTime() {
        return lastRemindTime;
    }

    public void setLastRemindTime(Date lastRemindTime) {
        this.lastRemindTime = lastRemindTime;
    }

    public enum RemindType {
        XuFei("0");

        private String val;

        RemindType(String i) {
            this.val = i;
        }

        public String getVal() {
            return val;
        }
    }

    public enum XuFeiJia {
        FiftyPO(1825), SixtyPO(2190), EightPO(2920); // fifty percent off / sixty percent off / eighty percent off
        private int val;

        XuFeiJia(int i) {
            this.val = i;
        }

        public int getVal() {
            return val;
        }
    }

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
