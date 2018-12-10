package com.jojowonet.modules.operate.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.dao.SiteParentRelDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * 关系表Service
 * @author Ivan
 * @version 2016-08-01
 */
@Component
@Transactional(readOnly = true)
public class SiteParentRelService extends BaseService {

	@Autowired
	private SiteParentRelDao siteParentRelDao;
	@Autowired
	private SiteService siteService;
	@Autowired
	private SiteDao siteDao;

	/**
	 * 1、修改网点类型（type）为一级网点（=1）
	 * 注：已被添加为二级你网点的不可修改
	 * @param id
	 * @return
	 */
	@Transactional(rollbackFor =Exception.class)
	public Result<Object> openNoOne(String id){
		Result<Object> ret= new Result<Object>();
		Record re=Db.findFirst("select parent_site_id from crm_site_parent_rel where site_id=? and status='0' ",id);
		if(re!=null){
			String parentSiteId=re.getStr("parent_site_id");
			Site site=siteDao.get(parentSiteId);
			String parentName=site.getName();
			ret.setCode("401");
			ret.setMsg("该网点已被"+parentName+"添加为二级网点！");
		}else {
			siteDao.update("update Site set type='1' where id=:p1 and status='0' ",new Parameter(id));
			ret.setCode("200");
		}
		return ret;
	}

	/**
	 * 1、修改网点类型（type）为二级网点（=0）
	 * 2、删除二级网点关联关系（暂不考虑）
	 * 注：已添加了二级网点的不可修改
	 * @param id
	 * @return
	 */
	@Transactional(rollbackFor =Exception.class)
	public Result<Object> cancelNoOne(String id){
		Result<Object> ret= new Result<Object>();
		String userId = UserUtils.getUser().getId();
		String userName = UserUtils.getUser().getLoginName();
		Record re=Db.findFirst("select * from crm_site_parent_rel where parent_site_id=? and status='0' ",id);
		if(re!=null){
			ret.setCode("401");
			ret.setMsg("该网点下已有二级网点，解绑后才可以取消一级网点！");
		}else{
			siteDao.update("update Site set type='0' where id=:p1 and status='0' ",new Parameter(id));
			//siteParentRelDao.update("update SiteParentRel set cancel_time=:p1,cancel_name=:p2,cancel_id=:p3,status='1'  where parent_site_id=:p4 ",new Parameter(new Date(),userName,userId,id));
			ret.setCode("200");
		}
		return ret;
	}


}
