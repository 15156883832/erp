package com.jojowonet.modules.order.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.jojowonet.modules.order.entity.GoodsCategory;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;


@Repository
public class GoodsCategoryDao extends BaseDao<GoodsCategory> {
	//服务商的商品种类管理
	public List<Record> filterGoodsCate(String siteId, Page<Record> page) {
		List<Record> list=new ArrayList<Record>();
		SqlKit kit = new SqlKit();
		if(siteId !=null){
			 kit = new SqlKit()
			.append(" SELECT * FROM crm_goods_category WHERE site_id=? and status='0' ORDER BY sort ASC ");
			if(page !=null){
				kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
			}
			 list =Db.find(kit.toString(), siteId);
		}else{
			 kit = new SqlKit()
			.append(" SELECT * FROM crm_goods_category WHERE site_id IS NULL AND status='0' ORDER BY sort ASC ");
			if(page !=null){
				kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
			}
			list= Db.find(kit.toString());
		}
		return list;
				
		
	}
	
	public long getListcount(String siteId){
		String sql="";
		if(siteId!=null){
			 sql = " select count(*) as count from crm_goods_category where status ='0' and site_id='"+siteId+"'";
		}else{
			 sql = " select count(*) as count from crm_goods_category where status ='0' and site_id IS NULL";
		}
		
		return Db.queryLong(sql);
	}

	public Record getGoodsCateById(Integer id, String siteId) {
		String sql="";
		if(siteId!=null){
			sql="SELECT * FROM crm_goods_category WHERE site_id=?  AND id=? ";
			 return  Db.findFirst(sql, siteId,id);	
		}else{
			sql="SELECT * FROM crm_goods_category WHERE site_id IS NULL  AND id=? ";
			return Db.findFirst(sql,id);	
		}

	}

	public void updates(String name, String sort, Integer id) {
String sql="UPDATE crm_goods_category SET name=? ,sort=? WHERE id=?";
Db.update(sql, name,sort,id);
		
	}

	public void deleteByIds(Integer id) {
		String sql="UPDATE crm_goods_category SET status='1'  WHERE id=?";
		Db.update(sql,id);
		
	}
	//平台商品种类管理
	public List<Record> filterGoodsCateForPlat(String userId, Page<Record> page) {
		SqlKit kit = new SqlKit()
				.append(" SELECT * FROM crm_goods_category WHERE create_by=? and status='0' ORDER BY sort ASC ");
				if(page !=null){
					kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
				}
		return Db.find(kit.toString(), userId);
	}
	public long getListcountForPlat(String userId){
		String sql = " select count(*) as count from crm_goods_category where status ='0' and create_by='"+userId+"'";
		return Db.queryLong(sql);
	}

	public Record getGoodsCateByIdForPlat(Integer id, String userId) {
	String sql="SELECT * FROM crm_goods_category WHERE create_by=?  AND id=? ";
		Record rd= Db.findFirst(sql, userId,id);
		return rd;
	}

/*	public void updatesForPlat(String name, String sort, Integer id) {
String sql="UPDATE crm_goods_category SET name=? ,sort=? WHERE id=?";
Db.update(sql, name,sort,id);
		
	}

	public void deleteByIdsForPlat(Integer id) {
		String sql="UPDATE crm_goods_category SET status='1'  WHERE id=?";
		Db.update(sql,id);
		
	}*/

}
