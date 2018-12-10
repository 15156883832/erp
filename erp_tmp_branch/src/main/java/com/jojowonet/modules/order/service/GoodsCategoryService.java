package com.jojowonet.modules.order.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.SQLQuery;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;











import org.hibernate.criterion.Order;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.GoodsCategoryDao;
import com.jojowonet.modules.order.dao.SiteCommonSettingDao;
import com.jojowonet.modules.order.entity.GoodsCategory;
import com.jojowonet.modules.order.entity.SiteCommonSetting;


@Component
@Transactional(readOnly = true)
public class GoodsCategoryService extends BaseService {
	
	@Autowired
	private GoodsCategoryDao goodsCategoryDao;
	@Autowired
	private SiteCommonSettingDao siteCommonSettingDao;
	
	//服务商品牌种类管理

	
    public Page<Record> filterGoodsCate(Page<Record> page,String siteId) {
        List<Record> list =goodsCategoryDao.filterGoodsCate(siteId, page);
        long count = goodsCategoryDao.getListcount(siteId);
        page.setCount(count);
        page.setList(list);

        return page;
    }
	
	@Transactional(readOnly = false)
	public void save( GoodsCategory goodsCategory) {

		goodsCategoryDao.save(goodsCategory);
		
			
	}
	
	@Transactional(readOnly = false)
	public void delete(Integer id) {
	
		goodsCategoryDao.deleteByIds(id);
	}
	

	


	public Record getGoodsById(Integer id, String siteId) {
     Record rd=goodsCategoryDao.getGoodsCateById(id, siteId);
		return rd;
	}



	public void updates(String name, String sort, Integer id) {
		goodsCategoryDao.updates(name,sort,id);
		
	}

	public boolean queryNumByNames(String site_id,String names,Integer id){
		if(id==null){
			List list = goodsCategoryDao.createSqlQuery("select * from crm_goods_category"
					+ " where site_id = :p1 and name = :p2 and status='0' ",new Parameter(site_id,names)).list();
			if (list.size()>0)
				return true;
			return false;
		}else{
			List list = goodsCategoryDao.createSqlQuery("select * from crm_goods_category"
					+ " where site_id = :p1 and name = :p2 and id!=:p3 and status='0' ",new Parameter(site_id,names,id)).list();
			if (list.size()>0)
				return false;
			return true;
		}
		
	}
	//平台商品种类管理
    public Page<Record> filterGoodsCateForplat(Page<Record> page,String userId) {
        List<Record> list =goodsCategoryDao.filterGoodsCateForPlat(userId, page);
        long count = goodsCategoryDao.getListcountForPlat(userId);
        page.setCount(count);
        page.setList(list);

        return page;
    }
	public Record getGoodsByIdForplat(Integer id, String userId) {
	     Record rd=goodsCategoryDao.getGoodsCateByIdForPlat(id, userId);
			return rd;
		}
	
	public boolean queryNumByNamesForplat(String userId,String names,Integer id){
		if(id==null){
			List list = goodsCategoryDao.createSqlQuery("select * from crm_goods_category"
					+ " where create_by = :p1 and name = :p2 and status='0' ",new Parameter(userId,names)).list();
			if (list.size()>0)
				return true;
			return false;
		}else{
			List list = goodsCategoryDao.createSqlQuery("select * from crm_goods_category"
					+ " where create_by = :p1 and name = :p2 and id!=:p3 and status='0' ",new Parameter(userId,names,id)).list();
			if (list.size()>0)
				return false;
			return true;
		}
		
	}
	
	public Record getGoodsSalesSet(String siteId){
		return Db.findFirst("select a.* from crm_site_common_setting a where a.site_id=? and a.type='6' ",siteId);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public String saveSalesSave(String siteId,String id,String salesSet){
		if(StringUtils.isBlank(id)){//未设置过，保存
			SiteCommonSetting scs = new SiteCommonSetting();
			scs.setSetValue(salesSet);
			scs.setType("6");
			scs.setSiteId(siteId);
			siteCommonSettingDao.save(scs);
			return "ok";
		}
		SQLQuery sql = siteCommonSettingDao.getSession().createSQLQuery("update crm_site_common_setting a set a.set_value='"+salesSet+"' where a.id='"+id+"' ");
		sql.executeUpdate();
		return "ok";
	}

}
