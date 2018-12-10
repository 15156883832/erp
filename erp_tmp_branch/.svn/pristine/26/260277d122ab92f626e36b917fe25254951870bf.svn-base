package com.jojowonet.modules.order.utils;

import java.net.URL;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class GetLocation {  
    public static void main(String[] args) {  
        // lat 39.97646       
        //log 116.3039   
        String add = getAdd("117.834359", "30.813789");  
      /*  JSONObject jsonObject = JSONObject.fromObject(add);  
        JSONArray jsonArray = JSONArray.fromObject(jsonObject.getString("addrList"));  
        JSONObject j_2 = JSONObject.fromObject(jsonArray.get(0));  
        String allAdd = j_2.getString("admName");  
        String arr[] = allAdd.split(",");  */
    }
      
    public static String getAdd(String log, String lat ){  
        //lat 小  log  大  
        //参数解释: 纬度,经度 type 001 (100代表道路，010代表POI，001代表门址，111可以同时显示前三项)  
        String urlString = "http://gc.ditu.aliyun.com/regeocoding?l="+lat+","+log+"&type=010";  
        String res = "";     
        String address ="";
        try {     
            URL url = new URL(urlString);    
            java.net.HttpURLConnection conn = (java.net.HttpURLConnection)url.openConnection();    
            conn.setDoOutput(true);    
            conn.setRequestMethod("POST");    
            java.io.BufferedReader in = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream(),"UTF-8"));    
            String line;    
           while ((line = in.readLine()) != null) {    
               res += line+"\n";  
            JSONObject jsonObject = JSONObject.fromObject(res);  
               JSONArray jsonArray = JSONArray.fromObject(jsonObject.getString("addrList"));  
               JSONObject j_2 = JSONObject.fromObject(jsonArray.get(0));  
               String allAdd = j_2.getString("admName");  
               String arr[] = allAdd.split(",");   
               address = arr[0]+arr[1]+arr[2]+j_2.getString("name");
         }    
            in.close();    
        } catch (Exception e) {    
        }
        return address;
    }  
      
}