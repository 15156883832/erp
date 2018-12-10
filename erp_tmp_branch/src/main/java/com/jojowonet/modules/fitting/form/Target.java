package com.jojowonet.modules.fitting.form;

/**
 * 消息的具体类，比如工单的过程消息和备件端反馈消息等用来解析json字符串存储的
 * 
 * @author ivan
 *
 */
public class Target {
	/*
	 * 1、新建工单：信息员接入/自动同步：系统自动同步 2、派工：信息员派工至服务工程师 3、转派：信息员转派至服务工程师
	 * 4、暂不派工：信息员暂不派工，暂不派工原因 5、取消暂不派工：信息员取消暂不派工 6、无效工单：信息员确认无效工单，无效原因 7、接单：服务工程师已接单
	 * 8、拒单：服务工程师拒单，拒单原因 9、修改预约时间：信息员修改预约时间为日期 时间要求 10、修改用户信息：服务工程师/信息员 修改信息
	 * 为信息内容，原信息 为信息内容； 11、上门：服务工程师已上门 12、完成：服务工程师确认维修完成 13、回访：信息员已回访，回访结果
	 * 14、再次回访：信息员再次回访，回访结果 15、结算：信息员已结算 16、直接封单：信息员直接封单 17、反馈封单：信息员反馈封单
	 * 18、工单完成：工单已完成(只要工单状态变成已完成)
	 */
	public static final int ORDER_ZZJ = 0;// 同步过程信息
	public static final int NEW_ORDER = 1;// 新建工单
	public static final int DISPATCH_ORDER = 2;// 派工
	public static final int REDIRECT_DISPATCH_ORDER = 3;// 转派
	public static final int WAIT_NOT_DISPATCH = 4;// 暂不派工
	public static final int CANCEL_WAIT_NOT_DISPATCH = 5;// 取消暂不派工
	public static final int INVALID_ORDER = 6;// 无效工单
	public static final int ACCEPT_ORDER = 7;// 接单
	public static final int REJECT_ORDER = 8;// 拒单
	public static final int MODIFY_YY_TIME = 9;// 信息员修改预约时间为日期 时间要求
	public static final int MODIFY_YHMSG = 10;// 信息员修改用户信息
	public static final int MESS_CALLBACK = 13;// 回访：信息员已回访，回访结果
	public static final int MESS_CALLBACK_TWICE = 14;// 再次回访：信息员再次回访，回访结果
	public static final int MESS_SETTLEMENT = 15;// 再次回访：信息员再次回访，回访结果
	public static final int DIRECTLY_CLOSE = 16;// 直接封单：信息员直接封单
	public static final int FEEDBACK_CLOSE = 17;// 反馈封单：信息员反馈封单
	public static final int COMPLETE_ORDER = 18;// 工单完成：工单已完成
	public static final int MARK_ORDER = 19;// 工单完成：工单已完成
	public static final int NEW_SECOND_ORDER = 20;// 一级网点
	public static final int DISPATCH_SECOND_ORDER = 21;// 一级网点派工
	public static final int REDIRECT_DISPATCH_SECOND_ORDER = 22;// 一级网点转派
	public static final int DIRECTLY_CLOSE_SECOND_ORDER = 23;// 一级网点直接封单

	public static final int SITE_EDIT_WARRANTY_TYPE = 30;// 保修类型的修改
	public static final int SITE_EDIT_RECORD_ACCOUNT_TYPE = 31;// 修改录单编号
	public static final int SITE_EDIT_EDIT_MARK_TYPE = 32;// 备注信息修改
	public static final int SITE_EDIT_CONFIRM_RECORD_TYPE = 33;// 确认录单
	public static final int SITE_EDIT_CONFIRM_RETURN_CARD_TYPE = 34;// 确认交单
	public static final int SITE_EDIT_CONFIRM_PAY_MONEY_TYPE = 35;// 确认交单

	public static final int ONESITE_DISPATCH_SECONDSITE_EMPLOYES = 40;// 一级网点直接派工给二级网点的服务工程师
	public static final int ONESITE_DISPATCHCHANGE_SECONDSITE_EMPLOYES = 41;// 一级网点转派给二级网点的服务工程师

	public static final int SITE_ORDER_DELETE_PROCESS_IMG = 42;// 一级网点转派给二级网点的服务工程师

	private String name;
	private String content;
	private String time;

	private int type;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

}
