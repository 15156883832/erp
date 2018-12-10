package com.jojowonet.modules.order.form;


import ivan.common.utils.DateUtils;
import ivan.common.utils.excel.annotation.ExcelField;

import com.jfinal.plugin.activerecord.Record;

public class ExpBaowaiChargesForm {
    
	private String orderNum;
	private String empName;
	private String callBackFee;//回访确认收费
	private String costFee;//收费金额
	private String customerName;
	private String customerMobile;
	private String customerAddress;
	private String brand;
	private String category;
	private String repairType;
	private String endTime;
    
	public ExpBaowaiChargesForm(Record rd) {
		super();
		this.orderNum = rd.getStr("number");
		this.empName = rd.getStr("employe_name");
		String wc = rd.getStr("whether_collection");
		if("0".equals(wc)){
			this.callBackFee = "否";
		}else if("1".equals(wc)){
			this.callBackFee = "是";
		}
		this.costFee = String.valueOf(rd.get("total_collection"));
		this.customerName = rd.getStr("customer_name");
		this.customerMobile = rd.getStr("customer_mobile");
		this.customerAddress = rd.getStr("customer_address");
		this.brand = rd.getStr("appliance_brand");
		this.category = rd.getStr("appliance_category");
		String rt = rd.getStr("repair_type");
		//1.维修 2.安装 3.咨询 4.保养 5.工程 6.其他
		if("1".equals(rt)){
			this.repairType = "维修";
		}else if("2".equals(rt)){
			this.repairType = "安装";
		}else if("3".equals(rt)){
			this.repairType = "咨询";
		}else if("4".equals(rt)){
			this.repairType = "保养";
		}else if("5".equals(rt)){
			this.repairType = "工程";
		}else if("6".equals(rt)){
			this.repairType = "其他";
		}
		if(rd.get("end_time") != null){
			this.endTime = DateUtils.formatDate(rd.getDate("end_time"), "yyyy-MM-dd HH:mm:ss");
		}
	}
	
	@ExcelField(title = "工单编号", align = 2, sort=10)
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	@ExcelField(title = "服务工程师", align = 2, sort=20)
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	@ExcelField(title = "回访确认收费", align = 2, sort=30)
	public String getCallBackFee() {
		return callBackFee;
	}
	public void setCallBackFee(String callBackFee) {
		this.callBackFee = callBackFee;
	}
	@ExcelField(title = "收费金额", align = 2, sort=40)
	public String getCostFee() {
		return costFee;
	}
	public void setCostFee(String costFee) {
		this.costFee = costFee;
	}
	@ExcelField(title = "用户姓名", align = 2, sort=50)
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	@ExcelField(title = "联系方式", align = 2, sort=60)
	public String getCustomerMobile() {
		return customerMobile;
	}
	public void setCustomerMobile(String customerMobile) {
		this.customerMobile = customerMobile;
	}
	@ExcelField(title = "详细地址", align = 2, sort=70)
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	@ExcelField(title = "家电品牌", align = 2, sort=80)
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	@ExcelField(title = "家电类型", align = 2, sort=90)
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@ExcelField(title = "施工类型", align = 2, sort=100)
	public String getRepairType() {
		return repairType;
	}
	public void setRepairType(String repairType) {
		this.repairType = repairType;
	}
	@ExcelField(title = "完工时间", align = 2, sort=110)
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public ExpBaowaiChargesForm() {
		super();
	}
	
	
}
