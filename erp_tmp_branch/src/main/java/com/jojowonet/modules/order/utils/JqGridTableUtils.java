package com.jojowonet.modules.order.utils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;

import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.Date;

public class JqGridTableUtils {

	/**
	 * 
	 * @param siteId
	 * @param path 请求的路径：如：/a/order/site/ajaxList
	 * @return
	 */
	public static SiteTableHeaderForm getCustomizedTableHead(String siteId, String path){
		/*siteId = "ff808081586cc3d701586ce8bef50003";
		path = "/a/order/site/ajaxList2";*/
		StringBuilder sb = new StringBuilder(" select a.id as defaultId, b.id, a.header, b.sort_header,a.excel_title ");
		sb.append(" from crm_site_default_table_header a ");
		sb.append(" left join crm_site_table_header b on b.default_id = a.id and b.site_id = ? ");
		sb.append(" where a.path = ? ");
		Record rd = Db.findFirst(sb.toString(), siteId, path);
		SiteTableHeaderForm stf = new SiteTableHeaderForm();
		if(rd != null){
			stf.setTableHeader(JSONArray.fromObject(rd.getStr("header")).toString());
			stf.setId(rd.getStr("id"));
			stf.setDefaultId(rd.getInt("defaultId"));
			stf.setSortHeader(rd.getStr("sort_header"));
			stf.setExcelTitle(rd.getStr("excel_title"));
		}
		return stf;
	}
	
	public static SiteTableHeaderForm getCustomizedTableHead2(String siteId, String path){
		/*siteId = "ff808081586cc3d701586ce8bef50003";
		path = "/a/order/site/ajaxList2";*/
        String str1="{'name':'customer_telephone','label':'联系方式2','index':'customer_telephone','width':100,'align':'center'}";
        String str2="{'name':'customer_telephone2','label':'联系方式3','index':'customer_telephone2','width':100,'align':'center'}";
        JSONObject js=new JSONObject();
   
		StringBuilder sb = new StringBuilder(" select a.id as defaultId, b.id, a.header, b.sort_header,a.excel_title ");
		sb.append(" from crm_site_default_table_header a ");
		sb.append(" left join crm_site_table_header b on b.default_id = a.id and b.site_id = ? ");
		sb.append(" where a.path = ? ");
		Record rd = Db.findFirst(sb.toString(), siteId, path);
		SiteTableHeaderForm stf = new SiteTableHeaderForm();
		if(rd != null){
		     JSONArray jarray= JSONArray.fromObject(rd.getStr("header"));
		    	        jarray.add(js.fromObject(str1));
		    	        jarray.add(js.fromObject(str2));
			stf.setTableHeader(jarray.toString());
			stf.setId(rd.getStr("id"));
			stf.setDefaultId(rd.getInt("defaultId"));
			stf.setSortHeader(rd.getStr("sort_header"));
			stf.setExcelTitle(rd.getStr("excel_title"));
		}
		return stf;
	}
	
	public static SiteTableHeaderForm getDefaultTableHead(String path){
		StringBuilder sb = new StringBuilder("");
		sb.append(" select * from crm_site_default_table_header a where a.path = ? limit 1");
		Record rd = Db.findFirst(sb.toString(), path);
		SiteTableHeaderForm stf = new SiteTableHeaderForm();
		stf.setTableHeader(JSONArray.fromObject(rd.getStr("header")).toString());
		return stf;
	}
	
	public static void saveTableHeader(SiteTableHeaderForm headerForm, String siteId){
		if(!("-1".equals(headerForm.getId()) || StringUtils.isBlank(headerForm.getId()))){
			//更新
			Db.update(" update crm_site_table_header set sort_header = ?, create_time = ? where id = ? ", headerForm.getSortHeader(), new Date(), headerForm.getId());
		}else{
			if(StringUtils.isNotBlank(headerForm.getSortHeader())){
				Db.update(" insert into crm_site_table_header (id, site_id, default_id, sort_header, create_time) values (?, ?, ?, ?, ?) ", 
						IdGen.uuid(), siteId, headerForm.getDefaultId(), headerForm.getSortHeader(), new Date());
			}
		}
	}
	
	public static String generate(){
		return "";
	}
}
