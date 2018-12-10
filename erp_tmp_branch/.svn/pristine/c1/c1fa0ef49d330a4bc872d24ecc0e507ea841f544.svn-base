package com.jojowonet.modules.finance.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.InvoiceAddress;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2017/12/29.
 * 发票寄送地址Dao
 */
@Repository
public class InvoiceAddressDao extends BaseDao<InvoiceAddress> {
    public Record getInvoiceAddress(String siteId, String userId){
        String sql = "select a.* from crm_invoice_address as a where a.site_id=? and a.user_id=? and a.status='0' ";
        return Db.findFirst(sql,siteId,userId);
    }
}
