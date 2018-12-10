package com.jojowonet.modules.operate.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;


/**
 * 服务商Entity
 * @author Ivan
 * @version 2016-08-01
 */
@Entity
@Table(name = "crm_user_custom")
public class UserCustom implements Serializable {

	private String id; 		// 编号
	private String userId;
	private String style;
	private Date createTime;

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
