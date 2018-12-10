package com.jojowonet.modules.order.web;

import java.net.URLEncoder;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Category;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderMarkSetting;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.ChangeSelfOrderService;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderMarkSettingService;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.service.PushMessageService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.MsgModelUtils;
import com.jojowonet.modules.order.utils.OrderCountChangeTypes;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.SfJsonKit;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "${adminPath}/order/ChangeSelfOrder")
public class ChangeSelfOrderController extends BaseController {
	@Autowired
	private ChangeSelfOrderService changeSelfOrderService;
	@Autowired
	private OrderDispatchService orderDispatchService;
	@Autowired
	private OrderMarkSettingService orderMarkSettingService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private PushMessageService pushMessageService;

	public Map<String, Object> getFactory() {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> reList = changeSelfOrderService.selectFactory(siteId);
		Map<String, Object> map = Maps.newHashMap();
		map.put("meidi", "no");
		map.put("haier", "no");
		map.put("haixin", "no");
		map.put("huierpu", "no");
		map.put("geli", "no");
		map.put("aokesi", "no");
		map.put("meiling", "no");
		map.put("tcl", "no");
		map.put("suning", "no");
		map.put("guomei", "no");
		map.put("jingdong", "no");
		if (reList != null) {
			// 添加新品牌时记得在OrderSmallProgramController 中对应添加
			for (Record re : reList) {
				if ("美的".equals(re.getStr("name"))) {
					map.put("meidi", "has");
				} else if ("海尔".equals(re.getStr("name")) || "旧版海尔".equals(re.getStr("name"))) {
					map.put("haier", "has");
				} else if ("海信".equals(re.getStr("name"))) {
					map.put("haixin", "has");
				} else if ("惠而浦".equals(re.getStr("name"))) {
					map.put("huierpu", "has");
				} else if ("格力".equals(re.getStr("name"))) {
					map.put("geli", "has");
				} else if ("奥克斯".equals(re.getStr("name"))) {
					map.put("aokesi", "has");
				} else if ("美菱".equals(re.getStr("name"))) {
					map.put("meiling", "has");
				} else if ("tcl".equals(re.getStr("name")) || "TCL".equals(re.getStr("name"))) {
					map.put("tcl", "has");
				} else if ("苏宁".equalsIgnoreCase(re.getStr("name"))) {
					map.put("suning", "has");
				} else if ("国美".equalsIgnoreCase(re.getStr("name"))) {
					map.put("guomei", "has");
				} else if ("京东".equalsIgnoreCase(re.getStr("name"))) {
					map.put("jingdong", "has");
				}
			}
		}
		return map;
	}

	/*
	 * 获取400工单列表的表头header（美的）
	 */
	@RequestMapping(value = "headerList")
	public String getHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		model.addAttribute("flags", flags);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		List<Record> reList = changeSelfOrderService.selectFactory(siteId);

		Map<String, Object> printMap = Maps.newHashMap();
		printMap.put("template", "BJDY_1");
		List<Map<String, String>> printList = Lists.newArrayList();
		for (int i = 0; i < 3; i++) {
			Map<String, String> printItem = Maps.newHashMap();
			printItem.put("p1", "12");
			printItem.put("p2", "2");
			printList.add(printItem);
		}
		printMap.put("items", printList);
		String json = new Gson().toJson(printMap);
		model.addAttribute("json", URLEncoder.encode(json));

		if (reList.size() > 0) {
			model.addAttribute("brando", reList.get(0).getStr("name"));
			for (Record re : reList) {
				if ("美的".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/400Order";
				}
			}
			for (Record re : reList) {
				if ("海尔".equals(re.getStr("name")) || "旧版海尔".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/HaierOrder";
				}
			}
			for (Record re : reList) {
				if ("海信".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/HaiXinOrder";
				}
			}
			for (Record re : reList) {
				if ("惠而浦".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/HuiErPuOrder";
				}
			}
			for (Record re : reList) {
				if ("格力".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/GeLiOrder";
				}
			}
			for (Record re : reList) {
				if ("奥克斯".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/AoKeSiOrder";
				}
			}
			for (Record re : reList) {
				if ("美菱".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/MeiLingOrder";
				}
			}
			for (Record re : reList) {
				if ("tcl".equals(re.getStr("name")) || "TCL".equals(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/TclOrder";
				}
			}
			for (Record re : reList) {
				if ("苏宁".equalsIgnoreCase(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/SuningOrder";
				}
			}
			for (Record re : reList) {
				if ("国美".equalsIgnoreCase(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/GuomeiOrder";
				}
			}
			for (Record re : reList) {
				if ("京东".equalsIgnoreCase(re.getStr("name"))) {
					return "modules/order/orderManagement/400Order/JingdongOrder";
				}
			}
		}
		return "modules/order/orderManagement/400Order/blank";
	}

	/*
	 * 获取400工单列表的表头header（海尔）
	 */
	@RequestMapping(value = "haierHeaderList")
	public String getHaierHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/HaierOrder";
	}

	/*
	 * 获取400工单列表的表头header（海信）
	 */
	@RequestMapping(value = "haixinHeaderList")
	public String getHaixinHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/HaiXinOrder";
	}

	/*
	 * 获取400工单列表的表头header（惠而浦）
	 */
	@RequestMapping(value = "huierpuHeaderList")
	public String getHuierpuHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/HuiErPuOrder";
	}

	/*
	 * 获取400工单列表的表头header（格力）
	 */
	@RequestMapping(value = "geliHeaderList")
	public String getGeliHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/GeLiOrder";
	}

	/*
	 * 获取400工单列表的表头header（奥克斯）
	 */
	@RequestMapping(value = "aokesiHeaderList")
	public String getAokesiHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/AoKeSiOrder";
	}

	/*
	 * 获取400工单列表的表头header（美菱）
	 */
	@RequestMapping(value = "meilingHeaderList")
	public String getMeilingHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/MeiLingOrder";
	}

	/*
	 * 获取400工单列表的表头header（美菱）
	 */
	@RequestMapping(value = "tclHeaderList")
	public String tclHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/TclOrder";
	}

	@RequestMapping(value = "suningHeaderList")
	public String suningHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/SuningOrder";
	}

	// 国美工单
	@RequestMapping(value = "guomeiHeaderList")
	public String guomeiHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/GuomeiOrder";
	}

	// 京东工单
	@RequestMapping(value = "jingdongHeaderList")
	public String jingdongHeaderList(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("flags", flags);
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/JingdongOrder";
	}

	/*
	 * 获取400工单列表(美的)
	 */
	@ResponseBody
	@RequestMapping(value = "FourHandurandOrder")
	public String getFourHandurandOrderGrid(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "2");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(国美)
	 */
	@ResponseBody
	@RequestMapping(value = "FourGuomeiOrder")
	public String FourGuomeiOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "i");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(京东)
	 */
	@ResponseBody
	@RequestMapping(value = "FourJingdongOrder")
	public String FourJingdongOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "j");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(海尔)
	 */
	@ResponseBody
	@RequestMapping(value = "FourHaierOrder")
	public String getFourHaierOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "5");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(海信)
	 */
	@ResponseBody
	@RequestMapping(value = "FourHaixinOrder")
	public String getFourHaixinOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "4");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(惠而浦)
	 */
	@ResponseBody
	@RequestMapping(value = "FourHuierpuOrder")
	public String getFourHuierpuOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "3");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(格力)
	 */
	@ResponseBody
	@RequestMapping(value = "FourGeliOrder")
	public String getGeliOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "8");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(奥克斯)
	 */
	@ResponseBody
	@RequestMapping(value = "FourAokesiOrder")
	public String getAokesiOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "9");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(美菱)
	 */
	@ResponseBody
	@RequestMapping(value = "FourMeilingOrder")
	public String getMeilingOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "f");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(Tcl)
	 */
	@ResponseBody
	@RequestMapping(value = "FourTclOrder")
	public String getTclOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "g");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	/*
	 * 获取400工单列表(Suning)
	 */
	@ResponseBody
	@RequestMapping(value = "FourSuningOrder")
	public String getSuningOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<>(request, response);
		Page<Record> page = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "h");
		model.addAttribute("page", page);
		// return renderJson(new JqGridPage<>(page));
		return sfRenderJson(new JqGridPage<>(page));
	}

	@ResponseBody
	@RequestMapping(value = "getCounts")
	public Map<String, Long> getCounts(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String orderType = request.getParameter("orderType");
		if (StringUtils.isNotBlank(orderType)) {
			if ("2".equals(orderType)) {// 2.美的厂家系统
				return changeSelfOrderService.getCount(siteId);
			} else if ("3".equals(orderType)) {// 3.惠而浦厂家系统
				return changeSelfOrderService.getHuierpuCount(siteId);
			} else if ("4".equals(orderType)) {// 4.海信厂家系统
				return changeSelfOrderService.getHaixinCount(siteId);
			} else if ("5".equals(orderType)) {// 5.海尔厂家系统
				return changeSelfOrderService.getHaierCount(siteId);
			} else if ("9".equals(orderType)) {// 9.奥克斯厂家系统
				return changeSelfOrderService.getAokesiCount(siteId);
			} else if ("8".equals(orderType)) {// 8.格力厂家系统
				return changeSelfOrderService.getGeliCount(siteId);
			} else if ("f".equals(orderType)) {// f.美菱厂家系统
				return changeSelfOrderService.getMeilingCount(siteId);
			} else if ("g".equals(orderType)) {// g.Tcl厂家系统
				return changeSelfOrderService.getTclCount(siteId);
			} else if ("h".equals(orderType)) {// h.苏宁厂家系统
				return changeSelfOrderService.getSuningCount(siteId);
			} else if ("i".equals(orderType)) {// i.国美厂家系统
				return changeSelfOrderService.getSuningCount(siteId);
			} else if ("j".equals(orderType)) {// i.京东厂家系统
				return changeSelfOrderService.getJingdongCount(siteId);
			}
		}
		return null;
	}

	/* 历史400工单 */
	@RequestMapping(value = "exportForOld")
	public String exportForOld(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getListForOld400(siteId, pages, map);
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);

				String origin = getOrigin(rd);
				rd.set("origin", origin);
				return null; // 故意的，原先这块导入就是这样
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	private String getOrigin(Record rd) {
		if (StringUtils.isNotBlank(rd.getStr("order_type"))) {
			if ("2".equals(rd.getStr("order_type"))) {
				return "美的";
			} else if ("3".equals(rd.getStr("order_type"))) {
				return "惠而浦";
			} else if ("4".equals(rd.getStr("order_type"))) {
				return "海信";
			} else if ("5".equals(rd.getStr("order_type"))) {
				return "海尔";
			} else {
				return "";
			}
		}
		return null;
	}

	/* 导出美的 */
	@RequestMapping(value = "export")
	public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "2").getList();// changeSelfOrderService.getList(siteId, pages, map, "2");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出海尔 */
	@RequestMapping(value = "exportHaier")
	public String exportHaier(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "5").getList();// changeSelfOrderService.getList(siteId, pages, map, "5");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出海信 */
	@RequestMapping(value = "exportHaixin")
	public String exportHaixin(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "4").getList();// changeSelfOrderService.getList(siteId, pages, map, "4");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出惠而浦 */
	@RequestMapping(value = "exportHuierpu")
	public String exportHuierpu(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "3").getList();// changeSelfOrderService.getList(siteId, pages, map, "3");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出格力 */
	@RequestMapping(value = "exportGeli")
	public String exportGeli(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "8").getList();// changeSelfOrderService.getList(siteId, pages, map, "8");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出格力 */
	@RequestMapping(value = "exportMeiling")
	public String exportMeiling(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "f").getList();// changeSelfOrderService.getList(siteId, pages, map, "f");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出格力 */
	@RequestMapping(value = "exportSuning")
	public String exportSuning(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "h").getList();// changeSelfOrderService.getList(siteId, pages, map, "h");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出国美 */
	@RequestMapping(value = "exportGuomei")
	public String exportGuomei(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "i").getList();// getList(siteId, pages, map, "i");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出京东 */
	@RequestMapping(value = "exportJingdong")
	public String exportJingdong(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "j").getList();// changeSelfOrderService.getList(siteId, pages, map, "j");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@RequestMapping(value = "exportTcl")
	public String exportTcl(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getList(siteId, pages, map, "g");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 导出奥克斯 */
	@RequestMapping(value = "exportAokesi")
	public String exportAokesi(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			List<Record> list = null;
			list = changeSelfOrderService.getFourHandurandOrderGrid(siteId, pages, map, "9").getList();// changeSelfOrderService.getList(siteId, pages, map, "9");
			String emps = "";
			String serviceType = "";
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
				emps = changeSelfOrderService.getEmpIdAndName1(rd.getStr("employe1"), rd.getStr("employe2"), rd.getStr("employe3"));
				if (StringUtils.isNotBlank(rd.getStr("service_type"))) {
					serviceType = rd.getStr("service_type");
				}
				if (StringUtils.isNotBlank(rd.getStr("c_service_type"))) {
					serviceType = rd.getStr("c_service_type");
				}
				rd.set("c_service_type", serviceType);
				rd.set("employes", emps);
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/* 单个转自接 */
	// @ResponseBody
	@RequestMapping(value = "oneZzj")
	public String oneZzj(String id, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> empList = changeSelfOrderService.empList(siteId);
		model.addAttribute("empList", empList);
		Record record = changeSelfOrderService.oneDetail(id);
		String emps = "";
		String emp1 = "";
		String emp2 = "";
		String emp3 = "";
		if (StringUtils.isNotBlank(record.getStr("employe1"))) {
			emps = record.getStr("employe1");
			emp1 = record.getStr("employe1");
			String[] emp4001 = emp1.split(",");
			Set<String> set = new HashSet<>();
			for (int i = 0; i < emp4001.length; i++) {
				set.add(emp4001[i]);
			}
			emp4001 = (String[]) set.toArray(new String[set.size()]);
			emp1 = StringUtils.join(emp4001, ",");
		}
		if (StringUtils.isNotBlank(record.getStr("employe2"))) {
			emp2 = record.getStr("employe2");
			if (emps.equals("")) {
				emps = record.getStr("employe2");
			} else {
				emps = emps + "," + record.getStr("employe2");
			}
			String[] emp4002 = emp2.split(",");
			Set<String> set = new HashSet<>();
			for (int i = 0; i < emp4002.length; i++) {
				set.add(emp4002[i]);
			}
			emp4002 = (String[]) set.toArray(new String[set.size()]);
			emp2 = StringUtils.join(emp4002, ",");
		}
		if (StringUtils.isNotBlank(record.getStr("employe3"))) {
			emp3 = record.getStr("employe2");
			if (emps.equals("")) {
				emps = record.getStr("employe3");
			} else {
				emps = emps + "," + record.getStr("employe3");
			}
			String[] emp4003 = emp3.split(",");
			Set<String> set = new HashSet<>();
			for (int i = 0; i < emp4003.length; i++) {
				set.add(emp4003[i]);
			}
			emp4003 = (String[]) set.toArray(new String[set.size()]);
			emp3 = StringUtils.join(emp4003, ",");
		}
		model.addAttribute("emps", emps);
		model.addAttribute("emp1", emp1);
		model.addAttribute("emp2", emp2);
		model.addAttribute("emp3", emp3);
		model.addAttribute("id", id);
		model.addAttribute("oneDetail", changeSelfOrderService.oneDetail(id));
		return "modules/order/orderManagement/400Order/oneZzj";
	}

	/* 确认单个转自接操作 */
	@ResponseBody
	@RequestMapping(value = "confirmOne")
	public String confirmOne(String id400, String[] employes, String orderStatus, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String employs = StringUtil.join(employes);
		Map<String, Object> s = changeSelfOrderService.confirmOne(siteId, id400, employs, orderStatus, "");
		String code = s.get("code") != null ? s.get("code").toString() : "";
		if ("2".equals(orderStatus)) {// 服务中
			if ("ok".equals(code)) {// 转自接成功
				Order od = (Order) s.get("ids");
				Map<String, String> idMap = Maps.newHashMap();
				idMap.put(od.getId(), od.getNumber());
				try {
					pushMessageService.notifyOrder(idMap, "1", "");// 推送消息
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		orderService.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_zzj);
		return code;
	}

	/* 批量转自接 */
	// @ResponseBody
	@RequestMapping(value = "moreZzj")
	public String moreZzj(String ids, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> empList = changeSelfOrderService.empList(siteId);
		model.addAttribute("empList", empList);
		List<Record> EmpList400 = changeSelfOrderService.getList400(ids);
		String[] idss = ids.split(",");
		Integer legh = idss.length;
		model.addAttribute("legh", legh);// 工单数
		model.addAttribute("ids", ids);// 工单ids
		String emps = "";
		String mark = "1";
		Boolean boolean1 = null;
		for (Record rd : EmpList400) {// 遍历选择的多条400工单
			// 如果有一条工单的所有工程师为空
			if (StringUtils.isBlank(rd.getStr("employe1")) && StringUtils.isBlank(rd.getStr("employe2")) && StringUtils.isBlank(rd.getStr("employe3"))) {
				mark = "0";
			} else {
				if (StringUtils.isNotBlank(rd.getStr("employe1"))) {
					if (emps.equals("")) {
						emps = rd.getStr("employe1");
					} else {
						emps = emps + "," + rd.getStr("employe1");
					}
				}
				if (StringUtils.isNotBlank(rd.getStr("employe2"))) {
					if (emps.equals("")) {
						emps = rd.getStr("employe2");
					} else {
						emps = emps + "," + rd.getStr("employe2");
					}
				}
				if (StringUtils.isNotBlank(rd.getStr("employe3"))) {
					if (emps.equals("")) {
						emps = rd.getStr("employe3");
					} else {
						emps = emps + "," + rd.getStr("employe3");
					}
				}
			}
		}
		/* 针对否的情况--提前判断 */
		if (StringUtils.isNotBlank(emps)) {
			String[] emp400 = emps.split(",");
			/* 先给服务工程师做去重处理 */
			Set<String> set = new HashSet<>();
			for (int i = 0; i < emp400.length; i++) {
				set.add(emp400[i]);
			}
			emp400 = (String[]) set.toArray(new String[set.size()]);
			emps = StringUtils.join(emp400, ",");
			Integer empLength = emp400.length;
			Long count = changeSelfOrderService.checkEmploye(emps, siteId);
			if (Long.parseLong(empLength.toString()) == count) {// 如果多少个工程师对应多少条count,即这些工程师全在网点维护的里面，则选择否的时候可以直接转自接
				boolean1 = true;
			} else {
				boolean1 = false;
			}
		}
		if (StringUtils.isNotBlank(emps)) {
			String[] ds = emps.split(",");
			model.addAttribute("ds", ds);
		}
		model.addAttribute("emps", emps);
		model.addAttribute("noIsZzj", boolean1);// 否的时候是否可以转自接，true表示可以，false表示不可以
		model.addAttribute("mark", mark);// 选择的400工单存在一条工单三个工程师为空，则mark返回为“0”
		return "modules/order/orderManagement/400Order/moreZzj";
	}

	/* 确认批量转自接操作 */
	@ResponseBody
	@RequestMapping(value = "confirmMore")
	public String confirmMore(String ids, String employes, String orderStatus, String isEmployes, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> s = changeSelfOrderService.confirmMore(siteId, ids, employes, orderStatus, isEmployes);
		String code = s.get("code") != null ? s.get("code").toString() : "";
		if ("ok".equals(code)) {// 转自接成功
			if ("2".equals(orderStatus)) {// 服务中状态
				List<Order> list = (List<Order>) s.get("ids");
				Map<String, String> idMap = Maps.newHashMap();
				for (Order od : list) {
					idMap.put(od.getId(), od.getNumber());
				}
				try {
					pushMessageService.notifyOrder(idMap, "1", "");// 推送消息
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		orderService.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_zzj);
		return code;
	}

	/* 400Order 工单详情 */
	@RequestMapping(value = "order400Form")
	public String order400Form(String id, HttpServletRequest request, HttpServletResponse response, Model model) {
		Record record = changeSelfOrderService.changeSelfOrderService(id);
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String name = "";
		Record rd = orderDispatchService.getSiteMsg(siteId);
		name = rd.getStr("sms_sign");
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String siteArea = rd.getStr("area");
		model.addAttribute("serviceName", name);// 签字
		model.addAttribute("jdPhone", jdPhone);// 监督电话
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteName", siteName);// 网点名称
		Map<String, Object> map = changeSelfOrderService.getEmpIdAndName2(record.getStr("employe1"), record.getStr("employe2"), record.getStr("employe3"), siteId);
		model.addAttribute("msg1", map.get("msg1"));
		model.addAttribute("msg2Names", map.get("msg2"));
		model.addAttribute("msg2Mobiles", map.get("msg3"));
		model.addAttribute("msg4", map.get("msg4"));
		List<Record> listModel = MsgModelUtils.getListModel1();
		model.addAttribute("listModel", listModel);
		String serviceType = record.getStr("service_type");
		if (StringUtils.isBlank(serviceType)) {
			serviceType = record.getStr("c_service_type");
		}
		String proTime = "";
		if (record.getDate("promise_time") != null) {
			proTime = record.getDate("promise_time").toString().substring(0, 11);
		}
		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + id + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("count", count);
		model.addAttribute("proTime", proTime);
		model.addAttribute("order400", record);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("serviceType", serviceType);
		return "modules/order/orderManagement/400Order/400OrderForm";
	}

	/* 400OrderOldFor2017 工单详情 */
	@RequestMapping(value = "oldOrder400Form")
	public String oldOrder400Form(String id, HttpServletRequest request, HttpServletResponse response, Model model) {
		Record record = changeSelfOrderService.changeSelfOrderServiceFor2017(id);
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String name = "";
		Record rd = orderDispatchService.getSiteMsg(siteId);
		name = rd.getStr("sms_sign");
		String jdPhone = rd.getStr("sms_phone");
		String siteMobile = rd.getStr("mobile");
		String siteName = rd.getStr("name");
		String siteArea = rd.getStr("area");
		model.addAttribute("serviceName", name);// 签字
		model.addAttribute("jdPhone", jdPhone);// 监督电话
		model.addAttribute("siteMobile", siteMobile);
		model.addAttribute("siteName", siteName);// 网点名称
		Map<String, Object> map = changeSelfOrderService.getEmpIdAndName2(record.getStr("employe1"), record.getStr("employe2"), record.getStr("employe3"), siteId);
		model.addAttribute("msg1", map.get("msg1"));
		model.addAttribute("msg2Names", map.get("msg2"));
		model.addAttribute("msg2Mobiles", map.get("msg3"));
		model.addAttribute("msg4", map.get("msg4"));
		List<Record> listModel = MsgModelUtils.getListModel1();
		model.addAttribute("listModel", listModel);
		String serviceType = record.getStr("service_type");
		if (StringUtils.isBlank(serviceType)) {
			serviceType = record.getStr("c_service_type");
		}
		String proTime = "";
		if (record.getDate("promise_time") != null) {
			proTime = record.getDate("promise_time").toString().substring(0, 11);
		}
		Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + id + "' AND a.site_id='" + siteId + "'");
		model.addAttribute("count", count);
		model.addAttribute("proTime", proTime);
		model.addAttribute("order400", record);
		model.addAttribute("siteArea", siteArea);
		model.addAttribute("serviceType", serviceType);
		return "modules/order/orderManagement/400Order/400OldOrderForm";
	}

	/* 校验工单编号是否重复 */
	@ResponseBody
	@RequestMapping(value = "checkNumber")
	public String checkNumber(String numbers, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return changeSelfOrderService.checkNumber(numbers, siteId);
	}

	/* 删除400工单 */
	@ResponseBody
	@RequestMapping(value = "delMore")
	public String delMore(String delIds, HttpServletRequest request, HttpServletResponse response) {
		return changeSelfOrderService.delMore(delIds);
	}

	@RequestMapping(value = "headerListforold400")
	public String headerListforold400(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		List<Record> list = changeSelfOrderService.gerOrderBrandList(siteId);
		List<Record> empList = changeSelfOrderService.empList(siteId);
		List<OrderMarkSetting> flags = orderMarkSettingService.getOrderMarksBySite(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("siteId", siteId);
		model.addAttribute("orderBrandList", list);
		model.addAttribute("empList", empList);
		model.addAttribute("flags", flags);
		Map<String, Object> map = getFactory();
		model.addAttribute("map", map);
		return "modules/order/orderManagement/400Order/400OrderForOld";
	}

	@ResponseBody
	@RequestMapping(value = "old400Order")
	public String old400Order(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = getParams(request);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = changeSelfOrderService.old400Order(siteId, pages, map);
		model.addAttribute("page", page);
		return sfRenderJson(new JqGridPage<>(page));
	}

	private String sfRenderJson(JqGridPage<?> page) {
		return new SfJsonKit("yyyy-MM-dd HH:mm:ss").toJson(page);
	}

}
