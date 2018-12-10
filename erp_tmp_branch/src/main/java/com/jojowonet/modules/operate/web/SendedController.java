package com.jojowonet.modules.operate.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SendedSmsService;

import com.jojowonet.modules.order.form.SiteTableHeaderForm;

import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;


@Controller
@RequestMapping(value = "${adminPath}/operate/sendedSms")
public class SendedController extends BaseController {
	@Autowired
	private SendedSmsService sendedService;

	
	@RequestMapping(value={"list",""})
	public String list(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId=CrmUtils.getCurrentSiteId(UserUtils.getUser());
		//String orderId = request.getParameter("orderId");
		String orderNum = request.getParameter("orderNum");
		String target = request.getParameter("target");
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		//List<Record> templatelist=templateSms.getTemplatelist(siteId);
		//model.addAttribute("templatelist", templatelist);
		model.addAttribute("headerData", stf);
		//model.addAttribute("orderId", orderId);
		model.addAttribute("orderNum", orderNum);
		model.addAttribute("target", target);
		return "modules/" + "operate/sendedsmslist";
	}
	//查询出列表
	@RequestMapping(value="sendedSmslist")
	@ResponseBody
	public String sendedSmslist(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId=CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,Object> map = request.getParameterMap();
		Page<Record> page = new Page<>(request, response);
		page = sendedService.getSendedList(page, siteId, map);
		model.addAttribute("page",page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	//导出数据
	@RequestMapping(value="export")
	public String exportfile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String,Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
	        String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
	        String type ="";
	        String str1="";
	        String status="";
	        String str2="";
			List<Record> list =null;
				 list = sendedService.getSendedList(pages, siteId, map).getList();
			 for (Record re : list) {
				 if(re.getStr("type")==null){
					 str1="自定义短信";
						type = str1;
						re.set("type", type);
				 }else{
					switch (re.getStr("type")) {
					case "1":
					str1="自定义短信";
						break;
					case "2":
						str1 = "工单电话无人接听";
						break;
					case "3":
						str1 = "改约";
						break;
					case "4":
						str1 = "缺配件";
						break;
					case "5":
						str1 = "服务后";
						break;
					case "6":
						str1 = "工单上门前";					
						break;
					default:
						str1="自定义短信";		
						break;
					}
					type = str1;
					re.set("type", type);
				}
			 }

				for (Record re : list) {
					 if(re.getStr("type")==null){
						 str1="自定义短信";
							status = str2;
							re.set("status", status);
					 }else{
					switch (re.getStr("status")) {
					case "0":
						str2 = "未发送";
						break;
					case "1":
						str2 = "已发送";
						break;
					case "2":
						str2 = "接收成功";
						break;
					case "3":
						str2 = "接收失败";
						break;
					case "4":
						str2 = "已删除";
						break;

					default:
						str2="未发送";
						break;
					}
					status = str2;
			re.set("status", status);
				
			}
				}
			
			new ExportJqExcel(title+"数据", stf.getTableHeader(), stf.getSortHeader())
				.setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}
	
	

}
