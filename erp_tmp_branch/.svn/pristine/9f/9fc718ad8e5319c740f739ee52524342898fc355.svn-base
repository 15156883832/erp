package com.jojowonet.modules.goods.utils;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class GoodsCategoryUtil {

	// 获取服务商的商品类别
	public static List<Record> getSiteGoodsCategoryList(String siteId){
		StringBuffer sb = new StringBuffer("");
		sb.append(" SELECT *  FROM crm_goods_category a WHERE a.site_id = ? AND a.status = '0' order by sort ");
		return Db.find(sb.toString(), siteId);
	}
	//获取平台商品类别
	public static List<Record> getPlatGoodsCategoryList(){
		StringBuffer sb = new StringBuffer("");
		sb.append(" SELECT *  FROM crm_goods_category a WHERE a.site_id is null AND a.status = '0' ");
		return Db.find(sb.toString());
	}
	
	//获取服务商家电品类
	public static List<Record> getSiteCategory(String siteId){
		StringBuffer sb = new StringBuffer("");
		sb.append(" SELECT *  FROM crm_category a WHERE a.site_id='"+siteId+"' AND a.del_flag = '0' ");
		return Db.find(sb.toString());
	}
}
