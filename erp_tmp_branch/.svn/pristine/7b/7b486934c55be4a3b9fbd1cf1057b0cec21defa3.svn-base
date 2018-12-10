package com.jojowonet.modules.order.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.order.entity.OrderEvaluation;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.OrderEvaluationService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 工单Controller
 *
 * @author gaols
 * @version 2017-05-04
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderEvaluation")
public class OrderEvaluationController extends BaseController {
    @Autowired
    private OrderEvaluationService orderEvaluationService;
    @Autowired
    private EmployeService employeService;

    @RequestMapping(value = "headList")
    public String getHeadList(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        model.addAttribute("empList", employeService.getSiteEmployeList(siteId));
        return "modules/order/orderEvaluation";
    }


    @RequestMapping(value = "evaluationList")
    @ResponseBody
    public String evaluationList(HttpServletRequest request, HttpServletResponse response) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map<String, Object> map = new TrimMap(getParams(request));
        Page<Record> page = new Page<>(request, response);
        orderEvaluationService.evaluationList(page, siteId, map);
        return renderJson(new JqGridPage<>(page));
    }


    @RequestMapping(value = "show")
    @ResponseBody
    public OrderEvaluation show(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        return orderEvaluationService.get(id);
    }

}
