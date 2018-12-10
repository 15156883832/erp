/**
 */
package com.jojowonet.modules.order.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * 查询信息Entity
 * @author Ivan
 * @version 2017-11-02
 */
@Entity
@Table(name = "crm_query_times")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class QueryTimes implements Serializable {
	private static final Integer COUNT = 0;
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String siteId;
	private Integer numberCount;
	private Integer customerNameCount;
	private Integer customerMobileCount;
	private Integer customerAddressCount;
	private Integer originCount;
	private Integer serviceTypeCount;
	private Integer applicationCategoryCount;
	private Integer statusCount;
	private Integer flagCount;
	private Integer employeCount;
	private Integer applicationBrandCount;
	private Integer applianceModelCount;
	private Integer applianceBarcodeCount;
	private Integer warrantyTypeCount;
	private Integer levelCount;
	private Integer serviceModeCount;
	private Integer orderTypeCount;
	private Integer promiseTimeCount;
	private Integer returnCardCount;
	private Integer orderCostCount;
	private Integer whetherCollectionCount;
	private Integer repairTimeMaxCount;
	private Integer repairTimeCount;
	private Integer endTimeCount;
	private Integer endTimeMaxCount;
	private Integer dispatchTimeCount;
	private Integer dispatchTimeMaxCount;
	private Integer messengerNameCount;
	//菜单
	private Integer wholeOrderCount;
	private Integer dpgOrderCount;
	private Integer duringOrderCount;
	private Integer stayvisitOrderCount;
	private Integer historyOrderCount;
	private Integer zbpgOrderCount;
	private Integer jjgdOrderCount;
	private Integer jryyOrderCount;
	private Integer djgdOrderCount;
	private Integer yjgdOrderCount;
	private Integer daijgdOrderCount;
	private Integer dhfOrderCount;
	private Integer djsOrderCount;
	private Integer ywgOrderCount;
	private Integer wxOrderCount;
	//按钮
	private Integer updateOrderCount;//修改工单
	private Integer invalidOrderCount;//无效工单
	private Integer temporarilyOrderCount;//暂不派工
	private Integer feedbackOrderCount;//反馈封单
	private Integer signOrderCount;//标记工单
	private Integer printOrderCount;//打印工单
	
	

	public QueryTimes() {
		super();
		this.applianceBarcodeCount = COUNT;
		this.applianceModelCount = COUNT;
		this.applicationBrandCount = COUNT;
		this.applicationCategoryCount= COUNT;
		this.customerAddressCount = COUNT;
		this.customerMobileCount = COUNT;
		this.customerNameCount= COUNT;
		this.daijgdOrderCount= COUNT;
		this.dhfOrderCount= COUNT;
		this.dispatchTimeCount= COUNT;
		this.dispatchTimeMaxCount= COUNT;
		this.djgdOrderCount= COUNT;
		this.djsOrderCount= COUNT;
		this.dpgOrderCount= COUNT;
		this.duringOrderCount= COUNT;
		this.employeCount= COUNT;
		this.endTimeCount= COUNT;
		this.endTimeMaxCount= COUNT;
		this.flagCount= COUNT;
		this.historyOrderCount= COUNT;
		this.jjgdOrderCount= COUNT;
		this.jryyOrderCount= COUNT;
		this.levelCount= COUNT;
		this.messengerNameCount= COUNT;
		this.numberCount= COUNT;
		this.orderCostCount= COUNT;
		this.orderTypeCount= COUNT;
		this.originCount= COUNT;
		this.promiseTimeCount= COUNT;
		this.repairTimeCount= COUNT;
		this.repairTimeMaxCount= COUNT;
		this.returnCardCount= COUNT;
		this.serviceModeCount= COUNT;
		this.serviceTypeCount= COUNT;
		this.statusCount= COUNT;
		this.stayvisitOrderCount= COUNT;
		this.warrantyTypeCount= COUNT;
		this.whetherCollectionCount= COUNT;
		this.wholeOrderCount= COUNT;
		this.wxOrderCount= COUNT;
		this.yjgdOrderCount= COUNT;
		this.ywgOrderCount= COUNT;
		this.zbpgOrderCount= COUNT;
		this.updateOrderCount = COUNT;
		this.invalidOrderCount = COUNT;
		this.temporarilyOrderCount = COUNT;
		this.feedbackOrderCount = COUNT;
		this.signOrderCount = COUNT;
		this.printOrderCount = COUNT;
	}

	public QueryTimes(String id){
		this();
		this.id = id;
	}
	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public Integer getNumberCount() {
		return numberCount;
	}

	public void setNumberCount(Integer numberCount) {
		this.numberCount = numberCount;
	}

	public Integer getCustomerNameCount() {
		return customerNameCount;
	}

	public void setCustomerNameCount(Integer customerNameCount) {
		this.customerNameCount = customerNameCount;
	}

	public Integer getCustomerMobileCount() {
		return customerMobileCount;
	}

	public void setCustomerMobileCount(Integer customerMobileCount) {
		this.customerMobileCount = customerMobileCount;
	}

	public Integer getCustomerAddressCount() {
		return customerAddressCount;
	}

	public void setCustomerAddressCount(Integer customerAddressCount) {
		this.customerAddressCount = customerAddressCount;
	}

	public Integer getOriginCount() {
		return originCount;
	}

	public void setOriginCount(Integer originCount) {
		this.originCount = originCount;
	}

	public Integer getServiceTypeCount() {
		return serviceTypeCount;
	}

	public void setServiceTypeCount(Integer serviceTypeCount) {
		this.serviceTypeCount = serviceTypeCount;
	}

	public Integer getApplicationCategoryCount() {
		return applicationCategoryCount;
	}

	public void setApplicationCategoryCount(Integer applicationCategoryCount) {
		this.applicationCategoryCount = applicationCategoryCount;
	}

	public Integer getStatusCount() {
		return statusCount;
	}

	public void setStatusCount(Integer statusCount) {
		this.statusCount = statusCount;
	}

	public Integer getFlagCount() {
		return flagCount;
	}

	public void setFlagCount(Integer flagCount) {
		this.flagCount = flagCount;
	}

	public Integer getEmployeCount() {
		return employeCount;
	}

	public void setEmployeCount(Integer employeCount) {
		this.employeCount = employeCount;
	}

	public Integer getApplicationBrandCount() {
		return applicationBrandCount;
	}

	public void setApplicationBrandCount(Integer applicationBrandCount) {
		this.applicationBrandCount = applicationBrandCount;
	}

	public Integer getApplianceModelCount() {
		return applianceModelCount;
	}

	public void setApplianceModelCount(Integer applianceModelCount) {
		this.applianceModelCount = applianceModelCount;
	}

	public Integer getApplianceBarcodeCount() {
		return applianceBarcodeCount;
	}

	public void setApplianceBarcodeCount(Integer applianceBarcodeCount) {
		this.applianceBarcodeCount = applianceBarcodeCount;
	}

	public Integer getWarrantyTypeCount() {
		return warrantyTypeCount;
	}

	public void setWarrantyTypeCount(Integer warrantyTypeCount) {
		this.warrantyTypeCount = warrantyTypeCount;
	}

	public Integer getLevelCount() {
		return levelCount;
	}

	public void setLevelCount(Integer levelCount) {
		this.levelCount = levelCount;
	}

	public Integer getServiceModeCount() {
		return serviceModeCount;
	}

	public void setServiceModeCount(Integer serviceModeCount) {
		this.serviceModeCount = serviceModeCount;
	}

	public Integer getOrderTypeCount() {
		return orderTypeCount;
	}

	public void setOrderTypeCount(Integer orderTypeCount) {
		this.orderTypeCount = orderTypeCount;
	}

	public Integer getPromiseTimeCount() {
		return promiseTimeCount;
	}

	public void setPromiseTimeCount(Integer promiseTimeCount) {
		this.promiseTimeCount = promiseTimeCount;
	}

	public Integer getReturnCardCount() {
		return returnCardCount;
	}

	public void setReturnCardCount(Integer returnCardCount) {
		this.returnCardCount = returnCardCount;
	}

	public Integer getOrderCostCount() {
		return orderCostCount;
	}

	public void setOrderCostCount(Integer orderCostCount) {
		this.orderCostCount = orderCostCount;
	}

	public Integer getWhetherCollectionCount() {
		return whetherCollectionCount;
	}

	public void setWhetherCollectionCount(Integer whetherCollectionCount) {
		this.whetherCollectionCount = whetherCollectionCount;
	}

	public Integer getRepairTimeMaxCount() {
		return repairTimeMaxCount;
	}

	public void setRepairTimeMaxCount(Integer repairTimeMaxCount) {
		this.repairTimeMaxCount = repairTimeMaxCount;
	}

	public Integer getRepairTimeCount() {
		return repairTimeCount;
	}

	public void setRepairTimeCount(Integer repairTimeCount) {
		this.repairTimeCount = repairTimeCount;
	}

	public Integer getEndTimeCount() {
		return endTimeCount;
	}

	public void setEndTimeCount(Integer endTimeCount) {
		this.endTimeCount = endTimeCount;
	}

	public Integer getEndTimeMaxCount() {
		return endTimeMaxCount;
	}

	public void setEndTimeMaxCount(Integer endTimeMaxCount) {
		this.endTimeMaxCount = endTimeMaxCount;
	}

	public Integer getDispatchTimeCount() {
		return dispatchTimeCount;
	}

	public void setDispatchTimeCount(Integer dispatchTimeCount) {
		this.dispatchTimeCount = dispatchTimeCount;
	}

	public Integer getDispatchTimeMaxCount() {
		return dispatchTimeMaxCount;
	}

	public void setDispatchTimeMaxCount(Integer dispatchTimeMaxCount) {
		this.dispatchTimeMaxCount = dispatchTimeMaxCount;
	}

	public Integer getMessengerNameCount() {
		return messengerNameCount;
	}

	public void setMessengerNameCount(Integer messengerNameCount) {
		this.messengerNameCount = messengerNameCount;
	}

	public Integer getWholeOrderCount() {
		return wholeOrderCount;
	}

	public void setWholeOrderCount(Integer wholeOrderCount) {
		this.wholeOrderCount = wholeOrderCount;
	}

	public Integer getDpgOrderCount() {
		return dpgOrderCount;
	}

	public void setDpgOrderCount(Integer dpgOrderCount) {
		this.dpgOrderCount = dpgOrderCount;
	}

	public Integer getDuringOrderCount() {
		return duringOrderCount;
	}

	public void setDuringOrderCount(Integer duringOrderCount) {
		this.duringOrderCount = duringOrderCount;
	}

	public Integer getStayvisitOrderCount() {
		return stayvisitOrderCount;
	}

	public void setStayvisitOrderCount(Integer stayvisitOrderCount) {
		this.stayvisitOrderCount = stayvisitOrderCount;
	}

	public Integer getHistoryOrderCount() {
		return historyOrderCount;
	}

	public void setHistoryOrderCount(Integer historyOrderCount) {
		this.historyOrderCount = historyOrderCount;
	}

	public Integer getZbpgOrderCount() {
		return zbpgOrderCount;
	}

	public void setZbpgOrderCount(Integer zbpgOrderCount) {
		this.zbpgOrderCount = zbpgOrderCount;
	}

	public Integer getJjgdOrderCount() {
		return jjgdOrderCount;
	}

	public void setJjgdOrderCount(Integer jjgdOrderCount) {
		this.jjgdOrderCount = jjgdOrderCount;
	}

	public Integer getJryyOrderCount() {
		return jryyOrderCount;
	}

	public void setJryyOrderCount(Integer jryyOrderCount) {
		this.jryyOrderCount = jryyOrderCount;
	}

	public Integer getDjgdOrderCount() {
		return djgdOrderCount;
	}

	public void setDjgdOrderCount(Integer djgdOrderCount) {
		this.djgdOrderCount = djgdOrderCount;
	}

	public Integer getYjgdOrderCount() {
		return yjgdOrderCount;
	}

	public void setYjgdOrderCount(Integer yjgdOrderCount) {
		this.yjgdOrderCount = yjgdOrderCount;
	}

	public Integer getDaijgdOrderCount() {
		return daijgdOrderCount;
	}

	public void setDaijgdOrderCount(Integer daijgdOrderCount) {
		this.daijgdOrderCount = daijgdOrderCount;
	}

	public Integer getDhfOrderCount() {
		return dhfOrderCount;
	}

	public void setDhfOrderCount(Integer dhfOrderCount) {
		this.dhfOrderCount = dhfOrderCount;
	}

	public Integer getDjsOrderCount() {
		return djsOrderCount;
	}

	public void setDjsOrderCount(Integer djsOrderCount) {
		this.djsOrderCount = djsOrderCount;
	}

	public Integer getYwgOrderCount() {
		return ywgOrderCount;
	}

	public void setYwgOrderCount(Integer ywgOrderCount) {
		this.ywgOrderCount = ywgOrderCount;
	}

	public Integer getWxOrderCount() {
		return wxOrderCount;
	}

	public void setWxOrderCount(Integer wxOrderCount) {
		this.wxOrderCount = wxOrderCount;
	}

	public Integer getUpdateOrderCount() {
		return updateOrderCount;
	}

	public void setUpdateOrderCount(Integer updateOrderCount) {
		this.updateOrderCount = updateOrderCount;
	}

	public Integer getInvalidOrderCount() {
		return invalidOrderCount;
	}

	public void setInvalidOrderCount(Integer invalidOrderCount) {
		this.invalidOrderCount = invalidOrderCount;
	}

	public Integer getTemporarilyOrderCount() {
		return temporarilyOrderCount;
	}

	public void setTemporarilyOrderCount(Integer temporarilyOrderCount) {
		this.temporarilyOrderCount = temporarilyOrderCount;
	}

	public Integer getFeedbackOrderCount() {
		return feedbackOrderCount;
	}

	public void setFeedbackOrderCount(Integer feedbackOrderCount) {
		this.feedbackOrderCount = feedbackOrderCount;
	}

	public Integer getSignOrderCount() {
		return signOrderCount;
	}

	public void setSignOrderCount(Integer signOrderCount) {
		this.signOrderCount = signOrderCount;
	}

	public Integer getPrintOrderCount() {
		return printOrderCount;
	}

	public void setPrintOrderCount(Integer printOrderCount) {
		this.printOrderCount = printOrderCount;
	}
	 
	
}


