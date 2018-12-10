package com.jojowonet.modules.goods.dao;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.entity.GoodsSiteSelf;

@Repository
public class GoodsSiteSelfDao extends BaseDao<GoodsSiteSelf>{

	//查询所有对应商品
	public List<Record> getAllSiteInfo(Page<Record> page, String siteId,
			Map<String, Object> map){
		List<Record> re=new ArrayList<Record>();
		StringBuffer sb=new StringBuffer();
		sb.append("select id,sort_num,icon,number,name,brand,category,stocks,unit,site_price,employe_price,customer_price,rebate_price,source,ss.sell_flag ");
		sb.append(" from crm_goods_siteself ss");
		sb.append(" where ss.site_id='"+siteId+"' and ss.status='0'");
		sb.append(getqueryCriteria(map));
		sb.append(" order by ss.sort_num asc,ss.create_time desc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
		re=Db.find(sb.toString());
		return re;
	}
	

	
	//计算对应商品数量
	public Long getCount(String siteId,Map<String, Object> map){
		StringBuffer sb=new StringBuffer();
		sb.append("select count(*) from crm_goods_siteself ss");
		sb.append(" where ss.site_id='"+siteId+"' and ss.status='0'");
		sb.append(getqueryCriteria(map));
		return Db.queryLong(sb.toString());
	}
	
	//查询条件
	public String getqueryCriteria(Map<String, Object> ma) {
		StringBuffer sf = new StringBuffer();
		if (StringUtils.isNotEmpty(   (CharSequence) ma.get("number")  ) ) {
			String numb=ma.get("number").toString().trim();
			sf.append(" and ss.number like '%" + numb + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("name"))) {
			String name = ma.get("name").toString().trim();
			sf.append(" and ss.name like '%" + name + "%' ");	
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("category"))) {  
			sf.append(" and ss.category = '" + ma.get("category") + "' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("sellFlag"))) {
			sf.append(" and ss.sell_flag = '" + ma.get("sellFlag") + "' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("source"))) {
			sf.append(" and ss.source = '" + ma.get("source") + "' ");
		}
		return sf.toString();
	}
	
	//查询服务商自营商品列表
	public List<Record> loadSiteGoodsList(Map<String,Object> map,String siteId,Page<Record> page){
		List<Record> re=new ArrayList<Record>();
		StringBuffer sb=new StringBuffer();
		sb.append("select id,sort_num,icon,number,name,brand,model,category,stocks,unit,site_price,employe_price,customer_price,rebate_price,source,ss.sell_flag ");
		sb.append(" from crm_goods_siteself ss");
		sb.append(" where ss.site_id='"+siteId+"' and ss.status='0'");
		sb.append(getqueryCriteria(map));
		sb.append(" order by ss.sort_num asc,ss.create_time desc");
		Integer pg = page.getPageNo();
		Integer pgs = page.getPageSize();
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
/*		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
*/		return Db.find(sb.toString());
	}
	
	//查询服务商自营商品数量
	public Long loadSiteGoodsListCount(Map<String, Object> map,String siteId){
		StringBuffer sb=new StringBuffer();
		sb.append("select count(*) from crm_goods_siteself ss");
		sb.append(" where ss.site_id='"+siteId+"' and ss.status='0'");
		sb.append(getqueryCriteria(map));
		return Db.queryLong(sb.toString());
	}
	
	
}
