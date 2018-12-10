/**
 */
package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.service.SiteselfOrderService;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteManagerService;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.dao.CustomerTypeDao;
import com.jojowonet.modules.order.entity.CrmOrder2017;
import com.jojowonet.modules.order.entity.CrmOrder400;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderMarkSetting;
import com.jojowonet.modules.order.entity.SettlementTemplate;
import com.jojowonet.modules.order.form.OrderReturnVisit;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.ChangeSelfOrderService;
import com.jojowonet.modules.order.service.DistributionService;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderFittingService;
import com.jojowonet.modules.order.service.OrderMallService;
import com.jojowonet.modules.order.service.OrderMarkSettingService;
import com.jojowonet.modules.order.service.OrderMustFillSettingService;
import com.jojowonet.modules.order.service.OrderOriginService;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.service.SettlementTemplateService;
import com.jojowonet.modules.order.service.SmsTempletService;
import com.jojowonet.modules.order.service.SysSettleService;
import com.jojowonet.modules.order.service.TownshipService;
import com.jojowonet.modules.order.utils.Apiutils;
import com.jojowonet.modules.order.utils.BrandUtils;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.GPSUtil;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.MsgModelUtils;
import com.jojowonet.modules.order.utils.OrderNo;
import com.jojowonet.modules.order.utils.RandomUtil;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.Tuple;
import com.jojowonet.modules.sys.util.TrimMap;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.mapper.JsonMapper;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 工单Controller
 * 
 * @author Ivan
 * @version 2017-05-04
 */
@Controller
@RequestMapping(value = "${adminPath}/order")
public class OrderController extends BaseController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private SiteselfOrderService siteselfOrderService;
	@Autowired
	private SiteService siteService;
	@Autowired
	private NonServicemanService noService;
	@Autowired
	private OrderOriginService orderOriginService;
	@Autowired
	private SysSettleService siteSettleService;
	@Autowired
	private SettlementTemplateService setService;
	@Autowired
	private OrderFittingService orderFittingService;
	@Autowired
	private OrderMarkSettingService orderMarkSettingService;
	@Autowired
	private ChangeSelfOrderService changeSelfOrderService;
	@Autowired
	private SiteManagerService siteManagerService;
	@Autowired
	private SmsTempletService smsTempletService;
	@Autowired
	private TownshipService townshipService;
	@Autowired
	private OrderMallService orderMallService;
	@Autowired
	private SiteMsgService siteMsgService;
	@Autowired
	private OrderDispatchService orderDispatchService;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private OrderMustFillSettingService orderMustFillSettingService;
	@Autowired
	private CustomerTypeDao customerTypeDao;
	@Autowired
	private DistributionService distributionService;

	public static final HashMap<String, AtomicLong> fromMap = new HashMap<>();

	static {
		fromMap.put("wc", new AtomicLong(0));
		fromMap.put("dhf", new AtomicLong(0));
		fromMap.put("hbc", new AtomicLong(0));
		fromMap.put("hf", new AtomicLong(0));
		fromMap.put("df", new AtomicLong(0));
		fromMap.put("count-cache", new AtomicLong(0));
		fromMap.put("o", new AtomicLong(0));
	}

	@ModelAttribute
	public Order get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderService.get(id);
		} else {
			return new Order();
		}
	}

	// 待派工
	@RequestMapping(value = "getWwgList/{menu}")
	public String list(@PathVariable String menu, Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		model.addAttribute("order", order);
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		String userType = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", userType);
		User user = UserUtils.getUser();
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		if ("zbpg".equals(menu)) {// 暂不派工
			return "modules/order/orderManagement/wait/orderListzbpg";
		} else if ("jjgd".equals(menu)) {// 拒接工单
			return "modules/order/orderManagement/wait/orderListjjgd";
		} else if ("jryy".equals(menu)) {// 今日预约
			return "modules/order/orderManagement/wait/orderListjryy";
		} else if ("djd".equals(menu)) {// 待接单
			return "modules/order/orderManagement/during/orderListdjd";
		} else if ("yjgd".equals(menu)) {// 预警工单
			Map<String, Object> map = orderService.getManufactorEfficiency(siteId);
			model.addAttribute("mapyj", map);
			return "modules/order/orderManagement/during/orderListyjgd";
		} else if ("djgd".equals(menu)) {// 待件工单
			return "modules/order/orderManagement/during/orderListdjgd";
		} else if ("djs".equals(menu)) {// 待结算
			String setFlag = siteSettleService.getSiteSettleFlag(siteId);
			model.addAttribute("settleFlag", setFlag);
			return "modules/order/orderManagement/jiesuan/orderListdjs";
		} else if ("dhf".equals(menu)) {// 待回访
			String setFlag = siteSettleService.getSiteSettleFlag(siteId);
			model.addAttribute("settleFlag", setFlag);
			return "modules/order/orderManagement/jiesuan/orderListdhf";
		} else if ("ywc".equals(menu)) {// 已完成
			return "modules/order/orderManagement/history/orderListywc";
		} else if ("wxgd".equals(menu)) {// 无效工单
			return "modules/order/orderManagement/history/orderListwxgd";
		}
		return null;
	}

	// 待派工
	@RequestMapping(value = "getWwgList")
	public String getWwg(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		model.addAttribute("order", order);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		String userType = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", userType);
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		model.addAttribute("oneHref", ret);
		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		return "modules/order/orderManagement/wait/orderList";
	}

	// 维修中
	@RequestMapping(value = "during")
	public String during(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("order", order);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		String userType = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", userType);
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}

		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		model.addAttribute("oneHref", ret);

		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);
		Map<String, String> brands = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brands);
		return "modules/order/orderManagement/during/orderDuringList";
	}

	// 待回访结算
	@RequestMapping(value = "StayVisit")
	public String StayVisit(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("order", order);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
		model.addAttribute("category", category);
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		String setFlag = siteSettleService.getSiteSettleFlag(siteId);
		model.addAttribute("settleFlag", setFlag);
		// 结算措施
		List<SettlementTemplate> listsetTem = setService.getListSet(order.getApplianceCategory(), siteId);
		model.addAttribute("listsetTem", listsetTem);
		String userType = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", userType);
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		return "modules/order/orderManagement/jiesuan/orderStayVisitList";
	}

	// 历史工单
	@RequestMapping(value = "History")
	public String History(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("order", order);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		// 结算措施
		List<SettlementTemplate> listsetTem = setService.getListSet(order.getApplianceCategory(), siteId);
		model.addAttribute("listsetTem", listsetTem);
		String userType = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", userType);
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);
		Map<String, String> brands = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brands);
		return "modules/order/orderManagement/history/orderHistoryList";
	}

	// 全部工单
	@RequestMapping(value = "Whole")
	public String Whole(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("order", order);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String userType = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", userType);
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginList = new ArrayList<>();
		for (Record rd : listOrigin) {
			listOriginList.add(rd.getStr("name"));
		}
		List<Record> category = CategoryUtils.getCategoryNameSiteId(siteId);
		model.addAttribute("category", category);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brand", brand);
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginList);
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		String setFlag = siteSettleService.getSiteSettleFlag(siteId);
		model.addAttribute("settleFlag", setFlag);

		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", Global.getConfig("server.erpwx"), siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		return "modules/order/orderManagement/whole/orderWholeList";
	}

	// 待派工
	@ResponseBody
	@RequestMapping(value = "getDpgList")
	public String getWwgList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		Page<Record> page = orderService.getOrderWaitForDis(pages, siteId, "1", map, cateList, brandList);
		return renderJson(new JqGridPage<>(page));
	}

	// 待派工
	@ResponseBody
	@RequestMapping(value = "getOrderMenuList/{menu}")
	public String getOrderMenuList(@PathVariable String menu, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> page = new Page<Record>(request, response);
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		if ("zbpg".equals(menu)) {// 暂不派工
			page = orderService.getOrderWaitForDisoType(page, siteId, "1", menu, map, cateList, brandList);
		} else if ("jjgd".equals(menu)) {// 拒接工单
			page = orderService.getOrderWaitForDisoType(page, siteId, "1", menu, map, cateList, brandList);
		} else if ("jryy".equals(menu)) {// 今日预约
			page = orderService.getOrderWaitForDisoType(page, siteId, "1", menu, map, cateList, brandList);
		} else if ("djd".equals(menu)) {// 待接单
			page = orderService.getOrderWaitForDisoType(page, siteId, "2", menu, map, cateList, brandList);
		} else if ("yjgd".equals(menu)) {// 预警工单
			page = orderService.getOrderWaitForDisoType(page, siteId, "2", menu, map, cateList, brandList);
		} else if ("djgd".equals(menu)) {// 待件工单
			page = orderService.getOrderWaitForDisoType(page, siteId, "2", menu, map, cateList, brandList);
		} else if ("dhf".equals(menu)) {// 待回访--
			page = orderService.getOrderWaitForDisoType(page, siteId, "3", menu, map, cateList, brandList);
		} else if ("djs".equals(menu)) {// 待结算
			page = orderService.getOrderWaitForDisoType(page, siteId, "3", menu, map, cateList, brandList);
		} else if ("ywc".equals(menu)) {// 已完成
			page = orderService.getOrderWaitForDisoType(page, siteId, "5", menu, map, cateList, brandList);
		} else if ("wxgd".equals(menu)) {// 无效工单
			map.put("__WXGDList", "8"); // HACK,用此来表明是无效工单列表
			page = orderService.getOrderWaitForDisoType(page, siteId, "5", menu, map, cateList, brandList);
		}

		return renderJson(new JqGridPage<>(page));
	}

	// 维修中
	@ResponseBody
	@RequestMapping(value = "getWxzList")
	public String getWxzList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		Page<Record> page = orderService.getOrderWaitForDis(pages, siteId, "2", map, cateList, brandList);
		return renderJson(new JqGridPage<>(page));
	}

	// 待回访结算
	@ResponseBody
	@RequestMapping(value = "getStayVisitList")
	public String getStayVisitList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		String status = (String) map.get("status");
		if (!StringUtils.isNotBlank(status)) {
			status = "3,4";
		}
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		Page<Record> page = orderService.getOrderHis(pages, siteId, status, map, cateList, brandList);
		return renderJson(new JqGridPage<>(page));
	}

	// 历史
	@ResponseBody
	@RequestMapping(value = "getHistoryList")
	public String getHistoryList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		String status = (String) map.get("status");
		if (status == null) {
			status = "5,8";
		}
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		map.put("__WXGDList", "8"); // HACK,用此来表明是无效工单列表
		Page<Record> page = orderService.getOrderHis(pages, siteId, status, map, cateList, brandList);

		return renderJson(new JqGridPage<>(page));
	}

	// 全部(工单信息)
	@ResponseBody
	@RequestMapping(value = "getWholeList")
	public String getWholeList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<>(request, response);
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		boolean hasCondition = hasCondition(map);
		Page<Record> page = orderService.getOrderWholeList(pages, siteId, null, map, cateList, brandList, hasCondition);
		if (!hasCondition(map)) { // this block is for debug only
			fromMap.get("o").getAndIncrement();
			if (fromMap.get("o").get() > 1000000) {
				fromMap.get("o").set(0);
			}
		}

		return renderJson(new JqGridPage<>(page));
	}

	private static final HashSet<String> defaultParam = new HashSet<>(Arrays.asList("_search", "nd", "rows", "page", "sidx", "sord", "ptype"));

	private boolean hasCondition(Map<String, Object> map) {
		Set<Map.Entry<String, Object>> entrySet = map.entrySet();
		for (Map.Entry<String, Object> entry : entrySet) {
			if (defaultParam.contains(entry.getKey())) {
				continue;
			}
			if (StringUtil.isNotBlank((CharSequence) entry.getValue())) {
				return true;
			}
		}
		return false;
	}

	@SuppressWarnings("static-access")
	@RequestMapping(value = "form")
	public String form(Order order, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Site site = siteService.get(siteId);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		Date curDate = new Date();
		String orderId = RandomUtil.randomOrderNumber();
		order.setNumber(orderId);
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<String>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);

		// 获取来源
		List<Record> list = orderService.getOrderType();
		model.addAttribute("ordertype", list);

		List<Record> malllist = orderMallService.getlistRecordWithNameOnly(siteId);
		model.addAttribute("malllist", malllist);
		order.setRepairTime(curDate);
		model.addAttribute("site", site);

		model.addAttribute("category", CategoryUtils.getCategoryNameSiteId(siteId));
		model.addAttribute("brand", brand);
		model.addAttribute("order", order);
		int wnsize = 0;
		List<Record> towns = townshipService.getTownshipSiteId(siteId);
		if (towns != null) {
			model.addAttribute("township", towns);
			wnsize = towns.size();
		}
		model.addAttribute("wnsize", wnsize);
		// 自定义用户类型
		model.addAttribute("cusTypecount", customerTypeDao.getsiteCustomerTypeCount(siteId));
		model.addAttribute("orderNumSet", siteMsgService.ifOpenOrderSet(siteId));

		/* 必填设置 */
		model.addAttribute("mustfill", orderMustFillSettingService.getMustFillInfoRecord(siteId));

		model.addAttribute("provincelist", CrmUtils.getProvinceList());
		model.addAttribute("cities", CrmUtils.getCityList(site.getProvince()));
		model.addAttribute("districts", CrmUtils.getDistrictList(site.getCity()));

		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		return "modules/" + "order/orderForm";
	}

	@ResponseBody
	@RequestMapping(value = "getproLimitList")
	public Object getproLimitList() {
		// 时间要求
		List<Record> listli = orderDispatchService.getAllProLimit(null);
		List<String> listStr = Lists.newArrayList();
		for (Record aListli : listli) {
			listStr.add(aListli.getStr("name"));
		}
		return listStr;
	}

	@ResponseBody
	@RequestMapping(value = "getDefaultAddress")
	public String getDefaultAddress() {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record re = orderService.getCustomerAddress(siteId);
		return re.getStr("province") + re.getStr("city") + re.getStr("AREA") + re.getStr("address");
	}

	// 新建工单
	@SuppressWarnings("static-access")
	@RequestMapping(value = "newFormFormDetail")
	public String saveform(HttpServletRequest request, Model model) {
		String orId = request.getParameter("id");
		Order order = orderService.get(orId);
		String siteId = order.getSiteId();
		Site site = siteService.get(siteId);
		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		Date curDate = new Date();
		String orderNumber = RandomUtil.randomOrderNumber();
		model.addAttribute("number", orderNumber);
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		// 获取来源
		List<Record> list = orderService.getOrderType();
		model.addAttribute("ordertype", list);
		model.addAttribute("curDate", curDate);
		model.addAttribute("site", site);
		model.addAttribute("category", category);
		model.addAttribute("brand", brand);
		model.addAttribute("order", order);
		model.addAttribute("orderNumSet", siteMsgService.ifOpenOrderSet(siteId));
		int wnsize = 0;
		List<Record> towns = townshipService.getTownshipSiteId(siteId);
		if (towns != null) {
			model.addAttribute("township", towns);
			wnsize = towns.size();
		}
		model.addAttribute("wnsize", wnsize);
		// 自定义用户类型
		model.addAttribute("cusTypecount", customerTypeDao.getsiteCustomerTypeCount(siteId));
		/* 必填设置 */
		model.addAttribute("mustfill", orderMustFillSettingService.getMustFillInfoRecord(siteId));
		model.addAttribute("malllist", orderMallService.getlistRecordWithNameOnly(siteId));

		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		Map<String, Object> mapAddr = CrmUtils.getProCityArea(site, order);
		model.addAttribute("provincelist", mapAddr.get("provincelist"));
		model.addAttribute("cities", mapAddr.get("cities"));
		model.addAttribute("districts", mapAddr.get("districts"));
		// 报修图片
		Integer repairImgsCount = 0;
		if (StringUtils.isNotBlank(order.getBdImgs())) {
			String[] repairImgs = order.getBdImgs().split("[,;]");
			model.addAttribute("repairImgs", repairImgs);
			repairImgsCount = repairImgs.length;
		}
		model.addAttribute("repairImgsCount", repairImgsCount);

		return "modules/" + "order/orderFormFromDetail";
	}

	// 工单入库及派工
	@ResponseBody
	@RequestMapping(value = "save")
	public Object save(Order or, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String code = siteMsgService.ifOpenOrderSet(siteId);
		if ("200".equals(code)) {
			OrderNo odn = CrmUtils.genOrderNo(siteId);
			if (odn != null) {
				or.setNumber(odn.getData());
				or.setSeq(odn.getSeq());
			}
		}
		String distributionNumber = request.getParameter("distributionNumber");
		String distributionTime = request.getParameter("distributionTime");
		String plateNumber = request.getParameter("plateNumber");
		String siteplateId = request.getParameter("siteplateId");
		String driverName = request.getParameter("driverName");
		String sitedriverId = request.getParameter("sitedriverId");
		Long count = orderService.numberCount1(or.getNumber(), siteId);
		if (count > 0) {
			return "420";
		}
		orderService.save(or, "");
		if (StringUtils.isNotBlank(distributionNumber) && StringUtils.isNotBlank(plateNumber)) {
			distributionService.save(or, distributionNumber, distributionTime, plateNumber, siteplateId, driverName, sitedriverId, user.getId());
		}
		return or;
	}

	// 工单入库及派工
	@ResponseBody
	@RequestMapping(value = "checkonumber")
	public String checkonumber(String orderNumber, HttpServletRequest request, HttpServletResponse response) {
		Long count = orderService.numberCount1(orderNumber.trim());
		if (count > 0) {
			return "existNumber";
		}
		return "ok";
	}

	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		orderService.delete(id);
		addMessage(redirectAttributes, "删除工单成功");
		return "redirect:" + Global.getAdminPath() + "/order/order/?repage";
	}

	@RequestMapping(value = "goTest")
	public String goTest(RedirectAttributes redirectAttributes) {
		return "modules/order/orderDetail";
	}

	@RequestMapping(value = "getBrand")
	public void getBrand(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter write;
		try {
			write = response.getWriter();
			String category = request.getParameter("category");
			User user = UserUtils.getUser();
			String siteId = request.getParameter("siteId");
			if (StringUtils.isBlank(siteId)) {
				siteId = CrmUtils.getCurrentSiteId(user);
			}
			Map<String, String> brand = BrandUtils.getSiteBrand(siteId, CategoryUtils.getSiteCategoryId(category, siteId));
			// 将lists转换成json
			JSONObject obj = new JSONObject();
			if (brand.size() < 1) {
				obj.accumulate("count", 2); // 标记没有品类
			} else {
				obj.accumulate("count", 1);
			}
			obj.accumulate("brand", brand);
			write.print(obj);
		} catch (IOException e) {
		}
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "getCategory")
	public void getCategory(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter write;
		String brand = request.getParameter("brand");
		try {
			write = response.getWriter();
			Map<String, Object> map = request.getParameterMap();
			User user = UserUtils.getUser();
			String siteId = request.getParameter("siteId");
			if (StringUtils.isBlank(siteId)) {
				siteId = CrmUtils.getCurrentSiteId(user);
			}
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

	@RequestMapping(value = "getOrderTabCount")
	@ResponseBody
	public JSONObject getOrderTabCount(HttpServletRequest request) {
		String tab = request.getParameter("tab");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String userType = UserUtils.getUser().getUserType();
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(userType))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		Map<String, Long> countMap = orderService.getOrderTabCount(tab, siteId, cateList, brandList);
		return JSONObject.fromObject(countMap);
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

			List<String> cateList = null;
			List<String> brandList = null;
			if (!("2".equals(user.getUserType()))) {
				Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
				cateList = StringUtil.tolist(cateAndBrand.getVal1());
				brandList = StringUtil.tolist(cateAndBrand.getVal2());
			}
			logger.info("<<<<<<<<<<<<<<<<<<<<<<导出：sid:" + siteId + "；formPath:" + formPath + ";title=" + title);
			List<Record> list = null;
			if ("待派工工单".equals(title)) {
				list = orderService.getOrderList(pages, siteId, "1", map, cateList, brandList);
			} else if ("维修中工单".equals(title)) {
				list = orderService.getOrderList(pages, siteId, "2", map, cateList, brandList);

			} else if ("回访结算工单".equals(title)) {
				String status = StringUtil.objectAsString(map.get("status"));
				if (StringUtils.isBlank(status)) {
					status = "3,4";
				}
				list = orderService.getOrderHistoryList(pages, siteId, status, map, cateList, brandList);
			} else if ("历史工单".equals(title)) {
				list = orderService.getOrderHistoryList(pages, siteId, "5,8", map, cateList, brandList);
			} else if ("暂不派工".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "1", "zbpg", map, cateList, brandList);
			} else if ("拒接工单".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "1", "jjgd", map, cateList, brandList);
			} else if ("今日预约".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "1", "jryy", map, cateList, brandList);
			} else if ("待接单".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "2", "djd", map, cateList, brandList);
			} else if ("预警工单".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "2", "yjgd", map, cateList, brandList);

			} else if ("待件工单".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "2", "djgd", map, cateList, brandList);

			} else if ("待回访".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "3", "dhf", map, cateList, brandList);
				jarray.remove(1);
			} else if ("待结算".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "4", "djs", map, cateList, brandList);
				jarray.remove(1);
			} else if ("已完成工单".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "5", "ywc", map, cateList, brandList);
			} else if ("无效工单".equals(title)) {
				list = orderService.getOrderListRecord(pages, siteId, "5", "wxgd", map, cateList, brandList);
			} else if ("全部工单".equals(title)) {
				list = orderService.getOrderHistoryList(pages, siteId, null, map, cateList, brandList);
			} else if ("今日提醒标记".equals(title)) {
				list = orderService.getJrtxbjListExport(pages, siteId, null, map, cateList, brandList);
			}
			String phones = "";
			for (Record rd : list) {
				phones = (rd.getStr("customer_mobile"));
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone"))) {
					phones += "/" + (rd.getStr("customer_telephone"));
				}
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone2"))) {
					phones += "/" + (rd.getStr("customer_telephone2"));
				}
				rd.set("customer_mobile", phones);
				String rAccount = rd.getStr("record_account");
				if ("1".equals(rAccount)) {
					rd.set("record_account", "是");
				} else {
					rd.set("record_account", "否");
				}
				String seAt = rd.getStr("service_attitude");// 满意度
				if ("1".equals(seAt)) {
					rd.set("service_attitude", "十分不满意");
				}
				if ("2".equals(seAt)) {
					rd.set("service_attitude", "不满意");
				}
				if ("3".equals(seAt)) {
					rd.set("service_attitude", "一般");
				}
				if ("4".equals(seAt)) {
					rd.set("service_attitude", "满意");
				}
				if ("5".equals(seAt)) {
					rd.set("service_attitude", "十分满意");
				}
				if ("6".equals(seAt)) {
					rd.set("service_attitude", "无效回访");
				}
				if ("7".equals(seAt)) {
					rd.set("service_attitude", "回访未成功");
				}
				String disableType = rd.getStr("disable_type");
				if ("0".equals(disableType)) {
					rd.set("disable_type", "");
				} else if ("1".equals(disableType)) {
					rd.set("disable_type", "重复");
				} else if ("2".equals(disableType)) {
					rd.set("disable_type", "机器已好");
				} else if ("3".equals(disableType)) {
					rd.set("disable_type", "费用高不修");
				} else if ("4".equals(disableType)) {
					rd.set("disable_type", "用户没时间");
				} else if ("5".equals(disableType)) {
					rd.set("disable_type", "其他原因");
				} else {
					rd.set("disable_type", "");
				}
			}

			// page = orderService.getOrderWaitForDisoType(page, siteId,"1", "jjgd",null);
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/*
	 * 短信发送失败历史工单的导出
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "exportWrongNumber")
	public String exportFile1(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			String wrongNumber = request.getParameter("no");
			String[] wm = wrongNumber.split(",");
			String number = "";
			for (String w : wm) {
				if ("".equals(number)) {
					number = "'" + w + "'";
				} else {
					number = number + ",'" + w + "'";
				}
			}
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<Record> list = null;
			List<String> cateList = null;
			List<String> brandList = null;
			if (!("2".equals(user.getUserType()))) {
				Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
				cateList = StringUtil.tolist(cateAndBrand.getVal1());
				brandList = StringUtil.tolist(cateAndBrand.getVal2());
			}
			list = orderService.getWrongNumberOrderHistoryList(siteId, "5", map, number, cateList, brandList);
			String phones = "";
			for (Record rd : list) {
				phones = (rd.getStr("customer_mobile"));
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone"))) {
					phones += "/" + (rd.getStr("customer_telephone"));
				}
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone2"))) {
					phones += "/" + (rd.getStr("customer_telephone2"));
				}
				rd.set("customer_mobile", phones);
				String rAccount = rd.getStr("record_account");
				if ("1".equals(rAccount)) {
					rd.set("record_account", "是");
				} else {
					rd.set("record_account", "否");
				}
				String seAt = rd.getStr("service_attitude");// 满意度
				if ("1".equals(seAt)) {
					rd.set("service_attitude", "十分不满意");
				}
				if ("2".equals(seAt)) {
					rd.set("service_attitude", "不满意");
				}
				if ("3".equals(seAt)) {
					rd.set("service_attitude", "一般");
				}
				if ("4".equals(seAt)) {
					rd.set("service_attitude", "满意");
				}
				if ("5".equals(seAt)) {
					rd.set("service_attitude", "十分满意");
				}
				if ("6".equals(seAt)) {
					rd.set("service_attitude", "无效回访");
				}
				if ("7".equals(seAt)) {
					rd.set("service_attitude", "回访未成功");
				}
			}
			new ExportJqExcel(title + "数据", stf.getTableHeader(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/*
	 * 短信发送失败历史工单的导出
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "exportWrongNumberDuring")
	public String exportWrongNumberDuring(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			String wrongNumber = request.getParameter("no");
			String[] wm = wrongNumber.split(",");
			String number = "";
			for (String w : wm) {
				if ("".equals(number)) {
					number = "'" + w + "'";
				} else {
					number = number + ",'" + w + "'";
				}
			}
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = request.getParameterMap();
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<Record> list = null;
			List<String> cateList = null;
			List<String> brandList = null;
			if (!("2".equals(user.getUserType()))) {
				Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
				cateList = StringUtil.tolist(cateAndBrand.getVal1());
				brandList = StringUtil.tolist(cateAndBrand.getVal2());
			}
			list = orderService.getWrongNumberOrderDuringList(siteId, "2", map, number, cateList, brandList);
			String phones = "";
			for (Record rd : list) {
				phones = (rd.getStr("customer_mobile"));
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone"))) {
					phones += "/" + (rd.getStr("customer_telephone"));
				}
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone2"))) {
					phones += "/" + (rd.getStr("customer_telephone2"));
				}
				rd.set("customer_mobile", phones);
				String rAccount = rd.getStr("record_account");
				if ("1".equals(rAccount)) {
					rd.set("record_account", "是");
				} else {
					rd.set("record_account", "否");
				}
				String seAt = rd.getStr("service_attitude");// 满意度
				if ("1".equals(seAt)) {
					rd.set("service_attitude", "十分不满意");
				}
				if ("2".equals(seAt)) {
					rd.set("service_attitude", "不满意");
				}
				if ("3".equals(seAt)) {
					rd.set("service_attitude", "一般");
				}
				if ("4".equals(seAt)) {
					rd.set("service_attitude", "满意");
				}
				if ("5".equals(seAt)) {
					rd.set("service_attitude", "十分满意");
				}
				if ("6".equals(seAt)) {
					rd.set("service_attitude", "无效回访");
				}
				if ("7".equals(seAt)) {
					rd.set("service_attitude", "回访未成功");
				}
			}
			new ExportJqExcel(title + "数据", stf.getTableHeader(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 自测方法案例
	@ResponseBody
	@RequestMapping(value = "getValueTest")
	public JSONObject getValueTest(HttpServletRequest request) {

		return null;
	}

	@ResponseBody
	@RequestMapping(value = "showPjMsg") // showPjMsg
	public Map<String, Object> showPjMsg(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = request.getParameter("siteId");
		if (StringUtils.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		String orderId = request.getParameter("orderId");
		String remark = request.getParameter("remark");
		List<Record> list = Lists.newArrayList();
		list = orderService.getPjMsg(list, orderId, siteId, remark);
		map.put("list", list);
		return map;
	}

	// 工单信息中配件使用的信息
	@ResponseBody
	@RequestMapping(value = "showSYMsg")
	public Map<String, Object> showSYMsg(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = request.getParameter("siteId");
		if (StringUtils.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		String orderNumber = request.getParameter("orderNumber");
		String remark = request.getParameter("remark");
		List<Record> list = Lists.newArrayList();
		list = orderFittingService.getPjMsg(list, orderNumber, siteId, remark);
		map.put("list", list);
		return map;
	}

	// 工单信息中关联商品销售的信息
	@ResponseBody
	@RequestMapping(value = "showGoodsMsg")
	public List<Record> showGoodsMsg(Model model, HttpServletRequest request, HttpServletResponse response) {
		String siteId = request.getParameter("siteId");
		if (StringUtils.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		String orderNumber = request.getParameter("orderNumber");
		return siteselfOrderService.orderVsGoods(siteId, orderNumber);
	}

	// 工单信息中关联商品销售的信息
	@ResponseBody
	@RequestMapping(value = "showGoodsMsg2017")
	public List<Record> showGoodsMsg2017(Model model, HttpServletRequest request, HttpServletResponse response) {
		String siteId = request.getParameter("siteId");
		if (StringUtils.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		String orderNumber = request.getParameter("orderNumber");
		return siteselfOrderService.orderVsGoods2017(siteId, orderNumber);
	}

	// 400工单信息中配件使用的信息
	@ResponseBody
	@RequestMapping(value = "showSYMsg400")
	public Map<String, Object> showSYMsg400(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderId = request.getParameter("orderId");
		String remark = request.getParameter("remark");
		List<Record> list = Lists.newArrayList();
		list = orderFittingService.getPjMsg400(list, orderId, siteId, remark);
		map.put("list", list);
		return map;
	}

	// 工单信息中配件申请的信息
	@ResponseBody
	@RequestMapping(value = "showSQMsg")
	public Map<String, Object> showSQMsg(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = request.getParameter("siteId");
		if (StringUtils.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		String orderNumber = request.getParameter("orderNumber");
		String remark = request.getParameter("remark");
		List<Record> list = Lists.newArrayList();
		list = orderFittingService.getPjMsg(list, orderNumber, siteId, remark);
		map.put("list", list);
		return map;
	}

	// 工单信息中旧件的信息
	@ResponseBody
	@RequestMapping(value = "showOldFitting")
	public Map<String, Object> showOldFitting(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = request.getParameter("siteId");
		if (StringUtils.isBlank(siteId)) {
			siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		String orderNumber = request.getParameter("orderNumber");
		List<Record> list = orderFittingService.getOldFitting(siteId, orderNumber);
		map.put("list", list);
		return map;
	}

	// 400工单信息中旧件的信息
	@ResponseBody
	@RequestMapping(value = "showOldFitting400")
	public Map<String, Object> showOldFitting400(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderId = request.getParameter("orderId");
		List<Record> list = orderFittingService.getOldFitting400(siteId, orderId);
		map.put("list", list);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersByTel")
	public Object getHistoryOrdersByTel(HttpServletRequest request) {
		return orderService.getHistoryOrdersByTel(request.getParameter("tel"));
	}

	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersBycodeIn")
	public Object getHistoryOrdersBycodeIn(HttpServletRequest request) {
		return orderService.getHistoryOrdersBycodeIn(request.getParameter("code"));
	}

	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersBycodeOut")
	public Object getHistoryOrdersBycodeOut(HttpServletRequest request) {
		return orderService.getHistoryOrdersBycodeOut(request.getParameter("code"));
	}

	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersCountByTel")
	public Object getHistoryOrdersCountByTel(HttpServletRequest request) {
		long cnt = orderService.getHistoryOrdersCountByTel(request.getParameter("tel"));
		Map<String, Object> ret = new HashMap<>();
		ret.put("cnt", cnt);
		return ret;
	}

	/* 校验内机条码是否有历史 */
	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersCodeInCountByTel")
	public Object getHistoryOrdersCodeInCountByTel(HttpServletRequest request) {
		long cnt = orderService.getHistoryOrdersCodeInCountByTel(request.getParameter("code"));
		Map<String, Object> ret = new HashMap<>();
		ret.put("cnt", cnt);
		return ret;
	}

	/* 校验外机条码是否有历史 */
	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersCodeOutCountByTel")
	public Object getHistoryOrdersCodeOutCountByTel(HttpServletRequest request) {
		long cnt = orderService.getHistoryOrdersCodeOutCountByTel(request.getParameter("code"));
		Map<String, Object> ret = new HashMap<>();
		ret.put("cnt", cnt);
		return ret;
	}

	/* 校验外机条码是否有历史 */
	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersCodeOutCountByTelDetail")
	public Object getHistoryOrdersCodeOutCountByTelDetail(HttpServletRequest request) {
		String f = request.getParameter("f");
		AtomicLong atomicLong = fromMap.get(f);
		if (atomicLong != null) {
			atomicLong.getAndIncrement();
			if (atomicLong.get() > 1000000) {
				atomicLong.set(0);
			}
		} else {
			AtomicLong other = fromMap.get("other");
			other.getAndIncrement();
			if (other.get() > 1000000) {
				other.set(0);
			}
		}

		long cnt = orderService.getHistoryOrdersCodeOutCountByTelDetail(request.getParameter("code"), request.getParameter("id"));
		Map<String, Object> ret = new HashMap<>();
		ret.put("cnt", cnt);
		return ret;
	}

	/* 校验外机条码是否有历史 */
	@ResponseBody
	@RequestMapping(value = "getHistoryOrdersCodeOutCountByTelDetail2017")
	public Object getHistoryOrdersCodeOutCountByTelDetail2017(HttpServletRequest request) {
		long cnt = orderService.getHistoryOrdersCodeOutCountByTelDetail2017(request.getParameter("code"), request.getParameter("id"));
		Map<String, Object> ret = new HashMap<>();
		ret.put("cnt", cnt);
		return ret;
	}

	/*
	 * 确认交款
	 */
	@ResponseBody
	@RequestMapping(value = "confirmCollection")
	public Object confirmCollection(String id, String mnys, HttpServletRequest request, HttpServletResponse response) {
		return orderService.confirmCollection(id, mnys);
	}

	/*
	 * 确认交款
	 */
	@ResponseBody
	@RequestMapping(value = "confirmCollection2017")
	public Object confirmCollection2017(String id, String mnys, HttpServletRequest request, HttpServletResponse response) {
		return orderService.confirmCollection2017(id, mnys);
	}

	/*
	 * 确认交单
	 */
	@ResponseBody
	@RequestMapping(value = "confirmCard")
	public String confirmCard(String id, String relMoney, String ifSelect, String oneOrMore, HttpServletRequest request, HttpServletResponse response) {
		return orderService.confirmCard(id, relMoney, ifSelect, oneOrMore);
	}

	/*
	 * 确认交单
	 */
	@ResponseBody
	@RequestMapping(value = "confirmCard2017")
	public String confirmCard2017(String id, String relMoney, String ifSelect, String oneOrMore, HttpServletRequest request, HttpServletResponse response) {
		return orderService.confirmCard2017(id, relMoney, ifSelect, oneOrMore);
	}

	/*
	 * 短信条数
	 */
	@ResponseBody
	@RequestMapping(value = "msgNumbers")
	public Integer getMsgNumbers(String content, String sign, String markType, HttpServletRequest request, HttpServletResponse response) {
		return orderService.getMsgNumbers(content, sign, markType);
	}

	/*
	 * 服务商剩余短信条数
	 */
	@ResponseBody
	@RequestMapping(value = "remainMsgNum")
	public Record getRemainMsgNum(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getRemainMsgNum(siteId);
	}

	/*
	 * 执行发送短信操作 已使用 自己编辑短信发送，不用模板 群发
	 */
	@ResponseBody
	@RequestMapping(value = "sendMsg")
	public String getSendMsg(String content, String sign, String mobile, String number, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getSendMsg(content, sign, mobile, siteId, number);
	}

	/*
	 * 执行发送短信操作 已使用 400 非模板发送短信 单个
	 */
	@ResponseBody
	@RequestMapping(value = "sendMsg400")
	public String getSendMsg400(String content, String sign, String mobile, String number, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getSendMsg400(content, sign, mobile, siteId, number);
	}

	/**
	 * 派工或转派中给周边用户发送短信
	 */
	@ResponseBody
	@RequestMapping(value = "sendInDispOrTurnDisp")
	public String sendInDispOrTurnDisp(String content, String sign, String mobile, String number, HttpServletRequest request, HttpServletResponse response) {
		String[] contents = content.split("#");
		String[] mobiles = mobile.split(",");
		String[] numbers = number.split(",");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Integer mks = 0;
		for (int i = 0; i < contents.length; i++) {
			Integer nums = orderService.getMsgNumbers(contents[i], sign, "");// 短信的字数，看是多少条短信
			mks = nums * mobiles.length;
		}
		Record rdNum = Db.findFirst("select sms_available_amount from crm_site a where a.id=?", siteId);
		if (mks > rdNum.getInt("sms_available_amount")) {
			return "noMessage";
		}
		for (int i = 0; i < contents.length; i++) {
			orderService.sendInDispOrTurnDisp(contents[i], sign, mobiles[i], siteId, numbers[i]);
		}
		return "ok";
	}

	/*
	 * 短信催单//短信催单-编辑的短信-不是模板 发送
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsg")
	public String getFwzSendmsg(String content, String sign, String orderMsgMobile, String orderMsgId, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getFwzSendmsg(content, sign, orderMsgMobile, siteId, orderMsgId);
	}

	/*
	 * 短信通知（短信模板）短信催单-模板发送
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsgModel")
	public String getFwzSendmsgModel(String temId, String sign, String content, String extno, String orderId, String customerMobile, HttpServletRequest request,
			HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getFwzSendmsgModel(temId, sign, content, extno, orderId, customerMobile, siteId);
	}

	/*
	 * 短信通知（短信模板）（目前已使用：系统短信模板-群发）
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsgModelFwz")
	public String fwzSendmsgModelFwz(String temId, String sign, String content, String extno, String number, String customerMobile, String yxId, String oneHref, String endMode,
			HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.fwzSendmsgModelFwz(temId, sign, content, extno, number, customerMobile, siteId, yxId, oneHref, endMode);
	}

	/*
	 * 短信通知（短信模板）已使用 系统短信模板-单个发送
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsgModelFwzOne")
	public String fwzSendmsgModelFwzOne(String temId, String sign, String content, String extno, String number, String customerMobile, String yxId, String oneHref, String endMode,
			String definedContentTz, String target, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.fwzSendmsgModelFwzOne(temId, sign, content, extno, number, customerMobile, siteId, yxId, oneHref, endMode, definedContentTz, target);
	}

	/*
	 * 根据id获取tag 短信发送
	 */
	@ResponseBody
	@RequestMapping(value = "getTag")
	public List<Record> getTag(String tag, HttpServletRequest request, HttpServletResponse response) {
		return orderService.getTag(tag);
	}

	@ResponseBody
	@RequestMapping(value = "getsmsbyid")
	public Record getsmsbyid(String id, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return smsTempletService.getsmsById(id, siteId);
	}

	/*
	 * 待回访结算工单模板短信通知
	 */
	@ResponseBody
	@RequestMapping(value = "pingjia")
	public Record pingjia(String id, HttpServletRequest request, HttpServletResponse response) {
		return orderService.pingjia(id);
	}

	@ResponseBody
	@RequestMapping(value = "count2")
	public Long count2(String orderId, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getPjMsg1(orderId, siteId);
	}

	@ResponseBody
	@RequestMapping(value = "mark")
	public String mark(String ids, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.mark(ids, siteId);
	}

	@RequestMapping(value = "importUnfinishedOrder")
	@ResponseBody
	public JSONObject importUnfinishedOrder(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		User user = UserUtils.getUser();
		Map<String, String> params = Maps.newHashMap();
		Map<String, Object> retMap = Maps.newHashMap();
		params.put("fileName", file.getOriginalFilename());
		String siteId = CrmUtils.getCurrentSiteId(user);
		Site site = siteService.get(siteId);
		params.put("siteId", siteId);
		params.put("siteName", site.getName());
		String templateId = request.getParameter("templateId");
		try {
			logger.info("*******************************************************import dpg start,sid=" + siteId + ";siteName:" + site.getName());
			if ("0".equals(templateId)) {
				retMap = orderService.importUnfinishedOrder(params, file.getInputStream());
			} else {
				params.put("isHistory", "N");
				params.put("templateId", templateId);
				params.put("extName", StringUtil.getFileExtName(file.getOriginalFilename()));
				retMap = orderService.importEOrderExcelTemplate(params, file.getInputStream());
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			orderService.onOrderCountChanged(siteId, "import-dpg");
		}
		return JSONObject.fromObject(retMap);
	}

	@RequestMapping(value = "checkUnfinishedOrderExcel")
	@ResponseBody
	public JSONObject checkUnfinishedOrderExcel(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> params = Maps.newHashMap();
		Map<String, Object> retMap = Maps.newHashMap();
		String templateId = request.getParameter("templateId");
		params.put("extName", StringUtil.getFileExtName(file.getOriginalFilename()));
		params.put("templateId", templateId);
		try {
			if ("0".equals(templateId)) {
				retMap = orderService.checkUnfinishedOrder(params, file.getInputStream());
			} else {
				retMap = orderService.checkEOrderExcelTemplate(params, file.getInputStream());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return JSONObject.fromObject(retMap);
	}

	/**
	 * 历史工单导入（数据检测）
	 * 
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "checkHistoryOrderExcel")
	@ResponseBody
	public JSONObject checkHistoryOrderExcel(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> params = Maps.newHashMap();
		Map<String, Object> retMap = Maps.newHashMap();
		String templateId = request.getParameter("templateId");
		params.put("extName", StringUtil.getFileExtName(file.getOriginalFilename()));
		params.put("templateId", templateId);
		try {

			if ("0".equals(templateId)) {
				retMap = orderService.checkHistoryOrder(params, file.getInputStream());
			} else {
				retMap = orderService.checkEOrderExcelTemplate(params, file.getInputStream());
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return JSONObject.fromObject(retMap);
	}

	/**
	 * 历史工单（数据）导入
	 * 
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "importHistoryOrder")
	@ResponseBody
	public JSONObject importHistoryOrder(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		User user = UserUtils.getUser();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date da = new Date();
		String now = sf.format(da);
		Map<String, String> params = Maps.newHashMap();
		Map<String, Object> retMap = Maps.newHashMap();
		params.put("fileName", file.getOriginalFilename());
		String siteId = CrmUtils.getCurrentSiteId(user);
		Site site = siteService.get(siteId);
		params.put("siteId", siteId);
		params.put("siteName", site.getName());
		params.put("createTime", now);
		String templateId = request.getParameter("templateId");
		try {
			logger.info("*******************************************************import history start,sid=" + siteId + ";siteName:" + site.getName());
			if ("0".equals(templateId)) {
				retMap = orderService.importHistoryOrder(params, file.getInputStream());
			} else {
				params.put("templateId", templateId);
				params.put("extName", StringUtil.getFileExtName(file.getOriginalFilename()));
				retMap = orderService.importEOrderExcelOlatform(params, file.getInputStream());
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			orderService.onOrderCountChanged(siteId, "import-history");
		}
		return JSONObject.fromObject(retMap);
	}

	/*
	 * 查询是否有相似的工单
	 */
	@ResponseBody
	@RequestMapping(value = "getOrderMobile")
	public String getOrderMobile(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Order or = orderService.get(id);
		Record rd = orderService.getOrderMobile(or, siteId);
		if (rd != null) {
			rd.set("time", DateUtils.formatDate(rd.getDate("create_time"), "yyyy-MM-dd HH:mm:ss"));
		}
		return JsonMapper.nonDefaultMapper().toJson(rd);
	}

	@ResponseBody
	@RequestMapping(value = "getOrder2017Mobile")
	public String getOrder2017Mobile(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		HistoryBkOrder or = new HistoryBkOrder(orderService.get2017(id, siteId));
		Record rd = orderService.getOrder2017Mobile(or, siteId);
		if (rd != null) {
			rd.set("time", DateUtils.formatDate(rd.getDate("create_time"), "yyyy-MM-dd HH:mm:ss"));
		}
		return JsonMapper.nonDefaultMapper().toJson(rd);
	}

	/*
	 * 反馈封单中删除备件使用记录
	 */
	@ResponseBody
	@RequestMapping(value = "deleteOneFittingRecord")
	public Object deleteOneFittingRecord(String id, String siteId, HttpServletRequest request, HttpServletResponse response) {
		return orderFittingService.deleteOneFittingRecord(id, siteId);
	}

	/*
	 * 批量删除无效工单
	 */
	@ResponseBody
	@RequestMapping(value = "delWxgd")
	public Object delWxgd(String ids, HttpServletRequest request, HttpServletResponse response) {
		String[] idsToDel = request.getParameterValues("idsToDel[]");
		return orderService.delWxgd(idsToDel);
	}

	@ResponseBody
	@RequestMapping(value = "delWxgd2017")
	public Object delWxgd2017(String ids, HttpServletRequest request, HttpServletResponse response) {
		String[] idsToDel = request.getParameterValues("idsToDel[]");
		return orderService.delWxgd2017(idsToDel);
	}

	/**
	 * 标记工单，单个标记和批量标记都统一处理。
	 */
	@ResponseBody
	@RequestMapping(value = "markOrders")
	public void markOrders(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("ids");
		String flag = request.getParameter("flag");
		String orderType = request.getParameter("type");
		String flagAlertTime = request.getParameter("alertTime");
		String flagDesc = request.getParameter("flagDesc");

		if (StringUtil.isBlank(ids)) {
			throw new RuntimeException("ids required");
		}
		if (StringUtil.isBlank(flag)) {
			throw new RuntimeException("flag required");
		}

		if ("400".equals(orderType)) {
			changeSelfOrderService.markOrders(ids.split(","), flag, flagDesc, flagAlertTime);
		} else {
			orderService.markOrders(ids.split(","), flag, flagDesc, flagAlertTime);
		}
	}

	/**
	 * 标记工单，单个标记和批量标记都统一处理(2017工单)。
	 */
	@ResponseBody
	@RequestMapping(value = "markOrdersFor2017")
	public void markOrdersFor2017(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("ids");
		String flag = request.getParameter("flag");
		String orderType = request.getParameter("type");
		String flagAlertTime = request.getParameter("alertTime");
		String flagDesc = request.getParameter("flagDesc");

		if (StringUtil.isBlank(ids)) {
			throw new RuntimeException("ids required");
		}
		if (StringUtil.isBlank(flag)) {
			throw new RuntimeException("flag required");
		}

		if ("400".equals(orderType)) {
			changeSelfOrderService.markOrdersFor2017(ids, flag, flagDesc, flagAlertTime);
		} else {
			orderService.markOrdersFor2017(ids.split(","), flag, flagDesc, flagAlertTime);
		}
	}

	@ResponseBody
	@RequestMapping(value = "cancelOrdersMark")
	public void cancelOrdersMark(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String orderType = request.getParameter("type");
		if (StringUtil.isBlank(ids)) {
			throw new RuntimeException("ids required");
		}
		if ("400".equals(orderType)) {
			changeSelfOrderService.cancelOrdersMark(ids.split(","));
		} else {
			orderService.cancelOrdersMark(ids.split(","));
		}
	}

	/**
	 * 取消标记工单（2017）
	 * 
	 * @param request
	 */
	@ResponseBody
	@RequestMapping(value = "cancelOrdersMarkFor2017")
	public void cancelOrdersMarkFor2017(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String orderType = request.getParameter("type");
		if (StringUtil.isBlank(ids)) {
			throw new RuntimeException("ids required");
		}
		if ("400".equals(orderType)) {
			changeSelfOrderService.cancelOrdersMarkFor2017(ids);
		} else {
			orderService.cancelOrdersMarkFor2017(ids.split(","));
		}
	}

	@RequestMapping(value = "showMarkOrders")
	public String showMarkOrder(HttpServletRequest request, Model model) {
		String ids = request.getParameter("ids");
		String orderType = request.getParameter("type"); // 400还是自接工单
		orderType = StringUtil.isBlank(orderType) ? "order" : "400";
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("ids", ids);
		model.addAttribute("type", orderType);
		return "modules/order/orderManagement/flag_add";
	}

	/**
	 * 标记2017的工单
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "showMarkOrdersFor2017")
	public String showMarkOrdersFor2017(HttpServletRequest request, Model model) {
		String ids = request.getParameter("ids");
		String orderType = request.getParameter("type"); // 400还是自接工单
		orderType = StringUtil.isBlank(orderType) ? "order" : "400";
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("ids", ids);
		model.addAttribute("type", orderType);
		return "modules/order/orderManagement/flagAddFor2017";
	}

	/**
	 * 快速查询
	 */
	@RequestMapping(value = "orderQuick")
	public String getorderQuick(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String comp = request.getParameter("comp");
		String type = request.getParameter("type");
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, "/a/order/Whole");
		model.addAttribute("headerData", stf);
		SiteTableHeaderForm stf400 = JqGridTableUtils.getCustomizedTableHead(siteId, "/a/order/ChangeSelfOrder/headerList");
		model.addAttribute("headerData400", stf400);
		model.addAttribute("comp", comp);
		model.addAttribute("type", type);
		return "modules/order/orderManagement/orderquickList";
	}

	@ResponseBody
	@RequestMapping(value = "getorderQuick")
	public String getorderQuickList(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String stam = request.getParameter("comp");
		String type = request.getParameter("type");
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = null;
		page = orderService.getorderListQuick(pages, siteId, stam, type);
		return renderJson(new JqGridPage<>(page));
	}

	@ResponseBody
	@RequestMapping(value = "getorderQuick400")
	public String getorderQuickLis400(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String stam = request.getParameter("comp");
		String type = request.getParameter("type");
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = null;
		page = orderService.getorderListQuick400(pages, siteId, stam, type);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * 录单确认
	 */
	@ResponseBody
	@RequestMapping(value = "confirmAccount")
	public Result<T> confirmAccount(String id, String factoryNumber, HttpServletRequest request) {
		return orderService.confirmAccount(id, factoryNumber);
	}

	/*
	 * 录单确认
	 */
	@ResponseBody
	@RequestMapping(value = "confirmAccount2017")
	public Result<T> confirmAccount2017(String id, String factoryNumber, HttpServletRequest request) {
		return orderService.confirmAccount2017(id, factoryNumber);
	}

	/*
	 * 今日提醒标记
	 */
	@RequestMapping(value = "jrtxbj")
	public String jrtxbj(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("order", order);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listOrigin = orderOriginService.filterOrderOrigin(siteId);
		List<String> listOriginlist = new ArrayList<>();
		for (Record rd : listOrigin) {
			listOriginlist.add(rd.getStr("name"));
		}
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("listoriginlist", listOriginlist);
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		String setFlag = siteSettleService.getSiteSettleFlag(siteId);
		model.addAttribute("settleFlag", setFlag);
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		String ptype = UserUtils.getUser().getUserType();
		model.addAttribute("ptype", ptype);
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(ptype))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		model.addAttribute("cateList", cateList);
		model.addAttribute("brandList", brandList);

		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);

		return "modules/order/orderManagement/whole/jrtxbjList";
	}

	/*
	 * 今日提醒标记列表
	 */
	@ResponseBody
	@RequestMapping(value = "jrtxbjList")
	public String jrtxbjList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			Tuple<String, String> cateAndBrand = noService.getNonServicemanCateAndBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cateAndBrand.getVal1());
			brandList = StringUtil.tolist(cateAndBrand.getVal2());
		}
		Page<Record> page = orderService.getJrtxbjList(pages, siteId, null, map, cateList, brandList);
		return renderJson(new JqGridPage<>(page));
	}

	/**
	 * 批量复制工单
	 */

	@ResponseBody
	@RequestMapping(value = "copyOrder")
	public String copyOrder(HttpServletRequest request) {
		String orderId = request.getParameter("id");
		int nums = Integer.parseInt(request.getParameter("nums"));
		if (StringUtils.isBlank(orderId)) {
			return "400";
		}
		return orderService.copyOrder(orderId, nums);
	}

	@ResponseBody
	@RequestMapping(value = "getDistance")
	public String getDistances(String customProvince, String customArea, String customCity, String customAdress) {
		String distance;
		String customAdresses = customProvince + customCity + customArea + customAdress;
		double[] customGPS = Apiutils.addressToGPS(customAdresses);
		String customlng = null;
		String customlat = null;
		if (customGPS != null) {
			if (customGPS.length != 0 && customGPS.length == 2) {
				customlng = String.valueOf(customGPS[0]);
				customlat = String.valueOf(customGPS[1]);
			}
		}
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record rd = siteManagerService.querySiteByid(siteId);
		String sitelnglat = rd.getStr("lnglat");
		String address = rd.getStr("province") + rd.getStr("city") + rd.getStr("area") + rd.getStr("address");
		boolean isSiteGPSOk = StringUtils.isNotEmpty(sitelnglat);
		String[] siteLnglats;
		String sitelng = null;
		String sitelat = null;
		if (isSiteGPSOk) {
			siteLnglats = sitelnglat.split(",");
			if (siteLnglats != null && siteLnglats.length == 2) {
				sitelng = siteLnglats[0];
				sitelat = siteLnglats[1];
			} else if (StringUtils.isNotBlank(address)) {
				double[] da = Apiutils.addressToGPS(address);
				if (da != null && da.length == 2) {
					sitelng = Double.toString(da[0]);
					sitelat = Double.toString(da[1]);
				}
			}
		} else {
			if (StringUtils.isNotBlank(address)) {
				double[] da = Apiutils.addressToGPS(address);
				if (da != null && da.length == 2) {
					sitelng = Double.toString(da[0]);
					sitelat = Double.toString(da[1]);
				}
			}
		}
		double d;
		if (StringUtils.isNotEmpty(customlng) && StringUtils.isNotEmpty(customlat) && StringUtils.isNotEmpty(sitelng) && StringUtils.isNotEmpty(sitelat)) {
			d = GPSUtil.getDistance(customlng, customlat, sitelng, sitelat);
		} else {
			d = Double.MAX_VALUE;
		}
		if (d == Double.MAX_VALUE) {
			distance = "未知";
		} else {
			distance = String.valueOf(d);
		}
		return distance;
	}

	// 交单数据提取到弹出框
	@ResponseBody
	@RequestMapping(value = "jiaodanPageShow")
	public Map<String, Object> jiaodanPageShow(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		return orderService.jiaodanPageShow(ids);
	}

	@ResponseBody
	@RequestMapping(value = "jiaodanPageShow2017")
	public Map<String, Object> jiaodanPageShow2017(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		return orderService.jiaodanPageShow2017(ids);
	}

	@ResponseBody
	@RequestMapping(value = "canMarkAsInvalid")
	public String canMarkAsInvalid(HttpServletRequest request) {
		String[] ids = request.getParameterValues("ids[]");
		if (ids == null || ids.length <= 0) {
			return "N";
		}
		return orderService.canMarkAsInvalid(ids);
	}

	@RequestMapping(value = "showHistoryPopup")
	public String showHistoryPopup(HttpServletRequest request, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<Record> orders = orderService.getHistoryOrdersBycodeIn2(request.getParameter("code"), request.getParameter("id"), siteId);
		if (orders.size() > 0) {
			for (Record rd : orders) {
				String status = rd.getStr("status");
				String type = rd.getStr("warranty_type");
				String zt = "";
				String wt = "";
				if ("0".equals(status)) {
					zt = "待接收";
				}
				if ("1".equals(status)) {
					zt = "待派工";
				}
				if ("2".equals(status)) {
					zt = "服务中";
				}
				if ("3".equals(status)) {
					zt = "待回访待结算";
				}
				if ("4".equals(status)) {
					zt = "已回访待结算";
				}
				if ("5".equals(status)) {
					zt = "已完成";
				}
				if ("6".equals(status)) {
					zt = "取消工单";
				}
				if ("7".equals(status)) {
					zt = "暂不派工";
				}
				if ("8".equals(status)) {
					zt = "无效工单";
				}
				if ("1".equals(type)) {
					wt = "保内";
				}
				if ("2".equals(type)) {
					wt = "保外";
				}
				rd.set("stas", zt);
				rd.set("typ", wt);
			}
		}
		model.addAttribute("orders", orders);
		return "modules/order/orderHistory";
	}

	@RequestMapping(value = "showHistoryPopupDetail")
	public String showHistoryPopupDetail(HttpServletRequest request, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<Record> orders = orderService.showHistoryPopupDetail(request.getParameter("code"), request.getParameter("id"), siteId);
		if (orders.size() > 0) {
			for (Record rd : orders) {
				String status = rd.getStr("status");
				String type = rd.getStr("warranty_type");
				String zt = "";
				String wt = "";
				if ("0".equals(status)) {
					zt = "待接收";
				}
				if ("1".equals(status)) {
					zt = "待派工";
				}
				if ("2".equals(status)) {
					zt = "服务中";
				}
				if ("3".equals(status)) {
					zt = "待回访待结算";
				}
				if ("4".equals(status)) {
					zt = "已回访待结算";
				}
				if ("5".equals(status)) {
					zt = "已完成";
				}
				if ("6".equals(status)) {
					zt = "取消工单";
				}
				if ("7".equals(status)) {
					zt = "暂不派工";
				}
				if ("8".equals(status)) {
					zt = "无效工单";
				}
				if ("1".equals(type)) {
					wt = "保内";
				}
				if ("2".equals(type)) {
					wt = "保外";
				}
				rd.set("stas", zt);
				rd.set("typ", wt);
			}
		}
		model.addAttribute("orders", orders);
		return "modules/order/orderHistory";
	}

	@RequestMapping(value = "showHistoryPopupDetail2017")
	public String showHistoryPopupDetail2017(HttpServletRequest request, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<Record> orders = orderService.showHistoryPopupDetail2017(request.getParameter("code"), request.getParameter("id"), siteId);
		if (orders.size() > 0) {
			for (Record rd : orders) {
				String status = rd.getStr("status");
				String type = rd.getStr("warranty_type");
				String zt = "";
				String wt = "";
				if ("0".equals(status)) {
					zt = "待接收";
				}
				if ("1".equals(status)) {
					zt = "待派工";
				}
				if ("2".equals(status)) {
					zt = "服务中";
				}
				if ("3".equals(status)) {
					zt = "待回访待结算";
				}
				if ("4".equals(status)) {
					zt = "已回访待结算";
				}
				if ("5".equals(status)) {
					zt = "已完成";
				}
				if ("6".equals(status)) {
					zt = "取消工单";
				}
				if ("7".equals(status)) {
					zt = "暂不派工";
				}
				if ("8".equals(status)) {
					zt = "无效工单";
				}
				if ("1".equals(type)) {
					wt = "保内";
				}
				if ("2".equals(type)) {
					wt = "保外";
				}
				rd.set("stas", zt);
				rd.set("typ", wt);
			}
		}
		model.addAttribute("orders", orders);
		return "modules/order/orderHistory";
	}

	@ResponseBody
	@RequestMapping(value = "canBatchCopy")
	public String canBatchCopy(HttpServletRequest request) {
		String[] ids = request.getParameterValues("ids[]");
		if (ids == null || ids.length <= 0) {
			return "500";
		}
		return orderService.canBatchCopy(ids);
	}

	@ResponseBody
	@RequestMapping(value = "checkIfAllowSendMsg")
	public String checkIfAllowSendMsg(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String code = orderService.checkIfAllowSendMsg(siteId);
		return code;
	}

	@ResponseBody
	@RequestMapping(value = "getOrderMsgsByOneId")
	public Map<String, Object> getOrderMsgsByOneId(String id, HttpServletRequest request) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new HashMap<>();
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		map.put("oneHref", ret);
		Order order = orderService.get(id);
		Record rd = orderDispatchService.getSiteMsg(siteId);
		if (StringUtils.isNotBlank(order.getEmployeId())) {
			Map<String, String> msg2 = orderDispatchService.getEmployeMsg1(order.getEmployeId());
			map.put("msg1", msg2.get("nameMobile"));
		} else {
			map.put("msg1", "");
		}
		map.put("serviceName", CrmUtils.getSignBySiteId(siteId));
		map.put("customerName", order.getCustomerName());
		map.put("serviceType", order.getServiceType());
		return map;
	}

	/**
	 * 根据详细地址获取周边用户信息
	 */
	@ResponseBody
	@RequestMapping(value = "geteArroundCustInfo")
	public List<Record> geteArroundCustInfo(HttpServletRequest request) {
		String address = request.getParameter("address");
		String orderId = request.getParameter("orderId");
		String mobile = request.getParameter("mobile");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		StringBuffer sb = new StringBuffer();
		sb.append(" select t.* from( ");
		sb.append(
				" SELECT customer_name,customer_mobile,customer_telephone,customer_telephone2,number,concat(appliance_brand,appliance_category) as applBranCate ,DATE_FORMAT(repair_time,'%Y-%m-%d') as repair_time");
		sb.append(" FROM crm_order");
		sb.append(" WHERE customer_address LIKE '%" + address + "%' and site_id=? ");
		if (StringUtils.isNotBlank(orderId)) {
			sb.append("and id != '" + orderId + "' ");
		}
		if (StringUtils.isNotBlank(mobile)) {
			sb.append("and customer_mobile!='" + mobile + "' ");
		}
		sb.append("and status='5' limit 1000) as t ");
		sb.append(" GROUP BY t.customer_mobile limit 100 ");
		return Db.find(sb.toString(), siteId);
	}

	@ResponseBody
	@RequestMapping(value = "getOrderInfoById")
	public Record getOrderInfoById(HttpServletRequest request) {
		String id = request.getParameter("orderId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return Db.findFirst("select * from crm_order where id=? and site_id=? limit 1 ", id, siteId);
	}

	@RequestMapping(value = "erjiDispatch")
	@ResponseBody
	public Map<String, Object> erjiDispatch(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String secondSiteId = request.getParameter("secondSiteId");
		String secondSiteName = request.getParameter("secondSiteName");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.erjiDispatch(ids, secondSiteId, secondSiteName, siteId);
	}

	// 短信群发
	@RequestMapping(value = "sendMsgAccounts")
	public String sendMsgAccounts(HttpServletRequest request, Model model) {
		String ids = request.getParameter("ids");
		Order order = orderService.get(ids.split(",")[0]);
		String marks = request.getParameter("marks");// 2表示待派工
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record rd = orderDispatchService.getSiteMsg(siteId);
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String siteArea = rd.getStr("area");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		Map<String, Object> mapDt = getParams(request);
		model.addAttribute("mapDt", mapDt);
		model.addAttribute("marks", marks);
		model.addAttribute("type", request.getParameter("type"));
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("siteName", siteName);
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

		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel("2");
		model.addAttribute("listModel", listModel);
		// 自定义模板获取
		List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
		model.addAttribute("definedmodel", definedmodel);
		model.addAttribute("order", order);
		model.addAttribute("ids", ids);
		model.addAttribute("site", siteDao.get(siteId));
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);
		return "modules/order/sendMsg/sendMsgAccounts";
	}

	// 短信群发
	@RequestMapping(value = "sendMsgAccountsOne")
	public String sendMsgAccountsOne(HttpServletRequest request, Model model) {
		String ids = request.getParameter("ids");
		Order order = orderService.get(ids);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record site = siteService.getSiteId(siteId);
		String jdPhone = site.getStr("sms_phone");
		String siteMobile = site.getStr("mobile");
		String siteName = site.getStr("name");
		String siteArea = site.getStr("area");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		Map<String, Object> mapDt = getParams(request);
		model.addAttribute("mapDt", mapDt);
		model.addAttribute("type", request.getParameter("type"));
		model.addAttribute("target", request.getParameter("target"));
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("siteName", siteName);
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

		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel("2");
		model.addAttribute("listModel", listModel);
		// 自定义模板获取
		List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
		model.addAttribute("definedmodel", definedmodel);
		model.addAttribute("order", order);
		model.addAttribute("ids", ids);
		model.addAttribute("site", siteDao.get(siteId));
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);
		return "modules/order/sendMsg/sendMsgAccountsOne";
	}

	/*
	 * 短信通知（短信自定义模板）已使用 服务商自定义模板-群发/单个发送
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsgModelFwzDefined1")
	public String fwzSendmsgModelFwzDefined1(String temId, String sign, String content, String extno, String number, String yxId, String customerMobile, String markType,
			HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.fwzSendmsgModelFwzDefined(temId, sign, content, extno, number, customerMobile, siteId, yxId, markType);
	}

	/*
	 * 短信通知（短信自定义模板）
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsgModelFwzDefined1400")
	public String fwzSendmsgModelFwzDefined1400(String temId, String sign, String content, String extno, String number, String yxId, String customerMobile, String markType,
			HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.fwzSendmsgModelFwzDefined1400(temId, sign, content, extno, number, customerMobile, siteId, yxId, markType);
	}

	/*
	 * 平台工单
	 */
	@RequestMapping(value = "platformOrderList")
	public String platformOrderList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String userType = user.getUserType();
		model.addAttribute("ptype", userType);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("category", category);
		model.addAttribute("headerData", stf);
		model.addAttribute("siteId", siteId);
		model.addAttribute("signList", orderMarkSettingService.getSettingsBySiteId(siteId));

		return "modules/order/orderManagement/platform/platformOrder";
	}

	@ResponseBody
	@RequestMapping(value = "getPlatformCount")
	public Map<String, Long> getPlatformCount(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderType = request.getParameter("orderType");
		if (StringUtils.isNotBlank(orderType)) {
			if ("2".equals(orderType)) {//
				return orderService.getPlatformCount(siteId, "家电协会");
			}
		}
		return null;
	}

	@ResponseBody
	@RequestMapping(value = "getplatformOrderList")
	public String getplatformOrderList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = orderService.getPlatFormList(siteId, pages, map, "家电协会");
		model.addAttribute("page", page);
		return renderJson(new JqGridPage<>(page));
	}

	/*
	 * 服务商接收厂家工单
	 */
	@ResponseBody
	@RequestMapping(value = "recvOrdersFac")
	public Object recvOrdersFac(HttpServletRequest request) {
		String orderIds = request.getParameter("ids");
		return orderService.recvOrders(orderIds);
	}

	/*
	 * 服务商拒接工单
	 */
	@ResponseBody
	@RequestMapping(value = "refuseOrders")
	public Object refuseOrders(HttpServletRequest request) {
		String orderIds = request.getParameter("ids");
		return orderService.refuseOrders(orderIds);
	}

	@RequestMapping(value = "getFactoryReturnOrder")
	public String getFactoryReturn(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> params = getParams(request);
		Page<OrderReturnVisit> page = new Page<>(request, response);
		List<Map<String, Object>> returnlist = orderService.getreturnlist();
		Page<OrderReturnVisit> pages = orderService.getFactoryReturn(page, params, siteId, returnlist);
		model.addAttribute("visitList", returnlist);
		model.addAttribute("page", pages);
		return "modules/order/orderManagement/platform/factoryOrderReturnList";
	}

	@RequestMapping(value = "platformOrder/export")
	public String exportPlatformOrder(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
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
			Page<Record> page = orderService.getPlatFormList(siteId, pages, map, "家电协会");
			List<Record> list = page.getList();
			String phones = "";
			for (Record rd : list) {
				phones = (rd.getStr("customer_mobile"));
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone"))) {
					phones += "/" + (rd.getStr("customer_telephone"));
				}
				if (StringUtils.isNotBlank(rd.getStr("customer_telephone2"))) {
					phones += "/" + (rd.getStr("customer_telephone2"));
				}
				rd.set("customer_mobile", phones);
				String rAccount = rd.getStr("record_account");
				if ("1".equals(rAccount)) {
					rd.set("record_account", "是");
				} else {
					rd.set("record_account", "否");
				}
				String seAt = rd.getStr("service_attitude");// 满意度
				if ("1".equals(seAt)) {
					rd.set("service_attitude", "十分不满意");
				}
				if ("2".equals(seAt)) {
					rd.set("service_attitude", "不满意");
				}
				if ("3".equals(seAt)) {
					rd.set("service_attitude", "一般");
				}
				if ("4".equals(seAt)) {
					rd.set("service_attitude", "满意");
				}
				if ("5".equals(seAt)) {
					rd.set("service_attitude", "十分满意");
				}
				if ("6".equals(seAt)) {
					rd.set("service_attitude", "无效回访");
				}
				if ("7".equals(seAt)) {
					rd.set("service_attitude", "回访未成功");
				}
				if ("0".equals(rd.getStr("repair_record_account"))) {
					rd.set("repair_record_account", "未录单");
				} else if ("1".equals(rd.getStr("repair_record_account"))) {
					rd.set("repair_record_account", "已录单");
				}
				String status = rd.getStr("status");
				if ("0".equals(status)) {
					rd.set("status", "待接收");
				} else if ("1".equals(status)) {
					rd.set("status", "待派工");
				} else if ("2".equals(status)) {
					rd.set("status", "服务中");
				} else if ("3".equals(status)) {
					rd.set("status", "待回访");
				} else if ("4".equals(status)) {
					rd.set("status", "待结算");
				} else if ("5".equals(status)) {
					rd.set("status", "已完成");
				} else if ("6".equals(status)) {
					rd.set("status", "取消工单");
				} else if ("7".equals(status)) {
					rd.set("status", "暂不派工");
				} else if ("9".equals(status)) {
					rd.set("status", "未指派");
				} else {
					rd.set("status", "无效工单");
				}
				rd.set("c_service_type", StringUtils.isBlank(rd.getStr("service_type")) ? rd.getStr("c_service_type") : rd.getStr("service_type"));
			}

			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "getLatestEmployesByMobile")
	public String getLatestEmployesByMobile(HttpServletRequest request) {
		String mobile = request.getParameter("mobile");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getLatestEmployesByMobile(siteId, mobile);
	}

	// 短信群发
	@RequestMapping(value = "sendMsgAccounts400One")
	public String sendMsgAccounts400One(HttpServletRequest request, Model model) {
		String ids = request.getParameter("ids");
		CrmOrder400 order = changeSelfOrderService.getOrder400(ids);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record rd = orderDispatchService.getSiteMsg(siteId);
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String siteArea = rd.getStr("area");
		String proTime = "";
		if (order.getPromiseTime() != null) {
			proTime = order.getPromiseTime().toString().substring(0, 11);
		}
		Map<String, Object> mapDt = getParams(request);
		model.addAttribute("mapDt", mapDt);
		model.addAttribute("type", request.getParameter("type"));
		model.addAttribute("target", request.getParameter("target"));
		model.addAttribute("proTime", proTime);
		model.addAttribute("serviceName", CrmUtils.getSignBySiteId(siteId));
		model.addAttribute("jdPhone", jdPhone);
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("siteName", siteName);
		Map<String, Object> map = changeSelfOrderService.getEmpIdAndName2(order.getEmploye1(), order.getEmploye2(), order.getEmploye3(), siteId);
		model.addAttribute("msg1", map.get("msg1"));
		model.addAttribute("msg2Names", map.get("msg2"));
		model.addAttribute("msg2Mobiles", map.get("msg3"));
		model.addAttribute("msg4", map.get("msg4"));
		// 模板获取
		List<Record> listModel = MsgModelUtils.getListModel("2");
		model.addAttribute("listModel", listModel);
		// 自定义模板获取
		List<Record> definedModel = smsTempletService.getSmsmodel(siteId);
		model.addAttribute("definedmodel", definedModel);
		model.addAttribute("order", order);
		model.addAttribute("ids", ids);
		model.addAttribute("site", siteDao.get(siteId));
		String serviceType = order.getServiceType();
		if (StringUtils.isBlank(serviceType)) {
			serviceType = order.getcServiceType();
		}
		model.addAttribute("serviceType", serviceType);
		String erpwx = Global.getConfig("server.erpwx");
		String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
		String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
		model.addAttribute("oneHref", ret);
		return "modules/order/sendMsg/sendMsgAccounts400One";
	}

}