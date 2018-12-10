package com.jojowonet.modules.finance.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.InvoiceMsg;
import com.jojowonet.modules.finance.service.InvoiceAddressService;
import com.jojowonet.modules.finance.service.InvoiceMsgService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.TrimMap;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/1/2.
 * 发票信息维护controller
 */

@Controller
@RequestMapping(value = "${adminPath}/finance/invoiceMsg")
public class InvoiceMsgManager extends BaseController {

    @Autowired
    private InvoiceMsgService invoiceMsgService;
    @Autowired
    private InvoiceAddressService invoiceAddressService;
    @Autowired
    private SiteMsgService siteMsgService;

    @RequestMapping(value = "invoiceManager")
    public String goodsIndex(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        Record invoiceMsg = invoiceMsgService.getInvoiceMsg(siteId, userId);
        Record invoiceAddress = invoiceAddressService.getInvoiceAddress(siteId, userId);
        if (invoiceMsg != null) {
            if (StringUtil.isNotBlank(invoiceMsg.getStr("id"))) {
                model.addAttribute("invoiceMsg", invoiceMsg);
            }
        }
        if (invoiceAddress != null) {
            if (StringUtil.isNotBlank(invoiceAddress.getStr("id"))) {
                model.addAttribute("invoiceAddress", invoiceAddress);
            }
        }

        return "modules/finance/invoiceManager";
    }
//跳转到发票信息修改添加页面
    @RequestMapping("toform")
    public String toform(HttpServletRequest request, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        Record invoiceMsg = invoiceMsgService.getInvoiceMsg(siteId, userId);
        if (invoiceMsg != null) {
            if (StringUtil.isNotBlank(invoiceMsg.getStr("id"))) {
                model.addAttribute("invoiceMsg", invoiceMsg);
            }
        }
        return "modules/finance/invoiceMsgform";
    }
    //跳转到发票寄送地址修改添加页面
    @RequestMapping("tofromAddress")
    public String tofromAddress(HttpServletRequest request, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        Record rd=siteMsgService.getSiteId(siteId);
        Record invoiceAddress = invoiceAddressService.getInvoiceAddress(siteId, userId);
        if (invoiceAddress != null) {
            if (StringUtil.isNotBlank(invoiceAddress.getStr("id"))) {
                model.addAttribute("invoiceAddress", invoiceAddress);
            }
        }

        if(rd!=null){
            model.addAttribute("site",rd);
        }
        List <Record> provincelist = siteMsgService.getprovincelist();
        List <Record> districts = new ArrayList <>();
        List <Record> cities = new ArrayList <>();
        if (invoiceAddress != null) {
            if (StringUtil.isNotBlank(invoiceAddress.getStr("receiver_province"))) {
                cities = siteMsgService.getCitiesByProvince(invoiceAddress.getStr("receiver_province"));
            } else {
                    cities = siteMsgService.getCitiesByProvince("北京市");
            }
        } else {
            if(StringUtil.isNotBlank(rd.getStr("province"))){
                cities = siteMsgService.getCitiesByProvince(rd.getStr("province"));
            }else{
                cities = siteMsgService.getCitiesByProvince("北京市");
            }
        }
        if (invoiceAddress != null) {
            if (StringUtil.isNotBlank(invoiceAddress.getStr("recevier_city"))) {
                districts = siteMsgService.getDistrinctsProvince(invoiceAddress.getStr("recevier_city"));
            } else {
                    districts = siteMsgService.getDistrinctsProvince("北京市");
            }
        } else {
            if (StringUtil.isNotBlank(rd.getStr("city"))) {
                districts = siteMsgService.getDistrinctsProvince(rd.getStr("city"));
            } else {
                districts = siteMsgService.getDistrinctsProvince("北京市");
            }
        }
        model.addAttribute("cities", cities);
        model.addAttribute("provincelist", provincelist);
        model.addAttribute("districts", districts);
        return "modules/finance/invoiceAddressform";
    }
    //保存发票信息
    @RequestMapping("saveinvoiceMsg")
    @ResponseBody
    public String saveinvoiceMsg(HttpServletRequest request, Model model) {
        Map <String, Object> map = request.getParameterMap();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        String data = invoiceMsgService.saveInvoiceMsg(siteId, userId, map);
        return data;
    }
    //保存寄送地址信息
    @RequestMapping("saveinvoiceAddress")
    @ResponseBody
    public String saveinvoiceAddress(HttpServletRequest request, Model model) {
        Map <String, Object> map = request.getParameterMap();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        String data = invoiceAddressService.saveInvoiceAddress(siteId, userId, map);
        return data;
    }
}
