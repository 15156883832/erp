/**
 */
package com.jojowonet.modules.order.service;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.order.entity.Distribution;
import com.jojowonet.modules.order.entity.Order;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.DistributionDao;

/**
 * 配送信息Service
 * @author lzp
 * @version 2018-10-31
 */
@Component
@Transactional(readOnly = true)
public class DistributionService extends BaseService {

	@Autowired
	private DistributionDao distributionDao;
	
	public Distribution get(String id) {
		return distributionDao.get(id);
	}
	
	@Transactional(readOnly = false)
	public void save(Order or,String distributionNumber,String distributionTime,String plateNumber,String siteplateId,
			String driverName,String sitedriverId,String userId) {
		String[] plNum = plateNumber.split(","); 
		String[] plId = siteplateId.split(","); 
		String[] drrName = driverName.split(";"); 
		String[] drId = sitedriverId.split(";"); 
		List<Distribution> list = Lists.newArrayList();
		for(int i = 0;i<plNum.length;i++) {
			Distribution du = new Distribution();
			du.setCreateBy(userId);
			du.setDistributionNumber(distributionNumber);
			if(StringUtils.isBlank(distributionTime)) {
				du.setDistributionTime(new Date());
			}else {
				du.setDistributionTime(DateUtils.parseDate(distributionTime));
			}
			du.setPlateNumber(plNum[i]);
			du.setVehicleId(plId[i]);
			du.setDriverId(drId[i]);
			du.setDriverName(drrName[i]);
			du.setOrderId(or.getId());
			du.setSiteId(or.getSiteId());
			list.add(du);
		}
		
		
		distributionDao.save(list);
	}
	
	public Page<Record> getDistributionPage(String siteId,Map<String,Object> map,Page<Record> page){
		List<Record> list = distributionDao.getDistributionList(siteId, page, map);
		long count = distributionDao.getDistributionCount(siteId, map);
		page.setCount(count);
		page.setList(list);
		return page;
	}
}
