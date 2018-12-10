/**
 */
package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.entity.CustomerTelephoneIncome;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

/**
 * 用户来电次数记录。
 *
 * @author Gaols
 * @version 2016-08-01
 */
@Repository
public class CustomerTelephoneIncomeDao extends BaseDao<CustomerTelephoneIncome> {

    public Long getIncomingTimes(String siteId, String tel) {
        return Db.queryLong("select count(1) as cnt from crm_customer_telephone_income where site_id=? and telephone=?", siteId, tel);
    }
}
