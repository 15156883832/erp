package com.jojowonet.modules.order.dao;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.utils.StringUtils;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Category;



@Repository(value = "CategoryDao")
public class CategoryDao extends BaseDao<Category>  {

	@Autowired
	private SfCacheService sfCacheService;
	
	public List<Category> findAllList(String siteId) {
		return find("from Category where delFlag ='0' and siteId =:p1 ",new Parameter(siteId));
	}
	
	public String getCategoryNameById(String id){
		String name = "";
		if(StringUtils.isNotBlank(id)){
			String sql = "SELECT name from crm_category WHERE id = '"+id+"' and del_flag='0'";
			Record record = Db.findFirst(sql);
			
			if(record != null){
				name = record.getStr("name");
			}
		}
		
		return name;
	}
	

	public Long getCategoryId(String name) {
		Long id=null;
		String query = "SELECT id FROM crm_category WHERE NAME='"+name+"'";
		Record record=Db.findFirst(query);
		if(record==null){
			
		}else{
			id=record.getLong("id");
		}
		return id;
	}
	public Integer getCategoryName(String name,String siteId) {
		
		String query = "SELECT id FROM crm_category WHERE site_id=? AND name='"+name.trim()+"'";
		Record record=Db.findFirst(query,siteId);
		if(record!=null){
			return record.getInt("id");
		}
		return null;
	}

	public String getCategoryName1(String name, String siteId) {
		String[] str = name.split(",");
		String names = "";
		String names1 = "";
		String ids = "";
		for (String st : str) {
			if ("".equals(names)) {
				names = "'" + st.trim() + "'";
			} else {
				names = names + ",'" + st.trim() + "'";
			}
		}
		Set<String> set = new HashSet<>();
		set.addAll(Arrays.asList(str));
		str = set.toArray(new String[set.size()]);
		names1 = StringUtils.join(str, ",");
		String[] str1 = names1.split(",");//去重之后的数组
		Long count = Db.queryLong("select count(*) from crm_category a where a.del_flag='0' and a.site_id='" + siteId + "' AND a.name in(" + names + ") ");
		String query = "SELECT id FROM crm_category a WHERE a.site_id=? AND a.name in(" + names + ") and a.del_flag='0'";
		List<Record> list = Db.find(query, siteId);
		if (list.size() > 0) {
			for (Record re : list) {
				if ("".equals(ids)) {
					ids = re.getInt("id").toString();
				} else {
					ids = ids + "," + re.getInt("id").toString();
				}
			}
		}
		if (count == str1.length) {
			return ids;
		}

		return null;

	}


	public List<Record> getUnselCat() {
		StringBuffer sb = new StringBuffer("");
		sb.append(" SELECT a.id, a.name FROM crm_category a WHERE NOT EXISTS ( ");
		sb.append(" SELECT DISTINCT category_id FROM crm_warranty_common_rule b WHERE a.id = b.category_id ");
		sb.append(" ) ");
		return Db.find(sb.toString());
	}

	public Category getById(String categoryId) {
		return getByHql(" from crmCategory where id = '"+categoryId+"'");
	}

	public Category getByName(String name){
		return getByHql("from Category where delFlag=:p1 and name= :p2", new Parameter("0",name));
	}

	public boolean deleteById(Long id)
	{
		if(id != null)
		{
			String delete = "DELETE FROM crm_category WHERE id="+id;
			Db.update(delete);
		}
		return true;
	}
	
	public void updateCategory(Category ca ){
		String sql="UPDATE crm_category SET name = ? , img = ? WHERE id = ? ";
		Db.update(sql,ca.getName(),ca.getImg(),ca.getId());
	}
	
	public List<Record> getCategorySiteId(String siteId){
		String sql = "SELECT * FROM crm_category WHERE site_id=? AND del_flag='0' ORDER BY sort asc ";
		return Db.find(sql,siteId);
	}

	public List<Record> getCategoryNameSiteId(String siteId) {
		List<String> cacheList = getCategoryNameFromCache(siteId);
		List<Record> ret = new ArrayList<>();
		if (cacheList != null) {
			for (String v : cacheList) {
				Record r = new Record();
				r.set("name", v);
				ret.add(r);
			}
			return ret;
		}

		String sql = "SELECT name FROM crm_category WHERE site_id=? AND del_flag='0' ORDER BY sort asc ";
		List<Record> result = Db.find(sql, siteId);
		List<String> vs = new ArrayList<>();
		for (Record r : result) {
			vs.add(r.getStr("name"));
		}
		sfCacheService.hset(SfCacheKey.siteCateMap, siteId, new Gson().toJson(vs));
		return result;
	}

	private List<String> getCategoryNameFromCache(String siteId) {
		if (StringUtil.isNotBlank(siteId)) {
			String json = sfCacheService.hget(SfCacheKey.siteCateMap, siteId);
			if (StringUtil.isNotBlank(json)) {
				return new Gson().fromJson(json, new TypeToken<List<String>>() {
				}.getType());
			}
		}
		return null;
	}
	
	public List<Category> getListByIds(String[] cates){
	    
	    String sql = " select * from crm_category where id in( '";
        String in = "";
        for(String categoryId : cates)
        {
            if(StringUtils.isNotEmpty(categoryId)){
            if(in.length() > 0)
                in += "','"+categoryId;
            else
                in += categoryId;
            }
        }
        
        sql += in+"')";
        List<Record> rds = Db.find(sql);
        List<Category> list = new ArrayList<>();
        for(Record rd : rds){
            Category cate = new Category();
            cate.setId(rd.getInt("id"));
            cate.setImg(rd.getStr("img"));
            cate.setName(rd.getStr("name"));
            cate.setDelFlag(rd.getStr("del_flag"));
            list.add(cate);
        }
        return list;
	}
	public List<Record> getListCategory(Page<Record> page){
	    StringBuffer sf = new StringBuffer();
		sf.append("SELECT * FROM crm_category WHERE del_flag='0' ");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
        List<Record> rds = Db.find(sf.toString());
        return rds;
	}
	public long getListcount(){
		String sql = " select count(*) as count from crm_category where del_flag ='0' ";
		return Db.queryLong(sql);
	}
	public Long getListcountforca(String siteId) {
		String sql = " select count(*) as count from crm_category where del_flag ='0' and site_id='"+siteId+"'";
		return Db.queryLong(sql);
	}
	
	public List<Record> getServiceCategoryList(Page<Record> page,String siteId) {
		StringBuffer sf=new StringBuffer();
		sf.append( "SELECT * FROM crm_category WHERE  site_id ='"+siteId+"'  AND del_flag='0' order by sort asc,create_time desc");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		
		return Db.find(sf.toString());
	}
	public List<Record> getCategoryList(String siteId) {
		StringBuffer sf=new StringBuffer();
		sf.append( "SELECT * FROM crm_category WHERE  site_id ='"+siteId+"'  AND del_flag='0' order by sort  ");
		
		return Db.find(sf.toString());
	}
	
	public void updateServiceMode(Category category){
		String hql="";
		hql="update crm_category set name= ? , sort = ? where id=? ";
		Db.update(hql,category.getName(),category.getSort(),category.getId());
	}
	
	public String delete(String ids,String name,String siteId) {
		String turn="";
		String id = "";
		String creaname = "";
		String[] str=ids.split(",");
		String[] names=name.split(",");
		for (int i = 0; i < str.length; i++) {
			id=str[i];
			creaname = names[i];
			String sql2 = "delete from crm_site_brand_rel WHERE category_id ='"+id+"'";
			String setsql = "DELETE FROM crm_site_settlement_template WHERE category = ? AND site_id=? ";
			Db.update(sql2);
			
			String sql1 = "delete from crm_category WHERE id ='"+id+"'";
			Db.update(sql1);
			//删除结算项
			Db.update(setsql,creaname,siteId);
			
			turn= "0";
		}
		return turn;
	}
	
	public void delete1(String id) {
			String sql = "UPDATE crm_category SET del_flag='1' WHERE id ='"+id+"'";
			Db.update(sql);
	}
	
	public static String[] getListCategory8(){
	    StringBuffer sf = new StringBuffer();
	    List<String> list = Lists.newArrayList();
		sf.append("SELECT * FROM crm_category WHERE del_flag='0' AND site_id IS NULL ");
        List<Record> rds = Db.find(sf.toString());
        for(Record record : rds){
        String name = record.getStr("name");
        	list.add(name);
        }
        String strArray[] = new String[list.size()];
        list.toArray(strArray);       
        return strArray;
	}
	public static Category getListCategory4(Integer rowId){
		String rId = rowId.toString();
	    StringBuffer sf = new StringBuffer();
	    Category cate = new Category();
		sf.append("SELECT * FROM crm_category WHERE del_flag='0' AND id='"+rId+"'");
        Record rds = Db.findFirst(sf.toString());
        cate.setCreateTime(rds.getDate("create_time"));
		cate.setDelFlag(rds.getStr("del_flag"));
		cate.setId(rds.getInt("id"));
		cate.setImg(rds.getStr("img"));
		cate.setName(rds.getStr("name"));
		cate.setSort(rds.getInt("sort"));
		cate.setSiteId(rds.getStr("site_id"));
        return cate;
	}
	
	public List<Category> getListCate(String siteId){
		List<Category> list = Lists.newArrayList();
		String sql ="SELECT *  FROM crm_category WHERE (site_id=? OR site_id IS NULL OR site_id ='' ) AND del_flag ='0'  GROUP BY name  ORDER BY sort ASC  ";
		List<Record> rds = Db.find(sql,siteId);
			if(rds != null){
				for(Record rd :rds){
			Category ca = new Category();
			ca.setId(rd.getInt("id"));
			ca.setCreateBy(rd.getStr("create_by"));
			ca.setCreateTime(rd.getDate("create_time"));
			ca.setDelFlag(rd.getStr("del_flag"));
			ca.setImg(rd.getStr("img"));
			ca.setName(rd.getStr("name"));
			ca.setSiteId(rd.getStr("site_id"));
			ca.setSort(rd.getInt("sort"));
			list.add(ca);
				}
			}
		return list;
	}
	
	
	public List<Record> getSiteBrandRelList(String siteId){
		String sql = "SELECT a.* FROM crm_category a WHERE a.id in(SELECT r.category_id  FROM crm_site_brand_rel r WHERE r.site_id='"+siteId+"')";
		List<Record> records = Db.find(sql);
		return records;
	}
	
	public Long queryCount(String siteId) {
		long count = Db.queryLong("SELECT COUNT(DISTINCT category_id) FROM crm_site_brand_rel WHERE site_id = '"+siteId+"'");
		return count;
	}
	public List<Record> getsysCateList(){
		String sql="SELECT * FROM crm_category WHERE del_flag='0' AND site_id IS NULL or site_id=''";
		return Db.find(sql);
	}
	public Record querysortbyname(String name){
		String sql="SELECT * FROM crm_category WHERE name='"+name+"'";
		return Db.findFirst(sql);
	}

	public List<Category> getListCatenotnull(String siteId) {
		List<Category> list = Lists.newArrayList();
		String sql ="SELECT *  FROM crm_category WHERE site_id=?   AND del_flag ='0'  GROUP BY name  ORDER BY sort ASC  ";
		List<Record> rds = Db.find(sql,siteId);
			if(rds != null){
				for(Record rd :rds){
			Category ca = new Category();
			ca.setId(rd.getInt("id"));
			ca.setCreateBy(rd.getStr("create_by"));
			ca.setCreateTime(rd.getDate("create_time"));
			ca.setDelFlag(rd.getStr("del_flag"));
			ca.setImg(rd.getStr("img"));
			ca.setName(rd.getStr("name"));
			ca.setSiteId(rd.getStr("site_id"));
			ca.setSort(rd.getInt("sort"));
			list.add(ca);
				}
			}
		return list;
	}


}
