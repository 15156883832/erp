package com.jojowonet.modules.order.utils;

import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;

public class JqExcelCommonConvertor {
	//工单状态
	public static String orderStatus(Object obj){
		String status = getStr(obj);
		if("0".equals(status)){
			return "待接收";
		}else if("1".equals(status)){
			return "待派工";
		}else if("2".equals(status)){
			return "服务中";
		}else if("3".equals(status)){
			return "待回访";
		}else if("4".equals(status)){
			return "待结算";
		}else if("5".equals(status)){
				return "已完工";
		}else if("6".equals(status)){
			return "取消工单";
		}else if("7".equals(status)){
			return "暂不派工";
		}
		return "无效工单";
	}

	public static String empStatus(Object obj) {
		String status = getStr(obj);
		if("0".equals(status)){
			return "在职";
		}else if("1".equals(status)){
			return "--";
		}else if("3".equals(status)){
			return "离职";
		}else if("2".equals(status)){
			return "审核";
		}
		return "--";
	}
	
	public static String orderNo(Object numObj, Object nameObj){
		String num = getStr(numObj);
		String name = getStr(nameObj);
		return "NO:" + num + ", name:" + name;
	}
	//报修家电
	public static String orderAppliance(Object appliance_brandObj, Object appliance_categoryObj){
		String appliance_brand = getStr(appliance_brandObj);
		String appliance_category = getStr(appliance_categoryObj);
		if(!StringUtils.isNotBlank(appliance_brand)&&StringUtils.isNotBlank(appliance_category)){
			return appliance_category;
		}else if(!StringUtils.isNotBlank(appliance_category)&&StringUtils.isNotBlank(appliance_brand)){
			return appliance_brand;
		}else if(!StringUtils.isNotBlank(appliance_category)&&!StringUtils.isNotBlank(appliance_brand)){
			return "";
		}else{
			return appliance_brand+appliance_category;
		}
		
	}
	//信息等级
	public static String orderLevel(Object obj){
		String level = getStr(obj);
		if("1".equals(level)){
			return "紧急";
		}else if("2".equals(level)){
			return "一般";
		}
		return "";
	}
	
	//审核
	public static String reviewType(Object obj){
		String review = getStr(obj);
		if("1".equals(review)){
			return "审核通过";
		}else if("2".equals(review)){
			return "审核不通过";
		}
		return "未审核";
	}
	//保修类型
	public static String orderwarrantyType(Object obj){
		String type = getStr(obj);
		if("1".equals(type)){
			return "保内";
		}else if("2".equals(type)){
			return "保外";
		}else if("3".equals(type)){
			return "保外转保内";
		}
		return "";
	}
	//工单来源
	public static String orderType(Object obj){
		String type = getStr(obj);
		if("1".equals(type)){
			return "ERP系统录入";
		}else if("2".equals(type)){
			return "美的厂家系统";
		}else if("3".equals(type)){
			return "惠而浦厂家系统";
		}else if("4".equals(type)){
			return "海信厂家系统";
		}else if("5".equals(type)){
			return "海尔厂家系统";
		}else if ("9".equals(type)) {// 9.奥克斯厂家系统
			return "奥克斯厂家系统";
		} else if ("8".equals(type)) {// 8.格力厂家系统
			return "格力厂家系统";
		} else if ("f".equals(type)) {// f.美菱厂家系统
			return "美菱厂家系统";
		} else if ("g".equals(type)) {// g.Tcl厂家系统
			return "Tcl厂家系统";
		} else if ("h".equals(type)) {// h.苏宁厂家系统
			return "苏宁厂家系统";
		}
		return "";
	}
	//服务方式
	public static String serviceMode(Object obj){
		String type = getStr(obj);
		if("1".equals(type)){
			return "上门";
		}else if("2".equals(type)){
			return "拉修";
		}
		return "";
	}
/*	//交回卡单
	public static String returnCard(String type){
		if("0".equals(type)){
			return "否";
		}else if("1".equals(type)){
			return "是";
		}
		return "";
	}*/
	//是否交款
	public static String whetherCollection(Object obj){
		String type = getStr(obj);
		if("0".equals(type)){
			return "否";
		}else if("1".equals(type)){
			return "是";
		}
		return "";
	}
	
	public static String returnCord(Object obj){
		String type = getStr(obj);
		if("0".equals(type)){
			return "否";
		}else if("1".equals(type)){
			return "是";
		}
		return "";
		
	}
	public static String orderFwz(Object obj){
		String disp_status = getStr(obj);
		if("1".equals(disp_status)){
			return "待接单";
		}else if("2".equals(disp_status)){
			return "待上门";
		}else if("3".equals(disp_status)){
			return "待派工";
		}else if("4".equals(disp_status)){
			return "服务中";
		}else if("5".equals(disp_status)){
			return "维修已完工";
		}else if("6".equals(disp_status)){
			return "已转派";
		}else if("7".equals(disp_status)){
			return "派工取消";
		}
		return "服务中";
	}
	
	public static String orderYJ(Object disStatusObj){
		String disStatus = getStr(disStatusObj);
		if("1".equals(disStatus)){
			return "待接单";
		}else if("2".equals(disStatus)){
			return "待上门";
		}else if("3".equals(disStatus)){
			return "待派工";
		}else if("4".equals(disStatus)){
			return "服务中";
		}else if("5".equals(disStatus)){
			return "维修已完工";
		}else if("6".equals(disStatus)){
			return "已转派";
		}else if("7".equals(disStatus)){
			return "派工取消";
		}
		return "服务中";
	}

	private static String getStr(Object obj){
		if(obj instanceof BigDecimal){
			return ((BigDecimal) obj).toPlainString();
		}else {
			return String.valueOf(obj);
		}
	}

	public static String recordAccount(Object obj){
		String type = getStr(obj);
		if("0".equals(type)){
			return "未确认";
		}else if("1".equals(type)){
			return "已确认";
		}
		return "";
	}
	
}