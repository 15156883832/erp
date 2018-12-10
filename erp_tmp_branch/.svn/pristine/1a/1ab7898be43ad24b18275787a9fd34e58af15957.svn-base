/**
 */
package com.jojowonet.modules.order.dao;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderSettlement;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Parameter;

/**
 * 派工DAO接口
 * @author Ivan
 * @version 2017-05-04
 */
@Repository
public class OrderSettlementDao extends BaseDao<OrderSettlement> {

	public OrderSettlement getByDispatch(String dispatchId) {
		return getByHql(" from OrderSettlement a where a.dispatchId = :p1 ", new Parameter(dispatchId));
	}

}
