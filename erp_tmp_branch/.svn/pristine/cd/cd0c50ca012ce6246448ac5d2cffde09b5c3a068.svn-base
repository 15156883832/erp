package com.jojowonet.modules.order.utils;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jojowonet.modules.order.utils.StringUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Component
public class FactorySyncHelper {

    public static final String DEFAULT_FACTORY = "default";

    @Value("${sync.server.host.default}")
    private String defaultSyncUrl;

    @Autowired
    private RestTemplate restTemplate;

    private Map<String, Object> sync(String path, Map<String, Object> data, String factory, RequestMethod method){
        String host = getFactorySynHost(factory);
        Map<String, Object> ret = null;
        if(RequestMethod.POST == method){
            ret = restTemplate.postForEntity(host + path, data, HashMap.class).getBody();
        }
        return ret;
    }

    /**
     * 暂时都只发post请求
     * @param path
     * @param data
     * @return
     */
    public Map<String, Object> sync(String path, Map<String, Object> data){
        return sync(path, data, DEFAULT_FACTORY, RequestMethod.POST);
    }

    /**
     * 返回厂家同步服务器的地址前缀
     * @param facotry
     * @return
     */
    private String getFactorySynHost(String facotry){
        String host = "";
        if("default".equalsIgnoreCase(facotry)){
            return getRealHost(defaultSyncUrl);
        }
        return host;
    }

    private String getRealHost(String host){
        if(StringUtil.isBlank(host)){
            return "";
        }
        String[] hostArr = host.split(",");
        if(hostArr.length == 2 && StringUtil.isNotBlank(hostArr[1])){
            return hostArr[1];
        }
        return hostArr[0];
    }
}
