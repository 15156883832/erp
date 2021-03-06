package com.jojowonet.modules.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.ServiceMode;
import com.jojowonet.modules.order.utils.SqlKit;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

@Repository
public class ServiceModeDao extends BaseDao<ServiceMode>{

	public List<Record> filterServiceMode(Page<Record> page) {
		SqlKit kit = new SqlKit()
				.append(" SELECT * FROM  crm_service_mode WHERE  status='0' ORDER BY sort ASC ");
				if(page !=null){
					kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
				}
		return Db.find(kit.toString());
	}

	public Record getServiceModeById(Integer id) {
	String sql="SELECT * FROM  crm_service_mode WHERE id=? ";
		Record rd= Db.findFirst(sql,id);
		return rd;
	}

	public void updates(String name, String sort, Integer id) {
	String sql="UPDATE  crm_service_mode SET name=? ,sort=? WHERE id=?";
	Db.update(sql, name,sort,id);
		
	}
	public void deleteByIds(Integer id) {
		String sql="UPDATE  crm_service_mode SET status='1'  WHERE id=?";
		Db.update(sql,id);
		
	}
	
	public List<Record> getNewServiceMode(Page<Record> page,String siteId) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT * FROM ( ");
    	sf.append("SELECT * FROM crm_service_mode a ");
    	sf.append(" WHERE a.site_id = '0' AND a.status = '0' AND NOT EXISTS ");
    	sf.append(" ( ");
    	sf.append(" 	SELECT b.* FROM crm_service_mode b, crm_site si ");
    	sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
    	sf.append(" 	) ");
    	sf.append(" UNION ");
    	sf.append(" SELECT b.* FROM crm_service_mode b, crm_site si ");
    	sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? "); 
    	sf.append("  ) ass ORDER BY ass.sort ASC  ");
		if(page !=null){
			sf.append("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(),siteId,siteId);
	}
	public long getNewServiceModeCount(String siteId,String name,Integer id) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT COUNT(*) FROM ( ");
		sf.append("SELECT * FROM crm_service_mode a ");
		sf.append(" WHERE a.site_id = '0' AND a.status = '0' AND NOT EXISTS ");
		sf.append(" ( ");
		sf.append(" 	SELECT b.* FROM crm_service_mode b, crm_site si ");
		sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
		sf.append(" 	) ");
		sf.append(" UNION ");
		sf.append(" SELECT b.* FROM crm_service_mode b, crm_site si ");
		sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? "); 
		sf.append(" ) ass  ");
		if(StringUtils.isNotBlank(name)) {
			sf.append(" WHERE ass.name = '"+name+"' ");
		}
		if(id != null) {
			sf.append(" and ass.id !="+id+" ");
		}
		return Db.queryLong(sf.toString(),siteId,siteId);
	}
	
	public static List<Record> getNewServiceModeList(String siteId) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT * FROM ( ");
    	sf.append("SELECT * FROM crm_service_mode a ");
    	sf.append(" WHERE a.site_id = '0' AND NOT EXISTS ");
    	sf.append(" ( ");
    	sf.append(" 	SELECT b.* FROM crm_service_mode b, crm_site si ");
    	sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
    	sf.append(" 	) ");
    	sf.append(" UNION ");
    	sf.append(" SELECT b.* FROM crm_service_mode b, crm_site si ");
    	sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? "); 
    	sf.append("  ) ass ORDER BY ass.sort ASC  ");
		return Db.find(sf.toString(),siteId,siteId);
	}
}
