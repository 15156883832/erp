package com.jojowonet.modules.fmss.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class HttpUtils {

	private static final CloseableHttpClient httpClient;
	public static final String CHARSET = "UTF-8";
	static{
		RequestConfig config = RequestConfig.custom().setConnectTimeout(60000).setSocketTimeout(15000).build();
		httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
	}
	
	public static String doGet(String url, Map<String, String> params)
	{
		return doGet(url, params, CHARSET);
	}
	
	public static String doPost(String url, Map<String, String> params)
	{
		return doPost(url, params, CHARSET);
	}
	
	public static String doKDGet(String url, Map<String, String> params){
		String charset = CHARSET;
		if(StringUtils.isBlank(url))
			return null;
		try
		{
			if(params != null && !params.isEmpty())
			{
				List<NameValuePair> pairs = convertMap2List(params);
				url += "?" + EntityUtils.toString(new UrlEncodedFormEntity(pairs, charset));
			}
			
			HttpGet httpGet = new HttpGet(url);
			httpGet.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0");
			httpGet.setHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
			httpGet.setHeader("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
			httpGet.setHeader("Accept-Encoding", "gzip, deflate, br");
			httpGet.setHeader("Cookie", "BAIDUID=130889C085F0EC781B99AED2FE5BD7747:FG=1; BIDUPSID=130889C085F0EC781B99AED2FE5BD7747;");
			httpGet.setHeader("Connection", "keep-alive");
			httpGet.setHeader("Cache-Control", "max-age=0");
			
			CloseableHttpResponse response = httpClient.execute(httpGet);
			int statusCode = response.getStatusLine().getStatusCode();
			if(statusCode != 200)
			{
				httpGet.abort();
				return null;
			}
			HttpEntity entity = response.getEntity();
			String result  = null;
			if(entity != null)
				result = EntityUtils.toString(entity, "utf-8");
			
			EntityUtils.consume(entity);
			response.close();
			return result;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	
	}
	
	public static String doGet(String url, Map<String, String> params, String charset)
	{
		if(StringUtils.isBlank(url))
			return null;
		try
		{
			if(params != null && !params.isEmpty())
			{
				List<NameValuePair> pairs = convertMap2List(params);
				url += "?" + EntityUtils.toString(new UrlEncodedFormEntity(pairs, charset));
			}
			
			HttpGet httpGet = new HttpGet(url);
			
			CloseableHttpResponse response = httpClient.execute(httpGet);
			int statusCode = response.getStatusLine().getStatusCode();
			if(statusCode != 200)
			{
				httpGet.abort();
				return null;
			}
			HttpEntity entity = response.getEntity();
			String result  = null;
			if(entity != null)
				result = EntityUtils.toString(entity, "utf-8");
			
			EntityUtils.consume(entity);
			response.close();
			return result;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	public static String doPost(String url, Map<String, String> params, String charset)
	{
		if (StringUtils.isBlank(url))
			return null;
		try {
			HttpPost httpPost = new HttpPost(url);
			List<NameValuePair> pairs = convertMap2List(params);
			if(pairs != null && !pairs.isEmpty())
			httpPost.setEntity(new UrlEncodedFormEntity(pairs, CHARSET));
			//
			/*if (params != null) {
				JSONObject object = JSONObject.fromObject(params);
				StringEntity se = new StringEntity(object.toString(), charset);
				se.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE,
						"application/json"));
				se.setContentType(new BasicHeader(HTTP.CONTENT_TYPE, "application/json; charset=UTF-8"));
				httpPost.setEntity(se);
				//httpPost.setHeader("Content-Type", "application/json; charset=UTF-8");
			}*/
			CloseableHttpResponse response = httpClient.execute(httpPost);
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != 200)// 失败
			{
				httpPost.abort();
			} else// 成功
			{
				HttpEntity entity = response.getEntity();
				String result = null;
				if (entity != null)
					result = EntityUtils.toString(entity, CHARSET);
				EntityUtils.consume(entity);
				response.close();
				return result;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static List<NameValuePair> convertMap2List(Map<String, String> params)
	{
		List<NameValuePair> pairs = null;
		if(params != null && !params.isEmpty())
		{
			pairs = Lists.newArrayListWithCapacity(params.size());
			for(Map.Entry<String, String> entry : params.entrySet())
			{
				String value = entry.getValue();
				if(value != null)
					pairs.add(new BasicNameValuePair(entry.getKey(), value));
			}
		}
		return pairs;
	}
	
	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl 请求地址
	 * @param requestMethod 请求方式（GET、POST）
	 * @param outputStr 提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static String httpRequest(String requestUrl, String requestMethod, String outputStr) {
		String result = null;
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
//			jsonObject = new JSONObject(buffer.toString());
			result = buffer.toString();
		} catch (ConnectException ce) {
			ce.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
