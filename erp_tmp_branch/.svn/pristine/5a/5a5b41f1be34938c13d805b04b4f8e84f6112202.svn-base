package com.jojowonet.modules.fitting.service;
	
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.EmpFittingKeepDao;
import com.jojowonet.modules.fitting.dao.EmployeFittingDao;
import com.jojowonet.modules.fitting.entity.EmpFittingKeep;
import com.jojowonet.modules.fitting.entity.EmployeFitting;
	
@Component
@Transactional(readOnly = true)
public class EmpFittingKeepService extends BaseService {
	
	@Autowired
	private EmpFittingKeepDao empFittingKeepDao;
	@Autowired
	private EmployeFittingDao employeFittingDao;
	public EmpFittingKeep get(String id){
		
		return empFittingKeepDao.get(id);
	}
	
	public Page<Record> getEmpFittingKeep(Page<Record> page,String siteId,Map<String,Object> map){
		
		List<Record> list = empFittingKeepDao.getListOfEmpFittingKeep2(page,siteId, map);
		long count = empFittingKeepDao.getCountOfEmpFittingKeep(page,siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}
	
	//新增调拨记录
	public void  doDB(String idO,double warning,String idT,String fId,EmployeFitting empFitting,EmpFittingKeep efk1,EmpFittingKeep efk){//idO：调拨人employid
		Record r=employeFittingDao.checkYMY(idT, fId);
		if(r!=null){
			employeFittingDao.doDB(idO, warning, idT,fId);
		}else{
			SimpleDateFormat fm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date now=new Date();
			String date=fm.format(now);
			String sql="update crm_employe_fitting ef set warning=warning-"+warning+",total=total-'"+warning+"',newest_keep_time='"+date+"' where ef.employe_id='"+idO+"' and ef.fitting_id='"+fId+"'";
			Db.update(sql);//调拨人库存数量减少
			employeFittingDao.save(empFitting);
		}
		//employeFittingService.doDB(idO, warning, idT, fId, empFitting);
		
		empFittingKeepDao.save(efk1);
		empFittingKeepDao.save(efk);
	}
	
	
	public void  tjEmpKeep(EmpFittingKeep efk){
		
		empFittingKeepDao.save(efk);
	}
	
}
