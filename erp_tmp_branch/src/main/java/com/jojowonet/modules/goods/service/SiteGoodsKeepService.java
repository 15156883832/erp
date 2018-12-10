package com.jojowonet.modules.goods.service;

import java.util.List;
import java.util.Map;

import ivan.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.SiteGoodsKeepDao;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

@Component
@Transactional(readOnly = true)
public class SiteGoodsKeepService extends BaseService {

	@Autowired
	private SiteGoodsKeepDao siteGoodsKeepDao;

	// 获取服务商出入库明细表的数据
	public Page<Record> getSiteGoodsKeep(Page<Record> page, String siteId,
			Map<String, Object> map) {
		
		List<Record> list = siteGoodsKeepDao.getListOfSiteGoodsKeep(page,siteId,map);
		long count = siteGoodsKeepDao.getCountOfSiteGoodsKeep(page, siteId,map);
		for(Record re:list){
			if(StringUtils.isNotBlank(re.getStr("icons"))){
				String[] icons=re.getStr("icons").split(",");
				re.set("icons",icons[0]);
			}
		}
		page.setList(list);
		page.setCount(count);
		
		return page;
	}
	
	// 导出  服务商出入库明细表的记录
	public List<Record> getSiteGoodsKeepList (Page<Record> page, String siteId, Map<String, Object> map) {
		
		List<Record> list = siteGoodsKeepDao.getListOfSiteGoodsKeep(page, siteId, map);
		
		return list;
	}
	
	// 获取工程师领取出入库明细表的数据
	public Page<Record> getEmpKeepList(Page<Record> page, String siteId,
			Map<String, Object> map) {
		
		List<Record> list = siteGoodsKeepDao.getListOfEmpGoodsKeep(page,siteId,map);
		long count = siteGoodsKeepDao.getCountOfEmpGoodsKeep(page, siteId,map);
		for(Record re:list){
			if(StringUtils.isNotBlank(re.getStr("icon"))){
				String[] icons=re.getStr("icon").split(",");
				re.set("icon",icons[0]);
			}

		}
		page.setList(list);
		page.setCount(count);
		
		return page;
	}
	// 获取工程师自购出入库明细表的数据
	public Page<Record> getEmpKeepListgm(Page<Record> page, String siteId,
			Map<String, Object> map) {
		
		List<Record> list = siteGoodsKeepDao.getListOfEmpGoodsKeepgm(page,siteId,map);
		long count = siteGoodsKeepDao.getCountOfEmpGoodsKeepgm(page, siteId,map);
		for(Record re:list){
			if(StringUtils.isNotBlank(re.getStr("icon"))){
				String[] icons=re.getStr("icon").split(",");
				re.set("icon",icons[0]);
			}
			
		}
		page.setList(list);
		page.setCount(count);
		
		return page;
	}

}
