/**
 */
package com.jojowonet.modules.operate.web;

import com.jojowonet.modules.operate.service.SiteParentRelService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.utils.Result;
import ivan.common.web.BaseController;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 人员Controller
 * 
 * @author cdq
 * @version 2018-01-015
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/siteParentRel")
public class SiteParentRelController extends BaseController {

	@Autowired
	private SiteParentRelService siteParentRelService;
	@Autowired
	private SiteService siteService;

	/**
	 * 开通一级网点
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="openNoOne")
	public Result<Object> openNoOne(HttpServletRequest request){
		Result<Object> ret=new Result<Object>();
		String id=request.getParameter("id");
		if(StringUtils.isBlank(id)){
			logger.error("id is null");
			ret.setCode("201");
			return ret;
		}else{
			return siteParentRelService.openNoOne(id);
		}
	}

	/**
	 * 取消一级网点
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="cancelNoOne")
	public Result<Object> cancelNoOne(HttpServletRequest request){
		Result<Object> ret=new Result<Object>();
		String id=request.getParameter("id");
		if(StringUtils.isBlank(id)){
			logger.error("id is null");
			ret.setCode("201");
			return ret;
		}else{
			return siteParentRelService.cancelNoOne(id);
		}
	}

}
