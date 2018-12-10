package com.jojowonet.modules.sys.util;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jojowonet.modules.sys.service.CityService;
import net.sf.json.JSONObject;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

/**
 * Created by Administrator on 2017/10/24.
 */
@Component
public class CityUtil {
    public static void getCitytext() {
        Map<String,Object> map = (Map<String, Object>) CityService.getPCD();
        String s=JSON.toJSONString(map);
        try {
            String line = System.getProperty("line.separator");
            StringBuffer str = new StringBuffer();
            FileWriter fw = new FileWriter("F:\\city.min.js", true);
            str.append(s).append(line);
            fw.write(str.toString());
            fw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
