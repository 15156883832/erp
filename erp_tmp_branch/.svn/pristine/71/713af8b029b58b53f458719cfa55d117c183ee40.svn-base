package com.jojowonet.modules.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.DocSet;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;


/**
 * 文件设置DAO接口
 * @author yc
 * @version 2017-09-07
 */
@Repository
public class DocSetDao  extends BaseDao<DocSet>{
	public List<Record> getDocList(Page<Record> page){
		StringBuffer sf=new StringBuffer();
		sf.append("select * from crm_doc where status='0' ");
		if(page!=null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}
	
	public long getcount(){
		StringBuffer sf=new StringBuffer();
		sf.append("select count(*) from crm_doc where status='0' ");
		return Db.queryLong(sf.toString());
	}

	public String getDocByname(String name) {
		String sql="select id from crm_doc where name=? and status='0' ";
		return Db.queryStr(sql, name);
	}

	public Integer deletedoc(String id) {
		String sql="UPDATE crm_doc SET status='1' WHERE id='"+id+"'";
		return Db.update(sql);
	}

}
