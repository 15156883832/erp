package com.jojowonet.modules.operate.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.VipSiteExpireService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;
import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by yc on 2017/10/9.
 * 到期会员统计controller
 */

@Controller
@RequestMapping(value = "${adminPath}/operate/VipSiteExpire")
public class VipSiteExpireController extends BaseController{
    @Autowired
    private VipSiteExpireService vipSiteExpireService;
    @RequestMapping(value="ForThreeMon")
    public String ThreeMonlist(HttpServletRequest request, HttpServletResponse response, Model model){
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
                siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/" + "operate/VipSiteExpireThreeMon";
    }

    //查询离到期时间还有三个月的服务商
    @RequestMapping(value="VipThreeMonList")
    @ResponseBody
    public  String VipThreeMonList(HttpServletRequest request, HttpServletResponse response, Model model){
        Page<Record> page = new Page<>(request, response);
        Map<String,Object> map = new TrimMap(getParams(request));
        page = vipSiteExpireService.getVipSite(page,map,"3");
        model.addAttribute("page", page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    @RequestMapping(value="ForOneMon")
    public String OneMonlist(HttpServletRequest request, HttpServletResponse response, Model model){
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
                siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/" + "operate/VipSiteExpireOneMon";
    }

    //查询离到期时间还有一个月的服务商
    @RequestMapping(value="VipOneMonList")
    @ResponseBody
    public  String VipOneMonList(HttpServletRequest request,HttpServletResponse response, Model model){
        Page<Record> page = new Page<>(request, response);
        Map<String,Object> map = new TrimMap(getParams(request));
        page = vipSiteExpireService.getVipSite(page,map,"1");
        model.addAttribute("page", page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    @RequestMapping(value="Atterms")
    public String Atterms(HttpServletRequest request, HttpServletResponse response, Model model){
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
                siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/" + "operate/VipSiteExpireAtterms";
    }

    //查询到期未续费的服务商
    @RequestMapping(value="VipAttermsList")
    @ResponseBody
    public  String VipAttermsList(HttpServletRequest request,HttpServletResponse response, Model model){
        Page<Record> page = new Page<>(request, response);
        Map<String,Object> map = new TrimMap(getParams(request));
        page = vipSiteExpireService.getVipAttermsList(page,map);
        model.addAttribute("page", page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    //导出
    @RequestMapping(value = "export")
    public String exportFile2(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String formPath = request.getParameter("formPath");
            User user = UserUtils.getUser();
            String siteId = CrmUtils.getCurrentSiteId(user);
            Page<Record> pages = new Page<Record>(request, response);
            pages.setPageNo(1);
            pages.setPageSize(10000);
            SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
            String title = stf.getExcelTitle();
            String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            Map<String, Object> ma = new TrimMap(getParams(request));
            JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
            // jarray.remove(0);
            List<Record> list = null;
            if ("三个月".equals(title)) {
                list = vipSiteExpireService.getVipSite(pages,ma,"3").getList();
            } else if("一个月".equals(title)){
                list=vipSiteExpireService.getVipSite(pages,ma,"1").getList();
            }else{
                list=vipSiteExpireService.getVipAttermsList(pages,ma).getList();
            }
            new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader())
                    .setDataList(list).write(request, response, fileName).dispose();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
    }





}
