package com.jojowonet.modules.fmss.web;

import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.util.http.EzTemplate;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.*;

@Controller
@RequestMapping(value="${adminPath}/testCon")
public class DemoEzTemplateController extends BaseController {

    @Autowired
    private EzTemplate ezTemplate;

    @ResponseBody
    @RequestMapping(value = "test")
    public Object testPostForm(HttpServletRequest request){
        Map<String, Object> params = new HashMap<>();
        params.put("a", "b");
        params.put("c", Arrays.asList(1, 2));
        Result<List<String>> listResult = ezTemplate.postForm("/test2", params, new ParameterizedTypeReference<Result<List<String>>>() {
        });
        return listResult;
    }

    @ResponseBody
    @RequestMapping(value = "test11")
    public Object testPostJson(HttpServletRequest request){
        Map<String, Object> data = new HashMap<>();
        data.put("hello", "hi2");
        Result<MyUser> ret = ezTemplate.postJson("/test3", data, new ParameterizedTypeReference<Result<MyUser>>() {
        });
        return ret;
    }

    public static class MyUser implements Serializable {
        private String name;
        private int age;
        private Date date;

        public void setName(String name) {
            this.name = name;
        }

        public void setAge(int age) {
            this.age = age;
        }

        public String getName() {
            return name;
        }

        public int getAge() {
            return age;
        }

        public Date getDate() {
            return date;
        }

        public void setDate(Date date) {
            this.date = date;
        }
    }

}
