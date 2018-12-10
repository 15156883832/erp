package com.jojowonet.modules.order.utils;



import ivan.common.utils.CacheUtils;
import ivan.common.utils.SpringContextHolder;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.CategoryDao;
import com.jojowonet.modules.order.entity.Category;


/**
 * 类目工具类
 * 
 * @version 2014-07-29
 */
public class CategoryUtils {
	private static CategoryDao categoryDao = SpringContextHolder
			.getBean(CategoryDao.class);

	public static final String CACHE_KEY = "CRM_CATEGORY";
	
	public static List<Category> getCategoryList() {
		@SuppressWarnings("unchecked")
		List<Category> categoryList = (List<Category>) CacheUtils.get(CACHE_KEY);
		if(categoryList==null){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
			categoryList = categoryDao.findAllList(siteId);
			CacheUtils.put(CACHE_KEY, categoryList);
		}
		return categoryList;
	}

	public static Map<String, String> getAllCategorysAsMap()
	{
		LinkedHashMap<String, String> maps = new LinkedHashMap<String, String>();
		String query = "SELECT  id,name FROM crm_category WHERE del_flag='0' ";
		List<Record> records = Db.find(query);
		if(records != null)
		{
			for(Record record : records)
			{
				//Integer id = record.getInt("id");
				String name = record.getStr("name");
				if(name != null)
					maps.put(name, name);
			}
		}
		return maps;
	}
	
	public static Integer getSiteCategoryId(String name,String siteId) {
		return categoryDao.getCategoryName(name,siteId);
	}
	
	public static String getSiteCategoryId1(String name,String siteId) {
		return categoryDao.getCategoryName1(name,siteId);
	}

	public static List<Record> getListCategorySite(String siteId){
		return categoryDao.getCategorySiteId(siteId);
	}

	public static List<Record> getCategoryNameSiteId(String siteId) {
		return categoryDao.getCategoryNameSiteId(siteId);
	}
	
	public static String getCategoryName(String cateStr){
		String cname = "";
			if(StringUtils.isNotBlank(cateStr)){
				String[] strs = cateStr.split(",");
				Category c =  categoryDao.get(Integer.valueOf(strs[0]));
				if(c != null){
					cname = c.getName();
				}
			}
		return cname;
	}
	
	public static List<Category> getCategoryList(String cateStr){
		String[] strs = cateStr.split(",");
		return categoryDao.getListByIds(strs);
	}
	
	public static Map<String, String> getSiteCategory(String siteId, Integer brand) {
	    Map<String, String> map = new HashMap<String, String>();
	    StringBuilder sb = new StringBuilder();
	    sb.append(" SELECT DISTINCT a.id, a.name FROM crm_category a    ");
	    sb.append("  LEFT JOIN crm_site_brand_rel b ON b.category_id=a.id ");
	    sb.append(" WHERE a.del_flag='0' AND a.site_id= '"+siteId+"' ");
	    if(brand != null){
	    	sb.append(" AND b.brand_id='"+brand+"' ");
	    }
	     
		List<Record> re = Db.find(sb.toString());
		Record strArray[] = new Record[re.size()];
		 re.toArray(strArray);
		 if(strArray.length > 0){
			//if(re != null) {
				for(Record rdco : re){
				    String name = rdco.getStr("name");
					map.put(name, name);
				}
			//}
		 }
		return map;
	}
	
	public static List<Category> getCategoryList2() {
		List<Record> result = Db.find("select * from crm_category where del_flag='0' AND site_id=''");
		List<Category> ret = new ArrayList<>();
		for(Record r : result) {//将result结果循环赋值给Record的对象r;
			Category c = new Category();//然后new一个category的对象c，一次将对象r中的值赋给c
			c.setId(r.getInt("id"));
			c.setName(r.getStr("name"));
			ret.add(c);
		}
		return ret;
	}
	
	public static List<Category> getCategorySiteList(String category){
		List<Category> list = Lists.newArrayList();
		String[] strc = category.split(",");
		list = categoryDao.getListByIds(strc);//String []  strc
		return list;
	}
	
	public static List<Category> getSiteCategoryList(String siteId){
		return categoryDao.getListCate(siteId);
	}

	public static List<Category> getSiteCategoryListfornotnull(String siteId) {
		return categoryDao.getListCatenotnull(siteId);
	}
	
}
