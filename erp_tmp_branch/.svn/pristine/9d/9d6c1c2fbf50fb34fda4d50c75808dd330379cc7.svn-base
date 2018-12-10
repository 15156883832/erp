package com.jojowonet.modules.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.entity.GoodsEmployeOwn;
import com.jojowonet.modules.order.utils.CrmUtils;

@Repository
public class GoodsEmployeOwnDao extends BaseDao<GoodsEmployeOwn> {

	// 查询工程师领取商品库存
	public List<Record> getAllSiteInfo(Page<Record> page, String siteId,
			Map<String, Object> map) {
		List<Record> re = new ArrayList<Record>();
		StringBuffer sb = new StringBuffer();
		sb.append("select s.icon,eo.id,eo.good_number,eo.good_id,e.name as empName,s.source,s.name as goodsName,s.number as goodsNumber,s.model as goodsModel,s.brand,s.category,eo.stocks,s.unit,s.site_price,s.customer_price,s.employe_price,s.description  ");
		sb.append(" from crm_goods_employe_own eo");
		sb.append(" left join crm_employe e on eo.employe_id=e.id");
		sb.append(" left join crm_goods_siteself s on eo.good_id=s.id");
		sb.append(" where eo.site_id='" + siteId + "' and s.status='0' and eo.stocks > 0 ");
		sb.append(getqueryCriteria(map));
		sb.append(" order by s.sort_num asc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
		re=Db.find(sb.toString());
		return re;
	}
	
	// 查询工程师自购商品库存
	public List<Record> getAllSiteInfogm(Page<Record> page, String siteId,
			Map<String, Object> map) {
		List<Record> re = new ArrayList<Record>();
		StringBuffer sb = new StringBuffer();
		sb.append("select s.icon,eo.id,eo.good_number,eo.zg_stocks,eo.good_id,e.name as empName,s.source,s.name as goodsName,s.number as goodsNumber,s.model as goodsModel,s.brand,s.category,eo.stocks,s.unit,s.site_price,s.customer_price,s.employe_price,s.description  ");
		sb.append(" from crm_goods_employe_own eo");
		sb.append(" left join crm_employe e on eo.employe_id=e.id");
		sb.append(" left join crm_goods_siteself s on eo.good_id=s.id");
		sb.append(" where eo.site_id='" + siteId + "' and s.status='0' and eo.zg_stocks is not null and eo.zg_stocks > 0 ");
		sb.append(getqueryCriteria(map));
		sb.append(" order by s.sort_num asc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
		re=Db.find(sb.toString());
		return re;
	}
	
	// 查询工程师商品库存excel


	// 计算对应商品数量
	public Long getCount(String siteId, Map<String, Object> map) {
		StringBuffer sb = new StringBuffer();
		sb.append("select count(*) from crm_goods_employe_own eo");
		sb.append(" left join crm_employe e on eo.employe_id=e.id");
		sb.append(" left join crm_goods_siteself s on eo.good_id=s.id");
		sb.append(" where eo.site_id='" + siteId + "' and s.status='0' and eo.stocks > 0 ");
		sb.append(getqueryCriteria(map));
		return Db.queryLong(sb.toString());
	}
	
	//自购困村总条数
	public Long getCountgm(String siteId, Map<String, Object> map) {
		StringBuffer sb = new StringBuffer();
		sb.append("select count(*) from crm_goods_employe_own eo");
		sb.append(" left join crm_employe e on eo.employe_id=e.id");
		sb.append(" left join crm_goods_siteself s on eo.good_id=s.id");
		sb.append(" where eo.site_id='" + siteId + "' and s.status='0' and eo.zg_stocks is not null and eo.zg_stocks > 0 ");
		sb.append(getqueryCriteria(map));
		return Db.queryLong(sb.toString());
	}

	// 查询条件
	public String getqueryCriteria(Map<String, Object> ma) {
		StringBuffer sf = new StringBuffer();

		if (StringUtils.isNotEmpty((CharSequence) ma.get("employeName"))) {
			String number = ma.get("employeName").toString().trim();
			sf.append(" and eo.employe_id like '%" + number + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("number"))) {
			sf.append(" and s.number like '%" + ma.get("number") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("name"))) {
			String name = ma.get("name").toString().trim();
			sf.append(" and s.name like '%" +name + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("suitCategory"))) {
			sf.append(" and s.category = '" + ma.get("suitCategory") + "' ");
		}
		return sf.toString();
	}

	// 根据商品id查询记录数
	public long getByGoodId(String gId,String emId,String siteId) {
		String sql = "select count(*) from crm_goods_employe_own eo where eo.good_id='"+ gId + "' and eo.employe_id='"+emId+"' and eo.site_id='"+siteId+"'";
		return Db.queryLong(sql);
	}

	// 工程师领取商品
	public void LQ(Map<String, Object> map) {
		String site_id = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String sql = "update crm_goods_employe_own set stocks=stocks+"
				+ map.get("cnum") + ",receives=receives+" + map.get("cnum")
				+ " where good_id='" + map.get("id") + "' and employe_id='"
				+ map.get("empId") + "' and site_id='" + site_id + "'";
		Db.update(sql);
	}
}
