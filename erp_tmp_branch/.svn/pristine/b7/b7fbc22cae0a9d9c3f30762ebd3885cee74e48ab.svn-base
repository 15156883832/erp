/**
 */
package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.MalfunctionDao;
import com.jojowonet.modules.order.entity.Malfunction;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 故障类别Service
 * @author Ivan
 * @version 2016-08-02
 */
@Component
@Transactional(readOnly = true)
public class MalfunctionService extends BaseService {

	@Autowired
	private MalfunctionDao malfunctionDao;
	
	public Malfunction get(String id) {
		return malfunctionDao.get(id);
	}
	
	public Map<String ,String > getMalfunction(String category,String siteId){
		return malfunctionDao.getMalfunction(category,siteId);
		}
	
	public List<Malfunction> getListMal(String category,String siteId){
		
	 return malfunctionDao.getListMal(category, siteId);
	 
	}
	
	public Page<HashMap<String, List<Malfunction>>> getListMalfunction(String siteId,Page<HashMap<String, List<Malfunction>>> page,Integer categroy, String type){
		List<HashMap<String, List<Malfunction>>>  hashmap = new ArrayList<HashMap<String,List<Malfunction>>>();
		List<String> li = malfunctionDao.gettype(siteId, categroy, type, page.getPageSize(),page.getPageNo());//取到故障类型的列表
		
		for(String ma : li){
			HashMap<String, List<Malfunction>> map = new HashMap<String, List<Malfunction>>();
			List<Malfunction> list = malfunctionDao.het(ma,siteId,categroy);
			map.put(ma, list);
			hashmap.add(map);
		}
		
		long count = malfunctionDao.getCount(siteId,categroy, type);
	    page.setList(hashmap);
		page.setCount(count);
		return page;
	}
	
	public Page<String> getlist(String siteId,Page<String> page,Integer categroy, String type){
		List<String> li = malfunctionDao.gettype(siteId, categroy, type, page.getPageSize(), page.getPageNo());
		long count = malfunctionDao.getCount(siteId,categroy,type);
		page.setCount(count);
		page.setList(li);
		return page;
	}
	
	/*public List<Malfunction> getMal(String type,String siteId){
		return malfunctionDao.het(type,siteId);
	}*/
	public  void saveMal(String category,String type,List<Malfunction> list){
	         malfunctionDao.saveMal(category, type, list);
	}

	public void updateMal(String category, String type, List<Malfunction> list, String siteId, String xintype) {
		if (isPlatform(siteId)) {
			malfunctionDao.delectPlatformMal(category, type);
		} else {
			malfunctionDao.delectMal(category, type, siteId);
		}
		malfunctionDao.saveMal(category, xintype, list);
	}
	
	public List<Record> getlistmal(String category,String type,String siteId){
		return malfunctionDao.getListMal(category, type, siteId);
	}

	public void delectMalfuncton(String category, String type, String siteId) {
		if (isPlatform(siteId)) {
			malfunctionDao.delectPlatformMalfuncton(category, type);
		} else {
			malfunctionDao.delectMalfuncton(category, type, siteId);
		}
	}

	public void deleteSelectedMalfunctions(String[] ids, boolean isAdmin) {
		String[][] params = new String[ids.length][];
		for (int i = 0; i < ids.length; i++) {
			params[i] = new String[1];
			params[i][0] = ids[i];
		}
		if (isAdmin) {
			Db.batch("update crm_malfunction set status='1' where id=? and user_type='1'", params, 10);
		} else {
			Db.batch("update crm_malfunction set status='1' where id=? and user_type!='1'", params, 10);
		}
	}

	public boolean isPlatformType(String type,String category) {
		return Db.queryLong("select count(1) from crm_malfunction where `type`=? and status=0 and category=? and user_type='1'", type, category) > 0;
	}

	public boolean isSiteAddedType(String type,String category) {
		return Db.queryLong("select count(1) from crm_malfunction where `type`=? and category=? and status=0 and user_type!='1'", type, category) > 0;
	}

	public boolean isMalTypeExists(String category, String malType) {
		return Db.queryLong("select count(1) from crm_malfunction where `type`=? and status=0 and category=?", malType, category) > 0;
	}

	private boolean isPlatform(String siteId) {
		return (StringUtils.isBlank(siteId) || "null".equals(siteId));
	}
}
