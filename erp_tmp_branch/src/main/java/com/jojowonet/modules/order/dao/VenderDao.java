package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Vender;


/**
 * 厂家DAO接口
 * @author yc
 * @version 2017-06-06
 */
 
@Repository
public class VenderDao  extends BaseDao<Vender> {
	public List<Record> getVenderList(Page<Record> page){
		StringBuffer sf=new StringBuffer();
        sf.append("SELECT * FROM crm_vender_info WHERE status='0' ");
		sf.append(page.getSqlOrderBy());
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString());
	  }
	
	public long getListCount(){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(*) FROM crm_vender_info WHERE status='0'");
		return Db.queryLong(sf.toString());
	   }
	
	
	//删除厂家信息
		public Integer delete(String id) {
		 String sql="UPDATE crm_vender_info SET status='1' WHERE id=?";
		return Db.update(sql,id);
		}
		
	//修改厂家资料前根据id查询厂家资料
		public Record findVenderById(String id) {
	     String sql="SELECT * FROM crm_vender_info WHERE id=?";
		 return Db.findFirst(sql, id);	
	    } 
		
		
	//查询厂家的所有已有名称
		public List<String> getVenderName(){
			String sql="SELECT name FROM crm_vender_info WHERE status='0'";
			return Db.query(sql);
		}
		
		

}
