package com.jojowonet.modules.order.service;


import java.util.Date;
import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.BrandDao;
import com.jojowonet.modules.order.dao.CategoryDao;
import com.jojowonet.modules.order.entity.Brand;


/**
 * 家电品牌设置Service
 * @author yc
 * @version 2017-06-01
 */
@Component
@Transactional(readOnly = true)
public class BrandSettleService extends BaseService {
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private CategoryDao categoryDao;
	
	//查询出品牌基本信息以及对应的品类关系列表
    public Page<Record> findbrand(Page<Record> page,String brands,String categoryid) {
        List<Record> list =brandDao.getBrandListForCate(page,brands,categoryid);
      for (Record rd : list) {//将对应的所属种类id转换成对应的名称
    	  if(rd.getStr("category")!=null){
    		  String[] cate=rd.getStr("category").split(",");
	           String[] catename=new String[cate.length];
	        for(int i=0;i<cate.length;i++){
		         catename[i]=categoryDao.getCategoryNameById(cate[i]);
	            }
	          rd.set("category", catename.clone());
        }
    	  }
	          
        long count = brandDao.getListcountForCate(brands, categoryid);
        page.setCount(count);
        page.setList(list);
        return page;
    }
    
    //删除品牌
	@Transactional(readOnly = false)
	public void deleteBrandById(Integer id) {
		brandDao.deleteBrandByIds(id);
	}
 
	//通过id获取品牌基本信息
	public Record getBrandById(Integer id) {
	     Record rd=brandDao.getBrandById(id);
			return rd;
		}

	
	//修改和添加时查询是否重名
	public boolean queryBrandById(String names, Integer id) {
		if(id!=null){
			List list = brandDao.createSqlQuery("select * from crm_brand"
					+ " where name = :p1 and id!=:p2 and del_flag='0'  ",new Parameter(names,id)).list();
			if (list.size()>0)
				return false;
			return true;
		}else{
			List list = brandDao.createSqlQuery("select * from crm_brand"
					+ " where  name = :p1 and del_flag='0'  ",new Parameter(names)).list();
			if (list.size()>0)
				return false;
			return true;
		}
	}
	
//更新品牌基本信息分为两部1：更新基本信息，2：更新品牌品类信息表
	public void updatesBrand(String name, Integer id, String sort,
			String[] categorylist, String vendor, String first_letter,String upload) {
		Date updateTime=new Date();
		brandDao.updatesBrand(name,sort,vendor,first_letter,id,updateTime,upload);
				//brandDao.deleteCate(id);
		/*		if(categorylist!=null){
					for(int i=0;i<categorylist.length;i++){
						Integer categoryid=Integer.valueOf(categorylist[i]);
						brandDao.addBrandRelation(categoryid,id);
					}
				}*/
		
		
	}

	//添加品牌信息方式与更新相同
	public void save(Brand brand, String[] categorylist) {
		
		brandDao.save(brand);
		Integer brand_id=brand.getId();
/*		if(categorylist!=null){
			for(int i=0;i<categorylist.length;i++){
				Integer categoryid=Integer.valueOf(categorylist[i]);
				brandDao.addBrandRelation(categoryid,brand_id);
			}
		}*/

		
		
	}


}
