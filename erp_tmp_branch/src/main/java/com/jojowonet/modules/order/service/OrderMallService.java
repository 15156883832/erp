package com.jojowonet.modules.order.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.OrderMallDao;
import com.jojowonet.modules.order.entity.OrderMall;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/1/25.
 * 购机商场service
 */
@Component
@Transactional(readOnly = true)
public class OrderMallService extends BaseService {
    @Autowired
    private OrderMallDao orderMallDao;
    @Autowired
    private SfCacheService sfCacheService;

    public OrderMall get(String id) {
        return orderMallDao.get(id);
    }

    public Page<Record> find(Page<Record> page, Map<String,Object> map, String siteId) {
        List<Record> malllist = orderMallDao.filterOrderMall(siteId,page);
        long count = orderMallDao.getcount(siteId);
        page.setCount(count);
        page.setList(malllist);
        return page;
    }

    public List<Record> getlist(String siteId){
        return orderMallDao.getlist(siteId);
    }

    public List<Record> getlistRecordWithNameOnly(String siteId) {
        List<String> list = getlistname(siteId);
        List<Record> ret = new ArrayList<>();
        for (String v : list) {
            Record r = new Record();
            r.set("mall_name", v);
            ret.add(r);
        }
        return ret;
    }

    public List<String> getlistNameFromCache(String siteId) {
        String json = sfCacheService.hget(SfCacheKey.siteMallMap, siteId);
        if (StringUtil.isBlank(json)) {
            return null;
        }

        return new Gson().fromJson(json, new TypeToken<List<String>>() {
        }.getType());
    }

    public List<String> getlistname(String siteId) {
        List<String> mallNameList = getlistNameFromCache(siteId);
        if (mallNameList != null) {
            return mallNameList;
        }

        List<String> ret = orderMallDao.getlistname(siteId);
        if (ret == null) {
            ret = new ArrayList<>();
        }
        sfCacheService.hset(SfCacheKey.siteMallMap, siteId, new Gson().toJson(ret));
        return ret;
    }
  //保存
    public void save(OrderMall orderMall) {
        orderMallDao.save(orderMall);
    }

   //删除
    public String deleteMall(String[] idArr) {
        String result ="";
        int i=0;
        for(int j=0;j<idArr.length;j++){
           i=i+orderMallDao.deleteMall(idArr[i]);
        }
        if(i==idArr.length){
            result="ok";
        }
        return result;
    }


    //根据id查询
    public Record getOrderMallById(String id, String siteId) {
        return orderMallDao.getOrderMallById(id, siteId);
    }

    //根据name查询
    public long querylongbyname(String name,String id){
        return orderMallDao.querylongbyname(name,id);
    }


    //更新
    public String updates(String name, Integer sort, String id) {
        String result="";
        long i = orderMallDao.querylongbyname(name,id);
        if(i>0){
            result="rename";
        }else{
            int j = orderMallDao.updatesMall(name, sort, id, new Date());
            if(j==1){
                result="ok";
            }
        }
        return result;
    }

}
