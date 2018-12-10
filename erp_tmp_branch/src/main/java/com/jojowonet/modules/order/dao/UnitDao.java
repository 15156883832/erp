package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Unit;



@Repository
public class UnitDao extends BaseDao<Unit> {
	public Record getUnitById(Integer id) {
	String sql="SELECT * FROM  crm_unit WHERE id=? ";
		Record rd= Db.findFirst(sql,id);
		return rd;
	}

	public void updates(String name, String type, Integer id) {
String sql="UPDATE  crm_unit SET name=? ,type=? WHERE id=?";
Db.update(sql, name,type,id);
		
	}
	public void deleteByIds(Integer id) {
		String sql="UPDATE  crm_unit SET status='1'  WHERE id=?";
		Db.update(sql,id);
		
	}

	public List<Unit> getUnitList() {
		Query q = getSession().createQuery("from Unit where status=:status");
		q.setParameter("status", "0");
		return q.list();
	}
	
	public List<Record> getAllUnit() {
		String sql = "select name, type from crm_unit where status = '0' ";
		return Db.find(sql);
	}
	
	public Record getUnitType(String type) {
		String sql = "select * from crm_unit where name =? and status = '0' ";
		return Db.findFirst(sql, type);
	}
	public static Record getFitUnitType(String type) {
		String sql = "select * from crm_unit where name =? and status = '0' ";
		return Db.findFirst(sql, type);
	}

	
	


}
