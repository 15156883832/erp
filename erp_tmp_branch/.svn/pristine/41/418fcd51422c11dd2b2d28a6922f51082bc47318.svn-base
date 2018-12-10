/**
 */
package com.jojowonet.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ivan.common.web.BaseController;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.QueryTimes;
import com.jojowonet.modules.order.service.QueryTimesService;

/**
 * 工单查询信息Controller
 * @author Ivan
 * @version 2017-11-02
 */
@Controller
@RequestMapping(value = "${adminPath}/order/queryTimes")
public class QueryTimesController extends BaseController {

	@Autowired
	private QueryTimesService queryTimesService;
	
	@ModelAttribute
	public QueryTimes get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return queryTimesService.get(id);
		}else{
			return new QueryTimes();
		}
	}
	
	@RequestMapping(value="querylist")
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			//queryTimes1.setCreateBy(user);
		}
        Page<Record> page = queryTimesService.find(new Page<Record>(request, response)); 
        model.addAttribute("page", page);
        model.addAttribute("rds", queryTimesService.getSum());
		return "modules/" + "order/queryTimesList";
	}

}
