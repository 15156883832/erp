package com.jojowonet.modules.goods.utils;

import ivan.common.utils.DateUtils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;


public class HttpUtils {

	private static final String url = "https://sp0.baidu.com/9_Q4sjW91Qh3otqbppnN2DJv/pae/channel/data/asyncqury";
	public static final String CHARSET = "UTF-8";
        /**
         * 向指定URL发送GET方法的请求
         *
         * @param url
         *            发送请求的URL
         * @param params
         *            请求参数，请求参数应该是name1=value1&name2=value2的形式。
         * @return URL所代表远程资源的响应
         */
        public static String sendGet(String url, Map<String,String> params) {
            String result = "";
            String charset = CHARSET;
            BufferedReader in = null;
            try {
            	if(params != null && !params.isEmpty())
    			{
    				List<NameValuePair> pairs = convertMap2List(params);
    				url += "?" + EntityUtils.toString(new UrlEncodedFormEntity(pairs, charset));
    			}
             //   String urlName = url + "?" + params;
                URL realUrl = new URL(url);
                // 打开和URL之间的连接
                URLConnection conn = realUrl.openConnection();
                // 设置通用的请求属性
                conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0");
                conn.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
                conn.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
                conn.setRequestProperty("Accept-Encoding", "gzip, deflate, br");
                conn.setRequestProperty("Cookie", "BAIDUID=130889C085F0EC781B99AED2FE5BD7747:FG=1; BIDUPSID=130889C085F0EC781B99AED2FE5BD7747;");
                conn.setRequestProperty("Connection", "keep-alive");
                conn.setRequestProperty("Cache-Control", "max-age=0");
                
                // 建立实际的连接
                conn.connect();
                // 获取所有响应头字段

             //   Map<String, List<String>> map = conn.getHeaderFields();
                // 遍历所有的响应头字段
                /*for (String key : map.keySet()) {
                }*/
                // 定义BufferedReader输入流来读取URL的响应
                in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
                String originalData = in.readLine();
                String returnData = decodeUnicode(originalData);
                if(returnData != null){
                	return returnData;
                }
                String line;
                while ((line = in.readLine()) != null) {
                    result += "\n" + line;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            // 使用finally块来关闭输入流
            finally {
                try {
                    if (in != null) {
                        in.close();
                    }
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
            return result;
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
         * 解码 Unicode \\uXXXX
         * @param str
         * @return
         */
        public static String decodeUnicode(String str) {
            Charset set = Charset.forName("UTF-16");
            Pattern p = Pattern.compile("\\\\u([0-9a-fA-F]{4})");
            Matcher m = p.matcher( str );
            int start = 0 ;
            int start2 = 0 ;
            StringBuffer sb = new StringBuffer();
            while( m.find( start ) ) {
                start2 = m.start() ;
                if( start2 > start ){
                    String seg = str.substring(start, start2) ;
                    sb.append( seg );
                }
                String code = m.group( 1 );
                int i = Integer.valueOf( code , 16 );
                byte[] bb = new byte[ 4 ] ;
                bb[ 0 ] = (byte) ((i >> 8) & 0xFF );
                bb[ 1 ] = (byte) ( i & 0xFF ) ;
                ByteBuffer b = ByteBuffer.wrap(bb);
                sb.append( String.valueOf( set.decode(b) ).trim() );
                start = m.end() ;
            }
            start2 = str.length() ;
            if( start2 > start ){
                String seg = str.substring(start, start2) ;
                sb.append( seg );
            }
            return sb.toString() ;
        }
    	
public static void main(String[] args) {
	String comp = "yuantong";//快递公司代码
	String orderNo = "886645923564089934";//快递单号
	getLogistics(orderNo,comp);
}

public static List<Map.Entry<String,String>> sort(Map<String,String> map ){
	 List<Map.Entry<String,String>> list = new ArrayList<Map.Entry<String,String>>(map.entrySet());
     //然后通过比较器来实现排序
     Collections.sort(list,new Comparator<Map.Entry<String,String>>() {
         //降序排序
         @Override
         public int compare(Entry<String, String> o1,
                 Entry<String, String> o2) {
             return o2.getKey().compareTo(o1.getKey());
         }
     });
   /*  for (Map.Entry<String, String> mapping : list) {  
    	}*/
     return list;
    
}


/*
 * orderNo : 快递单号
 * name : 快递公司名称
*/
public static Map<String,String> getLogistics(String orderNo,String name){
	Map<String,String> maps = LogisticsUtils.getlogistics();
	String comp = maps.get(name);
	 Map<String ,String> map = Maps.newHashMap();
		String timePrefix = String.valueOf(new Date().getTime());
		Map<String, String> params = Maps.newHashMap();
		params.put("cb", "jQuery11020516348667348736_"+timePrefix);
		params.put("appid", "4001");
		params.put("com", comp);
		params.put("nu", orderNo);
		params.put("vcode", "");
		params.put("token", "");
		params.put("_", timePrefix);
		try {

			String str = HttpUtils.sendGet(url, params);
			String str1 = str.replace("/**/jQuery11020516348667348736_"+timePrefix+"(", "");
			String str2 = str1.replace("}}})", "}}}").replaceAll(" +","");
			JSONObject jo = new JSONObject(str2);
			Object msg = jo.get("msg");
			Object status = jo.get("status");
			if("-3".equals(status)){
				map.put(DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"), msg.toString());
			}else if("-2".equals(status) || "-5".equals(status)){
				map.put(DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"), "暂无快递信息！");
			}else{
				JSONObject jsc = jo.getJSONObject("data").getJSONObject("info");
				JSONArray context = jsc.getJSONArray("context");
				String state = jsc.get("state").toString();
				String sta = "";
				if("0".equals(state)){
					sta = "运输中";
				}else if("1".equals(state)){
					sta= "已发货";
				}else if("2".equals(state)){
					sta = "疑难件";
				}else if("3".equals(state)){
					sta = "已签收 ";
				}else if("4".equals(state)){
					sta = "已退货";
				}else if("5".equals(state)){
					sta = "派件中";
				}
				JSONArray js = new JSONArray(context.toString());
				for(int i=0;i<js.length();i++){
					JSONObject ja = js.getJSONObject(i);
					String time = ja.get("time").toString();
					String date = timeStamp2Date(time, "yyyy-MM-dd HH:mm:ss");  
					String desc = String.valueOf(ja.get("desc"));
					map.put(date, desc);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	 return map;
}

/** 
 * 时间戳转换成日期格式字符串 
 * @param seconds 精确到秒的字符串 
 * @param formatStr 
 * @return 
 */  
public static String timeStamp2Date(String seconds,String format) {  
    if(seconds == null || seconds.isEmpty() || seconds.equals("null")){  
        return "";  
    }  
    if(format == null || format.isEmpty()) format = "yyyy-MM-dd HH:mm:ss";  
    SimpleDateFormat sdf = new SimpleDateFormat(format);  
    return sdf.format(new Date(Long.valueOf(seconds+"000")));  
}   

 
}
