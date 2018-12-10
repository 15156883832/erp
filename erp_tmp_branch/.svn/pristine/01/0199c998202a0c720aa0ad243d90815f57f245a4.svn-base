package com.jojowonet.modules.statistics.form;

import ivan.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

public class StockIndexExport {
	
	//主要用于导出
			private String code;
				private String name; //备件名称
				private String warning;//库存总量
				private String total; //入库总量
				private String outTotal;//出库总量
				private String fhNum; //返还总量
				private String useNum;//使用总量
				
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
				@ExcelField(title = "库存总量", align = 2, sort=2)
				public String getWarning() {
					return warning;
				}
				public void setWarning(String warning) {
					this.warning = warning;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "入库总量", align = 2, sort=3)
				public String getTotal() {
					return total;
				}
				public void setTotal(String total) {
					this.total = total;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "出库总量", align = 2, sort=4)
				public String getOutTotal() {
					return outTotal;
				}
				public void setOutTotal(String outTotal) {
					this.outTotal = outTotal;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "返还总量", align = 2, sort=5)
				public String getFhNum() {
					return fhNum;
				}
				public void setFhNum(String fhNum) {
					this.fhNum = fhNum;
				}
				
				@Length(min = 1, max = 50)
				@ExcelField(title = "使用总量", align = 2, sort=6)
				public String getUseNum() {
					return useNum;
				}
				public void setUseNum(String useNum) {
					this.useNum = useNum;
				}
				
				

}
