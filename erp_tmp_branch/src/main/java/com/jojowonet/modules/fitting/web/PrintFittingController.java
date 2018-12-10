package com.jojowonet.modules.fitting.web;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.FittingDao;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.OldFitting;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Parameter;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/printFitting")
public class PrintFittingController extends BaseController{
	@Autowired
	private FittingDao fittingDao;
	
	@RequestMapping(value="printStock")
	public String printStock(String id,HttpServletRequest request,HttpServletResponse response,Model model){
		String number = request.getParameter("number");
		Fitting fitting = fittingDao.getByHql(" from Fitting a where a.id = :p1 ", new Parameter(id));
		int size = 0;
		if(StringUtils.isNotBlank(number)){
			if(Integer.valueOf(number) >14){ 
				size = Integer.valueOf(number)/14;
			}
		}
		model.addAttribute("number", number);
		model.addAttribute("size", size);
		model.addAttribute("fitting", fitting);
		return "modules/fitting/print/printStock";
	}
	@RequestMapping(value="printappStocklist")
	public String printappStocklist(HttpServletRequest request,HttpServletResponse response,Model model){
		 String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		 String sitename = SiteDao.getSiteNameId(siteId);
		Map<String, Object> params = getParams(request);
	    Object orderObjs = params.get("fittingappId");
	    String[] fiappId = orderObjs.toString().split(",");
	    StringBuilder sf = new StringBuilder();
	    sf.append("  SELECT a.* FROM crm_site_fitting_apply a "); 
	    sf.append(" WHERE a.site_id=? AND a.id IN (" + StringUtil.joinInSql(fiappId) + ")");
	    List<Record> rds = Db.find(sf.toString(),siteId);
	 
	    model.addAttribute("rds", rds);
	    model.addAttribute("time", DateUtils.getDateTime());
	    model.addAttribute("creaname", CrmUtils.getUserXM());
	    model.addAttribute("sitename", sitename);
		return "modules/fitting/print/printappStocklist";
	}
	
	@RequestMapping(value="printStockList")
	public String printStockList(HttpServletRequest request,HttpServletResponse response,Model model){
		
		Map<String, Object> params = getParams(request);
	    Object orderObjs = params.get("fittingId");
		List<Fitting> list = Lists.newArrayList();
		int size = 1;
		
		if(orderObjs != null){
		   String fittingId = String.valueOf(orderObjs);
		if(StringUtils.isNotBlank(fittingId)){
			String[] ids = fittingId.split(",");
			for(String id :ids){
				Fitting fitting = fittingDao.getByHql(" from Fitting a where a.id = :p1 ", new Parameter(id));
				list.add(fitting);
			}
			if(ids.length >14){
				size = ids.length/14;
			}
		}
		}
		model.addAttribute("length", list.size());
		model.addAttribute("size", size);
		model.addAttribute("list", list);
		return "modules/fitting/print/printStocklist";
	}
	
	@RequestMapping(value="printOldFittingRegister")
	public String printOldFittingRegister(String id,HttpServletRequest request,HttpServletResponse response,Model model){
		User user = UserUtils.getUser();
		String siteId= CrmUtils.getCurrentSiteId(user);
		OldFitting oldFitting = new OldFitting();
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT of.*,of.employe_name as employeName FROM crm_site_old_fitting of");
		//sf.append(" LEFT JOIN crm_employe e ON of.employe_id=e.id AND e.site_id = '"+ siteId + "' ");
		sf.append(" where of.id=?");
		Record record = Db.findFirst(sf.toString(), id);
		
		if(StringUtils.isNotEmpty((CharSequence) record.getStr("employeName"))){
			oldFitting.setEmployeName(record.getStr("employeName"));
		}
		if(StringUtils.isNotEmpty((CharSequence)  record.getStr("number"))){
			oldFitting.setNumber(record.getStr("number"));
		}
		
		if(StringUtils.isNotEmpty((CharSequence)  record.getStr("id"))){
			oldFitting.setId(record.getStr("id"));
		}
		if(StringUtils.isNotEmpty((CharSequence)  record.getStr("status"))){
			oldFitting.setStatus(record.getStr("status"));
		}
		if (StringUtils.isNotEmpty((CharSequence)  record.getStr("code"))) {
			oldFitting.setCode(record.getStr("code"));// 旧件条码
		}
		if (StringUtils.isNotEmpty((CharSequence)  record.getStr("name"))) {
			oldFitting.setName(record.getStr("name"));// 旧件名称
		}
		if (StringUtils.isNotEmpty((CharSequence)  record.getStr("version"))) {
			oldFitting.setVersion(record.getStr("version"));// 旧件型号
		}
		if (StringUtils.isNotEmpty((CharSequence)  record.getStr("brand"))) {
			oldFitting.setBrand(record.getStr("brand"));// 旧件品牌
		}
		if(StringUtils.isNotEmpty((CharSequence) record.getStr("yrpz_flag"))){
			oldFitting.setYrpzFlag(record.getStr("yrpz_flag"));// 是否原配
		}
		if(StringUtils.isNotEmpty((CharSequence)  record.getStr("order_id"))){
			oldFitting.setOrderId(record.getStr("order_id"));//关联工单id
		}
		if (record.getBigDecimal("num")!=null) {
			oldFitting.setNum(record.getBigDecimal("num"));// 登记数量
		}
		if (StringUtils.isNotEmpty((CharSequence)   record.getStr("img"))) {
			oldFitting.setImg(record.getStr("img"));// 旧件图片地址
		}
		if (StringUtils.isNotEmpty((CharSequence)   record.getStr("customer_name"))) {
			oldFitting.setCustomerName(record.getStr("customer_name"));// 用户姓名
		}
		if (StringUtils.isNotEmpty((CharSequence)   record.getStr("customer_mobile"))) {
			oldFitting.setCustomerMobile(record.getStr("customer_mobile"));// 联系方式
		}
		model.addAttribute("pofr", oldFitting);
		return "modules/fitting/print/printOldFitting";
	}

}
