package com.jojowonet.modules.finance.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.dao.RevenueDao;
import com.jojowonet.modules.finance.form.OrderExcel;
import com.jojowonet.modules.finance.service.FinanceOrderExcelService;
import com.jojowonet.modules.finance.service.RevenueService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportExcel;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
/*
 * 财务报表Controller
 * */
@Controller
@RequestMapping(value = "${adminPath}/finance/financeOrderExcel")
public class FinanceOrderExcelController extends BaseController {
	
	@Autowired
	private RevenueService revenueService;
	
	@Autowired
	private RevenueDao revenueDao;

	@Autowired
	private FinanceOrderExcelService financeOrderExcelService;
	//@ResponseBody
	@RequestMapping(value="headerList")
	public String getFinanceOrderExcelList(HttpServletRequest request,HttpServletResponse response, Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> placingNameList = financeOrderExcelService.getPlacingNameList(siteId);
		//List<Record> allList = financeOrderExcelService.getAllList(siteId);
		String[] str = new String[placingNameList.size()];
		if(placingNameList.size()>0){
			for(int i=0;i<placingNameList.size();i++){
				str[i] = placingNameList.get(i).getStr("placing_name");
			}
		}
		model.addAttribute("placingNameList", str);
		return "modules/finance/financeOrderExcel";
	}
	
	/*
	 * 获取商品报表列表
	 * */
	@ResponseBody
	@RequestMapping(value = "financeOrderExcelGrid")
	public  String financeOrderExcelGrid(HttpServletRequest request,HttpServletResponse response){
	    String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	    Map<String,Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request,response);
		Page<Record> page = financeOrderExcelService.financeOrderExcelGrid(pages,siteId,map);
		return renderJson(new JqGridPage<>(page));
	}
	
	@ResponseBody
	@RequestMapping(value = "getRecord")
	public Record getRecord(String placingName){
		return revenueService.queryById(placingName);
	}
	
	@ResponseBody
	@RequestMapping(value = "loadList")
	public List<Map<String, Object>> loadList(String placingName,String poTime,String poTime1,HttpServletRequest request,HttpServletResponse response){
//		Map<String,Object> map = new HashMap<String, Object>();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Map<String, Object>> list = financeOrderExcelService.getAllList(siteId,placingName,poTime,poTime1);
		return list;
	}
	
	/*
	 * 工单报表
	 * */
	@RequestMapping(value = "orderHeaderList")
	public  String orderHeaderList(HttpServletRequest request,HttpServletResponse response,Model model){
	    String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	    List<Record> employeList = financeOrderExcelService.getEmployeList(siteId);//获取服务工程师列表
	    String[] str = new String[employeList.size()];
		if(employeList.size()>0){
			for(int i=0;i<employeList.size();i++){
				str[i] = employeList.get(i).getStr("name");
			}
		}
		String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
		model.addAttribute("repairTimeMin", createT+"-01");	
		model.addAttribute("repairTimeMax", DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
	    model.addAttribute("employeList", str);
		return "modules/finance/financeOrderGrid";
	}
	

	@ResponseBody
	@RequestMapping(value = "loadOrderList")
	public Map<String,Object> loadOrderList(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String, Object>(); 
		Map<String,Object> map1 = getParams(request);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String migration = "";
		Long orderCount = (long)0;
		BigDecimal confirmMoney = new BigDecimal(0);
		Long yjsOrderCount = (long)0;
		BigDecimal sumMoney = new BigDecimal(0);
		
		Result rt = revenueDao.checkYears(map1);
		if("200".equals(rt.getCode())){
			migration = rt.getData().toString();
			orderCount = financeOrderExcelService.orderCount(siteId,map1,migration);//工单总数
			confirmMoney = financeOrderExcelService.confirmMoney(siteId,map1,migration);//实收金额
			yjsOrderCount = financeOrderExcelService.yjsOrderCount(siteId,map1,migration);//已结算工单
			sumMoney = financeOrderExcelService.sumMoney(siteId,map1,migration);//结算金额
		}
		map.put("orderCount", orderCount);
		map.put("confirmMoney", confirmMoney);
		map.put("yjsOrderCount", yjsOrderCount);
		map.put("sumMoney", sumMoney);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "employeOrderDetail")
	public Map<String,Object> employeOrderDetail(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,Object> map = new HashMap<String, Object>(); 
		Map<String,Object> map1 = request.getParameterMap();
		List<Record> records = financeOrderExcelService.employeOrderDetailList(siteId,map1);
		Long yjsOrderCount = new Long(0) ;//已结算工单数
		Long wjsOrderCount = new Long(0) ;//未结算工单数
		BigDecimal jsMoenyAll = new BigDecimal("0") ;//结算金额
		if(records.size()>0){
			for(Record rd : records){
				if(rd.getLong("yjs")!=null){
					yjsOrderCount = yjsOrderCount + rd.getLong("yjs");
				}
				if(rd.getLong("wjs")!=null){
					wjsOrderCount = wjsOrderCount + rd.getLong("wjs");
				}
				if(rd.getBigDecimal("tatol")!=null){
					jsMoenyAll = jsMoenyAll.add(rd.getBigDecimal("tatol"));
				}
			}
		}
		map.put("list", records);
		map.put("yjsOrderCount", yjsOrderCount);
		map.put("wjsOrderCount", wjsOrderCount);
		map.put("jsMoenyAll", jsMoenyAll);
		return map;
	}
	
		//导出
		@RequestMapping(value="export")
		public String exportFile(OrderExcel orderExcel,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
			try {
		        String fileName = "工单结算报表"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
		        User user = UserUtils.getUser();
				String siteId= CrmUtils.getCurrentSiteId(user);
		        Map<String,Object> map = request.getParameterMap();
		        List<Record> list = financeOrderExcelService.employeOrderDetailList(siteId,map);
		        List<OrderExcel> list1 = new ArrayList<>();
		        if(list.size()>0){
			        for(Record rd : list){
			        	OrderExcel oe = new OrderExcel();
			        	oe.setName(rd.getStr("name"));
			        	oe.setYjs(rd.getLong("yjs"));
			        	oe.setWjs(rd.getLong("wjs"));
			        	oe.setTatol(rd.getBigDecimal("tatol"));
			        	list1.add(oe);
			        }
		        }
				new ExportExcel("工单结算报表", OrderExcel.class)
		                     .setDataList(list1)
		                     .write(response, fileName)
		                     .dispose();
				return null;
			} catch (Exception e) {
				addMessage(redirectAttributes,"导出工单报表失败！失败信息："+e.getMessage());
			}
			return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
		}
	
}
