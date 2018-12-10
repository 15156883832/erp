package com.jojowonet.modules.operate.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteManagerDao;
import com.jojowonet.modules.operate.dao.SiteOrderCountDao;


/**
 * 服务商工单统计Service
 * @author yc
 * @version 2017-08-04
 */
@Component
@Transactional(readOnly = true)
public class SiteOrderCountService extends BaseService {
	@Autowired
	private SiteOrderCountDao siteOrderCountDao;
	
	public Page<Record> findsiteManager(Page<Record> page,Map<String,Object> map){
		List<Record> list=siteOrderCountDao.siteList(page, map);
		Date now = new Date();
/*		String adresses="";
		String province="";
		String city="";
		String area="";
		String address="";*/
		for (Record rd : list) {
			if (rd.getDate("due_time") == null) {
				rd.set("version", "免费版");
			} else {
				if (rd.getDate("due_time").getTime() >= now.getTime()) {
					rd.set("version", "收费版");
				} else {
					rd.set("version", "免费版");
				}
			}
/*			if(StringUtils.isNotBlank(rd.getStr("province"))){
				province=rd.getStr("province");
			}
			if(StringUtils.isNotBlank(rd.getStr("city"))){
				city=rd.getStr("city");
			}
			if(StringUtils.isNotBlank(rd.getStr("area"))){
				area=rd.getStr("area");
			}
			if(StringUtils.isNotBlank(rd.getStr("address"))){
				address=rd.getStr("address");
			}
			adresses=province+city+area+address;
			rd.set("sadress", adresses);*/
			
		}
		long count=siteOrderCountDao.getListCount(map);
		
		page.setList(list);
		page.setCount(count);
		return page;
	}

}
