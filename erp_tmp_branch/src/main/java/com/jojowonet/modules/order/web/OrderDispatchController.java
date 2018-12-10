package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.service.FittingService;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.dao.CrmOrder400Dao;
import com.jojowonet.modules.order.dao.CustomerTypeDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderDispatch;
import com.jojowonet.modules.order.entity.SettlementTemplate;
import com.jojowonet.modules.order.form.GenerationOrderFrom;
import com.jojowonet.modules.order.form.vo.ExtendedCallback;
import com.jojowonet.modules.order.form.vo.ExtendedOrder;
import com.jojowonet.modules.order.service.ChangeSelfOrderService;
import com.jojowonet.modules.order.service.OrderCallBackService;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderMallService;
import com.jojowonet.modules.order.service.OrderMustFillSettingService;
import com.jojowonet.modules.order.service.OrderOriginService;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.service.SettlementTemplateService;
import com.jojowonet.modules.order.service.SiteAlarmService;
import com.jojowonet.modules.order.service.SiteSettlementService;
import com.jojowonet.modules.order.service.SmsTempletService;
import com.jojowonet.modules.order.utils.BrandUtils;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.MsgModelUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.RegexUtil;
import com.jojowonet.modules.sys.util.TranslationUtils;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.mapper.JsonMapper;
import ivan.common.persistence.Page;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import net.sf.json.JSONObject;

/**
 * 派工Controller
 * 
 * @author Ivan
 * @version 2017-05-04
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderDispatch")
public class OrderDispatchController extends BaseController {

	private static Logger logger = Logger.getLogger(OrderDispatchController.class);

	@Autowired
	private OrderDispatchService orderDispatchService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderCallBackService orderCallBackService;
	@Autowired
	private OrderOriginService orderOriginServicce;
	@Autowired
	private SettlementTemplateService setService;
	@Autowired
	EmployeService employeService;
	@Autowired
	FittingService fittingService;
	@Autowired
	ChangeSelfOrderService changeSelfOrderService;
	@Autowired
	private SmsTempletService smsTempletService;
	@Autowired
	private OrderMustFillSettingService orderMustFillSettingService;

	@Autowired
	private OrderMallService orderMallService;
	@Autowired
	private SiteAlarmService siteAlarmService;

	@Autowired
	private CrmOrder400Dao order400Dao;
	@Autowired
	private SiteService siteService;
	@Autowired
	private SiteSettlementService settlementService;

	@ModelAttribute
	public OrderDispatch get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderDispatchService.get(id);
		} else {
			return new OrderDispatch();
		}
	}

	@RequestMapping(value = { "list", "" })
	public String list(OrderDispatch orderDispatch, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()) {
			// orderDispatch.setCreateBy(user);
		}
		Page<OrderDispatch> page = orderDispatchService.find(new Page<OrderDispatch>(request, response), orderDispatch);
		model.addAttribute("page", page);
		return "modules/" + "order/orderDispatchList";
	}

	// 待派工工单详情
	@RequestMapping(value = "form")
	public String form(HttpServletRequest request, Model model) {
		String orderId = request.getParameter("id");
		Order order = orderService.get(orderId);
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Long count = orderDispatchService.formCount(orderId, siteId);
		Record rd = orderDispatchService.getSiteMsg(siteId);
		if (rd == null) {
			logger.error("site not found: sid=" + siteId);
		}
		String name = rd.getStr("sms_sign");
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String siteArea = rd.getStr("area");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		Integer repairImgsCount = 0;
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] bdImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("bdImgs", bdImgs);
			model.addAttribute("repairImgs", bdImgs);
			repairImgsCount = bdImgs.length;
		}
		model.addAttribute("repairImgsCount", repairImgsCount);
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteName", siteName);
		setSmsEmployeInfo(model, order);
		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel(order.getStatus());
		model.addAttribute("listModel", listModel);
		// 自定义模板获取
		List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
		model.addAttribute("definedmodel", definedmodel);

		model.addAttribute("number", order.getNumber());
		model.addAttribute("count", count);
		List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		List<String> brandlist = new ArrayList<>();
		brandlist.addAll(brand.values());
		List<String> catelist = new ArrayList<>();
		for (Record caterd : category) {
			catelist.add(caterd.getStr("name"));
		}
		model.addAttribute("catelist", catelist);
		model.addAttribute("brandlist", brandlist);
		model.addAttribute("category", category);
		model.addAttribute("order", order);
		// 信息来源
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rdss : listOrigin) {
			listOriginlist.add(rdss.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		// 时间要求
		List<Record> list = orderDispatchService.getAllProLimit(new ArrayList<Record>());
		List<String> listStr = Lists.newArrayList();
		for (Record aList : list) {
			listStr.add(aList.getStr("name"));
		}
		model.addAttribute("proLimitList", listStr);

		// 自定义用户类型
		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
		/* 必填设置 */
		Record mustfill = orderMustFillSettingService.getMustFillInfoRecord(siteId);
		model.addAttribute("mustfill", mustfill);

		List<Record> malllist = orderMallService.getlistRecordWithNameOnly(siteId);
		model.addAttribute("malllist", malllist);

		Site site = siteService.get(siteId);
		Map<String, Object> mapAddr = CrmUtils.getProCityArea(site, order);
		model.addAttribute("provincelist", mapAddr.get("provincelist"));
		model.addAttribute("cities", mapAddr.get("cities"));
		model.addAttribute("districts", mapAddr.get("districts"));
		model.addAttribute("site", site);

		return "modules/" + "order/orderDispatchForm";
	}

	@ResponseBody
	@RequestMapping(value = "getHrefAjax")
	public String getHrefAjax(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		return CrmUtils.getShortUrl(longUrl).replace("\n", "");
	}

	@ResponseBody
	@RequestMapping(value = "getCodeShowPopup")
	public Map<String, Object> getCodeShowPopup(HttpServletRequest request) {
		String id = request.getParameter("id");
		Order order = orderService.get(id);
		// 判断条码是否有历史工单
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		return orderDispatchService.checkIfHasSameCode(siteId, order);
	}

	@ResponseBody
	@RequestMapping(value = "getCodeShowPopupNew")
	public Map<String, Object> getCodeShowPopupNew(HttpServletRequest request) {
		String id = request.getParameter("id");
		Order order = orderService.get(id);
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		return orderDispatchService.checkIfHasSameCode(siteId, order);
	}

	private Boolean changeFrom(String op) {
		return "0".equals(op);
	}

	// 服务中工单详情
	@RequestMapping(value = "duringform")
	public String OrderDuringform(HttpServletRequest request, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);

		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		Map<String, Object> mapDt = getParams(request);
		String orderId = request.getParameter("id");
		Order order = orderService.get(orderId);
		String orderAddress = org.apache.commons.lang3.StringUtils.defaultString(order.getCustomerAddress(), "").replaceAll("\n", "");
		model.addAttribute("orderAddress", orderAddress);
		order.setCustomerAddress(orderAddress);
		Record rds = orderDispatchService.getOrderId(orderId, order.getSiteId());
		model.addAttribute("disOrder", rds);
		Record rd = orderDispatchService.getSiteMsg(siteId);
		String name = rd.getStr("sms_sign");
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String siteArea = rd.getStr("area");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] bdImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("bdImgs", bdImgs);
		}
		Record rdetail = orderDispatchService.feedBackDuringDetail(siteId, orderId);
		Integer duringFeedImgsCount = 0;
		if (rdetail != null) {
			model.addAttribute("duringFeedImgs", rdetail.getStr("feedback_img"));
			if (StringUtils.isNotBlank(rdetail.getStr("feedback_img"))) {
				model.addAttribute("duringFeedImgsArr", rdetail.getStr("feedback_img").split(","));
				duringFeedImgsCount = rdetail.getStr("feedback_img").split(",").length;
			}
		}
		model.addAttribute("duringFeedImgsCount", duringFeedImgsCount);
		model.addAttribute("mapDt", mapDt);
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("siteName", siteName);
		setSmsEmployeInfo(model, order);
		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel(order.getStatus());
		model.addAttribute("listModel", listModel);

		// 自定义模板获取
		List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
		model.addAttribute("definedmodel", definedmodel);

		String odStatus = (rds == null ? "" : rds.getStr("status"));
		model.addAttribute("dispStatus", (rds == null ? "" : TranslationUtils.translateDispatchOrderStatus(odStatus)));
		// 反馈信息
		Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
		model.addAttribute("feedbackInfo", feedbackInfo);
		model.addAttribute("order", order);
		model.addAttribute("odStatus", odStatus);

		Long count1 = orderService.getPjMsg1(orderId, siteId);
		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + orderId + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("number", order.getNumber());
		model.addAttribute("count", count);
		model.addAttribute("count1", count1);
		List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		List<String> brandlist = new ArrayList<>();
		brandlist.addAll(brand.values());
		List<String> catelist = new ArrayList<>();
		for (Record caterd : category) {
			catelist.add(caterd.getStr("name"));
		}
		model.addAttribute("catelist", catelist);
		model.addAttribute("brandlist", brandlist);
		model.addAttribute("category", category);
		model.addAttribute("order", order);
		if (StringUtils.isNotBlank(order.getEmployeId())) {
			Map<String, Object> empmap = getOrderEmpMobiles(order.getEmployeId());

			model.addAttribute("empMobile", org.apache.commons.lang3.StringUtils.join(empmap.get("empmos"), ","));
			model.addAttribute("mapempMo", empmap.get("mobiles"));
		}
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rdss : listOrigin) {
			listOriginlist.add(rdss.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);

		// 时间要求
		List<Record> list = orderDispatchService.getAllProLimit(new ArrayList<Record>());
		List<String> listStr = Lists.newArrayList();
		for (Record aList : list) {
			listStr.add(aList.getStr("name"));
		}
		model.addAttribute("proLimitList", listStr);
		// List<Record> collectionslist =
		// orderDispatchService.getCollectionlist(orderId,siteId);
		List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
		model.addAttribute("collectionslist", collectionslist);
		// 自定义用户类型
		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
		/* 必填设置 */
		model.addAttribute("mustfill", orderMustFillSettingService.getMustFillInfoRecord(siteId));
		model.addAttribute("malllist", orderMallService.getlistRecordWithNameOnly(siteId));

		Site site = siteService.get(siteId);
		Map<String, Object> mapAddr = CrmUtils.getProCityArea(site, order);
		model.addAttribute("provincelist", mapAddr.get("provincelist"));
		model.addAttribute("cities", mapAddr.get("cities"));
		model.addAttribute("districts", mapAddr.get("districts"));
		model.addAttribute("site", site);
		// 报修图片
		Integer repairImgsCount = 0;
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] repairImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("repairImgs", repairImgs);
			repairImgsCount = repairImgs.length;
		}
		model.addAttribute("repairImgsCount", repairImgsCount);
		return "modules/order/orderManagement/during/orderDuringForm";
	}

	// 回访结算工单详情
	@RequestMapping(value = "jiesuanform")
	public String jiesuanform(HttpServletRequest request, Model model) {
		String orderId = request.getParameter("id");
		Order order = orderService.get(orderId);
		order.setCustomerName(RegexUtil.NEW_LINE.matcher(order.getCustomerName()).replaceAll(""));
		String siteId = order.getSiteId();
		model.addAttribute("siteId", siteId);
		Record rdetail = orderDispatchService.feedBackDetail(siteId, orderId);
		if (rdetail != null) {
			model.addAttribute("feedBackDetail", orderDispatchService.feedBackDetail(siteId, orderId));
			String feedBImgs = orderDispatchService.feedBackDetail(siteId, orderId).getStr("feedback_img");
			if (StringUtils.isNotBlank(feedBImgs)) {
				model.addAttribute("feedImgs", feedBImgs.split(","));
				model.addAttribute("feedImgsCount", feedBImgs.split(",").length);
			} else {
				model.addAttribute("feedImgs", "");
				model.addAttribute("feedImgsCount", 0);
			}
		} else {
			model.addAttribute("feedBackDetail", "");
		}
		Record rd = orderDispatchService.getSiteMsg(siteId);
		String name = rd.getStr("sms_sign");
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] bdImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("bdImgs", bdImgs);
		}
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteName", siteName);

		/* 结算条件设置query */
		Record jsSetRd = orderDispatchService.queryLsSet(siteId);
		model.addAttribute("jsSetRd", jsSetRd);

		setSmsEmployeInfo(model, order);
		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel(order.getStatus());
		model.addAttribute("listModel", listModel);

		// 自定义模板获取
		List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
		model.addAttribute("definedmodel", definedmodel);

		model.addAttribute("order", order);
		Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
		model.addAttribute("feedbackInfo", feedbackInfo);

		Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);
		model.addAttribute("dispRd", dispRd);
		model.addAttribute("dispStatus", (dispRd == null ? "" : TranslationUtils.translateDispatchOrderStatus(dispRd.getStr("status"))));

		// 回访信息
		Record callbacks = orderCallBackService.getCallBackInfo(orderId, siteId);
		model.addAttribute("cbInfo", callbacks);
		model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
		if (callbacks != null) {
			Record reBa = Db.findFirst("SELECT a.`name` FROM crm_non_serviceman a  WHERE a.status='0' AND a.user_id ='" + callbacks.get("create_by") + "' ");
			if (reBa != null) {
				model.addAttribute("userLogna", reBa.get("name"));
			} else {
				String createBy = callbacks.getStr("create_by");
				String username = StringUtil.isBlank(createBy) ? "" : SiteDao.getNameByUserId(createBy);
				model.addAttribute("userLogna", username);
			}
		}

		List<Record> disRels = null;
		if (dispRd != null) {
			disRels = orderDispatchService.getDispatchRels(dispRd.getStr("id"), siteId);
		}

		model.addAttribute("disRels", disRels);
		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + orderId + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("number", order.getNumber());
		model.addAttribute("count", count);
		List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
		Record rds = orderDispatchService.getOrderId(orderId, order.getSiteId());
		model.addAttribute("disOrder", rds);
		List<String> catelist = new ArrayList<String>();
		for (Record caterd : category) {
			catelist.add(caterd.getStr("name"));
		}
		model.addAttribute("catelist", catelist);
		model.addAttribute("category", category);
		model.addAttribute("order", order);
		String orderAddress = org.apache.commons.lang3.StringUtils.defaultString(order.getCustomerAddress(), "").replaceAll("\n", "");
		model.addAttribute("orderAddress", orderAddress);
		order.setCustomerAddress(orderAddress);

		// ---------------------------
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		List<String> brandlist = new ArrayList<String>();
		brandlist.addAll(brand.values());
		model.addAttribute("brandlist", brandlist);
		model.addAttribute("order", order);

		List<String> listStr = Lists.newArrayList();
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rdss : listOrigin) {
			listOriginlist.add(rdss.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);

		// 时间要求
		List<Record> list = orderDispatchService.getAllProLimit(new ArrayList<Record>());
		for (Record aList : list) {
			listStr.add(aList.getStr("name"));
		}
		model.addAttribute("proLimitList", listStr);

		// 结算措施
		List<SettlementTemplate> listsetTem = setService.getListSet(order.getApplianceCategory(), siteId);
		model.addAttribute("listsetTem", listsetTem);

		model.addAttribute("extendedOrder", new ExtendedOrder(order));

		// 服务工程师
		if (StringUtils.isNotBlank(order.getEmployeName())) {
			String[] emplName = order.getEmployeName().split(",");
			List<Record> listemp = new ArrayList<Record>();
			for (int i = 0; i < emplName.length; i++) {
				Record r = new Record();
				r.set("name", emplName[i]);
				listemp.add(r);
			}
			model.addAttribute("emName", listemp);
		}
		List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
		model.addAttribute("collectionslist", collectionslist);
		// 自定义用户类型
		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
		/* 必填设置 */
		model.addAttribute("mustfill", orderMustFillSettingService.getMustFillInfoRecord(siteId));
		model.addAttribute("malllist", orderMallService.getlistRecordWithNameOnly(siteId));

		Site site = siteService.get(siteId);
		Map<String, Object> mapAddr = CrmUtils.getProCityArea(site, order);
		model.addAttribute("provincelist", mapAddr.get("provincelist"));
		model.addAttribute("cities", mapAddr.get("cities"));
		model.addAttribute("districts", mapAddr.get("districts"));
		model.addAttribute("site", site);
		model.addAttribute("userType", UserUtils.getUser().getUserType());
		// 报修图片
		Integer repairImgsCount = 0;
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] repairImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("repairImgs", repairImgs);
			repairImgsCount = repairImgs.length;
		}
		model.addAttribute("repairImgsCount", repairImgsCount);

		return "modules/order/orderManagement/jiesuan/orderdhfForm";
	}

	// 历史工单详情
	@RequestMapping(value = "historyform")
	public String historyform(HttpServletRequest request, Model model) {
		String orderId = request.getParameter("id");
		Order order = orderService.get(orderId);
		String siteId = order.getSiteId();
		model.addAttribute("order", order);
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] bdImgs = order.getBdImgs().split("[,;]");
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
		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + orderId + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("number", order.getNumber());
		model.addAttribute("count", count);
		if (dispRd != null) {
			List<Record> disRels = orderDispatchService.getDispatchRels(dispRd.getStr("id"), siteId);
			model.addAttribute("disRels", disRels);
		}
		// 自定义用户类型
		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rdss : listOrigin) {
			listOriginlist.add(rdss.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
		Record rds = orderDispatchService.getOrderId(orderId, siteId);
		model.addAttribute("disOrder", rds);
		List<String> catelist = new ArrayList<String>();
		for (Record caterd : category) {
			catelist.add(caterd.getStr("name"));
		}
		model.addAttribute("catelist", catelist);
		model.addAttribute("category", category);
		model.addAttribute("order", order);
		model.addAttribute("extendedOrder", new ExtendedOrder(order));
		model.addAttribute("wxgd", "8".equals(order.getStatus()));
		// 历史工单结算

		String sql = "SELECT * FROM crm_order_settlement WHERE order_id=? order by create_time desc limit 1";
		Record settlement = Db.findFirst(sql, orderId);
		model.addAttribute("hasSettlement", settlement != null);
		/* 结算条件设置query */
		Record jsSetRd = orderDispatchService.queryLsSet(siteId);
		model.addAttribute("jsSetRd", jsSetRd);
		List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
		model.addAttribute("collectionslist", collectionslist);
		setSmsEmployeInfo(model, order);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		List<String> brandlist = new ArrayList<String>();
		brandlist.addAll(brand.values());
		model.addAttribute("brandlist", brandlist);

		List<String> listStr = Lists.newArrayList();
		// 时间要求
		List<Record> list = orderDispatchService.getAllProLimit(new ArrayList<Record>());
		for (Record aList : list) {
			listStr.add(aList.getStr("name"));
		}
		model.addAttribute("proLimitList", listStr);

		/* 必填设置 */
		model.addAttribute("mustfill", orderMustFillSettingService.getMustFillInfoRecord(siteId));
		model.addAttribute("malllist", orderMallService.getlistRecordWithNameOnly(siteId));

		Site site = siteService.get(siteId);
		Map<String, Object> mapAddr = CrmUtils.getProCityArea(site, order);
		model.addAttribute("provincelist", mapAddr.get("provincelist"));
		model.addAttribute("cities", mapAddr.get("cities"));
		model.addAttribute("districts", mapAddr.get("districts"));
		model.addAttribute("site", site);
		// 报修图片
		Integer repairImgsCount = 0;
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] repairImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("repairImgs", repairImgs);
			repairImgsCount = repairImgs.length;
		}
		model.addAttribute("repairImgsCount", repairImgsCount);
		return "modules/order/orderManagement/history/orderhistoryForm";
	}

	// 全部工单详情
	@RequestMapping(value = "Wholeform")
	public String Wholeform(HttpServletRequest request, Model model) {
		try {
			String whereMark = request.getParameter("whereMark");
			Map<String, Object> map = getParams(request);
			String orderId = request.getParameter("id");
			Order order = orderService.get(orderId);
			if (order == null) {

				return "redirect:" + Global.getAdminPath() + "/order2017/orderDispatch/order2017form?id=" + orderId;
			}
			if (StringUtils.isNotBlank(order.getBdImgs())) {
				String[] bdImgs = order.getBdImgs().split("[,;]");
				model.addAttribute("bdImgs", bdImgs);
			}
			if (order.getCustomerName() != null) {
				order.setCustomerName(RegexUtil.NEW_LINE.matcher(order.getCustomerName()).replaceAll(""));
			}
			String siteId = order.getSiteId();
			model.addAttribute("siteId", siteId);

			Record siteRd = orderDispatchService.getSiteMsg(siteId);
			String name = siteRd.getStr("sms_sign");
			String jdPhone = siteRd.getStr("sms_phone");
			String siteMobile = siteRd.getStr("mobile");
			String siteName = siteRd.getStr("name");
			String siteArea = siteRd.getStr("area");
			String proTime = "";
			if (order.getPromiseTime() != null) {
				proTime = order.getPromiseTime().toString().substring(0, 11);
			}
			model.addAttribute("mapDt", map);
			model.addAttribute("whereMark", whereMark);
			model.addAttribute("proTime", proTime);
			model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
			model.addAttribute("jdPhone", jdPhone);
			model.addAttribute("siteMobile", siteMobile);
			model.addAttribute("siteArea", siteArea);
			model.addAttribute("siteName", siteName);
			setSmsEmployeInfo(model, order);

			// 自定义用户类型
			model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
			String orderAddress = RegexUtil.NEW_LINE.matcher(org.apache.commons.lang3.StringUtils.defaultString(order.getCustomerAddress(), "")).replaceAll("");
			model.addAttribute("orderAddress", orderAddress);
			order.setCustomerAddress(orderAddress);

			List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
			Record rds = orderDispatchService.getOrderId(orderId, siteId);
			model.addAttribute("disOrder", rds);
			List<String> categoryList = new ArrayList<>();
			for (Record caterd : category) {
				categoryList.add(caterd.getStr("name"));
			}
			model.addAttribute("catelist", categoryList);
			model.addAttribute("category", category);

			model.addAttribute("order", order);
			String odStatus = (rds == null ? "" : rds.getStr("status"));
			model.addAttribute("dispStatus", (rds == null ? "" : TranslationUtils.translateDispatchOrderStatus(odStatus)));

			Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
			model.addAttribute("brand", brand);
			List<String> brandlist = new ArrayList<>();
			brandlist.addAll(brand.values());
			model.addAttribute("brandlist", brandlist);
			model.addAttribute("number", order.getNumber());
			model.addAttribute("newOrder", request.getParameter("newOrder"));
			List<String> listStr;
			// 信息来源
			List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
			List<String> listOriginlist = new ArrayList<>();
			for (Record rdss : listOrigin) {
				listOriginlist.add(rdss.getStr("name"));
			}
			model.addAttribute("listorigin", listOrigin);
			model.addAttribute("listoriginlist", listOriginlist);

			// 时间要求
			List<Record> list = orderDispatchService.getAllProLimit(null);
			listStr = Lists.newArrayList();
			for (Record aList : list) {
				listStr.add(aList.getStr("name"));
			}
			model.addAttribute("proLimitList", listStr);
			Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id=? AND a.site_id=?", orderId, siteId);
			model.addAttribute("count", count);

			List<Record> malllist = orderMallService.getlistRecordWithNameOnly(siteId);
			model.addAttribute("malllist", malllist);

			// 服务工程师
			if (StringUtils.isNotBlank(order.getEmployeName())) {
				String[] emplName = order.getEmployeName().split(",");
				List<Record> listemp = new ArrayList<>();
				for (String anEmplName : emplName) {
					Record r = new Record();
					r.set("name", anEmplName);
					listemp.add(r);
				}
				model.addAttribute("emName", listemp);
			}

			/* 必填设置 */
			model.addAttribute("mustfill", orderMustFillSettingService.getMustFillInfoRecord(siteId));

			// 地址信息
			Site site = siteService.get(siteId);
			Map<String, Object> mapAddr = CrmUtils.getProCityArea(site, order);
			model.addAttribute("provincelist", mapAddr.get("provincelist"));
			model.addAttribute("cities", mapAddr.get("cities"));
			model.addAttribute("districts", mapAddr.get("districts"));
			model.addAttribute("site", site);
			// 报修图片
			Integer repairImgsCount = 0;
			if (StringUtils.isNotBlank(order.getBdImgs())) {
				String[] repairImgs = order.getBdImgs().split("[,;]");
				model.addAttribute("repairImgs", repairImgs);
				repairImgsCount = repairImgs.length;
			}
			model.addAttribute("repairImgsCount", repairImgsCount);

			if ("1".equals(order.getStatus()) || "7".equals(order.getStatus()) || "0".equals(order.getStatus())) {
				// 自定义模板获取
				List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
				model.addAttribute("definedmodel", definedmodel);
				model.addAttribute("listModel", MsgModelUtils.getListModel(order.getStatus()));
				return "modules/order/orderDispatchForm";
			} else if ("2".equals(order.getStatus())) {
				if (StringUtils.isNotBlank(order.getEmployeId())) {
					Map<String, Object> empmap = getOrderEmpMobiles(order.getEmployeId());

					model.addAttribute("empMobile", org.apache.commons.lang3.StringUtils.join(empmap.get("empmos"), ","));
					model.addAttribute("mapempMo", empmap.get("mobiles"));
				}

				// 反馈信息
				Long count1 = orderService.getPjMsg1(orderId, siteId);
				Record rdetail = orderDispatchService.feedBackDuringDetail(siteId, orderId);
				Integer duringFeedImgsCount = 0;
				if (rdetail != null) {
					model.addAttribute("duringFeedImgs", rdetail.getStr("feedback_img"));
					if (StringUtils.isNotBlank(rdetail.getStr("feedback_img"))) {
						model.addAttribute("duringFeedImgsArr", rdetail.getStr("feedback_img").split(","));
						duringFeedImgsCount = rdetail.getStr("feedback_img").split(",").length;
					}
				}
				model.addAttribute("duringFeedImgsCount", duringFeedImgsCount);
				Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
				model.addAttribute("feedbackInfo", feedbackInfo);
				// 派工信息
				Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);
				model.addAttribute("dispRd", dispRd);
				model.addAttribute("count1", count1);
				List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
				model.addAttribute("collectionslist", collectionslist);

				// 自定义模板获取
				List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
				model.addAttribute("definedmodel", definedmodel);
				model.addAttribute("listModel", MsgModelUtils.getListModel(order.getStatus()));
				String erpwx = Global.getConfig("server.erpwx");
				String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
				String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
				model.addAttribute("oneHref", ret);
				return "modules/order/orderManagement/during/orderDuringForm";
			} else if ("3".equals(order.getStatus()) || "4".equals(order.getStatus())) {
				// 反馈信息
				Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
				model.addAttribute("feedbackInfo", feedbackInfo);
				// 派工信息
				Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);
				model.addAttribute("dispRd", dispRd);

				// 厂家工单派工信息可能为空（防止出现空指针）
				List<Record> disRels = null;
				if (dispRd != null) {
					disRels = orderDispatchService.getDispatchRels(dispRd.getStr("id"), siteId);
				}
				model.addAttribute("disRels", disRels);
				// 回访信息
				Record callbacks = orderCallBackService.getCallBackInfo(orderId, siteId);
				model.addAttribute("cbInfo", callbacks);
				model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
				model.addAttribute("extendedOrder", new ExtendedOrder(order));
				model.addAttribute("siteId", siteId);
				Record rdetail = orderDispatchService.feedBackDetail(siteId, orderId);
				if (rdetail != null) {
					model.addAttribute("feedBackDetail", orderDispatchService.feedBackDetail(siteId, orderId));
					String feedBImgs = orderDispatchService.feedBackDetail(siteId, orderId).getStr("feedback_img");
					if (StringUtils.isNotBlank(feedBImgs)) {
						model.addAttribute("feedImgs", feedBImgs.split(","));
						model.addAttribute("feedImgsCount", feedBImgs.split(",").length);
					} else {
						model.addAttribute("feedImgs", "");
						model.addAttribute("feedImgsCount", 0);
					}
				} else {
					model.addAttribute("feedBackDetail", "");
				}
				// 结算措施
				List<SettlementTemplate> listsetTem = setService.getListSet(order.getApplianceCategory(), siteId);
				model.addAttribute("listsetTem", listsetTem);
				/* 结算条件设置query */
				Record jsSetRd = orderDispatchService.queryLsSet(siteId);
				model.addAttribute("jsSetRd", jsSetRd);
				List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
				model.addAttribute("collectionslist", collectionslist);
				// 自定义模板获取
				List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
				model.addAttribute("definedmodel", definedmodel);
				model.addAttribute("userType", UserUtils.getUser().getUserType());
				return "modules/order/orderManagement/jiesuan/orderdhfForm";
			}

			// 在有结算信息的前提下
			String sql = "SELECT * FROM crm_order_settlement WHERE order_id=? order by create_time desc limit 1";
			Record settlement = Db.findFirst(sql, orderId);
			model.addAttribute("hasSettlement", settlement != null);

			// 反馈信息
			Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(orderId, siteId);
			model.addAttribute("feedbackInfo", feedbackInfo);
			// 派工信息
			Record dispRd = orderDispatchService.getOrderDispatchForCallBack(order.getId(), siteId);
			model.addAttribute("dispRd", dispRd);
			// 回访信息
			Record callbacks = orderCallBackService.getCallBackInfo(orderId, siteId);
			model.addAttribute("cbInfo", callbacks);
			model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
			model.addAttribute("extendedOrder", new ExtendedOrder(order));
			List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getNumber(), siteId);
			model.addAttribute("collectionslist", collectionslist);
			return "modules/order/orderManagement/history/orderhistoryForm";
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
	}

	private void setSmsEmployeInfo(Model model, Order order) {
		if (StringUtils.isNotBlank(order.getEmployeId())) {
			Map<String, String> msg2 = orderDispatchService.getEmployeMsg1(order.getEmployeId());
			model.addAttribute("msg1", msg2.get("nameMobile"));
			model.addAttribute("msg2Names", msg2.get("empNames"));
			model.addAttribute("msg2Mobiles", msg2.get("empMobiles"));
		} else {
			model.addAttribute("msg1", "");
			model.addAttribute("msg2Names", "");
			model.addAttribute("msg2Mobiles", "");
		}
	}

	private Map<String, Object> getOrderEmpMobiles(String empids) {
		Map<String, Object> mapss = Maps.newHashMap();
		Map<String, Object> mobls = Maps.newHashMap();
		List<String> empMobileList = new ArrayList<>();
		if (StringUtils.isNotBlank(empids)) {
			if (!(empids.indexOf(",") > 0)) {
				if (StringUtils.isNotBlank(empids)) {
					Employe employe = employeService.get(empids);
					if (employe != null) {
						empMobileList.add(employe.getMobile());
						mobls.put(employe.getName(), employe.getMobile());
					}
				}
			} else {
				List<Employe> emps = employeService.getEmployes(empids);
				if (emps != null) {
					for (Employe e : emps) {
						empMobileList.add(e.getMobile());
						mobls.put(e.getName(), e.getMobile());
					}
				}
			}
		}
		mapss.put("mobiles", mobls);
		mapss.put("empmos", empMobileList);
		return mapss;
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "orderDetailForm")
	public String detailForm(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderNo = request.getParameter("orderNo");
		String migration = request.getParameter("migration");
		// Record order = new Record();
		// if ("2017".equals(migration)) {
		// order = orderService.getDetailByOrderNum2017(orderNo, siteId);
		// } else {
		// order = orderService.getDetailByOrderNum(orderNo, siteId);
		// }
		//
		// if (StringUtils.isBlank(migration)) {
		// order = orderService.getDetailByOrderNum2017(orderNo, siteId);
		// if (order == null) {
		// order = orderService.getDetailByOrderNum(orderNo, siteId);
		// }
		// }
		Record order = orderService.findOrderByNumberIfHistory(orderNo, siteId);

		if (order == null) {
			// 工单表中没找到？那么去400工单中找找看。
			Record record = order400Dao.findOrder400ByNumber(orderNo, siteId);
			model.addAttribute("order400", record);
			return "modules/order/orderManagement/400OrderDetailForm";
		}
		// if (order == null) {
		// logger.error(String.format("fitting hx order id [%s] not found", orderNo));
		// }

		model.addAttribute("order", order);
		String orderId = order.getStr("id");
		Order orderEntity = orderService.get(orderId);
		boolean isCurrent = orderEntity != null; // 表明不是备份工单中查出的工单
		model.addAttribute("isCurrent", isCurrent);

		// Map<String, Object> feedbackInfo = "2017".equals(migration) ?
		// orderService.getOrderFeedbackRecords2017(orderId, siteId)
		// : orderService.getOrderFeedbackRecords(orderId, siteId);
		model.addAttribute("feedbackInfo", orderService.getOrderFeedbackRecordsIfHistory(orderId, siteId));

		// Record dispRd = "2017".equals(migration) ?
		// orderDispatchService.getOrderDispatchForCallBack2017(orderId, siteId)
		// : orderDispatchService.getOrderDispatchForCallBack(orderId, siteId);
		Record dispRd = orderDispatchService.getOrderDispatchForCallBackIfHistory(orderId, siteId);
		model.addAttribute("dispRd", dispRd);
		model.addAttribute("dispStatus", (dispRd == null ? "" : TranslationUtils.translateDispatchOrderStatus(dispRd.getStr("status"))));

		// 回访信息
		// Record callbacks = "2017".equals(migration) ?
		// orderCallBackService.getCallBackInfo2017(orderId, siteId) :
		// orderCallBackService.getCallBackInfo(orderId, siteId);
		Record callbacks = orderCallBackService.getCallBackInfoIfHistory(orderId, siteId);
		model.addAttribute("cbInfo", callbacks);
		if (callbacks != null) {
			model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
		}

		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + orderId + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("number", order.getStr("number"));
		model.addAttribute("count", count);
		if (dispRd != null) {
			// List<Record> disRels = "2017".equals(migration) ?
			// orderDispatchService.getDispatchRels2017(dispRd.getStr("id"), siteId)
			// : orderDispatchService.getDispatchRels(dispRd.getStr("id"), siteId);
			List<Record> disRels = orderDispatchService.getDispatchRelsIfHistory(dispRd.getStr("id"), siteId);
			model.addAttribute("disRels", disRels);
		}

		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		// Record rds = "2017".equals(migration) ?
		// orderDispatchService.getOrderId2017(orderId, siteId) :
		// orderDispatchService.getOrderId(orderId, siteId);
		Record rds = orderDispatchService.getOrderIdIfHistory(orderId, siteId);
		model.addAttribute("disOrder", rds);
		model.addAttribute("category", category);
		if (order != null) {
			String orderType = order.getStr("order_type");
			if ("7".equals(orderType)) {
				order.set("xm", order.getStr("origin"));
			} else {
				order.set("xm", CrmUtils.getUserXM(order.getStr("create_by")));
			}
		}
		model.addAttribute("order", order);
		// 报修图片
		if (StringUtils.isNotBlank(order.getStr("bd_imgs"))) {
			String[] repairImgs = order.getStr("bd_imgs").split("[,;]");
			model.addAttribute("repairImgs", repairImgs);
		}

		Order order1 = new Order();
		order1.setReturnCard(order.getStr("return_card"));
		order1.setWarrantyType(order.getStr("warranty_type"));
		order1.setWhetherCollection(order.getStr("whether_collection"));
		model.addAttribute("extendedOrder", new ExtendedOrder(order1));
		Record settlement = settlementService.getOrderSettlementIfHistory(orderId, siteId);
		model.addAttribute("hasSettlement", settlement != null);

		return "modules/order/orderManagement/orderDetailForm";
	}

	/*
	 * 信息员操作代反馈
	 */
	// @ResponseBody
	@RequestMapping(value = "ReplaceEmploye")
	@ResponseBody
	public String ReplaceEmploye(GenerationOrderFrom od, HttpServletRequest re, HttpServletResponse reason) {
		String userName = CrmUtils.getUserXM();
		return orderDispatchService.ReplaceEmploye(od, userName);
	}

	/*
	 * 信息员操作重新反馈封单
	 */
	// @ResponseBody
	@RequestMapping(value = "ReplaceEmployeRe")
	@ResponseBody
	public String ReplaceEmployeRe(GenerationOrderFrom od, HttpServletRequest re, HttpServletResponse reason) {
		String userName = CrmUtils.getUserXM();
		return orderDispatchService.ReplaceEmployeRe(od, userName);
	}

	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		orderDispatchService.delete(id);
		addMessage(redirectAttributes, "删除派工成功");
		return "redirect:" + Global.getAdminPath() + "/order/orderDispatch/?repage";
	}

	// 操作直接封单
	@RequestMapping(value = "updateOrderClose")
	public Object updateOrderClose(HttpServletRequest request, HttpServletResponse response) {
		String latestProcess = request.getParameter("latest_process");
		String id = request.getParameter("id");
		orderDispatchService.updateClose(id, latestProcess);
		return id;
	}

	// 操作直接封单
	@RequestMapping(value = "updateOrderClose2017")
	public Object updateOrderClose2017(HttpServletRequest request, HttpServletResponse response) {
		String latestProcess = request.getParameter("latest_process");
		String id = request.getParameter("id");
		orderDispatchService.updateClose2017(id, latestProcess);
		return id;
	}

	// 操作无效工单
	@RequestMapping(value = "updateOrderInvalid")
	@ResponseBody
	public Boolean updateOrderInvalid(HttpServletRequest request, HttpServletResponse response) {
		String latestProcess = request.getParameter("latest_process");
		String reasonofwxgdType = request.getParameter("reasonofwxgdType");
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		boolean proving = true;
		try {
			orderDispatchService.updateInvalid(id, latestProcess, reasonofwxgdType, type);
		} catch (Exception e) {
			e.printStackTrace();
			proving = false;
		}
		return proving;
	}

	// 操作暂不派工
	@RequestMapping(value = "TemporarilyDis")
	@ResponseBody
	public Boolean TemporarilyDis(HttpServletRequest request, HttpServletResponse response) {
		String latestProcess = request.getParameter("latest_process");
		String id = request.getParameter("id");
		boolean proving = true;
		try {
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			orderDispatchService.delayOrderDispatch(id, latestProcess, siteId);// 工单表状态取消
		} catch (Exception e) {
			e.printStackTrace();
			proving = false;
		}
		return proving;
	}

	/**
	 * 修改待派工工单
	 */
	@RequestMapping(value = "update")
	@ResponseBody
	public Object update(HttpServletRequest request, HttpServletResponse response, Model model, Order order) {
		String emplids = request.getParameter("employeIds");
		if (StringUtils.isNotBlank(emplids)) {
			// 理论上此分支只针对回访结算工单才会有此功能
			String[] ids = emplids.split(",");
			HashMap<String, String> map = new HashMap<>();
			String empNames = "";
			for (int i = 0; i < ids.length; i++) {
				Record re = orderDispatchService.getEmployeMsg4(ids[i]);
				if (i == 0) {
					empNames = re.getStr("name");
				} else {
					empNames += "," + re.getStr("name");
				}
				map.put(ids[i], re.getStr("name"));
			}
			order.setEmployeId(emplids);
			order.setEmployeName(empNames);

			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			Record dispRd = Db.findFirst("SELECT d.`id` FROM crm_order_dispatch AS d WHERE d.`order_id`=? AND d.`site_id`=? AND d.`status`='5' LIMIT 1", order.getId(), siteId);
			if (dispRd == null) {
				logger.error("dispRd not found, order.id=" + order.getId() + ";site.id=" + siteId);
			}
			String dispId = dispRd.getStr("id");
			SqlKit kit = new SqlKit().append("DELETE FROM `crm_order_dispatch_employe_rel`").append("WHERE `dispatch_id`=?").append("AND `site_id`=?");
			Db.update(kit.toString(), dispId, siteId);
			String sql = "INSERT INTO `crm_order_dispatch_employe_rel`(`id`, `order_id`, `dispatch_id`, `emp_id`, `emp_name`, `site_id`) VALUES(?, ?, ?, ?, ?, ?)";
			Set<Map.Entry<String, String>> entries = map.entrySet();
			for (Map.Entry<String, String> entry : entries) {
				Db.update(sql, IdGen.uuid(), order.getId(), dispId, entry.getKey(), entry.getValue(), siteId);
			}
		}
		orderDispatchService.update(order);
		return new HashMap<String, Object>();
	}

	/*
	 * 待派工派单
	 */@ResponseBody
	@RequestMapping(value = "save")
	public Boolean save(Model model, HttpServletRequest request, HttpServletResponse response) {
		String employeId = request.getParameter("empId");
		String orderId = request.getParameter("orderId");
		boolean proving = true;
		try {
			orderDispatchService.Disorder(orderId, employeId, "");
		} catch (Exception e) {
			e.printStackTrace();
			proving = false;
		}
		return proving;
	}

	@RequestMapping(value = "wxdRedispatch")
	@ResponseBody
	public Object wxdRedispatch(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("id");
		String empId = request.getParameter("empId");
		return orderDispatchService.wxOrderRedispatch(orderId, empId);
	}

	/*
	 * 转派工单
	 */
	@RequestMapping(value = "Redispatch")
	@ResponseBody
	public Boolean Redispatch(Model model, HttpServletRequest request, HttpServletResponse response) {
		String employeId = request.getParameter("empId");
		String orderId = request.getParameter("orderId");
		String disId = request.getParameter("disorderId");
		String transferReasons = request.getParameter("transferReasons");
		logger.info(" in Redispatch orderId:" + orderId);

		boolean proving = true;
		try {
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			String[] orderIds = orderId.split(",");
			if (orderIds.length <= 0) {
				return false;
			}

			String joinedOrderIds = StringUtil.joinInSql(orderIds);
			String mark = orderService.mark(joinedOrderIds, siteId);
			if ("1".equals(mark)) {
				logger.error("有配件申请信息，不可转派，sid：" + siteId + ";orderIds=" + Arrays.toString(orderIds));
				// 有申请配件的不可以再转派
				return false;
			}

			logger.info(" in Redispatch orderId:" + orderId);

			// 检查相应的派工是否已经处于转派状态
			String[] disIds = disId.split(",");
			if(StringUtil.isNotBlank(disId) && disIds.length > 0){
				Long count = Db.queryLong("select count(1) as count from crm_order_dispatch as od where od.status='6' and od.id in(" + StringUtil.joinInSql(disIds) + ")");
				if (count > 0) {
					logger.error("派工单子状态已经处于转派状态，不可重复转派,sid=：" + siteId + "disId=" + disId);
					return false;
				}
			}

			// 检查工单是否已经完工（即工单状态为待回访待结算）
			Long count1 = Db.queryLong("select count(1) as count from crm_order as o where o.id in(" + joinedOrderIds + ") and o.`status`<>'2'");
			if (count1 > 0) {
				logger.error("只有服务中的工单才能转派,sid=：" + siteId + ";orderIds=" + orderId);
				return false;
			}

			logger.info(" in Turntosend orderId:" + orderId);

			orderDispatchService.Turntosend(siteId, orderId, employeId, disId, transferReasons, "");
		} catch (Exception e) {
			e.printStackTrace();
			proving = false;
		}
		return proving;
	}

	@RequestMapping(value = "getCategory")
	public void getCategory(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter write;
		try {
			write = response.getWriter();
			String brand = request.getParameter("brand");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, String> cate = CategoryUtils.getSiteCategory(siteId, BrandUtils.getBrandId(brand));
			// 将lists转换成json
			JSONObject obj = new JSONObject();
			if (cate.size() < 1) {
				obj.accumulate("count", 2);
			} else {
				obj.accumulate("count", 1);
			}
			obj.accumulate("cate", cate);
			write.print(obj);
		} catch (IOException e) {
		}
	}

	// 根据省获取市
	@ResponseBody
	@RequestMapping(value = "getCity")
	public String getCity(HttpServletRequest request, HttpServletResponse response) {
		String province = request.getParameter("province");
		List<Record> list = CrmUtils.getCityList(province);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}

	// 根据市获取区县
	@ResponseBody
	@RequestMapping(value = "getArea")
	public String getArea(HttpServletRequest request, HttpServletResponse response) {
		String city = request.getParameter("city");
		List<Record> list = CrmUtils.getDistrictList(city);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}

	@RequestMapping(value = "changeBrand")
	public void changeBrand(String name, HttpServletRequest request, HttpServletResponse response) {
		List<String> liststr = Lists.newArrayList();
		List<Record> list = orderDispatchService.changeBrand(name);
		Map<String, Object> map = Maps.newHashMap();
		for (int i = 0; i < list.size(); i++) {
			liststr.add(list.get(i).getStr("name"));
		}

		map.put("changecstr", liststr);

		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@ResponseBody
	@RequestMapping(value = "showPjms")
	public Map<String, Object> showPjmg(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String orderId = request.getParameter("orderId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> list = Lists.newArrayList();
		list = orderService.getPjMsg(list, orderId, siteId, null);
		map.put("list", list);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "queryDispatchStatus")
	public Object queryDispatchStatus(HttpServletRequest request) {
		String oid = request.getParameter("oid");
		if (StringUtils.isBlank(oid)) {
			throw new IllegalArgumentException("order id required");
		}

		Order order = orderService.get(oid);
		Record rds = orderDispatchService.getOrderId(oid, order.getSiteId());
		Map<String, Object> ret = new HashMap<>();
		ret.put("status", rds == null ? "" : rds.getStr("status"));
		return ret;
	}

	/**
	 * 将派工单状态修改为已接单。
	 */
	@ResponseBody
	@RequestMapping(value = "updateDispatchStatusToYJD")
	public void updateDispatchStatusToYJD(HttpServletRequest request) {
		String oid = request.getParameter("oid");
		if (StringUtils.isBlank(oid)) {
			throw new IllegalArgumentException("order id required");
		}

		Order order = orderService.get(oid);
		Record rds = orderDispatchService.getOrderId(oid, order.getSiteId());
		if (rds != null) {
			order.setProcessTime(new Date());
			orderService.persist(order);
			orderDispatchService.updateOrderDispatchStatusToYJD(rds.getStr("id"));
		}
	}

	/**
	 * 历史工单修改用户信息
	 */
	@RequestMapping(value = "updateHistoryUser")
	@ResponseBody
	public void updateHistoryUser(HttpServletRequest request, Order order) {
		String factoryNumber = request.getParameter("factoryNumber");
		orderDispatchService.updateHistoryUser(order, factoryNumber);
	}

	// 新建工单保存后发送短信
	@RequestMapping(value = "SMSnotification")
	public String SMSnotification(HttpServletRequest request, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String orderId = request.getParameter("id");
		Order order = orderService.get(orderId);
		String name = "";
		Record rd = orderDispatchService.getSiteMsg(siteId);
		name = rd.getStr("sms_sign");
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteName", siteName);
		model.addAttribute("siteArea", rd.getStr("area"));
		setSmsEmployeInfo(model, order);
		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel(order.getStatus());
		model.addAttribute("listModel", listModel);
		model.addAttribute("order", order);
		// if (StringUtils.isNotBlank(order.getCustomerMobile())) {
		// model.addAttribute("lenMobile", order.getCustomerMobile().length());// 号码长度
		// } else {
		// model.addAttribute("lenMobile", 0);// 号码长度
		// }

		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + orderId + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("number", order.getNumber());
		model.addAttribute("count", count);
		model.addAttribute("order", order);
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		// 自定义模板获取
		List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
		if (definedmodel.size() > 0) {
			model.addAttribute("definedmodel", definedmodel);
			return "modules/order/dispatchSendDefinedMsg";
		}
		return "modules/order/sysorderForm";
	}

	/**
	 * 批量交款
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "pljk")
	public Result<T> pljk(String ids, HttpServletRequest request) {
		return orderDispatchService.confirmJk(ids);
	}

	/**
	 * 批量交单
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "pljd")
	public Result<T> pljd(String ids, HttpServletRequest request) {
		return orderDispatchService.confirmJd(ids);
	}

	@RequestMapping(value = "showLatestAnnounce")
	public String showLatestAnnounce(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		String mark = request.getParameter("mark");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record rd = new Record();
		if (StringUtils.isNotBlank(id)) {
			rd = orderDispatchService.showLatestAnnounceById(id);
			rd.set("id", id);
			orderDispatchService.updateAnnounce(siteId, rd);
		} else {
			rd = orderDispatchService.showLatestAnnounce(siteId);
		}
		model.addAttribute("rd", rd);
		model.addAttribute("mark", mark);
		return "modules/base/announceMentShow";
	}

	@RequestMapping(value = "showearlyWarningAnnounce")
	public String showearlyWarningAnnounce(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		Db.update("update crm_site_alarm a set a.status='0' where a.id=?", id);
		model.addAttribute("sitealarm", siteAlarmService.getSiteAlarm(id));
		return "modules/base/announceearlyWarningShow";
	}

	@ResponseBody
	@RequestMapping(value = "ifShowAnounce")
	public String ifShowAnounce(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record rd = orderDispatchService.showLatestAnnounce(siteId);
		if (rd == null) {
			return "noShow";
		}
		if (StringUtils.isNotBlank(rd.getStr("readId"))) {
			return "noShow";
		}
		orderDispatchService.updateAnnounce(siteId, rd);
		return "okShow";
	}

	/* 删除过程信息图片 */
	@ResponseBody
	@RequestMapping(value = "deleteProcessImage")
	public String deleteProcessImage(HttpServletRequest request) {
		String id = request.getParameter("id");
		String path = request.getParameter("path");
		return orderDispatchService.deleteProcessImage(id, path);
	}
}
