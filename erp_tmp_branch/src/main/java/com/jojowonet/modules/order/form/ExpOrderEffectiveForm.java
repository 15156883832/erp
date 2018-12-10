package com.jojowonet.modules.order.form;

import ivan.common.utils.excel.annotation.ExcelField;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.jfinal.plugin.activerecord.Record;

public class ExpOrderEffectiveForm {
    
    private String orderNum;
    private String originName;    // 名称
    private String customerName;    // 备件条码
    private String customerMobile;
    private String employeName;
    private String customerAddress;  //  备件来源
    private String disJD30;
    private String isAz;    // 关键字
    private String disOV24;    //
    private String isDcsm;
    private String isYhmy;
    private String isDb;
    private String bjApp6;
    
    public ExpOrderEffectiveForm() {
        super();
    }

    public ExpOrderEffectiveForm(Record rd) {
        this.orderNum = rd.getStr("number");
        this.originName = rd.getStr("originName");
        this.customerName = rd.getStr("customer_name");
        this.customerMobile = rd.getStr("customer_mobile");
        this.customerAddress = rd.getStr("customer_address");
        this.employeName = rd.getStr("employe_name");
        this.disJD30 = String.valueOf(rd.get("disJD30"));
        this.isAz = String.valueOf(rd.get("isAz"));
        this.disOV24 = String.valueOf(rd.get("disOV24"));
        this.isDcsm = String.valueOf(rd.get("isDcsm"));
        this.isYhmy = String.valueOf(rd.get("isYhmy"));
        this.isDb = String.valueOf(rd.get("isDb"));
        this.bjApp6 = String.valueOf(rd.get("bjApp6"));
    }
    
    @ExcelField(title = "工单编号", align = 2, sort=1)
    public String getOrderNum() {
        return orderNum;
    }
    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }
    
    @ExcelField(title = "来源", align = 2, sort=10)
    public String getOriginName() {
        return originName;
    }
    public void setOriginName(String originName) {
        this.originName = originName;
    }
    
    @ExcelField(title = "用户姓名", align = 2, sort=20)
    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    @ExcelField(title = "用户电话", align = 2, sort=30)
    public String getCustomerMobile() {
        return customerMobile;
    }
    public void setCustomerMobile(String customerMobile) {
        this.customerMobile = customerMobile;
    }
    
    @ExcelField(title = "服务工程师", align = 2, sort=40)
    public String getEmployeName() {
        return employeName;
    }
    public void setEmployeName(String employeName) {
        this.employeName = employeName;
    }
    
    @ExcelField(title = "用户地址", align = 2, sort=50)
    public String getCustomerAddress() {
        return customerAddress;
    }
    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }
    @ExcelField(title = "派单接收及时(30分钟)", align = 2, sort=60)
    public String getDisJD30() {
        return disJD30;
    }
    public void setDisJD30(String disJD30) {
        this.disJD30 = disJD30;
    }
    @ExcelField(title = "维修安装成功否", align = 2, sort=70)
    public String getIsAz() {
        return isAz;
    }
    public void setIsAz(String isAz) {
        this.isAz = isAz;
    }
    @ExcelField(title = "超期未完成(24小时)", align = 2, sort=80)
    public String getDisOV24() {
        return disOV24;
    }
    public void setDisOV24(String disOV24) {
        this.disOV24 = disOV24;
    }
    @ExcelField(title = "多次上门否", align = 2, sort=90)
    public String getIsDcsm() {
        return isDcsm;
    }
    public void setIsDcsm(String isDcsm) {
        this.isDcsm = isDcsm;
    }
    @ExcelField(title = "确认用户满意否", align = 2, sort=100)
    public String getIsYhmy() {
        return isYhmy;
    }
    public void setIsYhmy(String isYhmy) {
        this.isYhmy = isYhmy;
    }
    @ExcelField(title = "确认标准化达标否", align = 2, sort=110)
    public String getIsDb() {
        return isDb;
    }
    public void setIsDb(String isDb) {
        this.isDb = isDb;
    }
    @ExcelField(title = "备件是否6小时内申请", align = 2, sort=120)
    public String getBjApp6() {
        return bjApp6;
    }
    public void setBjApp6(String bjApp6) {
        this.bjApp6 = bjApp6;
    }

    
}
