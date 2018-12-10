package com.jojowonet.modules.sys.util;

import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jojowonet.modules.fmss.utils.HttpUtils;
import com.jojowonet.modules.order.utils.Result;
import org.apache.commons.lang.StringUtils;

import java.net.URLEncoder;
import java.util.Map;


public class SfSmsUtils {

	private static String accesskey = "8wdC8pHbVlwphSii";// accesskey

	private static String secret = "dfHHfCV1QwyTK6KP5WP3pFntNJjPAke3";// secret

	//群发短信前缀
	private static String sendMsgPrefix = "http://api.1cloudsp.com/api/v2/send";
	//单发短信前缀
	private static String singleSendMsgPrefix = "http://api.1cloudsp.com/api/v2/single_send";
	//添加签名前缀
	private static String signTemplatePrefix = "http://api.1cloudsp.com/open/api/";
	//修改模板前缀
	private static String modifyTemplatePrefix = "http://api.1cloudsp.com/open/api/modifyTemplate";

	/**
	 * 发送短信接口
	 * @param mobile
	 * @param content
	 * @param sign
	 * @return 成功返回记录id 失败则返回空
	 */
	public static String sendMsg(String mobile,String content,String sign) {
		// 追加发送时间，可为空，为空为及时发送
		String stime = "";
		try {
			String result = sendMsgPost(mobile, content, stime,
					null,sign);
			JsonObject obj = convertStringToJsonObject(result);
			if(obj != null && obj.has("code") && "0".equals(obj.get("code").getAsString())){
			}
			return obj.get("batchId").getAsString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 添加短信模板方法
	 * 
	 * @param content
	 *            短信模板内容
	 * @return {"ret":0,"msg":null,"data":{"signId":123}}
	 */
	public static Result addTemplet(String tempName, String content,String siteName) {
		String categoryId = "2";//通知、订单
		Result ret = new Result();
		try {
			String result = addTemplatePost(tempName, content,
					categoryId, siteName);
			/*JsonObject obj = convertStringToJsonObject(result);
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){
				JsonObject templateId = obj.get("data").getAsJsonObject();
				return templateId.get("templateId").toString();
			}*/

			JsonObject obj = SfSmsUtils.convertStringToJsonObject(result);
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){
				String tempId = obj.get("data").getAsJsonObject().get("templateId").getAsString();
				ret.setCode("0");
				ret.setData(tempId);
			}else{
				ret.setCode("203");
				ret.setMsg(obj.get("msg").getAsString());
			}
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 修改短信模板状态
	 *
	 * @param templetId
	 *            短信模板id
	 * @return
	 */
	public static Result modTemplet(String name, String content, String templetId,String siteName) {
		Result ret = new Result();
		try {
			String result = modTemplatePost(templetId, name, content,
					siteName);
			/*JsonObject obj = convertStringToJsonObject(result);
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){
				return true;
			}*/
			JsonObject obj = SfSmsUtils.convertStringToJsonObject(result);
			if (obj != null && obj.has("ret") && !"0".equals(obj.get("ret").getAsString())) {
				ret.setCode("203");
				ret.setMsg(obj.get("msg").getAsString());
			}else{
				ret.setCode("0");
			}

			return ret;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 添加签名方法
	 *
	 * @param sign 格式：【+签名名称+】
	 * @return
	 */
	public static String addSign(String sign,String siteName){
		try {
			String result = addSignPost(sign, siteName);
			/*JsonObject obj = convertStringToJsonObject(result);
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){
				JsonObject templateId = obj.get("data").getAsJsonObject();
				return templateId.get("signId").toString();
			}*/
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 修改签名方法
	 * @param id 签名id
	 * @param sign 格式：【+签名名称+】
	 * @return
	 */
	public static String modifySign(String id ,String sign,String siteName){
		try {
			String result = modSignPost(id, sign, siteName);
			/*JsonObject obj = convertStringToJsonObject(result);
			if(obj != null && obj.has("ret") && "0".equals(obj.get("ret").getAsString())){
				return true;
			}*/
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 *
	 * @param mobileString
	 * @param contextString
	 * @param stime
	 * @param tid
	 * @param sign 格式：【+签名名称+】
	 * @return 只有返回是0表示提交成功
	 * @throws Exception
	 */
	public static String sendMsgPost(String mobileString, String contextString, String stime, String tid, String sign) throws Exception {

		/*NameValuePair[] data = {
				new NameValuePair("accesskey", accesskey),
				new NameValuePair("secret", secret),
				new NameValuePair("sign", sign),
				new NameValuePair("templateId", tid),
				new NameValuePair("mobile", mobileString),
				new NameValuePair("scheduleSendTime", stime),
				new NameValuePair("content", URLEncoder.encode(contextString, "utf-8"))
		};*/

		Map<String, String> data = Maps.newHashMap();
		data.put("accesskey", accesskey);
		data.put("secret", secret);
		data.put("sign", sign);
		data.put("templateId", tid);
		data.put("mobile", mobileString);
		data.put("scheduleSendTime", stime);
		data.put("content", URLEncoder.encode(contextString, "utf-8"));

		String prefix = sendMsgPrefix;
		return doPost(prefix,data);
	}

	/**
	 * 添加模板接口
	 * @param name 模板名称
	 * @param content  短信模板
	 * @param categoryId  1 验证码 2 通知||订单 3 营销
	 * @param description 简单描述使用场景 公司名称之类
	 * @return {"ret":0,"msg":null,"data":{"signId":123}}
	 * @throws Exception
	 */
	public static String addTemplatePost(String name, String content, String categoryId, String description) throws Exception {

		/*NameValuePair[] data = {
				new NameValuePair("accesskey", accesskey),
				new NameValuePair("secret", secret),
				new NameValuePair("templateName", name),
				new NameValuePair("categoryId", categoryId),
				new NameValuePair("description", description),
				new NameValuePair("template", content)
		};*/

		Map<String, String> data = Maps.newHashMap();
		data.put("accesskey", accesskey);
		data.put("secret", secret);
		data.put("templateName", name);
		data.put("categoryId", categoryId);
		data.put("description", description);
		data.put("template", content);

		String prefix = signTemplatePrefix + "addTemplate";
		return doPost(prefix,data);
	}

	/**
	 * 修改模板接口
	 * @param name 模板名称
	 * @param content  短信模板
	 * @param tempId  模板id
	 * @param description 简单描述使用场景 公司名称之类
	 * @return {"ret":0,"msg":null,"data":{"signId":123}}
	 * @throws Exception
	 */
	public static String modTemplatePost(String tempId, String name, String content, String description) throws Exception {

		//List<NameValuePair> data = Lists.newArrayList();

		/*NameValuePair[] data = {
				new BasicNameValuePair("accesskey", accesskey),
				new BasicNameValuePair("secret", secret),
				new BasicNameValuePair("templateName", name),
				new BasicNameValuePair("id", tempId),
				new BasicNameValuePair("description", description),
				new BasicNameValuePair("template", content)
		};*/

		Map<String, String> data = Maps.newHashMap();
		data.put("accesskey", accesskey);
		data.put("secret", secret);
		data.put("templateName", name);
		data.put("id", tempId);
		data.put("description", description);
		data.put("template", content);

		String prefix = signTemplatePrefix + "modifyTemplate";
		return doPost(prefix,data);
	}

	/**
	 * 添加签名接口
	 * @param sign 格式：【+签名名称+】
	 * @param description 简单描述使用场景 公司名称之类
	 * @return {"ret":0,"msg":null,"data":{"signId":123}}
	 * @throws Exception
	 */
	public static String addSignPost(String sign, String description) throws Exception {

		/*NameValuePair[] data = {
				new BasicNameValuePair("accesskey", accesskey),
				new BasicNameValuePair("secret", secret),
				new BasicNameValuePair("sign", sign),
				new BasicNameValuePair("description", description),
		};*/

		Map<String, String> data = Maps.newHashMap();
		data.put("accesskey", accesskey);
		data.put("secret", secret);
		data.put("sign", sign);
		data.put("description", description);

		String prefix = signTemplatePrefix + "addSign";
		return doPost(prefix,data);
	}

	/**
	 * 修改签名接口
	 * @param id 签名id
	 * @param sign 格式：【+签名名称+】
	 * @param description 简单描述使用场景 公司名称之类
	 * @return {"ret":0,"msg":null,"data":{"signId":123}}
	 * @throws Exception
	 */
	public static String modSignPost(String id, String sign, String description) throws Exception {

		/*NameValuePair[] data = {
				new BasicNameValuePair("accesskey", accesskey),
				new BasicNameValuePair("secret", secret),
				new BasicNameValuePair("id", id),
				new BasicNameValuePair("sign", sign),
				new BasicNameValuePair("description", description),
		};*/

		Map<String, String> data = Maps.newHashMap();
		data.put("accesskey", accesskey);
		data.put("secret", secret);
		data.put("id", id);
		data.put("sign", sign);
		data.put("description", description);

		String prefix = signTemplatePrefix + "modifySign";
		return doPost(prefix,data);
	}

	public static String doPost(String prefix, Map<String, String> data) throws Exception {

		return HttpUtils.doPost(prefix, data, "UTF-8");

		/*HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod(prefix);
		postMethod.getParams().setContentCharset("UTF-8");
		postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());
		postMethod.setRequestBody(data);

		try {
			postMethod.setRequestHeader("Connection", "close");
			int statusCode = httpClient.executeMethod(postMethod);
			System.out.println("statusCode: " + statusCode + ", body: "
					+ postMethod.getResponseBodyAsString());
			if(statusCode != 200){
				return "";
			}
			return postMethod.getResponseBodyAsString();
		}catch (Exception e){
			e.printStackTrace();
		}
		return "";*/
	}

	/**
	 * 将字符串转换成JsonObject对象
	 * 
	 * @param result
	 * @return
	 */
	public static JsonObject convertStringToJsonObject(String result) {
		Gson gson = new Gson();
		JsonObject obj = gson.fromJson(result,JsonObject.class);
		return obj;
	}

	public static boolean sendCode(String code, String mobile) {
		// 内容字符串
		StringBuffer contextString = new StringBuffer("您的验证码是:"+code
				+"，在5分钟内有效。如非本人操作请忽略本短信。");
		// 追加发送时间，可为空，为空为及时发送
		try {
			String result = sendMsg(mobile, contextString.toString(), "思方科技");
			String[] spr = (result == null)? null : result.split(",");
			System.out.println(result);
			if (StringUtils.isNotBlank(result)) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void main(String[] args) throws Exception {
		// System.out.println(sendCode("7965", "13955174824"));
		//String content = "您的验证码是:5748，在5分钟内有效。如非本人操作请忽略本短信。";
		String content = "尊敬的李志勇先生您好，您的预约时间已改至11月19日上午10:30即下周一 也可以来电659842317改约，具体上门时间会与您联系。【安徽思方网络科技】";
		String tcontent = "@您好，您的预约时间已改至@，具体上门时间会与您联系。";
		String tcontent2 = "@您好。";
//		System.out.println(sendCode("7395","13955174824"));
		//System.out.println(sendMsg("18256953495,17744445555", tcontent,"【安徽思方网络科技】"));
//		System.out.println(addTemplet("测试模板", tcontent,"思方科技"));
		System.out.println(modTemplet("测试模板", tcontent,"28349","思方科技"));
//		System.out.println(addSign("【冬青家电】", "思方科技"));
//		System.out.println(modifySign("13806","【思方小虾】", "思方科技"));
//		System.out.println(modifySign("14204","【思方小虾】", "思方科技"));

	}
}
