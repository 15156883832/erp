package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.order.dao.Order2017Dao;
import com.jojowonet.modules.order.dao.OrderDispatchDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.TableSplitMapper;
import com.jojowonet.modules.order.utils.WebPageFunUtils;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Component
@Transactional(readOnly = false)
public class OrderDispatch2017Service extends BaseService {

    @Autowired
    private OrderDispatchDao orderDispatchDao;

    @Autowired
    TableSplitMapper tableSplitMapper;
    @Autowired
    private Order2017Dao order2017Dao;

    /*
     * 点击下一单
     */
    public Record getNextOrderId(Map<String,Object> map, String time, String siteId, String orderId, String parentNumber){
        logger.error("getNextOrderId should not called", new Exception());
        return null;
    }
    /*
     * 点击上一单
     */
    public Record getPreviousOrderId(Map<String,Object> map,String time,String siteId,String orderId,String parentNumber){
        logger.error("getPreviousOrderId should not called", new Exception());
        return null;
    }
	public void updateHistoryUser(Order order, String factoryNumber) {
		String siteId = order.getSiteId();
		if(StringUtils.isBlank(siteId)) {
			 siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		}
		Record rd = null;
		  String orderTable = tableSplitMapper.mapOrder(siteId);
	        if (orderTable != null) {
	           rd=Db.findFirst("select a.* from " + orderTable + " a where a.id=? ", order.getId());
	        }
	    StringBuilder sf = new StringBuilder();
	    sf.append("UPDATE ");
	    sf.append(orderTable);
	    sf.append(" SET ");
	    sf.append(" customer_name = '"+order.getCustomerName()+"'");
	    sf.append(",customer_mobile = '"+order.getCustomerMobile()+"'");
	    sf.append(",customer_telephone = '"+order.getCustomerTelephone()+"'");
	    sf.append(",customer_telephone2 = '"+order.getCustomerTelephone2()+"'");
	    sf.append(",customer_address = '"+order.getCustomerAddress()+"'");
	    sf.append(",province = '"+order.getProvince()+"'");
	    sf.append(",city = '"+order.getCity()+"'");
	    sf.append(",area = '"+order.getArea()+"'");
	    sf.append(",customer_lnglat = '"+order.getCustomerLnglat()+"'");
	    sf.append(",appliance_brand = '"+order.getApplianceBrand()+"'");
	    sf.append(",appliance_category = '"+order.getApplianceCategory()+"'");
	    if(order.getPromiseTime() != null) {
	    	sf.append(",promise_time = '"+DateUtils.formatDateTime(order.getPromiseTime())+"'");
	    	sf.append(",promise_limit = '"+order.getPromiseLimit()+"'");
	    }
	    sf.append(",customer_feedback = '"+order.getCustomerFeedback()+"'");
	    sf.append(",remarks = '"+order.getRemarks()+"'");
	    sf.append(",appliance_model = '"+order.getApplianceModel()+"'");
	    sf.append(",appliance_num = '"+order.getApplianceNum()+"'");
	    sf.append(",appliance_barcode = '"+order.getApplianceBarcode()+"'");
	    sf.append(",appliance_machine_code = '"+order.getApplianceMachineCode()+"'");
	    if(order.getApplianceBuyTime() != null) {
	    	sf.append(",appliance_buy_time = '"+DateUtils.formatDateTime(order.getApplianceBuyTime())+"'");
	    }
	    sf.append(",please_refer_mall = '"+order.getPleaseReferMall()+"'");
	   
	    sf.append(",warranty_type = '"+order.getWarrantyType()+"'");
	    sf.append(",level = '"+order.getLevel()+"'");
	    sf.append(",customer_type = '"+order.getCustomerType()+"'");
	    sf.append(",service_mode = '"+order.getServiceMode()+"'");

		String name = CrmUtils.getUserXM();
		String finalProcessDetail = rd.getStr("process_detail");
		String finalLatestDetail = "";
		Date processTime = new Date();
		if ("1".equals(rd.getStr("record_account"))) {// 曾经录过单
			if (!rd.getStr("factory_number").equals(factoryNumber)) {
				finalLatestDetail = name + "修改厂家工单编号为" + factoryNumber + "，原厂家工单编号为" + rd.getStr("factory_number");
				Target ta1 = new Target();
				ta1.setName(name);
				ta1.setContent(finalLatestDetail);
				ta1.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				ta1.setType(Target.SITE_EDIT_RECORD_ACCOUNT_TYPE);
				finalProcessDetail = WebPageFunUtils.appendProcessDetail(ta1, rd.getStr("process_detail"));
				sf.append(",record_account_time = '"+DateUtils.formatDateTime(processTime)+"'");
				sf.append(",factory_number = '"+factoryNumber+"'");
			}
		}
		String customer_mobile = "";
		String customer_telephone = "";
		String customer_telephone2 = "";
		if (StringUtil.isNotBlank(rd.getStr("customer_mobile"))) {
			customer_mobile = rd.getStr("customer_mobile");
		}
		if (StringUtil.isNotBlank(rd.getStr("customer_telephone"))) {
			customer_telephone = rd.getStr("customer_telephone");
		}
		if (StringUtil.isNotBlank(rd.getStr("customer_telephone2"))) {
			customer_telephone2 = rd.getStr("customer_telephone2");
		}
		if ((!customer_mobile.equals(order.getCustomerMobile())) || (!customer_telephone.equals(order.getCustomerTelephone()))
				|| (!customer_telephone2.equals(order.getCustomerTelephone2()))) {

			StringBuffer latestProcess = new StringBuffer();
			latestProcess.append(name);
			latestProcess.append("修改用户联系方式为：");
			if (!customer_mobile.equals(order.getCustomerMobile())) {
				latestProcess.append(order.getCustomerMobile());
				latestProcess.append("  ");
			}
			if (!customer_telephone.equals(order.getCustomerTelephone())) {
				latestProcess.append(order.getCustomerTelephone());
				latestProcess.append("  ");
			}
			if (!customer_telephone2.equals(order.getCustomerTelephone2())) {
				latestProcess.append(order.getCustomerTelephone2());
				latestProcess.append("  ");
			}
			latestProcess.append(",原用户联系方式为：");
			if (!customer_mobile.equals(order.getCustomerMobile())) {
				latestProcess.append(rd.getStr("customer_mobile"));
				latestProcess.append("  ");
			}
			if (!customer_telephone.equals(order.getCustomerTelephone())) {
				latestProcess.append(rd.getStr("customer_telephone"));
				latestProcess.append("  ");
			}
			if (!customer_telephone2.equals(order.getCustomerTelephone2())) {
				latestProcess.append(rd.getStr("customer_telephone2"));
				latestProcess.append("  ");
			}

			Target ta = new Target();
			ta.setName(name);
			ta.setContent(latestProcess.toString());
			ta.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			ta.setType(Target.MODIFY_YHMSG);
			finalProcessDetail = WebPageFunUtils.appendProcessDetail(ta, finalProcessDetail);
			if (StringUtils.isNotBlank(finalLatestDetail)) {
				finalLatestDetail = finalLatestDetail + "；" + latestProcess.toString();
			} else {
				finalLatestDetail = latestProcess.toString();
			}
		}
		if (StringUtils.isNotBlank(finalLatestDetail)) {
			sf.append(",latest_process = '"+finalLatestDetail+"'");
			sf.append(",latest_process_time = '"+DateUtils.formatDateTime(processTime)+"'");
			sf.append(",process_detail = '"+finalProcessDetail+"'");
		}
		sf.append(" WHERE id = ? ");
		Db.update(sf.toString(),order.getId());
	}

}
