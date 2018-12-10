/**
 */
package com.jojowonet.modules.order.service;

import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.order.entity.OrderFeedback;
import com.jojowonet.modules.order.dao.OrderFeedbackDao;

/**
 * 反馈Service
 * @author Ivan
 * @version 2017-05-13
 */
@Component
@Transactional(readOnly = true)
public class OrderFeedbackService extends BaseService {

	@Autowired
	private OrderFeedbackDao orderFeedbackDao;
	
	public OrderFeedback get(String id) {
		return orderFeedbackDao.get(id);
	}
	
	@Transactional(readOnly = false)
	public void save(OrderFeedback orderFeedback) {
		orderFeedbackDao.save(orderFeedback);
	}
	

}
