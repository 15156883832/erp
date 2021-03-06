package com.jojowonet.modules.order.adapters;

import com.jfinal.plugin.activerecord.Record;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public class HistoryBkOrderCallback extends JBean {

	public HistoryBkOrderCallback(Record record) {
		super(record);
	}

	public void setId(String id) {
		set("id", id);
	}

	public String getId() {
		return get("id");
	}

	public void setOrderId(String orderId) {
		set("order_id", orderId);
	}

	public String getOrderId() {
		return get("order_id");
	}

	public void setDispatchId(String dispatchId) {
		set("dispatch_id", dispatchId);
	}

	public String getDispatchId() {
		return get("dispatch_id");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

	public void setCreateBy(String createBy) {
		set("create_by", createBy);
	}

	public String getCreateBy() {
		return get("create_by");
	}

	public void setCreateName(String createName) {
		set("create_name", createName);
	}

	public String getCreateName() {
		return get("create_name");
	}

	public void setSafetyEvaluation(String safetyEvaluation) {
		set("safety_evaluation", safetyEvaluation);
	}

	public String getSafetyEvaluation() {
		return get("safety_evaluation");
	}

	public void setServiceAttitude(String serviceAttitude) {
		set("service_attitude", serviceAttitude);
	}

	public String getServiceAttitude() {
		return get("service_attitude");
	}

	public void setMultipleDropin(String multipleDropin) {
		set("multiple_dropin", multipleDropin);
	}

	public String getMultipleDropin() {
		return get("multiple_dropin");
	}

	public void setResult(String result) {
		set("result", result);
	}

	public String getResult() {
		return get("result");
	}

	public void setRemarks(String remarks) {
		set("remarks", remarks);
	}

	public String getRemarks() {
		return get("remarks");
	}

	public void setSiteId(String siteId) {
		set("site_id", siteId);
	}

	public String getSiteId() {
		return get("site_id");
	}

}
