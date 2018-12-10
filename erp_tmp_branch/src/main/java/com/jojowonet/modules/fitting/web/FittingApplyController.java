package com.jojowonet.modules.fitting.web;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.jojowonet.modules.order.utils.*;
import com.jojowonet.modules.sys.db.DbKey;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.FittingApplyPlanDao;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingApply;
import com.jojowonet.modules.fitting.entity.FittingApplyPlan;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.fitting.service.FittingApplyService;
import com.jojowonet.modules.fitting.service.FittingService;
import com.jojowonet.modules.goods.service.GoodsSiteSelfService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.OrderFittingService;
import com.jojowonet.modules.order.service.PushMessageService;
import com.jojowonet.modules.sys.util.TranslationService;
import com.jojowonet.modules.sys.util.TrimMap;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

/**
 * 备件申请Controller
 *
 * @author Ivan
 * @version 2017-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/fitting/fittingApply")
public class FittingApplyController extends BaseController {

	private static final Log logger = LogFactory.getLog(FittingApplyController.class);

	@Autowired
	private FittingApplyService fittingApplyService;
	@Autowired
	private OrderFittingService orderFittingService;

	@Autowired
	private FittingService fiService;

	@Autowired
	private EmployeService employeService;

	@Autowired
	private PushMessageService pushmessageService;

	@Autowired
	private SiteMsgService siteMsgService;
	@Autowired
	TranslationService translationService;
	@Autowired
	private FittingApplyPlanDao fittingApplyPlanDao;
	@Autowired
	private GoodsSiteSelfService goodsSiteSelfService;
	@Autowired
	private TableSplitMapper tableSplitMapper;

	// 备件申请管理表头
	@RequestMapping(value = "getApplyList")
	public String getApplyList(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		Map<String, String> brandList = BrandUtils.getSiteBrand(siteId, null);
		List<Record> applianceCategory = CategoryUtils.getListCategorySite(siteId);
		model.addAttribute("listR", listR);
		model.addAttribute("applianceCategory", applianceCategory);
		model.addAttribute("brandList", brandList);
		model.addAttribute("headerData", stf);
		return "modules/" + "fitting/fittingApplyList";
	}

	// 备件申请管理待审核数据
	@ResponseBody
	@RequestMapping(value = "getlist")
	public String getlist(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> page = fittingApplyService.getfindList(new Page<Record>(request, response), siteId, 0, ma);// 0表示待审核的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	@RequestMapping(value = "fittingManage")
	public String fittingManage(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
       /* List<Record> re=SiteListUtils.getSiteList();
        model.addAttribute("siteList", re);*/
		List<Record> provincelist=siteMsgService.getprovincelist();
		model.addAttribute("listarea", provincelist);
		model.addAttribute("headerData", stf);
		return "modules/" + "operate/fittingAnalyse";
	}

    //备件在途
	@RequestMapping(value = "fittingInRoad")
	public String fittingInRoad(HttpServletRequest request,Model model){
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		String applyId = request.getParameter("applyId");
		model.addAttribute("headerData", stf);
		model.addAttribute("applyId",applyId);
		return "modules/" + "fitting/fittingApplyInRoad";
	}

	//备件在途数据
	@ResponseBody
	@RequestMapping(value = "getFittingInRoadList")
	public String getFittingInRoadList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> page = fittingApplyService.fittingInRoadList(new Page<Record>(request, response), map, siteId);
		return renderJson(new JqGridPage<>(page));
	}

	//备件在途-确认入库页面
	@RequestMapping(value = "getFittingApplyPlanById")
	public String getFittingApplyPlanById(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		FittingApplyPlan re = fittingApplyPlanDao.get(id);
		FittingApply fa = fittingApplyService.getFittingApplyId(re.getFittingApplyId());
		model.addAttribute("applyPlan", re);
		model.addAttribute("fa", fa);
		return "modules/" + "fitting/putFittingInStock";
	}
	/*
	 * 删除备件申请信息
	 */
	@ResponseBody
	@RequestMapping(value = "checkFittingApplyplan")
	public Result<Void> checkFittingApplyplan( HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(StringUtil.isBlank(id)) {
			return Result.fail("402", "FittingSId id null");
		}
		boolean check = fittingApplyService.checkPlan(id);
		if(check) {
			//已经做过备件计划
		return Result.ok();
		}
		return Result.fail("400", "FittingSId id null");
	}

		/*
	 * 删除备件申请信息
	 */
	@ResponseBody
	@RequestMapping(value = "deleteFittingApply")
	public Result<Void> deleteFittingApply( HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			FittingApply fa = fittingApplyService.getFittingApplyId(id);
			Fitting fi = fiService.get(fa.getFittingId());
			String orderNumber = fa.getOrderNumber();
			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			String status = fa.getStatus();
			String name = CrmUtils.getUserXM();
			if(Integer.parseInt(status) > 3){
				//删除失败，数据信息错误
				return Result.fail("400", "FittingStatus already adopted");
			}
			fa.setUpdateName(name);
			fa.setUpdateTime(new Date());
			fa.setEndTime(new Date());
			fa.setAuditMarks("反馈封单删除申请");
			fa.setStatus("7");
			if("2".equals(status)){
				//审核通过待出库（需要更改Fitting表的审核通过待出库数量）
				fittingApplyService.RejectFittingApply(fa,fi);
			}else{
				fittingApplyService.deleteFittingApply(fa);
			}

			//更改工单中备件标记；fitting_flag
			fittingApplyService.updateFittingFlag(orderNumber, siteId);

			//取消预警
			StringBuilder sb = new StringBuilder();
			sb.append(" update crm_site_alarm set is_cancel = '1' ");
			sb.append(" where site_id = '" + siteId + "' and target_id = '" + id + "' and type = '4'  ");
			Db.update(sb.toString());
			return Result.ok();
		}
		return Result.fail("400", "FittingSId id null");
	}

	@ResponseBody
	@RequestMapping(value = "rellyExit")
    public String rellyExit(HttpServletRequest request){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String code = request.getParameter("fittingCode");
		String id = request.getParameter("fittingId");
		Record re = Db.findFirst("select * from crm_site_fitting where (code=? or id=?) and status=1 and site_id=?", code,id,siteId);
		if (re != null) {
			return "ok";
		}else{
			return "no";
		}
	}

	@RequestMapping(value="addFittingApply")
	public String addFittingApply(HttpServletRequest request, HttpServletResponse response, Model model){
		String id=request.getParameter("id");
		String type=request.getParameter("type");
		String emNamId=request.getParameter("emNamId");
		String number=request.getParameter("number");
       /* if(StringUtils.isBlank(emNamId)){
            throw Exception
            return "";
        }*/
		try {
			if (emNamId.indexOf(",") != -1) {
				emNamId = emNamId.split(",")[0];
			}
		} catch (Exception ex) {
			if (emNamId == null) {
				logger.error(String.format("<><>add fitting apply:id=%s,type=%s,number=%s", id, type, number));
			}
			throw ex;
		}
		Employe employe= employeService.get(emNamId);
		//   Fitting fit= fittingservice.get(id);
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		if(StringUtils.isNotBlank(number)){
			Record reOrder = orderFittingService.getOrderOr400(number,siteId);
			model.addAttribute("reOrder",reOrder);
		}
		//List<Record> fittings = fittingservice.getFittings(siteId);
		// model.addAttribute("fittings", fittings);
		model.addAttribute("siteId", siteId);
		model.addAttribute("type", type);
		//   model.addAttribute("fit",fit);
		model.addAttribute("employe",employe);
		return "modules/" + "fitting/addApply";
	}

	@ResponseBody
	@RequestMapping(value = "getFittingManageList")
	public String getFittingManageList(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		// String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> page = fittingApplyService.getfitList(new Page<Record>(request, response), ma);// 0表示待审核的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	@RequestMapping(value = "export2")
	public String exportFile2(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Map<String, Object> ma = new TrimMap(getParams(request));
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			// jarray.remove(0);
			List<Record> list = null;
			if ("备件分析".equals(title)) {
				list = fittingApplyService.getfitList(pages, ma).getList();

			} else {

			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 备件申请管理待出库表头
	@RequestMapping(value = "ThelibraryHeader")
	public String ThelibraryHeader(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		List<Record> applianceCategory = CategoryUtils.getListCategorySite(siteId);
		Map<String, String> brandList = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brandList", brandList);
		model.addAttribute("applianceCategory", applianceCategory);
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		return "modules/" + "fitting/fittingThelibrary";
	}

	// 备件申请管理待出库数据
	@ResponseBody
	@RequestMapping(value = "Thelibrary")
	public String Thelibrarylist(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = fittingApplyService.getfindList(pages, siteId, 1, ma);// 1表示待出库的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	// 全部备件申请表头
	@RequestMapping(value = "ApplyallHeader")
	public String ApplyallHeader(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		List<Record> applianceCategory = CategoryUtils.getListCategorySite(siteId);
		Map<String, String> brandList = BrandUtils.getSiteBrand(siteId, null);
		model.addAttribute("brandList", brandList);
		model.addAttribute("applianceCategory", applianceCategory);
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		List<Record> emps = employeService.findBySiteId(siteId);
		model.addAttribute("emps", emps);
		return "modules/" + "fitting/ApplyallList";
	}

	// 全部申请数据
	@ResponseBody
	@RequestMapping(value = "Applyall")
	public String Applyalllist(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> page = fittingApplyService.getfindList(new Page<Record>(request, response), siteId, 2, ma);// 2表示全部的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	@ResponseBody
	@RequestMapping(value = "getOrderByEmp")
	public List<Record> getOrderByEmp(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String employeId = request.getParameter("employId");
		String employName = request.getParameter("employName");
		String sql = "select * from crm_order where site_id=? and employe_id=? and DATE_SUB(CURDATE(), INTERVAL 1 MONTH) <= date(create_time) ";
		List<Record> reList = null;
		if (StringUtils.isNotBlank(employeId)) {
			reList = Db.find(sql, siteId, employeId);
			if (reList == null) {
				String sql4 = "select * from crm_order_400 where site_id=? and (employe1=? or employe2=? or employe3=?) and  DATE_SUB(CURDATE(), INTERVAL 1 MONTH) <= date(create_time)";
				reList = Db.use(DbKey.DB_ORDER_400).find(sql4, siteId, employName, employName, employName);
			}
		}
		return reList;
	}

	@ResponseBody
	@RequestMapping(value = "getOrderByNumber")
	public Record getOrderByNumber(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String number = request.getParameter("number");
		return orderFittingService.getOrderOr400(number, siteId);
	}

	/**
	 * // 配件申请有可能是直接输入配件名称
	 */
	@RequestMapping(value = "form")
	public String form(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		String fittingImgs = fa.getFittingImg();
		String[] imgs = null;
		if (StringUtils.isNotBlank(fittingImgs)) {
			imgs = fittingImgs.split(",");
			model.addAttribute("fittingApplyImgs", imgs);
		}
		if (imgs != null && imgs.length > 0) {
			model.addAttribute("hasApplyImgs", true);
		}
		if (StringUtils.isNotEmpty(fa.getFittingId())) {
			Fitting fi = fiService.getId(fa.getFittingId());
			String fittingImages = fi.getImg();
			String[] fitImgs = null;
			if (StringUtils.isNotBlank(fittingImages)) {
				fitImgs = fittingImages.split(",");
				model.addAttribute("fitImgs", fitImgs);
			}
			if (fitImgs != null && fitImgs.length > 0) {
				model.addAttribute("hasFitImgs", true);
			}
			model.addAttribute("fitting", fi);
		} else if (StringUtils.isNotBlank(fa.getFittingCode())) {
			Fitting fi = fiService.getByCode(fa.getFittingCode(), siteId);
			model.addAttribute("fitting", fi);
		}
		if (StringUtils.isNotEmpty(fa.getOrderNumber())) {
			Record rd = orderFittingService.getOrderOr400(fa.getOrderNumber(), siteId);
			model.addAttribute("order", rd);
		}
		Record applyPlan = Db.findFirst(" select * from crm_site_fitting_apply_plan where fitting_apply_id=? ", id);
		model.addAttribute("applyPlan", applyPlan);

		model.addAttribute("siteRelos", goodsSiteSelfService.getSiteServiceInfoList(siteId));
		model.addAttribute("fa", fa);
		model.addAttribute("fmtWT", translationService.translationWarrantyType(fa.getWarrantyType()));
		BigDecimal fittingAuditNum = fa.getFittingAuditNum();
		if (fittingAuditNum == null || fittingAuditNum.doubleValue() == 0) { // 审核数量不允许为0
			fittingAuditNum = fa.getFittingApplyNum();
			model.addAttribute("auditNum", fittingAuditNum);
		} else {
			model.addAttribute("auditNum", fittingAuditNum);
		}
		return "modules/" + "fitting/fittingApplyForm";
	}

	/*配件计划
	*/
    @ResponseBody
    @RequestMapping(value="commitApplyPlan")
    public String commitApplyPlan(String fittingCode,String applyId,String planApplicant,String planApplicantId,String planMarks,Double planNum,HttpServletRequest request){
        if(StringUtils.isBlank(applyId)){
            return "201";
        }
        Record re=Db.findFirst("select * from crm_site_fitting where code=? and status='1' ",fittingCode);
        if(re==null){
            return "202";
        }
    	FittingApply fa = fittingApplyService.getFittingApplyId(applyId);
		Date now = new Date();
        FittingApplyPlan applyPlan=new FittingApplyPlan();
        applyPlan.setFittingApplyId(applyId);
        applyPlan.setPlanTime(now);
        applyPlan.setCreateTime(now);
        applyPlan.setCreator(CrmUtils.getUserXM());
        applyPlan.setCreatorId(UserUtils.getUser().getId());
        applyPlan.setPlanApplicantId(planApplicantId);
        applyPlan.setPlanApplicant(planApplicant);
        applyPlan.setMarks(planMarks);
        applyPlan.setPlanNum(planNum);
        applyPlan.setStatus("1");
        applyPlan.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
        fittingApplyPlanDao.save(applyPlan);
        String sty = fittingApplyService.getOrderFittingFlagById(fa.getOrderNumber(), fa.getSiteId(), applyId);
        //如果申请数大于库存数并且关联工单则修改工单的备件标记
        if(fa.getFittingApplyNum().compareTo(re.getBigDecimal("warning")) == 1 && StringUtil.isNotBlank(fa.getOrderId())) {
        		Db.update("update crm_order a set a.fitting_flag =? where a.id =? ", sty, fa.getOrderId());
        }
        return "ok";
    }

	/**
	 * //备件强全部申请查看详情
	 */
	@RequestMapping(value = "seeDetailForm")
	public String seeDetailForm(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		String fittingImgs = fa.getFittingImg();
		String[] imgs = null;
		if (StringUtils.isNotBlank(fittingImgs)) {
			imgs = fittingImgs.split(",");
			model.addAttribute("fittingApplyImgs", imgs);
		}
		if (imgs != null && imgs.length > 0) {
			model.addAttribute("hasApplyImgs", true);
		}
		if (StringUtils.isNotEmpty(fa.getFittingId())) {
			Fitting fi = fiService.getId(fa.getFittingId());
			model.addAttribute("fitting", fi);
		} else if (StringUtils.isNotBlank(fa.getFittingCode())) {
			Fitting fi = fiService.getByCode(fa.getFittingCode(), siteId);
			model.addAttribute("fitting", fi);
		}
		if (StringUtils.isNotEmpty(fa.getOrderNumber())) {
			Record rd = orderFittingService.getOrderOr400(fa.getOrderNumber(), siteId);
			model.addAttribute("order", rd);
		}
		model.addAttribute("fa", fa);
		model.addAttribute("fmtWT", translationService.translationWarrantyType(fa.getWarrantyType()));
		BigDecimal fittingAuditNum = fa.getFittingAuditNum();
		if (fittingAuditNum == null || fittingAuditNum.doubleValue() == 0) { // 审核数量不允许为0
			fittingAuditNum = fa.getFittingApplyNum();
			model.addAttribute("auditNum", fittingAuditNum);
		} else {
			model.addAttribute("auditNum", fittingAuditNum);
		}
		return "modules/" + "fitting/fittingApplyDetailForm";
	}

	/**
	 * 备件申请上一个、下一个功能
	 */
	@RequestMapping(value = "formClick")
	public String formClick(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		String fittingImgs = fa.getFittingImg();
		String[] imgs = null;
		if (StringUtils.isNotBlank(fittingImgs)) {
			imgs = fittingImgs.split(",");
			model.addAttribute("fittingApplyImgs", imgs);
		}
		if (imgs != null && imgs.length > 0) {
			model.addAttribute("hasApplyImgs", true);
		}
		if (StringUtils.isNotEmpty(fa.getFittingId())) {
			Fitting fi = fiService.getId(fa.getFittingId());
			model.addAttribute("fitting", fi);
		} else if (StringUtils.isNotBlank(fa.getFittingCode())) {
			Fitting fi = fiService.getByCode(fa.getFittingCode(), siteId);
			model.addAttribute("fitting", fi);
		}
		if (StringUtils.isNotEmpty(fa.getOrderNumber())) {
			Record rd = orderFittingService.getOrderOr400(fa.getOrderNumber(), siteId);
			model.addAttribute("order", rd);
		}
		model.addAttribute("fa", fa);
		model.addAttribute("fmtWT", translationService.translationWarrantyType(fa.getWarrantyType()));
		BigDecimal fittingAuditNum = fa.getFittingAuditNum();
		if (fittingAuditNum == null || fittingAuditNum.doubleValue() == 0) { // 审核数量不允许为0
			fittingAuditNum = fa.getFittingApplyNum();
			model.addAttribute("auditNum", fittingAuditNum);
		} else {
			model.addAttribute("auditNum", fittingAuditNum);
		}
		return "modules/" + "fitting/fittingApplyForm";
	}

	/**
	 * 信息员添加申请备件, pc端口替服务工程申请配件(批量)。
	 */
	@RequestMapping("saveFittingApplyBatch")
	@ResponseBody
	public Object saveFittingApplyBatch(HttpServletRequest request) {
		String data = request.getParameter("data");
		String employeId = request.getParameter("employeId");
		String employeName = request.getParameter("employeName");
		String datas[] = data.split("-");

		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());

		String lessStockFitCode = "";

		for (int i = 0; i < datas.length; i++) {
			String vals[] = datas[i].split(",");
			if (vals.length < 2) {
				HashMap<String, String> ret = new HashMap<>();
				ret.put("dataError", "true");
				return ret;
			}
			String fittingId = vals[0];
			String applyNum = vals[1];
			FittingApply fa = new FittingApply();
			fa.setEmployeId(employeId);
			fa.setEmployeName(employeName);
			fa.setFittingId(fittingId);
			fa.setFittingApplyNum(BigDecimal.valueOf(Double.valueOf(applyNum)));

			if (StringUtil.isBlank(fa.getEmployeName())) {
				Employe employe = employeService.get(fa.getEmployeId());
				fa.setEmployeName(employe.getName());
			}

			Fitting fi = fiService.getId(fa.getFittingId());

			if (fi != null) {
				logger.info(String.format("全部申请/工程师申请：warning=%s,apply.num=%s,fitting.Id=%s,emp.id=%s,order.number=%s,fitting.number=%s", fi.getWarning(), fa.getFittingApplyNum(),
						fi.getId(), fa.getEmployeId(), fa.getOrderNumber(), fi.getNumber()));
			} else {
				logger.error("全部申请/工程师申请 -> 未找到配件");
				HashMap<String, Object> ret = new HashMap<>();
				ret.put("error", "fitting not found");
				return ret;
			}

			if (StringUtil.isBlank(fa.getEmployeId())) {
				logger.error("全部申请/工程师申请 -> 工程师id不能为空");
				HashMap<String, Object> ret = new HashMap<>();
				ret.put("error", "employe id not found");
				return ret;
			}

			double amount = fi.getWarning() - fa.getFittingApplyNum().doubleValue();
			if (amount < 0 || fa.getFittingApplyNum().doubleValue() <= 0) {
				HashMap<String, String> ret = new HashMap<>();
				ret.put("noInventory", "true");
				lessStockFitCode = lessStockFitCode + "," + fi.getCode();
				ret.put("result", lessStockFitCode);
				return ret;
			}
		}

		String failureMsg = "";
		String fittingApplyId = "";
		for (int i = 0; i < datas.length; i++) {
			String vals[] = datas[i].split(",");
			String fittingId = vals[0];
			String applyNum = vals[1];

			String orderNumber = null;
			String remarks = null;
			if (vals.length == 3) {
				orderNumber = vals[2];
			} else if (vals.length == 4) {
				orderNumber = vals[2];
				remarks = vals[3];
			}

			FittingApply fa = new FittingApply();
			fa.setEmployeId(employeId);
			fa.setEmployeName(employeName);
			fa.setFittingId(fittingId);
			fa.setFittingApplyNum(BigDecimal.valueOf(Double.valueOf(applyNum)));
			fa.setEmployeFeedback(remarks);

			if (StringUtils.isNotBlank(orderNumber)) {
				Record re = orderFittingService.getOrderOr400(orderNumber, siteId);
				fa.setCustomerName(re.getStr("customer_name"));
				fa.setCustomerMobile(re.getStr("customer_mobile"));
				fa.setCustomerAddress(re.getStr("customer_address"));
				fa.setApplianceBrand(re.getStr("appliance_category"));
				fa.setApplianceCategory(re.getStr("appliance_category"));
				fa.setApplianceModel(re.getStr("apppliance_model"));
				fa.setWarrantyType(re.getStr("warranty_type"));
				fa.setOrderId(re.getStr("id"));
			}

			Fitting fi = fiService.getId(fa.getFittingId());
			Record re = Db.findFirst("select * from crm_site_fitting where id=? ", fittingId);
			if (re.getBigDecimal("warning").compareTo(BigDecimal.valueOf(Double.valueOf(applyNum))) == -1) {
				try {
					failureMsg += "第" + (i + 1) + "行申请的备件" + fi.getCode() + "库存不足,申请失败！\n";
					throw new RuntimeException("fitting stocks is not enough");
				} catch (RuntimeException e) {
					continue;
				}
			}
			fa.setOrderNumber(orderNumber);
			if (StringUtil.isBlank(fa.getEmployeName())) {
				Employe employe = employeService.get(fa.getEmployeId());
				fa.setEmployeName(employe.getName());
			}

			fa.setFittingCode(fi.getCode());
			fa.setFittingImg(fi.getImg());
			fa.setFittingName(fi.getName());
			fa.setFittingVersion(fi.getVersion());
			saveFittingApplyForBatch(fa, fi, remarks);
			if(StringUtil.isNotBlank(fittingApplyId)) {
				fittingApplyId = fittingApplyId+","+fa.getId();
			}else {
				fittingApplyId = fa.getId();
			}
		}

		HashMap<String, String> ret = new HashMap<>();
		if (StringUtils.isNotBlank(failureMsg)) {
			ret.put("noEnough", "true");
			ret.put("msg", failureMsg);
			return ret;
		} else {
			ret.put("fittingApplyId", fittingApplyId);
			ret.put("ckeck", "ok");
			return ret;
		}
	}

	public Object saveFittingApplyForBatch(FittingApply fa, Fitting fi, String remarks) {
		User user = UserUtils.getUser();
		fittingApplyService.employeApply(fa, fi, user, remarks);
		
		fiService.refresh(fi);
		logger.info(String.format("全部申请/工程师申请：warning=%s,apply.num=%s,fitting.Id=%s,emp.id=%s,order.number=%s,fitting.number=%s", fi.getWarning(), fa.getFittingApplyNum(),
				fi.getId(), fa.getEmployeId(), fa.getOrderNumber(), fi.getNumber()));

		/* 库存预警 */
		fiService.stockAlert(fa.getFittingId());
		return fi;
	}

	/**
	 * 信息员添加申请备件, pc端口替服务工程申请配件。
	 */
	@RequestMapping("saveFittingApply")
	@ResponseBody
	public Object saveFittingApply(@Valid FittingApply fa, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return bindingResult.getAllErrors();
		}

		if (StringUtil.isBlank(fa.getEmployeId())) {
			logger.error("全部申请/工程师申请 -> 工程师id不能为空");
			HashMap<String, Object> ret = new HashMap<>();
			ret.put("error", "employe id not found");
			return ret;
		}

		if (StringUtil.isBlank(fa.getEmployeName())) {
			Employe employe = employeService.get(fa.getEmployeId());
			fa.setEmployeName(employe.getName());
		}

		Fitting fi = fiService.getId(fa.getFittingId());
		if (fi != null) {
			logger.info(String.format("全部申请/工程师申请：warning=%s,apply.num=%s,fitting.Id=%s,emp.id=%s,order.number=%s,fitting.number=%s", fi.getWarning(), fa.getFittingApplyNum(),
					fi.getId(), fa.getEmployeId(), fa.getOrderNumber(), fi.getNumber()));
		} else {
			logger.error("全部申请/工程师申请 -> 未找到配件");
			HashMap<String, Object> ret = new HashMap<>();
			ret.put("error", "fitting not found");
			return ret;
		}

		double amount = fi.getWarning() - fa.getFittingApplyNum().doubleValue();
		if (amount < 0 || fa.getFittingApplyNum().doubleValue() <= 0) {
			HashMap<String, String> ret = new HashMap<>();
			ret.put("noInventory", "true");
			return ret;
		}

		User user = UserUtils.getUser();
		fittingApplyService.employeApply(fa, fi, user);

		fiService.refresh(fi);
		logger.info(String.format("全部申请/工程师申请：warning=%s,apply.num=%s,fitting.Id=%s,emp.id=%s,order.number=%s,fitting.number=%s", fi.getWarning(), fa.getFittingApplyNum(),
				fi.getId(), fa.getEmployeId(), fa.getOrderNumber(), fi.getNumber()));

		/* 库存预警 */
		fiService.stockAlert(fa.getFittingId());
		return fi;
	}

	/**
	 * 添加工程师备件申请
	 *
	 * @param fa
	 * @return
	 */
	@RequestMapping(value = "addFittingApplys")
	@ResponseBody
	public Object addFittingApplys(FittingApply fa) {
		Fitting fi = fiService.getId(fa.getFittingId());
		User user = UserUtils.getUser();
		fittingApplyService.addEmpApply(fa, user, fi);
		String siteId = CrmUtils.getCurrentSiteId(user);
		fittingApplyService.updateFittingFlag(fa.getOrderNumber(), siteId);

		return null;
	}

	@ResponseBody
	@RequestMapping(value = "updateFittingApply")
	public Object getupdateFittingApply(HttpServletRequest request, HttpServletResponse response) {
		String auditMarks = request.getParameter("auditMarks");
		String id = request.getParameter("id");
		String fittingId = request.getParameter("fittingId");
		String fittingCode = request.getParameter("fittingCode");
		String fittingCode1 = request.getParameter("fittingCode1");
		String fittingAuditNum = request.getParameter("fittingAuditNum");
		String oldFittingFlag = request.getParameter("oldFittingFlag");
		String orderNumber = request.getParameter("orderNumber");
		String orderType = request.getParameter("orderType");
		String fittingName = request.getParameter("fittingName");
		String fiCount = request.getParameter("ficount");// 库存数量
		String name = CrmUtils.getUserXM();
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		fa.setOldFittingFlag(oldFittingFlag);
		fa.setAuditMarks(auditMarks);
		fa.setUpdateTime(new Date());
		fa.setUpdateName(name);
		fa.setFittingAuditNum(new BigDecimal(fittingAuditNum));
		fa.setFittingCode(fittingCode);
		logger.info(String.format("UFA: fa.id=%s,fitting_code=%s,fitting_code1=%s,marks=%s,audit_num=%s,status=%s", id, fittingCode, fittingCode1, auditMarks, fittingAuditNum,
				fa.getStatus()));

		if (!"0".equals(fa.getStatus()) && !"1".equals(fa.getStatus())) {
			logger.error(String.format("UFA: cannot update,fa.id=%s,fa.status=%s", id, fa.getStatus()));
			return null;
		}

		// 如果两个备件条码相同则不会更新备件信息，fittingCode1是配件原来的编号，fittingCode是本次要更新的配件编号。
		//if (!fittingCode1.equals(fittingCode)) {  //不管相不相同都更新
		if(StringUtils.isNotBlank(fittingId)) {
			Fitting fitting = fiService.getId(fittingId);
			if (fitting != null) {
				fa.setFittingName(fitting.getName());
				fa.setFittingVersion(fitting.getVersion());
				fa.setFittingId(fittingId);
				fa.setFittingCode(fittingCode);
			}
		}

		String exits = request.getParameter("exi");
		if ("no".equals(exits)) {
			logger.info(String.format("UFA: set fa.status=1,old status=%s,fa.id=%s", fa.getStatus(), id));
			fa.setStatus("1");
			if(StringUtil.isNotBlank(fa.getOrderId())) {
				Db.update("update crm_order a set a.fitting_flag = '2' where a.id =? and a.number =? and a.site_id=? ", fa.getOrderId(), fa.getOrderNumber(),fa.getSiteId());
			}
		} else {
			logger.info(String.format("UFA: set fa.status=0,old status=%s,fa.id=%s", fa.getStatus(), id));
			fa.setStatus("0");
		}

		// 配件条码为空，不标为缺件
		if ((StringUtils.isBlank(fittingCode) && StringUtils.isBlank(fittingCode1)) || StringUtils.isBlank(fittingCode)) {
			logger.info(String.format("UFA: set fa.status=0,old status=%s,fa.id=%s", fa.getStatus(), id));
			fa.setStatus("0");
		}
		fittingApplyService.save(fa);

		// 系统预警
		Double fCount = 0.0;
		if (StringUtils.isNotBlank(fiCount)) {
			fCount = Double.valueOf(fiCount);
		}
		if (fCount == 0) {
			String content;
			if (StringUtils.isNotEmpty(orderNumber)) {
				content = "" + orderNumber + "、" + orderType + "申请的" + fittingName + "、" + fittingCode + "缺件，请及时处理！";
			} else {
				content = "" + fittingName + "、" + fittingCode + "缺件，请及时处理！";
			}

			String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			StringBuilder sb = new StringBuilder();
			sb.append(" insert into crm_site_alarm (id, site_id, type, target_id, target_name, content, create_time, status, is_cancel, is_send) ");
			sb.append(" values ('" + IdGen.uuid() + "', '" + siteId + "', '4', '" + id + "', '" + fittingCode + "', '" + content + "', '" + DateUtils.getDate("yyyy-MM-dd HH:mm:ss")
					+ "', '0', '0', '0') ");
			Db.update(sb.toString());
		}
		return fa;
	}

	/**
	 * @return 通过备件申请
	 */
	@ResponseBody
	@RequestMapping(value = "adoptFittingApply")
	public Result<Void> adoptFittingApply(HttpServletRequest request, HttpServletResponse response) {
		String auditMarks = request.getParameter("auditMarks");
		String id = request.getParameter("id");
		String fittingId = request.getParameter("fittingId");
		String fittingCode = request.getParameter("fittingCode");
		String fittingCode1 = request.getParameter("fittingCode1");
		String fittingAuditNum = request.getParameter("fittingAuditNum");
		String oldFittingFlag = request.getParameter("oldFittingFlag");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		logger.info(String.format("adopt fitting apply,id=%s,code=%s,code1=%s,audit_num=%s,old fitting flag=%s,siteId=%s", fittingId, fittingCode, fittingCode1, fittingAuditNum,
				oldFittingFlag, siteId));

		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		/*当前状态已经是审核通过待出库*/
		if ("2".equals(fa.getStatus())) {
			logger.error(String.format("fitting apply [%s] is already adopted, blocked.", fa.getId()));
			return Result.fail("422", "fitting apply already adopted");
		}

		if (StringUtils.isBlank(fittingCode) || StringUtils.isBlank(fittingId)) {
			logger.error(String.format("fitting apply %s fittingId or fittingCode is null", id));
			return Result.fail("423", "fitting apply illegal state");
		}

		String orderNumber = fa.getOrderNumber();
		String name = CrmUtils.getUserXM();
		User user = UserUtils.getUser();
		Fitting fi = fiService.getId(fittingId);

		if (!checkBinding(fittingCode, fi)) {
			logger.error(String.format("fitting code=%s and fitting id=%s binding failed for apply %s", fittingCode, fittingCode1, id));
			return Result.fail("424", "fitting code and id binding failed");
		}
		/*审核数量不能大于当前库存*/
		Double auditNum = Double.valueOf(fittingAuditNum);
		if (fi.getWarning() < auditNum) {
			logger.error(String.format("adopt fitting apply %s failed for not enough warning", id));
			return Result.fail("425", "fitting has not enough warning");
		}

		fa.setOldFittingFlag(oldFittingFlag);
		fa.setAuditMarks(auditMarks);
		fa.setUpdateTime(new Date());
		fa.setUpdateName(name);
		fa.setFittingAuditNum(new BigDecimal(fittingAuditNum));
		fa.setStatus("2");
		fa.setAuditor(name);
		fa.setAuditorId(user.getId());
		fa.setAuditTime(new Date());
		fa.setFittingId(fi.getId());
		fa.setFittingName(fi.getName());
		fa.setFittingCode(fi.getCode());
		fa.setFittingVersion(fi.getVersion());
		fittingApplyService.adoptFittingApply(fa, fi);
		updateOrderFittingFlag(orderNumber, siteId, fa.getStatus(), id);
	
		// 取消预警
		StringBuilder sb = new StringBuilder();
		sb.append(" update crm_site_alarm set is_cancel = '1' ");
		sb.append(" where site_id = '" + siteId + "' and target_id = '" + id + "' and type = '4'  ");
		Db.update(sb.toString());

		return Result.ok();
	}

	private void updateOrderFittingFlag(String orderNumber, String siteId, String fittingApplyStatus, String applyId) {
		String fittingFlag = "0";
		if (StringUtil.isNotBlank(orderNumber)) {
			Tuple<Long, String> countOrder = fittingApplyService.countOrder(orderNumber, siteId);
			if (countOrder.getVal1() > 0) {
				fittingFlag = fittingApplyService.getOrderFittingFlag(orderNumber, siteId);
				if ("1".equals(fittingApplyStatus) && !"2".equals(fittingFlag)) {
					fittingFlag = "6";
				} else if ("2".equals(fittingFlag)) {
					//还有缺件申请
					fittingFlag = fittingApplyService.getOrderFittingFlagById(orderNumber, siteId, applyId);
				}
			}
			String orderTable = countOrder.getVal2();
			if (StringUtil.isNotBlank(orderTable)) {
				Db.update("update " + orderTable + " a set a.fitting_flag = ? where a.number =? and a.site_id=?", fittingFlag, orderNumber, siteId);
			}
		}
	}

	/**
	 * @return 待出库中驳回申请
	 */
	@ResponseBody
	@RequestMapping(value = "RejectFittingApply")
	public Result<Void> RejectFittingApply(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		if (!"2".equals(fa.getStatus())) {
			logger.error(String.format("fitting apply [%s] is already adopted, blocked.", fa.getId()));
			return Result.fail("422", "fitting apply already adopted");
		}
		logger.error(String.format("<<--- RejectFittingApply fitting apply id=%s", fa.getId()) + ";" + new Date());
		String name = CrmUtils.getUserXM();
		Fitting fi = fiService.getId(fa.getFittingId());
		Double auditNum = fa.getFittingAuditNum().doubleValue();
		String orderNumber = fa.getOrderNumber();
		if (fi.getWarning() < auditNum) {
			// 添加预警信息操作
			logger.error(String.format("<<--Reject fitting apply %s failed for not enough warning", id));
			//
			Record rd = fittingApplyService.getalarm(siteId, id);
			if (rd != null) {
				StringBuilder sb = new StringBuilder();
				sb.append(" update crm_site_alarm set is_cancel = '0' ");
				sb.append(" where site_id = '" + siteId + "' and target_id = '" + id + "' and type = '4'  ");
				Db.update(sb.toString());
			} else {
				String sql = null;
				try {
					String content;
					if (StringUtils.isNotEmpty(orderNumber)) {
						content = "" + orderNumber + "、" + "申请的" + fi.getName() + "、" + fi.getCode() + "缺件，请及时处理！";
					} else {
						content = "" + fi.getName() + "、" + fi.getCode() + "缺件，请及时处理！";
					}
					StringBuilder sb = new StringBuilder();
					sb.append(" insert into crm_site_alarm (id, site_id, type, target_id, target_name, content, create_time, status, is_cancel, is_send) ");
					sb.append(" values (?, ?, '4', ?, ?, ?, ?, '0', '0', '0') ");
					sql = sb.toString();
					Db.update(sql, IdGen.uuid(), siteId, id, fi.getCode(), content, new Date());
				} catch (Exception e) {
					logger.error(String.format("create crm site alarm failed,sql=[%s]", sql), e);
					throw e;
				}
			}
		}
		fa.setAuditMarks(fa.getAuditMarks() + ";" + DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss") + "驳回申请");
		fa.setUpdateTime(new Date());
		fa.setUpdateName(name);
		fa.setStatus("0");
		fittingApplyService.RejectFittingApply(fa, fi);
		logger.error(String.format("<<--Reject fitting apply %s Change the status of the application and the number of spare parts to be delivered", id + ";" + new Date()));

		fittingApplyService.updateFittingFlag(orderNumber, siteId);

		return Result.ok();
	}

	private boolean checkBinding(String fittingCode, Fitting fitting) {
		return fitting.getCode().equals(fittingCode);
	}

	/**
	 * @return 拒绝备件申请
	 */
	@ResponseBody
	@RequestMapping(value = "refuseFittingApply")
	public Object refuseFittingApply(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String auditMarks = request.getParameter("auditMarks");
		String reason = request.getParameter("reason");
		return fittingApplyService.refuseFittingApply(id, reason, auditMarks);
	}

	// 申请反馈
	@ResponseBody
	@RequestMapping(value = "messageApply")
	public Object messageApply(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String message = request.getParameter("message");
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		ArrayList<Target> list = WebPageFunUtils.getOrderProcess(fa.getMessage());
		Target ta = new Target();
		String name = CrmUtils.getUserXM();
		ta.setContent(message);
		ta.setName(name);
		ta.setTime(DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
		list.add(ta);
		Gson gson = new Gson();
		@SuppressWarnings("serial")
		String str = gson.toJson(list, new TypeToken<ArrayList<Target>>() {
		}.getType());
		fa.setMessage(str);

		fittingApplyService.save(fa);

		// 推送消息给服务工程师
		pushmessageService.notifyFittingApplyFeedback(fa.getId(), message, fa.getEmployeId());
		return fa;
	}

	// 备件出库
	@ResponseBody
	@RequestMapping(value = "thelibraryApply")
	public Object thelibraryApply(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		FittingApply fa = fittingApplyService.getFittingApplyId(id);
		String name = CrmUtils.getUserXM();
		User user = UserUtils.getUser();
		fa.setConfirmor(name);
		fa.setConfirmorId(user.getId());
		logger.info(String.format("fitting out stock,apply -> id=%s,site_id=%s,audit_num=%s,apply_num=%s,empid=%s,orderNumber=%s", fa.getId(), fa.getSiteId(),
				fa.getFittingAuditNum(), fa.getFittingApplyNum(), fa.getEmployeId(), fa.getOrderNumber()));
		 if (!"2".equals(fa.getStatus())) {
			 return Result.fail(String.format("fitting apply[%s] already out stocked", fa.getId()));
	       }
		Result<Void> ob = fittingApplyService.outStockByFittingApply(fa, user);
		try {
			Fitting fi = fiService.get(fa.getFittingId());
			logger.info("after update site stock,apply.id=" + fa.getId() + ";fitting.id=" + fi.getId() + ";warning=" + fi.getWarning() + ";audited_sum=" + fi.getAuditedSum()
					+ ";number=" + fi.getNumber());
		} catch (Exception ex) {
			logger.error("log update site stock failed,apply.id=" + fa.getId());
		}
		fittingApplyService.updateFittingFlag(fa.getOrderNumber(),  fa.getSiteId());
		/* 库存预警 */
		fiService.stockAlert(fa.getFittingId());
		return ob;
	}

	// 备件出库
	@ResponseBody
	@RequestMapping(value = "batchOutStock")
	public Object batchOutStock(HttpServletRequest request) {
		String[] id = request.getParameterValues("id[]");
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		List<FittingApply> applyList = fittingApplyService.getFittingApplyList(id, CrmUtils.getCurrentSiteId(user));
		String resultMsg = "";
		Integer count = 0;
		String fittingappId = "";
		Result<Void> res = new Result<>();
		for (FittingApply fa : applyList) {
			fa.setConfirmor(name);
			fa.setConfirmorId(user.getId());
			logger.info(String.format("fitting out stock,apply -> id=%s,site_id=%s,audit_num=%s,apply_num=%s,empid=%s,orderNumber=%s", fa.getId(), fa.getSiteId(),
					fa.getFittingAuditNum(), fa.getFittingApplyNum(), fa.getEmployeId(), fa.getOrderNumber()));
			Result<Void> result = fittingApplyService.outStockByFittingApply(fa, user);
			if ("203".equals(result.getCode())) {
				resultMsg += result.getErrMsg();
				continue;
			}
			if ("400".equals(result.getCode())) {
				resultMsg += result.getErrMsg();
				continue;
			}
			if ("402".equals(result.getCode())) {
				resultMsg += fa.getFittingCode()+"出库失败<br>";
				continue;
			}
			if ("403".equals(result.getCode())) {
				resultMsg += fa.getFittingCode()+"已经出库，操作重复<br>";
				continue;
			}
			count ++;
			if(StringUtil.isNotBlank(fittingappId)) {
				fittingappId = fittingappId+","+fa.getId();
			}else {
				fittingappId = fa.getId();
			}
			try {
				Fitting fi = fiService.get(fa.getFittingId());
				logger.info("after update site stock,apply.id=" + fa.getId() + ";fitting.id=" + fi.getId() + ";warning=" + fi.getWarning() + ";audited_sum=" + fi.getAuditedSum()
						+ ";number=" + fi.getNumber());
			} catch (Exception ex) {
				logger.error("log upate site stock failed,apply.id=" + fa.getId());
			}
			fittingApplyService.updateFittingFlag(fa.getOrderNumber(), fa.getSiteId());
		}
		String msg = "<br>"+"出库成功条数："+count;
		resultMsg = resultMsg+msg;
		res.setMsg(fittingappId);
		if (StringUtils.isNotBlank(resultMsg)) {
			res.setCode("203");
			res.setErrMsg(resultMsg);
			return res;

		}
		res.setCode("200");
		res.setMsg("ok");
		return res;
	}

	@RequestMapping(value = "export")
	public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Map<String, Object> ma = new TrimMap(getParams(request));
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);
			List<Record> list = null;
			if ("全部申请".equals(title)) {
				list = fittingApplyService.getfindList(pages, siteId, 2, ma).getList();
				// 申请状态：0.申请待审核 1.缺件中 2.审核通过待出库 3.确认出库待领取 4.已领取可使用 5.申请已取消 6.申请审核未通过，默认0
				for (Record re : list) {
					if ("1".equals(re.getStr("warranty_type"))) {
						re.set("warranty_type", "保外");
					} else if ("2".equals(re.getStr("warranty_type"))) {
						re.set("warranty_type", "保内");
					} else if ("3".equals(re.getStr("warranty_type"))) {
						re.set("warranty_type", "保外转保内");
					} else if ("0".equals(re.getStr("warranty_type"))) {
						re.set("warranty_type", "其他");
					}
					String fapStatus = re.getStr("fapStatus");
					if ("0".equals(fapStatus)) {
						re.set("fapStatus", "待提交");
					}
					if ("1".equals(fapStatus)) {
						re.set("fapStatus", "已提交");
					}
					if ("2".equals(fapStatus)) {
						re.set("fapStatus", "已出库");
					}
					switch (re.getStr("status")) {
					case "0":
						re.set("status", "申请待审核");
						break;
					case "1":
						re.set("status", "缺件中");
						break;
					case "2":
						re.set("status", "审核通过待出库");
						break;
					case "3":
						re.set("status", "确认出库待领取");
						break;
					case "4":
						re.set("status", "已领取可使用");
						break;
					case "5":
						re.set("status", "申请已取消");
						break;
					case "6":
						re.set("status", "申请审核未通过");
						break;
					default:
						break;
					}
				}
			} else {

			}
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	@RequestMapping(value = "q_bjapply")
	@ResponseBody
	public Map<String, Object> q_bjapply(HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> map = Maps.newHashMap();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String code = request.getParameter("code");
		List<Record> list = fittingApplyService.q_bjapply(siteId, code);
		if (list.size() > 0) {
			Record re = list.get(0);
			String name = re.getStr("name");
			String version = re.getStr("version");
			BigDecimal num = re.getBigDecimal("warning");
			String remark = re.getStr("remarks");
			String fittingId = re.getStr("id");
			map.put("name", name);
			map.put("version", version);
			map.put("maxnum", num);
			map.put("remarks", remark);
			map.put("fittingId", fittingId);
			map.put("jg", "data");
		}
		return map;
	}

	@RequestMapping(value = "tj_bjapply")
	@ResponseBody
	public void tj_bjapply(@Valid FittingApply fa, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response, Model model) {

		if (bindingResult.hasErrors()) {
			// intentionally left empty
			return;
		}

		String fittingId = request.getParameter("fittingId");
		Fitting fi = fiService.getId(fittingId);
		String name = CrmUtils.getUserXM();
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String num = request.getParameter("num");
		String type = request.getParameter("type");
		String remarks = request.getParameter("remarks");
		String eid = request.getParameter("empId");
		String orderId = request.getParameter("orderId");
		String empName = request.getParameter("empName");
		BigDecimal bg = new BigDecimal(num);
		fa.setConfirmor(name);
		fa.setConfirmorId(user.getId());
		fa.setFittingAuditNum(fa.getFittingApplyNum());
		fa.setStatus("0"); // 申请待确认
		fa.setNumber(CrmUtils.no());
		fa.setCreateTime(new Date());
		fa.setSuitCategory(fi.getSuitCategory());
		fa.setFittingImg(fi.getImg());
		fa.setCreator(fa.getEmployeName());
		fa.setOldFittingFlag(fi.getRefundOldFlag());
		fa.setAuditor(name);// 审核人
		fa.setAuditorId(user.getId());
		fa.setAuditTime(new Date());
		fa.setType("1");
		fa.setOrderId(orderId);
		fa.setSiteId(siteId);
		fa.setFittingApplyNum(bg);
		fa.setEmployeId(eid);
		fa.setFittingName(name);
		fa.setFittingVersion(type);
		fa.setEmployeFeedback(remarks);
		fa.setFittingCode(fi.getCode());
		fa.setFittingImg(fi.getImg());
		fa.setEmployeName(empName);
		fa.setCreator(empName);
		fa.setMessage(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()) + "@#" + remarks);
		fittingApplyService.bjApplyTj(fa);
	}


	@RequestMapping(value = "fitInRoadExport")
	public String fitInRoadExport(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String formPath = request.getParameter("formPath");
			User user = UserUtils.getUser();
			String siteId = CrmUtils.getCurrentSiteId(user);
			Page<Record> pages = new Page<Record>(request, response);
			pages.setPageNo(1);
			pages.setPageSize(10000);
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
			String title = stf.getExcelTitle();
			String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Map<String, Object> ma = new TrimMap(getParams(request));
			JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			jarray.remove(0);
			List<Record> list = fittingApplyService.fittingInRoadList(pages, ma, siteId).getList();
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value="RejectFittingUsedRecord")
	public Object RejectFittingUsedRecord(HttpServletRequest request,HttpServletResponse response) {
		String id = request.getParameter("id");
		
		return fiService.RejectFitting(id);
	}
	
	/*取消备件在途
	 */
	@ResponseBody
	@RequestMapping(value="cancelFittingPlan")
	public Object cancelFittingPlan(HttpServletRequest request,HttpServletResponse response) {
		String id = request.getParameter("id");
		String orderNumber = request.getParameter("orderNumber");
		return fittingApplyService.cancelFittingPlan(id, orderNumber);
	}
	/*删除备件在途
	 */
	@ResponseBody
	@RequestMapping(value="deleteFittingAppPlan")
	public Object deleteFittingAppPlan(HttpServletRequest request,HttpServletResponse response) {
		String id = request.getParameter("id");
		return fittingApplyService.deleteFittingAppPlan(id);
	}

}