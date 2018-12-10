/**
 */
package com.jojowonet.modules.order.web;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.form.vo.ExtendedCallback;
import com.jojowonet.modules.order.form.vo.ExtendedOrder;
import com.jojowonet.modules.order.service.OrderCallBackService;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderOriginService;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.utils.*;
import com.jojowonet.modules.sys.util.TranslationUtils;
import com.jojowonet.modules.sys.util.TrimMap;
import com.jojowonet.modules.sys.util.http.EzTemplate;
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
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 工单Controller
 * @author DQChen
 * @version 2018-4-11
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderSettlement")
public class OrderSettlementForFactoryController extends BaseController {

	@Autowired
	private EzTemplate ezTemplate;

	@Autowired
	private OrderService orderService;

	@Autowired
	private OrderDispatchService orderDispatchService;

	@Autowired
	private OrderCallBackService orderCallBackService;

	@Autowired
	private OrderOriginService orderOriginServicce;

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private SiteService siteService;


	/**
	 * 待审核结算档案（表头）
	 */
	@RequestMapping(value="getODSMTInWCheckForFacTab")
	public String getODSMTInWCheckForFacTab(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/order/factorySettleOrder/repairOrderWaitCheckRecord";
	}

	/**
	 * 待审核结算档案(数据)
	 */
	@ResponseBody
	@RequestMapping(value ="getODSMTInWCheckForFacList")
	public String getODSMTInWCheckForFacList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String,Object> map = new TrimMap(getParams(request));
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Map<String,Object>> pages = new Page<Map<String,Object>>(request, response);
		map.put("pageNo",pages.getPageNo());
		map.put("pageSize",pages.getPageSize());
		map.put("siteId",siteId);
		Result<Map<String,Object>> listResult = ezTemplate.postForm("/factory/orderSettlement/getAllSettleRecordInWaitCheck", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
		});
		pages.setList((ArrayList)listResult.getData().get("list"));
		pages.setCount((Integer)listResult.getData().get("count"));
		return renderJson(new JqGridPage<>(pages));
	}

	@RequestMapping(value = "export")
	public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId= CrmUtils.getCurrentSiteId(user);
			Map<String,Object> map = new TrimMap(getParams(request));
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());

			List<Record> list =Lists.newArrayList();
			map.put("pageNo",1);
			map.put("pageSize",1000);
			map.put("siteId",siteId);
			List<Map<String,Object>> listResult = ezTemplate.postForm("/factory/orderSettlement/getSettleRecordForExport", map, new ParameterizedTypeReference<List<Map<String,Object>>>() {
			});

			for(Map<String,Object> m:listResult){
				Record rd=new Record();
				rd.setColumns(m);
				if (StringUtils.isNotBlank(rd.getStr("review_status"))) {
					if ("0".equals(rd.getStr("review_status"))) {
						rd.set("review_status", "待审核");
					} else if ("1".equals(rd.getStr("review_status"))) {
						rd.set("review_status", "审核不通过");
					} else if ("2".equals(rd.getStr("review_status"))) {
						rd.set("review_status", "已审核");
					} else if ("3".equals(rd.getStr("review_status"))) {
						rd.set("review_status", "审核不通过");
					} else {
						rd.set("review_status", "");
					}
				}
				list.add(rd);
			}

			new ExportJqExcel(title+"数据",  jarray.toString(), stf.getSortHeader())
					.setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}

	/**
	 * 结算单详情
	 */
	@RequestMapping(value="getSettlementOrderDetail")
	public String getSettlementOrderDetail(HttpServletRequest request,Model model){
//		Record re= Db.findFirst("select * from crm_order where number=?",request.getParameter("number"));
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Order order=orderDao.getOrderByNumber(request.getParameter("number"), siteId);
		String orderId=null;
		if(order!=null){
			orderId=order.getId();
		}else{
			return "false";
		}
//		String siteId = order.getSiteId();
		model.addAttribute("order", order);
		if(StringUtils.isNotBlank(order.getCustomerMobile())){
			model.addAttribute("lenMobile", order.getCustomerMobile().length());//号码长度
		}else{
			model.addAttribute("lenMobile", 0);//号码长度
		}
		if(StringUtils.isNotBlank(order.getBdImgs())){
			String[] bdImgs = order.getBdImgs().split(";");
			model.addAttribute("bdImgs", bdImgs);
		}
		Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
		model.addAttribute("feedbackInfo", feedbackInfo);

		Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);
		model.addAttribute("dispRd", dispRd);
		model.addAttribute("dispStatus", (dispRd == null ? "" : TranslationUtils.translateDispatchOrderStatus(dispRd.getStr("status"))));

		// 回访信息
		Record callbacks = orderCallBackService.getCallBackInfo(orderId, siteId);
		model.addAttribute("cbInfo", callbacks);
		model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
		Long count = Db
				.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '"
						+ orderId + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("number", order.getNumber());
		model.addAttribute("count", count);
		if (dispRd != null) {
			List<Record> disRels = orderDispatchService.getDispatchRels(dispRd.getStr("id"), siteId);
			model.addAttribute("disRels", disRels);
		}

		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		List<String> listOriginlist=new ArrayList<String>();
		for (Record rdss : listOrigin) {
			listOriginlist.add(rdss.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		Record rds = orderDispatchService.getOrderId(orderId, siteId);
		model.addAttribute("disOrder", rds);
		List<String> catelist=new ArrayList<String>();
		for (Record caterd : category) {
			catelist.add(caterd.getStr("name"));
		}
		model.addAttribute("catelist", catelist);
		model.addAttribute("category", category);
		model.addAttribute("order", order);
		model.addAttribute("extendedOrder", new ExtendedOrder(order));
		model.addAttribute("wxgd", "8".equals(order.getStatus()));
		String sql = "SELECT * FROM crm_order_settlement WHERE order_id=? order by create_time desc limit 1";
		Record settlement = Db.findFirst(sql, orderId);
		model.addAttribute("hasSettlement", settlement != null);

		/*结算信息*/
		Record jsSetRd =orderDispatchService.queryLsSet(siteId);
		model.addAttribute("jsSetRd", jsSetRd);
//		List<Record> collectionslist = orderDispatchService.getCollectionlist(orderId,siteId);
		List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
		model.addAttribute("collectionslist",collectionslist);


		if(StringUtils.isNotBlank(order.getEmployeId())){
			Map<String, String> msg2 = orderDispatchService.getEmployeMsg1(order.getEmployeId());
			model.addAttribute("msg1", msg2.get("nameMobile"));
			model.addAttribute("msg2Names", msg2.get("empNames"));
			model.addAttribute("msg2Mobiles", msg2.get("empMobiles"));
		}else{
			model.addAttribute("msg1", "");
			model.addAttribute("msg2Names","" );
			model.addAttribute("msg2Mobiles","" );
		}

		model.addAttribute("dengjiren", order.getXm());
		return "modules/order/factorySettleOrder/orderSettlementDetail";
	}

	/**
	 * 工单结算信息
	 */
	@ResponseBody
	@RequestMapping(value = "showJsMsg")
	public Result<Map<String,Object>> showJsMsg(HttpServletRequest request){
		String number=request.getParameter("number");
		Map<String,Object> map= Maps.newHashMap();
		map.put("number", number);
		return ezTemplate.postForm("/factory/orderSettlement/getSettleDetail", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {});
	}


	/**
	 * 重新提交审核页面
	 */
	@RequestMapping(value="reRepairSubmitPage")
	public String reRepairSubmitPage(HttpServletRequest request,Model model){
//		String number = request.getParameter("number");
		Record re= Db.findFirst("select * from crm_order where number=?",request.getParameter("number"));
		Order order=new Order();
		String orderId=null;
		if(re!=null){
			order=orderDao.getrecord(re);
			orderId=order.getId();
		}

		String siteId = order.getSiteId();
		Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
		Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);

		if(org.apache.commons.lang3.StringUtils.isNotBlank(order.getEmployeId())){
			Map<String, String> msg2 = orderDispatchService.getEmployeMsg1(order.getEmployeId());
			model.addAttribute("msg2Mobiles", msg2.get("empMobiles"));
		}

		Map<String,Object> map=Maps.newHashMap();
		map.put("applianceCategory",order.getApplianceCategory());
		Result<Map<String,Object>> listResult = ezTemplate.postForm("/factory/orderSettlement/getSettlementPara", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {});
        /*结算项列名（表头）*/
		model.addAttribute("settlementTempList",listResult.getData().get("settlementTempList"));
        /*结算项列*/
		model.addAttribute("settTempListMap",listResult.getData().get("settTempListMap"));

		model.addAttribute("order", order);
		model.addAttribute("dispRd", dispRd);
		model.addAttribute("dispStatus", (dispRd == null ? "" : TranslationUtils.translateDispatchOrderStatus(dispRd.getStr("status"))));
		model.addAttribute("feedbackInfo", feedbackInfo);
		model.addAttribute("order", order);
		return "modules/order/factorySettleOrder/reRepairOrderAccountForm";
	}


	/**
	 * 获取结算项
	 */
	@ResponseBody
	@RequestMapping(value="getAllSettleDetail")
	public List<List<Record>> getAllSettleDetail(HttpServletRequest request){
		Map<String,Object> map=Maps.newHashMap();
		String id=request.getParameter("orderId");
		Order order=orderService.get(id);
		map.put("applianceCategory",order.getApplianceCategory());
		Result<Map<String,Object>> listResult = ezTemplate.postForm("/factory/orderSettlement/getSettlementPara", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {});
		return (List)listResult.getData().get("settTempListMap");
	}


	/**
	 * 服务商提交维修单（重新提交）
	 */
	@ResponseBody
	@RequestMapping(value = "reWriteRepairOrder")
	public Result<String> reWriteRepairOrder(HttpServletRequest request){
		Map<String,Object> map=Maps.newHashMap();
		String mainIds=request.getParameter("mainIds");
		String orderId=request.getParameter("orderId");
		Order order=orderDao.get(orderId);
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());

		map.put("mainIds",mainIds);
		map.put("orderId",orderId);
		map.put("siteId",siteId);
		map.put("siteName", siteService.get(siteId).getName());
		map.put("userXM",CrmUtils.getUserXM());
		map.put("userId",UserUtils.getUser().getId());
		map.put("orderNumber",order.getNumber());
		return ezTemplate.postForm("/factory/orderSettlement/reWriteRepairOrder", map, new ParameterizedTypeReference<Result<String>>() {});
	}

}
