/**
 */
package com.jojowonet.modules.order.dao;

import com.jojowonet.modules.order.utils.SqlKit;
import ivan.common.persistence.BaseDao;
import ivan.common.utils.IdGen;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Malfunction;

/**
 * 故障类别DAO接口
 * @author Ivan
 * @version 2016-08-02
 */
@Repository
public class MalfunctionDao extends BaseDao<Malfunction> {
	
	
	private SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	
	public Map<String ,String > getMalfunction(String category,String siteId){
		HashMap<String, String> malfunction = new HashMap<String, String>();
		String sql ="";
		List<Record> record = Db.find(sql);
		if(record != null){
			for(Record cord : record){
				String name = cord.getStr("type");
				malfunction.put(name, name);
			}
		}
		return malfunction;
	}
	
	public List<Malfunction> getListMal(String category,String siteId){
		List<Malfunction> list = Lists.newArrayList();
		String sql = "SELECT DISTINCT type,category FROM crm_malfunction WHERE  category = '"+category+"' AND status='0' AND (site_id ='"+siteId+"' OR user_type='1') ";
		List<Record> record = Db.find(sql);
		if(record != null){
			for(Record cord : record){
				String type = cord.getStr("type");
				Malfunction ma = new Malfunction();
				ma.setType(type);
				ma.setCategory(cord.getStr("category"));
				list.add(ma);
			}
		}
		
		return list;
	} 
	
	
//	public List<Record> getList(String siteId,Page<Record> page ,String category){
//		StringBuffer sf = new StringBuffer();
//		sf.append("SELECT * FROM crm_malfunction WHERE  category = '"+category+"' and status='0' AND (site_id ='"+siteId+"' OR user_type='1')");
//		sf.append("LIMIT " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
//		return Db.find(sf.toString());
//	}
	
	public long getCount(String siteId,Integer categroy, String type){
		String sql;
		if(ivan.common.utils.StringUtils.isBlank(type)) {
			sql = "SELECT count(DISTINCT a.type) as count FROM crm_malfunction a ,crm_category b WHERE a.category=b.name AND b.id = '" + categroy + "' and a.status='0' AND (a.site_id ='" + siteId + "' OR a.user_type='1')";
		} else {
			sql = "SELECT count(DISTINCT a.type) as count FROM crm_malfunction a ,crm_category b WHERE a.category=b.name AND b.id = '" + categroy + "' and a.status='0' AND (a.site_id ='" + siteId + "' OR a.user_type='1') AND a.type like '%" + type+"%'";
		}
		return Db.queryLong(sql);
	}

	public List<Malfunction> het(String type,String siteId,Integer categroy){
		List<Malfunction> list = Lists.newArrayList();
		String sql ="SELECT a.* FROM crm_malfunction a ,crm_category b WHERE a.category=b.name AND b.id = '"+categroy+"' and a.type ='"+type+"'  and a.status='0' AND (a.site_id ='"+siteId+"' OR a.user_type='1') order by a.create_time desc";
		List<Record> record = Db.find(sql);
		for(Record rd : record){
			Malfunction mal = new Malfunction();
			String solution = rd.getStr("solution");
			mal.setId(rd.getStr("id"));
			mal.setSolution(solution);
			mal.setDescription(rd.getStr("description"));
			mal.setUserType(rd.getStr("user_type"));
			list.add(mal);
		}
		return list;
	}
	
	public List<String> gettype(String siteId, Integer category, String searchType, int limit, int pageNo){
		List<String> list = new ArrayList<>();
		SqlKit kit = new SqlKit();
		kit.append("SELECT DISTINCT a.type FROM crm_malfunction a ,crm_category b  ")
				.append("where   a.category=b.name AND b.id ='"+ category +"' and a.status='0' AND (a.site_id ='"+siteId+"' OR a.user_type='1')");
		if(StringUtils.isNotBlank(searchType)) {
			//kit.append("AND `a.type` like '%" + searchType+"%'");
			kit.append("AND a.type like '%" + searchType+"%'");
		}
		kit.last("order by a.create_time desc "+"LIMIT " + limit + " offset " + (pageNo-1)*limit);

//		String sql ="SELECT DISTINCT type FROM crm_malfunction where category = '"+ category +"' and status='0' AND (site_id ='"+siteId+"' OR user_type='1') order by create_time desc "+"LIMIT " + limit + " offset " + (pageNo-1)*limit;
		String sql =kit.toString();
		List<Record> rds = Db.find(sql);
		for(Record rd : rds){
			String type = rd.getStr("type");
			list.add(type);
		}
		return list;
	}
	
	public  void saveMal(String category,String type,List<Malfunction> list){
		List<String> li = Lists.newArrayList();
		for(int i=0;i<list.size();i++){
			String siteId = list.get(i).getSiteId();
			if(StringUtils.isBlank(siteId) || "null".equalsIgnoreCase(siteId)){
				siteId = null;
			}else{
				siteId = "'"+siteId+"'";
			}
			String sql ="INSERT INTO crm_malfunction VALUES ('"+IdGen.uuid()+"', '"+category+"', '"+type+"', '"+list.get(i).getDescription()+"', '"+list.get(i).getSolution()+"', '"+time.format(new Date())+"', '"+list.get(i).getCreateBy()+"', '0', '"+list.get(i).getUserType()+"', "+siteId+");";		
			li.add(sql);
		}
	   Db.batch(li, li.size());
	}
	
	
	public void delectMal(String category,String type,String siteId){
		String sql ="DELETE FROM crm_malfunction WHERE site_id = '"+siteId+"' AND category='"+category+"' AND type='"+type+"'";
		Db.update(sql);
	}

	public void delectPlatformMal(String category,String type){
		String sql ="DELETE FROM crm_malfunction WHERE category='"+category+"' AND type='"+type+"' AND `user_type`='1'";
		Db.update(sql);
	}

	public List<Record> getListMal(String category, String type, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT * FROM crm_malfunction WHERE category='" + category + "' ");
		sf.append(" AND type='" + type + "' AND site_id='" + siteId + "' AND status='0'");
		return Db.find(sf.toString());
	}
	
	public void delectMalfuncton(String category,String type,String siteId){
		String sql ="UPDATE crm_malfunction SET status='1' WHERE category='"+category+"' AND type='"+type+"' AND site_id='"+siteId+"' ";
		Db.update(sql);
	}

	public void delectPlatformMalfuncton(String category, String type) {
		String sql = "UPDATE crm_malfunction SET status='1' WHERE category='" + category + "' AND type='" + type + "' AND `user_type`='1'";
		Db.update(sql);
	}
}
