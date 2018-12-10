/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.QueryTimes;

/**
 * 查询信息DAO接口
 * @author Ivan
 * @version 2017-11-02
 */
@Repository
public class QueryTimesDao extends BaseDao<QueryTimes> {
	
	public void updateCount(String name,String siteId){
		String sql = " UPDATE crm_query_times SET "+name+" = "+name+"+1  WHERE site_id = '"+siteId+"' ";
		if(StringUtils.isNotBlank(name)){
			Db.update(sql);
		}
	}
	
	public QueryTimes getqueryTimesSiteId(String siteId){
		String sql = "SELECT * FROM crm_query_times WHERE site_id ='"+siteId+"' LIMIT 1  ";
		Record rd = Db.findFirst(sql);
		QueryTimes qu = new QueryTimes();
		if(rd != null){
			qu.setId(rd.getStr("id"));
			qu.setSiteId(rd.getStr("site_id"));
			qu.setNumberCount(rd.getInt("number_count"));
			qu.setCustomerNameCount(rd.getInt("customer_name_count"));
			qu.setCustomerMobileCount(rd.getInt("customer_mobile_count"));
			qu.setCustomerAddressCount(rd.getInt("customer_address_count"));
			qu.setOriginCount(rd.getInt("origin_count"));
			qu.setServiceTypeCount(rd.getInt("service_type_count"));
			qu.setApplicationCategoryCount(rd.getInt("application_category_count"));
			qu.setStatusCount(rd.getInt("status_count"));
			qu.setFlagCount(rd.getInt("flag_count"));
			qu.setEmployeCount(rd.getInt("employe_count"));
			qu.setApplicationBrandCount(rd.getInt("application_brand_count"));
			qu.setApplianceModelCount(rd.getInt("appliance_model_count"));
			qu.setApplianceBarcodeCount(rd.getInt("appliance_barcode_count"));
			qu.setWarrantyTypeCount(rd.getInt("warranty_type_count"));
			qu.setLevelCount(rd.getInt("level_count"));
			qu.setServiceModeCount(rd.getInt("service_mode_count"));
			qu.setOrderTypeCount(rd.getInt("order_type_count"));
			qu.setPromiseTimeCount(rd.getInt("promise_time_count"));
			qu.setReturnCardCount(rd.getInt("return_card_count"));
			qu.setOrderCostCount(rd.getInt("order_cost_count"));
			qu.setWhetherCollectionCount(rd.getInt("whether_collection_count"));
			qu.setRepairTimeCount(rd.getInt("repair_time_count"));
			qu.setRepairTimeMaxCount(rd.getInt("repair_time_max_count"));
			qu.setEndTimeCount(rd.getInt("end_time_count"));
			qu.setEndTimeMaxCount(rd.getInt("end_time_max_count"));
			qu.setDispatchTimeCount(rd.getInt("dispatch_time_count"));
			qu.setDispatchTimeMaxCount(rd.getInt("dispatch_time_max_count"));
			qu.setMessengerNameCount(rd.getInt("messenger_name_count"));
			qu.setWholeOrderCount(rd.getInt("whole_order_count"));
			qu.setDpgOrderCount(rd.getInt("dpg_order_count"));
			qu.setDuringOrderCount(rd.getInt("during_order_count"));
			qu.setStayvisitOrderCount(rd.getInt("stayvisit_order_count"));
			qu.setHistoryOrderCount(rd.getInt("history_order_count"));
			qu.setZbpgOrderCount(rd.getInt("zbpg_order_count"));
			qu.setJjgdOrderCount(rd.getInt("jjgd_order_count"));
			qu.setJryyOrderCount(rd.getInt("jryy_order_count"));
			qu.setDjgdOrderCount(rd.getInt("djgd_order_count"));
			qu.setYjgdOrderCount(rd.getInt("yjgd_order_count"));
			qu.setDaijgdOrderCount(rd.getInt("daijgd_order_count"));
			qu.setDhfOrderCount(rd.getInt("dhf_order_count"));
			qu.setDjsOrderCount(rd.getInt("djs_order_count"));
			qu.setYwgOrderCount(rd.getInt("ywg_order_count"));
			qu.setWxOrderCount(rd.getInt("wx_order_count"));
			qu.setUpdateOrderCount(rd.getInt("update_order_count"));
			qu.setInvalidOrderCount(rd.getInt("invalid_order_count"));
			qu.setTemporarilyOrderCount(rd.getInt("temporarily_order_count"));
			qu.setFeedbackOrderCount(rd.getInt("feedback_order_count"));
			qu.setSignOrderCount(rd.getInt("sign_order_count"));
			qu.setPrintOrderCount(rd.getInt("print_order_count"));
		}
		return qu;
	}
	
	public List<Record> getqueryList(Page<Record> page){
		StringBuilder sf = new StringBuilder();
		sf.append( "SELECT a.*,b.name FROM crm_query_times a "
				+ " LEFT JOIN crm_site b ON b.id=a.site_id AND b.status='0' GROUP BY a.site_id ");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sf.toString());		
	} 
	public long getQueryCount(){
		return Db.queryLong("SELECT count(*) as count FROM crm_query_times");
	}
	
	public Record getSum(){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT SUM(number_count) AS number_count,SUM(customer_name_count) AS customer_name_count,SUM(customer_mobile_count) AS customer_mobile_count,SUM(customer_address_count) AS customer_address_count, ");
		sf.append("SUM(origin_count) AS origin_count,SUM(service_type_count) AS service_type_count,SUM(application_category_count) AS application_category_count,SUM(status_count) AS status_count, ");
		sf.append("SUM(flag_count) AS flag_count,SUM(employe_count) AS employe_count,SUM(application_brand_count) AS application_brand_count,SUM(appliance_model_count) AS appliance_model_count, ");
		sf.append("SUM(appliance_barcode_count) AS appliance_barcode_count,SUM(warranty_type_count) AS warranty_type_count,SUM(level_count) AS level_count,SUM(service_mode_count) AS service_mode_count, ");
		sf.append("SUM(order_type_count) AS order_type_count,SUM(promise_time_count) AS promise_time_count,SUM(return_card_count) AS return_card_count,SUM(order_cost_count) AS order_cost_count,");
		sf.append("SUM(whether_collection_count) AS whether_collection_count,SUM(repair_time_max_count) AS repair_time_max_count,SUM(repair_time_count) AS repair_time_count,SUM(end_time_count) AS end_time_count,");

		sf.append("SUM(end_time_max_count) AS end_time_max_count,SUM(dispatch_time_count) AS dispatch_time_count,SUM(dispatch_time_max_count) AS dispatch_time_max_count,SUM(messenger_name_count) AS messenger_name_count,");
		sf.append("SUM(whole_order_count) AS whole_order_count,SUM(dpg_order_count) AS dpg_order_count,SUM(during_order_count) AS during_order_count,SUM(stayvisit_order_count) AS stayvisit_order_count,");
		sf.append("SUM(history_order_count) AS history_order_count,SUM(zbpg_order_count) AS zbpg_order_count,SUM(jjgd_order_count) AS jjgd_order_count,SUM(jryy_order_count) AS jryy_order_count,");
		sf.append("SUM(djgd_order_count) AS djgd_order_count,SUM(yjgd_order_count) AS yjgd_order_count,SUM(daijgd_order_count) AS daijgd_order_count,SUM(dhf_order_count) AS dhf_order_count,");
		sf.append("SUM(djs_order_count) AS djs_order_count,SUM(ywg_order_count) AS ywg_order_count,SUM(wx_order_count) AS wx_order_count,SUM(update_order_count) AS update_order_count,");
		sf.append("SUM(invalid_order_count) AS invalid_order_count,SUM(temporarily_order_count) AS temporarily_order_count,SUM(feedback_order_count) AS feedback_order_count,SUM(sign_order_count) AS sign_order_count,SUM(print_order_count) AS print_order_count ");
		sf.append(" FROM crm_query_times  WHERE 1=1 ");
		Record rd = Db.findFirst(sf.toString());
		return rd;
	}
}
