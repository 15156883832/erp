package com.jojowonet.modules.statistics.form;

import ivan.common.utils.excel.annotation.ExcelField;

import org.hibernate.validator.constraints.Length;

public class GoodsIndexExport {
	
	//主要用于导出

		private String good_name; //商品名称
		private String good_category;//商品类别
		private String good_number; //商品编号
		private String stocks; //库存总量
		private String purchaseNum;//销售数量
		private String saleMoney; //销售金额
		
		
		@Length(min = 1, max = 50)
		@ExcelField(title = "商品名称", align = 2, sort=0)
		public String getGood_name() {
			return good_name;
		}
		public void setGood_name(String good_name) {
			this.good_name = good_name;
		}
		
		@Length(min = 1, max = 50)
		@ExcelField(title = "商品类别", align = 2, sort=1)
		public String getGood_category() {
			return good_category;
		}
		public void setGood_category(String good_category) {
			this.good_category = good_category;
		}
		
		
		
		@Length(min = 1, max = 50)
		@ExcelField(title = "商品编号", align = 2, sort=2)
		public String getGood_number() {
			return good_number;
		}
		public void setGood_number(String good_number) {
			this.good_number = good_number;
		}
		
		@Length(min = 1, max = 50)
		@ExcelField(title = "库存总量", align = 2, sort=3)
		public String getStocks() {
			return stocks;
		}
		public void setStocks(String stocks) {
			this.stocks = stocks;
		}
		
		@Length(min = 1, max = 50)
		@ExcelField(title = "销售数量", align = 2, sort=4)
		public String getPurchaseNum() {
			return purchaseNum;
		}
		public void setPurchaseNum(String purchaseNum) {
			this.purchaseNum = purchaseNum;
		}
		
		@Length(min = 1, max = 50)
		@ExcelField(title = "销售金额(元)", align = 2, sort=5)
		public String getSaleMoney() {
			return saleMoney;
		}
		public void setSaleMoney(String saleMoney) {
			this.saleMoney = saleMoney;
		}
		
		


}
