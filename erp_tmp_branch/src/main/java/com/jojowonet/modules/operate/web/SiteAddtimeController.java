package com.jojowonet.modules.operate.web;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteManagerService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;


@Controller
@RequestMapping(value = "${adminPath}/operate/SiteAddtime")
public class SiteAddtimeController extends BaseController {
	
    @Autowired
    private SiteManagerService siteManagerService;
    
    
    @RequestMapping(value="siteAddtimeRecord")
    public String siteAddtimeRecord(HttpServletRequest request,HttpServletResponse response, Model model){
    	String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
   	 return "modules/" + "operate/siteAddtimeList";
    }
	
    @RequestMapping(value="siteAddtimeRecordList")
    @ResponseBody
    public  String siteAddtimeRecordList(HttpServletRequest request,
			HttpServletResponse response, Model model){
   	 Page<Record> page = new Page<>(request, response);
   	 Map<String,Object> map = new TrimMap(getParams(request));
		page = siteManagerService.findsitesiteAddTimeRecord(page, map);
		model.addAttribute("page", page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
    }

}
