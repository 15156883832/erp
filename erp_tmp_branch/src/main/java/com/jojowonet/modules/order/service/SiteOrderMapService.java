package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import org.springframework.stereotype.Service;

@Service
public class SiteOrderMapService {

    public String getSiteOrderSuffix(String siteId) {
        Record first = Db.findFirst("select suffix from crm_site_order_map where site_id=?", siteId);
        if (first != null) {
            return first.getStr("suffix");
        }
        return "";
    }

}
