package com.jojowonet.modules.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.sysSettle;








import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.IdGen;
@Repository
public class SysSettleDao  extends BaseDao<sysSettle>{
	
	public List<Record> getsettngList(Page<Record> page ,String siteId){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT * FROM crm_site_settlement_settings a  WHERE a.site_id=? AND a.status='0' ORDER BY a.create_time DESC  ");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());

		return Db.find(sf.toString(),siteId);
	
	}
	public long getListcount(String siteId){
		String sql = " select count(*) as count from crm_site_settlement_settings as c where  c.status ='0' and c.site_id=?  ";
		return Db.queryLong(sql,siteId);
	}
	public void saveInfo(sysSettle sys){
		String sql ="INSERT INTO  crm_site_settlement_settings VALUES('"+sys.getId()+"', '"+sys.getSite_id()+"', '"+sys.getType()+"', '"+sys.getFigure()+"', '"+sys.getStatus()+"', '"+sys.getCreateTime()+"');";
		Db.update(sql);
	}
	public List<Record> querysettletype() {
		String sql="SELECT type FROM `crm_site_settlement_settings`";
		return Db.find(sql);
	}
	public void deletesettle(String id) {
		String sql ="UPDATE crm_site_settlement_settings SET status = '1' WHERE id = '"+id+"'";
		Db.update(sql);
		
	}
	public void updatesettle(String id) {
		String sql ="UPDATE crm_site_settlement_settings SET figure = '1' WHERE id = '"+id+"'";
		Db.update(sql);
	}
	public void updatesettles(String id) {
		String sql ="UPDATE crm_site_settlement_settings SET figure = '0' WHERE id = '"+id+"'";
		Db.update(sql);
	}
	public Record getSiteSettleFlag(String siteId) {
		return Db.findFirst(" select * from crm_site_settlement_settings a where a.site_id = ? and a.type = '1' and a.status = '0' ", siteId);
	}
	
}
