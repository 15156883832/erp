package com.jojowonet.modules.order.web;

import com.jojowonet.modules.order.entity.OrderSettlement;
import com.jojowonet.modules.order.service.OrderSettlementService;
import com.jojowonet.modules.order.utils.CrmUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 工单结算已经转移到了SiteSettlementController中，不要继续在该controller中做任何关于结算的功能。
 */
@Deprecated
@Controller
@RequestMapping(value = "${adminPath}/order/orderSettlemnt")
public class OrderSettlementController extends BaseController {

    @Autowired
    private OrderSettlementService settlementService;

    @RequestMapping(value = "saveSettlement")
    @ResponseBody
    public String saveSettlement(OrderSettlement orderSettlement, HttpServletRequest request) {
        Map<String, Object> map = getParams(request);
        User user = UserUtils.getUser();
        String userName = user.getLoginName();
        String userId = UserUtils.getUser().getId();
        String siteId = CrmUtils.getCurrentSiteId(user);
        orderSettlement.setCreateBy(userId);
        orderSettlement.setCreateName(userName);
        orderSettlement.setSiteId(siteId);
        settlementService.saveSettlement(orderSettlement, map);
        return "ok";
    }

    @RequestMapping(value = "batchSaveSettlement")
    @ResponseBody
    public String batchSaveSettlement(HttpServletRequest request) {
        Map<String, Object> map = getParams(request);
        User user = UserUtils.getUser();
        String userName = user.getLoginName();
        map.put("userName", userName);
        String userId = UserUtils.getUser().getId();
        map.put("userId", userId);
        String siteId = CrmUtils.getCurrentSiteId(user);
        settlementService.batchSaveSettlement(map, siteId);
        return "ok";
    }

}
