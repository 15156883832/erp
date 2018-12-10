package com.jojowonet.modules.finance.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.service.ExacctService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
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
 * Created by Administrator on 2017/12/26.
 * 费用科目管理controller
 */
@Controller
@RequestMapping(value = "${adminPath}/finance/exacctManager")
public class ExacctController extends BaseController {
    @Autowired
    private ExacctService exacctService;

    @RequestMapping(value = {"list", ""})
    public String exacctManager(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/finance/exacctList";
    }

    @RequestMapping("getexacctList")
    @ResponseBody
    public String getexacctList(HttpServletRequest request, HttpServletResponse response) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map <String, Object> map = request.getParameterMap();
        Page <Record> page = new Page <>(request, response);
        page = exacctService.getexacctlist(page, siteId, map);
        JqGridPage <Record> jqp = new JqGridPage <>(page);
        return renderJson(jqp);
    }
}
