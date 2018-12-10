package com.jojowonet.modules.order.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ivan.common.entity.mysql.common.Role;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;















import ivan.common.utils.MD5;
import ivan.common.utils.UserUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.SupplierDao;
import com.jojowonet.modules.order.entity.Supplier;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.sys.service.SystemService;


@Component
@Transactional(readOnly = true)
public class SupplierService extends BaseService{
	@Autowired
	private SupplierDao supplierDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private SystemService systemService;
	
    public Page<Record> findsupplier(Page<Record> page) {
        List<Record> list =supplierDao.getSupplierList(page);
      for (Record rd : list) {//将对应的所属商品id转换成对应的名称
    	  if(rd.getStr("goods")!=null){
    		  String[] goods=rd.getStr("goods").split(",");
	           String[] goodsname=new String[goods.length];
	        for(int i=0;i<goods.length;i++){
	        	goodsname[i]=supplierDao.getGoodsNameById(goods[i]);
	            }
	          rd.set("goods", goodsname.clone());
        }
    	  }
	          
        long count = supplierDao.getListCount();
        page.setCount(count);
        page.setList(list);
        return page;
    }


	public List<Record> getAllPlatGoods() {
		List<Record> goodslist=supplierDao.getAllPlatGoods();

		return goodslist;
	}

//判断登录名和供应商名是否重名
	public boolean querySupplierById(String names, String id,String loginName,String userId) {
		if(id!=null&&userId!=null){
			List list = supplierDao.createSqlQuery("select * from crm_supplier"
					+ " where name = :p1 and id!=:p2 and status='0' ",new Parameter(names,id)).list();
			User user=userDao.findByLoginNameId(loginName,userId);
			if (list.size()>0||user!=null)
				return false;
			return true;
		}else{
			List list = supplierDao.createSqlQuery("select * from crm_supplier"
					+ " where  name = :p1 and status='0' ",new Parameter(names)).list();
			User user=userDao.findByLoginName(loginName);
			if (list.size()>0||user!=null)
				return false;
			return true;
		}
	}

//新增供应商时分两步1：添加基础信息到供应商表中2：添加添加供应商与商品的关系到供应商与商品表中

	
	public String save(String param) {
		String result="";
		JSONObject jo = new JSONObject();
		User user = new User();
		Supplier supplier = new Supplier();
		if(supplierDao.queryMobile((String) jo.fromObject(param).get("mobile"),"")>=1){
			result="手机号已存在";
			
		}else{
			String goods = jo.fromObject(param).getString("goodslist");
			JSONArray arr = JSONArray.fromObject(goods);
			String[] goodslist = new String[arr.size()];
			for (int i = 0; i < goodslist.length; i++) {
				goodslist[i] = arr.getString(i);
			}
			user.setLoginName((String) jo.fromObject(param).get("loginName"));
			user.setPassword(MD5.MD5((String) jo.fromObject(param).get("password")));
			user.setUserType("7");
			user.setMobile((String) jo.fromObject(param).get("mobile"));
			user.setCreateBy(UserUtils.getUser().getId());
			user.setCreateDate(new Date());
			Role supplierRole = systemService.getRole("7");
			List<Role> roles = Lists.newArrayList();
			roles.add(supplierRole);
			user.setRoleList(roles);
			userDao.save(user);// 将信息保存到sys_user表
			supplier.setUserId(user.getId());
			supplier.setName((String) jo.fromObject(param).get("name"));
			supplier.setMobile((String) jo.fromObject(param).get("mobile"));
			supplier.setContactor((String) jo.fromObject(param).get("contactor"));
			supplier.setRemarks((String) jo.fromObject(param).get("remarks"));
			supplier.setCreateBy(UserUtils.getUser().getId());
			supplierDao.save(supplier);
			for(int i=0;i<goodslist.length;i++){
				String goodsnum=supplierDao.queryGoodsNumById(goodslist[i]).getStr("number");
				supplierDao.addGoodsSupplierRel(goodslist[i],supplier.getId(),goodsnum);
			}
			result="ok";
		}
		
		return result;
	}


	public void deleteSupplier(String id,String userId) {
		if(userId!=null){
			supplierDao.deleteUser(userId);
		}
		if(id!=null){
			supplierDao.delete(id);
		}
	}

//动过id查找供应商
	public Record findSupplierById(String id) {
		Record rd=supplierDao.findSupplierById(id);
	    return rd;
		
	}

//根据id查询供应商以及供应商与商品关系
	public Record findSupplierGoodsById(String id) {
	Record rd=supplierDao.findSupplierGoodsById(id);
		return rd;
	}

	//根据供应商的user_id查询user
	public Record findUserById(String userId) {
		Record rd=supplierDao.findUserById(userId);
		return rd;
	}


	public String updateById(String name, String contactor, String mobile,
			String remarks, String[] goodslist, String supplierid,String userId) {
		String result="";
		if(supplierDao.queryMobile(mobile,userId)>=1){
			result="手机号已存在";
		}else{
		supplierDao.updateById(name,contactor,mobile,remarks,supplierid);
		supplierDao.deleteGoodsRel(supplierid);
		for(int i=0;i<goodslist.length;i++){
			String goodsnum=supplierDao.queryGoodsNumById(goodslist[i]).getStr("number");
			supplierDao.addGoodsSupplierRel(goodslist[i],supplierid,goodsnum);
			result="ok";
		}
		}
		return result;
		
	}


	public void updateUserById(String loginName, String password, String mobile,
			String userId) {

			supplierDao.updateUserById(loginName,password,mobile,userId);
			
	}


    public Record getSupplierByuserId(String userId){
    	return supplierDao.getSupplierByuserId(userId);
    }


}
