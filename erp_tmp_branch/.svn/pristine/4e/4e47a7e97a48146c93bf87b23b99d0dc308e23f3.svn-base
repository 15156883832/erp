package com.jojowonet.modules.sys.util;

import org.apache.commons.lang3.StringUtils;

public class AppPushUtils {

	/**
	 * 
	 * @param regIds 极光推送的regIds
	 * @param title
	 * @param content
	 * @param sfPushIds 思方推送的regIds
	 * @param type 发送消息类型：1表示新工单提醒
	 * @param appType 发送终端手机类型：0.android手机  1.ios手机
	 * @return
	 */
	public static boolean sendMsg(String regIds, String title,String content, String sfPushIds,
			int type,int appType,String appName){
		//首先判断思方token是否有值
		if(StringUtils.isNotBlank(sfPushIds)){
			String sound = (type == 1 ? "order_tip" : null);
			return  SFPushUtil2.sendNoticeMsg(title, content, sfPushIds, appName, sound);
		}
//		else if(StringUtils.isNotBlank(regIds)){
//			return JGPushUtils.sendMsg(regIds, title, content, type, appType);
//		}
		return false;
	}
}
