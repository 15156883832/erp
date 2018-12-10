package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.Order2017Dao;
import com.jojowonet.modules.order.utils.CrmUtils;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Component
@Transactional
public class Order2017Service extends BaseService {
    @Autowired
    private Order2017Dao order2017Dao;

    //全部工单信息
    public Page<Record> getOrderHis(Page<Record> page, String siteId, String status, Map<String,Object> map, List<String> cateList, List<String> brandList) {
        List<Record> list = order2017Dao.getOrderHis(page, siteId, status, map, cateList, brandList);
        long count = order2017Dao.getOrderHisCount(siteId, status, map, cateList, brandList);
        for (Record rd : list) {
            String customerMobiles = CrmUtils.cusMobiles(rd.getStr("customer_mobile"), rd.getStr("customer_telephone"), rd.getStr("customer_telephone2"));
            rd.set("customer_mobile", customerMobiles);
        }
        page.setList(list);
        page.setCount(count);
        return page;
    }

    public Record findOrderById(String orderId, String siteId) {
        return order2017Dao.findOrderById(orderId, siteId);
    }

    public Record findOrderByNumber(String number, String siteId) {
        return order2017Dao.findOrderByNumber(number, siteId);
    }
}
