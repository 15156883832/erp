/**
 */
package com.jojowonet.modules.operate.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.operate.entity.SiteVehicle;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteVehicleDao;

/**
 * 车辆信息Service
 * @author lzp
 * @version 2018-10-31
 */
@Component
@Transactional(readOnly = true)
public class SiteVehicleService extends BaseService {

	@Autowired
	private SiteVehicleDao siteVehicleDao;
	
	public SiteVehicle get(String id) {
		return siteVehicleDao.get(id);
	}
	
	public Page<SiteVehicle> find(Page<SiteVehicle> page, SiteVehicle siteVehicle,String siteId) {
		DetachedCriteria dc = siteVehicleDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(siteVehicle.getPlateNumber())){
			dc.add(Restrictions.like("plateNumber", "%"+siteVehicle.getPlateNumber()+"%"));
		}
		dc.add(Restrictions.eq("siteId", siteId));
		dc.addOrder(Order.desc("createTime"));
		return siteVehicleDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public String save(String[] number,String siteId,String userId) {
		try {
			List<SiteVehicle> list = Lists.newArrayList();
			for(String pla: number ) {
				SiteVehicle sv = new SiteVehicle();
				sv.setPlateNumber(pla);
				sv.setSiteId(siteId);
				sv.setCreateBy(userId);
				list.add(sv);
			}
			siteVehicleDao.save(list);
			return "ok";
		} catch (Exception e) {
			return "no";
		}
	}
	
	public boolean getCheckNumber(String siteId,String number) {
		String sql = "SELECT COUNT(*) FROM crm_site_vehicle WHERE  plate_number=? AND site_id=?";
		long count = Db.queryLong(sql, number,siteId);
		if(count >0) {
			return true;
		}
		return false;
	}
	
	public void deleteVehicle(String id) {
		String sql ="DELETE FROM crm_site_vehicle WHERE id = ?";
		Db.update(sql,id);
	}
	
	/*
	 * 获取当前服务商的车辆信息
	*/
	public static List<Record> getVehicleList(String siteId){
		String sql = "SELECT id,plate_number FROM crm_site_vehicle WHERE  site_id=?";
		return Db.find(sql,siteId);
	}
	
}
