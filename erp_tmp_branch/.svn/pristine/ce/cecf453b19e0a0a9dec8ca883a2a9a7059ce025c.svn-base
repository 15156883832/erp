/**
 */
package com.jojowonet.modules.order.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 来源Entity
 *
 * @author Ivan
 * @version 2017-05-04
 */
@Entity
@Table(name = "crm_order_evaluation")
public class OrderEvaluation implements Serializable {

    private static final long serialVersionUID = 1L;
    private String id;        // 编号
    private String orderId;    // 名称
    private String serviceEval;
    private String chargeCondition;
    private BigDecimal chargeMoney;
    private String employeId;
    private String code;
    private String sign;
    private String customerId;

    @Id
    @GeneratedValue(generator = "idGenerator")
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getServiceEval() {
        return serviceEval;
    }

    public void setServiceEval(String serviceEval) {
        this.serviceEval = serviceEval;
    }

    public String getChargeCondition() {
        return chargeCondition;
    }

    public void setChargeCondition(String chargeCondition) {
        this.chargeCondition = chargeCondition;
    }

    public BigDecimal getChargeMoney() {
        return chargeMoney;
    }

    public void setChargeMoney(BigDecimal chargeMoney) {
        this.chargeMoney = chargeMoney;
    }

    public String getEmployeId() {
        return employeId;
    }

    public void setEmployeId(String employeId) {
        this.employeId = employeId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }
}
