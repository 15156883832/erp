package com.jojowonet.modules.operate.web;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.operate.service.SiteOrderCountService;
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


@Controller
@RequestMapping(value = "${adminPath}/operate/ordercount")
public class SiteOrderCountController  extends BaseController{
	
    @Autowired
    private SiteOrderCountService siteOrderCountService;
	@Autowired
	private SiteMsgService siteMsgService;
    
    @RequestMapping(value={"list",""})
    public String list(HttpServletRequest request,HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> provincelist=siteMsgService.getprovincelist();
		model.addAttribute("listarea", provincelist);
   	 return "modules/" + "operate/siteOrderCountList";
    }
    
    //查询服务商列表
    @RequestMapping(value="ordercountList")
    @ResponseBody
    public  String siteManagerList(HttpServletRequest request,
			HttpServletResponse response, Model model){
   	 Page<Record> page = new Page<>(request, response);
   	 Map<String,Object> map = new TrimMap(getParams(request));
		page = siteOrderCountService.findsiteManager(page, map);

		model.addAttribute("page", page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
    }
    
    @RequestMapping(value = "export2")
    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
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
            Date now = new Date();
            if ("工单统计".equals(title)) {
                list =siteOrderCountService.findsiteManager(pages, ma).getList();
                for (Record rd : list) {
                    if (rd.getDate("due_time") == null||"".equals(rd.getDate("due_time"))) {
                        rd.set("version", "免费版");
                    } else {
                        if (rd.getDate("due_time").getTime() >= now.getTime()) {
                            rd.set("version", "收费版");
                        } else {
                            rd.set("version", "免费版");
                        }
                    }
				}

            } else {


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
