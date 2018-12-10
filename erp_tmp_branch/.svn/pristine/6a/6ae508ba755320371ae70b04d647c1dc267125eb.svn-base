/**
 */
package com.jojowonet.modules.order.dao;

import java.util.Date;
import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Brand;



/**
 * 品牌DAO接口
 * @author Ivan
 * @version 2016-08-01
 */
@Repository
public class BrandDao extends BaseDao<Brand> {
	
	public List<Record> getBrandSite(String siteId,String caId){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT sbr.brand_id AS brandId,cb.name FROM crm_site_brand_rel sbr  ");
		sf.append("LEFT JOIN crm_brand cb ON cb.id = sbr.brand_id AND cb.del_flag='0' ");
		sf.append(" WHERE sbr.site_id='"+siteId+"' AND sbr.category_id='"+caId+"' ");
		
		return Db.find(sf.toString());
	}
	
	public List<Record> getbrand(String categerId){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT cb.id as bid,cb.name FROM crm_category_brand_rel cbr ");
		sf.append("LEFT JOIN crm_brand cb ON cb.id = cbr.brand_id AND cb.del_flag='0' ");
		sf.append(" WHERE 1=1 ");
		if(StringUtils.isNotBlank(categerId)){
			sf.append(" and  cbr.category_id ='"+categerId+"' ");
		}
		return Db.find(sf.toString());
		
	}
	
	public List<Record> getBrandList(Page<Record> page){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT *, '1' as ordernum FROM crm_brand WHERE del_flag='0'  ");
		sf.append(page.getSqlOrderBy());
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString());
	}
	
	public long getListcount(){
		String sql = " select count(*) as count from crm_brand where del_flag ='0' ";
		return Db.queryLong(sql);
	}
	
	

	public String getBrandNameById(String id){
		String name = "";
		if(StringUtils.isNotBlank(id)){
			String sql = "SELECT name from crm_brand WHERE id = '"+id+"' and del_flag='0'";
			Record record = Db.findFirst(sql);
			
			if(record != null){
				name = record.getStr("name");
			}
		}
		
		return name;
	}
	//获取当前品牌下的所有关联品类
	public List<Record> getListBrandRel(String id){
		String sql = "SELECT * FROM crm_category_brand_rel a WHERE a.brand_id=? ";
		return Db.find(sql,id);
	}
	//获取当前品牌下的所有关联品类名称以及品牌属性的列表createby yc
public List<Record> getBrandListForCate(Page<Record> page,String brands,String categoryid){
	StringBuffer sf=new StringBuffer();
	sf.append("SELECT * FROM ");
	sf.append("(SELECT  b.name AS name,b.id,b.img,b.vendor,b.first_letter,b.sort,b.del_flag AS del_flag,GROUP_CONCAT(cb.category_id) AS category ");
	sf.append("FROM crm_brand AS b LEFT JOIN crm_category_brand_rel AS cb ON b.id=cb.brand_id  ");
	sf.append("GROUP BY b.id ORDER BY b.sort) AS s WHERE s.del_flag='0' ");
	sf.append(getSettingCondition(brands,categoryid));

	sf.append(page.getSqlOrderBy());
	sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
	return Db.find(sf.toString());
}

public Record getBrandById(Integer id) { 
	StringBuffer sf = new StringBuffer();
	sf.append("SELECT * FROM ");
	sf.append("(SELECT  b.name AS name,b.id AS id,b.img,b.vendor AS vendor,b.first_letter,b.sort,b.del_flag AS del_flag,");
	sf.append("GROUP_CONCAT(cb.category_id) AS category FROM crm_brand AS b ");
	sf.append("LEFT JOIN crm_category_brand_rel AS cb ON b.id=cb.brand_id  GROUP BY b.id ORDER BY b.sort) AS s ");
	sf.append("WHERE s.id=? AND s.del_flag='0'");
	Record rd= Db.findFirst(sf.toString(),id);
	return rd;
}

public long getListcountForCate(String brands, String categoryid){
	StringBuffer sf = new StringBuffer();

	sf.append("SELECT count(distinct b.id) ");
	sf.append("FROM crm_brand AS b LEFT JOIN crm_category_brand_rel AS cb ON b.id=cb.brand_id WHERE del_flag='0' ");
	sf.append(getSettingConditionforcount(brands,categoryid));
	return Db.queryLong(sf.toString());
}
	
public String getSettingCondition(String brands,String categoryid){
	StringBuffer sf = new StringBuffer();
	if(brands != null&&brands.length()!=0){
		sf.append(" AND s.name = '"+brands+"' ");
	}
	if(categoryid!=null&&categoryid.length()!=0){
		sf.append(" AND s.category LIKE '%"+categoryid+"%'"+" ");
	}
	return sf.toString();
}
public String getSettingConditionforcount(String brands,String categoryid){
	StringBuffer sf = new StringBuffer();
	if(brands != null&&brands.length()!=0){
		sf.append(" AND b.name = '"+brands+"' ");
	}
	if(categoryid!=null&&categoryid.length()!=0){
		sf.append(" AND cb.category_id ="+categoryid+"");
	}
	return sf.toString();
}
//删除品牌
public void deleteBrandByIds(Integer id) {
	String sql="UPDATE  crm_brand SET del_flag='1'  WHERE id=?";
	Db.update(sql,id);
}
//更新brand表的信息
public void updatesBrand(String name, String sort, String vendor,
		String first_letter, Integer id,Date updateTime,String upload) {
	String sql="UPDATE  crm_brand SET name=? , sort=? , vendor=? , first_letter=? , update_time=? ,img=?  WHERE id=?";
	Db.update(sql,name,sort,vendor,first_letter,updateTime,upload,id);
	
}
//以下两个方法用来更新brand——category关系表的信息
	public void deleteCate(Integer id) {
		String sql="DELETE FROM crm_category_brand_rel WHERE brand_id="+id;
				Db.update(sql);
		
	}
	public void addBrandRelation(Integer categoryid, Integer id) {
		String sql="INSERT INTO crm_category_brand_rel VALUES(?,?) ";
		Db.update(sql,id,categoryid);
		
	}

//yc

	public boolean addNewRelation(List<Integer> categoryIds, Integer brandId)
	{
		if(categoryIds != null && !categoryIds.isEmpty() && brandId != null)
		{
			String insert = "INSERT INTO crm_category_brand_rel (category_id,brand_id) VALUES";
			String insertValue = "";
			for(Integer categoryId : categoryIds)
			{
				String temp = "("+categoryId+","+brandId+")";
				if(insertValue.length() > 0)
					insertValue += "," + temp;
				else
					insertValue +=  temp;
			}
			insert += " "+insertValue;
			Db.update(insert);
		}
		return true;
	}
	
	public boolean deleteRelation(List<Integer> categoryIds, Integer brandId)
	{
		if(categoryIds != null && !categoryIds.isEmpty() && brandId != null)
		{
			String delete = "DELETE FROM crm_category_brand_rel WHERE brand_id="+brandId;
			String in = "";
			for(Integer categoryId : categoryIds)
			{
				if(in.length() > 0)
					in += ","+categoryId;
				else
					in += categoryId;
			}
			delete += " AND category_id IN ("+in+")";
			Db.update(delete);
		}
		return true;
	}
	
	
	public List<Integer> getAllCategoryIdsByBrandId(Integer brandid)
	{
		List<Integer> categoryIds = Lists.newArrayList();
		if(brandid != null)
		{
			String query = "SELECT category_id FROM crm_category_brand_rel WHERE brand_id="+brandid;
			List<Record> records = Db.find(query);
			if(records != null)
			{
				for(Record record : records)
				{
					Integer categoryid = record.getInt("category_id");
					if(categoryid != null)
						categoryIds.add(categoryid);
				}
			}
		}
		return categoryIds;
	}
	
	/**
	 * 将用户更改后的品牌信息同步到数据库中.
	 *
	 * @param brand 品牌实体类对象
	 * @return 更新成功
	 */
	public boolean updateModify(Brand brand)
	{
		if(brand != null)
		{
			Integer id = brand.getId();
			String brandName = brand.getName();
			String vendor = brand.getVendor();
			String img = brand.getImg();
			String firstLetter = brand.getFirstLetter();
			StringBuffer update = new StringBuffer("UPDATE crm_brand SET");
			if(brandName != null && !brandName.isEmpty())
				update.append(" name='"+brandName+"'");
			if(vendor != null && !vendor.isEmpty())
				update.append(" , vendor='"+vendor+"'");
			if(img != null && !img.isEmpty())
				update.append(" , img='"+img+"'");
			if(firstLetter != null && !firstLetter.isEmpty())
				update.append(", first_letter='"+firstLetter+"'");
			//当前时间
			Date date = new Date();
			//修改时间格式
			String datetime = DateUtils.formatDateTime(date);
			update.append(",update_time='"+datetime+"'");
			if(id != null)
			{
				update.append(" WHERE id="+id);
				Db.update(update.toString());
			}
			//如果类型也被更改了，那么要更新crm_category_brand_rel表
//			Long  categoryId = brand.getCategoryid();
//			if(categoryId != null)
//			{
//				String query = "UPDATE crm_category_brand_rel SET category_id="+categoryId+" WHERE brand_id="+id;
//				Db.update(query);
//			}
		}
		return true;
	}
	
	public List<Record> getSiteBrandRelList1(String siteId){
		String sql = "SELECT a.* FROM crm_brand a WHERE a.id in(SELECT r.brand_id  FROM crm_site_brand_rel r WHERE r.site_id='"+siteId+"')";
		List<Record> list = Db.find(sql);
		return list;
	}





	
}
