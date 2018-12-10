package com.jojowonet.modules.goods.dao;

import java.util.List;
import java.util.Map;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.entity.GoodsPlatformTransferOrder;
import com.jojowonet.modules.order.utils.StringUtil;

@Repository
public class GoodsPlatformTransferOrderDao extends BaseDao<GoodsPlatformTransferOrder> {

	
	public List<Record> getSitePlatformGoodsRecord(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sql = new StringBuffer("");
		sql.append("select gpo.*,concat(gpo.province,gpo.city,gpo.area,gpo.customer_address) as address,ia.review_status,d.name as placeOrderName,c.mobile,e.good_sign  ");
		sql.append(" FROM crm_goods_platform_transfer_order gpo left join crm_invoice_application as ia on gpo.invoice_record_id=ia.id  ");
		sql.append(" left join sys_user c on gpo.placing_order_by=c.id  ");
		sql.append(" left join crm_site d on d.user_id=c.id  ");
		sql.append(" left join crm_goods_platform e on e.id=gpo.good_id  ");
		sql.append(" WHERE gpo.status IN(0,1,2,3,4)  AND gpo.site_id='"+siteId+"'  and pay_status='1' ");
		sql.append(getRecordQuery(map));
		sql.append(" order by gpo.placing_order_time desc  ");
		if (page != null) {
			sql.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sql.toString());
	}
	
	public long getCount(Map<String, Object> map,String siteId){
		StringBuffer sql = new StringBuffer("");
		sql.append("select count(*) ");
		sql.append(" FROM crm_goods_platform_transfer_order gpo ");
		sql.append(" WHERE gpo.status IN(0,1,2,3,4)  AND gpo.site_id='"+siteId+"'  and pay_status='1' ");
		sql.append(getRecordQuery(map));
		sql.append(" order by gpo.placing_order_time desc  ");
		return  Db.queryLong(sql.toString());
	}
	
	// 服务商付款记录明细查询条件
		private Object getRecordQuery(Map<String, Object> map) {
			if (map == null) {
				return "";
			}
			StringBuffer sf = new StringBuffer();
			String good_number = getTrimmedParamValue(map, "good_number");
			if (StringUtil.isNotBlank(good_number)) {
				sf.append(" and gpo.good_number like '%" + good_number + "%' ");
			}
			String number = getTrimmedParamValue(map, "number");
			if (StringUtil.isNotBlank(number)) {
				sf.append(" and gpo.number like '%" + number + "%' ");
			}
			String orderMan = getTrimmedParamValue(map, "orderMan");
			if (StringUtil.isNotBlank(orderMan)) {
				sf.append(" and gpo.placing_order_by = '" + orderMan + "' ");
			}
			String good_name = getTrimmedParamValue(map, "good_name");
			if (StringUtil.isNotBlank(good_name)) {
				sf.append(" and gpo.good_name like '%" + good_name + "%' ");
			}
			String good_brand = getTrimmedParamValue(map, "good_brand");
			if (StringUtil.isNotBlank(good_brand)) {
				sf.append(" and gpo.good_brand like '%" + good_brand + "%' ");
			}
			String good_model = getTrimmedParamValue(map, "good_model");
			if (StringUtil.isNotBlank(good_model)) {
				sf.append(" and gpo.good_model like '%" + good_model + "%' ");
			}
			String good_category = getTrimmedParamValue(map, "good_category");
			if (StringUtil.isNotBlank(good_category)) {
				sf.append(" and gpo.good_category like '%" + good_category + "%' ");
			}
			
			String status = getTrimmedParamValue(map, "status");
			if (StringUtil.isNotBlank(status)) {
				sf.append(" and gpo.status='"+status+"' ");
			}
			
			String customer_name = getTrimmedParamValue(map, "customer_name");
			if (StringUtil.isNotBlank(customer_name)) {
				sf.append(" and gpo.customer_name like '%" + customer_name + "%' ");
			}
			
			String customer_contact = getTrimmedParamValue(map, "customer_contact");
			if (StringUtil.isNotBlank(customer_contact)) {
				sf.append(" and gpo.customer_contact like '%" + customer_contact + "%' ");
			}
			
			String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
			if (StringUtil.isNotBlank(createTimeMin)) {// 接入时间
				sf.append(" and gpo.payment_time >= '" + createTimeMin
						+ " 00:00:00' ");
			}

			String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
			if (StringUtil.isNotBlank(createTimeMax)) {
				sf.append(" and gpo.payment_time <= '" + createTimeMax
						+ " 23:59:59' ");
			}

			return sf.toString();
		}
		
		 //去空格
	    private String getTrimmedParamValue(Map<String, Object> map, String param) {
	        return StringUtils.trim(getParamValue(map, param));
	    }
	    
	    //转换为String类型
	    private String getParamValue(Map<String, Object> map, String param) {
	        Object value = map.get(param);
	        return value == null ? null : (map.get(param).toString());
	    }
	    
	    /*
		 * 查询单个服务商近三个月购买漏保的订单数据
		*/
		public List<Record> getGoodsOrderBySite(String siteId){
			StringBuilder sf = new StringBuilder();
			sf.append("SELECT a.good_id,a.good_name,SUM(a.purchase_num) AS purchase_num,SUM(a.good_amount) AS good_amount ");
			sf.append("FROM crm_goods_platform_transfer_order a ");
			sf.append("WHERE a.site_id=? AND  a.pay_status='1' AND a.good_category LIKE '%插座%' AND  a.placing_order_time>DATE_SUB(CURDATE(), INTERVAL 3 MONTH) GROUP BY a.good_id ");
			return Db.find(sf.toString(),siteId);
		}
		
		/*
		 * 查询单个服务商近三个月购买漏保的服务商
		 */
		public List<Record> getGoodsOrderSite(){
			StringBuilder sf = new StringBuilder();
			sf.append("SELECT a.site_id,s.name FROM crm_goods_platform_transfer_order a  ");
			sf.append("LEFT JOIN crm_site s ON s.id = a.site_id AND s.status='0' ");
			sf.append("WHERE a.pay_status='1' AND a.good_category LIKE '%插座%' AND  a.placing_order_time>DATE_SUB(CURDATE(), INTERVAL 3 MONTH) GROUP BY a.site_id ");
			return Db.find(sf.toString());
		}
}
