package com.jojowonet.modules.operate.dao;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;


import com.jojowonet.modules.operate.entity.Site;

import ivan.common.persistence.BaseDao;
import ivan.common.utils.StringUtils;

/**
 * @author yc 服务商资料信息dao接口
 *
 */
@Repository
public class SiteMsgDao extends BaseDao<Site> {
	// 通过登陆后获得的siteid查询到服务商
	public Record getSiteId(String siteId) {
		String sql = "SELECT * FROM crm_site WHERE id='" + siteId
				+ "' AND status !='1'";
		return Db.findFirst(sql);
	}

	// 根据siteId修改服务商资料
	public void updateSite(String siteId,String contacts,String province,String city,String area,String telephone,String address,String license_img,String lnglat){
		
		String sql="UPDATE crm_site SET contacts=? , province=? , city=? , area=? , telephone=? , license_img=? , update_time=? , address=? ,  lnglat=? WHERE id=?";
		Db.update(sql, contacts,province,city,area,telephone,license_img,new Date(),address,lnglat,siteId);
	}
//查询省
	public List<Record> getprovincelist(){
		String sql="SELECT * FROM s_province";
		return Db.find(sql);
	}

	public void updateZfb(String siteId, String imgzfb) {
		String sql="";
		if (imgzfb != null && StringUtils.isNotEmpty(imgzfb)){
			 sql="UPDATE crm_site SET ali_code=? WHERE id=?";
			 Db.update(sql,imgzfb,siteId);
		
		}else{
			 sql="UPDATE crm_site SET ali_code=null WHERE id=?";
			 Db.update(sql,siteId);
		}
	}

	public void updateWx(String siteId, String imgwx) {
		String sql="";
		if (imgwx != null && StringUtils.isNotEmpty(imgwx)){
			sql="UPDATE crm_site SET wx_code=? WHERE id=?";
				Db.update(sql,imgwx,siteId);
		
		}else{
			 sql="UPDATE crm_site SET wx_code=null WHERE id=?";
				Db.update(sql,siteId);
		}
		
	
		
	}
}
