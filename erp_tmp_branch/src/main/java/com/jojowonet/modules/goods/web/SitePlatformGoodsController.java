package com.jojowonet.modules.goods.web;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.service.InvoiceAddressService;
import com.jojowonet.modules.finance.service.InvoiceMsgService;
import com.jojowonet.modules.fmss.utils.HttpUtils;
import com.jojowonet.modules.goods.entity.GoodsPlatFormMjlOrder;
import com.jojowonet.modules.goods.entity.GoodsPlatform;
import com.jojowonet.modules.goods.entity.GoodsPlatformOrder;
import com.jojowonet.modules.goods.entity.GoodsPlatformTransferOrder;
import com.jojowonet.modules.goods.entity.GoodsSiteSelf;
import com.jojowonet.modules.goods.form.PrototypeOrder;
import com.jojowonet.modules.goods.service.GoodsPlatFormService;
import com.jojowonet.modules.goods.service.GoodsSiteSelfService;
import com.jojowonet.modules.goods.service.SitePlatformGoodsService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.goods.utils.OrderInfo;
import com.jojowonet.modules.goods.utils.OrderPoto;
import com.jojowonet.modules.goods.utils.SmsOrderInfo;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.entity.GoodsCategory;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.UnitService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.Tuple;
import com.jojowonet.modules.sys.util.FreeOrVipUtils;
import com.jojowonet.modules.unipay.UniPayOrderServiceFactory;
import com.jojowonet.modules.unipay.core.OrderContext;
import com.jojowonet.modules.unipay.core.PushOrderResult;
import com.jojowonet.modules.unipay.core.PushOrderStatus;
import com.jojowonet.modules.unipay.core.UnifyOrderService;
import com.jojowonet.modules.unipay.utils.TradeNoUtils;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "${adminPath}/goods/sitePlatformGoods")
public class SitePlatformGoodsController extends BaseController {

	@Autowired
	private SiteService siteService;

	@Autowired
	private NonServicemanService nonService;

	@Autowired
	private SitePlatformGoodsService sitePlatformGoodsService;

	@Autowired
	private GoodsSiteSelfService goodsSiteSelfService;

	@Autowired
	private GoodsPlatFormService goodsPlatFormService;

	@Autowired
	private UnitService unitService;

	@Autowired
	private InvoiceMsgService invoiceMsgService;

	@Autowired
	private InvoiceAddressService invoiceAddressService;

	// 获取服务商可销售的平台商品列表
	@RequestMapping(value = "getSitePlatformGoodslist")
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());

		Map<String, Object> map = getParams(request);
		Page<Record> page = sitePlatformGoodsService.getSitePlatformGoodslistSiteShow(new Page<Record>(request, response), siteId, map);
		model.addAttribute("page", page);
		List<Record> listR = GoodsCategoryUtil.getPlatGoodsCategoryList();
		model.addAttribute("categoryList", listR);
		model.addAttribute("map", map);
		return "modules/" + "goods/SitePlatformGoodsList";
	}

	// 显示平台商品详情
	@RequestMapping(value = "showSPXQ")
	public Object showSPXQ(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteid = request.getParameter("siteId");
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		List<Record> listR = GoodsCategoryUtil.getPlatGoodsCategoryList();
		model.addAttribute("categoryList", listR);// 商品类别
		model.addAttribute("platform", gss);
		model.addAttribute("siteId", siteid);

		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str);
			model.addAttribute("count", str.length);
		} else {
			model.addAttribute("count", 0);
		}

		if (StringUtils.isNotBlank(gss.getStr("name"))) {
			if ("漏电保护插座".equals(gss.getStr("name"))) {
				return "modules/goods/especiallyGoods/oxGoods";
			}
			if ("HZ20180104".equals(gss.getStr("good_sign"))) {
				// 净水器
				return "modules/goods/goodsDetail/clearWaterDetail";
			} else if ("DX20180101".equals(gss.getStr("good_sign"))) {
				// 短信
				return "modules/goods/goodsDetail/messageDetail";
			} else if ("CD20180103".equals(gss.getStr("good_sign"))) {
				// 电子名片
				return "modules/goods/goodsDetail/codeDetail";
			} else if ("TP20180102".equals(gss.getStr("good_sign"))) {
				// 弹屏
				return "modules/goods/goodsDetail/tanPingDetail";
			} else if ("LB20180105".equals(gss.getStr("good_sign")) || "LB20180106".equals(gss.getStr("good_sign"))) {
				// 漏保
				return "modules/goods/goodsDetail/southIslandDetail";
			} else if ("BS20180107".equals(gss.getStr("good_sign")) || "BS20180108".equals(gss.getStr("good_sign")) || "LB18102201".equals(gss.getStr("good_sign"))
					|| "LB18102202".equals(gss.getStr("good_sign"))) {
				// 漏保(升级版)
				return "modules/goods/goodsDetail/southIslandUpgradeDetail";
			} else if ("QJ18040201".equals(gss.getStr("good_sign")) || "QJ18040202".equals(gss.getStr("good_sign"))) {
				// 清洁剂
				return "modules/goods/goodsDetail/detergentDetail";
			} else if ("WT18040301".equals(gss.getStr("good_sign")) || "WT18040302".equals(gss.getStr("good_sign")) || "WT18040303".equals(gss.getStr("good_sign"))) {
				// 水龙头
				return "modules/goods/goodsDetail/faucetDetail";
			} else if ("CW08040801".equals(gss.getStr("good_sign"))) {
				// 除味盒
				return "modules/goods/goodsDetail/flavorBoxDetail";
			} else if ("MD20180716".equals(gss.getStr("good_sign")) || "MD20180717".equals(gss.getStr("good_sign"))) {
				// 美的冰箱
				return "modules/goods/goodsDetail/refrigeratorDetail";
			} else {
				String[] meiJies = new String[] { "DZ20180110", "DZ20180111", "DZ20180112", "DZ20180113", "DZ20180114", "DZ20180115", "DZ20180116" };
				for (int i = 0; i < meiJies.length; i++) {
					if (meiJies[i].equals(gss.getStr("good_sign"))) {
						return "modules/goods/goodsDetail/fundDetail";
					}
				}
			}
		}
		return "modules/goods/mygoodsTC/ptdetail";
	}

	/**
	 * 南岛（运费校验）
	 */
	@ResponseBody
	@RequestMapping(value = "checkLogistics")
	public String checkLogistics(HttpServletRequest request, HttpServletResponse response, Model model) {
		String province = request.getParameter("province");
		BigDecimal num = BigDecimal.valueOf(Double.valueOf(request.getParameter("num")));// 购买数量
		BigDecimal oneLogistics = BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticss")));// 前台计算的运费
		BigDecimal startNum = BigDecimal.valueOf(15.0);
		Tuple<Integer, Double> tuple = this.getTwoPrice(province);
		if (tuple != null) {
			BigDecimal startPrice = BigDecimal.valueOf(tuple.getVal1().doubleValue());
			BigDecimal anyTimes = BigDecimal.valueOf(tuple.getVal2());
			BigDecimal anotherPrice = anyTimes.multiply(num.subtract(startNum)).divide(BigDecimal.valueOf(10.0), 2, RoundingMode.HALF_UP).add(startPrice);
			if (oneLogistics.compareTo(anotherPrice) == 0) {
				return "200";
			} else {
				return "201";
			}
		} else {
			return "401";
		}
	}

	/**
	 * 除味盒（运费校验）
	 */
	@ResponseBody
	@RequestMapping(value = "checkLogisticsForFlavorBox")
	public String checkLogisticsForFlavorBox(HttpServletRequest request, HttpServletResponse response, Model model) {
		String province = request.getParameter("province");
		BigDecimal num = BigDecimal.valueOf(Double.valueOf(request.getParameter("num")));// 购买数量
		Double oneLogistics = Double.valueOf(request.getParameter("logisticss"));// 前台计算的运费
		BigDecimal startNum = BigDecimal.valueOf(10.0);
		Tuple<Integer, Double> tuple = this.getTwoPrice(province);
		if (tuple != null) {
			BigDecimal startPrice = BigDecimal.valueOf(tuple.getVal1().doubleValue());
			BigDecimal anyTimes = BigDecimal.valueOf(tuple.getVal2());
			BigDecimal ret = anyTimes.multiply(num.subtract(startNum)).divide(BigDecimal.valueOf(6), 2, RoundingMode.HALF_UP).add(startPrice);
			/*
			 * BigDecimal ret2 = num.subtract(startNum).divide(BigDecimal.valueOf(6), 4,
			 * RoundingMode.HALF_UP).multiply(anyTimes).setScale(2, RoundingMode.HALF_UP);
			 */
			BigDecimal pagePrice = BigDecimal.valueOf(oneLogistics);
			if (pagePrice.compareTo(ret) == 0) {
				return "200";
			} else {
				return "201";
			}
		} else {
			return "401";
		}
	}

	/**
	 * 水龙头（运费校验）
	 */
	@ResponseBody
	@RequestMapping(value = "checkLogisticsForPlat")
	public String checkLogisticsForPlat(HttpServletRequest request, HttpServletResponse response, Model model) {
		String province = request.getParameter("province");
		BigDecimal num = BigDecimal.valueOf(Double.valueOf(request.getParameter("num")));// 购买数量
		BigDecimal oneLogistics = BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticss")));// 前台计算的运费
		BigDecimal startNum = BigDecimal.valueOf(60.0);
		Tuple<Integer, Double> tuple = this.getTwoPriceForPLat(province);
		if (tuple != null) {
			BigDecimal startPrice = BigDecimal.valueOf(tuple.getVal1().doubleValue());
			BigDecimal anyTimes = BigDecimal.valueOf(tuple.getVal2());
			BigDecimal anotherPrice = anyTimes.multiply(num.subtract(startNum)).divide(BigDecimal.valueOf(60.0), 2, RoundingMode.HALF_UP).add(startPrice);
			if (oneLogistics.compareTo(anotherPrice) == 0) {
				return "200";
			} else {
				return "201";
			}
		} else {
			return "401";
		}
	}

	private Tuple<Integer, Double> getTwoPrice(String province) {
		Map<String, Object> maps = Maps.newHashMap();
		maps.put("安徽", new Tuple<Integer, Double>(10, 1.2));
		maps.put("江苏", new Tuple<Integer, Double>(10, 1.2));
		maps.put("浙江", new Tuple<Integer, Double>(10, 1.2));
		maps.put("上海", new Tuple<Integer, Double>(10, 1.2));

		maps.put("湖北", new Tuple<Integer, Double>(15, 6.0));
		maps.put("山东", new Tuple<Integer, Double>(15, 6.0));
		maps.put("江西", new Tuple<Integer, Double>(15, 6.0));
		maps.put("河南", new Tuple<Integer, Double>(15, 6.0));
		maps.put("河北", new Tuple<Integer, Double>(15, 6.0));
		maps.put("北京", new Tuple<Integer, Double>(15, 6.0));
		maps.put("福建", new Tuple<Integer, Double>(15, 6.0));
		maps.put("广东", new Tuple<Integer, Double>(15, 6.0));
		maps.put("湖南", new Tuple<Integer, Double>(15, 6.0));
		maps.put("天津", new Tuple<Integer, Double>(15, 6.0));

		maps.put("重庆", new Tuple<Integer, Double>(16, 8.0));
		maps.put("四川", new Tuple<Integer, Double>(16, 8.0));
		maps.put("山西", new Tuple<Integer, Double>(16, 8.0));
		maps.put("辽宁", new Tuple<Integer, Double>(16, 8.0));
		maps.put("广西", new Tuple<Integer, Double>(16, 8.0));
		maps.put("广西壮族自治区", new Tuple<Integer, Double>(16, 8.0));
		maps.put("陕西", new Tuple<Integer, Double>(16, 8.0));
		maps.put("吉林", new Tuple<Integer, Double>(16, 8.0));
		maps.put("贵州", new Tuple<Integer, Double>(16, 8.0));
		maps.put("黑龙江", new Tuple<Integer, Double>(16, 8.0));
		maps.put("云南", new Tuple<Integer, Double>(16, 8.0));

		maps.put("海南", new Tuple<Integer, Double>(20, 10.0));
		maps.put("内蒙古", new Tuple<Integer, Double>(20, 10.0));
		maps.put("宁夏", new Tuple<Integer, Double>(20, 10.0));
		maps.put("甘肃", new Tuple<Integer, Double>(20, 10.0));
		maps.put("青海", new Tuple<Integer, Double>(20, 10.0));

		maps.put("新疆", new Tuple<Integer, Double>(30, 20.0));
		maps.put("西藏", new Tuple<Integer, Double>(30, 20.0));

		if (maps.get(province) != null) {
			return (Tuple<Integer, Double>) maps.get(province);
		} else {
			return null;
		}
	}

	private Tuple<Integer, Double> getTwoPriceForPLat(String province) {
		Map<String, Object> maps = Maps.newHashMap();
		maps.put("安徽", new Tuple<Integer, Double>(25, 20.0));
		maps.put("江苏", new Tuple<Integer, Double>(25, 20.0));
		maps.put("浙江", new Tuple<Integer, Double>(25, 20.0));
		maps.put("上海", new Tuple<Integer, Double>(25, 20.0));

		maps.put("湖北", new Tuple<Integer, Double>(60, 60.0));
		maps.put("山东", new Tuple<Integer, Double>(60, 60.0));
		maps.put("江西", new Tuple<Integer, Double>(60, 60.0));
		maps.put("河南", new Tuple<Integer, Double>(60, 60.0));

		maps.put("河北", new Tuple<Integer, Double>(66, 62.0));
		maps.put("北京", new Tuple<Integer, Double>(66, 62.0));
		maps.put("福建", new Tuple<Integer, Double>(66, 62.0));
		maps.put("广东", new Tuple<Integer, Double>(66, 62.0));
		maps.put("湖南", new Tuple<Integer, Double>(66, 62.0));
		maps.put("天津", new Tuple<Integer, Double>(66, 62.0));

		maps.put("重庆", new Tuple<Integer, Double>(95, 92.0));
		maps.put("四川", new Tuple<Integer, Double>(95, 92.0));
		maps.put("山西", new Tuple<Integer, Double>(95, 92.0));
		maps.put("辽宁", new Tuple<Integer, Double>(95, 92.0));
		maps.put("广西", new Tuple<Integer, Double>(95, 92.0));
		maps.put("广西壮族自治区", new Tuple<Integer, Double>(95, 92.0));
		maps.put("陕西", new Tuple<Integer, Double>(95, 92.0));

		maps.put("吉林", new Tuple<Integer, Double>(105, 100.0));
		maps.put("贵州", new Tuple<Integer, Double>(105, 100.0));
		maps.put("黑龙江", new Tuple<Integer, Double>(105, 100.0));
		maps.put("云南", new Tuple<Integer, Double>(105, 100.0));

		maps.put("海南", new Tuple<Integer, Double>(115, 110.0));

		maps.put("内蒙古", new Tuple<Integer, Double>(130, 122.0));
		maps.put("宁夏", new Tuple<Integer, Double>(130, 122.0));
		maps.put("甘肃", new Tuple<Integer, Double>(130, 122.0));

		maps.put("青海", new Tuple<Integer, Double>(140, 135.0));

		maps.put("新疆", new Tuple<Integer, Double>(375, 360.0));
		maps.put("西藏", new Tuple<Integer, Double>(375, 360.0));

		if (maps.get(province) != null) {
			return (Tuple<Integer, Double>) maps.get(province);
		} else {
			return null;
		}
	}

	// 显示平台商品购买弹屏
	@RequestMapping(value = "showBuy")
	public Object showBuy(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("platform", gss);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		// return "modules/goods/spbuy/spbuytp";
		return "modules/goods/spbuy/spbuytp";
	}

	/**
	 * 购买二维码
	 */
	@RequestMapping(value = "showBuyCode")
	public Object showBuyCode(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("platform", gss);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		return "modules/goods/spbuy/spbuyCode";
	}

	// 显示平台商品
	@RequestMapping(value = "showBuyCOP")
	public Object showBuyCOP(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("N"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);

		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}

		if (gss.getStr("good_sign") != null) {
			if ("LB20180105".equals(gss.getStr("good_sign")) || "LB20180106".equals(gss.getStr("good_sign"))) {
				model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
				return "modules/goods/spbuy/southIslandBuying";
			}
			if ("BS20180108".equals(gss.getStr("good_sign")) || "BS20180107".equals(gss.getStr("good_sign"))) {
				model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
				model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
				if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
					String[] str = gss.getStr("icon").split(",");
					model.addAttribute("images", str[0]);
				}
				return "modules/goods/spbuy/southIslandUpgrade";
			}
			if ("CZ20180117".equals(gss.getStr("good_sign"))) {
				return "modules/goods/spbuy/oxBuying";
			}
			if ("HZ20180104".equals(gss.getStr("good_sign"))) {
				return "modules/goods/especiallyGoods/waterMechineBuying";
			}
			String[] meiJies = new String[] { "DZ20180110", "DZ20180111", "DZ20180113", "DZ20180114", "DZ20180115", "DZ20180116" };
			for (int i = 0; i < meiJies.length; i++) {
				if (meiJies[i].equals(gss.getStr("good_sign"))) {
					// return "modules/goods/spbuy/Foundation";
					return "modules/goods/spbuy/foundationBuying";
				}
			}
		}
		return "modules/goods/spbuy/spbuyCOP";
	}

	// 显示平台商品
	@RequestMapping(value = "showBuySouthUpgrade")
	public Object showBuySouthUpgrade(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("N"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}
		return "modules/goods/spbuy/southIslandLbUpgrade";
	}

	// 购买漏保2018/10/22 - xfzh
	@RequestMapping(value = "showBuySouthLbUpgrade")
	public Object showBuySouthLbUpgrade(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("N"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}
		return "modules/goods/spbuy/southIslandLbUpgrade";
	}

	// 购买水龙头2018/10/26 - xfzh
	@RequestMapping(value = "showBuySouthSltUpgrade")
	public Object showBuySouthSltUpgrade(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("N"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}
		if ("WT18040301".equals(gss.getStr("good_sign"))) {
			return "modules/goods/spbuy/faucetBuying";
		}
		return "modules/goods/spbuy/southIslandSltUpgrade";
	}

	/* 清洁剂、美的冰箱 购买 */
	@RequestMapping(value = "showBuyDetergentDetail")
	public Object showBuyDetergentDetail(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("Q"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}

		if ("QJ18040201".equals(gss.getStr("good_sign")) || "QJ18040202".equals(gss.getStr("good_sign"))) {
			// 清洁剂
			return "modules/goods/spbuy/detergentBuying";
		} else if ("MD20180716".equals(gss.getStr("good_sign")) || "MD20180717".equals(gss.getStr("good_sign"))) {
			// 美的冰箱
			return "modules/goods/spbuy/refrigeratorBuying";
		} else {
			throw new RuntimeException("where you want to go");
		}
	}

	/* 水龙头购买 */
	@RequestMapping(value = "showBuyFaucetDetail")
	public Object showBuyFaucetDetail(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("W"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}
		if ("WT18040301".equals(gss.getStr("good_sign"))) {
			return "modules/goods/spbuy/faucetBuying";
		}
		return "modules/goods/spbuy/southIslandSltUpgrade";
	}

	@RequestMapping(value = "flavorBoxBuying")
	public Object flavorBoxBuying(HttpServletRequest request, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("number", TradeNoUtils.genOrderNo2("W"));
		model.addAttribute("platform", gss);
		User user = UserUtils.getUser();
		Site site = new Site();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String sql = "select * from crm_site where id=?";
		Record reSer = Db.findFirst(sql, siteId);
		String pro = reSer.getStr("province");
		String city = reSer.getStr("city");
		String area = reSer.getStr("area");

		site.setProvince(pro);
		site.setCity(city);
		site.setArea(area);
		model.addAttribute("site", site);
		model.addAttribute("isVIP", sitePlatformGoodsService.isVip(siteId));
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str[0]);
		}

		return "modules/goods/spbuy/flavorBoxBuying";
	}

	// 显示平台商品购买弹屏
	@RequestMapping(value = "showBuyMessage")
	public Object showBuyMessage(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id").trim();
		Record gss = goodsPlatFormService.showPTBJ(id);
		model.addAttribute("platform", gss);
		return "modules/goods/spbuy/spbuyDX";
	}

	// 显示平台商品详情(我要销售)
	@RequestMapping(value = "showPTSPXQ")
	public Object showPTSPXQ(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id").trim();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record gss = goodsPlatFormService.showPTBJ(id);
		// 转自营是商品类别的添加，先判断服务商是否已经维护了该平台商品的类别
		List<Record> listR = GoodsCategoryUtil.getSiteGoodsCategoryList(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		if (StringUtils.isNotBlank(gss.getStr("category"))) {
			GoodsCategory gcs = goodsSiteSelfService.addCategory(siteId, gss.getStr("category"));
			Record rd = new Record();
			rd.set("site_id", gcs.getSiteId());
			rd.set("id", gcs.getId());
			rd.set("name", gcs.getName());
			rd.set("create_time", gcs.getCreateTime());
			rd.set("status", gcs.getStatus());
			rd.set("create_by", gcs.getCreateBy());
			rd.set("sort", gcs.getSort());
			listR.add(rd);
		}
		if (StringUtils.isNotEmpty(gss.getStr("icon"))) {
			String[] str = gss.getStr("icon").split(",");
			model.addAttribute("images", str);
			model.addAttribute("count", str.length);
		} else {
			model.addAttribute("count", 0);
		}
		model.addAttribute("categoryList", listR);// 商品类别
		model.addAttribute("platform", gss);

		model.addAttribute("units", unitService.getUnitList());
		// return "modules/goods/mygoodsTC/ptspSell";
		return "modules/goods/goodsSell/clearWaterSell";
	}

	// 我要销售操作
	@ResponseBody
	@RequestMapping(value = "doXS")
	public Boolean doXS(HttpServletRequest request, HttpServletResponse response, GoodsSiteSelf gss, Model model) {
		Map<String, Object> map = getParams(request);
		User user = UserUtils.getUser();
		String uname = "";
		String html = request.getParameter("html");
		gss.setHtml(html);
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			uname = siteService.getUserSite(user.getId()).getName();
		} else {
			uname = nonService.getNonServiceman(user).getName();
		}
		map.put("userName", uname);
		return goodsSiteSelfService.platCastForGoods(gss, map);
	}

	@RequestMapping(value = "getPlatfromAssistant")
	public String getPlatfromAssistant(HttpServletRequest request, HttpServletResponse response, Model model) {

		// String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());

		Map<String, Object> map = getParams(request);
		Page<Record> page = sitePlatformGoodsService.getPlatformAssistantList(new Page<Record>(request, response), map);

		model.addAttribute("page", page);

		return "modules/" + "goods/PlatformAssistantList";
	}

	// 获取服务商商品出入库明细表头(商品购买记录)
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, Model model) {

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		String userId = UserUtils.getUser().getId();
		model.addAttribute("headerData", stf);
		Record invoiceMsg = invoiceMsgService.getInvoiceMsg(siteId, userId);
		Record invoiceAddress = invoiceAddressService.getInvoiceAddress(siteId, userId);
		model.addAttribute("invoiceMsg", invoiceMsg);
		model.addAttribute("invoiceAddress", invoiceAddress);
		return "modules/" + "goods/SitePlatformGoodsRecord";
	}

	// 获取服务商购买的平台商品交易记录(短信、弹屏、电子名片、郝泽净水、清洁剂、水龙头、除味盒)
	@RequestMapping(value = "getPlatfromGoodsRecord")
	public String getSiteFitKeepList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String userId = UserUtils.getUser().getId();
		Map<String, Object> map = getParams(request);
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record invoiceMsg = invoiceMsgService.getInvoiceMsg(siteId, userId);
		Record invoiceAddress = invoiceAddressService.getInvoiceAddress(siteId, userId);
		model.addAttribute("invoiceMsg", invoiceMsg);
		model.addAttribute("invoiceAddress", invoiceAddress);
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = null;
		page = sitePlatformGoodsService.getPlatformGoodsRecordPayed(pages, siteId, map);
		model.addAttribute("page", page);
		model.addAttribute("placeOrderMan", CrmUtils.getAllSiteManInfo(siteId));
		model.addAttribute("searchValues", map);
		return "modules/" + "goods/SitePlatformGoodsRecord";
	}

	// 取消订单
	@ResponseBody
	@RequestMapping(value = "cancelOrder")
	public String cancelOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		sitePlatformGoodsService.cancelOrder(id);
		return "ok";
	}

	// 系统服务助手列表
	@RequestMapping(value = "getSitePlatformAssistant")
	public String getSitePlatformAssistantlist(HttpServletRequest request, HttpServletResponse response, Model model) {
		// String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<GoodsPlatform> re = sitePlatformGoodsService.getsiteAssistant();
		GoodsPlatform gpfo = re.get(0);// 短信
		GoodsPlatform gpft = re.get(1);// 来电弹屏
		GoodsPlatform gpftCode = re.get(2);// 二维码
		String[] str1 = null;
		String str2 = null;
		String str3 = null;
		if (StringUtils.isNotEmpty(gpft.getImgs())) {
			str1 = gpft.getImgs().split(",");// 来电弹屏，过程图片
		}
		if (StringUtils.isNotEmpty(gpft.getIcon())) {
			str2 = gpft.getIcon();// 来电弹屏，商品图片
		}
		if (StringUtils.isNotEmpty(gpfo.getImgs())) {
			str3 = gpfo.getIcon();// 短信，商品图片
		}
		/*
		 * String[] str1 = gpft.getImgs().split(",");//来电弹屏，过程图片 String[] str2 =
		 * gpft.getIcon().split(",");//来电弹屏，商品图片 String[] str3 =
		 * gpfo.getIcon().split(",");//短信，商品图片
		 */ model.addAttribute("message", gpfo);
		model.addAttribute("view", gpft);
		model.addAttribute("icoCode", gpftCode);
		model.addAttribute("str1", str1);
		model.addAttribute("str2", str2);
		model.addAttribute("str3", str3);
		return "modules/" + "goods/SitePlatformAssistant";
	}

	// 商品购买记录导出
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "export")
	public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Map<String, Object> map = getParams(request);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);
			List<Record> list = sitePlatformGoodsService.getPlatformGoodsRecordList(pages, siteId, map);
			if (list.size() > 0) {
				for (Record rd : list) {
					if (rd.getStr("status") != null) {
						String status = rd.getStr("status");
						if (status.equals("0")) {
							rd.set("status", "已下单");
						} else if (status.equals("1")) {
							rd.set("status", "待分配确认");
						} else if (status.equals("2")) {
							rd.set("status", "待发货");
						} else if (status.equals("3")) {
							rd.set("status", "已发货");
						} else if (status.equals("4")) {
							rd.set("status", "已完成");
						}
					}

					if (rd.getStr("pay_status") != null) {
						String pStatus = rd.getStr("pay_status");
						if (pStatus.equals("0")) {
							rd.set("pay_status", "未支付");
						} else if (pStatus.equals("1")) {
							rd.set("pay_status", "已支付");
						}
					}
					/*
					 * if("3".equals(rd.getStr("review_status"))){
					 * if(StringUtil.isNotBlank(rd.getStr("good_category"))){
					 * if(rd.getStr("good_category").indexOf("来电弹屏")!=-1||"短信".equals(rd.getStr(
					 * "good_category"))||"二维码".equals(rd.getStr("good_category"))){
					 * rd.set("review_status","可开票"); }else{ rd.set("review_status","不可开票"); }
					 * }else{ rd.set("review_status","不可开票"); }
					 * 
					 * }else { rd.set("review_status","不可开票"); }
					 */

				}
			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	/**
	 * 来电弹屏设备下单
	 */
	@RequestMapping(value = "createTpOrder")
	@ResponseBody
	public Object createTPOrder(@Valid OrderInfo order, BindingResult result, HttpServletRequest request) {
		if (result.hasErrors()) {
			return Result.fail("422", "tp order info error");
		}

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record tpRecord = goodsPlatFormService.showPTBJ(order.getPid());
		BigDecimal sitePrice = tpRecord.getBigDecimal("site_price");
		BigDecimal totalAmount = BigDecimal.valueOf(Double.valueOf(request.getParameter("totlePrice")));
		order.setSubject("平台商品-" + tpRecord.getStr("name"));
		if (CrmUtils.isOnlineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totalAmount.doubleValue() * 100));
		}
		String outTradeNo = TradeNoUtils.genUniqueNo("tp");
		order.setOutTradeNo(outTradeNo);
		order.setBody(order.getName() + " *" + order.getQuantity());

		String payType = order.getPayType();
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(payType);// 付款方式：微信，支付宝
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/tp/callback/" + payType);
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate tp order failed");
		}

		GoodsPlatformOrder tpOrder = goodsPlatFormService.createTpOrder(order, tpRecord, UserUtils.getUser(), totalAmount);
		return createOrderResult(tpOrder, pushOrderResult);// tpOrder为生成的平台商品订单，
	}

	/**
	 * 样机商品下单
	 */
	@RequestMapping(value = "prototypeOrder")
	@ResponseBody
	public Object prototypeOrder(HttpServletRequest request) {
		OrderPoto order = new OrderPoto();
		String fee = request.getParameter("totalFee");
		String id = request.getParameter("id");
		String payType = request.getParameter("payType");
		String outTradeNo = request.getParameter("outTradeNo");
		String icon = request.getParameter("icon");
		order.setTotalFee(Math.round(Double.valueOf(fee)));
		order.setId(id);
		order.setPayType(payType);
		order.setOutTradeNo(outTradeNo);
		order.setIcon(icon);

		String url = Global.getConfig("sended.sms.interface.url") + "getPrototypeId";
		Map<String, String> params = Maps.newHashMap();
		params.put("id", order.getId());
		String retStr = HttpUtils.doPost(url, params);
		// 获取商品信息
		Record tpRecord = new Gson().fromJson(retStr, new TypeToken<Record>() {
		}.getType());
		// 销售价格
		BigDecimal sitePrice = new BigDecimal(tpRecord.getStr("sale_price"));
		// 数量
		BigDecimal totalAmount = sitePrice.multiply(BigDecimal.valueOf(1));

		// 订单总额
		order.setTotalFee(Math.round(totalAmount.doubleValue()));

		// String payType = order.getPayType();
		// 付款方式：微信，支付宝
		/*
		 * String type = "1"; if (Constants.PAY_TYPE_WX.equals(payType)) { type ="0"; }
		 * else if (Constants.PAY_TYPE_ALIPAY.equals(payType)) { type = "1"; }
		 * order.setPayType(type);
		 */
		// 生成订单信息数据添加数据库
		Map<String, String> paramso = goodsPlatFormService.prototypeOrder(order, tpRecord, UserUtils.getUser());
		String urlo = Global.getConfig("sended.sms.interface.url") + "getPrototypeOrder";
		String retStro = HttpUtils.doPost(urlo, paramso);
		PrototypeOrder ft = new Gson().fromJson(retStro, new TypeToken<PrototypeOrder>() {
		}.getType());
		return ft;// tpOrder为生成的平台商品订单，
	}

	/**
	 * 根据平台业务订单和支付宝|微信下单结果，生成响应。
	 *
	 * @param order
	 *            业务订单
	 * @param pushOrderResult
	 *            向支付宝和微信下单结果
	 */
	private Result prototypeOrderResult(PrototypeOrder order, PushOrderResult pushOrderResult) {
		if (StringUtils.isNotBlank(order.getId())) {
			Map<String, Object> response = pushOrderResult.getResponse();
			String qrCodeUrl = (String) response.get("qr_code_url");
			Result<String[]> ret = new Result<>();
			ret.setCode("200");
			ret.setData(new String[] { qrCodeUrl, order.getTradeNo(), order.getNumber() });
			return ret;
		}

		return Result.fail("422", String.format("create platform %s order failed", order.getNumber()));
	}

	@RequestMapping(value = "createCOPOrder")
	@ResponseBody
	public Object createCOPOrder(@Valid OrderInfo order, BindingResult result, HttpServletRequest request) {
		if (result.hasErrors()) {
			return Result.fail("422", "cop order info error");
		}

		Record copRecord = goodsPlatFormService.showPTBJ(order.getPid());
		String productName = copRecord.getStr("name");
		BigDecimal sitePrice = copRecord.getBigDecimal("site_price");
		BigDecimal totalAmount = sitePrice.multiply(BigDecimal.valueOf(order.getQuantity()));
		order.setSubject("平台合作商品-" + productName);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totalAmount.doubleValue() * 100));
		}
		String outTradeNo = TradeNoUtils.genUniqueNo("cp"); // cp用于平台合作商品的 out_trade_no prefix
		order.setOutTradeNo(outTradeNo);
		order.setBody(productName + " *" + order.getQuantity());

		String payType = order.getPayType();
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(payType);
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/cop/callback/" + payType);// http/https路径。
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);// ??
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate cop order failed");
		}

		GoodsPlatformOrder copOrder = goodsPlatFormService.createCOPOrder(order, copRecord, UserUtils.getUser());
		return createOrderResult(copOrder, pushOrderResult);
	}

	@RequestMapping(value = "createNanDaoOrder")
	@ResponseBody
	public Object createNanDaoOrder(HttpServletRequest request) {
		String pid10A = request.getParameter("pid10A");
		String pid16A = request.getParameter("pid16A");

		String orderNumb = request.getParameter("orderNumber");
		if (StringUtils.isNotBlank(orderNumb)) {
			Record re = Db.findFirst("select * from crm_goods_platform_transfer_order where number=? limit 1 ", orderNumb);
			if (re != null) {
				return "numberExit";
			}
		}

		GoodsPlatformTransferOrder gpon = new GoodsPlatformTransferOrder();
		GoodsPlatformTransferOrder gpon16 = new GoodsPlatformTransferOrder();

		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
			gpon16.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
			gpon16.setCustomerContact(request.getParameter("customerMobile").toString());
		}
		if (request.getParameter("province") != null && !"".equals(request.getParameter("province"))) {
			gpon.setProvince(request.getParameter("province"));
			gpon16.setProvince(request.getParameter("province"));
		}
		if (request.getParameter("city") != null && !"".equals(request.getParameter("city"))) {
			gpon.setCity(request.getParameter("city"));
			gpon16.setCity(request.getParameter("city"));
		}
		if (request.getParameter("area") != null && !"".equals(request.getParameter("area"))) {
			gpon.setArea(request.getParameter("area"));
			gpon16.setArea(request.getParameter("area"));
		}
		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {
			gpon.setCustomerAddress(request.getParameter("customerAddress"));
			gpon16.setCustomerAddress(request.getParameter("customerAddress"));
		}
		if (request.getParameter("icon") != null && !"".equals(request.getParameter("icon"))) {
			gpon.setPayConfirm(request.getParameter("icon"));
			gpon16.setPayConfirm(request.getParameter("icon"));
		}
		if (request.getParameter("icon") != null && !"".equals(request.getParameter("icon"))) {
			gpon.setPayConfirm(request.getParameter("icon").toString());
			gpon16.setPayConfirm(request.getParameter("icon").toString());
		}
		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {
			if ("alipay".equals(request.getParameter("payType").toString())) {
				gpon16.setPaymentType("1");
				gpon.setPaymentType("1");
			} else {
				gpon16.setPaymentType("0");
				gpon.setPaymentType("0");
			}
		}
		// 获取商品详情
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid10A"));
		if (re != null) {
			if (StringUtils.isNotBlank(re.getStr("number"))) {
				gpon.setGoodNumber(re.getStr("number"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				gpon.setGoodName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("icon"))) {
				gpon.setGoodIcon(re.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				gpon.setGoodBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re.getStr("model"))) {
				gpon.setGoodModel(re.getStr("model"));
			}
			if (StringUtils.isNotBlank(re.getStr("category"))) {
				gpon.setGoodCategory(re.getStr("category"));
			}
		}
		Record re16 = goodsPlatFormService.showPTBJ(request.getParameter("pid16A"));
		if (re16 != null) {
			if (StringUtils.isNotBlank(re16.getStr("number"))) {
				gpon16.setGoodNumber(re16.getStr("number"));
			}
			if (StringUtils.isNotBlank(re16.getStr("name"))) {
				gpon16.setGoodName(re16.getStr("name"));
			}
			if (StringUtils.isNotBlank(re16.getStr("icon"))) {
				gpon16.setGoodIcon(re16.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re16.getStr("brand"))) {
				gpon16.setGoodBrand(re16.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re16.getStr("model"))) {
				gpon16.setGoodModel(re16.getStr("model"));
			}
			if (StringUtils.isNotBlank(re16.getStr("category"))) {
				gpon16.setGoodCategory(re16.getStr("category"));
			}
		}

		if (request.getParameter("pid10A") != null && !"".equals(request.getParameter("pid10A"))) {
			gpon.setGoodId(request.getParameter("pid10A"));
		}
		if (request.getParameter("quantity10") != null && !"".equals(request.getParameter("quantity10"))) {
			String unit10A = request.getParameter("unit10A");
			if ("箱".equals(unit10A)) {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10")) * 144));
			} else {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10"))));
			}
		}
		if (request.getParameter("zong10A") != null && !"".equals(request.getParameter("zong10A"))) {
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong10A"))));
		}

		if (request.getParameter("pid16A") != null && !"".equals(request.getParameter("pid16A"))) {
			gpon16.setGoodId(request.getParameter("pid16A"));
		}
		if (request.getParameter("quantity16") != null && !"".equals(request.getParameter("quantity16"))) {
			String unit16A = request.getParameter("unit16A");
			if ("箱".equals(unit16A)) {
				gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16")) * 144));
			} else {
				gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16"))));
			}
		}
		if (request.getParameter("zong16A") != null && !"".equals(request.getParameter("zong16A"))) {
			gpon16.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong16A"))));
		}
		// 交易记录号
		String tradeNo = TradeNoUtils.genUniqueNo("N");
		gpon.setTradeNo(tradeNo);
		gpon16.setTradeNo(tradeNo);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		String sql = "select user_id from crm_site  where id='" + siteId + "'";
		Record reSite = Db.findFirst(sql);
		gpon.setPlacingOrderBy(reSite.getStr("user_id"));
		gpon.setPlacingOrderTime(now);
		gpon.setPayer(reSite.getStr("user_id"));
		gpon.setPaymentTime(now);
		gpon.setPayStatus("1");
		gpon.setStatus("0");
		gpon.setSiteId(siteId);
		gpon.setCreator(reSite.getStr("name"));
		gpon.setSupplierId("999");

		gpon16.setPlacingOrderBy(reSite.getStr("user_id"));
		gpon16.setPlacingOrderTime(now);
		gpon16.setPayer(reSite.getStr("user_id"));
		gpon16.setPaymentTime(now);
		gpon16.setPayStatus("1");
		gpon16.setStatus("0");
		gpon16.setSiteId(siteId);
		gpon16.setCreator(reSite.getStr("name"));
		gpon16.setSupplierId("999");

		List<GoodsPlatformTransferOrder> listGoods = Lists.newArrayList();

		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			/* 只有10A的 */
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			if (gpon.getPurchaseNum().compareTo(BigDecimal.valueOf(144d)) < 0) {
				gpon.setHadLogisticsPrice("1");
			} else {
				gpon.setHadLogisticsPrice("0");
			}
			listGoods.add(gpon);
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			/* 只有16A的 */
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon16.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon16.setNumber(request.getParameter("orderNumber"));
			}
			if (gpon16.getPurchaseNum().compareTo(BigDecimal.valueOf(144d)) < 0) {
				gpon16.setHadLogisticsPrice("1");
			} else {
				gpon16.setHadLogisticsPrice("0");
			}

			listGoods.add(gpon16);
		} else {
			/* 两个都有 */
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			String orderNumber2 = request.getParameter("orderNumber") + "-2";
			gpon16.setNumber(orderNumber2);
			if ((gpon.getPurchaseNum().add(gpon16.getPurchaseNum())).compareTo(BigDecimal.valueOf(144d)) < 0) {
				gpon.setHadLogisticsPrice("1");
			} else {
				gpon.setHadLogisticsPrice("0");
			}

			listGoods.add(gpon);
			listGoods.add(gpon16);
		}

		sitePlatformGoodsService.createNanDaoOrderDetail(listGoods);
		return "";
	}

	public String dealNull(Object obj) {
		if (obj == null || StringUtils.isBlank(obj.toString())) {
			return "";
		}
		return obj.toString();
	}

	/**
	 * 南岛升级版订单----最新 2018/10/25 zxf
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "createNanDaoUpgradeOrderLatest")
	@ResponseBody
	public Object createNanDaoUpgradeOrderLatest(HttpServletRequest request) {
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> map = getParams(request);
		String ids = map.get("ids") != null ? map.get("ids").toString() : "";
		String numbers = map.get("numbers") != null ? map.get("numbers").toString() : "";
		String orderAmounts = map.get("orderAmounts") != null ? map.get("orderAmounts").toString() : "";
		if (StringUtils.isBlank(ids) || StringUtils.isBlank(numbers) || StringUtils.isBlank(orderAmounts)) {
			ret.put("code", "410");// 信息有误
			return ret;
		}

		if (!(ids.split(",").length == numbers.split(",").length && ids.split(",").length == orderAmounts.split(",").length)) {
			ret.put("code", "410");
			return ret;
		}
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		Record reSite = Db.findFirst("select user_id from crm_site  where id=? limit 1", siteId);
		String[] idsArr = ids.split(",");
		String[] numbersArr = numbers.split(",");
		String[] orderAmountsArr = orderAmounts.split(",");
		List<GoodsPlatformTransferOrder> listGoods = Lists.newArrayList();
		String tradeNo = TradeNoUtils.genUniqueNo("N");
		String descStr = "";
		for (int i = 0; i < idsArr.length; i++) {
			Record platGood = Db.findFirst("select a.* from crm_goods_platform a where id=? limit 1 ", idsArr[i]);
			GoodsPlatformTransferOrder gpto = new GoodsPlatformTransferOrder();
			gpto.setArea(dealNull(map.get("area")));
			gpto.setCity(dealNull(map.get("city")));
			gpto.setCreator(reSite.getStr("name"));
			gpto.setCustomerAddress(dealNull(map.get("customerAddress")));
			gpto.setCustomerContact(dealNull(map.get("customerMobile")));
			gpto.setCustomerName(dealNull(map.get("customerName")));
			gpto.setGoodAmount(new BigDecimal(orderAmountsArr[i]));// 订单金额
			gpto.setGoodBrand(platGood.getStr("brand"));
			gpto.setGoodCategory(platGood.getStr("category"));
			gpto.setGoodIcon(platGood.getStr("icon"));
			gpto.setGoodId(platGood.getStr("id"));
			gpto.setGoodModel(platGood.getStr("model"));
			gpto.setSiteId(siteId);
			gpto.setGoodName(platGood.getStr("name"));
			gpto.setGoodNumber(platGood.getStr("number"));
			gpto.setHadLogisticsPrice(map.get("logisMark").toString());
			gpto.setNumber(TradeNoUtils.genOrderNo3("N") + i);
			gpto.setPurchaseNum(new BigDecimal(numbersArr[i]));
			gpto.setProvince(dealNull(map.get("province")));
			if (i == 0) {
				gpto.setLogisticsPrice(new BigDecimal(map.get("logisPrice").toString()));
				if ("1".equals(map.get("logisMark").toString())) {// 有运费的时候
					gpto.setGoodAmount(new BigDecimal(orderAmountsArr[i]).add(new BigDecimal(map.get("logisPrice").toString())));// 订单金额,把运费也加上
				}
			}
			gpto.setPayStatus("0");
			gpto.setStatus("1");
			gpto.setPayer(reSite.getStr("user_id"));
			gpto.setPaymentType(map.get("payType").toString());
			gpto.setSupplierId("999");
			gpto.setPlacingOrderBy(reSite.getStr("user_id"));
			gpto.setPlacingOrderTime(now);
			gpto.setTradeNo(tradeNo);
			listGoods.add(gpto);
			if ((i + 1) == idsArr.length) {
				descStr += platGood.getStr("name") + " * " + numbersArr[i] + "个";
			} else {
				descStr += platGood.getStr("name") + " * " + numbersArr[i] + "个，";
			}
		}
		sitePlatformGoodsService.createNanDaoOrderDetail(listGoods);

		OrderInfo order = new OrderInfo();

		String productName = "南岛漏电保护插头";

		order.setSubject("平台商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(Double.valueOf(map.get("allAmount").toString()) * 100));
		}
		order.setOutTradeNo(tradeNo);
		order.setBody(productName + "(" + descStr + ")");
		logger.info("此次购买的商品明细为：" + descStr);
		String payType = map.get("payType").toString();
		String pt = "alipay";
		if ("0".equals(payType)) {
			pt = "wx";
		}

		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(pt);
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/nandao/callback/" + pt);
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate nd order failed");
		}
		return createNanDaoOrderResult(listGoods.get(0), pushOrderResult);
	}

	/**
	 * 水龙头订单----最新 2018/10/26 zxf
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "createSltDaoUpgradeOrderLatest")
	@ResponseBody
	public Object createSltDaoUpgradeOrderLatest(HttpServletRequest request) {
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> map = getParams(request);
		String ids = map.get("ids") != null ? map.get("ids").toString() : "";
		String numbers = map.get("numbers") != null ? map.get("numbers").toString() : "";
		String orderAmounts = map.get("orderAmounts") != null ? map.get("orderAmounts").toString() : "";
		if (StringUtils.isBlank(ids) || StringUtils.isBlank(numbers) || StringUtils.isBlank(orderAmounts)) {
			ret.put("code", "410");// 信息有误
			return ret;
		}

		if (!(ids.split(",").length == numbers.split(",").length && ids.split(",").length == orderAmounts.split(",").length)) {
			ret.put("code", "410");
			return ret;
		}
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		Record reSite = Db.findFirst("select user_id from crm_site  where id=? limit 1", siteId);
		String[] idsArr = ids.split(",");
		String[] numbersArr = numbers.split(",");
		String[] orderAmountsArr = orderAmounts.split(",");
		List<GoodsPlatformOrder> listGoods = Lists.newArrayList();
		String tradeNo = TradeNoUtils.genUniqueNo("N");
		String descStr = "";
		for (int i = 0; i < idsArr.length; i++) {
			Record platGood = Db.findFirst("select a.* from crm_goods_platform a where id=? limit 1 ", idsArr[i]);
			GoodsPlatformOrder gpto = new GoodsPlatformOrder();
			gpto.setArea(dealNull(map.get("area")));
			gpto.setCity(dealNull(map.get("city")));
			gpto.setCreator(reSite.getStr("name"));
			gpto.setCustomerAddress(dealNull(map.get("customerAddress")));
			gpto.setCustomerContact(dealNull(map.get("customerMobile")));
			gpto.setCustomerName(dealNull(map.get("customerName")));
			gpto.setGoodAmount(new BigDecimal(orderAmountsArr[i]));// 订单金额
			gpto.setGoodBrand(platGood.getStr("brand"));
			gpto.setGoodCategory(platGood.getStr("category"));
			gpto.setGoodIcon(platGood.getStr("icon"));
			gpto.setGoodId(platGood.getStr("id"));
			gpto.setGoodModel(platGood.getStr("model"));
			gpto.setSiteId(siteId);
			gpto.setGoodName(platGood.getStr("name"));
			gpto.setGoodNumber(platGood.getStr("number"));
			gpto.setHadLogisticsPrice(map.get("logisMark").toString());
			gpto.setNumber(TradeNoUtils.genOrderNo3("N") + i);
			gpto.setPurchaseNum(new BigDecimal(numbersArr[i]));
			gpto.setProvince(dealNull(map.get("province")));
			if (i == 0) {
				gpto.setLogisticsPrice(new BigDecimal(map.get("logisPrice").toString()));
				if ("1".equals(map.get("logisMark").toString())) {// 有运费
					gpto.setGoodAmount(new BigDecimal(orderAmountsArr[i]).add(new BigDecimal(map.get("logisPrice").toString())));// 订单金额,加上运费
				}
			}
			gpto.setPayStatus("0");
			gpto.setStatus("2");
			gpto.setPayer(reSite.getStr("user_id"));
			gpto.setPaymentType(map.get("payType").toString());
			gpto.setSupplierId("999");
			gpto.setPlacingOrderBy(reSite.getStr("user_id"));
			gpto.setPlacingOrderTime(now);
			gpto.setTradeNo(tradeNo);
			listGoods.add(gpto);
			if ((i + 1) == idsArr.length) {
				descStr += platGood.getStr("name") + " * " + numbersArr[i] + "个";
			} else {
				descStr += platGood.getStr("name") + " * " + numbersArr[i] + "个，";
			}
		}
		sitePlatformGoodsService.createDetergentOrderDetail(listGoods);

		OrderInfo order = new OrderInfo();

		String productName = "水龙头";

		order.setSubject("平台商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(Double.valueOf(map.get("allAmount").toString()) * 100));
		}
		order.setOutTradeNo(tradeNo);
		order.setBody(productName + "(" + descStr + ")");
		logger.info("此次购买的商品明细为：" + descStr);
		String payType = map.get("payType").toString();
		String pt = "alipay";
		if ("0".equals(payType)) {
			pt = "wx";
		}

		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(pt);
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/faucet/callback/" + pt);
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate nd order failed");
		}
		return createDetergentResult(listGoods.get(0), pushOrderResult);
		// return createNanDaoOrderResult(listGoods.get(0), pushOrderResult);
	}

	/**
	 * 南岛升级版订单
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "createNanDaoUpgradeOrder")
	@ResponseBody
	public Object createNanDaoUpgradeOrder(HttpServletRequest request) {
		String pid10A = request.getParameter("pid10A");
		String pid16A = request.getParameter("pid16A");

		GoodsPlatformTransferOrder gpon = new GoodsPlatformTransferOrder();
		GoodsPlatformTransferOrder gpon16 = new GoodsPlatformTransferOrder();

		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
			gpon16.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
			gpon16.setCustomerContact(request.getParameter("customerMobile").toString());
		}
		if (request.getParameter("province") != null && !"".equals(request.getParameter("province"))) {
			gpon.setProvince(request.getParameter("province"));
			gpon16.setProvince(request.getParameter("province"));
		}
		if (request.getParameter("city") != null && !"".equals(request.getParameter("city"))) {
			gpon.setCity(request.getParameter("city"));
			gpon16.setCity(request.getParameter("city"));
		}
		if (request.getParameter("area") != null && !"".equals(request.getParameter("area"))) {
			gpon.setArea(request.getParameter("area"));
			gpon16.setArea(request.getParameter("area"));
		}
		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {
			gpon.setCustomerAddress(request.getParameter("customerAddress"));
			gpon16.setCustomerAddress(request.getParameter("customerAddress"));
		}
		if (request.getParameter("icon") != null && !"".equals(request.getParameter("icon"))) {
			gpon.setPayConfirm(request.getParameter("icon"));
			gpon16.setPayConfirm(request.getParameter("icon"));
		}
		if (request.getParameter("icon") != null && !"".equals(request.getParameter("icon"))) {
			gpon.setPayConfirm(request.getParameter("icon").toString());
			gpon16.setPayConfirm(request.getParameter("icon").toString());
		}
		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {
			if ("alipay".equals(request.getParameter("payType").toString())) {
				gpon16.setPaymentType("1");
				gpon.setPaymentType("1");
			} else {
				gpon16.setPaymentType("0");
				gpon.setPaymentType("0");
			}
		}
		// 获取商品详情
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid10A"));
		if (re != null) {
			if (StringUtils.isNotBlank(re.getStr("number"))) {
				gpon.setGoodNumber(re.getStr("number"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				gpon.setGoodName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("icon"))) {
				gpon.setGoodIcon(re.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				gpon.setGoodBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re.getStr("model"))) {
				gpon.setGoodModel(re.getStr("model"));
			}
			if (StringUtils.isNotBlank(re.getStr("category"))) {
				gpon.setGoodCategory(re.getStr("category"));
			}
		}
		Record re16 = goodsPlatFormService.showPTBJ(request.getParameter("pid16A"));
		if (re16 != null) {
			if (StringUtils.isNotBlank(re16.getStr("number"))) {
				gpon16.setGoodNumber(re16.getStr("number"));
			}
			if (StringUtils.isNotBlank(re16.getStr("name"))) {
				gpon16.setGoodName(re16.getStr("name"));
			}
			if (StringUtils.isNotBlank(re16.getStr("icon"))) {
				gpon16.setGoodIcon(re16.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re16.getStr("brand"))) {
				gpon16.setGoodBrand(re16.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re16.getStr("model"))) {
				gpon16.setGoodModel(re16.getStr("model"));
			}
			if (StringUtils.isNotBlank(re16.getStr("category"))) {
				gpon16.setGoodCategory(re16.getStr("category"));
			}
		}

		if (request.getParameter("pid10A") != null && !"".equals(request.getParameter("pid10A"))) {
			gpon.setGoodId(request.getParameter("pid10A"));
		}
		if (request.getParameter("quantity10") != null && !"".equals(request.getParameter("quantity10"))) {
			String unit10A = request.getParameter("unit10A");
			if ("箱".equals(unit10A)) {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10")) * 144));
			} else {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10"))));
			}
		}
		if (request.getParameter("zong10A") != null && !"".equals(request.getParameter("zong10A"))) {
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong10A"))));
		}

		if (request.getParameter("pid16A") != null && !"".equals(request.getParameter("pid16A"))) {
			gpon16.setGoodId(request.getParameter("pid16A"));
		}
		if (request.getParameter("quantity16") != null && !"".equals(request.getParameter("quantity16"))) {
			String unit16A = request.getParameter("unit16A");
			if ("箱".equals(unit16A)) {
				gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16")) * 144));
			} else {
				gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16"))));
			}
		}
		if (request.getParameter("zong16A") != null && !"".equals(request.getParameter("zong16A"))) {
			gpon16.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong16A"))));
		}
		// 交易记录号
		String tradeNo = TradeNoUtils.genUniqueNo("N");
		gpon.setTradeNo(tradeNo);
		gpon16.setTradeNo(tradeNo);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		String sql = "select user_id from crm_site  where id='" + siteId + "'";
		Record reSite = Db.findFirst(sql);
		gpon.setPlacingOrderBy(reSite.getStr("user_id"));
		gpon.setPlacingOrderTime(now);
		gpon.setPayer(reSite.getStr("user_id"));
		gpon.setPayStatus("0");
		gpon.setStatus("1");
		gpon.setSiteId(siteId);
		gpon.setCreator(reSite.getStr("name"));
		gpon.setSupplierId("999");

		gpon16.setPlacingOrderBy(reSite.getStr("user_id"));
		gpon16.setPlacingOrderTime(now);
		gpon16.setPayer(reSite.getStr("user_id"));
		gpon16.setPayStatus("0");
		gpon16.setStatus("1");
		gpon16.setSiteId(siteId);
		gpon16.setCreator(reSite.getStr("name"));
		gpon16.setSupplierId("999");

		List<GoodsPlatformTransferOrder> listGoods = Lists.newArrayList();
		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			if (gpon.getPurchaseNum().compareTo(BigDecimal.valueOf(144d)) < 0) {
				gpon.setHadLogisticsPrice("1");
			} else {
				gpon.setHadLogisticsPrice("0");
			}
			listGoods.add(gpon);
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon16.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon16.setNumber(request.getParameter("orderNumber"));
			}
			if (gpon16.getPurchaseNum().compareTo(BigDecimal.valueOf(144d)) < 0) {
				gpon16.setHadLogisticsPrice("1");
			} else {
				gpon16.setHadLogisticsPrice("0");
			}
			listGoods.add(gpon16);
		} else {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			String orderNumber2 = request.getParameter("orderNumber") + "-2";
			gpon16.setNumber(orderNumber2);

			if ((gpon.getPurchaseNum().add(gpon16.getPurchaseNum())).compareTo(BigDecimal.valueOf(144d)) < 0) {
				gpon.setHadLogisticsPrice("1");
			} else {
				gpon.setHadLogisticsPrice("0");
			}

			listGoods.add(gpon);
			listGoods.add(gpon16);
		}
		sitePlatformGoodsService.createNanDaoOrderDetail(listGoods);

		String price10A = request.getParameter("zong10A");
		String price16A = request.getParameter("zong16A");
		BigDecimal totlePrice = BigDecimal.valueOf(0);
		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A));
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price16A));
		} else {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A)).add(BigDecimal.valueOf(Double.valueOf(price16A)));
		}

		String productName = "南岛漏电保护插头";
		OrderInfo order = new OrderInfo();
		order.setSubject("平台商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totlePrice.doubleValue() * 100));
		}
		order.setOutTradeNo(tradeNo);

		String unit10A = request.getParameter("unit10A");
		String unit16A = request.getParameter("unit16A");
		String tenA = "";
		String sixA = "";
		if ("箱".equals(unit10A)) {
			Double a = Double.valueOf(request.getParameter("quantity10"));
			tenA = String.valueOf(a * 144);
		} else {
			tenA = request.getParameter("quantity10");
		}
		if ("箱".equals(unit16A)) {
			Double a = Double.valueOf(request.getParameter("quantity16"));
			sixA = String.valueOf(a * 144);
		} else {
			sixA = request.getParameter("quantity16");
		}
		order.setBody(productName + " *" + (tenA + sixA));
		logger.info(String.format("uid[%s]购买了%s个10A，%s个16A,付费：%s", reSite.getStr("user_id"), tenA, sixA, totlePrice));
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(request.getParameter("payType"));
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/nandao/callback/" + request.getParameter("payType"));
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate nd order failed");
		}
		if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			return createNanDaoOrderResult(gpon16, pushOrderResult);
		} else {
			return createNanDaoOrderResult(gpon, pushOrderResult);
		}
	}

	/**
	 * 清洁剂订单(10A:清洁剂1、16A：清洁剂2)
	 */
	@RequestMapping(value = "createDetergentOrder")
	@ResponseBody
	public Object createDetergentOrder(HttpServletRequest request) {
		String pid10A = request.getParameter("pid10A");
		String pid16A = request.getParameter("pid16A");

		GoodsPlatformOrder gpon = new GoodsPlatformOrder();
		GoodsPlatformOrder gpon16 = new GoodsPlatformOrder();

		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
			gpon16.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
			gpon16.setCustomerContact(request.getParameter("customerMobile").toString());
		}

		gpon.setProvince(request.getParameter("province"));
		gpon.setCity(request.getParameter("city"));
		gpon.setArea(request.getParameter("area"));
		gpon16.setProvince(request.getParameter("province"));
		gpon16.setCity(request.getParameter("city"));
		gpon16.setArea(request.getParameter("area"));

		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {
			gpon.setCustomerAddress(request.getParameter("customerAddress"));
			gpon16.setCustomerAddress(request.getParameter("customerAddress"));
		}
		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {
			if ("alipay".equals(request.getParameter("payType").toString())) {
				gpon16.setPaymentType("1");
				gpon.setPaymentType("1");
			} else {
				gpon16.setPaymentType("0");
				gpon.setPaymentType("0");
			}
		}
		// 获取商品详情
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid10A"));
		if (re != null) {
			if (StringUtils.isNotBlank(re.getStr("number"))) {
				gpon.setGoodNumber(re.getStr("number"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				gpon.setGoodName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("icon"))) {
				gpon.setGoodIcon(re.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				gpon.setGoodBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re.getStr("model"))) {
				gpon.setGoodModel(re.getStr("model"));
			}
			if (StringUtils.isNotBlank(re.getStr("category"))) {
				gpon.setGoodCategory(re.getStr("category"));
			}
		}
		Record re16 = goodsPlatFormService.showPTBJ(request.getParameter("pid16A"));
		if (re16 != null) {
			if (StringUtils.isNotBlank(re16.getStr("number"))) {
				gpon16.setGoodNumber(re16.getStr("number"));
			}
			if (StringUtils.isNotBlank(re16.getStr("name"))) {
				gpon16.setGoodName(re16.getStr("name"));
			}
			if (StringUtils.isNotBlank(re16.getStr("icon"))) {
				gpon16.setGoodIcon(re16.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re16.getStr("brand"))) {
				gpon16.setGoodBrand(re16.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re16.getStr("model"))) {
				gpon16.setGoodModel(re16.getStr("model"));
			}
			if (StringUtils.isNotBlank(re16.getStr("category"))) {
				gpon16.setGoodCategory(re16.getStr("category"));
			}
		}

		if (request.getParameter("pid10A") != null && !"".equals(request.getParameter("pid10A"))) {
			gpon.setGoodId(request.getParameter("pid10A"));
		}
		if (request.getParameter("quantity10") != null && !"".equals(request.getParameter("quantity10"))) {
			String unit10A = request.getParameter("unit10A");
			if ("箱".equals(unit10A)) {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10")) * 144));
			} else {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10"))));
			}
		}
		if (request.getParameter("zong10A") != null && !"".equals(request.getParameter("zong10A"))) {
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong10A"))));
		}

		if (request.getParameter("pid16A") != null && !"".equals(request.getParameter("pid16A"))) {
			gpon16.setGoodId(request.getParameter("pid16A"));
		}
		if (request.getParameter("quantity16") != null && !"".equals(request.getParameter("quantity16"))) {
			String unit16A = request.getParameter("unit16A");
			if ("箱".equals(unit16A)) {
				gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16")) * 144));
			} else {
				gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16"))));
			}
		}
		if (request.getParameter("zong16A") != null && !"".equals(request.getParameter("zong16A"))) {
			gpon16.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong16A"))));
		}
		// 交易记录号
		String tradeNo = TradeNoUtils.genUniqueNo("Q");
		gpon.setTradeNo(tradeNo);
		gpon16.setTradeNo(tradeNo);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		String userId = UserUtils.getUser().getId();
		String userName = CrmUtils.getUserXM();
		gpon.setPlacingOrderBy(userId);
		gpon.setPlacingOrderTime(now);
		gpon.setPayer(userId);
		gpon.setPayStatus("0");
		gpon.setStatus("2");
		gpon.setSiteId(siteId);
		gpon.setCreator(userName);
		gpon.setSupplierId("999");
		/* 免运费 */
		gpon.setHadLogisticsPrice("0");

		gpon16.setPlacingOrderBy(userId);
		gpon16.setPlacingOrderTime(now);
		gpon16.setPayer(userId);
		gpon16.setPayStatus("0");
		gpon16.setStatus("2");
		gpon16.setSiteId(siteId);
		gpon16.setCreator(userName);
		gpon16.setSupplierId("999");
		/* 免运费 */
		gpon16.setHadLogisticsPrice("0");

		List<GoodsPlatformOrder> listGoods = Lists.newArrayList();
		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			listGoods.add(gpon);
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon16.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon16.setNumber(request.getParameter("orderNumber"));
			}
			listGoods.add(gpon16);
		} else {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			String orderNumber2 = request.getParameter("orderNumber") + "-2";
			gpon16.setNumber(orderNumber2);
			listGoods.add(gpon);
			listGoods.add(gpon16);
		}
		sitePlatformGoodsService.createDetergentOrderDetail(listGoods);

		String price10A = request.getParameter("zong10A");
		String price16A = request.getParameter("zong16A");
		BigDecimal totlePrice = BigDecimal.valueOf(0);
		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A));
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price16A));
		} else {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A)).add(BigDecimal.valueOf(Double.valueOf(price16A)));
		}

		String productName = "洁力士清洁剂";
		OrderInfo order = new OrderInfo();
		order.setSubject("平台合作商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totlePrice.doubleValue() * 100));
		}
		order.setOutTradeNo(tradeNo);

		String unit10A = request.getParameter("unit10A");
		String unit16A = request.getParameter("unit16A");
		String tenA = "";
		String sixA = "";
		if ("箱".equals(unit10A)) {
			Double a = Double.valueOf(request.getParameter("quantity10"));
			tenA = String.valueOf(a * 144);
		} else {
			tenA = request.getParameter("quantity10");
		}
		if ("箱".equals(unit16A)) {
			Double a = Double.valueOf(request.getParameter("quantity16"));
			sixA = String.valueOf(a * 144);
		} else {
			sixA = request.getParameter("quantity16");
		}
		order.setBody(productName + " *" + (tenA + sixA));

		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(request.getParameter("payType"));
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/detergent/callback/" + request.getParameter("payType"));
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate detergent order failed");
		}
		if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			return createDetergentResult(gpon16, pushOrderResult);
		} else {
			return createDetergentResult(gpon, pushOrderResult);
		}
	}

	/**
	 * 美的冰箱(10A:冰箱1、16A：冰箱2)
	 */
	@RequestMapping(value = "createRefrigertorOrder")
	@ResponseBody
	public Object createRefrigertorOrder(HttpServletRequest request) {
		String pid10A = request.getParameter("pid10A");
		String pid16A = request.getParameter("pid16A");

		GoodsPlatformOrder gpon = new GoodsPlatformOrder();
		GoodsPlatformOrder gpon16 = new GoodsPlatformOrder();

		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
			gpon16.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
			gpon16.setCustomerContact(request.getParameter("customerMobile").toString());
		}

		gpon.setProvince(request.getParameter("province"));
		gpon.setCity(request.getParameter("city"));
		gpon.setArea(request.getParameter("area"));
		gpon16.setProvince(request.getParameter("province"));
		gpon16.setCity(request.getParameter("city"));
		gpon16.setArea(request.getParameter("area"));

		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {
			gpon.setCustomerAddress(request.getParameter("customerAddress"));
			gpon16.setCustomerAddress(request.getParameter("customerAddress"));
		}
		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {
			if ("alipay".equals(request.getParameter("payType"))) {
				gpon16.setPaymentType("1");
				gpon.setPaymentType("1");
			} else {
				gpon16.setPaymentType("0");
				gpon.setPaymentType("0");
			}
		}
		// 获取商品详情
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid10A"));
		if (re != null) {
			if (StringUtils.isNotBlank(re.getStr("number"))) {
				gpon.setGoodNumber(re.getStr("number"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				gpon.setGoodName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("icon"))) {
				gpon.setGoodIcon(re.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				gpon.setGoodBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re.getStr("model"))) {
				gpon.setGoodModel(re.getStr("model"));
			}
			if (StringUtils.isNotBlank(re.getStr("category"))) {
				gpon.setGoodCategory(re.getStr("category"));
			}
		}
		Record re16 = goodsPlatFormService.showPTBJ(request.getParameter("pid16A"));
		if (re16 != null) {
			if (StringUtils.isNotBlank(re16.getStr("number"))) {
				gpon16.setGoodNumber(re16.getStr("number"));
			}
			if (StringUtils.isNotBlank(re16.getStr("name"))) {
				gpon16.setGoodName(re16.getStr("name"));
			}
			if (StringUtils.isNotBlank(re16.getStr("icon"))) {
				gpon16.setGoodIcon(re16.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re16.getStr("brand"))) {
				gpon16.setGoodBrand(re16.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re16.getStr("model"))) {
				gpon16.setGoodModel(re16.getStr("model"));
			}
			if (StringUtils.isNotBlank(re16.getStr("category"))) {
				gpon16.setGoodCategory(re16.getStr("category"));
			}
		}

		if (request.getParameter("pid10A") != null && !"".equals(request.getParameter("pid10A"))) {
			gpon.setGoodId(request.getParameter("pid10A"));
		}
		if (request.getParameter("quantity10") != null && !"".equals(request.getParameter("quantity10"))) {
			String unit10A = request.getParameter("unit10A");
			gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10"))));
		}
		if (request.getParameter("zong10A") != null && !"".equals(request.getParameter("zong10A"))) {
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong10A"))));
		}

		if (request.getParameter("pid16A") != null && !"".equals(request.getParameter("pid16A"))) {
			gpon16.setGoodId(request.getParameter("pid16A"));
		}
		if (request.getParameter("quantity16") != null && !"".equals(request.getParameter("quantity16"))) {
			String unit16A = request.getParameter("unit16A");
			gpon16.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity16"))));
		}
		if (request.getParameter("zong16A") != null && !"".equals(request.getParameter("zong16A"))) {
			gpon16.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong16A"))));
		}
		// 交易记录号
		String tradeNo = TradeNoUtils.genUniqueNo("Q");
		gpon.setTradeNo(tradeNo);
		gpon16.setTradeNo(tradeNo);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		String userId = UserUtils.getUser().getId();
		String userName = CrmUtils.getUserXM();
		gpon.setPlacingOrderBy(userId);
		gpon.setPlacingOrderTime(now);
		gpon.setPayer(userId);
		gpon.setPayStatus("0");
		gpon.setStatus("2");
		gpon.setSiteId(siteId);
		gpon.setCreator(userName);
		gpon.setSupplierId("999");
		/* 免运费 */
		gpon.setHadLogisticsPrice("0");

		gpon16.setPlacingOrderBy(userId);
		gpon16.setPlacingOrderTime(now);
		gpon16.setPayer(userId);
		gpon16.setPayStatus("0");
		gpon16.setStatus("2");
		gpon16.setSiteId(siteId);
		gpon16.setCreator(userName);
		gpon16.setSupplierId("999");
		/* 免运费 */
		gpon16.setHadLogisticsPrice("0");

		List<GoodsPlatformOrder> listGoods = Lists.newArrayList();
		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			listGoods.add(gpon);
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon16.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon16.setNumber(request.getParameter("orderNumber"));
			}
			listGoods.add(gpon16);
		} else {
			if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
				gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
			}
			if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
				gpon.setNumber(request.getParameter("orderNumber"));
			}
			String orderNumber2 = request.getParameter("orderNumber") + "-2";
			gpon16.setNumber(orderNumber2);
			listGoods.add(gpon);
			listGoods.add(gpon16);
		}
		sitePlatformGoodsService.createDetergentOrderDetail(listGoods);

		String price10A = request.getParameter("zong10A");
		String price16A = request.getParameter("zong16A");
		BigDecimal totlePrice = BigDecimal.valueOf(0);
		if (StringUtils.isNotBlank(pid10A) && StringUtils.isBlank(pid16A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A));
		} else if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price16A));
		} else {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A)).add(BigDecimal.valueOf(Double.valueOf(price16A)));
		}

		String productName = "美的冰箱";
		OrderInfo order = new OrderInfo();
		order.setSubject("平台合作商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totlePrice.doubleValue() * 100));
		}
		order.setOutTradeNo(tradeNo);

		String tenA = request.getParameter("quantity10");
		String sixA = request.getParameter("quantity16");
		Double zongNum = Double.valueOf(tenA) + Double.valueOf(sixA);
		order.setBody(productName + " *" + zongNum);

		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(request.getParameter("payType"));
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/refrigerator/callback/" + request.getParameter("payType"));
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate detergent order failed");
		}
		if (StringUtils.isNotBlank(pid16A) && StringUtils.isBlank(pid10A)) {
			return createDetergentResult(gpon16, pushOrderResult);
		} else {
			return createDetergentResult(gpon, pushOrderResult);
		}
	}

	/**
	 * 水龙头订单
	 */
	@RequestMapping(value = "createFaucetOrder")
	@ResponseBody
	public Object createFaucetOrder(HttpServletRequest request) {
		String pid10A = request.getParameter("pid10A");

		GoodsPlatformOrder gpon = new GoodsPlatformOrder();

		gpon.setProvince(request.getParameter("province"));
		gpon.setCity(request.getParameter("city"));
		gpon.setArea(request.getParameter("area"));

		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
		}
		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {
			gpon.setCustomerAddress(request.getParameter("customerAddress"));
		}
		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {
			if ("alipay".equals(request.getParameter("payType").toString())) {
				gpon.setPaymentType("1");
			} else {
				gpon.setPaymentType("0");
			}
		}
		// 获取商品详情
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid10A"));
		if (re != null) {
			if (StringUtils.isNotBlank(re.getStr("number"))) {
				gpon.setGoodNumber(re.getStr("number"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				gpon.setGoodName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("icon"))) {
				gpon.setGoodIcon(re.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				gpon.setGoodBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re.getStr("model"))) {
				gpon.setGoodModel(re.getStr("model"));
			}
			if (StringUtils.isNotBlank(re.getStr("category"))) {
				gpon.setGoodCategory(re.getStr("category"));
			}
		}

		if (request.getParameter("pid10A") != null && !"".equals(request.getParameter("pid10A"))) {
			gpon.setGoodId(request.getParameter("pid10A"));
		}
		if (request.getParameter("quantity10") != null && !"".equals(request.getParameter("quantity10"))) {
			String unit10A = request.getParameter("unit10A");
			if ("箱".equals(unit10A)) {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10")) * 60));
			} else {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10"))));
			}
		}
		if (request.getParameter("zong10A") != null && !"".equals(request.getParameter("zong10A"))) {
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong10A"))));
		}

		// 交易记录号
		String tradeNo = TradeNoUtils.genUniqueNo("Q");
		gpon.setTradeNo(tradeNo);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		String userId = UserUtils.getUser().getId();
		String userName = CrmUtils.getUserXM();
		gpon.setPlacingOrderBy(userId);
		gpon.setPlacingOrderTime(now);
		gpon.setPayer(userId);
		gpon.setPayStatus("0");
		gpon.setStatus("2");
		gpon.setSiteId(siteId);
		gpon.setCreator(userName);
		gpon.setSupplierId("999");
		gpon.setHadLogisticsPrice("1");

		List<GoodsPlatformOrder> listGoods = Lists.newArrayList();
		if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
			gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
		}
		if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
			gpon.setNumber(request.getParameter("orderNumber"));
		}

		listGoods.add(gpon);

		sitePlatformGoodsService.createDetergentOrderDetail(listGoods);

		String price10A = request.getParameter("zong10A");
		BigDecimal totlePrice = BigDecimal.valueOf(0);
		if (StringUtils.isNotBlank(pid10A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A));
		}

		String productName = "水龙头";
		OrderInfo order = new OrderInfo();
		order.setSubject("平台商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totlePrice.doubleValue() * 100));
		}
		order.setOutTradeNo(tradeNo);

		String unit10A = request.getParameter("unit10A");
		String unit16A = request.getParameter("unit16A");
		String tenA = "";
		if ("箱".equals(unit10A)) {
			Double a = Double.valueOf(request.getParameter("quantity10"));
			tenA = String.valueOf(a * 60);
		} else {
			tenA = request.getParameter("quantity10");
		}
		order.setBody(productName + " *" + tenA);

		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(request.getParameter("payType"));
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/faucet/callback/" + request.getParameter("payType"));
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate faucet order failed");
		}
		return createDetergentResult(gpon, pushOrderResult);
	}

	/**
	 * 除味盒订单
	 */
	@RequestMapping(value = "createflavorBoxOrder")
	@ResponseBody
	public Object createflavorBoxOrder(HttpServletRequest request) {
		String pid10A = request.getParameter("pid10A");

		GoodsPlatformOrder gpon = new GoodsPlatformOrder();

		gpon.setProvince(request.getParameter("province"));
		gpon.setCity(request.getParameter("city"));
		gpon.setArea(request.getParameter("area"));

		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
		}
		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {
			gpon.setCustomerAddress(request.getParameter("customerAddress"));
		}
		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {
			if ("alipay".equals(request.getParameter("payType").toString())) {
				gpon.setPaymentType("1");
			} else {
				gpon.setPaymentType("0");
			}
		}
		// 获取商品详情
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid10A"));
		if (re != null) {
			if (StringUtils.isNotBlank(re.getStr("number"))) {
				gpon.setGoodNumber(re.getStr("number"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				gpon.setGoodName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("icon"))) {
				gpon.setGoodIcon(re.getStr("icon"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				gpon.setGoodBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(re.getStr("model"))) {
				gpon.setGoodModel(re.getStr("model"));
			}
			if (StringUtils.isNotBlank(re.getStr("category"))) {
				gpon.setGoodCategory(re.getStr("category"));
			}
		}

		if (request.getParameter("pid10A") != null && !"".equals(request.getParameter("pid10A"))) {
			gpon.setGoodId(request.getParameter("pid10A"));
		}
		if (request.getParameter("quantity10") != null && !"".equals(request.getParameter("quantity10"))) {
			String unit10A = request.getParameter("unit10A");
			if ("箱".equals(unit10A)) {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10")) * 144));
			} else {
				gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity10"))));
			}
		}
		if (request.getParameter("zong10A") != null && !"".equals(request.getParameter("zong10A"))) {
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong10A"))));
		}

		// 交易记录号
		String tradeNo = TradeNoUtils.genUniqueNo("Q");
		gpon.setTradeNo(tradeNo);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		String userId = UserUtils.getUser().getId();
		String userName = CrmUtils.getUserXM();
		gpon.setPlacingOrderBy(userId);
		gpon.setPlacingOrderTime(now);
		gpon.setPayer(userId);
		gpon.setPayStatus("0");
		gpon.setStatus("2");
		gpon.setSiteId(siteId);
		gpon.setCreator(userName);
		gpon.setSupplierId("999");

		List<GoodsPlatformOrder> listGoods = Lists.newArrayList();
		if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
			gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice"))));
		}
		if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
			gpon.setNumber(request.getParameter("orderNumber"));
		}

		if (gpon.getPurchaseNum().compareTo(BigDecimal.valueOf(144d)) < 0) {
			gpon.setHadLogisticsPrice("1");
		} else {
			gpon.setHadLogisticsPrice("0");
		}

		listGoods.add(gpon);

		sitePlatformGoodsService.createDetergentOrderDetail(listGoods);

		String price10A = request.getParameter("zong10A");
		BigDecimal totlePrice = BigDecimal.valueOf(0);
		if (StringUtils.isNotBlank(pid10A)) {
			totlePrice = BigDecimal.valueOf(Double.valueOf(price10A));
		}

		String productName = "除味盒";
		OrderInfo order = new OrderInfo();
		order.setSubject("平台合作商品-" + productName);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totlePrice.doubleValue() * 100));
		}
		order.setOutTradeNo(tradeNo);

		String unit10A = request.getParameter("unit10A");
		String tenA = "";
		if ("箱".equals(unit10A)) {
			Double a = Double.valueOf(request.getParameter("quantity10"));
			tenA = String.valueOf(a * 144);
		} else {
			tenA = request.getParameter("quantity10");
		}
		order.setBody(productName + " *" + tenA);

		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(request.getParameter("payType"));
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/flavorbox/callback/" + request.getParameter("payType"));
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate flavorbox order failed");
		}
		return createDetergentResult(gpon, pushOrderResult);
	}

	@RequestMapping(value = "createMeiJLiOrder")
	@ResponseBody
	public Object createMeiJLiOrder(HttpServletRequest request) {
		String orderNumber = request.getParameter("orderNumber");
		if (StringUtils.isNotBlank(orderNumber)) {
			Record re = Db.findFirst("select * from crm_goods_platform_mjl_order where number=? limit 1 ", orderNumber);
			if (re != null) {
				return "numberExit";
			}
		}

		GoodsPlatFormMjlOrder gpon = new GoodsPlatFormMjlOrder();
		if (request.getParameter("customerName") != null && !"".equals(request.getParameter("customerName"))) {
			gpon.setCustomerName(request.getParameter("customerName").toString());
		}
		if (request.getParameter("customerMobile") != null && !"".equals(request.getParameter("customerMobile"))) {// 收件人手机号
			gpon.setCustomerContact(request.getParameter("customerMobile").toString());
		}
		if (request.getParameter("province") != null && !"".equals(request.getParameter("province"))) {
			gpon.setProvince(request.getParameter("province"));
		}
		if (request.getParameter("city") != null && !"".equals(request.getParameter("city"))) {
			gpon.setCity(request.getParameter("city"));
		}
		if (request.getParameter("area") != null && !"".equals(request.getParameter("area"))) {
			gpon.setArea(request.getParameter("area"));
		}
		if (request.getParameter("logisticsPrice") != null && !"".equals(request.getParameter("logisticsPrice"))) {
			gpon.setLogisticsPrice(BigDecimal.valueOf(Double.valueOf(request.getParameter("logisticsPrice").toString())));
		}
		if (request.getParameter("customerAddress") != null && !"".equals(request.getParameter("customerAddress"))) {// 收件人手机号
			gpon.setCustomerAddress(request.getParameter("customerAddress").toString());
		}
		if (request.getParameter("pid") != null && !"".equals(request.getParameter("pid"))) {// 商品id
			gpon.setGoodId(request.getParameter("pid").toString());
		}
		if (request.getParameter("quantity") != null && !"".equals(request.getParameter("quantity"))) {// 购买数量
			gpon.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity").toString())));
		}
		if (request.getParameter("zong") != null && !"".equals(request.getParameter("zong"))) {// 支付金额
			gpon.setGoodAmount(BigDecimal.valueOf(Double.valueOf(request.getParameter("zong").toString())));
		}
		if (request.getParameter("orderNumber") != null && !"".equals(request.getParameter("orderNumber"))) {
			gpon.setNumber(request.getParameter("orderNumber").toString());
		}
		if (request.getParameter("icon") != null && !"".equals(request.getParameter("icon"))) {
			gpon.setPayConfirm(request.getParameter("icon"));
		}

		if (request.getParameter("payType") != null && !"".equals(request.getParameter("payType"))) {// 支付方式
			if ("alipay".equals(request.getParameter("payType").toString())) {
				gpon.setPaymentType("1");
			} else {
				gpon.setPaymentType("0");
			}
		}
		Record re = goodsPlatFormService.showPTBJ(request.getParameter("pid").toString());
		if (StringUtils.isNotBlank(re.getStr("number"))) {
			gpon.setGoodNumber(re.getStr("number"));
		}
		if (StringUtils.isNotBlank(re.getStr("name"))) {
			gpon.setGoodName(re.getStr("name"));
		}
		if (StringUtils.isNotBlank(re.getStr("icon"))) {
			gpon.setGoodIcon(re.getStr("icon"));
		}
		if (StringUtils.isNotBlank(re.getStr("brand"))) {
			gpon.setGoodBrand(re.getStr("brand"));
		}
		if (StringUtils.isNotBlank(re.getStr("model"))) {
			gpon.setGoodModel(re.getStr("model"));
		}
		if (StringUtils.isNotBlank(re.getStr("category"))) {
			gpon.setGoodCategory(re.getStr("category"));
		}

		// pay_confirm支付凭证
		if (request.getParameter("icon") != null && !"".equals(request.getParameter("icon"))) {
			gpon.setPayConfirm(request.getParameter("icon").toString());
		}

		// 计算会员价
		BigDecimal sitePrice = re.getBigDecimal("site_price");// 商品零售价（即会员价）
		BigDecimal nums = BigDecimal.valueOf(Double.valueOf(request.getParameter("quantity")));
		BigDecimal vipPrice = sitePrice.multiply(nums);
		gpon.setVipPrice(vipPrice);

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Date now = new Date();
		// placing_order_by下单人user_id
		String sql = "select user_id from crm_site  where id='" + siteId + "'";
		Record reSite = Db.findFirst(sql);
		gpon.setPlacingOrderBy(reSite.getStr("user_id"));
		// siteself_order_id关联的服务商商品 订单信息表主键id

		// placing_order_time下单时间
		gpon.setPlacingOrderTime(now);
		// payer付款人user_id
		gpon.setPayer(reSite.getStr("user_id"));
		// payment_time付款时间
		gpon.setPaymentTime(now);
		// pay_status支付状态(0未支付 1已支付)
		gpon.setPayStatus("1");
		// status订单状态（0待审核 1待出库 2已完成 3审核不通过 4用户取消）
		gpon.setStatus("0");
		// trade_no交易记录号(TN)

		// site_id服务商id
		gpon.setSiteId(siteId);
		// creator订单创建人姓名
		gpon.setCreator(reSite.getStr("name"));
		// supplier_id供应商id(id为999时表示思方平台提供产品)
		if (StringUtils.isNotBlank(re.getStr("distribution_type"))) {
			if ("1".equals(re.getStr("distribution_type"))) {// 在自动分配
				String sqlSuperlier = "select * from crm_goods_platform_supplier_rel where good_platform_id ='" + re.getStr("id") + "' ";
				Record reSuper = Db.findFirst(sqlSuperlier);
				if (reSuper != null) {
					gpon.setSupplierId(reSuper.getStr("supplier_id"));
				}
			}
		}
		// confirm_time确认时间
		sitePlatformGoodsService.createMeiJLiOrderDetail(gpon);
		return "";
	}

	/**
	 * 短信下单。
	 */
	@RequestMapping(value = "createSmsOrder")
	@ResponseBody
	public Object createSmsOrder(@Valid SmsOrderInfo order, BindingResult result, HttpServletRequest request) {
		if (result.hasErrors()) {
			return Result.fail("422", "sms order info error");
		}

		Record tpRecord = goodsPlatFormService.showPTBJ(order.getPid());
		order.setSubject("平台商品-" + tpRecord.getStr("name"));
		if (CrmUtils.isOnlineTestSite(CrmUtils.getCurrentSiteId(UserUtils.getUser()))) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(sitePlatformGoodsService.calcSmsFee(order.getMsgCount()));
		}
		String outTradeNo = TradeNoUtils.genUniqueNo("sm");
		order.setOutTradeNo(outTradeNo);
		order.setBody(tpRecord.getStr("name") + " *" + order.getMsgCount());

		String payType = order.getPayType();
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(payType);
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/sms/callback/" + payType);
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate sms order failed");
		}

		GoodsPlatformOrder smsOrder = goodsPlatFormService.createSmsOrder(order, tpRecord, UserUtils.getUser());
		return createOrderResult(smsOrder, pushOrderResult);
	}

	/**
	 * 二维码下单。
	 */
	@RequestMapping(value = "createCodeOrder")
	@ResponseBody
	public Object createCodeOrder(@Valid OrderInfo order, BindingResult result, HttpServletRequest request) {
		if (result.hasErrors()) {
			return Result.fail("422", "qr order info error");
		}

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record qrRecord = goodsPlatFormService.showPTBJ(order.getPid());
		BigDecimal sitePrice = BigDecimal.valueOf(Double.valueOf(request.getParameter("price")));
		BigDecimal totalAmount = sitePrice.multiply(BigDecimal.valueOf(order.getQuantity()));
		order.setSubject("平台商品-" + qrRecord.getStr("name"));
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totalAmount.doubleValue() * 100));
		}
		String outTradeNo = TradeNoUtils.genUniqueNo("qr");
		order.setOutTradeNo(outTradeNo);
		order.setBody(order.getName() + " *" + order.getQuantity());

		String payType = order.getPayType();
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(payType);// 付款方式：微信，支付宝
		OrderContext orderContext = new OrderContext(request);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/code/callback/" + payType);
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			return Result.fail("422", "precreate tp order failed");
		}

		GoodsPlatformOrder qrOrder = goodsPlatFormService.createCodeOrder(order, qrRecord, UserUtils.getUser(), totalAmount);
		return createOrderResult(qrOrder, pushOrderResult);// qrOrder为生成的平台商品订单，
	}

	/**
	 * 根据平台业务订单和支付宝|微信下单结果，生成响应。
	 *
	 * @param order
	 *            业务订单
	 * @param pushOrderResult
	 *            向支付宝和微信下单结果
	 */
	private Result createOrderResult(GoodsPlatformOrder order, PushOrderResult pushOrderResult) {
		if (StringUtils.isNotBlank(order.getId())) {
			Map<String, Object> response = pushOrderResult.getResponse();
			String qrCodeUrl = (String) response.get("qr_code_url");
			Result<String[]> ret = new Result<>();
			ret.setCode("200");
			ret.setData(new String[] { qrCodeUrl, order.getTradeNo(), order.getNumber() });
			return ret;
		}

		return Result.fail("422", String.format("create platform %s order failed", order.getGoodName()));
	}

	/**
	 * 根据平台业务订单和支付宝|微信下单结果，生成响应。
	 *
	 * @param order
	 *            业务订单(清洁剂)
	 * @param pushOrderResult
	 *            向支付宝和微信下单结果
	 */
	private Result createDetergentResult(GoodsPlatformOrder order, PushOrderResult pushOrderResult) {
		Map<String, Object> response = pushOrderResult.getResponse();
		String qrCodeUrl = (String) response.get("qr_code_url");
		Result<String[]> ret = new Result<>();
		ret.setCode("200");
		ret.setData(new String[] { qrCodeUrl, order.getTradeNo(), order.getNumber() });
		return ret;
	}

	/**
	 * 根据平台业务订单和支付宝|微信下单结果，生成响应。
	 *
	 * @param order
	 *            业务订单(南岛)
	 * @param pushOrderResult
	 *            向支付宝和微信下单结果
	 */
	private Result createNanDaoOrderResult(GoodsPlatformTransferOrder order, PushOrderResult pushOrderResult) {
		Map<String, Object> response = pushOrderResult.getResponse();
		String qrCodeUrl = (String) response.get("qr_code_url");
		Result<String[]> ret = new Result<>();
		ret.setCode("200");
		ret.setData(new String[] { qrCodeUrl, order.getTradeNo(), order.getNumber() });
		return ret;
	}

	/*
	 * 取消平台商品订单 orderProgress
	 */
	@ResponseBody
	@RequestMapping(value = "cancelPlatOrder")
	public String cancelPlatOrder(String id, String soId, String gId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		String pNum1 = ((String[]) map.get("pNum"))[0];
		double pNum = Double.parseDouble(pNum1);
		return sitePlatformGoodsService.cancelPlatOrder(id, soId, gId, pNum);
	}

	/*
	 * 取消平台商品订单
	 */
	@ResponseBody
	@RequestMapping(value = "orderProgress")
	public Record orderProgress(String id, HttpServletRequest request, HttpServletResponse response) {
		return sitePlatformGoodsService.orderProgress(id);
	}

	// 查看詳情
	@RequestMapping(value = "continuePayId")
	public String continuePayId(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		Record rd = sitePlatformGoodsService.orderProgressId(id);
		model.addAttribute("rds", rd);
		return "modules/" + "goods/merchandisePay";
	}

	/* 网点开通收费版，点击立即支付生成订单 */
	@ResponseBody
	@RequestMapping(value = "scPlatOrder")
	public Map<String, Object> scPlatOrder(String countMoney, String zfType, String gmMonth, HttpServletRequest request, HttpServletResponse response) {
		/*
		 * if (result.hasErrors()) { return Result.fail("422", "cop order info error");
		 * }
		 */
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String type = request.getParameter("type");
		if ("xufei".equals(type)) {
			// 这中情况下是针对老的客户并且以5折(1825)和6折(2190)，续费vip。
			int months = Integer.valueOf(gmMonth);
			int siteXufeiAmount = siteService.getSiteXufeiAmount(siteService.get(siteId), months);
			if (Integer.valueOf(countMoney) != siteXufeiAmount) {
				throw new RuntimeException("invalid Xufei money detected:" + countMoney + ";expected:" + siteXufeiAmount + ";months=" + gmMonth + ";sid=" + siteId);
			}
		}

		HashMap<String, Object> ret = new HashMap<>();
		OrderInfo order = new OrderInfo();
		Record rd = sitePlatformGoodsService.getSiteMessage(siteId);
		OrderContext orderContext = new OrderContext(request);
		String payType = "";
		if (zfType.equals("wx")) {
			payType = "wx";
		} else {
			payType = "alipay";
		}
		UnifyOrderService unipayOrderService = UniPayOrderServiceFactory.getUnipayOrderService(payType);
		orderContext.setNotifyUrl(Global.getConfig("pay.callback.prefix") + "/notify/sf/callback/" + payType);// http/https路径。
		String outTradeNo = TradeNoUtils.genUniqueNo("po");
		logger.error("-> Generated out trade no is:" + outTradeNo);
		order.setOutTradeNo(outTradeNo);
		order.setPayType(payType);
		String sbJect = "";
		if (gmMonth.equals("1")) {
			sbJect = "一个月";
		} else if (gmMonth.equals("6")) {
			sbJect = "半年";
		} else if (gmMonth.equals("12")) {
			sbJect = "一年";
		} else if (gmMonth.equals("24")) {
			sbJect = "两年";
		} else if (gmMonth.equals("36")) {
			sbJect = "三年";
		}
		BigDecimal totalMoney = new BigDecimal("0");
		if (StringUtils.isNotBlank(countMoney)) {
			totalMoney = new BigDecimal(countMoney);
		}
		order.setCustomerName(rd.getStr("name"));
		order.setQuantity(1);
		order.setCustomerMobile(rd.getStr("mobile"));
		order.setCustomerAddress(rd.getStr("address"));
		order.setSubject("平台商品-思方erp VIP会员" + sbJect);
		if (CrmUtils.isOnlineTestSite(siteId) || CrmUtils.isOfflineTestSite(siteId)) {
			order.setTotalFee(1L);
		} else {
			order.setTotalFee(Math.round(totalMoney.doubleValue() * 100));
		}
		order.setBody("平台商品-思方erp VIP会员" + " *" + order.getQuantity());
		PushOrderResult pushOrderResult = unipayOrderService.unifyOrder(orderContext, order);// ??
		PushOrderStatus pushOrderStatus = pushOrderResult.getPushOrderStatus();
		if (PushOrderStatus.SUCCESS != pushOrderStatus) {
			ret.put("result", Result.fail("422", "precreate sc order failed"));
			ret.put("timeList", "");
			return ret;
		}
		GoodsPlatformOrder gpOrder = sitePlatformGoodsService.scPlatOrder(outTradeNo, countMoney, zfType, siteId, sbJect, gmMonth);
		Result result = createOrderResult(gpOrder, pushOrderResult);
		List<Map<String, Object>> list = sitePlatformGoodsService.timeDistinct(siteId, gmMonth);
		ret.put("result", result);
		ret.put("timeList", list);
		return ret;
	}

	/* 购买VIP历史订单详情 */
	@ResponseBody
	@RequestMapping(value = "historyOrder")
	public List<Record> historyOrder(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return sitePlatformGoodsService.historyOrder(siteId);
	}

	/* 免费版和收费版的区分 */
	@ResponseBody
	@RequestMapping(value = "distinct")
	public String distinct(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String dict = FreeOrVipUtils.freeVip();
		if (StringUtils.isBlank(siteId) || dict.equals("0")) {
			return "noPopup";
		}
		return sitePlatformGoodsService.distinct(siteId);

	}

	@RequestMapping(value = "jumpVIP")
	public String jumpVIP(HttpServletRequest request, HttpServletResponse response) {
		return "modules/" + "goods/openVIP";
	}

	@ResponseBody
	@RequestMapping("testVip")
	public Object testVip() {
		HashMap<String, String> ret = new HashMap<>();
		ret.put("msg", "hello");
		return ret;
	}

	@ResponseBody
	@RequestMapping(value = "getSite")
	public Record getSite(HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return sitePlatformGoodsService.getSiteMessage(siteId);
	}

	@ResponseBody
	@RequestMapping(value = "getPlatGoodsMsgByIds")
	public List<Record> getPlatGoodsMsgByIds(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		return sitePlatformGoodsService.getPlatGoodsMsgByIds(ids);
	}
}
