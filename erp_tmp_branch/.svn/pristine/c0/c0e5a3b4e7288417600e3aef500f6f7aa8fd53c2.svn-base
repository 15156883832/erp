package com.jojowonet.modules.finance.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.service.InvoiceAddressService;
import com.jojowonet.modules.finance.service.InvoiceApplicationService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
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
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/1/3.
 * fap申请记录controller
 */
@Controller
@RequestMapping(value = "${adminPath}/finance/invoiceApplication")
public class InvoiceApplicationController extends BaseController{
    @Autowired
    private InvoiceApplicationService invoiceApplicationService;

    @RequestMapping("saveapplication")
    @ResponseBody
    public String saveapplication(String invoicemsgid, String invoiceaddressid, String invoicevalue,
                                  String[] orderids, String[] orderGoodsCate, String invoiceNature, String invoiceTitle,
                                  String invoiceType, String receiverName, String receiverMobile, String receiverAddress, String postcode, String types,String kptype,String[] ordernumbers) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        return invoiceApplicationService.saveInvoiceAppli(invoicemsgid, invoiceaddressid, invoicevalue, orderids, orderGoodsCate, invoiceNature,
                invoiceTitle, invoiceType, receiverName, receiverMobile, receiverAddress, postcode, siteId, userId, types,kptype,ordernumbers);
    }

    @RequestMapping("record")
    public String getrecordlist(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/finance/invoiceApplicationRecord";
    }

    @RequestMapping("allrecord")
    public String getallrecordlist(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        Map <String, Object> namemap = invoiceApplicationService.getreviewmanlist();
        model.addAttribute("headerData", stf);
        model.addAttribute("namemap", namemap);
        return "modules/finance/invoiceApplicationAllrecord";
    }

    //服务商权限的发票记录列表
    @RequestMapping("getlist")
    @ResponseBody
    public String getList(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map <String, Object> map = new TrimMap(getParams(request));
        Page <Record> page = new Page <>(request, response);
        page = invoiceApplicationService.getInvoiceapplilist(page, siteId, map);
        model.addAttribute("page", page);
        JqGridPage <Record> jqp = new JqGridPage <>(page);
        return renderJson(jqp);
    }

    //system权限的发票记录列表
    @RequestMapping("getalllist")
    @ResponseBody
    public String getallList(HttpServletRequest request, HttpServletResponse response, Model model) {
        Map <String, Object> map = new TrimMap(getParams(request));
        Page <Record> page = new Page <>(request, response);
        page = invoiceApplicationService.getInvoiceapplilist(page, null, map);
        model.addAttribute("page", page);
        JqGridPage <Record> jqp = new JqGridPage <>(page);
        return renderJson(jqp);
    }

    //发票的详情查询
    @RequestMapping("getDetaile")
    @ResponseBody
    public Record getrecordbyid(HttpServletRequest request, HttpServletResponse response, String invoiceapplicationid) {
        return invoiceApplicationService.getrecordByid(invoiceapplicationid);
    }

    //发票申请记录的开票操作
    @RequestMapping("kaipiao")
    @ResponseBody
    public String kaipiao(HttpServletRequest request, HttpServletResponse response, String invoiceapplicationid, String kaipiaotime) {
        String userId = UserUtils.getUser().getId();
        return invoiceApplicationService.kaipiao(invoiceapplicationid, kaipiaotime, userId);
    }

    //发票申请记录的审核操作
    @RequestMapping("review")
    @ResponseBody
    public String review(HttpServletRequest request, HttpServletResponse response, String invoiceapplicationid, String flag, String reviewRemark) {
        String userId = UserUtils.getUser().getId();
        return invoiceApplicationService.review(invoiceapplicationid, flag, reviewRemark, userId);
    }

    //发票申请记录的寄件操作
    @RequestMapping("jijian")
    @ResponseBody
    public String jijian(HttpServletRequest request, HttpServletResponse response, String invoiceapplicationid, String logisticsNames, String logisticsNumber) {
        String userId = UserUtils.getUser().getId();
        return invoiceApplicationService.jijian(invoiceapplicationid, logisticsNames, logisticsNumber, userId);
    }

    /**
     * 根据订单编号查询订单详情
     */
    @ResponseBody
    @RequestMapping(value="getOrdersDetail")
    public List<Record> getOrdersDetail(HttpServletRequest request,String orderNumbers){
        return invoiceApplicationService.getOrdersDetail(orderNumbers);
    }

}
