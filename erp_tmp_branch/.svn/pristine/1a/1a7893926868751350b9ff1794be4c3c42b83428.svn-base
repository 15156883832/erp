package com.jojowonet.modules.sys.web;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.google.gson.Gson;
import com.jojowonet.modules.operate.service.*;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.service.AccountService;
import com.jojowonet.modules.goods.service.SitePlatformGoodsService;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.utils.TraderSiteForm;
import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import com.jojowonet.modules.order.dao.CustomerTypeDao;
import com.jojowonet.modules.order.dao.ServiceModeDao;
import com.jojowonet.modules.order.dao.ServiceTypeDao;
import com.jojowonet.modules.order.entity.CrmOrder2017;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.LoginResponse;
import com.jojowonet.modules.order.form.RegisterForm;
import com.jojowonet.modules.order.form.ResetPwdByMailForm;
import com.jojowonet.modules.order.form.ResetPwdBySmsForm;
import com.jojowonet.modules.order.form.SiteVendorAccountForm;
import com.jojowonet.modules.order.form.constant.Factory;
import com.jojowonet.modules.order.form.constant.Status;
import com.jojowonet.modules.order.service.AnnouncementService;
import com.jojowonet.modules.order.service.CustomerTelephoneIncomeService;
import com.jojowonet.modules.order.service.OrderDispatchService;
import com.jojowonet.modules.order.service.OrderMallService;
import com.jojowonet.modules.order.service.OrderOriginService;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.service.SiteAlarmService;
import com.jojowonet.modules.order.service.SiteScheduleService;
import com.jojowonet.modules.order.service.SitetVenderAccountService;
import com.jojowonet.modules.order.service.TelNotifyOrderService;
import com.jojowonet.modules.order.service.TownshipService;
import com.jojowonet.modules.order.utils.BrandUtils;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.FlagResult;
import com.jojowonet.modules.order.utils.OrderCountChangeTypes;
import com.jojowonet.modules.order.utils.OrderNo;
import com.jojowonet.modules.order.utils.RandomUtil;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.web.OrderController;
import com.jojowonet.modules.sys.service.SystemService;
import com.jojowonet.modules.sys.util.OrderDetailsVo;
import com.jojowonet.modules.sys.util.SMSUtils;
import com.jojowonet.modules.unipay.UniPayOrderServiceFactory;
import com.jojowonet.modules.unipay.core.OrderContext;
import com.jojowonet.modules.unipay.core.TradeStatus;
import com.jojowonet.modules.unipay.core.UnifyOrderService;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.mapper.JsonMapper;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.MD5;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "${adminPath}/main/redirect")
public class RedirectController extends BaseController {

	private static Logger logger = Logger.getLogger(RedirectController.class);

	@Autowired
	private SystemService systemService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private TelNotifyOrderService telNotifyOrderService;
	@Autowired
	private CustomerTelephoneIncomeService customerTelephoneIncomeService;
	@Autowired
	private OrderDispatchService orderDispatchService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private SiteService siteService;
	@Autowired
	private SiteAlarmService siteAlarmService;
	@Autowired
	private AnnouncementService annoucementService;
	@Autowired
	private SiteScheduleService siteScheduleService;
	@Autowired
	EmployeService employeService;
	@Autowired
	private OrderOriginService orderOriginServicce;
	@Autowired
	NonServicemanService nonServicemanService;
	@Autowired
	private SiteMsgService siteMsgService;
	@Autowired
	private SitePlatformGoodsService sitePlatformGoodsService;
	@Autowired
	private TownshipService townshipService;
	@Autowired
	private EmployeDailySignService employeDailySignService;
	@Autowired
	private OrderMallService orderMallService;
	@Autowired
	private SitetVenderAccountService sitetVenderAccountService;
	@Autowired
	private ReceivedSmsService receivedSmsService;

	@Autowired
	private SendedSmsService smsService;

	@RequestMapping(value = "welcome")
	public String crmLogin(HttpServletRequest request, Model model) {
		// 首页查询预警消息模块
		User user = UserUtils.getUser();
		String userId = user.getId();
		String siteId = CrmUtils.getCurrentSiteId(user);
		List<Record> sitealarmlist = siteAlarmService.getAlarmlist(siteId);
		for (Record rd : sitealarmlist) {
			String createtime = rd.getDate("create_time").toString();
			String createTime = createtime.substring(0, createtime.indexOf(" "));
			rd.set("create_time", createTime);
		}
		model.addAttribute("sitealarmlist", sitealarmlist);

		// String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		// 首页查询系统公告模块
		List<Record> announcementlist = annoucementService.getAnnouncementlist(siteId);
		model.addAttribute("announcementlist", announcementlist);

		/* 日历、待办事项 */
		List<Record> listDaiban = siteScheduleService.siteScheduleList(siteId);
		String[] listDate = siteScheduleService.siteScheduleTime(siteId);
		model.addAttribute("listDaiban", listDaiban);
		model.addAttribute("listDate", JSONArray.fromObject(listDate).toString());
		model.addAttribute("userId", userId);
		model.addAttribute("isPeijianMan", CrmUtils.isPeijianMan(user));
		model.addAttribute("permissions", user.getPermission());
		model.addAttribute("userType", user.getUserType());
		return "modules/base/welcome";
		// return "modules/base/homepage";
	}

	@RequestMapping(value = "getOtherlistdate")
	@ResponseBody
	public List<Record> getOtherlistdate(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		return siteScheduleService.siteScheduleOtherList(siteId);
	}

	@ResponseBody
	@RequestMapping(value = "getOtherlistTime")
	public String getOtherlistTime(HttpServletRequest request, HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String[] listDate = siteScheduleService.siteScheduleOtherTime(siteId);
		return JSONArray.fromObject(listDate).toString();
	}

	@RequestMapping(value = { "mainIndex", "" })
	public String mainIndex(HttpServletRequest request) {
		Map<String, Object> params = getParams(request);
		if ("jdxh".equals(params.get("origin"))) {
			return "modules/base/partner/login";
		}

		return "modules/base/login";
	}

	@RequestMapping(value = "ajaxTest")
	@ResponseBody
	public String ajaxTest(HttpServletRequest request) {
		Map<String, String> map = Maps.newHashMap();
		// map.put("barcodeStat", BarcodeService.BARCODECACHE.stats().toString());
		return map.toString();
	}

	@RequestMapping(value = "goTest")
	public String crmRegist() {
		// 删除多余的crm_site_default_role_permissions/crm_site_role_permission中重复的字段
		List<Record> drs = Db.find("select a.id, a.permissions from crm_site_default_nonservice_permission a where 1=1");
		List<Record> srs = Db.find("select a.id, a.permissions from crm_site_role_permission a where 1=1");
		for (Record drd : drs) {
			String pers = drd.getStr("permissions");
			String id = drd.getStr("id");

			String[] perArr = pers.split(",");
			Map<String, String> map = Maps.newHashMap();
			for (String s : perArr) {
				if (StringUtil.isNotBlank(s)) {
					map.put(s, "1");
				}
			}
			StringBuilder sb = new StringBuilder("");
			for (Map.Entry<String, String> ent : map.entrySet()) {
				String key = ent.getKey();
				sb.append(",").append(key);
			}
			Db.update("update crm_site_default_nonservice_permission set permissions = ? where id = ?", sb.toString(), id);
		}

		for (Record srd : srs) {
			String pers = srd.getStr("permissions");
			String id = srd.getStr("id");

			String[] perArr = pers.split(",");
			Map<String, String> map = Maps.newHashMap();
			for (String s : perArr) {
				if (StringUtil.isNotBlank(s)) {
					map.put(s, "1");
				}
			}
			StringBuilder sb = new StringBuilder("");
			for (Map.Entry<String, String> ent : map.entrySet()) {
				String key = ent.getKey();
				sb.append(",").append(key);
			}
			Db.update("update crm_site_role_permission set permissions = ? where id = ?", sb.toString(), id);
		}

		return "modules/goods/testBJ";
	}

	@RequestMapping(value = { "forgetPwd" })
	public String crmForgetPwd() {
		return "modules/base/forgetpwd";
	}

	@RequestMapping(value = "mobileCode")
	public void getMobileCode(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter write;
		try {
			write = response.getWriter();
			// 获取categoryid
			String mobile = request.getParameter("mobile");
			Map<String, Object> sendSim = systemService.SendSim(mobile);
			request.getSession().setAttribute("valcode", sendSim.get("valcode"));
			JSONObject obj = new JSONObject();
			obj.put("code", MD5.MD5((String) sendSim.get("valcode")));
			write.print(obj);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "sendMailCode")
	@ResponseBody
	public HashMap<String, String> sendMailCode(HttpServletRequest request) {
		String mail = request.getParameter("mail");
		User user = accountService.getUserByMail(mail);
		HashMap<String, String> ret = new HashMap<>();

		if (user == null) {
			ret.put("status", "n");
			return ret;
		}

		String token = RandomUtil.getPositiveRandomWithRang(4);
		Db.update("update sys_user set reset_pwd_token=? where id=?", token, user.getId());
		try {
			HtmlEmail email = new HtmlEmail();
			email.setCharset("UTF-8");
			email.setHostName(Global.getConfig("email.host"));
			email.setAuthenticator(new DefaultAuthenticator(Global.getConfig("email.username"), Global.getConfig("email.password")));
			email.setFrom(Global.getConfig("email.username"), Global.getConfig("email.corporation.title"));
			email.setSubject("密码重置");
			email.setHtmlMsg(String.format("您的验证码为：%s", token));
			email.addTo(mail);
			email.send();
			ret.put("status", "y");
		} catch (EmailException e) {
			ret.put("status", "n");
		}
		return ret;
	}

	@RequestMapping(value = "register")
	@ResponseBody
	public Object register(@Valid RegisterForm registForm, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return bindingResult.getAllErrors();
		} else {
			Map<String, String> errorCollector = new HashMap<>();
			if (checkRegist(registForm.getLoginName(), registForm.getMobile(), errorCollector)) {
				User user = new User();
				user.setLoginName(registForm.getLoginName());
				user.setMobile(registForm.getMobile());
				user.setCreateType(1);
				user.setPassword(SystemService.entryptPassword(registForm.getPassword()));
				user.setCreateDate(new Date());
				user.setStatus("0");
				user.setUserType("2");
				user.setUpdateTime(new Date());

				accountService.saveSiteUser(user, registForm.getSiteName());
				return user;
			}
			errorCollector.put("status", "n");
			return errorCollector;
		}
	}

	private boolean checkRegist(String login, String mobile, Map<String, String> error) {
		Long userCount = Db.queryLong("select count(1) from sys_user where `status`='0' and login_name=?", login);
		if (userCount > 0) {
			error.put("login", "login has already been taken");
			return false;
		}
		userCount = Db.queryLong("select count(1) from sys_user where `status`='0' and mobile=?", mobile);
		if (userCount > 0) {
			error.put("mobile", "mobile has already been taken");
			return false;
		}
		return true;
	}

	/**
	 * 通过短信验证码找回密码
	 */
	@RequestMapping(value = "resetPwdBySms")
	public String resetPwdBySms(@Valid ResetPwdBySmsForm resetForm, BindingResult bindingResult, HttpServletRequest request, RedirectAttributes a) {
		if (bindingResult.hasErrors()) {
			return "modules/sys/forgetpwd";
		} else {
			Object valcode = request.getSession().getAttribute("valcode");
			if (valcode != null && valcode.equals(resetForm.getCode())) {
				User user = accountService.getUserByMobile(resetForm.getMobile());
				if (user != null) {
					user.setPassword(SystemService.entryptPassword(resetForm.getPassword()));
					user.setUpdateTime(new Date());
					accountService.save(user);
					UserUtils.removeCache("user");
					Subject subject = SecurityUtils.getSubject();
					subject.logout();
					a.addFlashAttribute("temporaryMsg", "密码修改成功");
				}
			}
			return "redirect:" + Global.getAdminPath() + "/login";
		}
	}

	/**
	 * 通过邮箱找回密码
	 */
	@RequestMapping(value = "resetPwdByMail")
	public String resetPwdByMail(@Valid ResetPwdByMailForm resetForm, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "modules/sys/forgetpwd";
		} else {
			List<Record> records = Db.find("select * from sys_user where email=? and reset_pwd_token=? and status='0'", resetForm.getMail(), resetForm.getToken());
			if (records.size() > 0) {
				Db.update("update sys_user set password=? where email=? and reset_pwd_token=? and status='0'", SystemService.entryptPassword(resetForm.getPassword()),
						resetForm.getMail(), resetForm.getToken());
			}
			return "redirect:" + Global.getAdminPath();
		}
	}

	@ResponseBody
	@RequestMapping(value = "checkcode")
	public HashMap<String, String> checkSmsCode(@RequestParam("param") String code, @RequestParam(value = "sucmsg", required = false) String sucmsg, HttpServletRequest request) {

		HashMap<String, String> passRet = new HashMap<>();
		passRet.put("status", "y");
		passRet.put("info", sucmsg == null ? "验证通过" : sucmsg);
		HashMap<String, String> errorRet = new HashMap<>();
		errorRet.put("status", "n");
		errorRet.put("info", "验证码不正确");

		Object _code = request.getSession().getAttribute("valcode");
		return (code != null && _code != null && code.equals(_code)) ? passRet : errorRet;
	}

	/**
	 * Working with ValidForm 5.3
	 */
	@ResponseBody
	@RequestMapping(value = "checkphone2")
	public HashMap<String, String> checkphone2(@RequestParam("param") String mobile, @RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "sucmsg", required = false) String sucmsg) {
		HashMap<String, String> passRet = new HashMap<>();
		passRet.put("status", "y");
		passRet.put("info", sucmsg == null ? "验证通过" : sucmsg);
		HashMap<String, String> errorRet = new HashMap<>();
		errorRet.put("status", "n");
		errorRet.put("info", "手机号已经被占用");

		if (mobile == null) {
			errorRet.put("info", "手机号不能为空");
			return passRet;
		}

		try {
			User user = accountService.getUserByMobile(mobile);
			if (user != null && id != null && id.equals(user.getId())) {
				return passRet;
			}
			return user != null ? errorRet : passRet;
		} catch (NonUniqueResultException e) {
			return errorRet;
		}
	}

	/**
	 * 验证用户提供的邮箱是否注册。
	 */
	@ResponseBody
	@RequestMapping(value = "checkmail3")
	public HashMap<String, String> checkMail3(@RequestParam("param") String mail, @RequestParam(value = "sucmsg", required = false) String sucmsg) {
		HashMap<String, String> passRet = new HashMap<>();
		passRet.put("status", "y");
		passRet.put("info", sucmsg == null ? "验证通过" : sucmsg);
		HashMap<String, String> errorRet = new HashMap<>();
		errorRet.put("status", "n");
		errorRet.put("info", "邮箱尚未注册");

		User user = accountService.getUserByMail(mail);
		return user == null ? errorRet : passRet;
	}

	/**
	 * 验证邮箱验证码是否正确。
	 */
	@ResponseBody
	@RequestMapping(value = "checktoken")
	public HashMap<String, String> checkToken(@RequestParam("param") String token, @RequestParam("mail") String mail,
			@RequestParam(value = "sucmsg", required = false) String sucmsg) {
		String status = accountService.isTokenValid(mail, token) ? "y" : "n";
		String info = "y".equals(status) ? (sucmsg == null ? "验证通过" : sucmsg) : "验证码不正确";
		HashMap<String, String> ret = new HashMap<>();
		ret.put("status", status);
		ret.put("info", info);
		return ret;
	}

	/**
	 * http://localhost:8085/erp/a/main/redirect/assistantLogin?uname=penghui1314&upwd=adb6fc66763baabac3ffe9df01f2091d
	 * http://www.sifangerp.cn/order2.0/a/main/redirect/assistantLogin?uname=15655445653&upwd=25f9e794323b453885f5181f1b624d0b
	 */
	@RequestMapping(value = "assistantLogin")
	@ResponseBody
	public JSONObject assistantLogin(HttpServletRequest req, HttpServletResponse response) {
		String userName = req.getParameter("uname");
		String password = req.getParameter("upwd");

		String appId = req.getParameter("appId");
		LoginResponse lr = new LoginResponse();
		if (StringUtils.isNotBlank(appId)) {
			Record rd = Db.findFirst(" SELECT * from `sys_apk` a where a.`id`  = ? ", appId);
			if (rd != null) {
				lr.setVersion(rd.getStr("version"));
				lr.setUpdateUrl(rd.getStr("url"));
				JSONArray ja = JSONArray.fromObject(rd.get("attached", ""));
				List<Map<String, String>> ufs = Lists.newArrayList();
				for (int i = 0; i < ja.size(); i++) {
					JSONObject jo = ja.getJSONObject(i);
					Map<String, String> uf = Maps.newHashMap();
					String fileName = jo.keys().next().toString();
					uf.put("fileName", fileName);
					uf.put("filePath", jo.getString(fileName));
					ufs.add(uf);
				}
				lr.setUpdateFiles(ufs);
				lr.setStatus(Status.SUCCESS);
			}
			return JSONObject.fromObject(lr);
		}

		if (StringUtils.isNotBlank(userName) && StringUtils.isNotBlank(password)) {

			// 添加信息员帐号逻辑
			// userName=转换的网点登录名
			// password=转换的网点密码
			Record urd = Db.findFirst(" select b.site_id from sys_user a, crm_non_serviceman b where a.status = '0' "
					+ "and b.user_id = a.id and ( a.login_name = ? or a.mobile = ? ) and a.password = ? and a.user_type = '3' limit 1 ", userName, userName, password);
			boolean isNM = false;
			if (urd != null) {
				String siteId = urd.getStr("site_id");
				Site site = siteService.get(siteId);
				User siteUser = site.getUser();
				userName = siteUser.getLoginName();
				password = siteUser.getPassword();
				isNM = true;
			}

			StringBuilder sb = new StringBuilder("");
			sb.append(" select * from (");

			// 网点
			sb.append(
					" select a.id, b.id as siteId, b.name as siteName, a.user_type, c.login_name as vendorLoginName, c.id as vendorAccountId, c.password as vendorPassword, d.name as vendorName, d.url as vendorUrl, ");
			sb.append(" e.version, e.url, e.attached");
			sb.append(" from sys_user a  ");
			sb.append(" inner join crm_site b on b.user_id = a.id and b.status = '0' ");
			sb.append(" left join crm_site_vender_account c on c.site_id = b.id and c.status = '0' ");
			sb.append(" left join crm_vender_info d on d.id = c.vender_id and d.status = '0' ");
			sb.append(" left join sys_apk e on e.id='5' ");
			sb.append(" where b.due_time > '" + DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss") + "' and ( a.login_name = ? or a.mobile = ? )  ");// penghui1314
			sb.append(" and a.password = ?  ");// adb6fc66763baabac3ffe9df01f2091d
			sb.append(" and a.user_type = '2' and a.status='0' order by vendorUrl desc  ");
			// sb.append(" and a.user_type in('2', '3') and a.status='0' order by vendorUrl
			// desc ");
			sb.append(" ) as ot1 ");

			/*
			 * sb.append(" union all ");
			 *
			 * sb.append(" select * from ( "); //信息员 sb.
			 * append(" select a.id, b.site_id as siteId, cs.name as siteName, a.user_type, c.login_name as vendorLoginName, c.password as vendorPassword, d.name as vendorName, d.url as vendorUrl, "
			 * ); sb.append(" e.version, e.url, e.attached");
			 * sb.append(" from sys_user a  "); sb.
			 * append(" inner join crm_non_serviceman b on b.user_id = a.id and b.status = '0'  "
			 * );
			 * sb.append(" left join crm_site cs on cs.id = b.site_id and cs.status = '0'  "
			 * ); sb.
			 * append(" left join crm_site_vender_account c on c.site_id = b.id and c.status = '0' "
			 * ); sb.
			 * append(" left join crm_vender_info d on d.id = c.vender_id and d.status = '0' "
			 * ); sb.append(" left join sys_apk e on e.id='5' ");
			 * sb.append(" where cs.due_time > '" + DateUtils.formatDate(new Date(),
			 * "yyyy-MM-dd HH:mm:ss") + "' and ( a.login_name = ? or a.mobile = ? )  ");//
			 * penghui1314 sb.append(" and a.password = ?  ");//
			 * adb6fc66763baabac3ffe9df01f2091d
			 * sb.append(" and a.user_type = '3' and a.status='0' order by vendorUrl desc  "
			 * ); sb.append(" ) as ot2 ");
			 */

			List<Record> rds = Db.find(sb.toString(), userName, userName, password);
			if (rds != null && rds.size() > 0) {
				List<Map<String, Object>> vendors = Lists.newArrayList();
				String version = "";
				String updateUrl = "";
				String files = "";
				for (Record rd : rds) {
					String siteId = rd.get("siteId", "");
					if (StringUtil.isBlank(siteId)) {
						continue;
					}
					lr.setSiteId(siteId);
					String userType = "2";
					if (isNM) {
						userType = "3";
					}
					lr.setUserType(userType);
					lr.setSiteName(String.valueOf(rd.get("siteName", "")));
					Map<String, Object> item = Maps.newHashMap();
					item.put("vendorLoginName", rd.get("vendorLoginName", ""));
					item.put("vendorPassword", rd.get("vendorPassword", ""));
					item.put("vendorName", rd.get("vendorName", ""));
					item.put("vendorUrl", rd.get("vendorUrl", ""));
					item.put("vendorAccountId", rd.get("vendorAccountId", ""));
					item.put("factory", Factory.getFactoryLabel(rd.getStr("vendorName")));
					version = rd.get("version", "");
					updateUrl = rd.get("url", "");
					vendors.add(item);
					if (StringUtil.isNotBlank(rd.getStr("attached"))) {
						files = rd.get("attached", "");
					}
				}
				JSONArray ja = JSONArray.fromObject(files);
				List<Map<String, String>> ufs = Lists.newArrayList();
				for (int i = 0; i < ja.size(); i++) {
					Map<String, String> item = (Map<String, String>) ja.get(i);
					Map<String, String> uf = Maps.newHashMap();
					uf.put("fileName", item.entrySet().iterator().next().getKey());
					uf.put("filePath", item.entrySet().iterator().next().getValue());
					ufs.add(uf);
				}
				lr.setUpdateFiles(ufs);
				lr.setUpdateUrl(updateUrl);
				lr.setVersion(version);
				lr.setVendors(vendors);
				lr.setStatus(Status.SUCCESS);
			} else {
				lr.setStatus(Status.ERROR);
			}
		} else {
			lr.setStatus(Status.EMPTY);
		}
		return JSONObject.fromObject(lr);
	}

	/**
	 * 验证用户名是否重复，最新的Validform推荐的返回格式。
	 */
	@RequestMapping(value = "checkLoginName2")
	@ResponseBody
	public HashMap<String, String> checkLoginName2(@RequestParam("param") String loginName, @RequestParam(value = "sucmsg", required = false) String sucmsg) throws IOException {
		boolean status = loginName != null && systemService.getUserByLoginName(loginName) == null;
		String _status = status ? "y" : "n";
		String msg = status ? (sucmsg == null ? "验证通过" : sucmsg) : "用户名已被占用";
		HashMap<String, String> ret = new HashMap<>();
		ret.put("status", _status);
		ret.put("info", msg);
		return ret;
	}

	/**
	 * 如何当前用户为服务商用户，获取当前用户的服务商id
	 *
	 * @return 服务商id
	 */
	private String getCurrentSiteId() {
		User user = UserUtils.getUser();
		String Id = null;

		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			Id = siteService.findSiteIdByUserId(user.getId());
		}
		return Id;
	}

	/**
	 * 提供给客服查询的接口
	 **/
	@RequestMapping(value = "getOrderSimpleInfo")
	@ResponseBody
	public JSONObject getOrderSimpleInfo(HttpServletRequest request) {
		String orderNum = request.getParameter("orderNum");
		Map<String, Object> map = Maps.newHashMap();
		StringBuilder sb = new StringBuilder("");
		sb.append(" SELECT IFNULL(a.number, '') AS '工单编号', IFNULL(a.site_name, '') AS '网点名称', ");
		sb.append(" IFNULL((CASE a.status WHEN '0' THEN '待接收'  ");
		sb.append(" 	WHEN '1' THEN '待派工' ");
		sb.append(" 	WHEN '2' THEN '维修中' ");
		sb.append(" 	WHEN '3' THEN '待回访' ");
		sb.append(" 	WHEN '4' THEN '待结算' ");
		sb.append(" 	WHEN '5' THEN '已结单' ");
		sb.append(" 	WHEN '6' THEN '直接封单完成' ");
		sb.append(" 	WHEN '7' THEN '暂不派工' ");
		sb.append(" END), '') AS '工单状态', ");
		sb.append(
				"  IFNULL(a.create_time, '') AS '报修时间', IFNULL(a.appliance_category, '') AS '家电品类', IFNULL(a.customer_name, '') AS '用户姓名', IFNULL(a.customer_mobile, '') AS '用户电话', ");
		sb.append("   IFNULL(a.customer_address, '') AS '用户地址',  IFNULL(a.employe_name, '') AS '服务工程师', IFNULL(b.dispatch_time, '') AS '派工时间', IFNULL(b.end_time, '') AS '完工时间', ");
		sb.append("     IFNULL((CASE b.status  ");
		sb.append(" 	WHEN '1' THEN '待接单' ");
		sb.append(" 	WHEN '2' THEN '已接单待上门' ");
		sb.append(" 	WHEN '3' THEN '已拒单待派工' ");
		sb.append(" 	WHEN '4' THEN '已上门维修中（用于厂家工单）' ");
		sb.append(" 	WHEN '5' THEN '维修已完工(直接封单的厂家工单，派工状态均为5)' ");
		sb.append(" 	WHEN '6' THEN '转派，派工已取消' ");
		sb.append(" END), '') AS '派工状态', ");
		sb.append("     IFNULL(c.feedback_time, '') AS '反馈时间', IFNULL(d.create_time, '') AS '回访时间' ");
		sb.append("  FROM crm_order a  ");
		sb.append("  LEFT JOIN crm_order_dispatch b ON b.order_id = a.id ");
		sb.append("  LEFT JOIN crm_order_feedback c ON c.order_id = a.id ");
		sb.append("  LEFT JOIN crm_order_callback d ON d.order_id = a.id ");
		sb.append(" WHERE a.number like '%" + orderNum.trim() + "%' ");
		sb.append("  ");

		List<Record> rds = Db.find(sb.toString());

		JSONObject jo = JSONObject.fromObject(map);
		if (rds != null) {
			map.put("工单记录", rds.size() + "条");
			List<String> list = Lists.newArrayList();
			for (Record rd : rds) {
				String item = rd.toJson();
				list.add(item);
			}
			JSONArray ja = JSONArray.fromObject(list);
			jo.put("工单详情", ja);
		} else {
			map.put("工单记录", "无记录");
		}
		return jo;
	}

	@RequestMapping(value = "smsNotifyStatus")
	@ResponseBody
	public String snsNotify(HttpServletRequest request, HttpServletResponse response) {
		return SMSUtils.SMSStatusNotify(request);
	}

	@RequestMapping(value = "receiptStatus")
	@ResponseBody
	public String snsCallback(HttpServletRequest request, HttpServletResponse response) {
		String args = request.getParameter("args");
		SMSUtils.HandleReceiptStatus(args);

		return "ok";
	}

	/**
	 * 验证工单编号是否重复，最新的Validform推荐的返回格式。
	 */
	@RequestMapping(value = "checkOrderNo")
	@ResponseBody
	public HashMap<String, String> checkOrderNunber(@RequestParam("param") String orderNunber, @RequestParam(value = "sucmsg", required = false) String sucmsg) throws IOException {
		boolean status = orderNunber != null && systemService.getorderNumber(orderNunber, getCurrentSiteId()) == null;
		String _status = status ? "y" : "n";
		String msg = status ? (sucmsg == null ? "验证通过" : sucmsg) : "工单编号已存在";
		HashMap<String, String> ret = new HashMap<>();
		ret.put("status", _status);
		ret.put("info", msg);
		return ret;
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

	// 电话来电提醒工单

	/**
	 * http://localhost:8080/a/main/redirect/telephoneNotifyOrder?tel=15900832070&serialNo=3097818
	 */
	@RequestMapping(value = "telephoneNotifyOrder")
	public String telephoneNotifyOrder(HttpServletRequest req, HttpServletResponse response, Model model) {
		String telephone = req.getParameter("tel");
		String serialNo = req.getParameter("serialNo");

		if (telephone.length() > 11) {
			telephone = telephone.replace("-", "");
		}
		logger.info(String.format("telephoneNotifyOrder::tel=%s,serial=%s", telephone, serialNo));

		String page = req.getParameter("pageNo");
		if (!org.apache.commons.lang.StringUtils.isNumeric(page)) {
			page = "1";
		}
		int pageNo = StringUtil.isBlank(page) ? 1 : Integer.valueOf(page);
		long prevPageNo = pageNo > 1 ? pageNo - 1 : 1;
		if (StringUtils.isNotBlank(telephone) && StringUtils.isNotBlank(serialNo)) {
			OrderDetailsVo orderDetail = telNotifyOrderService.getTelephoneDeviceOrderList(serialNo, telephone, pageNo);
			Page<Record> page1 = orderDetail.getPage();
			long count = page1.getCount();
			long nextPageNo = pageNo >= count ? count : pageNo + 1;
			req.setAttribute("page", page1);// 历史工单信息
			req.setAttribute("img", orderDetail.getFeedbackImgs());// 图片信息
			Order order = orderDetail.getOrder();//
			req.setAttribute("order", order);
			req.setAttribute("unfinished", orderDetail.getUnfinishedOrderCount());
			req.setAttribute("finished", orderDetail.getFinishedOrderCount());
			req.setAttribute("cal", orderDetail.getCallback());
			req.setAttribute("fitti", orderDetail.getFittings());
			req.setAttribute("listdis", orderDetail.getDispatchList());
			req.setAttribute("settlement", orderDetail.getSettlement());
			req.setAttribute("callTimes", orderDetail.getCallTimes());
			req.setAttribute("details", orderDetail);
			req.setAttribute("feedback", orderDetail.getFeedback());
			req.setAttribute("pms", orderDetail.getPushMessages());
			req.setAttribute("feedbacks", orderDetail.getFeedbacks());
			req.setAttribute("prevPageNo", prevPageNo);
			req.setAttribute("nextPageNo", nextPageNo);
			req.setAttribute("tel", telephone);
			req.setAttribute("serialNo", serialNo);
			req.setAttribute("count", page1.getCount());
			req.setAttribute("infoMans", orderDetail.getInfoMans());// 信息员
			req.setAttribute("seriNo", serialNo);
			req.setAttribute("otime", orderDetail.getOtime());

			if (StringUtils.isNotBlank(order.getEmployeId())) {
				Map<String, Object> empmap = getOrderEmpMobiles(order.getEmployeId());

				model.addAttribute("empMobile", org.apache.commons.lang3.StringUtils.join(empmap.get("empmos"), ","));
				model.addAttribute("mapempMo", empmap.get("mobiles"));
			}

			if (order != null) {
				req.setAttribute("siteId", order.getSiteId());
				if (StringUtils.isNotBlank(order.getId()) && StringUtils.isNotBlank(order.getSiteId())) {
					Record rds = orderDispatchService.getOrderId(order.getId(), order.getSiteId());
					model.addAttribute("disOrder", rds);
					Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords(order.getId(), order.getSiteId());
					req.setAttribute("feedbackInfo", feedbackInfo);
					req.setAttribute("site", siteService.get(order.getSiteId()));
					req.setAttribute("serviceName", CrmUtils.getSignBySiteId(order.getSiteId()));
				}
				// 获取工程师手机号（用于短信催单）
				if (order.getEmployeId() != null && order.getEmployeId() != "") {
					if (!(order.getEmployeId().indexOf(",") > 0)) {
						Employe emp = employeService.get(order.getEmployeId());
						String mobile = "";
						if (emp != null) {
							mobile = emp.getMobile();
						}
						model.addAttribute("empMobile", mobile);
					} else {
						String empMs = "";
						String[] empIds = order.getEmployeId().split(",");
						for (int i = 0; i < empIds.length; i++) {
							if (i < empIds.length - 1) {
								Employe em = employeService.get(empIds[i]);
								if (em != null) {
									empMs += em.getMobile() != null ? em.getMobile() + "," : "";
								} else {
									logger.error(
											String.format("telephoneNotifyOrder::tel=%s,serial=%s,empid=%s,orderId=%s", telephone, serialNo, order.getEmployeId(), order.getId()));
								}
								// empMs+=employeService.get(empMobiles[i]).getMobile()!=null?employeService.get(empMobiles[i]).getMobile()+",":",";
							} else {
								Employe em = employeService.get(empIds[i]);
								if (em != null) {
									empMs += em.getMobile();
								} else {
									logger.error(
											String.format("telephoneNotifyOrder::tel=%s,serial=%s,empid=%s,orderId=%s", telephone, serialNo, order.getEmployeId(), order.getId()));
								}
								// empMs+=employeService.get(empMobiles[i]).getMobile()!=null?employeService.get(empMobiles[i]).getMobile():"";
							}
						}
						model.addAttribute("empMobile", empMs);
					}
				}
			}
		}
		return "modules/sys/callShowDatail/callShow";
	}

	// 新建工单
	@RequestMapping(value = "newBuildOrder")
	public String newBuildOrder(HttpServletRequest request, Model model) {
		String orId = request.getParameter("id");
		String otime = request.getParameter("otime");
		String seriNo = request.getParameter("seriNo");
		String telephone = request.getParameter("tel");
		String siteId = null;
		Site site = null;

		List<Record> provincelist = CrmUtils.getProvinceList();
		List<Record> cities = null;
		List<Record> districts = null;

		if ("0".equals(otime)) {
			Order order = orderService.get(orId);
			siteId = order.getSiteId();
			site = siteService.get(siteId);
			Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
			List<Record> category = CategoryUtils.getListCategorySite(siteId);
			List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
			model.addAttribute("listorigin", listOrigin);
			model.addAttribute("category", category);
			model.addAttribute("brand", brand);
			model.addAttribute("order", order);
			model.addAttribute("Username", order.getMessengerName());
			// 信息员
			List<Record> infomans = nonServicemanService.getInfoMans(siteId);
			model.addAttribute("infomans", infomans);

			int wnsize = 0;
			List<Record> towns = townshipService.getTownshipSiteId(siteId);
			if (towns != null) {
				model.addAttribute("township", towns);
				wnsize = towns.size();
			}
			model.addAttribute("wnsize", wnsize);

			cities = CrmUtils.getCityList(site.getProvince());
			districts = CrmUtils.getDistrictList(site.getCity());

			if (StringUtils.isNotBlank(order.getProvince()) && StringUtils.isNotBlank(order.getCity()) && StringUtils.isNotBlank(order.getArea())) {
				cities = CrmUtils.getCityList(order.getProvince());
				districts = CrmUtils.getDistrictList(order.getCity());
			}
		} else if ("1".equals(otime)) {
			
			siteId = telNotifyOrderService.getOrderSiteBySerialNo(seriNo);
			HistoryBkOrder order = new HistoryBkOrder(orderService.get2017(orId,siteId));
			site = siteService.get(siteId);
			model.addAttribute("order", order);
			model.addAttribute("Username", order.getMessengerName());
			// 信息员
			List<Record> infomans = nonServicemanService.getInfoMans(siteId);
			model.addAttribute("infomans", infomans);

			int wnsize = 0;
			List<Record> towns = townshipService.getTownshipSiteId(siteId);
			if (towns != null) {
				model.addAttribute("township", towns);
				wnsize = towns.size();
			}
			model.addAttribute("wnsize", wnsize);

			cities = CrmUtils.getCityList(site.getProvince());
			districts = CrmUtils.getDistrictList(site.getCity());
			if (StringUtils.isNotBlank(order.getProvince()) && StringUtils.isNotBlank(order.getCity()) && StringUtils.isNotBlank(order.getArea())) {
				cities = CrmUtils.getCityList(order.getProvince());
				districts = CrmUtils.getDistrictList(order.getCity());
			}
		} else {
			throw new RuntimeException(" otime no exit ");
		}

		Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
		List<Record> category = CategoryUtils.getListCategorySite(siteId);
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
		model.addAttribute("listorigin", listOrigin);
		model.addAttribute("category", category);
		model.addAttribute("brand", brand);
		/* 必填设置 */
		List<Record> mustFillInfoList = Db.find("select * from crm_order_mustfill_setting where site_id=? and type=0 ", siteId);
		Record mustfill = new Record();
		for (Record rec : mustFillInfoList) {
			Boolean rsu = changeFrom(rec.getStr("status"));
			mustfill.set(rec.getStr("name"), rsu);
		}
		if (mustFillInfoList.size() < 1) {
			mustfill.set("customerFeedback", true);
		}
		model.addAttribute("mustfill", mustfill);

		Date curDate = new Date();
		// String orderId = sdf.format(curDate) + curDate.getTime() % 1000;
		model.addAttribute("number", RandomUtil.randomOrderNumber());
		// 获取来源
		List<Record> list = orderService.getOrderType();
		model.addAttribute("ordertype", list);
		model.addAttribute("curDate", curDate);
		model.addAttribute("seriNo", seriNo);
		model.addAttribute("telephone", telephone);

		// 获取服务类型
		List<Record> rds = ServiceTypeDao.getServiceTypeList(siteId);
		model.addAttribute("ServiceType", rds);

		// 服务方式
		// String sql2 = "SELECT * FROM crm_service_mode a WHERE a.status ='0' and
		// a.site_id=? ORDER BY a.sort ASC ";
		List<Record> rds2 = ServiceModeDao.getNewServiceModeList(siteId);
		model.addAttribute("getServiceMode", rds2);

		/* 用户类型 */
		List<Record> type = CustomerTypeDao.getCustomerTypeList(siteId);
		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
		model.addAttribute("getCustomerType", type);

		// 购机商场
		List<Record> malllist = orderMallService.getlist(siteId);
		model.addAttribute("malllist", malllist);

		// 登记人
		String s = "select * from crm_site_tele_device where serial_no='" + seriNo + "' and status='0' ";
		Record reco = Db.findFirst(s);
		String ss = "select * from crm_site where id='" + reco.getStr("site_id") + "' ";
		Record recor = Db.findFirst(ss);
		model.addAttribute("sitename", recor.getStr("name"));
		model.addAttribute("orderNumSet", siteMsgService.ifOpenOrderSet(reco.getStr("site_id")));

		model.addAttribute("provincelist", provincelist);
		model.addAttribute("cities", cities);
		model.addAttribute("districts", districts);
		model.addAttribute("site", site);

		if ("0".equals(telephone.substring(0, 1))) {
			model.addAttribute("telorMob", "tel");
		} else {
			model.addAttribute("telorMob", "mob");
		}
		return "modules/" + "sys/callShowDatail/buildNewOrder";
	}

	@ResponseBody
	@RequestMapping(value = "getproLimitList")
	public Object getproLimitList() {
		// 时间要求
		List<Record> listli = orderDispatchService.getAllProLimit(new ArrayList<Record>());
		List<String> listStr = Lists.newArrayList();
		for (int i = 0; i < listli.size(); i++) {
			listStr.add(listli.get(i).getStr("name"));
		}
		return listStr;
	}

	// 新建工单(无工单时)
	@RequestMapping(value = "newBuildOrderWhenNull")
	public String newBuildOrderWhenNull(HttpServletRequest request, Model model) {
		Order order = new Order();
		Site site = new Site();
		String telephone = request.getParameter("tel");
		String serialNo = request.getParameter("serialNo");
		logger.info("....new build order when null called, telephone is:" + telephone + ";serial.no=" + serialNo);
		order.setCustomerMobile(telephone);
		String sql = "select * from crm_site_tele_device where serial_no='" + serialNo + "' and status='0' ";
		Record re = Db.findFirst(sql);
		if (re == null) {
			return "modules/sys/callShowDatail/unbind";
		}

		if ("0".equals(telephone.substring(0, 1))) {
			model.addAttribute("telorMob", "tel");
		} else {
			model.addAttribute("telorMob", "mob");
		}

		Map<String, String> brand = BrandUtils.getSiteBrand(re.getStr("site_id"), null);

		List<Record> category = CategoryUtils.getListCategorySite(re.getStr("site_id"));

		Date curDate = new Date();
		// String orderId = sdf.format(curDate) + curDate.getTime() % 1000;
		model.addAttribute("number", RandomUtil.randomOrderNumber());// 工单编号

		// 信息来源
		List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(re.getStr("site_id"));
		model.addAttribute("listorigin", listOrigin);
		// 获取来源
		model.addAttribute("curDate", curDate);
		model.addAttribute("category", category);
		model.addAttribute("brand", brand);
		model.addAttribute("order", order);
		model.addAttribute("seriNo", serialNo);
		model.addAttribute("telephone", telephone);
		model.addAttribute("returnModel", 1);

		// 登记人
		String s = "select * from crm_site_tele_device where serial_no='" + serialNo + "' and status='0' ";
		Record reco = Db.findFirst(s);
		String ss = "select * from crm_site where id='" + reco.getStr("site_id") + "' ";
		Record recor = Db.findFirst(ss);
		model.addAttribute("sitename", recor.getStr("name"));

		// 信息员
		List<Record> infomans = nonServicemanService.getInfoMans(reco.getStr("site_id"));
		model.addAttribute("infomans", infomans);
		String siteId = "";
		site = siteService.get(reco.getStr("site_id"));
		model.addAttribute("site", site);
		siteId = site.getId();
		int wnsize = 0;
		List<Record> towns = townshipService.getTownshipSiteId(siteId);
		if (towns != null) {
			model.addAttribute("township", towns);
			wnsize = towns.size();
		}
		model.addAttribute("wnsize", wnsize);
		model.addAttribute("orderNumSet", siteMsgService.ifOpenOrderSet(siteId));

		/* 必填设置 */
		List<Record> mustFillInfoList = Db.find("select * from crm_order_mustfill_setting where site_id=? and type=0 ", siteId);
		Record mustfill = new Record();
		for (Record rec : mustFillInfoList) {
			Boolean rsu = changeFrom(rec.getStr("status"));
			mustfill.set(rec.getStr("name"), rsu);
		}
		if (mustFillInfoList.size() < 1) {
			mustfill.set("customerFeedback", true);
		}
		model.addAttribute("mustfill", mustfill);

		List<Record> provinceList = CrmUtils.getProvinceList();
		List<Record> cities = CrmUtils.getCityList(site.getProvince());
		List<Record> districts = CrmUtils.getDistrictList(site.getCity());
		model.addAttribute("provincelist", provinceList);
		model.addAttribute("cities", cities);
		model.addAttribute("districts", districts);

		// 购机商场
		List<Record> malllist = orderMallService.getlist(siteId);
		model.addAttribute("malllist", malllist);

		// 获取服务类型
		List<Record> rds = ServiceTypeDao.getServiceTypeList(siteId);
		model.addAttribute("ServiceType", rds);

		// 服务方式
		List<Record> rds2 = ServiceModeDao.getNewServiceModeList(siteId);
		model.addAttribute("getServiceMode", rds2);

		/* 用户类型 */
		List<Record> type = CustomerTypeDao.getCustomerTypeList(siteId);
		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
		model.addAttribute("getCustomerType", type);

		return "modules/" + "sys/callShowDatail/buildNewOrder";
	}

	private Boolean changeFrom(String op) {
		return "0".equals(op);
	}

	// 工单入库及派工
	@RequestMapping(value = "save")
	public Object save(Order or, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		String seriNo = request.getParameter("seriNo");
		String mobile = or.getCustomerMobile();
		String s = "select * from crm_site_tele_device where serial_no='" + seriNo + "' and status='0' ";
		Record reco = Db.findFirst(s);
		String siteId = reco.getStr("site_id");
		String code = siteMsgService.ifOpenOrderSet(siteId);
		if ("200".equals(code)) {
			OrderNo odn = CrmUtils.genOrderNo(siteId);
			if (odn != null) {
				or.setNumber(odn.getData());
				or.setSeq(odn.getSeq());
			}
		}
		Long count = Db.queryLong("select count(1) as cnt from crm_order where number=? and site_id=?", or.getNumber(), siteId);
		if (count > 0) {
			return "420";
		}
		if (mobile.length() > 11) {
			mobile = mobile.replace("-", "");
			or.setCustomerMobile(mobile);
		}
		orderService.callShowSave(or, seriNo);
		orderService.onOrderCountChanged(siteId, OrderCountChangeTypes.TYPE_zjpg);
		return or;
	}

	// 显示转派
	@ResponseBody
	@RequestMapping(value = "count2")
	public Long count2(String orderId, HttpServletRequest request, HttpServletResponse response) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return orderService.getPjMsg1(orderId, siteId);
	}

	/*
	 * 来电弹屏中转派工单
	 */
	@RequestMapping(value = "RedispatchCallBack")
	@ResponseBody
	public Boolean RedispatchCallBack(Model model, HttpServletRequest request, HttpServletResponse response) {
		String employeId = request.getParameter("empId");
		String orderId = request.getParameter("orderId");
		String disId = request.getParameter("disorderId");
		String transferReasons = request.getParameter("transferReasons");
		String noId = request.getParameter("noId");
		boolean proving = true;
		try {
			orderDispatchService.TurntosendCallBack(orderId, employeId, disId, transferReasons, noId);
		} catch (Exception e) {
			e.printStackTrace();
			proving = false;
		}
		return proving;
	}

	/*
	 * 来电弹屏（服务商剩余短信条数）
	 */
	@ResponseBody
	@RequestMapping(value = "callBackRemainMsgNum")
	public Record callBackRemainMsgNum(HttpServletRequest request, HttpServletResponse response) {
		String siteId = request.getParameter("siteId");
		return orderService.getRemainMsgNum(siteId);
	}

	/*
	 * 短信条数
	 */
	@ResponseBody
	@RequestMapping(value = "msgNumbers")
	public Integer getMsgNumbers(String content, String sign, HttpServletRequest request, HttpServletResponse response) {
		return orderService.getMsgNumbers(content, sign, "");
	}

	/*
	 * 服务中短信通知(自定义模板)
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsg")
	public String getFwzSendmsg(String noId, String siteId, String content, String sign, String orderMsgMobile, String orderMsgId, HttpServletRequest request,
			HttpServletResponse response) {
		String ds = orderService.callShowSendmsg(noId, content, sign, orderMsgMobile, siteId, orderMsgId);
		return ds;
	}

	/*
	 * 短信通知（短信模板）
	 */
	@ResponseBody
	@RequestMapping(value = "fwzSendmsgModel")
	public String getFwzSendmsgModel(String noId, String temId, String siteId, String sign, String content, String extno, String orderId, String customerMobile, String orderMsgId,
			HttpServletRequest request, HttpServletResponse response) {
		return orderService.getCallFwzSendmsgModel(noId, temId, sign, content, extno, orderId, customerMobile, siteId);
	}

	/*
	 * 根据id获取tag 短信发送
	 */
	@ResponseBody
	@RequestMapping(value = "getTag")
	public List<Record> getTag(String tag, HttpServletRequest request, HttpServletResponse response) {
		return Db.find("select * from sys_sms_template a where a.tag='" + tag + "' order by a.id");
	}

	/**
	 * 来电弹屏
	 */

	@RequestMapping(value = "ajaxTelephoneOrder", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject ajaxTelephoneOrder(HttpServletRequest req) {
		String telephone = req.getParameter("tel");
		String serialNo = req.getParameter("serialNo");
		logger.info("ajax tel order,tel=" + telephone + "serial.no=" + serialNo);

		Map<String, Object> result = Maps.newHashMap();
		result.put("result", 0);
		if (StringUtils.isNotBlank(telephone) && StringUtils.isNotBlank(serialNo)) {
			customerTelephoneIncomeService.save(telephone, serialNo);
			long count = telNotifyOrderService.getTelephoneDeviceOrderCount(serialNo, telephone);
			if (count > 0) {
				result.put("result", count);
				// result.put("p",
				// String.format("http://www.sifangerp.com/main/redirect/telephoneNotifyOrder?tel=%s&serialNo=%s",
				// telephone, serialNo));
				// result.put("p",
				// String.format("http://192.168.2.58:8080/a/main/redirect/telephoneNotifyOrder?tel=%s&serialNo=%s",
				// telephone, serialNo));
				result.put("p", String.format("http://www.sifangerp.cn/order2.0/a/main/redirect/telephoneNotifyOrder?tel=%s&serialNo=%s", telephone, serialNo));
			} else {
				result.put("result", 0);
				// result.put("p",
				// String.format("http://www.sifangerp.com/main/redirect/newBuildOrder?tel=%s&serialNo=%s",
				// telephone, serialNo));
				result.put("p", String.format("http://www.sifangerp.cn/order2.0/a/main/redirect/newBuildOrderWhenNull?tel=%s&serialNo=%s", telephone, serialNo));
			}
		}
		return JSONObject.fromObject(result);
	}

	@RequestMapping(value = "telephoneTurn")
	public String telephoneTurn(@RequestParam(value = "page", defaultValue = "1") int pageNo, HttpServletRequest request, HttpServletResponse response) {
		// 查询第一条历史工单信息(分页查询每次一页)
		String telephone = request.getParameter("tel");// 获取手机号码
		String serialNo = request.getParameter("tel");// 获取设备序列号
		String pageNO = request.getParameter("tel");// 获取页码

		// telNotifyOrderService.getTelephoneDeviceOrderList(serialNo, telephone,
		// pageNO);

		return "modules/sys/callShowDatail/callShow";
	}

	/**
	 * 直接派工时，需要显示网点的所有服务工程师。
	 */
	@ResponseBody
	@RequestMapping(value = "dispatchList")
	public Object getEmployeList(HttpServletRequest request) {
		User user = UserUtils.getUser();
		String lnglat = request.getParameter("lnglat");
		String category = request.getParameter("category");
		String seriNo = request.getParameter("seriNo");
		String id = null;
		// 空调 、冰箱、热水器、电视、油烟机、洗衣机、小家电
		// String [] cate = {"空调","冰箱","热水器","电视","油烟机","洗衣机","小家电"};

		String s = "select * from crm_site_tele_device where serial_no='" + seriNo + "' and status='0' ";
		Record reco = Db.findFirst(s);
		String siteId = reco.getStr("site_id");
		if (StringUtils.isEmpty(category)) {
		} else {
			id = CategoryUtils.getSiteCategoryId1(category, siteId);
		}
		return employeService.getEmployeOrder2(siteId, lnglat, id, null);
	}

	@RequestMapping(value = "getBrand")
	public void getBrand(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter write;
		try {
			write = response.getWriter();
			String category = request.getParameter("category");
			String seriNo = request.getParameter("seriNo");

			String s = "select * from crm_site_tele_device where serial_no='" + seriNo + "' and status='0' ";
			Record reco = Db.findFirst(s);
			String siteId = reco.getStr("site_id");

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

	@RequestMapping(value = "getCategory")
	public void getCategory(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter write;
		String brand = request.getParameter("brand");
		String seriNo = request.getParameter("seriNo");
		try {
			write = response.getWriter();
			String s = "select * from crm_site_tele_device where serial_no='" + seriNo + "' and status='0' ";
			Record reco = Db.findFirst(s);
			String siteId = reco.getStr("site_id");

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

	@RequestMapping(value = "order")
	public String list(Order data, HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		Order order = null;
		if (StringUtils.isNotBlank(orderId)) {
			order = orderService.get(orderId);
			// 查询额外的信息
			StringBuilder sb = new StringBuilder("");
			sb.append(" SELECT a.service_attitude,c.name as siteName, c.mobile,c.sms_phone, d.end_time,d.dispatch_time ");
			sb.append(" FROM crm_order co LEFT JOIN crm_order_callback a ON a.order_id = co.id ");
			sb.append(" left join crm_order_dispatch d on d.order_id = co.id and d.status != '6' and d.status != '3' ");
			sb.append(" LEFT JOIN crm_site c ON c.id = co.site_id ");
			sb.append(" WHERE co.id = '" + orderId + "' ");
			sb.append(" ORDER BY a.create_time DESC  LIMIT 1 ");
			Record rd = Db.findFirst(sb.toString());
			model.addAttribute("rd", rd);
			model.addAttribute("order", order);
		} else {
			model.addAttribute("order", data);
		}
		return "modules/order/print/sfPrint";
	}

	// 根据省获取市
	@ResponseBody
	@RequestMapping(value = "getCity1")
	public String getCity1(HttpServletRequest request, HttpServletResponse response) {
		String province = request.getParameter("province");
		List<Record> list = CrmUtils.getCityList(province);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}

	// 根据市获取区县
	@ResponseBody
	@RequestMapping(value = "getArea1")
	public String getArea1(HttpServletRequest request, HttpServletResponse response) {
		String city = request.getParameter("city");
		List<Record> list = CrmUtils.getDistrictList(city);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}

	/* 注册 */
	@RequestMapping(value = "sgUp")
	public String sgUp(HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Record> provincelist = siteMsgService.getprovincelist();
		List<Record> cities = siteMsgService.getCities();
		List<Record> districts = siteMsgService.getDistrincts();
		model.addAttribute("cities", cities);
		model.addAttribute("districts", districts);
		model.addAttribute("provincelist", provincelist);
		String origin = request.getParameter("origin");
		if ("jdxh".equals(origin)) {
			return "modules/base/partner/signUp";
		}
		return "modules/base/signUp";
	}

	@ResponseBody
	@RequestMapping("sendMsg")
	public String sendMsg(String mobile, HttpServletRequest request, HttpServletResponse response) {
		String code = siteMsgService.getCode();
		request.getSession().setAttribute("confirmCode", code);
		return siteMsgService.zcCheckMobile(mobile, code);
	}

	@ResponseBody
	@RequestMapping("sendMsg1")
	public String sendMsg1(String mobile, HttpServletRequest request, HttpServletResponse response) {
		String code = siteMsgService.getCode();
		request.getSession().setAttribute("confirmCode1", code);
		return siteMsgService.xgmaCheckMobile(code, mobile);
	}

	@ResponseBody
	@RequestMapping("registerSign")
	public String register(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Object confirmCode = request.getSession().getAttribute("confirmCode");
		if (confirmCode == null) {
			logger.error("registerSign::confirm code is null");
			return "wrongMsg";
		}
		String msgCode = confirmCode.toString();
		return siteMsgService.registerSign(map, msgCode);
	}

	@ResponseBody
	@RequestMapping(value = "checkSiteName")
	public String checkSiteName(String name, HttpServletRequest request, HttpServletResponse response) {
		return siteMsgService.checkSiteName(name);
	}

	@RequestMapping(value = "resertMsg")
	public void resertMsg(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("confirmCode", "");
	}

	/* 重置密码 */
	@RequestMapping(value = "toResertPwd")
	public String toResertPwd(HttpServletRequest request, HttpServletResponse response, Model model) {
		String origin = request.getParameter("origin");
		if ("jdxh".equals(origin)) {
			return "modules/base/partner/resertPwd";
		}
		return "modules/base/resertPwd";
	}

	@ResponseBody
	@RequestMapping(value = "resertPwd")
	public String resertPwd(String mobile, String password, String msgCheck, HttpServletRequest request, HttpServletResponse response) {
		String msgCode = request.getSession().getAttribute("confirmCode1").toString();
		return siteMsgService.resertPwd(mobile, password, msgCode, msgCheck);
	}

	@RequestMapping(value = "getPlatformGoodsHtmlById")
	public String getPlatformGoodsHtmlById(HttpServletRequest request, HttpServletResponse response, Model model) {
		String goodId = request.getParameter("goodId");
		String html = siteMsgService.getPlatformGoodsHtmlById(goodId);
		model.addAttribute("htmlContent", html);
		return "modules/rest/restGoodsDetail";
	}

	@RequestMapping(value = "getHtmlById")
	public String getHtmlById(HttpServletRequest request, HttpServletResponse response, Model model) {
		String goodId = request.getParameter("goodId");
		String html = siteMsgService.getHtmlById(goodId);
		model.addAttribute("htmlContent", html);
		return "modules/rest/restGoodsDetail";
	}

	@RequestMapping(value = "openVIPSign")
	public String openVIPSign(HttpServletRequest request, HttpServletResponse response, Model model) {
		String mobile = request.getParameter("mobile");
		model.addAttribute("mobile", mobile);
		return "modules/base/openVIPSign";
	}

	/* 网点开通收费版，点击立即支付生成订单 */
	@ResponseBody
	@RequestMapping(value = "scPlatOrderSign")
	public Map<String, Object> scPlatOrder(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = request.getParameterMap();
		Object confirmCode = request.getSession().getAttribute("confirmCode");
		if (confirmCode == null) {
			logger.error("registerSign::confirm code is null");
		}
		String msgCode = confirmCode.toString();
		OrderContext orderContext = new OrderContext(request);
		return siteMsgService.registerSign1(map, msgCode, orderContext);
	}

	@ResponseBody
	@RequestMapping(value = "getSiteSign")
	public Record getSite(HttpServletRequest request, HttpServletResponse response) {
		String mobile = request.getParameter("mobile");
		return sitePlatformGoodsService.getSiteMessage1(mobile);
	}

	/**
	 * html预览的html内容,id对应的siteself的ID,type 0商品
	 */
	@RequestMapping(value = "goodsPreview")
	public String goodsPreview(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		Record rd = Db.findFirst(" select preview_html from crm_goods_siteself a where a.id = ? ", id);
		String html = "";
		if (rd != null) {
			html = rd.getStr("preview_html");
		}
		model.addAttribute("htmlContent", html);
		return "modules/rest/restGoodsDetailView";
	}

	@RequestMapping(value = "saveGoodsPreview")
	@ResponseBody
	public String saveGoodsPreview(HttpServletRequest request, HttpServletResponse response, Model model) {
		String html = request.getParameter("htmlContent");
		String id = request.getParameter("id");
		if (StringUtils.isNotBlank(id)) {
			Db.update("update crm_goods_siteself set preview_html = ? where id = ?", html, id);
		}
		return "ok";
	}

	@RequestMapping("cancel")
	@ResponseBody
	public Object cancelOrder(HttpServletRequest request) {
		String payType = request.getParameter("type");
		String outTradeNo = request.getParameter("outTradeNo");
		UnifyOrderService service = UniPayOrderServiceFactory.getUnipayOrderService(payType);
		if (StringUtils.isNotBlank(outTradeNo)) {
			service.cancelOrder(outTradeNo);
		}
		return Result.ok();
	}

	@RequestMapping("status")
	@ResponseBody
	public Object queryOrderStatus(HttpServletRequest request) {
		String payType = request.getParameter("type");
		String outTradeNo = request.getParameter("outTradeNo");
		UnifyOrderService service = UniPayOrderServiceFactory.getUnipayOrderService(payType);
		Map<String, Object> ret = new HashMap<>();
		if (StringUtils.isNotBlank(outTradeNo)) {
			TradeStatus status = service.queryOrderStatus(outTradeNo);
			if (TradeStatus.SUCCESS == status || TradeStatus.FINISHED == status) {
				ret.put("paid", "paid");
			} else {
				ret.put("status", status.toString());
			}
		}
		return ret;
	}

	@RequestMapping("upd/path/header")
	@ResponseBody
	public String updatePathHeaders(HttpServletRequest request) {
		String path = request.getParameter("path");
		String header = request.getParameter("header");
		String excelTitle = request.getParameter("excel_title");
		String sig = request.getParameter("sig");
		logger.error("path=" + path + ";header=" + header);
		String calcSig = null;
		try {
			calcSig = Hex.encodeHexString(DigestUtils.sha1((path + header + excelTitle).getBytes("utf-8")));
		} catch (UnsupportedEncodingException e) {
			// Intentionally ignore
		}
		if (calcSig == null || !calcSig.equals(sig)) {
			logger.error("sig error");
			return "XX";
		}

		Record r = Db.findFirst("select * from `crm_site_default_table_header` where `path`=?", path);
		if (r == null) {
			int nextId = Db.queryInt("select max(id) as maxid from `crm_site_default_table_header`") + 1;
			Db.update("insert into `crm_site_default_table_header`(`id`,`path`,`header`,`excel_title`) values(?,?,?,?)", nextId, path, header, excelTitle);
			return "OC";
		} else {
			Db.update("update `crm_site_default_table_header` set `header`=?,`excel_title`=? where `path`=?", header, excelTitle, path);
			return "OK";
		}
	}

	@ResponseBody
	@RequestMapping("gen/share")
	public String genShare() {
		int gens = siteService.genShareCode();
		return String.valueOf(gens);
	}

	// 弹出奥莱家电的弹框
	@RequestMapping(value = "showAolai")
	public String showAolai(Model model) {
		return "modules/base/goAolai"; // 弹出奥莱页面
	}

	/*
	 * 处理线上考勤遗留数据问题（一次性）
	 */
	@ResponseBody
	@RequestMapping(value = "dealEmployeSignTime")
	public String delaEmployeSignTime(HttpServletRequest request, HttpServletResponse response) {
		employeDailySignService.delaEmployeSignTime();
		return "200";
	}

	// 没有权限的页面
	@RequestMapping(value = "noAuthPage")
	public String noAuthPage(Model model) {
		return "modules/sys/noAuthPage"; // 弹出奥莱页面
	}

	/**
	 * 接收厂家账号，数据内容为json，包含：login_name/password/site_id/name四个字段
	 */
	@RequestMapping(value = "addFactoryAccount")
	@ResponseBody
	public FlagResult<String> addFactoryAccount(HttpServletRequest request) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.CAMEL_CASE_TO_LOWER_CASE_WITH_UNDERSCORES);
		InputStream in = null;

		Map<String, String> codeToNameMapping = new HashMap<>();
		codeToNameMapping.put("gree", "格力");
		codeToNameMapping.put("tcl", "TCL");
		codeToNameMapping.put("aux", "奥克斯");
		codeToNameMapping.put("gome", "国美");
		codeToNameMapping.put("haier2", "海尔");
		codeToNameMapping.put("hisense", "海信");
		codeToNameMapping.put("jd", "京东");
		codeToNameMapping.put("meling", "美菱");
		codeToNameMapping.put("midea", "美的");
		codeToNameMapping.put("haier", "旧版海尔");
		codeToNameMapping.put("suning", "苏宁");
		codeToNameMapping.put("whirlpool", "惠而浦");

		try {
			in = request.getInputStream();
			SiteVendorAccountForm form = mapper.readValue(in, SiteVendorAccountForm.class);
			String nameCode = form.getName();
			form.setName(codeToNameMapping.get(nameCode));
			return sitetVenderAccountService.save(form);
		} catch (IOException e) {
			logger.error("read input failed", e);
		} finally {
			IOUtils.closeQuietly(in);
		}
		FlagResult<String> ret = new FlagResult<>();
		ret.setMsg("read input stream failed");
		ret.setCode("422");
		ret.setData("");
		ret.setFlag("addFactoryAccount");
		return ret;
	}

	@RequestMapping(value = "delFactoryAccount")
	@ResponseBody
	public FlagResult<Void> delFactoryAccount(HttpServletRequest request) {
		String siteVendorAccountId = request.getParameter("id");
		logger.info("about to del site vendor account id: " + siteVendorAccountId);
		if (StringUtil.isBlank(siteVendorAccountId)) {
			FlagResult<Void> errRet = FlagResult.fail("422", "site vendor account id required");
			errRet.setFlag("delFactoryAccount");
			return errRet;
		}
		sitetVenderAccountService.delOne(siteVendorAccountId);
		FlagResult<Void> ok = FlagResult.ok();
		ok.setFlag("delFactoryAccount");
		return ok;
	}

	@RequestMapping(value = "modFactoryAccount")
	@ResponseBody
	public FlagResult<Void> modFactoryAccount(@RequestBody Map<String, String> params) {
		return sitetVenderAccountService.modifyAccount(params);
	}

	@RequestMapping(value = "statSource")
	@ResponseBody
	public Object statSource() {
		return OrderController.fromMap;
	}

	@RequestMapping(value = "cleanCache")
	@ResponseBody
	public Result<Void> clearOrderCountCache() {
		Result<Void> ret = new Result<>();
		List<Record> sites = Db.find("select id from crm_site as s where s.status='0'");
		for (Record r : sites) {
			orderService.onOrderCountChanged(r.getStr("id"), "clean cache");
		}
		ret.setCode("200");
		return ret;
	}

	/*
	 * 慧营销中获取服务商，按名称搜索
	 */
	@ResponseBody
	@RequestMapping(value = "getTraderSiteList")
	public JSONObject getTraderSiteList(HttpServletRequest request, HttpServletResponse response) {
		String name = request.getParameter("siteName");
		String ids = request.getParameter("siteIds");

		List<Record> rds = SiteDao.getTraderSiteList(name, ids);
		if (rds.size() > 0) {
			TraderSiteForm st = new TraderSiteForm();
			st.setList(rds);
			return JSONObject.fromObject(st);
		}
		return null;
	}

	/**
	 * 短信回复回调接口
	 */
	@ResponseBody
	@RequestMapping(value = "addReceivedMsg",method = RequestMethod.POST)
	public JSONObject addReceivedMsg(HttpServletRequest request) {
		Map<String, Object> map = getParams(request);
		receivedSmsService.addDRveivedMsg(map);
		JSONObject user2 = new JSONObject();
		user2.put("code", "0");
		user2.put("msg", "SUCCESS");
		return user2;
	}
	/**
	 * 短信发送回调接口
	 */
	@ResponseBody
	@RequestMapping(value = "changeSmsSendStatus",method = RequestMethod.POST)
	public JSONObject changeSmsSendStatus(HttpServletRequest request) {
		Map<String, Object> map = getParams(request);
		smsService.changeSendMsgStatus(map);
		JSONObject user2 = new JSONObject();
		user2.put("code", "0");
		user2.put("msg", "SUCCESS");
		return user2;
	}

	/**
	 * 短信模板、签名设置回调
	 */
	@ResponseBody
	@RequestMapping(value = "addSignOrTempPort",method = RequestMethod.POST)
	public JSONObject addSignOrTempPort(HttpServletRequest request) {
		Map<String, Object> map = getParams(request);
		logger.info("短信模板与签名设置：data" + map.toString());
		smsService.templeteSet(map);
		JSONObject user2 = new JSONObject();
		user2.put("code", "0");
		user2.put("msg", "SUCCESS");
		return user2;
	}

}
