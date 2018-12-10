package com.jojowonet.modules.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;








import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.TemplateSmsDao;
import com.jojowonet.modules.order.entity.TemplateSms;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;


@Component
@Transactional(readOnly = true)
public class TemplateSmsService extends BaseService {
	@Autowired
	private TemplateSmsDao templateSmsDao;
	
	public Page<Record> getTemplatelist(Page<Record> page){
		List<Record> tempaltelist=templateSmsDao.getTemplatelist(page);
		 long count =templateSmsDao.getcount();
		 page.setList(tempaltelist);
		 page.setCount(count);
		return page;
	}
//删除模板
	public void delete(String id) {
		templateSmsDao.deleteTemplate(id);	
	}
//保存模板
	public void save(TemplateSms temsms) {
		templateSmsDao.save(temsms);
	}
//根据id查询模板
	public Record queryTemplateById(String id) {
		Record rd=templateSmsDao.TemplateById(id);
		return rd;
	}
//更新模板
	public void updateTemplate(String id,String tid,String tag,String content,String name) {
		templateSmsDao.updateTemplate(id,tid,tag,content,name);
		
	}




	

}
