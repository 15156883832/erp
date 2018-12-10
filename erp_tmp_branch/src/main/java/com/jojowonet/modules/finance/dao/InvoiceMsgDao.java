package com.jojowonet.modules.finance.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.InvoiceMsg;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2017/12/29.
 * 发票信息维护dao
 */
@Repository
public class InvoiceMsgDao extends BaseDao<InvoiceMsg> {
    public Record getInvoicemsg(String siteId,String userId){
        String sql = "select a.* from crm_invoice_msg as a where a.site_id=? and a.user_id=? and a.status='0' ";
        return Db.findFirst(sql,siteId,userId);
    }
}
