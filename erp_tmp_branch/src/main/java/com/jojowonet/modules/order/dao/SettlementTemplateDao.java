/**
 */
package com.jojowonet.modules.order.dao;

import java.util.ArrayList;
import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SettlementTemplate;
import com.jojowonet.modules.order.utils.SqlKit;

/**
 * 结算措施DAO接口
 * @author Ivan
 * @version 2017-05-26
 */
@Repository
public class SettlementTemplateDao extends BaseDao<SettlementTemplate> {
	
	
	public List<SettlementTemplate> getListSet(String category,String siteId){
		List<SettlementTemplate> list = Lists.newArrayList();
		StringBuilder sf = new StringBuilder();
		sf.append(" SELECT DISTINCT service_measures,category FROM crm_site_settlement_template WHERE status='0' AND site_id ='"+siteId+"' ");
		if(StringUtils.isNotEmpty(category)){
			sf.append(" AND category = '"+category+"' ");
		}
		List<Record> record = Db.find(sf.toString());
		if(record != null){
			for(Record cord : record){
				String serviceMeasures = cord.getStr("service_measures");
				SettlementTemplate ma = new SettlementTemplate();
				ma.setServiceMeasures(serviceMeasures);
				ma.setCategory(cord.getStr("category"));
				list.add(ma);
			}
		}
		
		return list;
	}
	
	
	public List<Record> getListSetMea(String category, String serviceMeasures, String siteId,String warrantyType) {
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT * FROM crm_site_settlement_template WHERE ");
		sf.append(" service_measures='" + serviceMeasures + "' AND site_id='" + siteId + "' AND status='0' ");
		if(StringUtils.isNotEmpty(category)){
			sf.append(" AND category = '"+category+"' ");
		}
		if(StringUtils.isNotEmpty(warrantyType)){
			sf.append(" and warranty_type ='"+warrantyType+"'");
		}
		return Db.find(sf.toString());
	}
	
	public Record getSettlementId(String id){
		String sql ="SELECT * FROM crm_site_settlement_template  WHERE id= ?";
		return Db.findFirst(sql,id);
	}


	public List<String> serviceMeasures(String siteId, Integer category, String searchType, int limit, int pageNo){
		List<String> list = new ArrayList<>();
		SqlKit kit = new SqlKit();
		kit.append("SELECT DISTINCT a.service_measures FROM crm_site_settlement_template a ,crm_category b  ")
				.append("where   a.category=b.name AND b.id ='"+ category +"' and a.status='0' AND a.site_id ='"+siteId+"' ");
		if(StringUtils.isNotBlank(searchType)) {//服务措施
			kit.append("AND a.service_measures like '%" + searchType+"%'");
		}
		kit.last("order by a.create_time desc "+"LIMIT " + limit + " offset " + (pageNo-1)*limit);

		String sql =kit.toString();
		List<Record> rds = Db.find(sql);
		for(Record rd : rds){
			String serviceMeasures = rd.getStr("service_measures");
			list.add(serviceMeasures);
		}
		return list;
	}
	public long getCount(String siteId,Integer categroy, String type){
		String sql;
		if(ivan.common.utils.StringUtils.isBlank(type)) {
			sql = "SELECT count(DISTINCT a.service_measures) as count FROM crm_site_settlement_template a ,crm_category b WHERE a.category=b.name AND b.id = '" + categroy + "' and a.status='0' AND a.site_id ='" + siteId + "'";
		} else {
			sql = "SELECT count(DISTINCT a.service_measures) as count FROM crm_site_settlement_template a ,crm_category b WHERE a.category=b.name AND b.id = '" + categroy + "' and a.status='0' AND a.site_id ='" + siteId + "' AND a.service_measures like '%" + type+"%'";
		}
		return Db.queryLong(sql);
	}
	
	public List<SettlementTemplate> het(String type,String siteId,Integer categroy){
		List<SettlementTemplate> list = Lists.newArrayList();
		String sql ="SELECT a.* FROM crm_site_settlement_template a ,crm_category b WHERE a.category=b.name AND b.id = '"+categroy+"' and a.service_measures ='"+type+"'  and a.status='0' AND a.site_id ='"+siteId+"' order by a.create_time desc";
		List<Record> record = Db.find(sql);
		for(Record rd : record){
			SettlementTemplate mal = new SettlementTemplate();
			String chargeName = rd.getStr("charge_name");
			Integer pro = rd.getInt("charge_proportion");
			mal.setId(rd.getStr("id"));
			mal.setChargeName(chargeName);;
			mal.setBasisAmount(rd.getBigDecimal("basis_amount").doubleValue());
			mal.setChargeAmount(rd.getBigDecimal("charge_amount").doubleValue());
			mal.setSiteId(rd.getStr("site_id"));
			mal.setCategory(rd.getStr("category"));
			if(pro != null){
				mal.setChargeProportion(rd.getInt("charge_proportion"));
			}
			mal.setServiceMeasures(rd.getStr("service_measures"));
			mal.setWarrantyType(rd.getStr("warranty_type"));
			mal.setBasisType(rd.getStr("basis_type"));
			list.add(mal);
		}
		return list;
	}
	
	//删除该品类下服务措施为service_measures所有信息
	public void delectSet(String cate,String siteId,String service_measures){
		String sql = " UPDATE crm_site_settlement_template SET status='1'  WHERE site_id=? AND category=? AND service_measures=? ";
		Db.update(sql,siteId,cate,service_measures);
	}
	

}
