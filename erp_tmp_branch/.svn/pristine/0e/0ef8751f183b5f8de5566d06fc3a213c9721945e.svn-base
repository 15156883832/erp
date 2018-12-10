/**
 */
package com.jojowonet.modules.order.service;

import java.util.Date;

import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Printdesign;
import com.jojowonet.modules.order.dao.PrintdesignDao;

/**
 * 打印信息Service
 * @author Ivan
 * @version 2017-11-06
 */
@Component
@Transactional(readOnly = true)
public class PrintdesignService extends BaseService {

	@Autowired
	private PrintdesignDao printdesignDao;
	
	public Printdesign get(String id) {
		return printdesignDao.get(id);
	}
	
	public Record getPrintde(String siteId){
		return printdesignDao.getPrintde(siteId);
	}
	
	public Record getPrintdeState(String siteId){
		return printdesignDao.getPrintdeState(siteId);
	}
	
	@Transactional(readOnly = false)
	public void save(Printdesign printdesign) {
		printdesignDao.save(printdesign);
	}
	
	@Transactional(readOnly = false)
	public void update(Printdesign prin) {
		String sql ="UPDATE crm_printdesign SET imgurl = ? ,state = ?, content = ?, modifydate = ? WHERE id = ? ";
		Db.update(sql,prin.getImgurl(),prin.getState(),prin.getContent(),DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"),prin.getId());
	}
	
}
