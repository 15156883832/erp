package com.jojowonet.modules.order.form;

/**
 * 用于信息员代反馈
*/
public class GenerationOrderFrom {
	
	private String orderId;
	private String disOrderId;
	private String orderemployeId;
	private String feedback;
	private String feedbackType;//存数字
	private String serviceType;
	private String serviceMode;
	private String applianceCategory;
	private String applianceModel;
	private String applianceBarcode;
	private String applianceMachineCode;//外机条码
	private Double auxiliaryCost;
	private Double warrantyCost;
	private Double serveCost;
	private String malfunctionType;
	private String warrantyType;
	//	过程图片
	private String pickerImg;
	private String feedbackId;

	
	//旧件图片
	private String oldPartsImg;

	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getDisOrderId() {
		return disOrderId;
	}
	public void setDisOrderId(String disOrderId) {
		this.disOrderId = disOrderId;
	}
	public String getOrderemployeId() {
		return orderemployeId;
	}
	public void setOrderemployeId(String orderemployeId) {
		this.orderemployeId = orderemployeId;
	}

	
	public String getFeedback() {
		return feedback;
	}
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	public String getFeedbackType() {
		return feedbackType;
	}
	public void setFeedbackType(String feedbackType) {
		this.feedbackType = feedbackType;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getServiceMode() {
		return serviceMode;
	}
	public void setServiceMode(String serviceMode) {
		this.serviceMode = serviceMode;
	}
	public String getApplianceCategory() {
		return applianceCategory;
	}
	public void setApplianceCategory(String applianceCategory) {
		this.applianceCategory = applianceCategory;
	}
	public String getApplianceModel() {
		return applianceModel;
	}
	public void setApplianceModel(String applianceModel) {
		this.applianceModel = applianceModel;
	}
	public String getApplianceBarcode() {
		return applianceBarcode;
	}
	public void setApplianceBarcode(String applianceBarcode) {
		this.applianceBarcode = applianceBarcode;
	}
	public String getApplianceMachineCode() {
		return applianceMachineCode;
	}
	public void setApplianceMachineCode(String applianceMachineCode) {
		this.applianceMachineCode = applianceMachineCode;
	}
	public Double getAuxiliaryCost() {
		return auxiliaryCost;
	}
	public void setAuxiliaryCost(Double auxiliaryCost) {
		this.auxiliaryCost = auxiliaryCost;
	}
	public Double getWarrantyCost() {
		return warrantyCost;
	}
	public void setWarrantyCost(Double warrantyCost) {
		this.warrantyCost = warrantyCost;
	}
	
	public Double getServeCost() {
		return serveCost;
	}
	public void setServeCost(Double serveCost) {
		this.serveCost = serveCost;
	}
	public String getMalfunctionType() {
		return malfunctionType;
	}
	public void setMalfunctionType(String malfunctionType) {
		this.malfunctionType = malfunctionType;
	}
	public String getWarrantyType() {
		return warrantyType;
	}
	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}
	public String getPickerImg() {
		return pickerImg;
	}
	public void setPickerImg(String pickerImg) {
		this.pickerImg = pickerImg;
	}
	
	public String getOldPartsImg() {
		return oldPartsImg;
	}
	public void setOldPartsImg(String oldPartsImg) {
		this.oldPartsImg = oldPartsImg;
	}
	public String getFeedbackId() {
		return feedbackId;
	}
	public void setFeedbackId(String feedbackId) {
		this.feedbackId = feedbackId;
	}
	
	

}
