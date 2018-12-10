package com.jojowonet.modules.sys.util;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActiveRecordUtil {

    public static Record combineRecord(Record rd1, Record rd2, Map<String, String> excludeKeyMap){
        Record newRd = new Record();
        Map<String, Object> map = rd1.getColumns();
        for(Map.Entry<String, Object> ent : map.entrySet()){
            String colKey = ent.getKey();
            Object val = ent.getValue();
            if(excludeKeyMap.containsKey(colKey)){//在排除的键内，不需要叠加，保留原值即可
                newRd.set(colKey, val);
            }else{
                if(val == null){
                    newRd.set(colKey, rd2.get(colKey));
                }else{
                    Object newVal = val;
                    if(val instanceof Double){
                        Double d1 = rd1.get(colKey, 0d);
                        Double d2 = rd2.get(colKey, 0d);
                        newVal = d1 + d2;
                    }else if(val instanceof Long){
                        Long v1 = rd1.get(colKey, 0l);
                        Long v2 = rd2.get(colKey, 0l);
                        newVal = v1 + v2;
                    }else if(val instanceof Float){
                        Float v1 = rd1.get(colKey, 0f);
                        Float v2 = rd2.get(colKey, 0f);
                        newVal = v1 + v2;
                    }else if(val instanceof Integer){
                        Integer v1 = rd1.get(colKey, 0);
                        Integer v2 = rd2.get(colKey, 0);
                        newVal = v1 + v2;
                    }else if(val instanceof BigDecimal){
                        BigDecimal v1 = rd1.get(colKey, new BigDecimal(0));
                        BigDecimal v2 = rd2.get(colKey, new BigDecimal(0));
                        newVal = v1.add(v2);
                    }
                    newRd.set(colKey, newVal);
                }
            }
        }
        return newRd;
    }

    public static Record combineRecord(Record rd1, Record rd2){
        return combineRecord(rd1, rd2, new HashMap<String, String>());
    }

    public static List<Record> combineRecords(String key, List<Record> rds1, List<Record> rds2, Map<String, String> excludeKeyMap){
        List<Record> rds = Lists.newArrayList();
        for(Record nowRd : rds1){
            String mainId = nowRd.getStr(key);
            boolean used = false;
            for(int i = 0; i < rds2.size(); i++){
                Record hRd = rds2.get(i);
                String hManId = hRd.getStr(key);
                if(mainId.equals(hManId)){//是同一个的
                    Record newRd = ActiveRecordUtil.combineRecord(nowRd, hRd, excludeKeyMap);
                    rds.add(newRd);
                    rds2.remove(i);
                    used = true;
                    break;
                }
            }
            if(!used){
                rds.add(nowRd);
            }
        }
        if(rds2.size() > 0){//如果rds2中还有剩余的，那么直接全部放到rds中
            rds.addAll(rds2);
        }
        return rds;
    }

    public static List<Record> combineRecords(String key, List<Record> rds1, List<Record> rds2){
        return combineRecords(key, rds1, rds2, new HashMap<String, String>());
    }

}
