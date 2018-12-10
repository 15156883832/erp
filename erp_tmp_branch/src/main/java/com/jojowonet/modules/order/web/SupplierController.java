package com.jojowonet.modules.order.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.entity.mysql.common.Role;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.IdGen;
import ivan.common.utils.MD5;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Brand;
import com.jojowonet.modules.order.entity.Supplier;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.SupplierService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.sys.service.SystemService;
import com.jojowonet.modules.sys.web.UserController;

@Controller
@RequestMapping(value = "${adminPath}/order/supplier")
public class SupplierController extends BaseController {
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private UserDao userDao;


	@RequestMapping(value = { "list", "" })
	public String list(Brand brand, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
				siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/supplierlist";
	}

	@RequestMapping(value = "supplierList")
	@ResponseBody
	public String brandsettleListList(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Record> page = new Page<>(request, response);
		page = supplierService.findsupplier(page);
		model.addAttribute("page", page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}

	// 跳转到添加供应商页面
	@RequestMapping(value = "form")
	public String form(Model model) {
		List<Record> goodslist = supplierService.getAllPlatGoods();
		model.addAttribute("goodslist", goodslist);
		return "modules/" + "order/supplierForm";
	}

	@RequestMapping("querysupplierById")
	public void querysupplierById(String name, String loginName,
			String supplierid, String userId, HttpServletResponse response) {
		boolean flag = false;
		flag = supplierService.querySupplierById(name, supplierid, loginName,
				userId);
		Map<String, Boolean> map = Maps.newHashMap();
		map.put("flag", flag);
		try {
			response.getWriter().print(JSONObject.fromObject(map));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 保存供应商信息包括保存登陆信息和基本信息
	@RequestMapping(value = "addsupplier")
	@ResponseBody
	public String addsupplier(@RequestBody String param) {
		String result="ok";
		result=supplierService.save(param);
		return result;
	}

	// 删除供应商信息
	@RequestMapping("deletesuppier")
	public String deleteSupplier(String id) {
		String userId = supplierService.findSupplierById(id).getStr("user_id");
		supplierService.deleteSupplier(id, userId);

		return null;
	}

	// 跳转到修改页面
	@RequestMapping("editesupplier")
	public String toEdite(String id, Model model) {
		Record rd = supplierService.findSupplierGoodsById(id);
		List<String> goodslist = Arrays.asList(rd.getStr("goods"));
		Record user = supplierService.findUserById(rd.getStr("userId"));
		model.addAttribute("supplier", rd);
		model.addAttribute("goodslist", goodslist);
		model.addAttribute("user", user);
		List<Record> allGoodslist = supplierService.getAllPlatGoods();
		model.addAttribute("allGoodslist", allGoodslist);
		return "modules/" + "order/supplierEdite";

	}
//修改信息包括user的信息和供应商的信息
	@RequestMapping("updatesupplier")
	@ResponseBody
	public String updateSupplier(String name, String loginName, String password,
			String contactor, String mobile, String remarks,
			String[] goodslist, String supplierid, String userId) {
		String result="ok";
		result=supplierService.updateById(name,contactor,mobile,remarks,goodslist,supplierid,userId);
		supplierService.updateUserById(loginName,password,mobile,userId);
		return result;

	}

}
