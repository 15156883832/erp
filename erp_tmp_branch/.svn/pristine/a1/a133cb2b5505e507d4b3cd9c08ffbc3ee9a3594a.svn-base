package com.jojowonet.modules.order.web;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.vo.CrmOrder400Vo;
import com.jojowonet.modules.order.service.ChangeSelfOrderService;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.service.PrintService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.db.DbKey;
import com.jojowonet.modules.sys.util.http.Order400EzTemplate;

import ivan.common.entity.mysql.common.User;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import sun.misc.BASE64Decoder;

@Controller
@RequestMapping(value = "${adminPath}/print")
public class PrintOrderController extends BaseController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private PrintService printService;
	@Autowired
	private SiteService siteService;
	@Autowired
	private ChangeSelfOrderService changeSelfOrderService;
	@Autowired
	private Order400EzTemplate order400EzTemplate;

	
	@RequestMapping(value = "order")
	public String list(Order data, HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		Order order = null;
		User user = UserUtils.getUser();
	    String siteId = CrmUtils.getCurrentSiteId(user);
	    Map<String, Object> params = getParams(request);
	    Object orderObjs = params.get("orderId");
	    Record rd =  new Record();
	    if(orderObjs != null){
	    	String orderIds = String.valueOf(orderObjs);
	    	if(StringUtils.isNotBlank(orderIds) && orderIds.indexOf(",") != -1){	    		
	    		String[] orderArr = orderIds.split(",");
	    	
	    		StringBuilder sb = new StringBuilder("");
	    		sb.append(" SELECT a.service_attitude,c.name as siteName, c.mobile,c.sms_phone, co.* ");
	    		sb.append(" FROM crm_order co LEFT JOIN crm_order_callback a ON a.order_id = co.id ");
	    		sb.append(" LEFT JOIN crm_site c ON c.id = co.site_id ");
	    		sb.append(" WHERE co.id in ("+SqlKit.joinInSql(Arrays.asList(orderArr))+") ");
	    		List<Record> rds = Db.find(sb.toString());
	    		
	    		model.addAttribute("orders", rds);

	    		String numbers="";
	    		for(Record re:rds){
					numbers+=re.getStr("number")+",";
					re.set("createName", CrmUtils.getUserXM(re.getStr("create_by")));
					
				}
				model.addAttribute("numbers", numbers);
				
	    		if("690eacb5cb60c9253ffad7c305f40e40".equals(siteId)){//365特殊处理
	    			return "modules/order/print/sfPrintOrders2";
	    		}else if("ff8080815e99c7d9015ea433f1ad5b52".equals(siteId)) {
	    			return "modules/order/print/sfsitePrintOrders";
	    		}else{
	    			return "modules/order/print/sfPrintOrders";
	    		}
	    	}
	    }
	    
		if(StringUtils.isNotBlank(orderId)){
			order = orderService.get(orderId);
			if(order != null) {
				model.addAttribute("order", order);
			}else {
				Record rdss = orderService.findOrderById(orderId, siteId);
				model.addAttribute("order", new HistoryBkOrder(rdss));
			}
			//查询额外的信息
			StringBuilder sb = new StringBuilder("");
			sb.append(" SELECT a.service_attitude,c.name as siteName, c.mobile,c.sms_phone, d.end_time,d.dispatch_time ");
			sb.append(" FROM crm_order co LEFT JOIN crm_order_callback a ON a.order_id = co.id ");
			sb.append(" left join crm_order_dispatch d on d.order_id = co.id and d.status != '6' and d.status != '3' ");
			sb.append(" LEFT JOIN crm_site c ON c.id = co.site_id ");
			sb.append(" WHERE co.id = '"+orderId+"' ");
			sb.append(" ORDER BY a.create_time DESC  LIMIT 1 ");
			rd = printService.getOrderMsg(orderId);
		}else{
			Site site = siteService.get(siteId);
			rd.set("sms_phone", site.getSmsPhone());
			rd.set("siteName", site.getName());
			data.setSiteName(site.getName());
			model.addAttribute("order", data);
		}
		model.addAttribute("rd", rd);
		//if("40000011111222223333344444555556".equals(siteId)){
		if("690eacb5cb60c9253ffad7c305f40e40".equals(siteId)){
			return "modules/order/print/sfPrint2";
		//}else if("40000011111222223333344444555556".equals(siteId)) {
		}else if("ff8080815e99c7d9015ea433f1ad5b52".equals(siteId)) {
			return "modules/order/print/sfsitePrint";
		}else{
			return "modules/order/print/sfPrint";
		}
	
	}

	@RequestMapping(value = "order400")
	public String list400(Order data, HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Site site = siteService.get(siteId);
		model.addAttribute("site", site);

		String dataUri = request.getParameter("datauri");
		String operType = request.getParameter("operType");
		if("1".equalsIgnoreCase(operType)){
			model.addAttribute("dataUri", dataUri);
			try{
			}catch (Exception e){
				e.printStackTrace();
			}
			return "modules/base/printView3";
		}

		if (StringUtils.isNotBlank(orderId)) {
			String[] orderIds = orderId.split(",");
			if (orderIds.length > 0) {
				List<Record> orders = changeSelfOrderService.getList400SortByCreateTimeDesc(StringUtil.joinInSql(orderIds));
				model.addAttribute("orders", orders);

				String numbers="";
				for(Record re:orders){
					numbers+=re.getStr("number")+",";
				}
				model.addAttribute("numbers", numbers);

				return "modules/order/print/sfPrint400Orders";
//				return "modules/order/print/sfPrint400Orders_bk";
			} else {
				Record rd = changeSelfOrderService.oneDetail(orderId);
				model.addAttribute("order", rd);
				return "modules/order/print/sfPrint400";
			}
		}
		throw new RuntimeException("order id required");
	}




	/**
	 * 打印历史400工单（2017）
	 * @param data
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "order400For2017")
	public String order400For2017(Order data, HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Site site = siteService.get(siteId);
		model.addAttribute("site", site);

		if (StringUtils.isNotBlank(orderId)) {
			String[] orderIds = orderId.split(",");
			if (orderIds.length > 0) {
				Map<String, Object> maps = Maps.newHashMap();
				maps.put("siteId", siteId);
				maps.put("ids", orderId);
				Result<List<CrmOrder400Vo>> result = order400EzTemplate.postForm("/order400/getAll400OldByIds", maps, new ParameterizedTypeReference<Result<List<CrmOrder400Vo>>>() {
				});
				List<Record> orders = Lists.newArrayList();
				for (CrmOrder400Vo v : result.getData()) {
					orders.add(v.asRecord());
				}
				model.addAttribute("orders", orders);

				String numbers="";
				for(Record re:orders){
					numbers+=re.getStr("number")+",";
				}
				model.addAttribute("numbers", numbers);

				return "modules/order/print/sfPrint400OldOrders";
			} else {
				//查询额外的信息
				Map<String, Object> maps = Maps.newHashMap();
				maps.put("siteId", siteId);
				maps.put("ids", orderId);
				Result<List<CrmOrder400Vo>> result = order400EzTemplate.postForm("/order400/getAll400OldByIds", maps, new ParameterizedTypeReference<Result<List<CrmOrder400Vo>>>() {
				});

				model.addAttribute("order", result.getData().get(0).asRecord());
				return "modules/order/print/sfPrintOld400";
			}
		}
		throw new RuntimeException("order id required");
	}

	/**
	 * 工单打印次数
	 */
	@ResponseBody
	@RequestMapping(value="writePrintTimes")
	public void writePrintTimes(HttpServletRequest request){
		String number = request.getParameter("number");
		try {
			Db.update("update crm_order a set a.print_times=a.print_times+1 where a.number=? and a.site_id=? ",number,CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 多次工单打印次数
	 */
	@ResponseBody
	@RequestMapping(value="writeMorePrintTimes")
	public void writeMorePrintTimes(HttpServletRequest request){
		String numbers = request.getParameter("numbers");
		String[] number=numbers.split(",");
		try {
			Db.update("update crm_order a set a.print_times=a.print_times+1 where a.number in ("+StringUtil.joinInSql(number)+") and a.site_id=? ",CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 400工单打印次数
	 */
	@ResponseBody
	@RequestMapping(value="writePrintTimesFor400")
	public void writePrintTimesFor400(HttpServletRequest request){
		String number = request.getParameter("number");
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		params.put("number", number);
		Result<Void> resp = order400EzTemplate.postForm("/order400/writePrintTimesFor400", params, new ParameterizedTypeReference<Result<Void>>() {
		});
		if (!resp.isOk()) {
			logger.error("writePrintTimesFor400 failed");
		}
	}
	/**
	 * 400历史工单打印次数（2017）
	 */
	@ResponseBody
	@RequestMapping(value="writePrintTimesForOld400")
	public void writePrintTimesForOld400(HttpServletRequest request){
		String number = request.getParameter("number");
		try {
			Db.use(DbKey.DB_ORDER_400).update("update crm_order_400_2017 a set a.print_times=a.print_times+1 where a.number=? and a.site_id=? ",number,CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	/**
	 * 400工单批量打印次数
	 */
	@ResponseBody
	@RequestMapping(value="writeMorePrintTimesFor400")
	public void writeMorePrintTimesFor400(HttpServletRequest request){
		String numbers = request.getParameter("numbers");
		Map<String, Object> params = new HashMap<>();
		params.put("siteId", CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		params.put("numbers", numbers);
		Result<Void> resp = order400EzTemplate.postForm("/order400/writeMorePrintTimesFor400", params, new ParameterizedTypeReference<Result<Void>>() {
		});
		if (!resp.isOk()) {
			logger.error("writeMorePrintTimesFor400 failed");
		}
	}
	/**
	 * 400工单批量打印次数
	 */
	@ResponseBody
	@RequestMapping(value="writeMorePrintTimesForOld400")
	public void writeMorePrintTimesForOld400(HttpServletRequest request){
		String numbers = request.getParameter("numbers");
		String[] number=numbers.split(",");
		try {
			Db.use(DbKey.DB_ORDER_400).update("update crm_order_400_2017 a set a.print_times=a.print_times+1 where a.number in ("+StringUtil.joinInSql(number)+") and a.site_id=? ",CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		}catch (Exception e){
			e.printStackTrace();
		}
	}

}
