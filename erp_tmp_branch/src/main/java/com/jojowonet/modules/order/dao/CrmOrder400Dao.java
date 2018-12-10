package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.sys.db.DbKey;
import org.springframework.stereotype.Repository;

import com.jojowonet.modules.order.entity.CrmOrder400;

import ivan.common.persistence.BaseDao;


@Repository(value = "CrmOrder400Dao")
public class CrmOrder400Dao extends BaseDao<CrmOrder400> {

    public Record findOrder400ById(String id, String siteId) {
        Record rd = Db.use(DbKey.DB_ORDER_400).findFirst("select a.* from crm_order_400 a where a.id=? ", id);
        if (rd != null) {
            return rd;
        }
        return Db.use(DbKey.DB_ORDER_400).findFirst("select a.* from crm_order_400_2017 a where a.id=? ", id);
    }

    public Record findOrder400ByNumber(String number, String siteId) {
        Record rd = Db.use(DbKey.DB_ORDER_400).findFirst("select a.* from crm_order_400 a where a.number=? and a.site_id=?", number, siteId);
        if (rd != null) {
            return rd;
        }
        return Db.use(DbKey.DB_ORDER_400).findFirst("select a.* from crm_order_400_2017 a where a.number=? and site_id=?", number, siteId);
    }

}
