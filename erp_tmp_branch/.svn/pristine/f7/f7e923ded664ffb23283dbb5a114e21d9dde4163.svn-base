package com.jojowonet.modules.finance.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.FactorySettle;
import com.jojowonet.modules.finance.service.FactorySettleService;
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
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "${adminPath}/finance/factorysettle")
public class FactorySettleController extends BaseController {
    @Autowired
    private FactorySettleService factorySettleService;

    @RequestMapping(value = {"list", ""})
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        List<Record> vendornamelist = factorySettleService.getvendorname();
        model.addAttribute("headerData", stf);
        model.addAttribute("vendornamelist", vendornamelist);
        return "modules/finance/factorySettleList";
    }

    @RequestMapping("factorysettlelist")
    @ResponseBody
    public String smsTemplatelist(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map<String, Object> map = request.getParameterMap();
        Page<Record> page = new Page<>(request, response);
        page = factorySettleService.getfactorysettlelist(page, siteId, map);
        model.addAttribute("page", page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    //添加结算录入
    @RequestMapping("addfactorysettle")
    public void saveFactorySettle(String vendorid, String year, String month, String money, String remark, HttpServletRequest request, HttpServletResponse response) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        FactorySettle factorySettle = new FactorySettle();
        factorySettle.setSiteId(siteId);
        factorySettle.setFactoryId(vendorid);
        factorySettle.setYear(year);
        factorySettle.setMonth(month);
        factorySettle.setMoney(money);
        factorySettle.setRemark(remark);
        factorySettle.setStatus("0");
        factorySettleService.saveFactorySettle(factorySettle);
    }

    //根据id查找结算录入
    @RequestMapping("getfactorysettlebyid")
    @ResponseBody
    public Record FactorySettleById(String id) {
        return factorySettleService.FactorySettleById(id);
    }

    //更新结算录入
    @RequestMapping("updatefactorysettle")
    public void updateFactorySettle(String vendorid, String year, String month, String money, String remark, String id) {
        String userName = UserUtils.getUser().getLoginName();
        factorySettleService.updateFactorySettle(vendorid, year, month, money, userName, remark, id);
    }

    //删除结算录入
    @RequestMapping("deletefactorysettle")
    public void deleteFactorySettle(String[] idArr) {
        for (int i = 0; i < idArr.length; i++) {
            factorySettleService.deleteFactorySettle(idArr[i]);
        }

    }

}
