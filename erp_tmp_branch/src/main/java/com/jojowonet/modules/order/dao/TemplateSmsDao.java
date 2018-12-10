package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.TemplateSms;


@Repository
public class TemplateSmsDao extends BaseDao<TemplateSms> {
	public List<Record> getTemplatelist(Page<Record> page){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT *  FROM sys_sms_template");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString());
	}

	public long getcount() {
   String sql="SELECT COUNT(*) FROM sys_sms_template";
    return Db.queryLong(sql);
	}
//删除模板
	public void deleteTemplate(String id) {
		String sql="UPDATE sys_sms_template SET status='1' WHERE id='"+id+"'";
		Db.update(sql);
		
	}
//更新模板
	public void updateTemplate(String id,String tid,String tag,String content,String name) {
		String sql="UPDATE sys_sms_template SET number=? , name=? , tag=? , content=?  WHERE id='"+id+"'";
		Db.update(sql,tid,name,tag,content);
		
	}
//根据id查询模板
	public Record TemplateById(String id) {
		String sql="SELECT * FROM sys_sms_template WHERE id='"+id+"'";
		return Db.findFirst(sql);
	}

	

}
