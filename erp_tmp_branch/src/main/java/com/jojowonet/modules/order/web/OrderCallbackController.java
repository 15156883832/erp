package com.jojowonet.modules.order.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderCallBack;
import com.jojowonet.modules.order.service.OrderCallBackService;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderService;
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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "${adminPath}/order/orderCallback")
public class OrderCallbackController extends BaseController {

    @Autowired
    private OrderCallBackService callbackService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderCallBackService orderCallBackService;
    @Autowired
    private OrderDispatchService orderDispatchService;


    @RequestMapping(value = "saveCallback")
    @ResponseBody
    public String saveCallback(OrderCallBack orderCallback, HttpServletRequest request) {
        Map<String, Object> map = getParams(request);
        User user = UserUtils.getUser();
        String userName = CrmUtils.getUserXM();
        String userId = user.getId();
        if(StringUtils.isBlank(orderCallback.getSiteId())) {
        	String siteId = CrmUtils.getCurrentSiteId(user);
        	orderCallback.setSiteId(siteId);
        }
        orderCallback.setCreateBy(userId);
        orderCallback.setCreateName(userName);
        orderCallback.setCreateTime(new Date());
        callbackService.saveCallBack(orderCallback, map);
        return "ok";
    }

    @RequestMapping("new")
    public String form(HttpServletRequest request, Model model) {
        String orderId = request.getParameter("id");
        String siteId = request.getParameter("siteId");
        if(StringUtils.isBlank(siteId)) {
        	siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        }
        String espesially=request.getParameter("espesially");
        if(StringUtils.isNotBlank(espesially)){
        	model.addAttribute("fromHistory","ok");
        }
        Order order = orderService.get(orderId);
        String completionResult = orderDispatchService.getCompletionResult(orderId,siteId);
        if(StringUtil.isNotBlank(completionResult)){
            model.addAttribute("completionResult",completionResult);
        }
        request.setAttribute("order", order);
        request.setAttribute("orderId", orderId);
        Record callbacks = orderCallBackService.getCallBackInfo(orderId, siteId);
        request.setAttribute("cbInfo", callbacks);
        Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);
        request.setAttribute("dispRd", dispRd);
//        List<Record> collectionslist = orderDispatchService.getCollectionlist(orderId,siteId);
        List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(),siteId);
        model.addAttribute("collectionslist",collectionslist);
        return "modules/order/callbacksForm";
    }

}
