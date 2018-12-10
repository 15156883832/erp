/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.interceptor;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.Log;
import ivan.common.entity.mysql.common.User;
import ivan.common.service.BaseService;
import ivan.common.utils.IdGen;
import ivan.common.utils.SpringContextHolder;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.dao.LogDao;
import com.jojowonet.modules.sys.util.AuthUtils;

import eu.bitwalker.useragentutils.DeviceType;
import eu.bitwalker.useragentutils.UserAgent;

/**
 * 系统拦截器
 * @version 2013-6-6
 */
public class LogInterceptor extends BaseService implements HandlerInterceptor {

	private static LogDao logDao = SpringContextHolder.getBean(LogDao.class);
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		
		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			ModelAndView modelAndView) throws Exception {
		if(modelAndView!=null) {
			String viewName = modelAndView.getViewName();
			if(StringUtil.isNotBlank(request.getHeader("User-Agent"))){
			    UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent")); 
			    if(viewName.startsWith("modules/") && DeviceType.MOBILE.equals(userAgent.getOperatingSystem().getDeviceType())){
			        modelAndView.setViewName(viewName.replaceFirst("modules", "mobile"));
			    }
			}
		}
	}

	@Transactional(readOnly = false)
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {

		try {
			String requestRri = request.getRequestURI();
			String uriPrefix = request.getContextPath() + Global.getAdminPath();

			if ((StringUtils.startsWith(requestRri, uriPrefix) && (StringUtils.endsWith(requestRri, "/save")
                    || StringUtils.endsWith(requestRri, "/delete") || StringUtils.endsWith(requestRri, "/import")
                    || StringUtils.endsWith(requestRri, "/updateSort"))) || ex!=null){

                User user = UserUtils.getUser();
                if (user!=null && user.getId()!=null){

                    StringBuilder params = new StringBuilder();
                    int index = 0;
                    for (Object param : request.getParameterMap().keySet()){
                        params.append((index++ == 0 ? "" : "&") + param + "=");
                        params.append(StringUtils.abbr(StringUtils.endsWithIgnoreCase((String)param, "password")
                                ? "" : request.getParameter((String)param), 100));
                    }

                    Log log = new Log();
                    log.setType(ex == null ? Log.TYPE_ACCESS : Log.TYPE_EXCEPTION);
                    log.setCreateBy(user);
                    log.setCreateDate(new Date());
                    log.setRemoteAddr(StringUtils.getRemoteAddr(request));
                    log.setUserAgent(request.getHeader("user-agent"));
                    log.setRequestUri(request.getRequestURI());
                    log.setMethod(request.getMethod());
                    log.setParams(params.toString());
                    log.setException(ex != null ? ex.toString() : "");
                    logDao.save(log);

                    logger.info("save log {type: {}, loginName: {}, uri: {}}, ", log.getType(), user.getLoginName(), log.getRequestUri());

                }
            }
		} catch (Exception e) {
			logger.error("log interceptor, after completion, error", e);
			throw e;
		}
		
		/*if(uriPrefix.equalsIgnoreCase(requestRri)){
		    
		    User user = UserUtils.getUser();
		    if(user != null && StringUtils.isNotBlank(user.getId())){
		        try{
		            String userId = user.getId();
	                String siteName = null;
	                Date now = new Date();
	                if(User.USER_TYPE_SIT.equals(user.getUserType())){
	                    siteName = Db.findFirst(" SELECT a.name AS siteName FROM crm_site a WHERE a.user_id = '"+userId+"' AND a.status = '0' ").getStr("siteName");
	                }else if(User.USER_TYPE_XXY.equals(user.getUserType())){
	                    siteName = Db.findFirst(" SELECT b.name AS siteName FROM crm_messenger a INNER JOIN crm_site b ON b.id = a.site_id AND b.status = '0' WHERE a.user_id = '"+userId+"' AND a.status = '0' ").getStr("siteName");
	                }
	                Record rd = Db.findFirst(" select id from crm_onlines where user_id = '"+userId+"' ");
	                if(rd != null && StringUtils.isNotBlank(rd.getStr("id"))){//更新记录
	                    Db.update(" update crm_onlines set is_online = ?, site_name = ?, login_time = ? where user_id = ? ", "1", siteName, now, userId);
	                }else{//新增一条
	                    Db.update(" INSERT INTO crm_onlines (id, user_id, is_online, site_name, login_time) VALUES (?, ?, ?, ?, ?) ",
	                            IdGen.uuid(), userId, "1", siteName, now);
	                }
	                
	                logger.info(" userId:"+user.getId()+" login now at:"+now+"... ");
		        }catch (Exception e) {
		            e.printStackTrace();
                }
		    }
		}*/
		
//		logger.debug("最大内存: {}, 已分配内存: {}, 已分配内存中的剩余空间: {}, 最大可用内存: {}", 
//				Runtime.getRuntime().maxMemory(), Runtime.getRuntime().totalMemory(), Runtime.getRuntime().freeMemory(), 
//				Runtime.getRuntime().maxMemory()-Runtime.getRuntime().totalMemory()+Runtime.getRuntime().freeMemory()); 
		
	}

}
