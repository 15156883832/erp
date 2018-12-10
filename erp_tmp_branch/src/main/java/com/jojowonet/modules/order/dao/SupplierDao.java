package com.jojowonet.modules.order.dao;

import java.util.Date;
import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.MD5;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Supplier;

/**
 * 供应商DAO接口
 * @author yc
 * @version 2017-06-06
 */
 
@Repository
public class SupplierDao extends BaseDao<Supplier> {
	public List<Record> getSupplierList(Page<Record> page){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM");
		sf.append(" (SELECT p.id AS id ,p.name AS `name`,p.status AS `status`,GROUP_CONCAT(ps.good_platform_id) AS goods");
		sf.append(" FROM  crm_supplier AS p LEFT JOIN crm_goods_platform_supplier_rel AS ps ON p.id=ps.supplier_id GROUP BY id)");
		sf.append(" AS s WHERE s.status='0'");
		sf.append(page.getSqlOrderBy());
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString());
	}
	
	public long getListCount(){
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT COUNT(DISTINCT p.id) FROM crm_supplier AS p");
		sf.append(" LEFT JOIN crm_goods_platform_supplier_rel AS ps ON ps.supplier_id=p.id where p.status='0' ");
		return Db.queryLong(sf.toString());
	}
	
	//根据id查询商品名称
	public String getGoodsNameById(String id){
		String name = "";
		if(StringUtils.isNotBlank(id)){
			String sql = "SELECT p.name FROM crm_goods_platform AS p WHERE p.id='"+id+"' AND p.status='0'";
			Record record = Db.findFirst(sql);
			
			if(record != null){
				name = record.getStr("name");
			}
		}
		
		return name;
	}
	
	//获取所有品台商品的id和name
	public List<Record> getAllPlatGoods(){
		String sql="SELECT p.id AS id,p.name AS `name`  FROM crm_goods_platform AS p WHERE  p.status='0'";
		return Db.find(sql);
	}
//以下为对于处理供应商数据时处理供应商与商品关系表的方法
//根据商品id查询平台商品的商品编号
	public Record queryGoodsNumById(String goodsId) {
	
	String sql="SELECT gp.number AS number FROM crm_goods_platform AS gp WHERE gp.id=?";
		return Db.findFirst(sql, goodsId);
	}
//添加供应商时添加相应数据到供应商与商品关系表的方法
	public void addGoodsSupplierRel(String goodsId, String supplierId, String goodsnum) {
		String sql="INSERT INTO crm_goods_platform_supplier_rel VALUES(?,?,?)";
		Db.update(sql, goodsId,supplierId,goodsnum);	
	}
//根据Id查找供应商
	public Record findSupplierById(String id) {
	   String sql="SELECT * FROM crm_supplier WHERE id=?";
			   return Db.findFirst(sql, id);
		
	}
//根据Id删除供应商基本信息
	public void delete(String id) {
	 String sql="UPDATE crm_supplier SET status='1' WHERE id=?";
	 Db.update(sql,id);
	}
//删除user的登陆信息
	public void deleteUser(String userid){
		 String sql="UPDATE sys_user SET status='2' WHERE id=?";
		 Db.update(sql,userid);
	}

	//根据id查询供应商以及供应商与商品关系
	public Record findSupplierGoodsById(String id) {
		StringBuffer sf=new StringBuffer();
		sf.append("SELECT * FROM");
		sf.append(" (SELECT p.id AS id ,p.name AS `name`,p.status AS `status`,p.mobile AS mobile,p.contactor AS contactor,p.remarks AS remarks,p.user_id AS userId,GROUP_CONCAT(ps.good_platform_id) AS goods");
		sf.append(" FROM  crm_supplier AS p LEFT JOIN crm_goods_platform_supplier_rel AS ps ON p.id=ps.supplier_id GROUP BY id)");
		sf.append(" AS s WHERE s.id=? AND s.status='0'");
		return Db.findFirst(sf.toString(),id);
	}
//根据供应商的user_id查询user
	public Record findUserById(String userId) {
		   String sql="SELECT * FROM sys_user WHERE id=?";
		   return Db.findFirst(sql, userId);
	
	}
//更新供应商基本信息
	public void updateById(String name, String contactor, String mobile,
			String remarks, String supplierid) {
		String sql="UPDATE  crm_supplier SET name=? , mobile=? , contactor=? , remarks=?  WHERE id=?";
		Db.update(sql,name,mobile,contactor,remarks,supplierid);
		
		
	}
//删除供应商与商品关系
	public void deleteGoodsRel(String supplierid) {
		String sql="DELETE FROM crm_goods_platform_supplier_rel WHERE supplier_id='"+supplierid+"'";
		Db.update(sql);
	}
//更新user
	public void updateUserById(String loginName, String password,
			String mobile, String userId) {
		String sql;
		Date data=new Date();
//		if(password.length()==0||password==null){
		if(StringUtils.isBlank(password)){
			sql="UPDATE  sys_user SET login_name=? , mobile=? , update_time=?  WHERE id=?";
			Db.update(sql,loginName,mobile,data,userId);
		}else{
			sql="UPDATE  sys_user SET login_name=? , password=? , mobile=? , update_time=?  WHERE id=?";
			Db.update(sql,loginName,MD5.MD5(password),mobile,data,userId);
		}
	}

	public String getPlatformProductSupplierId(String pid) {
		Record r = Db.findFirst("select * from crm_goods_platform_supplier_rel where good_platform_id=? limit 1", pid);
		return r == null ? null : r.getStr("supplier_id");
	}

	public Record getSupplierByuserId(String userId) {
		String sql="select * from crm_supplier where user_id=?";
		Record r=Db.findFirst(sql, userId);
		return r;
	}

	public int queryMobile(String mobile,String userId) {
		
		int i=0;
		if(StringUtils.isNotBlank(userId)){
			String sql1="select * from sys_user a where a.status='0' and a.mobile='"+mobile+"'  and a.user_type!='4' and id!='"+userId+"'";
			i=Db.find(sql1).size();
		}else{
			String sql2="select * from sys_user a where a.status='0' and a.mobile='"+mobile+"'  and a.user_type!='4'";
			i=Db.find(sql2).size();
		}
		return i;
		
	}



}
