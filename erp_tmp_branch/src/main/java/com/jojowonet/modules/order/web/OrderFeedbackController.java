/**
 */
package com.jojowonet.modules.order.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ivan.common.web.BaseController;
import ivan.common.utils.StringUtils;
import com.jojowonet.modules.order.entity.OrderFeedback;
import com.jojowonet.modules.order.service.OrderFeedbackService;

/**
 * 反馈Controller
 * @author Ivan
 * @version 2017-05-13
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderFeedback")
public class OrderFeedbackController extends BaseController {

	@Autowired
	private OrderFeedbackService orderFeedbackService;
	
	@ModelAttribute
	public OrderFeedback get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return orderFeedbackService.get(id);
		}else{
			return new OrderFeedback();
		}
	}
	

}
