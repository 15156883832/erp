package com.jojowonet.modules.order.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderParentCallBack;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderParentCallBackService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping(value = "${adminPath}/order/orderParentCallback")
public class OrderParentCallbackController extends BaseController {

    @Autowired
    private OrderParentCallBackService orderParentCallBackService;
    @Autowired
    private OrderParentCallBackService orderCallBackService;
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private OrderDispatchService orderDispatchService;

    /**
     *二级网点回访
     */
    @RequestMapping("newSecondCallBack")
    public String newSecondCallBack(HttpServletRequest request, Model model) {
        String orderId = request.getParameter("id");
        Order order = orderDao.get(orderId);
        Record callbacks = orderCallBackService.getCallBackInfo(orderId,order.getSiteId());
        request.setAttribute("cbInfo", callbacks);
        request.setAttribute("order", order);
        String completionResult = orderDispatchService.getCompletionResult(orderId,order.getSiteId());
        if(StringUtil.isNotBlank(completionResult)){
            model.addAttribute("completionResult",completionResult);
        }
        return "modules/order/orderManagement/secondSiteOrder/waitCallBackOrder/callBacksForm";
    }

    @RequestMapping(value = "saveSecCallback")
    @ResponseBody
    public String saveSecCallback(OrderParentCallBack orderCallback, HttpServletRequest request) {
        Map<String, Object> map = getParams(request);
        if(StringUtils.isBlank((CharSequence) map.get("orderId"))){
            return "faile";
        }
        Order order=orderDao.get(map.get("orderId").toString());
        User user = UserUtils.getUser();
        String userName = CrmUtils.getUserXM();
        String userId = UserUtils.getUser().getId();
        String siteId = CrmUtils.getCurrentSiteId(user);
        orderCallback.setCreateBy(userId);
        orderCallback.setCreateName(userName);
        orderCallback.setCreateTime(new Date());
        orderCallback.setParentSiteId(siteId);
        orderCallback.setSiteId(order.getSiteId());
        orderParentCallBackService.saveCallBack(orderCallback, map);
        return "ok";
    }

}
