package com.jojowonet.modules.order.dao;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.ServiceType;
import com.jojowonet.modules.order.utils.SqlKit;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.utils.StringUtils;

@Repository
public class ServiceTypeDao extends BaseDao<ServiceType> {
	
	
	public List<Record> filterServiceType(Page<Record> page) {
		SqlKit kit = new SqlKit()
				.append(" SELECT * FROM crm_service_type WHERE  status='0' and site_id='0' ORDER BY sort ASC ");
				if(page !=null){
					kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
				}
		return Db.find(kit.toString());
	}

	public Record getServiceTypeById(Integer id) {
	String sql="SELECT * FROM crm_service_type WHERE id=? ";
		Record rd= Db.findFirst(sql,id);
		return rd;
	}

	public void updates(String name, String sort, Integer id) {
	String sql="UPDATE crm_service_type SET name=? ,sort=? WHERE id=?";
	Db.update(sql, name,sort,id);
		
	}
	public void deleteByIds(Integer id) {
		String sql="UPDATE crm_service_type SET status='1'  WHERE id=?";
		Db.update(sql,id);
		
	}
	
	public List<Record> getSiteServiceType(Page<Record> page,String siteId) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT * FROM ( ");
    	sf.append(getServiceTypeSql());
    	sf.append("  ) ass ORDER BY ass.sort ASC  ");
		if(page !=null){
			sf.append("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sf.toString(),siteId,siteId);
	}
	private static String getServiceTypeSql() {
		StringBuilder sf = new StringBuilder();
    	sf.append("SELECT * FROM crm_service_type a ");
    	sf.append(" WHERE a.site_id = '0' AND a.status = '0' AND NOT EXISTS ");
    	sf.append(" ( ");
    	sf.append(" 	SELECT b.* FROM crm_service_type b, crm_site si ");
    	sf.append(" WHERE b.parent_id = a.id AND b.site_id = si.id AND b.status = '1' AND si.id = ? ");
    	sf.append(" 	) ");
    	sf.append(" UNION ");
    	sf.append(" SELECT b.* FROM crm_service_type b, crm_site si ");
    	sf.append(" WHERE b.site_id = si.id AND b.status = '0' AND si.id = ? "); 
    	return sf.toString();
	}
	
	public long getSiteServiceTypeCount(String siteId,String name,Integer id) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT COUNT(*) FROM ( ");
		sf.append(getServiceTypeSql());
		sf.append(" ) ass  ");
		if(StringUtils.isNotBlank(name)) {
			sf.append(" WHERE ass.name = '"+name+"' ");
		}
		if(id != null) {
			sf.append(" and ass.id !="+id+" ");
		}
		return Db.queryLong(sf.toString(),siteId,siteId);
	}
	
	public static List<Record> getServiceTypeList(String siteId) {
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT * FROM ( ");
    	sf.append(getServiceTypeSql());
    	sf.append("  ) ass ORDER BY ass.sort ASC  ");
		return Db.find(sf.toString(),siteId,siteId);
	}

}
