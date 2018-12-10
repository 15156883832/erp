package com.jojowonet.modules.order.web;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderMarkSetting;
import com.jojowonet.modules.order.entity.SiteCommonSetting;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.OrderMarkSettingService;
import com.jojowonet.modules.order.service.SiteCommonSettingService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
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
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 标记工单
 *
 * @author gaols
 * @version 2017-10-10
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderMarkSet")
public class OrderMarkSettingController extends BaseController {

    @Autowired
    private OrderMarkSettingService orderMarkSettingService;
    @Autowired
    private SiteCommonSettingService siteCommonSettingService;

    /*
     * 获取标记工单header
     * */
    @RequestMapping("")
    public String getHeaderList(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/order/settings/ordermark/orderMark";
    }

    /*
     * 获取标记工单列表
     */
    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value = "orderMarkGrid")
    public String getSiteCategoryList(HttpServletRequest request, HttpServletResponse response) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Page<Record> pages = new Page<>(request, response);
        Map<String, Object> map = new TrimMap(request.getParameterMap());
        Page<Record> page = orderMarkSettingService.getOrderMarkList(pages, siteId, map);
        return renderJson(new JqGridPage<>(page));
    }

    @ResponseBody
    @RequestMapping(value = "save")
    public Result<Void> save(HttpServletRequest request, HttpServletResponse response) {
        String[] names = request.getParameterValues("name");
        String[] sorts = request.getParameterValues("sort");
        orderMarkSettingService.saveList(names, sorts);
        return Result.ok();
    }

    @ResponseBody
    @RequestMapping(value = "show")
    public OrderMarkSetting show(HttpServletRequest request, HttpServletResponse response) {
        return orderMarkSettingService.get(request.getParameter("id"));
    }

    @ResponseBody
    @RequestMapping(value = "edit")
    public OrderMarkSetting edit(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String sort = request.getParameter("sort");
        return orderMarkSettingService.edit(id, name, sort);
    }

    @ResponseBody
    @RequestMapping(value = "del")
    public Result<Void> del(HttpServletRequest request, HttpServletResponse response) {
        String[] ids = request.getParameterValues("ids[]");
        orderMarkSettingService.deleteByIds(Arrays.asList(ids));
        return Result.ok();
    }

    @RequestMapping(value = "appSetting")
    public String appSetting(Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        List<Record> listRec = Db.find("select * from crm_site_common_setting a where a.site_id=? and a.type in ('1','3','7','8','9','10','11','12','14') ", siteId);
        String settle = "";
        String settleType = "";
        String goodsPushMoney = "";
        String buildNewOrder = "";
        String showMarkByPh = "";
        String showHistoryOrder = "";
        String fourHistoryOrder = "";
        String showAroundUsers = "";
        String showEmpGoodsBtn = "";
        for (Record re : listRec) {
            if ("1".equals(re.getStr("type"))) {
                settle = re.getStr("set_value");
            } else if ("3".equals(re.getStr("type"))) {
                settleType = re.getStr("set_value");
            } else if ("7".equals(re.getStr("type"))) {
                goodsPushMoney = re.getStr("set_value");
            } else if ("8".equals(re.getStr("type"))) {
                buildNewOrder = re.getStr("set_value");
            } else if ("9".equals(re.getStr("type"))) {
                showMarkByPh = re.getStr("set_value");
            } else if ("10".equals(re.getStr("type"))) {
                showHistoryOrder = re.getStr("set_value");
            } else if ("11".equals(re.getStr("type"))) {
                fourHistoryOrder = re.getStr("set_value");
            } else if("12".equals(re.getStr("type"))){
                showAroundUsers=re.getStr("set_value");
            } else if("14".equals(re.getStr("type"))){
            	showEmpGoodsBtn=re.getStr("set_value");
            }

        }
        model.addAttribute("settle", settle);
        model.addAttribute("settleType", settleType);
        model.addAttribute("goodsPushMoney", goodsPushMoney);
        model.addAttribute("buildNewOrder", buildNewOrder);
        model.addAttribute("showMarkByPh", showMarkByPh);
        model.addAttribute("showHistoryOrder", showHistoryOrder);
        model.addAttribute("fourHistoryOrder", fourHistoryOrder);
        model.addAttribute("showAroundUsers", showAroundUsers);
        model.addAttribute("showEmpGoodsBtn", showEmpGoodsBtn);
        return "modules/order/settings/appSetting";
    }

    @ResponseBody
    @RequestMapping(value = "saveAppSetting")
    public Result<Void> saveAppSetting(HttpServletRequest request) {
        List<SiteCommonSetting> list = Lists.newArrayList();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String sql = "select id from crm_site_common_setting a where a.site_id=? and a.type = ? ";
        for (int i = 0; i < 9; i++) {
            SiteCommonSetting scs = new SiteCommonSetting();
            if (i == 0) {
                Record re1 = Db.findFirst(sql, siteId, "1");
                if (re1 != null) {
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("1");
                scs.setSetValue(request.getParameter("settle"));
            }
            if (i == 1) {
                Record re1 = Db.findFirst(sql, siteId, "3");
                if (re1 != null) {
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("3");
                scs.setSetValue(request.getParameter("settleType"));
            }
            if (i == 2) {
                Record re1 = Db.findFirst(sql, siteId, "7");
                if (re1 != null) {
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("7");
                scs.setSetValue(request.getParameter("goodsPushMoney"));
            }
            if (i == 3) {
                Record re1 = Db.findFirst(sql, siteId, "8");
                if (re1 != null) {
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("8");
                scs.setSetValue(request.getParameter("buildNewOrder"));
            }
            if (i == 4) {
                Record re1 = Db.findFirst(sql, siteId, "9");
                if (re1 != null) {
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("9");
                scs.setSetValue(request.getParameter("showMarkByPh"));
            }
            if (i == 5) {
                Record re1 = Db.findFirst(sql, siteId, "10");
                if(re1!=null){
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("10");
                scs.setSetValue(request.getParameter("showHistoryOrder"));
            }
            if (i == 6) {
                Record re1 = Db.findFirst(sql, siteId, "11");
                if(re1!=null){
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("11");
                scs.setSetValue(request.getParameter("fourHistoryOrder"));
            }
            if(i == 7){
                Record re1 = Db.findFirst(sql, siteId, "12");
                if(re1!=null){
                    scs.setId(re1.getStr("id"));
                }
                scs.setType("12");
                scs.setSetValue(request.getParameter("showAroundUsers"));
            }
            if(i == 8){
            	Record re1 = Db.findFirst(sql, siteId, "14");
            	if(re1!=null){
            		scs.setId(re1.getStr("id"));
            	}
            	scs.setType("14");
            	scs.setSetValue(request.getParameter("showEmpGoodsBtn"));
            }
            scs.setSiteId(siteId);
            list.add(scs);

        }
        siteCommonSettingService.saveAppSettle(list);
        return Result.ok();
    }

}
