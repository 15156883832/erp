package com.jojowonet.modules.finance.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.InvoiceApplication;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/1/3.
 * 发票申请记录dao
 */
@Repository
public class InvoiceApplicationDao extends BaseDao<InvoiceApplication> {
    public List <Record> getInvoiceapplilist(Page <Record> page, String siteId, Map <String, Object> map) {
        StringBuffer sf = new StringBuffer();
        sf.append("select a.*,b.make_ivtype as make_ivtype,b.icon from crm_invoice_application as a left join crm_invoice_msg as b on a.invoicemsg_id=b.id where a.status='0' ");
        if (StringUtil.isNotBlank(siteId)) {
            sf.append(" and a.site_id='" + siteId + "' ");
        }
        sf.append(getCondition(map));
        sf.append(" order by a.create_time desc");
        if (page != null) {
            sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        }
        return Db.find(sf.toString());
    }

    public long getcount(String siteId, Map <String, Object> map) {
        StringBuffer sf = new StringBuffer();
        sf.append("select count(*) from crm_invoice_application as a left join crm_invoice_msg as b on a.invoicemsg_id=b.id where a.status='0' ");
        if (StringUtil.isNotBlank(siteId)) {
            sf.append(" and a.site_id='" + siteId + "' ");
        }
        sf.append(getCondition(map));
        return Db.queryLong(sf.toString());
    }

    public String getCondition(Map <String, Object> map) {
        StringBuffer sf = new StringBuffer();
        if (map != null) {
            if (StringUtil.checkParamsValid(map.get("userMan"))) {
                sf.append(" and a.user_id = '" + (map.get("userMan")) + "' ");
            }

            if (StringUtil.checkParamsValid(map.get("makeIvtype"))) {
                sf.append(" and b.make_ivtype='" + (map.get("makeIvtype")) + "' ");
            }
            if (StringUtil.checkParamsValid(map.get("invoiceType"))) {
                sf.append(" and a.invoice_type='" + (map.get("invoiceType")) + "' ");
            }
            if (StringUtil.checkParamsValid(map.get("reviewStatus"))) {
                sf.append(" and a.review_status='" + (map.get("reviewStatus")) + "' ");
            }

            if (StringUtil.checkParamsValid(map.get("createTimeMin"))) {
                sf.append(" and a.create_time >= '" + (map.get("createTimeMin")) + " 00:00:00'  ");
            }
            if (StringUtil.checkParamsValid(map.get("createTimeMax"))) {
                sf.append(" and a.create_time <= '" + (map.get("createTimeMax")) + " 23:59:59' ");
            }
            if (StringUtil.checkParamsValid(map.get("kaipiaoTimeMin"))) {
                sf.append(" and a.kaipiao_time >= '" + (map.get("kaipiaoTimeMin")) + " 00:00:00'  ");
            }
            if (StringUtil.checkParamsValid(map.get("kaipiaoTimeMax"))) {
                sf.append(" and a.kaipiao_time <= '" + (map.get("kaipiaoTimeMax")) + " 23:59:59' ");
            }
        }
        return sf.toString();
    }

  //跟新订单关联的发票记录id
    public int updateOrderByid(String orderId, String invoiceappliId) {
        String sql = "update crm_goods_platform_order set invoice_record_id=? where id=?";
        return Db.update(sql, invoiceappliId, orderId);
    }
    //跟新南岛订单关联的发票记录id
    public int updatenandaoOrderByid(String orderId, String invoiceappliId) {
        String sql = "update crm_goods_platform_transfer_order set invoice_record_id=? where id=?";
        return Db.update(sql, invoiceappliId, orderId);
    }

    //根据id查询发票记录
    public Record getrecordByid(String invoiceapplicationid) {
        StringBuffer sf = new StringBuffer();
        sf.append("select a.*,b.make_ivtype,b.tax_registration_number,b.address,b.mobile,b.bank_of_deposit,b.open_account");
        sf.append(" from crm_invoice_application as a left join crm_invoice_msg as b on a.invoicemsg_id=b.id and b.status='0' ");
        sf.append(" where a.status='0' and a.id=?");
        return Db.findFirst(sf.toString(), invoiceapplicationid);
    }

    //发票申请记录的开票操作
    public int kaipiao(String invoiceapplicationid, String kaipiaotime, String userId) {
        String sql = "update crm_invoice_application set review_status='1',kaipiao_time=?,review_man=? where id=?";
        return Db.update(sql, kaipiaotime, userId, invoiceapplicationid);
    }
    //发票申请记录的审核操作
    public int review(String invoiceapplicationid, String flag, String reviewRemark, String userId) {
        String sql = "";
        if ("ok".equals(flag)) {
            sql = "update crm_invoice_application set review_status='0',review_remark=?,review_man=? where id=?";
        } else if ("failed".equals(flag)) {
            sql = "update crm_invoice_application set review_status='2',review_remark=?,review_man=? where id=?";
        }
        return Db.update(sql, reviewRemark, userId, invoiceapplicationid);
    }
    //发票申请记录的寄件操作
    public int jijian(String invoiceapplicationid, String logisticsNames, String logisticsNumber, String userId) {
        String sql = "update crm_invoice_application set review_status='4',logistics_names=?,logistics_number=?,review_man=? where id=?";
        return Db.update(sql, logisticsNames, logisticsNumber, userId, invoiceapplicationid);
    }

    public List <String> getreviewmanlist() {
        String sql = "select distinct(a.user_id) from crm_invoice_application as a where status='0' ";
        return Db.query(sql);
    }
}
