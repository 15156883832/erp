package com.jojowonet.modules.operate.web;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.QRCodeService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.TrimMap;
import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/20 0020.
 */
@Controller
@RequestMapping(value = "${adminPath}/QRCode")
public class QRCodeController extends BaseController {

    @Autowired
    private QRCodeService qrCodeService;

    @RequestMapping(value = "getQRCodeList")
    public String getQRCodeList(HttpServletRequest request, HttpServletRequest reponse, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
                siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        String sql = "select id,name from crm_site where status ='0' order by create_time desc ";
        List<Record> list = Db.find(sql);
        model.addAttribute("serviceList", list);
        return "modules/" + "operate/qrCodeFactory";
    }

    @RequestMapping(value = "getQRCodeValue")
    @ResponseBody
    public String getQRCodeValue(HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Record> page = new Page<>(request, response);
        Map<String, Object> map = new TrimMap(getParams(request));
        page = qrCodeService.getQRCodeList(page, map);
        model.addAttribute("page", page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    @ResponseBody
    @RequestMapping(value = "createQRCodeBySiteId")
    public String createQRCodeBySiteId(HttpServletRequest request, HttpServletResponse response) {
        String siteId = request.getParameter("siteId");
        int num = Integer.parseInt(request.getParameter("num"))*54;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date now = new Date();
        String date = sdf.format(now);//生成时间
        return qrCodeService.createCode(siteId, num, date);
    }

    @ResponseBody
    @RequestMapping(value = "getPage")
    public Integer getPage(HttpServletRequest request, HttpServletResponse response) {
        String siteId = request.getParameter("siteId");
        String sql="select sequence from crm_code where site_id='"+siteId+"' and status in ('0','1') order by sequence desc ";
        Record re = Db.findFirst(sql);
        int leng=0;
        if(re!=null){
            leng=re.getInt("sequence");//最大序号
        }
        return leng;
    }

    @RequestMapping(value = "getQRCodeUsedList")
    public String getQRCodeUsedList(HttpServletRequest request, HttpServletRequest reponse, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
                siteId, request.getServletPath());
        String useType = "select  from crm_order";
        model.addAttribute("headerData", stf);
        return "modules/" + "order/qrCodeUsedList";
    }

    @RequestMapping(value = "getQRCodeUsedValue")
    @ResponseBody
    public String getQRCodeUsedValue(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        String siteId = CrmUtils.getCurrentSiteId(user);
        Page<Record> page = new Page<>(request, response);
        Map<String, Object> map = new TrimMap(getParams(request));
        page = qrCodeService.getQRCodeUsedList(page, map,siteId);
        model.addAttribute("page", page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }


    @RequestMapping(value = "export")
    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String formPath = request.getParameter("formPath");
            User user = UserUtils.getUser();
            String siteId = CrmUtils.getCurrentSiteId(user);
            Map<String, Object> map = new TrimMap(getParams(request));
            SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);

            String title = stf.getExcelTitle();
            String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            Page<Record> pages = new Page<Record>(request, response);
            pages.setPageNo(1);
            pages.setPageSize(10000);
            JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());

            List<Record> list = null;
            list = qrCodeService.getExportData(pages, map,siteId);
            for (Record rd : list) {
                if ("1".equals(rd.getStr("warranty_type"))) {
                    rd.set("warranty_type", "保内");
                } else if ("2".equals(rd.getStr("warranty_type"))) {
                    rd.set("warranty_type", "保外");
                } else {
                    rd.set("warranty_type", "");
                }
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
    @RequestMapping(value = "exportSysFile")
    public String exportSysFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String formPath = request.getParameter("formPath");
            User user = UserUtils.getUser();
            String siteId = CrmUtils.getCurrentSiteId(user);
            Map<String, Object> map = new TrimMap(getParams(request));
            SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);

            String title = stf.getExcelTitle();
            String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            Page<Record> pages = new Page<Record>(request, response);
            pages.setPageNo(1);
            pages.setPageSize(10000);
            JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());

            List<Record> list = null;
            list = qrCodeService.getExportSysData(pages, map);
            for (Record rd : list) {
                String code=rd.get("code");
                String siteID=rd.get("site_id");
                String url="http://www.sifangerp.com/wxweb/toScan?sid="+siteID+"&xcode="+code;
                rd.set("codeU",url);

                if("0".equals(rd.get("status"))){
                    rd.set("status","未使用");
                }else if("1".equals(rd.get("status"))){
                    rd.set("status","已使用");
                }else if("2".equals(rd.get("status"))){
                    rd.set("status","已删除");
                }else{
                    rd.set("status","");
                }

                if("0".equals(rd.getStr("is_print"))){
                    rd.set("is_print","未打印");
                }else if("1".equals(rd.getStr("is_print"))){
                    rd.set("is_print","已打印");
                }else{
                    rd.set("is_print","");
                }
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

    @RequestMapping(value = "toPrintPage")
    public String toPrintPage(HttpServletRequest request, Model model) {
        String str = request.getParameter("str");
        String[] leng = str.split(",");
        String siteId=leng[1];
        int startPage =Integer.parseInt(leng[2]);
        int endPage = Integer.parseInt(leng[3]);
        if(startPage <=endPage){
            int size=(endPage-startPage)+1;

            String sql="select code,sequence from crm_code where site_id='"+siteId+"' and status in('0','1') order by sequence asc limit " + size + " offset "+(startPage-1)+"  ";
            List<Record> relist=Db.find(sql);
            String strs="";
            for(int i=0;i<relist.size();i++){
                if(i==relist.size()-1){
                    strs+=relist.get(i).getStr("code");
                }else{
                    strs+=relist.get(i).getStr("code")+",";
                }
            }

            model.addAttribute("len",size);
            model.addAttribute("pageSize",size/54);
            model.addAttribute("relist", strs);
            model.addAttribute("logo", leng[0]);
            model.addAttribute("siteId", siteId);

            String[] strsa = strs.split(",");
            String sqlsign="update crm_code set is_print='1'  where site_id='"+siteId+"' and code in ("+ StringUtil.joinInSql(strsa)+")  ";
            try{
                Db.update(sqlsign);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        return "modules/" + "operate/printQRCode";
    }

}
