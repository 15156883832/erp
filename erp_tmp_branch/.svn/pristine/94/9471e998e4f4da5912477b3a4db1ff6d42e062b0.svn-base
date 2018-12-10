package com.jojowonet.modules.order.service;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.utils.DataUtils;
import com.jojowonet.modules.order.dao.UnitDao;
import com.jojowonet.modules.order.entity.Unit;


@Component
@Transactional(readOnly=true)
public class UnitService extends BaseService {
	
	@Autowired
	private UnitDao unitDao;
	
	
	public Unit get(Integer id) {
		return unitDao.get(id);
	}
	
	   public Page<Unit> find(Page<Unit> page, Unit unit) {
			DetachedCriteria dc = unitDao.createDetachedCriteria();
			if (unit.getId()!=null){
				dc.add(Restrictions.like("name", "%"+unit.getId()+"%"));
			}
			dc.add(Restrictions.eq("status", "0"));			
			return unitDao.find(page, dc);
		}
	   
		@Transactional(readOnly = false)
		public void save(Unit unit) {
			//orderOriginDao.clear();
		
			unitDao.save(unit);	
		}
		
		@Transactional(readOnly = false)
		public void delete(Integer id) {
			unitDao.deleteByIds(id);
		}
		
		public boolean queryNumByNames(String names,Integer id){
			if(id!=null){
				List list = unitDao.createSqlQuery("select * from crm_unit"
						+ " where name = :p1 and id!=:p2 and status='0' ",new Parameter(names,id)).list();
				if (list.size()>0)
					return false;
				return true;
			}else{
				List list = unitDao.createSqlQuery("select * from crm_unit"
						+ " where  name = :p1 and status='0' ",new Parameter(names)).list();
				if (list.size()>0)
					return true;
				return false;
			}
			}
		
		public Record getUnitById(Integer id) {
		     Record rd=unitDao.getUnitById(id);
				return rd;
			}


			public void updates(String name, String type, Integer id) {
				unitDao.updates(name,type,id);
				
			}

			public List<Unit> getUnitList() {
				return unitDao.getUnitList();
			}

			public Map<String, String> getAllUnit() {
				Map<String, String> map = Maps.newHashMap();
				List<Record> list = unitDao.getAllUnit();
				if(list != null){
					for(Record rd :list){
						map.put(rd.getStr("name"), rd.getStr("type"));
					}
				}
				return map;
			}
		

}
