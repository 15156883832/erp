package com.jojowonet.modules.finance.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.dao.InvoiceApplicationDao;
import com.jojowonet.modules.finance.entity.InvoiceApplication;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2018/1/3.
 */
@Component
@Transactional(readOnly = true)
public class InvoiceApplicationService extends BaseService {
    @Autowired
    private InvoiceApplicationDao invoiceApplicationDao;

    public Page <Record> getInvoiceapplilist(Page <Record> page, String siteId, Map <String, Object> map) {
        List <Record> list = invoiceApplicationDao.getInvoiceapplilist(page, siteId, map);
        for (Record rd : list) {
            if("1".equals(rd.getStr("kp_man"))){
                rd.set("kp_man", "深圳南岛");
            }else{
                rd.set("kp_man", "思方科技");
            }
            if ("0".equals(rd.getStr("make_ivtype"))) {
                rd.set("make_ivtype", "个人");
            } else {
                rd.set("make_ivtype", "企业");
            }
            if (rd.getDate("create_time") != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String createTime = sdf.format(rd.getDate("create_time"));
                rd.set("create_time", createTime);
            }
            if (rd.getDate("kaipiao_time") != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String kaipiaoTime = sdf.format(rd.getDate("kaipiao_time"));
                rd.set("kaipiao_time", kaipiaoTime);
            }
            if (StringUtil.isNotBlank(rd.getStr("review_man"))) {
                String reviewName = CrmUtils.getUserXM();
                rd.set("review_man", reviewName);
            }
            if (StringUtil.isNotBlank(rd.getStr("user_id"))) {
                String userName = CrmUtils.getUserSiteName(UserUtils.getUserById(rd.getStr("user_id")));
                rd.set("user_id", userName);
            }
        }
        long count = invoiceApplicationDao.getcount(siteId, map);
        page.setList(list);
        page.setCount(count);
        return page;
    }

    //申请发票时保存发票记录
    public String saveInvoiceAppli(String invoicemsgid, String invoiceaddressid, String invoicevalue,
           String[] orderids, String[] orderGoodsCate, String invoiceNature, String invoiceTitle,
           String invoiceType, String receiverName, String receiverMobile, String receiverAddress, String postcode, String siteId, String userId, String types,String kptype,String[] ordernumbers) {
        String result = "";
        InvoiceApplication ia = new InvoiceApplication();
        ia.setSiteId(siteId);
        ia.setUserId(userId);
        ia.setInvoicemsgId(invoicemsgid);
        ia.setInvoiceaddressId(invoiceaddressid);
        if (StringUtil.isNotBlank(invoicevalue)) {
            ia.setInvoiceValue(new BigDecimal(invoicevalue));
        }
        StringBuffer orderidsf = new StringBuffer();
        if (orderids != null && orderids.length > 0) {
            for (int i = 0; i < orderids.length; i++) {
                orderidsf.append(orderids[i] + ";");
            }
        }


        ia.setOrderIds(orderidsf.toString());

        StringBuffer ordernumbersf = new StringBuffer();
        if (ordernumbers != null && orderids.length > 0) {
            for (int i = 0; i < ordernumbers.length; i++) {
                ordernumbersf.append(ordernumbers[i] + ";");
            }
        }
        ia.setOrderNumbers(ordernumbersf.toString());
        StringBuffer ordercatesf = new StringBuffer();
        if (orderGoodsCate != null && orderGoodsCate.length > 0) {
            for (int i = 0; i < orderGoodsCate.length; i++) {
                ordercatesf.append(orderGoodsCate[i] + ";");
            }
        }
        ia.setOrderGoodsCate(ordercatesf.toString());
        ia.setInvoiceNature(invoiceNature);
        ia.setInvoiceTitle(invoiceTitle);
        ia.setInvoiceType(invoiceType);
        ia.setReceiverName(receiverName);
        ia.setReceiverMobile(receiverMobile);
        ia.setReceiverAddress(receiverAddress);
        ia.setPostcode(postcode);
        if("1".equals(kptype)){
            ia.setKpMan("1");
        }else{
            ia.setKpMan("0");
        }
        invoiceApplicationDao.save(ia);
        if (orderids != null && orderids.length > 0) {
            int j = 0;
            for (int i = 0; i < orderids.length; i++) {
                if ("1".equals(types)) {
                    j = j + invoiceApplicationDao.updateOrderByid(orderids[i], ia.getId());
                } else {
                    j = j + invoiceApplicationDao.updatenandaoOrderByid(orderids[i], ia.getId());
                }
            }
            if (j != orderids.length) {
                result = "false";
                return result;
            }
        }
        result = "ok";
        return result;
    }

    public Record getrecordByid(String getrecordById) {
        Record rd = invoiceApplicationDao.getrecordByid(getrecordById);
        if (rd != null) {
            if ("0".equals(rd.getStr("invoice_type"))) {
                rd.set("invoice_type", "增值税普通发票");
            } else {
                rd.set("invoice_type", "增值税专用发票");
            }
        }
        return rd;
    }
    //发票申请记录的开票操作
    public String kaipiao(String invoiceapplicationid, String kaipiaotime, String userId) {
        String result = "";
        int i = invoiceApplicationDao.kaipiao(invoiceapplicationid, kaipiaotime, userId);
        if (i == 1) {
            result = "ok";
        }
        return result;
    }
    //发票申请记录的审核操作
    public String review(String invoiceapplicationid, String flag, String reviewRemark, String userId) {
        String result = "";
        int i = invoiceApplicationDao.review(invoiceapplicationid, flag, reviewRemark, userId);
        if (i == 1) {
            result = "ok";
        }
        return result;
    }
    //发票申请记录的寄件操作
    public String jijian(String invoiceapplicationid, String logisticsNames, String logisticsNumber, String userId) {
        String result = "";
        int i = invoiceApplicationDao.jijian(invoiceapplicationid, logisticsNames, logisticsNumber, userId);
        if (i == 1) {
            result = "ok";
        }
        return result;
    }

    public Map <String, Object> getreviewmanlist() {
        List <String> idlist = invoiceApplicationDao.getreviewmanlist();
        Map <String, Object> namemap = new HashMap <>();
        for (String id : idlist) {
            String name = CrmUtils.getUserSiteName(UserUtils.getUserById(id));
            namemap.put(id, name);
        }
        return namemap;
    }


    /**
     * 根据订单编号查询订单详情
     */
    public List<Record> getOrdersDetail(String orderNumbers){
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        if(StringUtils.isBlank(orderNumbers)){
            throw new RuntimeException("orderNumbers is null");
        }else{
            String[] numbers=orderNumbers.split(";");
            StringBuffer sb=new StringBuffer();
            sb.append("SELECT * FROM crm_goods_platform_order a WHERE a.number IN ("+StringUtil.joinInSql(numbers)+") and a.site_id=? ");
            List<Record> reList=Db.find(sb.toString(),siteId);
            if(reList.size()>0){
                return reList;
            }else{
                sb.delete(0,sb.length());
                sb.append(" SELECT * FROM crm_goods_platform_transfer_order a WHERE a.number IN ("+StringUtil.joinInSql(numbers)+") and a.site_id=? ");
                reList=Db.find(sb.toString(),siteId);
            }
            return reList;
        }
    }

}
