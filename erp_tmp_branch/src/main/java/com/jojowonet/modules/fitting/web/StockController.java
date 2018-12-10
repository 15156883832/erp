package com.jojowonet.modules.fitting.web;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.FittingDao;
import com.jojowonet.modules.fitting.entity.EmpFittingKeep;
import com.jojowonet.modules.fitting.entity.EmployeFitting;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingUsedRecord;
import com.jojowonet.modules.fitting.entity.SiteFittingKeep;
import com.jojowonet.modules.fitting.form.EmpFittingExport;
import com.jojowonet.modules.fitting.form.EmployeFittingCountExport;
import com.jojowonet.modules.fitting.service.EmpFittingKeepService;
import com.jojowonet.modules.fitting.service.EmployeFittingService;
import com.jojowonet.modules.fitting.service.FittingService;
import com.jojowonet.modules.fitting.service.FittingUsedRecordService;
import com.jojowonet.modules.fitting.service.SiteFittingKeepService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.goods.utils.LogisticsUtils;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.BrandService;
import com.jojowonet.modules.order.service.UnitService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.ExcelUtilsEx;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.TrimMap;
import com.jojowonet.modules.sys.util.http.EzTemplate;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportExcel;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

/**
 * 库存管理模块
 *
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/fitting/stock")
public class StockController extends BaseController {

	@Autowired
	private SiteService siteService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private FittingService fittingService;
	@Autowired
	private FittingDao fittingDao;
	@Autowired
	private FittingUsedRecordService fittingUsedRecordService;
	@Autowired
	private NonServicemanService nonService;
	@Autowired
	private SiteFittingKeepService siteFittingKeepService;
	@Autowired
	private EmployeFittingService employeFittingService;
	@Autowired
	private EmpFittingKeepService empFittingKeepService;
	@Autowired
	private EmployeService employeService;
	@Autowired
	private UnitService unitService;

	@Autowired
	private EzTemplate ezTemplate;

	// 备件库存管理
	@RequestMapping(value = "index")
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		SiteTableHeaderForm stf = JqGridTableUtils.getDefaultTableHead(request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("headerData", stf);
		model.addAttribute("listR", listR);
		model.addAttribute("userId", UserUtils.getUser().getId());
		model.addAttribute("userName", UserUtils.getUser().getLoginName());
		model.addAttribute("curTime", DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
		return "modules/fitting/stock/index";
	}

	// 待返还表头
	@RequestMapping(value = "waitReturn")
	public String waitReturn(HttpServletRequest request, HttpServletResponse response, Model model) {
		SiteTableHeaderForm stf = JqGridTableUtils.getDefaultTableHead(request.getServletPath());
		String empId = request.getParameter("empId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		model.addAttribute("headerData", stf);
		// 显示受拨人下拉框
		List<Employe> list = employeService.getListEmp(null, siteId);
		model.addAttribute("headerData", stf);
		model.addAttribute("empId", empId);
		model.addAttribute("list", list);
		return "modules/fitting/stock/waitReturn";
	}

	@RequestMapping(value = "ajaxList")
	@ResponseBody
	public String ajaxList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record> page = new Page<>(request, response);
		page = fittingService.findStockPage(page, params, siteId);
		return renderJson(new JqGridPage<>(page));
	}

	// 待返还表数据
	@RequestMapping(value = "ajaxWaitReturnList")
	@ResponseBody
	public String ajaxWaitReturnList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		params.put("siteId", siteId);
		Page<Record> page = new Page<>(request, response);
		page = fittingService.findWaitReturnPage(page, params);
		return renderJson(new JqGridPage<>(page));
	}

	// 工程师库存
	@RequestMapping(value = "form")
	public String form(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String id = String.valueOf(params.get("id"));
		if (StringUtils.isNotBlank(id)) {
			Fitting fitting = fittingService.getById(id);
			String[] mgs = null;
			if (fitting != null) {
				if (StringUtils.isNotBlank(fitting.getImg())) {
					mgs = fitting.getImg().split(",");
					model.addAttribute("imagesSize", mgs.length);
				}
			}
			model.addAttribute("images", mgs);
			model.addAttribute("fitting", fitting);
		}
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("categoryList", listR);
		model.addAttribute("UnitList", unitService.getUnitList());
		return "modules/fitting/stock/form";
	}

	@ResponseBody
	@RequestMapping(value = "getFittings")
	public List<Record> getFittings() {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String sql = "select code,version,name from crm_site_fitting where status='1' and site_id='" + siteId + "' ";
		return Db.find(sql);
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsBySelect")
	public Map<String, Object> getFittingsBySelect(HttpServletRequest request, String page) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String code = request.getParameter("q");
		StringBuilder sb = new StringBuilder();
		sb.append("select code from crm_site_fitting where status='1' and site_id=? and code like ? ");
		List<Record> list = Db.find(sb.toString(), siteId, '%' + code + '%');
		Map<String, Object> map = Maps.newHashMap();
		map.put("list", list);
		map.put("total_count", list.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsNameBySelect")
	public Map<String, Object> getFittingsNameBySelect(HttpServletRequest request, String page) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String name = request.getParameter("q");
		StringBuilder sb = new StringBuilder();
		sb.append("select code,name,warning from crm_site_fitting where status='1' and site_id=? and name like ? ");
		List<Record> list = Db.find(sb.toString(), siteId, '%' + name + '%');
		Map<String, Object> map = Maps.newHashMap();
		map.put("list", list);
		map.put("total_count", list.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsBySelectEmp")
	public Map<String, Object> getFittingsBySelectEmp(HttpServletRequest request, String page) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String code = request.getParameter("q");
		String empId = request.getParameter("empId");
		String ids = request.getParameter("ids");

		StringBuilder sb = new StringBuilder();
		sb.append(
				"select sf.code,sf.name,sf.version,sf.type,ef.warning,sf.unit,ef.suit_category,ef.suit_brand, ef.id,ef.fitting_id,e.id as employe_id,e.name as diaoPeople  from crm_employe_fitting ef");
		sb.append(" left join crm_site_fitting sf on ef.fitting_id=sf.id");
		sb.append(" left join crm_employe e on e.id=ef.employe_id");
		sb.append(" where sf.code like '%" + code + "%' and ef.site_id='" + siteId + "' and e.id='" + empId + "' ");
		if (StringUtils.isNotBlank(ids)) {
			sb.append(" and ef.id not in (" + StringUtil.joinInSql(ids.split(",")) + ")");
		}
		List<Record> list = Db.find(sb.toString());
		Map<String, Object> map = Maps.newHashMap();
		map.put("list", list);
		map.put("total_count", list.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsNameBySelectEmp")
	public Map<String, Object> getFittingsNameBySelectEmp(HttpServletRequest request, String page) {

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String name = request.getParameter("q");
		String empId = request.getParameter("empId");
		String ids = request.getParameter("ids");

		StringBuilder sb = new StringBuilder();
		sb.append(
				"select sf.code,sf.name,sf.version,sf.type,ef.warning,sf.unit,ef.suit_category,ef.suit_brand, ef.id,ef.fitting_id,e.id as employe_id,e.name as diaoPeople  from crm_employe_fitting ef");
		sb.append(" left join crm_site_fitting sf on ef.fitting_id=sf.id");
		sb.append(" left join crm_employe e on e.id=ef.employe_id");
		sb.append(" where sf.name like '%" + name + "%' and ef.site_id='" + siteId + "' and e.id='" + empId + "' ");
		if (StringUtils.isNotBlank(ids)) {
			sb.append(" and ef.id not in (" + StringUtil.joinInSql(ids.split(",")) + ")");
		}
		List<Record> list = Db.find(sb.toString());
		Map<String, Object> map = Maps.newHashMap();
		map.put("list", list);
		map.put("total_count", list.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsVersionBySelect")
	public Map<String, Object> getFittingsVersionBySelect(HttpServletRequest request, String page) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String version = request.getParameter("q");
		StringBuilder sb = new StringBuilder();
		sb.append("select code,version from crm_site_fitting where status='1' and site_id='" + siteId + "' and version like '%" + version + "%' ");
		List<Record> list = Db.find(sb.toString());
		Map<String, Object> map = Maps.newHashMap();
		map.put("list", list);
		map.put("total_count", list.size());
		return map;
	}

	@RequestMapping(value = "addEmployeFittingApply")
	public String addEmployeFittingApply(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> emps = employeService.findBySiteId(siteId);
		String ids = request.getParameter("ids");
		String[] idArr = null;
		int length = 0;
		List<Record> fittings = null;
		if (StringUtils.isNotBlank(ids)) {
			idArr = ids.split(",");
			length = idArr.length;
			fittings = fittingService.getAllFittingByIds(idArr);
		}
		model.addAttribute("fittings", fittings);
		model.addAttribute("emps", emps);
		model.addAttribute("fittingSize", length);
		return "modules/fitting/addEmpFitApplyForm";
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsByCode")
	public Record getFittingsByCode(HttpServletRequest request) {
		String code = request.getParameter("code");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String sql = "select code,name,version,site_price,warning,id,suit_brand,suit_category,type from crm_site_fitting where status='1' and site_id='" + siteId + "' and code='"
				+ code + "' ";
		return Db.findFirst(sql);
	}

	@ResponseBody
	@RequestMapping(value = "getFittingsByCodeEmpKeep")
	public Record getFittingsByCodeEmpKeep(HttpServletRequest request) {
		String code = request.getParameter("code");
		String empId = request.getParameter("empId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		StringBuilder sb = new StringBuilder();
		sb.append(
				"select sf.customer_price,sf.employe_price,sf.site_price,sf.code,sf.name,sf.version,sf.type,ef.warning,sf.unit,ef.suit_category,ef.suit_brand,sf.brand, ef.id,ef.fitting_id as fittingId,e.id as employe_id,e.name as diaoPeople  from crm_employe_fitting ef");
		sb.append(" left join crm_site_fitting sf on ef.fitting_id=sf.id");
		sb.append(" left join crm_employe e on e.id=ef.employe_id");
		sb.append(" where sf.code ='" + code + "' and ef.site_id='" + siteId + "' and e.id='" + empId + "'");
		return Db.findFirst(sb.toString());
		/*
		 * String sql =
		 * "select code,name,version,site_price,warning,id,suit_brand,suit_category,type from crm_site_fitting where status='1' and site_id='"
		 * + siteId + "' and code='" + code + "' "; return Db.findFirst(sql);
		 */
	}

	// 备件详情
	@ResponseBody
	@RequestMapping(value = "showDetail")
	public Object showDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		return fittingService.getById(id);
	}

	// 工程师库存
	@RequestMapping(value = "empFitting")
	public String empFitting(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		params.put("siteId", siteId);
		Page<Record> page = new Page<>(request, response);
		page = fittingService.findEmpFittingPage(page, params);
		model.addAttribute("empList", fittingService.getDefaultEmployeList(siteId));
		model.addAttribute("page", page);
		model.addAttribute("map", params);
		return "modules/fitting/stock/empFitting";
	}

	/*
	 * // 待返还表数据
	 * 
	 * @RequestMapping(value = "empFittingList")
	 * 
	 * @ResponseBody public String empFittingList(HttpServletRequest request,
	 * HttpServletResponse response, Model model) { Map<String, Object> params = new
	 * TrimMap(getParams(request)); String siteId =
	 * CrmUtils.getCurrentSiteId(UserUtils.getUser()); params.put("siteId", siteId);
	 * 
	 * return renderJson(new JqGridPage<>(page)); }
	 */

	// 工程师库存明细
	@RequestMapping(value = "empFittingItem")
	public String empFittingItem(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String empId = request.getParameter("empId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getDefaultTableHead(request.getServletPath());
		model.addAttribute("headerData", stf);
		params.put("siteId", siteId);
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(siteId);
		// 显示受拨人下拉框
		List<Employe> list = employeService.getListEmp(null, siteId);
		model.addAttribute("list", list);
		model.addAttribute("listR", listR);
		model.addAttribute("empId", empId);
		return "modules/fitting/stock/empFitingAllForm";
	}

	@RequestMapping(value = "getEmpKeepList")
	@ResponseBody
	public String getEmpKeepList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		params.put("siteId", siteId);
		Page<Record> page = new Page<>(request, response);
		page = fittingService.getEmpKeepPage(page, params);
		return renderJson(new JqGridPage<>(page));
	}

	// 查询
	@ResponseBody
	@RequestMapping(value = "empSelFitting")
	public Object empSelFitting(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> params = new TrimMap(getParams(request));
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		params.put("siteId", siteId);
		List<Record> rds = fittingService.getEmpFittingItems(params);
		if (rds != null) {
			for (Record r : rds) {
				model.addAttribute("epName", r.getStr("empName"));
			}
		}
		return rds;
	}

	// 调拨信息显示
	@RequestMapping(value = "tiaoBo")
	@ResponseBody
	public Record tiaoBo(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record re = employeFittingService.tiaoBo(id, siteId);
		return re;
	}

	// 显示零售信息
	@RequestMapping(value = "showEmpRetail")
	@ResponseBody
	public Record showEmpRetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record re = employeFittingService.showRetail(id, siteId);
		return re;
	}

	// 调拨
	@RequestMapping(value = "doDB")
	@ResponseBody
	public String doDB(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String idO = request.getParameter("idO");// 调拨人id
		String idT = request.getParameter("idT");// 受调拨人id
		String amount = request.getParameter("amount");// 调拨数量
		String fittingId = request.getParameter("fittingId");

		Fitting f = fittingService.get(fittingId);
		Employe e = employeService.get(idO);// 调拨工程师信息
		Employe e2 = employeService.get(idT);// 受调拨工程师信息
		// 工程师信息的操作
		EmployeFitting ef = new EmployeFitting();
		ef.setFittingId(fittingId);
		if (f.getType() != null) {
			ef.setType(f.getType());
		}
		if (f.getSuitCategory() != null) {
			ef.setSuitCategory(f.getSuitCategory());
		}
		ef.setEmployeId(idT);
		if (f.getBrand() != null) {
			ef.setSuitBrand(f.getBrand());
		}
		ef.setStatus("1");
		ef.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		ef.setCreateTime(new Date());
		ef.setCreateBy(user.getId());
		BigDecimal bd = new BigDecimal(amount);
		ef.setWarning(bd);
		ef.setTotal(bd);
		String nm = "0";
		BigDecimal number = new BigDecimal(nm);
		ef.setNumber(number);
		ef.setCjnum(number);

		Date now = new Date();
		// 工程师备件出入库明细表操作(调拨人)
		EmpFittingKeep efk = new EmpFittingKeep();
		efk.setNumber(CrmUtils.no());// 编号，生成规则：yyyyMMddHHmmssSSS
		efk.setType("4");// 类型：0领取，1工单使用 2零售，3返还 4调拨
		efk.setFittingId(fittingId);// 备件id
		if (f.getCode() != null) {
			efk.setFittingCode(f.getCode());// 备件条码
		}
		if (f.getName() != null) {
			efk.setFittingName(f.getName());// 备件名称
		}
		// 关联工单id
		efk.setAmount(Double.parseDouble("-" + amount));// 数量
		if (f.getSitePrice() != null) {
			efk.setPrice(f.getSitePrice());// 入库价格
		}
		if (f.getEmployePrice() != null) {
			efk.setEmployePrice(f.getEmployePrice());// 工程师价格
		}
		if (f.getCustomerPrice() != null) {
			efk.setCustomerPrice(f.getCustomerPrice());// 零售价格
		}
		efk.setCreateTime(now);// 创建时间
		if (e.getName() != null) {
			efk.setEmployeName(e.getName());// 工程师姓名
		}
		efk.setEmployeId(idO);// 工程师id
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		efk.setSiteId(siteId);// 服务商id
		efk.setCreateBy(user.getId());// 创建人user_id

		// 工程师备件出入库明细表操作(受调拨人)
		EmpFittingKeep efks = new EmpFittingKeep();
		efks.setNumber(CrmUtils.no());// 编号，生成规则：yyyyMMddHHmmssSSS
		efks.setType("4");// 类型：0领取，1工单使用 2零售，3返还 4调拨
		efks.setFittingId(fittingId);// 备件id
		if (f.getCode() != null) {
			efks.setFittingCode(f.getCode());// 备件条码
		}
		if (f.getName() != null) {
			efks.setFittingName(f.getName());// 备件名称
		}
		// 关联工单id
		efks.setAmount(Double.parseDouble(amount));// 数量
		if (f.getSitePrice() != null) {
			efks.setPrice(f.getSitePrice());// 入库价格
		}
		if (f.getEmployePrice() != null) {
			efks.setEmployePrice(f.getEmployePrice());// 工程师价格
		}
		if (f.getCustomerPrice() != null) {
			efks.setCustomerPrice(f.getCustomerPrice());// 零售价格
		}
		efks.setCreateTime(now);// 创建时间
		efks.setEmployeName(e2.getName());// 工程师姓名
		efks.setEmployeId(idT);// 工程师id
		efks.setSiteId(siteId);// 服务商id
		efks.setCreateBy(user.getId());// 创建人user_id
		empFittingKeepService.doDB(idO, Double.parseDouble(amount), idT, fittingId, ef, efk, efks);
		return "ok";
	}

	// 零售动作
	@RequestMapping(value = "doLS")
	@ResponseBody
	public int doLS(HttpServletRequest request, HttpServletResponse response, Model model) {
		int num = 0;

		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> params = new TrimMap(getParams(request));
		Fitting fit = fittingService.getById(params.get("id").toString());
		if (Double.parseDouble(params.get("saleAmount").toString()) <= fit.getWarning()) {// 如果零售数量小于库存数量
			// 备件详细表操作
			// fittingService.doLS(params);
			// 服务商备件使用记录表
			FittingUsedRecord fur = new FittingUsedRecord();
			fur.setFittingId(params.get("id").toString());// 备件id
			fur.setSiteId(siteId);// 服务商id
			fur.setType("4");// 服务商零售
			BigDecimal bd = new BigDecimal((params.get("saleAmount").toString()));
			fur.setUsedNum(bd);// 零售数量

			if (StringUtils.isNotBlank(fit.getCode())) {
				fur.setFittingCode(fit.getCode());
			}
			if (StringUtils.isNotBlank(fit.getVersion())) {
				fur.setFittingVersion(fit.getVersion());
			}
			if (StringUtils.isNotBlank(fit.getName())) {
				fur.setFittingName(fit.getName());
			}
			if (StringUtils.isNotBlank(fit.getBrand())) {
				fur.setBrand(fit.getBrand());
			}
			if (StringUtils.isNotBlank(fit.getSuitCategory())) {
				fur.setCategory(fit.getSuitCategory());
			}

			fur.setStatus("1");// 申请状态
			fur.setUsedTime(new Date());// 创建时间
			fur.setCreateBy(user.getId());// 使用人user_id

			String name = CrmUtils.getUserXM();
			fur.setUserName(name);// 使用人姓名
			fur.setOldFittingFlag("0");// 旧件返还标记
			fur.setCollectionFlag("1");// 收款标记
			fur.setCreator(name);
			fur.setCustomerName(params.get("customerName") != null ? params.get("customerName").toString() : "");
			fur.setCustomerMobile(params.get("customerMobile") != null ? params.get("customerMobile").toString() : "");
			fur.setCustomerAddress(params.get("customerAddress") != null ? params.get("customerAddress").toString() : "");

			BigDecimal m = new BigDecimal((params.get("saleTotalPrice").toString()));
			fur.setCollectionMoney(m);// 收款金额
			/*
			 * 新增备件出入库明细表信息
			 */
			SiteFittingKeep fittingKeep = new SiteFittingKeep();
			fittingKeep.setFittingId(params.get("id").toString());// 备件id
			fittingKeep.setNumber(CrmUtils.no());// 用时间生成备件编号
			fittingKeep.setFittingCode(params.get("code").toString());// 备件条码
			fittingKeep.setFittingName(params.get("name").toString());// 备件名称
			fittingKeep.setAmount(Double.parseDouble(params.get("saleAmount").toString()));// 数量
			if (params.get("sitePrice") != null && !"".equals(params.get("sitePrice"))) {
				fittingKeep.setPrice(Double.parseDouble(params.get("sitePrice").toString()));// 入库价格
			}

			if (params.get("employePrice") != null && !"".equals(params.get("employePrice"))) {
				fittingKeep.setEmployePrice(Double.parseDouble(params.get("employePrice").toString()));// 工程师价格
			}
			if (params.get("customerPrice") != null && !"".equals(params.get("customerPrice"))) {
				fittingKeep.setCustomerPrice(Double.parseDouble(params.get("customerPrice").toString()));// 零售价格
			}
			// fittingKeep //备注
			fittingKeep.setApplicant(name); // 申请人
			// fittingKeep //确认人
			fittingKeep.setCreateBy(user.getId());// 创建人user_id
			fittingKeep.setSiteId(siteId); // 服务商id
			fittingKeep.setType("4");// 类型
			fittingKeep.setRemarks(params.get("outstockMark") != null ? params.get("outstockMark").toString() : "");
			num = fittingUsedRecordService.doSave(fur, params, fittingKeep);

			/* 库存预警 */
			fittingService.stockAlert(params.get("id").toString());
		}
		return num;
	}

	// 工程师库存零售
	@RequestMapping(value = "doEmpRetail")
	@ResponseBody
	public int doEmpRetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		int num = 0;
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> params = new TrimMap(getParams(request));
		String id = params.get("id").toString();
		EmployeFitting fit = employeFittingService.get(id);
		if (Double.parseDouble(params.get("saleAmount").toString()) <= fit.getWarning().doubleValue()) {// 如果零售数量小于库存数量
			/*
			 * 新增备件出入库明细表信息
			 */
			EmpFittingKeep fittingKeep = new EmpFittingKeep();
			String sql = "select * from crm_employe where id=?";
			Record rec = Db.findFirst(sql, fit.getEmployeId());
			if (rec != null) {
				if (StringUtils.isNotBlank(rec.getStr("name"))) {
					fittingKeep.setEmployeId(fit.getEmployeId());
					fittingKeep.setEmployeName(rec.getStr("name"));
				}
			}

			fittingKeep.setFittingId(fit.getFittingId());// 备件id
			fittingKeep.setNumber(CrmUtils.no());// 用时间生成备件编号
			fittingKeep.setFittingCode(params.get("code").toString());// 备件条码
			fittingKeep.setFittingName(params.get("name").toString());// 备件名称
			fittingKeep.setAmount(Double.parseDouble(params.get("saleAmount").toString()));// 数量
			if (params.get("sitePrice") != null && !"".equals(params.get("sitePrice"))) {
				fittingKeep.setPrice(Double.parseDouble(params.get("sitePrice").toString()));// 入库价格
			}

			if (params.get("employePrice") != null && !"".equals(params.get("employePrice"))) {
				fittingKeep.setEmployePrice(Double.parseDouble(params.get("employePrice").toString()));// 工程师价格
			}
			if (params.get("customerPrice") != null && !"".equals(params.get("customerPrice"))) {
				fittingKeep.setCustomerPrice(Double.parseDouble(params.get("customerPrice").toString()));// 零售价格
			}
			fittingKeep.setCreateBy(user.getId());// 创建人user_id
			fittingKeep.setSiteId(siteId); // 服务商id
			fittingKeep.setType("2");// 类型

			// 服务商备件使用记录表
			String sqlFitting = "select * from crm_site_fitting where id='" + fit.getFittingId() + "'";
			Record re = Db.findFirst(sqlFitting);

			FittingUsedRecord fur = new FittingUsedRecord();
			fur.setFittingId(fit.getFittingId());// 备件id
			fur.setSiteId(siteId);// 服务商id
			fur.setType("3");// 工程师零售
			BigDecimal bdecimal = new BigDecimal((params.get("saleAmount").toString()));
			fur.setUsedNum(bdecimal);// 零售数量

			if (StringUtils.isNotBlank(re.getStr("code"))) {
				fur.setFittingCode(re.getStr("code"));
			}
			if (StringUtils.isNotBlank(re.getStr("version"))) {
				fur.setFittingVersion(re.getStr("version"));
			}
			if (StringUtils.isNotBlank(re.getStr("name"))) {
				fur.setFittingName(re.getStr("name"));
			}
			if (StringUtils.isNotBlank(re.getStr("brand"))) {
				fur.setBrand(re.getStr("brand"));
			}
			if (StringUtils.isNotBlank(fit.getSuitCategory())) {
				fur.setCategory(fit.getSuitCategory());
			}

			fur.setEmployeId(fit.getEmployeId());
			fur.setStatus("1");// 申请状态
			fur.setUsedTime(new Date());// 创建时间
			fur.setCreateBy(user.getId());// 使用人user_id

			fur.setUserName(rec.getStr("name"));// 使用人姓名
			fur.setOldFittingFlag("0");// 旧件返还标记
			fur.setCollectionFlag("1");// 收款标记
			fur.setCreator(CrmUtils.getUserXM());

			BigDecimal m = new BigDecimal((params.get("saleTotalPrice").toString()));
			fur.setCollectionMoney(m);// 收款金额

			num = fittingUsedRecordService.doEmpRetailSave(fur, params, fittingKeep);

		}
		return num;
	}

	/**
	 * 工程师备件返还并入库
	 */
	@ResponseBody
	@RequestMapping(value = "turnToStock")
	public Object turnToStock(HttpServletRequest request) {
		String empFittingId = request.getParameter("empId"); // 参数empId实际意义是empFittingId
		String fittingId = request.getParameter("fitId");
		double num = Double.valueOf(request.getParameter("num"));

		Record re = Db.findFirst("select a.warning from crm_employe_fitting a where a.id=? ", empFittingId);
		if (re.getBigDecimal("warning").compareTo(BigDecimal.valueOf(num)) < 0) {// 库存数量不足不可返还
			return Result.fail("203", "库存不足");
		}

		Object ob = fittingService.empFittingRecycle(empFittingId, fittingId, num);
		fittingService.cancelStockAlert(fittingId);
		return ob;
	}

	/**
	 * 工程师配件返还保存操作
	 */
	@ResponseBody
	@RequestMapping(value = "employTurnBack")
	public Object employTurnBack(HttpServletRequest request) {
		String empFittingId = request.getParameter("empId");
		String fittingId = request.getParameter("fitId");
		double num = Double.valueOf(request.getParameter("num"));

		Record re = Db.findFirst("select a.warning from crm_employe_fitting a where a.id=? ", empFittingId);
		if (re.getBigDecimal("warning").compareTo(BigDecimal.valueOf(num)) < 0) {// 库存数量不足不可返还
			return Result.fail("203", "库存不足");
		}

		logger.info(String.format("[备件返还需审核]，empFittingId=%s,fittingId=%s,recycleNum=%s", empFittingId, fittingId, num));
		return fittingService.turnBack(empFittingId, fittingId, num);
	}

	@ResponseBody
	@RequestMapping(value = "doTurnBack")
	public Object doTurnBack(HttpServletRequest request) {
		String id = request.getParameter("id");
		String num = request.getParameter("num");
		String result = fittingUsedRecordService.doTurnBack(id, num);
		/* 库存预警 */
		fittingService.stockAlert(id);
		return result;
	}

	// 调整库存动作
	@RequestMapping(value = "doTZKC")
	@ResponseBody
	public String doTZKC(HttpServletRequest request, HttpServletResponse response, Model model) {
		String name = CrmUtils.getUserXM();
		Map<String, Object> params = new TrimMap(getParams(request));
		String id = params.get("fittingId").toString();
		Fitting fi = fittingService.getWarning(id);
		fittingService.doTZKC(params, fi, name);
		/* 添加或取消库存预警 */
		fittingService.stockAlert(fi.getId());
		fittingService.cancelStockAlert(fi.getId());
		return "ok";
	}

	// 手动入库动作
	@RequestMapping(value = "dosdruku")
	@ResponseBody
	public String dosdruku(String data, String remarks, HttpServletRequest request, HttpServletResponse response, Model model) {
		return fittingService.dosdruku(data, remarks, UserUtils.getUser());
	}

	/* 备件申请页面入库 */
	@RequestMapping(value = "putInStock")
	@ResponseBody
	public String putInStock(String fittingId, String applyPlanId, Double planNum, HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String fittingCode = request.getParameter("fittingCode");
		String planMarks = request.getParameter("planMarks");
		if (StringUtils.isBlank(fittingId) && StringUtils.isNotBlank(fittingCode)) {
			Record re = Db.findFirst("select a.id from crm_site_fitting a where a.code=? and a.site_id=?", fittingCode, siteId);
			fittingId = re.getStr("id");
		}
		if (StringUtils.isBlank(fittingId) && StringUtils.isBlank(fittingCode)) {
			return "203";
		}
		fittingService.putInStock(fittingId, applyPlanId, planNum, UserUtils.getUser(), planMarks);
		/* 取消预警 */
		// fittingService.cancelStockAlert(fittingId);
		return "";
	}

	@RequestMapping(value = "export")
	public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			Map<String, Object> params = new TrimMap(getParams(request));
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);

			Page<Record> page = null;

			if ("公司库存明细".equals(title)) {
				/*
				 * Page<Fitting> page1 = new Page<>(request, response); page.setPageNo(1);
				 * page.setPageSize(1000);
				 */
				Page<Record> page1 = new Page<>(request, response);
				page1.setPageNo(1);
				page1.setPageSize(10000);
				Page<Record> pages = fittingService.findStockPage(page1, params, siteId);
				List<Record> list = pages.getList();
				for (Record fit : list) {
					if ("1".equals(fit.getStr("type"))) {
						fit.set("type", "配件");
					} else if ("2".equals(fit.getStr("type"))) {
						fit.set("type", "耗材");
					} else {
						fit.set("type", "其他");
					}
					if (fit.getBigDecimal("sitePrice") != null) {
						BigDecimal bd = fit.getBigDecimal("sitePrice");
						bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
						fit.set("sitePrice", bd.doubleValue());
					} else {
						fit.set("sitePrice", 0.00);
					}
					if (fit.getBigDecimal("employePrice") != null) {
						BigDecimal bd = fit.getBigDecimal("employePrice");
						bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
						fit.set("employePrice", bd.doubleValue());
					} else {
						fit.set("employePrice", 0.00);
					}

					if (fit.getBigDecimal("customerPrice") != null) {
						BigDecimal bd = fit.getBigDecimal("customerPrice");
						bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
						fit.set("customerPrice", bd.doubleValue());
					} else {
						fit.set("customerPrice", 0.00);
					}

				}
				new ExportJqExcel(title, jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
				return null;
			} else {
				page = brandService.findBrand(null);
			}

			new ExportJqExcel("用户数据", stf.getTableHeader(), stf.getSortHeader()).setDataList(page.getList()).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@RequestMapping(value = "export2")
	public String exportFile2(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {

			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());

			String title = "工程师库存";
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

			Map<String, Object> params = new TrimMap(getParams(request));
			params.put("siteId", siteId);
			Page<Record> page = new Page<>(request, response);
			page.setPageNo(1);
			page.setPageSize(10000);
			List<Record> rds = fittingService.getEmpKeepPage(page, params).getList();
			List<EmpFittingExport> list = new ArrayList<EmpFittingExport>();
			for (Record rd : rds) {
				EmpFittingExport efe = new EmpFittingExport();
				efe.setEmpName(rd.getStr("empName"));
				efe.setCode(rd.getStr("code"));
				efe.setName(rd.getStr("name"));
				efe.setVersion(rd.getStr("version"));
				if (rd.getBigDecimal("warning") != null) {
					efe.setWarning(rd.getBigDecimal("warning").toString());
				} else {
					efe.setWarning("0");
				}
				if (rd.getBigDecimal("employe_number") != null) {
					efe.setEmployeNumber(rd.getBigDecimal("employe_number").toString());
				} else {
					efe.setEmployeNumber("0");
				}
				if (rd.getBigDecimal("sitePrice") != null) {
					efe.setSitePrice(rd.getBigDecimal("sitePrice"));
				} else {
					efe.setSitePrice(new BigDecimal("0"));
				}
				if (rd.getBigDecimal("customer_price") != null) {
					efe.setCustomerPrice(rd.getBigDecimal("customer_price"));
				} else {
					efe.setCustomerPrice(new BigDecimal("0"));
				}
				efe.setUnit(rd.getStr("unit"));
				if ("1".equals(rd.getStr("type"))) {
					efe.setType("配件");
				} else {
					efe.setType("耗材");
				}
				efe.setBrand(rd.getStr("suit_brand"));
				efe.setCategory(rd.getStr("suit_category"));
				list.add(efe);
			}

			ExportExcel ee = new ExportExcel(title, EmpFittingExport.class).setDataList(list);
			new ExcelUtilsEx().write(request, response, fileName, ee).dispose();

			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@RequestMapping(value = "ajaxFittingById")
	@ResponseBody
	public Fitting ajaxFittingById(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		Fitting fitting = fittingService.getById(request.getParameter("id"));
		return fitting;
	}

	// 备件公司库存 上一条下一条
	@RequestMapping(value = "nextOrLastfittingDetailMsg")
	@ResponseBody
	public Result<Record> nextOrLastfittingDetailMsg(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		String mark = request.getParameter("mark");
		Map<String, Object> map = getParams(request);
		return fittingService.getnextOrLastfittingDetailMsg(id, mark, map);
	}

	/**
	 * 配件可删除删除逻辑：1：配件没有工程师库存，2：配件没有关联的未完成申请记录
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "pLSC")
	@ResponseBody
	public int pLSC(HttpServletRequest request, HttpServletResponse response, Model model) {
		int num = 0;
		String ids1 = "";
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String idArr = request.getParameter("idArr");
		String ids[] = idArr.split(",");
		try {
			outer: for (int i = 0; i < ids.length; i++) {
				if (ids1.equals("")) {
					ids1 = "'" + ids[i] + "'";
				} else {
					ids1 = ids1 + ",'" + ids[i] + "'";
				}
				List<Record> list = fittingService.getEmployeFitting(ids[i], siteId);
				List<Record> list1 = fittingService.getUnfinishedFittingApply(ids[i], siteId);
				if (list.size() > 0) {
					for (Record rd : list) {
						if (rd.getBigDecimal("warning") != null && rd.getBigDecimal("warning").doubleValue() > 0) {
							num = 2;
							break outer;
						}
					}
				}
				if (list1.size() > 0) {
					num = 2;
					break;
				}
			}
			if (num == 2) {
				return num;
			} else {
				fittingService.pLSC(ids1, ids);
				num = 1;
				return num;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}

	// 待返还（入库操作）
	@RequestMapping(value = "doDFH")
	@ResponseBody
	public Integer doDFH(HttpServletRequest request, HttpServletResponse response, Model model) {
		int result = 0;

		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String id = request.getParameter("id");// 备件使用记录的id
		String empName = request.getParameter("empName");// 申请人
		if (!StringUtils.isBlank(id)) {
			FittingUsedRecord fur = fittingUsedRecordService.getById(id);
			double d = fur.getUsedNum().doubleValue();// 返还数量
			SiteFittingKeep siteFittingKeep = new SiteFittingKeep();
			Fitting fitting = fittingService.getId(fur.getFittingId());
			siteFittingKeep.setFittingId(fur.getFittingId());
			siteFittingKeep.setNumber(CrmUtils.no());// 用时间生成备件编号
			if (StringUtils.isNotEmpty(fitting.getCode())) {
				siteFittingKeep.setFittingCode(fitting.getCode());// 备件条码
			}
			if (StringUtils.isNotEmpty(fitting.getName())) {
				siteFittingKeep.setFittingName(fitting.getName());// 备件名称
			}
			siteFittingKeep.setAmount(d);// 数量
			if (fitting.getSitePrice() != null) {
				siteFittingKeep.setPrice(fitting.getSitePrice());// 入库价格
			}
			if (fitting.getEmployePrice() != null) {
				siteFittingKeep.setEmployePrice(fitting.getEmployePrice());// 工程师价格
			}
			if (fitting.getCustomerPrice() != null) {
				siteFittingKeep.setCustomerPrice(fitting.getCustomerPrice());// 零售价格
			}
			siteFittingKeep.setType("2");
			siteFittingKeep.setApplicant(empName); // 申请人/领用人
			siteFittingKeep.setConfirmor(CrmUtils.getUserXM()); // 确认人
			siteFittingKeep.setCreateBy(user.getId());// 创建人user_id
			siteFittingKeep.setSiteId(siteId); // 服务商id

			/*
			 * 备件使用记录（use_record）
			 */
			String employeId = fur.getEmployeId();
			fittingUsedRecordService.doDFH(fur.getFittingId(), d, id, siteFittingKeep, employeId);
			result = 1;

			/* 取消预警 */
			fittingService.cancelStockAlert(fur.getFittingId());
		}
		return result;
	}

	// 批量入库操作）
	@RequestMapping(value = "batchdoDFH")
	@ResponseBody
	public Integer batchdoDFH(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String ids = request.getParameter("ids");// 备件使用记录的id
		if (!StringUtils.isBlank(ids)) {
			for (String id : ids.split(",")) {
				FittingUsedRecord fur = fittingUsedRecordService.getId(id);
				double d = fur.getUsedNum().doubleValue();// 返还数量
				SiteFittingKeep siteFittingKeep = new SiteFittingKeep();
				Fitting fitting = fittingService.getId(fur.getFittingId());
				siteFittingKeep.setFittingId(fur.getFittingId());
				siteFittingKeep.setNumber(CrmUtils.no());// 用时间生成备件编号
				if (StringUtils.isNotEmpty(fitting.getCode())) {
					siteFittingKeep.setFittingCode(fitting.getCode());// 备件条码
				}
				if (StringUtils.isNotEmpty(fitting.getName())) {
					siteFittingKeep.setFittingName(fitting.getName());// 备件名称
				}
				siteFittingKeep.setAmount(d);// 数量
				if (fitting.getSitePrice() != null) {
					siteFittingKeep.setPrice(fitting.getSitePrice());// 入库价格
				}
				if (fitting.getEmployePrice() != null) {
					siteFittingKeep.setEmployePrice(fitting.getEmployePrice());// 工程师价格
				}
				if (fitting.getCustomerPrice() != null) {
					siteFittingKeep.setCustomerPrice(fitting.getCustomerPrice());// 零售价格
				}
				siteFittingKeep.setType("2");
				siteFittingKeep.setApplicant(fur.getCreator()); // 申请人/领用人
				siteFittingKeep.setConfirmor(CrmUtils.getUserXM()); // 确认人
				siteFittingKeep.setCreateBy(user.getId());// 创建人user_id
				siteFittingKeep.setSiteId(siteId); // 服务商id
				/*
				 * 备件使用记录（use_record）
				 */
				String employeId = fur.getEmployeId();
				fittingUsedRecordService.doDFH(fur.getFittingId(), d, id, siteFittingKeep, employeId);
				result = 1;

				/* 取消预警 */
				fittingService.cancelStockAlert(fur.getFittingId());
			}
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "getWaitReturnCount1")
	public List<Map<String, Object>> getWaitReturnCount1() {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		ArrayList list = new ArrayList<>();
		Map<String, Object> map = new HashMap();
		map.put("count", fittingService.getWaitReturnCount1(siteId));
		list.add(map);
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "fittingFrom")
	/**
	 * @return 1 if the fitting from factory else fitting is site itself.
	 */
	public String isFittingFromMicroFactory(HttpServletRequest request) {
		return fittingService.isFittingFromMicroFactory(request.getParameter("fittingId")) ? "1" : "0";
	}

	@RequestMapping(value = "toNewReturnFactoryPage")
	public String toNewReturnFactoryPage(HttpServletRequest request, HttpServletResponse response, Model model) {
		String ids = request.getParameter("ids");
		model.addAttribute("curTime", DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
		model.addAttribute("lgn", LogisticsUtils.getlogisticsGet());
		model.addAttribute("ids", ids);
		model.addAttribute("uname", CrmUtils.getUserXM());
		model.addAttribute("number", CrmUtils.applyNo("OF"));
		return "modules/fitting/stock/newReturnFactory";
	}

	@ResponseBody
	@RequestMapping(value = "getDefaultReturnList")
	public List<Record> getDefaultReturnList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String ids = request.getParameter("ids");
		return fittingService.getDefaultReturnList(ids);
	}

	@ResponseBody
	@RequestMapping(value = "saveNewFittingReturnFactory")
	public Result saveNewFittingReturnFactory(HttpServletRequest request) {
		Map<String, Object> map = getParams(request);
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String uname = CrmUtils.getUserXM();
		map.put("userId", user.getId());
		map.put("siteId", siteId);
		map.put("siteName", siteService.get(siteId).getName());
		map.put("uname", uname);
		// Result<?> rt = fittingService.saveNewFittingReturnFactory(map);
		return ezTemplate.postForm("/saveNewFittingReturnFactory", map, new ParameterizedTypeReference<Result<String>>() {
		});
	}

	@ResponseBody
	@RequestMapping(value = "checkIfShowReturnPage")
	public String checkIfShowReturnPage(HttpServletRequest request) {
		Map<String, Object> map = getParams(request);
		Result<String> listResult = ezTemplate.postForm("/checkIfShowReturnPage", map, new ParameterizedTypeReference<Result<String>>() {
		});
		return listResult.getCode();
	}

	// 调拨页面
	@RequestMapping(value = "toAdjustFittingPage")
	public String toAdjustFittingPage(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> emps = employeService.findBySiteId(siteId);
		String ids = request.getParameter("ids");
		String employeId = request.getParameter("employeId");
		List<Record> emps1 = employeService.findBySiteIdExpectId(employeId, siteId);
		String[] idArr = null;
		int length = 0;
		String datas = "1";
		List<Record> fittings = null;
		if (StringUtils.isNotBlank(ids)) {
			idArr = ids.split(",");
			// length = idArr.length;
			fittings = employeFittingService.tiaoBoGetData(ids, siteId);
			length = fittings.size();
			if (length < idArr.length) {
				datas = "2";
			}
		}
		model.addAttribute("fittings", fittings);
		model.addAttribute("emps", emps);
		model.addAttribute("datas", datas);
		model.addAttribute("emps1", emps1);
		model.addAttribute("employeId", employeId);
		model.addAttribute("fittingSize", length);
		return "modules/fitting/stock/adjustFitting";
	}

	@ResponseBody
	@RequestMapping(value = "getEmpListByEmpId")
	public List<Record> getEmpListByEmpId(HttpServletRequest request) {
		String empId = request.getParameter("empId");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return employeService.findBySiteIdExpectId(empId, siteId);
	}

	// 调拨
	@RequestMapping(value = "doDBSave")
	@ResponseBody
	public String doDBSave(HttpServletRequest request, HttpServletResponse response, Model model) {
		String idO = request.getParameter("employeId");// 调拨人id
		String empIds = request.getParameter("empIds");// 调拨工程
		String nums = request.getParameter("nums");// 调拨数量
		String fittingIds = request.getParameter("fittingIds");
		User user = UserUtils.getUser();

		for (int i = 0; i < empIds.split(",").length; i++) {
			String idT = empIds.split(",")[i];// 受调拨人id
			String amount = nums.split(",")[i];// 调拨数量
			String fittingId = fittingIds.split(",")[i];
			;
			Fitting f = fittingService.get(fittingId);
			Employe e = employeService.get(idO);// 调拨工程师信息
			Employe e2 = employeService.get(idT);// 受调拨工程师信息
			// 工程师信息的操作
			EmployeFitting ef = new EmployeFitting();
			ef.setFittingId(fittingId);
			if (f.getType() != null) {
				ef.setType(f.getType());
			}
			if (f.getSuitCategory() != null) {
				ef.setSuitCategory(f.getSuitCategory());
			}
			ef.setEmployeId(idT);
			if (f.getBrand() != null) {
				ef.setSuitBrand(f.getBrand());
			}
			ef.setStatus("1");
			ef.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
			ef.setCreateTime(new Date());
			ef.setCreateBy(user.getId());
			BigDecimal bd = new BigDecimal(amount);
			ef.setWarning(bd);
			ef.setTotal(bd);
			String nm = "0";
			BigDecimal number = new BigDecimal(nm);
			ef.setNumber(number);
			ef.setCjnum(number);

			Date now = new Date();
			// 工程师备件出入库明细表操作(调拨人)
			EmpFittingKeep efk = new EmpFittingKeep();
			efk.setNumber(CrmUtils.no());// 编号，生成规则：yyyyMMddHHmmssSSS
			efk.setType("4");// 类型：0领取，1工单使用 2零售，3返还 4调拨
			efk.setFittingId(fittingId);// 备件id
			if (f.getCode() != null) {
				efk.setFittingCode(f.getCode());// 备件条码
			}
			if (f.getName() != null) {
				efk.setFittingName(f.getName());// 备件名称
			}
			// 关联工单id
			efk.setAmount(Double.parseDouble("-" + amount));// 数量
			if (f.getSitePrice() != null) {
				efk.setPrice(f.getSitePrice());// 入库价格
			}
			if (f.getEmployePrice() != null) {
				efk.setEmployePrice(f.getEmployePrice());// 工程师价格
			}
			if (f.getCustomerPrice() != null) {
				efk.setCustomerPrice(f.getCustomerPrice());// 零售价格
			}
			efk.setCreateTime(now);// 创建时间
			if (e.getName() != null) {
				efk.setEmployeName(e.getName());// 工程师姓名
			}
			efk.setEmployeId(idO);// 工程师id
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			efk.setSiteId(siteId);// 服务商id
			efk.setCreateBy(user.getId());// 创建人user_id

			// 工程师备件出入库明细表操作(受调拨人)
			EmpFittingKeep efks = new EmpFittingKeep();
			efks.setNumber(CrmUtils.no());// 编号，生成规则：yyyyMMddHHmmssSSS
			efks.setType("4");// 类型：0领取，1工单使用 2零售，3返还 4调拨
			efks.setFittingId(fittingId);// 备件id
			if (f.getCode() != null) {
				efks.setFittingCode(f.getCode());// 备件条码
			}
			if (f.getName() != null) {
				efks.setFittingName(f.getName());// 备件名称
			}
			// 关联工单id
			efks.setAmount(Double.parseDouble(amount));// 数量
			if (f.getSitePrice() != null) {
				efks.setPrice(f.getSitePrice());// 入库价格
			}
			if (f.getEmployePrice() != null) {
				efks.setEmployePrice(f.getEmployePrice());// 工程师价格
			}
			if (f.getCustomerPrice() != null) {
				efks.setCustomerPrice(f.getCustomerPrice());// 零售价格
			}
			efks.setCreateTime(now);// 创建时间
			efks.setEmployeName(e2.getName());// 工程师姓名
			efks.setEmployeId(idT);// 工程师id
			efks.setSiteId(siteId);// 服务商id
			efks.setCreateBy(user.getId());// 创建人user_id
			empFittingKeepService.doDB(idO, Double.parseDouble(amount), idT, fittingId, ef, efk, efks);
		}
		return "ok";
	}

	// 返还页面
	@RequestMapping(value = "toReturnFittingPage")
	public String toReturnFittingPage(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> emps = employeService.findBySiteId(siteId);
		String ids = request.getParameter("ids");
		String employeId = request.getParameter("employeId");
		List<Record> emps1 = employeService.findBySiteIdExpectId(employeId, siteId);
		String[] idArr = null;
		int length = 0;
		String datas = "1";
		List<Record> fittings = null;
		if (StringUtils.isNotBlank(ids)) {
			idArr = ids.split(",");
			// length = idArr.length;
			fittings = employeFittingService.tiaoBoGetData(ids, siteId);
			length = fittings.size();
			if (length < idArr.length) {
				datas = "2";
			}
		}
		model.addAttribute("fittings", fittings);
		model.addAttribute("emps", emps);
		model.addAttribute("datas", datas);
		model.addAttribute("emps1", emps1);
		model.addAttribute("employeId", employeId);
		model.addAttribute("fittingSize", length);
		return "modules/fitting/stock/returnFitting";
	}

	/**
	 * 工程师备件返还并入库-批量返还
	 */
	@ResponseBody
	@RequestMapping(value = "doDBSaveAndReturnSave")
	public Object doDBSaveAndReturnSave(HttpServletRequest request) {
		String idO = request.getParameter("employeId");// 调拨人id
		String nums = request.getParameter("nums");// 调拨数量
		String fittingIds = request.getParameter("fittingIds");
		String empFittingIds = request.getParameter("empFittingIds");

		String mark = "1";
		int m = 1;
		for (int j = 0; j < nums.split(",").length; j++) {
			m = m + j;
			double num1 = Double.valueOf(nums.split(",")[j]);
			EmployeFitting fit = employeFittingService.get(empFittingIds.split(",")[j]);
			if (num1 <= 0 || (fit != null && num1 > Double.valueOf(String.valueOf(fit.getWarning())))) {
				mark = "2";
				break;
			}
		}
		Result<Void> rt = new Result<>();
		if ("2".equals(mark)) {

			rt.setMsg("第" + m + "个备件的工程师库存不足！");
			rt.setCode("422");
			return rt;
		}

		for (int i = 0; i < empFittingIds.split(",").length; i++) {
			String empFittingId = empFittingIds.split(",")[i]; // 参数empId实际意义是empFittingId
			String fittingId = fittingIds.split(",")[i];
			double num = Double.valueOf(nums.split(",")[i]);
			fittingService.empFittingRecycleNew(empFittingId, fittingId, num);
			fittingService.cancelStockAlert(fittingId);
		}
		rt.setCode("200");
		return rt;
	}

	/**
	 * 工程师配件返还保存操作-批量
	 */
	@ResponseBody
	@RequestMapping(value = "employTurnBackSave")
	public Object employTurnBackSave(HttpServletRequest request) {
		String idO = request.getParameter("employeId");// 调拨人id
		String nums = request.getParameter("nums");// 调拨数量
		String fittingIds = request.getParameter("fittingIds");
		String empFittingIds = request.getParameter("empFittingIds");

		String mark = "1";
		int m = 1;
		for (int j = 0; j < nums.split(",").length; j++) {
			m = m + j;
			double num1 = Double.valueOf(nums.split(",")[j]);
			EmployeFitting fit = employeFittingService.get(empFittingIds.split(",")[j]);
			if (num1 <= 0 || (fit != null && num1 > Double.valueOf(String.valueOf(fit.getWarning())))) {
				mark = "2";
				break;
			}
		}
		Result<Void> rt = new Result<>();
		if ("2".equals(mark)) {

			rt.setMsg("第" + m + "个备件的工程师库存不足！");
			rt.setCode("422");
			return rt;
		}

		for (int i = 0; i < empFittingIds.split(",").length; i++) {
			String empFittingId = empFittingIds.split(",")[i]; // 参数empId实际意义是empFittingId
			String fittingId = fittingIds.split(",")[i];
			double num = Double.valueOf(nums.split(",")[i]);
			logger.info(String.format("[备件返还需审核]，empFittingId=%s,fittingId=%s,recycleNum=%s", empFittingId, fittingId, num));
			fittingService.turnBackNew(empFittingId, fittingId, num);
		}

		rt.setCode("200");
		return rt;
	}

	// 零售页面
	@RequestMapping(value = "toSalesFittingPage")
	public String toSalesFittingPage(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		List<Record> emps = employeService.findBySiteId(siteId);
		String ids = request.getParameter("ids");
		String employeId = request.getParameter("employeId");
		List<Record> emps1 = employeService.findBySiteIdExpectId(employeId, siteId);
		String[] idArr = null;
		int length = 0;
		String datas = "1";
		List<Record> fittings = null;
		if (StringUtils.isNotBlank(ids)) {
			idArr = ids.split(",");
			// length = idArr.length;
			fittings = employeFittingService.tiaoBoGetData(ids, siteId);
			length = fittings.size();
			if (length < idArr.length) {
				datas = "2";
			}
		}
		model.addAttribute("fittings", fittings);
		model.addAttribute("emps", emps);
		model.addAttribute("datas", datas);
		model.addAttribute("emps1", emps1);
		model.addAttribute("employeId", employeId);
		model.addAttribute("fittingSize", length);
		return "modules/fitting/stock/salesFitting";
	}

	// 工程师库存零售-批量
	@RequestMapping(value = "doEmpRetailSave")
	@ResponseBody
	public Object doEmpRetailSave(HttpServletRequest request, HttpServletResponse response, Model model) {
		Result<Void> rt = new Result<>();
		int num = 0;
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		/*
		 * Map<String, Object> params = new TrimMap(getParams(request));
		 * 
		 * String idO = request.getParameter("employeId");// 调拨人id
		 */ String nums = request.getParameter("nums");// 调拨数量
		String fittingIds = request.getParameter("fittingIds");
		String empFittingIds = request.getParameter("empFittingIds");
		String finalPrices = request.getParameter("finalPrices");
		String custName = request.getParameter("custName");
		String custMobile = request.getParameter("custMobile");
		String custAddress = request.getParameter("custAddress");

		String mark = "1";
		int m = 1;
		for (int j = 0; j < nums.split(",").length; j++) {
			m = m + j;
			double num1 = Double.valueOf(nums.split(",")[j]);
			EmployeFitting fit = employeFittingService.get(empFittingIds.split(",")[j]);
			if (num1 <= 0 || (fit != null && num1 > Double.valueOf(String.valueOf(fit.getWarning())))) {
				mark = "2";
				break;
			}
		}
		if ("2".equals(mark)) {
			rt.setMsg("第" + m + "个备件的工程师库存不足！");
			rt.setCode("422");
			return rt;
		}
		for (int i = 0; i < empFittingIds.split(",").length; i++) {
			String empFittingId = empFittingIds.split(",")[i];// 工程师库存id
			String amount = nums.split(",")[i];// 零售数量
			String fittingId = fittingIds.split(",")[i];//
			String saleMoneys = finalPrices.split(",")[i];//
			EmployeFitting fit = employeFittingService.get(empFittingId);
			Fitting ft = fittingDao.get(fittingId);// 获取备件信息
			if (Double.parseDouble(amount) <= fit.getWarning().doubleValue()) {// 如果零售数量小于库存数量
				/*
				 * 新增备件出入库明细表信息
				 */
				EmpFittingKeep fittingKeep = new EmpFittingKeep();
				String sql = "select * from crm_employe where id=?";
				Record rec = Db.findFirst(sql, fit.getEmployeId());
				if (rec != null) {
					if (StringUtils.isNotBlank(rec.getStr("name"))) {
						fittingKeep.setEmployeId(fit.getEmployeId());
						fittingKeep.setEmployeName(rec.getStr("name"));
					}
				}

				fittingKeep.setFittingId(fit.getFittingId());// 备件id
				fittingKeep.setNumber(CrmUtils.no());// 用时间生成备件编号
				fittingKeep.setFittingCode(ft.getCode());// 备件条码
				fittingKeep.setFittingName(ft.getName());// 备件名称
				fittingKeep.setAmount(Double.parseDouble(amount));// 数量
				fittingKeep.setPrice(ft.getSitePrice() != null ? ft.getSitePrice() : 0);// 入库价格
				fittingKeep.setCustomerAddress(custAddress);
				fittingKeep.setCustomerMobile(custMobile);
				fittingKeep.setCustomerName(custName);
				fittingKeep.setEmployePrice(ft.getEmployePrice() != null ? ft.getEmployePrice() : 0);// 工程师价格
				fittingKeep.setCustomerPrice(ft.getCustomerPrice() != null ? ft.getCustomerPrice() : 0);// 零售价格
				fittingKeep.setCreateBy(user.getId());// 创建人user_id
				fittingKeep.setSiteId(siteId); // 服务商id
				fittingKeep.setType("2");// 类型

				// 服务商备件使用记录表
				String sqlFitting = "select * from crm_site_fitting where id='" + fit.getFittingId() + "'";
				Record re = Db.findFirst(sqlFitting);

				FittingUsedRecord fur = new FittingUsedRecord();
				fur.setFittingId(fit.getFittingId());// 备件id
				fur.setSiteId(siteId);// 服务商id
				fur.setType("3");// 工程师零售
				BigDecimal bdecimal = new BigDecimal((amount));
				fur.setUsedNum(bdecimal);// 零售数量

				if (StringUtils.isNotBlank(re.getStr("code"))) {
					fur.setFittingCode(re.getStr("code"));
				}
				if (StringUtils.isNotBlank(re.getStr("version"))) {
					fur.setFittingVersion(re.getStr("version"));
				}
				if (StringUtils.isNotBlank(re.getStr("name"))) {
					fur.setFittingName(re.getStr("name"));
				}
				if (StringUtils.isNotBlank(re.getStr("brand"))) {
					fur.setBrand(re.getStr("brand"));
				}
				if (StringUtils.isNotBlank(fit.getSuitCategory())) {
					fur.setCategory(fit.getSuitCategory());
				}

				fur.setEmployeId(fit.getEmployeId());
				fur.setStatus("1");// 申请状态
				fur.setUsedTime(new Date());// 创建时间
				fur.setCreateBy(user.getId());// 使用人user_id
				fur.setCustomerAddress(custAddress);
				fur.setCustomerMobile(custMobile);
				fur.setCustomerName(custName);
				fur.setUserName(rec.getStr("name"));// 使用人姓名
				fur.setOldFittingFlag("0");// 旧件返还标记
				fur.setCollectionFlag("1");// 收款标记
				fur.setCreator(CrmUtils.getUserXM());

				BigDecimal n = new BigDecimal(saleMoneys);
				fur.setCollectionMoney(n);// 收款金额

				num = fittingUsedRecordService.doEmpRetailSaveNew(fur, amount, empFittingId, fittingKeep);
			}
		}
		rt.setCode("200");
		return rt;
	}

	@ResponseBody
	@RequestMapping(value = "exportEmpKeep")
	public String exportEmpKeep(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "工程师库存" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			String title = "工程师库存";
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);

			Map<String, Object> map = getParams(request);
			Page<Record> pages = new Page<Record>(request, response);
			map.put("siteId", siteId);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			Page<Record> page = fittingService.findEmpFittingPage(pages, map);
			List<Record> list = page.getList();
			List<EmployeFittingCountExport> list1 = new ArrayList<>();
			Record rds = fittingService.getEmpFittingListSum(pages, map);
			if (list.size() > 0) {
				for (Record rd : list) {
					EmployeFittingCountExport ec = new EmployeFittingCountExport();
					ec.setEmployeName(rd.getStr("name"));
					ec.setCateAmount(rd.get("ct"));
					ec.setStocks(rd.get("su"));
					ec.setInstoksMoney(rd.get("sallSitePrice"));
					ec.setEmpStocksMoney(rd.get("semployeSitePrice"));
					ec.setWaitHxNumber(rd.get("employe_number"));
					ec.setWaitHxMoney(rd.get("hallSitePrice"));
					ec.setWaitHxEmpMoney(rd.get("hemployeSitePrice"));
					ec.setWaitReturnNumber(rd.get("usedNum"));
					list1.add(ec);
				}
			}
			EmployeFittingCountExport ec1 = new EmployeFittingCountExport();
			ec1.setEmployeName("合计");
			ec1.setCateAmount(rds.get("h1"));
			ec1.setStocks(rds.get("h2"));
			ec1.setInstoksMoney(rds.get("h4"));
			ec1.setEmpStocksMoney(rds.get("h5"));
			ec1.setWaitHxNumber(rds.get("h3"));
			ec1.setWaitHxMoney(rds.get("h6"));
			ec1.setWaitHxEmpMoney(rds.get("h7"));
			ec1.setWaitReturnNumber(rds.get("h8"));
			list1.add(ec1);
			ExportExcel ee = new ExportExcel(title, EmployeFittingCountExport.class).setDataList(list1);
			new ExcelUtilsEx().write(request, response, fileName, ee).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}
}