/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;

import ivan.common.persistence.Page;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/session")
public class SessionController extends BaseController {
    
    
	@RequestMapping(value = "onlines")
	public String onlines(HttpServletRequest request, HttpServletResponse response, Model model) {
	    Map<String, String> filterMap = Maps.newHashMap();
	    filterMap.put("siteName", request.getParameter("siteName"));
        Page<Record> page = new Page<>(request, response);
        //page = statsService.statsOnlines(page, filterMap);
        model.addAttribute("page", page);
        model.addAttribute("stl", request.getSession().getMaxInactiveInterval());
        if(StringUtils.isNotBlank(filterMap.get("siteName"))){
            model.addAttribute("siteName", filterMap.get("siteName"));
        }
		return "modules/sys/onlines";
	}
	
}
