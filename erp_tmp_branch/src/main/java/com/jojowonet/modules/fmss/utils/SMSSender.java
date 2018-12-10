package com.jojowonet.modules.fmss.utils;

import java.net.URLEncoder;

public class SMSSender {

	public static String sendSMS(String msg, String mobile){
		String SIM_PASSWORD_MD5_16 = "012A124E5AD7E8BC";
		String SIM_LOGIN_NAME = "jojowo88";
		try {
			String content = URLEncoder.encode(msg, "gb2312");
			String url = "http://sdk.zyer.cn/SmsService/SmsService.asmx/SendEx?LoginName="+SIM_LOGIN_NAME
				+"&Password="+SIM_PASSWORD_MD5_16
				+"&SmsKind=803&SendSim="+mobile
				+"&ExpSmsId=&MsgContext="+content;
			String back = HttpUtils.doGet(url, null);
			return back;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "---send sms failed----";
	}
	
	public static void main(String[] args) {
		sendSMS("尊敬的用户 您好，欢迎使用智惠家，手机验证码为：13123。【智惠家科技】", "15856988250");
	}
}
