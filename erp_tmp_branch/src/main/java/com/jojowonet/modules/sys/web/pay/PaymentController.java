package com.jojowonet.modules.sys.web.pay;

import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.unipay.UniPayOrderServiceFactory;
import com.jojowonet.modules.unipay.core.TradeStatus;
import com.jojowonet.modules.unipay.core.UnifyOrderService;
import ivan.common.web.BaseController;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("${adminPath}/pay/")
@Controller
public class PaymentController extends BaseController {

    @RequestMapping("cancel")
    @ResponseBody
    public Object cancelOrder(HttpServletRequest request) {
        String payType = request.getParameter("type");
        String outTradeNo = request.getParameter("outTradeNo");
        UnifyOrderService service = UniPayOrderServiceFactory.getUnipayOrderService(payType);
        if (StringUtils.isNotBlank(outTradeNo)) {
            service.cancelOrder(outTradeNo);
        }
        return Result.ok();
    }

    @RequestMapping("status")
    @ResponseBody
    public Object queryOrderStatus(HttpServletRequest request) {
        String payType = request.getParameter("type");
        String outTradeNo = request.getParameter("outTradeNo");
        UnifyOrderService service = UniPayOrderServiceFactory.getUnipayOrderService(payType);
        Map<String, Object> ret = new HashMap<>();
        if (StringUtils.isNotBlank(outTradeNo)) {
            TradeStatus status = service.queryOrderStatus(outTradeNo);
            if (TradeStatus.SUCCESS == status || TradeStatus.FINISHED == status) {
                ret.put("paid", "paid");
            } else {
                ret.put("status", status.toString());
            }
        }
        return ret;
    }
}
