/**
 */
package com.jojowonet.modules.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SettlementTemplate;
import com.jojowonet.modules.order.dao.SettlementTemplateDao;

/**
 * 结算措施Service
 * @author Ivan
 * @version 2017-05-26
 */
@Component
@Transactional(readOnly = true)
public class SettlementTemplateService extends BaseService {

	@Autowired
	private SettlementTemplateDao settlementTemplateDao;
	
	public SettlementTemplate get(String id) {
		return settlementTemplateDao.get(id);
	}
	
	
	@Transactional(readOnly = false)
	public void save(SettlementTemplate settlementTemplate) {
		settlementTemplateDao.save(settlementTemplate);
	}
	@Transactional(readOnly = true)
	public void saveList(List<SettlementTemplate> list) {
		settlementTemplateDao.save(list);
	}
	
	@Transactional(readOnly = true)
	public void delete(String cate,String siteId,String service_measures,List<SettlementTemplate> list) {
		if(list!=null){
			settlementTemplateDao.save(list);
		}
		settlementTemplateDao.delectSet(cate,siteId,service_measures);
	}
	
	public List<SettlementTemplate> getListSet(String category,String siteId){
		return settlementTemplateDao.getListSet(category, siteId);
	}
	
	public List<Record> getListSetMea(String category,String serviceMeasures,String siteId,String warrantyType){
		return settlementTemplateDao.getListSetMea(category, serviceMeasures, siteId,warrantyType);
	}
	
	//根据id查询当前信息
	public Record getSettlementId(String id){
		return settlementTemplateDao.getSettlementId(id);
	}
	
	public Page<HashMap<String, List<SettlementTemplate>>> getListSettlementTemplate(String siteId,Page<HashMap<String, List<SettlementTemplate>>> page,Integer categroy, String type){
		List<HashMap<String, List<SettlementTemplate>>>  hashmap = new ArrayList<HashMap<String,List<SettlementTemplate>>>();
		List<String> li = settlementTemplateDao.serviceMeasures(siteId, categroy, type, page.getPageSize(),page.getPageNo());
		
		for(String ma : li){
			HashMap<String, List<SettlementTemplate>> map = new HashMap<String, List<SettlementTemplate>>();
			List<SettlementTemplate> list = settlementTemplateDao.het(ma,siteId,categroy);
			map.put(ma, list);
			hashmap.add(map);
		}
		
		long count = settlementTemplateDao.getCount(siteId,categroy, type);
	    page.setList(hashmap);
		page.setCount(count);
		return page;
	}
	
	public void delectChargeName(JsonArray resu){
		for(int i = 0;i<resu.size();i++){
			settlementTemplateDao.deleteById(resu.get(i).getAsString(), "1");
		}
	} 
}
