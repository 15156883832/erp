package com.jojowonet.modules.goods.service;

import java.util.List;
import java.util.Map;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.dao.GoodsEmployeOwnDao;

@Component
@Transactional(readOnly = true)
public class GoodsEmployeOwnService extends BaseService{

	@Autowired
	private GoodsEmployeOwnDao goodsEmployeOwnDao;
	
	public Page<Record> getAllSiteInfo(Page<Record> page,String siteId,Map<String,Object> map){
		if(map.get("pageSize")!=null){
			if(StringUtils.isNotBlank(map.get("pageSize").toString())){
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = goodsEmployeOwnDao.getAllSiteInfo(page, siteId, map);
		for(Record rd : list){
			rd.set("firstIcon", "");
			String icons = rd.getStr("icon");
			if(StringUtils.isNotBlank(icons)){
				rd.set("firstIcon", icons.split(",")[0]);
			}
		}
		long count = goodsEmployeOwnDao.getCount(siteId,map);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	
	public Page<Record> getAllSiteInfogm(Page<Record> page,String siteId,Map<String,Object> map){
		if(map.get("pageSize")!=null){
			if(StringUtils.isNotBlank(map.get("pageSize").toString())){
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		List<Record> list = goodsEmployeOwnDao.getAllSiteInfogm(page, siteId, map);
		for(Record rd : list){
			rd.set("firstIcon", "");
			String icons = rd.getStr("icon");
			if(StringUtils.isNotBlank(icons)){
				rd.set("firstIcon", icons.split(",")[0]);
			}
		}
		long count = goodsEmployeOwnDao.getCountgm(siteId,map);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	
	// 显示编辑信息
		@Transactional(readOnly = false)
		public Record showBJ(String id) {
			StringBuffer sb=new StringBuffer();
			sb.append("SELECT b.*,a.stocks as empStocks,c.name as empName FROM crm_goods_employe_own a ");
			sb.append(" LEFT JOIN crm_goods_siteself b ON a.`good_id`=b.`id`");
			sb.append(" LEFT JOIN crm_employe c ON a.`employe_id`=c.`id`");
			sb.append(" WHERE a.id='"+id+"' ");
			Record re = Db.findFirst(sb.toString());
			return re;
		}

}
