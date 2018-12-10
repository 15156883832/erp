package com.jojowonet.modules.order.form.constant;

public class Factory {

	public static final String MIDEA = "midea";
	public static final String WHIRLPOOL = "whirlpool";
	public static final String HISENSE = "hisense";
	public static final String HAIER = "haier";
	public static final String AUX = "aux";
	public static final String GREE = "gree";
	public static final String MELING = "meling";
	public static final String HAIER2 = "haier2";
	public static final String TCL = "tcl";
	public static final String SUNING = "suning";
	public static final String GOME = "gome";
	public static final String JD = "jd";
	
	public static String getFactoryLabel(String name){
		if("美的".equals(name)){
			return MIDEA;
		}else if("惠而浦".equals(name)){
			return WHIRLPOOL;
		}else if("海信".equals(name)){
			return HISENSE;
		}else if("旧版海尔".equals(name)){
			return HAIER;
		}else if("海尔".equals(name)){
			return HAIER2;
		}else if("奥克斯".equals(name)){
			return AUX;
		}else if("格力".equals(name)){
			return GREE;
		}else if("美菱".equals(name)){
			return MELING;
		}else if("TCL".equalsIgnoreCase(name)){
			return TCL;
		}else if("苏宁".equalsIgnoreCase(name)){
			return SUNING;
		}else if("国美".equalsIgnoreCase(name)){
			return GOME;
		}else if("京东".equalsIgnoreCase(name)){
			return JD;
		}

		return "";
	}
}
