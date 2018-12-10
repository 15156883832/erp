/**
 */
package com.jojowonet.modules.order.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.web.BaseController;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Distribution;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.DistributionService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;

/**
 * 配送信息Controller
 * @author lzp
 * @version 2018-10-31
 */
@Controller
@RequestMapping(value = "${adminPath}/order/distribution")
public class DistributionController extends BaseController {

	@Autowired
	private DistributionService distributionService;
	
	@RequestMapping(value = {"list", ""})
	public String list(Distribution distribution, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			//distribution.setCreateBy(user);
		}
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		
		return "modules/" + "order/distributionList";
	}


	@RequestMapping(value="distributionList")
	@ResponseBody
	public String distributionList(HttpServletRequest request,HttpServletResponse response,Model model){
		Map<String, Object> map = new TrimMap(getParams(request));
		String siteId =  CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Page<Record> page = new Page<>(request, response);
		page = distributionService.getDistributionPage(siteId, map, new Page<Record>(request, response));
		model.addAttribute("page",page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	@ResponseBody
	@RequestMapping(value="updateOrderDistribution")
	public String updateOrderDistribution(HttpServletRequest request,HttpServletResponse response) {
		User user = UserUtils.getUser();
		String siteId =  CrmUtils.getCurrentSiteId(user);
		String distributionNumber = request.getParameter("distributionNumber");
		String distributionTime = request.getParameter("distributionTime");
		String plateNumber = request.getParameter("plateNumber");
		String siteplateId = request.getParameter("siteplateId");
		String driverName = request.getParameter("driverName");
		String sitedriverId = request.getParameter("sitedriverId");
		String orderId = request.getParameter("orderId");
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="getdistribution")
	public Record getdistribution(String orderId,HttpServletRequest request,HttpServletResponse response) {
		String sql = "SELECT distribution_number,distribution_time FROM crm_order_distribution WHERE order_id=? GROUP BY distribution_number ";
	
	return Db.findFirst(sql,orderId);
	}
}
