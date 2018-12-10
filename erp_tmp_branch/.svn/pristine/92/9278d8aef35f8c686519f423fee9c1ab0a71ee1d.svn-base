/**
 */
package com.jojowonet.modules.order.service;

import ivan.common.entity.mysql.common.User;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.dao.OrderDispatchDao;
import com.jojowonet.modules.order.dao.OrderSettlementDao;
import com.jojowonet.modules.order.dao.OrderSettlementDetailDao;
import com.jojowonet.modules.order.dao.SettlementTemplateDao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderSettlement;
import com.jojowonet.modules.order.entity.OrderSettlementDetail;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
import com.jojowonet.modules.order.utils.MathUtils;
import com.jojowonet.modules.order.utils.ProcessFormatter;
import com.jojowonet.modules.order.utils.SettlementUtils;
import com.jojowonet.modules.order.utils.WebPageFunUtils;

/**
 * 工单Service
 * @author Ivan
 * @version 2017-05-04
 */
@Component
@Transactional(readOnly = true)
public class OrderSettlementService extends BaseService {

	@Autowired
	private OrderSettlementDao settlementDao;
	
	@Autowired
	private OrderDispatchDao dispatchDao;
	
	@Autowired
	private OrderSettlementDetailDao settlementDetailDao;
	
	@Autowired
	private OrderDao orderDao;
	@Autowired
    private NonServicemanDao noDao;
    @Autowired
    private SiteDao siteDao;
	
	@Autowired
	private SettlementTemplateDao setTelDao;
	
	@Transactional(readOnly = false)
	public void saveSettlement(OrderSettlement orderSettlement, Map<String, Object> map){
		
		OrderSettlement newSettle = null;
		Map<String, OrderSettlementDetail> detailMaps = null;
		if(StringUtils.isNotBlank(String.valueOf(map.get("resetSettle"))) && "resetSettle".equalsIgnoreCase(String.valueOf(map.get("resetSettle")))){
			//
			newSettle =  settlementDao.getByDispatch(orderSettlement.getDispatchId());
			detailMaps = settlementDetailDao.getByDispathIdInMap(orderSettlement.getDispatchId());
		}
		
		if(StringUtils.isBlank(orderSettlement.getId())){
			orderSettlement.setId(null);
		}
		
		if(newSettle != null){
			orderSettlement.setId(newSettle.getId());
		}
		
		//服务工程师当日付款金额
		String empTc = String.valueOf(map.get("emp_tc"));
		String totalTc = String.valueOf(map.get("total_tc"));
		Map<String, Double> empTcMap = Maps.newHashMap();
		if(StringUtils.isNotBlank(empTc)){
			String[] tcs = empTc.split(",");
			for(String tc : tcs){
				empTcMap.put(tc.split("_")[0], Double.valueOf(tc.split("_")[1]));
			}
		}
		
		//新增SettlementDetail表
		
		//取的派工明细表数据
		List<Record> dispRels = dispatchDao.getDispatchRels(orderSettlement.getDispatchId(), String.valueOf(orderSettlement.getSiteId()));
		List<OrderSettlementDetail> details = Lists.newArrayList();
		//算出有几条派工明细
		int empLen = (dispRels == null|| dispRels.size()==0) ? 1 : dispRels.size();
		
		Double d1 =0.00;
		Double d2 = 0.00;
		Double d3 =0.00;
		Double d4 = 0.00;
		String costDetail = "";//工程师A:50;工程师B50
		String costDt = "";
		String total = map.get("total_cost").toString();
		Double sumMoney = 0.00;
		if(ivan.common.utils.StringUtils.isEmpty(orderSettlement.getServiceMeasures())){
			d1 = MathUtils.getNormalDouble(map.get("serve_cost"))/empLen;
			d2 = MathUtils.getNormalDouble(map.get("auxiliary_cost"))/empLen;
			d3 = MathUtils.getNormalDouble(map.get("warranty_cost"))/empLen;
			d4 = MathUtils.getNormalDouble(map.get("other_cost"))/empLen;
			costDt = SettlementUtils.parseSettlementTemplate("1", 
					d1, d2, d3, d4);
			sumMoney = WebPageFunUtils.getTotalFee(d1 * empLen, d2 * empLen, d3*empLen, d4*empLen);
		}else{
			sumMoney = Double.valueOf(total);
			String combination = map.get("combination").toString();
			String[] com = combination.split(";");
			if(com.length>0){
				for(String id : com){
				String[] setId = id.split(":");
					Record rds = setTelDao.getSettlementId(setId[0]);
					if(StringUtils.isBlank(costDt)){
						costDt = rds.getStr("charge_name")+":"+setId[1]; 
					}else{
						costDt = costDt +";"+rds.getStr("charge_name")+":"+setId[1]; 
					}
				}
			}
		}
		for(Record rd : dispRels){
			if(StringUtils.isBlank(costDetail)){
				costDetail = rd.getStr("emp_name")+":"+(sumMoney/empLen);
				
			}else{
				costDetail = costDetail +";"+rd.getStr("emp_name")+":"+(sumMoney/empLen);
			}
		}
		orderSettlement.setCostDetail(costDetail);
		orderSettlement.setSumMoney(sumMoney);
		orderSettlement.setPaymentAmount(StringUtils.isEmpty(totalTc) ? 0d : Double.valueOf(String.valueOf(totalTc)));

		settlementDao.save(orderSettlement);
		
		for(Record rd : dispRels){		
			OrderSettlementDetail detail = null;
			if(detailMaps != null && detailMaps.containsKey(rd.getStr("emp_id"))){
				detail = detailMaps.get(rd.getStr("emp_id"));
			}else{
				detail = new OrderSettlementDetail(orderSettlement);
			}
			detail.setEmployeId(rd.getStr("emp_id"));
			detail.setEmployeName(rd.getStr("emp_name").trim());
			detail.setCostDetail(costDt);
			Double sumDt = WebPageFunUtils.getTotalFee(d1, d2, d3, d4);
//			detail.setPaymentAmount(empTcMap.get(detail.getEmployeId()) == null ? 0d : empTcMap.get(detail.getEmployeId()));
			detail.setSumMoney(sumDt);
			details.add(detail);
		}
		settlementDetailDao.save(details);
		
		Order order = orderDao.get(orderSettlement.getOrderId());
		
		//结算时工单状态更改以及增加一条过程

	Date processTime = new Date();
		String latestProcess = ProcessFormatter.getLatestProcess(ProcessFormatter.JIESUAN_TAG, 
				DateUtils.formatDate(processTime, "yyyy-MM-dd HH:mm:ss"), orderSettlement.getCreateName());
		String process = ProcessFormatter.getProcess(ProcessFormatter.JIESUAN_TAG, 
				DateUtils.formatDate(processTime, "yyyy-MM-dd HH:mm:ss"), orderSettlement.getCreateName());
		
		//String processDetail = ProcessFormatter.appendProcess(order.getProcessDetail(), process);
		order.setLatestProcessTime(processTime);
		//order.setProcessDetail(processDetail);
		order.setLatestProcess(latestProcess);
		String processDetaile="";
		Target ta=new Target();
		ta.setName(orderSettlement.getCreateName());
		ta.setType(ta.MESS_SETTLEMENT);
		ta.setContent(orderSettlement.getCreateName()+"已结算");
		ta.setTime(DateToStringUtils.DateToString());
		processDetaile=WebPageFunUtils.appendProcessDetail(ta, order.getProcessDetail());	

		order.setStatus("5");
		if(StringUtils.isNotBlank(order.getParentSiteId())) {
			order.setParentStatus("5");
		}
		
		String processDetailes="";
		Target tas=new Target();
		tas.setName(orderSettlement.getCreateName());
		tas.setType(tas.COMPLETE_ORDER);
		tas.setContent("工单已完成");
		tas.setTime(DateToStringUtils.DateToString());
		processDetailes=WebPageFunUtils.appendProcessDetail(tas, processDetaile);	
		order.setProcessDetail(processDetailes);
		orderDao.save(order);
	}

	@Transactional(readOnly = false)
	public void batchSaveSettlement(Map<String, Object> map, String siteId) {
		String dispIds = String.valueOf(map.get("dispIds"));
		String serviceMeasures = String.valueOf(map.get("serviceMeasures"));
		String[] dispArr = dispIds.split(",");
		List<Record> rels = dispatchDao.getDispatchRels(dispArr, siteId);
		
		StringBuilder orderIds = new StringBuilder("");
		
		
		for(int i = 0; i < dispArr.length; i++){
			String dispId = dispArr[i];
			List<Map<String, String>> relItem = Lists.newArrayList();
			
			OrderSettlement orderSettlement = new OrderSettlement();
			String orderId = "";
			int empLen = 0;
			for(Record rd : rels){
				if(dispId.equalsIgnoreCase(rd.getStr("dispatch_id")) && StringUtils.isNotBlank(rd.getStr("emp_id"))){
					empLen ++;
					Map<String, String> item = Maps.newHashMap();
					item.put("empId", rd.getStr("emp_id"));
					item.put("empName", rd.getStr("emp_name"));
					item.put("orderId", rd.getStr("order_id"));
					orderId = rd.getStr("order_id");
					relItem.add(item);
				}
			}
			orderIds.append(",").append(orderId);
			Order or = orderDao.get(orderId);
			Double d1 =0.00;
			Double d2 = 0.00;
			Double d3 =0.00;
			Double d4 = 0.00;
			String costDetail = "";//工程师A:50;工程师B50
			String costDt = "";
			String total = map.get("total_cost").toString();
			Double sumMoney = 0.00;
			if(ivan.common.utils.StringUtils.isEmpty(serviceMeasures)){
				orderSettlement.setServiceMeasures("1");
				String setmethodfw = String.valueOf(map.get("setmethodfw"));
				String setmethodfc = String.valueOf(map.get("setmethodfc"));
				String setmethodyb = String.valueOf(map.get("setmethodyb"));
				Double b1 =0.00;
				Double b2 = 0.00;
				Double b3 =0.00;
				Double b4 = 0.00;
				if("2".equals(setmethodfw)){//按比例结算
					b1 = or.getServeCost()* MathUtils.getNormalDouble(map.get("serve_costbl"))/empLen/100;
				}else{
					b1 = MathUtils.getNormalDouble(map.get("serve_cost"))/empLen;
				}
				if("2".equals(setmethodfc)){//按比例结算
					b2 = or.getAuxiliaryCost()*MathUtils.getNormalDouble(map.get("auxiliary_costbl"))/empLen/100;
				}else{
					b2 = MathUtils.getNormalDouble(map.get("auxiliary_cost"))/empLen;
				}
				if("2".equals(setmethodyb)){//按比例结算
					b3 = or.getWarrantyCost()*MathUtils.getNormalDouble(map.get("warranty_costbl"))/empLen/100;
				}else{
					b3 = MathUtils.getNormalDouble(map.get("warranty_cost"))/empLen;
				}

				b4 = MathUtils.getNormalDouble(map.get("other_cost"))/empLen;
				d1 = convertToDecimal(b1,2);
				d2 = convertToDecimal(b2,2);
				d3 = convertToDecimal(b3,2);
				d4 = convertToDecimal(b4,2);
				costDt = SettlementUtils.parseSettlementTemplate("1", 
						d1, d2, d3, d4);
				sumMoney = WebPageFunUtils.getTotalFee(d1 * empLen, d2 * empLen, d3*empLen, d4*empLen);
			}else{
				orderSettlement.setServiceMeasures(serviceMeasures);
				sumMoney = Double.valueOf(total);
				String combination = map.get("combination").toString();
				String[] com = combination.split(";");
				if(com.length>0){
					for(String id : com){
					String[] setId = id.split(":");
						Record rds = setTelDao.getSettlementId(setId[0]);
						if(StringUtils.isBlank(costDt)){
							costDt = rds.getStr("charge_name")+":"+setId[1]; 
						}else{
							costDt = costDt +";"+rds.getStr("charge_name")+":"+setId[1]; 
						}
					}
				}
			}
			for(Map<String, String> detailItem : relItem){
				if(StringUtils.isBlank(costDetail)){
					costDetail = detailItem.get("empName")+":"+(sumMoney/empLen);
					
				}else{
					costDetail = costDetail +";"+detailItem.get("empName")+":"+(sumMoney/empLen);
				}
			}

			orderSettlement.setCostDetail(costDetail);
			orderSettlement.setSumMoney(sumMoney);
			orderSettlement.setOrderId(orderId);
			orderSettlement.setCreateBy(String.valueOf(map.get("userId")));
			orderSettlement.setCreateName(String.valueOf(map.get("userName")));
			orderSettlement.setCreateTime(new Date());
			orderSettlement.setRemarks(String.valueOf(map.get("remarks")));
			orderSettlement.setPaymentAmount(sumMoney);
			orderSettlement.setDispatchId(dispId);
			orderSettlement.setSiteId(or.getSiteId());
			settlementDao.save(orderSettlement);
			
			Double detailAvgMoney =  MathUtils.getNormalDouble(sumMoney / empLen);
			
			for(Map<String, String> detailItem : relItem){
				OrderSettlementDetail detail = new OrderSettlementDetail(orderSettlement);
				detail.setEmployeId(detailItem.get("empId"));
				detail.setEmployeName(detailItem.get("empName"));
				detail.setCostDetail(costDt);
				Double sumDt = WebPageFunUtils.getTotalFee(d1, d2, d3, d4);
//				detail.setPaymentAmount(detailAvgMoney);
				detail.setSumMoney(sumDt);
				settlementDetailDao.save(detail);
			}
		}
		
		List<Order> orders = orderDao.getByDispatchId(orderIds.substring(1).split(","), siteId);
		
		for(Order order : orders){
			Date processTime = new Date();
			String latestProcess = ProcessFormatter.getLatestProcess(ProcessFormatter.JIESUAN_TAG, 
					DateUtils.formatDate(processTime, "yyyy-MM-dd HH:mm:ss"), map.get("userName"));
			String process = ProcessFormatter.getProcess(ProcessFormatter.JIESUAN_TAG, 
					DateUtils.formatDate(processTime, "yyyy-MM-dd HH:mm:ss"), map.get("userName"));
			//String processDetail = ProcessFormatter.appendProcess(order.getProcessDetail(), process);
			order.setLatestProcessTime(processTime);
			//order.setProcessDetail(processDetail);
			order.setLatestProcess(latestProcess);
			
			String processDetaile="";
			Target ta=new Target();
			ta.setName(CrmUtils.getUserName());
			ta.setType(ta.MESS_SETTLEMENT);
			ta.setContent(CrmUtils.getUserName()+"已结算");
			ta.setTime(DateToStringUtils.DateToString());
			processDetaile=WebPageFunUtils.appendProcessDetail(ta, order.getProcessDetail());	

			order.setStatus("5");
			if(StringUtils.isNotBlank(order.getParentSiteId())) {
				order.setParentStatus("5");
			}
			String processDetailes="";
			Target tas=new Target();
			tas.setName(CrmUtils.getUserName());
			tas.setType(tas.COMPLETE_ORDER);
			tas.setContent("工单已完成");
			tas.setTime(DateToStringUtils.DateToString());
			processDetailes=WebPageFunUtils.appendProcessDetail(tas, processDetaile);	
			order.setProcessDetail(processDetailes);
			orderDao.save(order);
		}
	}
	
	public Record getOrderSettlement(String siteId,String orderId){
		return  settlementDetailDao.getOrderSettlement(siteId, orderId);
	}
	//格式化数字四舍五入
	public static Double convertToDecimal(Double num, int scale){
		BigDecimal dec = new BigDecimal(num);
		Double dou = dec.setScale(scale, BigDecimal.ROUND_HALF_UP).doubleValue();
		return dou;
	}
}
