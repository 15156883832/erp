package com.jojowonet.modules.fitting.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.FittingDao;
import com.jojowonet.modules.fitting.dao.FittingOuterApplyDao;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingApply;
import com.jojowonet.modules.fitting.entity.FittingOuterApply;
import com.jojowonet.modules.fitting.service.FittingOuterApplyService;
import com.jojowonet.modules.fitting.service.FittingService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SecondSiteOrderService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.TrimMap;

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

/**
 * 备件申请Controller
 * 
 * @author DQChen
 * @version 2018-01-22
 */
@Controller
@RequestMapping(value = "${adminPath}/fitting/fittingOuterApply")
public class FittingOuterApplyController extends BaseController {
	@Autowired
	private FittingOuterApplyService fittingOuterApplyService;
	@Autowired
	private SecondSiteOrderService secondSiteOrderService;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private FittingOuterApplyDao fittingOuterApplyDao;
	@Autowired
	private FittingService fittingService;
	@Autowired
	private FittingDao fittingDao;

	// 备件申请管理表头
	@RequestMapping(value = "waitShenheHeader")
	public String waitShenheHeader(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		List<Record> listSecondList = secondSiteOrderService.getSecondSiteList(siteId);
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		model.addAttribute("listSecondList", listSecondList);
		return "modules/" + "fitting/secondSiteFittingApply/secondSiteFittingWaitApply";
	}

	// 备件申请待出库表头
	@RequestMapping(value = "waitChukuHeader")
	public String waitChukuHeader(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		List<Record> listSecondList = secondSiteOrderService.getSecondSiteList(siteId);
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		model.addAttribute("listSecondList", listSecondList);
		return "modules/" + "fitting/secondSiteFittingApply/secondSiteFittingWaitOutstocks";
	}

	// 备件申请全部申请表头
	@RequestMapping(value = "allApplyHeader")
	public String allApplyHeader(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		List<Record> listSecondList = secondSiteOrderService.getSecondSiteList(siteId);
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		model.addAttribute("listSecondList", listSecondList);
		return "modules/" + "fitting/secondSiteFittingApply/secondSiteFittingAllApply";
	}

	// 备件申请管理待审核数据
	@ResponseBody
	@RequestMapping(value = "getWaitShenheList")
	public String getWaitShenheList(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> page = fittingOuterApplyService.getWaitShenheList(new Page<Record>(request, response), siteId, 0, ma);// 0表示待审核的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	// 备件申请管理待审核数据
	@ResponseBody
	@RequestMapping(value = "getWaitChukuHeaderList")
	public String getWaitChukuHeaderList(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> page = fittingOuterApplyService.getWaitShenheList(new Page<Record>(request, response), siteId, 1, ma);// 1表示待出库的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	// 备件申请管理待审核数据
	@ResponseBody
	@RequestMapping(value = "getAllApplyHeaderList")
	public String getAllApplyHeaderList(FittingApply fittingApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		Page<Record> page = fittingOuterApplyService.getWaitShenheList(new Page<Record>(request, response), siteId, 2, ma);// 1表示待出库的配件申请
		return renderJson(new JqGridPage<>(page));
	}

	@ResponseBody
	@RequestMapping(value = "twoStatusCount2")
	public Map<String, Object> twoStatusCount2() {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		return fittingOuterApplyService.twoStatusCount2(siteId);
	}

	/**
	 * // 配件申请有可能是直接输入配件名称
	 */
	@RequestMapping(value = "secondSiteSHForm")
	public String form(HttpServletRequest request, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		FittingOuterApply fa = fittingOuterApplyService.getFittingApplyOneId(id);
		String secondSiteId = fa.getApplySiteId();
		model.addAttribute("fa", fa);
		Site st = fittingOuterApplyService.getSiteById(secondSiteId);
		Record rd = fittingOuterApplyService.getFittingByCode(fa.getApplyFittingCode(), siteId);
		model.addAttribute("siteName", st.getName());
		if (rd != null) {
			model.addAttribute("ft", rd);
		}
		String ftImg = fa.getApplyFittingImg();
		if (StringUtils.isNotBlank(ftImg)) {
			model.addAttribute("ftImg", ftImg.split(","));
		}
		return "modules/" + "fitting/secondSiteFittingApply/secondSiteSHForm";
	}

	// 保存
	@ResponseBody
	@RequestMapping(value = "updateFittingOuterApply")
	public String updateFittingOuterApply(HttpServletRequest request) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String auditMarks = request.getParameter("auditMarks");
		String fittingAuditNum = request.getParameter("fittingAuditNum");
		String oldFittingFlag = request.getParameter("oldFittingFlag");
		return fittingOuterApplyService.updateFittingOuterApply(id, auditMarks, fittingAuditNum, oldFittingFlag, siteId);
	}

	// 通过
	@ResponseBody
	@RequestMapping(value = "adoptFittingOuterApply")
	public String adoptFittingOuterApply(HttpServletRequest request) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String auditMarks = request.getParameter("auditMarks");
		String fittingAuditNum = request.getParameter("fittingAuditNum");
		String oldFittingFlag = request.getParameter("oldFittingFlag");
		return fittingOuterApplyService.adoptFittingOuterApply(id, auditMarks, fittingAuditNum, oldFittingFlag, siteId);
	}

	// 拒绝
	@ResponseBody
	@RequestMapping(value = "refuseFittingOuterApply")
	public String fittingOuterApply(HttpServletRequest request) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String auditMarks = request.getParameter("auditMarks");
		String reason = request.getParameter("reason");
		return fittingOuterApplyService.refuseFittingOuterApply(id, auditMarks, reason, siteId);
	}

	// 出库
	@ResponseBody
	@RequestMapping(value = "applyOutStocks")
	public String applyOutStocks(HttpServletRequest request) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		return fittingOuterApplyService.applyOutStocks(id, siteId);
	}

	// 备件批量出库
	@ResponseBody
	@RequestMapping(value = "batchOutStock")
	public Object batchOutStock(HttpServletRequest request) {
		String[] id = request.getParameterValues("id[]");
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<FittingOuterApply> applyList = fittingOuterApplyService.getFittingApplyList(id, siteId);
		Site st = siteDao.get(siteId);
		Date dt = new Date();
		for (FittingOuterApply foa : applyList) {
			fittingOuterApplyService.batchOutStock(foa, siteId, user, st, dt);
		}
		return Result.ok();
	}

	// 驳回
	@ResponseBody
	@RequestMapping(value = "RejectFittingApply")
	public String RejectFittingApply(HttpServletRequest request) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		return fittingOuterApplyService.RejectFittingApply(id, siteId);
	}

	// 导出
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
			list = fittingOuterApplyService.getWaitShenheList(pages, siteId, 2, ma).getList();
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
			new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	}

	// 二级网点备件申请管理表头
	@RequestMapping(value = "getAllApplyTab")
	public String getApplyList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		List<Record> listR = GoodsCategoryUtil.getSiteCategory(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		return "modules/" + "fitting/secondSiteFittingApply/secSiteFittingApplyList";
	}

	// 二级网点数据
	@ResponseBody
	@RequestMapping(value = "getAllApplyList")
	public String getAllApplyList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Map<String, Object> ma = new TrimMap(getParams(request));
		ivan.common.persistence.Page<Record> page = fittingOuterApplyService.getAllApplyList(new Page<Record>(request, response), siteId, ma);
		return renderJson(new JqGridPage<>(page));
	}

	/**
	 * 向一级网点申请备件
	 */
	@RequestMapping("saveFittingApply")
	@ResponseBody
	public Object saveFittingApply(HttpServletRequest request) {
		HashMap<String, Object> ret = new HashMap<>();
		String fIds = request.getParameter("fIds");
		String nums = request.getParameter("nums");
		String marks = request.getParameter("marks");
		User user = UserUtils.getUser();
		String uname = CrmUtils.getUserXM();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record re = Db.findFirst("select parent_site_id from crm_site_parent_rel a where a.site_id=? and a.status='0' ", siteId);
		if (re == null) {
			ret.put("code", "420");
			ret.put("msg", "网点绑定关系有误，请确认后重试！");
			return ret;
		}
		if (StringUtils.isBlank(fIds) || StringUtils.isBlank(nums)) {
			ret.put("code", "421");
			ret.put("msg", "数据有误，请检查！");
			return ret;
		}

		String[] idArr = fIds.split(",");
		List<Record> list = Db.find("select a.* from crm_site_fitting a  where a.status='1' and a.id in (" + StringUtil.joinInSql(fIds.split(",")) + ")");

		String mark = "1";
		String msg = "";
		for (int i = 0; i < idArr.length; i++) {
			String fId = idArr[i];
			for (Record rd1 : list) {
				if (fId.equals(rd1.getStr("id"))) {
					mark = "2";
				}
			}
			if ("1".equals(mark)) {
				msg = "第" + (i + 1) + "条备件信息有误，请刷新后重试！";
				break;
			}
		}
		if ("1".equals(mark)) {
			ret.put("code", "422");
			ret.put("msg", msg);
			return ret;
		}
		return fittingOuterApplyService.saveFittingApplyUpdate(fIds, nums, marks, user, uname, siteId, re.getStr("parent_site_id"), list);
	}

	@RequestMapping("repeatSubmitApply")
	@ResponseBody
	public Object repeatSubmitApply(@Valid FittingOuterApply fa, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return bindingResult.getAllErrors();
		}

		if (StringUtil.isBlank(fa.getApplyFittingId())) {
			logger.error("二级网点全部申请 -> 备件id不能为空");
			HashMap<String, Object> ret = new HashMap<>();
			ret.put("error", "fitting id not found");
			return ret;
		}

		Fitting fi = fittingService.getId(fa.getApplyFittingId());
		if (fi != null) {
			logger.info(String.format("全部申请/二级网点申请重新提交：apply.num=%s,fitting.Id=%s,fitting.number=%s", fa.getApplyFittingNum(), fi.getId(), fi.getNumber()));
		} else {
			logger.error("全部申请/二级网点申请重新提交 -> 未找到配件");
			HashMap<String, Object> ret = new HashMap<>();
			ret.put("error", "fitting not found");
			return ret;
		}
		FittingOuterApply outerApply = fittingOuterApplyDao.get(fa.getId());
		User user = UserUtils.getUser();
		String uname = CrmUtils.getUserXM();
		String siteId = CrmUtils.getCurrentSiteId(user);
		Record re = Db.findFirst("select parent_site_id from crm_site_parent_rel a where a.site_id=? and a.status='0' ", siteId);
		if (re == null) {
			return "405";
		}
		outerApply.setTargetSiteId(re.getStr("parent_site_id"));
		outerApply.setApplySiteId(siteId);
		outerApply.setType("1");
		outerApply.setApplicantId(user.getId());
		outerApply.setApplicantName(uname);
		outerApply.setStatus("0");
		outerApply.setOldFittingFlag("0");
		outerApply.setApplyFittingBrand(fi.getBrand());
		outerApply.setApplyFittingVersion(fi.getVersion());
		outerApply.setUpdateName(uname);
		outerApply.setUpdateTime(new Date());
		outerApply.setApplicantFeedback(fa.getApplicantFeedback());
		outerApply.setApplyFittingType(fa.getApplyFittingType());
		outerApply.setApplyFittingCode(fa.getApplyFittingCode());
		outerApply.setApplyFittingName(fa.getApplyFittingName());
		outerApply.setApplyFittingId(fa.getApplyFittingId());
		outerApply.setApplyFittingNum(fa.getApplyFittingNum());
		outerApply.setSuitCategory(fi.getSuitCategory());
		outerApply.setApplyFittingBrand(fi.getBrand());
		outerApply.setApplyFittingVersion(fa.getApplyFittingVersion());
		outerApply.setApplicantFeedback(fa.getApplicantFeedback());
		outerApply.setAuditMarks("");
		outerApply.setAuditor("");
		outerApply.setAuditFittingNum(null);
		outerApply.setAuditorId("");
		outerApply.setAuditTime(null);
		outerApply.setRefuseReason(null);
		fittingOuterApplyService.saveFittingApply(outerApply);
		return fi;
	}

	/**
	 * 撤销申请
	 */
	@ResponseBody
	@RequestMapping(value = "revocationApply")
	public String revocationApply(HttpServletRequest request) {
		String applyId = request.getParameter("id");
		return fittingOuterApplyService.revocationApply(applyId);
	}

	/**
	 * 入库
	 */
	@ResponseBody
	@RequestMapping(value = "thelibraryApply")
	public Object thelibraryApply(HttpServletRequest request) {
		String id = request.getParameter("id");
		if (StringUtil.isBlank(id)) {
			logger.error("二级网点全部申请 -> 备件id不能为空");
			HashMap<String, Object> ret = new HashMap<>();
			ret.put("error", "fitting id not found");
			return ret;
		}
		User user = UserUtils.getUser();
		FittingOuterApply outerApply = fittingOuterApplyDao.get(id);
		outerApply.setStockingId(user.getId());
		outerApply.setStockingName(CrmUtils.getUserXM());
		outerApply.setStatus("4");
		outerApply.setEndTime(new Date());
		outerApply.setUpdateName(CrmUtils.getUserXM());
		outerApply.setUpdateTime(new Date());
		fittingOuterApplyService.putInstock(outerApply);
		/* 取消库存预警 */
		fittingService.cancelStockAlert(outerApply.getApplyFittingId());
		return "ok";
	}

	@RequestMapping(value = "getFittingApplyInfo")
	public String getFittingApplyInfo(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		Record re = Db.findFirst("select a.*,b.unit from crm_site_fitting_outer_apply a left join crm_site_fitting b on a.apply_fitting_id=b.id  where a.id=? ", id);
		model.addAttribute("applyFitting", re);
		return "modules/" + "fitting/secondSiteFittingApply/fittingApplyInfo";
	}

}
