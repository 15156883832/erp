package com.jojowonet.modules.order.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2017/12/15.
 */
public class Test {
    public static void main(String args[]){
        List<String> list1 = new ArrayList <>();
        List<String> list2 =  null;
        List<String> list3 = new ArrayList <>();
//        for (int i=0;i<list3.size();i++) {
//        }
        list1.add("1");
        list1.add("2");
        list3.addAll(list1);
        list3.addAll(list2);
        for (int i=0;i<list3.size();i++) {
        }
    }
}
