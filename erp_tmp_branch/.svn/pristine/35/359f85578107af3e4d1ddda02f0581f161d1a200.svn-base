package com.jojowonet.modules.statistics.form;

import ivan.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;

public class OldStockIndexExport {
	
	//主要用于导出
				private String code;
				private String name; //备件名称
				private String version;//型号
				private String brand; //品牌
				private String num;//数量
				private String fittingPrice; //单价
				private String employeName;//服务工程师
				private String yrpzFlag;//是否原配
				private String totalPrice;//旧件总价

				@Length(min = 1, max = 50)
				@ExcelField(title = "备件条码", align = 2, sort=0)
				public String getCode() {
					return code;
				}
				public void setCode(String code) {
					this.code = code;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "备件名称", align = 2, sort=1)
				public String getName() {
					return name;
				}
				public void setName(String name) {
					this.name = name;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "旧件型号", align = 2, sort=2)
				public String getVersion() {
					return version;
				}
				public void setVersion(String version) {
					this.version = version;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "旧件品牌", align = 2, sort=3)
				public String getBrand() {
					return brand;
				}
				public void setBrand(String brand) {
					this.brand = brand;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "登记数量", align = 2, sort=4)
				public String getNum() {
					return num;
				}
				public void setNum(String num) {
					this.num = num;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "旧件单价", align = 2, sort=5)
				public String getFittingPrice() {
					return fittingPrice;
				}
				public void setFittingPrice(String fittingPrice) {
					this.fittingPrice = fittingPrice;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "服务工程师", align = 2, sort=6)
				public String getEmployeName() {
					return employeName;
				}
				public void setEmployeName(String employeName) {
					this.employeName = employeName;
				}

				@Length(min = 1, max = 50)
				@ExcelField(title = "是否原配", align = 2, sort=7)
				public String getYrpzFlag() {
					return yrpzFlag;
				}
				public void setYrpzFlag(String yrpzFlag) {
					this.yrpzFlag = yrpzFlag;
				}
				@Length(min = 1, max = 50)
				@ExcelField(title = "旧件总价", align = 2, sort=8)
				public String getTotalPrice() {
					return totalPrice;
				}
				public void setTotalPrice(String totalPrice) {
					this.totalPrice = totalPrice;
				}

				

}
