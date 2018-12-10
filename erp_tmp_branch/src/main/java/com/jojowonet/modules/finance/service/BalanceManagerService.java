package com.jojowonet.modules.finance.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.dao.BalanceManagerDao;
import com.jojowonet.modules.finance.entity.BalanceManager;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by yc on 2017/12/25.
 */
@Component
@Transactional(readOnly = true)
public class BalanceManagerService extends BaseService {
    @Autowired
    private BalanceManagerDao balanceManagerDao;

    public Page <Record> getBalanceManagerList(Page <Record> page, String siteId, Map <String, Object> map) {
        List <Record> balancelist = balanceManagerDao.getbalancemanagerlist(page, siteId, map);
        for (Record rd : balancelist) {
            if (StringUtil.isNotBlank(rd.getStr("bill_type"))) {
                if ("0".equals(rd.getStr("bill_type"))) {
                    rd.set("bill_type", "收据");
                } else {
                    rd.set("bill_type", "发票");
                }
            }
            if (StringUtils.isNotBlank(rd.getStr("imgs"))) {
                String str=rd.getStr("imgs").replace("\\","/").substring(0,rd.getStr("imgs").lastIndexOf(","));
                rd.set("imgs", str);
            }else{
                rd.set("imgs", null);
            }
        }
        long count = balanceManagerDao.getcount(siteId, map);
        page.setList(balancelist);
        page.setCount(count);
        return page;
    }

   //获取该网点所有员工姓名
    public List <Record> getAllsiteInfo(String siteId) {
        List <Record> nonServicemanlist = balanceManagerDao.getAllServicemanlist(siteId);
        List <Record> employelist = balanceManagerDao.getAllEmployeInfo(siteId);
        List <Record> site = balanceManagerDao.getSiteBysiteid(siteId);
        if (site != null) {
            if (nonServicemanlist != null && nonServicemanlist.size() > 0) {
                site.addAll(nonServicemanlist);
            }
            if (employelist != null && employelist.size() > 0) {
                site.addAll(employelist);
            }
        }
        return site;
    }

    //保存
    public String save(String siteId, String exacctId, String costType, String costTotal, String billType, String billAmount, String detailContent,
                       String costProducer, String costProducerName, String occurTime, String createBy, String createByName,String collectionId,String createType, String remarks, String exacctBrand,String imgs) {
        String result = "ok";
        if (StringUtil.isEmpty(exacctId)) {
            result = "请选择费用科目";
        } else if (StringUtil.isEmpty(costType)) {
            result = "请选择费用类型";
        } else if (StringUtil.isEmpty(costTotal)) {
            result = "请填写费用总额";
        } else if (StringUtil.isEmpty(costProducer) || StringUtil.isEmpty(costProducerName)) {
            result = "请选择费用发生人";
        } else {
            BalanceManager ba = new BalanceManager();
            ba.setCreateTime(new Date());
            ba.setSiteId(siteId);
            ba.setExacctId(exacctId);
            ba.setCostType(costType);
            ba.setCostTotal(new BigDecimal(costTotal));
            ba.setExacctBrand(exacctBrand);
            if (StringUtil.isNotBlank(billType)) {
                ba.setBillType(billType);
            }
            if (StringUtil.isNotBlank(billAmount)) {
                ba.setBillAmount(Integer.valueOf(billAmount));
            }
            if (StringUtil.isNotBlank(detailContent)) {
                ba.setDetailContent(detailContent);
            }
            ba.setCostProducer(costProducer);
            ba.setCostProducerName(costProducerName);
            if (StringUtil.isNotBlank(occurTime)) {
                java.text.SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    ba.setOccurTime(sdf.parse(occurTime));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            ba.setCreateBy(createBy);
            ba.setCreateByName(createByName);
            ba.setCollectionId(collectionId);
            ba.setCreateType(createType);
            String thisid = balanceManagerDao.getBalanceIdBycollectionId(collectionId,siteId);
            if(StringUtils.isNotBlank(thisid)){
                ba.setId(thisid);
            }
            ba.setStatus("0");
            ba.setImgs(imgs);
            balanceManagerDao.save(ba);
        }
        return result;
    }
    //查询
    public Record getBalanceById(String id){
        Record rd = balanceManagerDao.getBalanceById(id);
        return rd;
    }

    //修改
    public String edite(String id,String siteId, String exacctId, String costType, String costTotal, String billType, String billAmount, String detailContent,
                       String costProducer, String costProducerName, String occurTime, String createBy, String createByName,String collectionId,String createType, String remarks, String exacctBrand,String imgs) {
        String result = "ok";
        if (StringUtil.isEmpty(exacctId)) {
            result = "请选择费用科目";
        } else if (StringUtil.isEmpty(costType)) {
            result = "请选择费用类型";
        } else if (StringUtil.isEmpty(costTotal)) {
            result = "请填写费用总额";
        } else if (StringUtil.isEmpty(costProducer) || StringUtil.isEmpty(costProducerName)) {
            result = "请选择费用发生人";
        } else {
            BalanceManager ba = new BalanceManager();
            ba.setId(id);
            ba.setCreateTime(new Date());
            ba.setSiteId(siteId);
            ba.setExacctId(exacctId);
            ba.setCostType(costType);
            ba.setCostTotal(new BigDecimal(costTotal));
            ba.setExacctBrand(exacctBrand);
            if (StringUtil.isNotBlank(billType)) {
                ba.setBillType(billType);
            }
            if (StringUtil.isNotBlank(billAmount)) {
                ba.setBillAmount(Integer.valueOf(billAmount));
            }
            if (StringUtil.isNotBlank(detailContent)) {
                ba.setDetailContent(detailContent);
            }
            ba.setCostProducer(costProducer);
            ba.setCostProducerName(costProducerName);
            if (StringUtil.isNotBlank(occurTime)) {
                java.text.SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    ba.setOccurTime(sdf.parse(occurTime));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            ba.setCreateBy(createBy);
            ba.setCreateByName(createByName);
            ba.setCollectionId(collectionId);
            ba.setCreateType(createType);
        /*    String thisid = balanceManagerDao.getBalanceIdBycollectionId(collectionId,siteId);
            if(StringUtils.isNotBlank(thisid)){
                ba.setId(thisid);
            }*/
            ba.setStatus("0");
            ba.setImgs(imgs);
            balanceManagerDao.save(ba);
        }
        return result;
    }

    public String doShanchu(String id){
        String result ="";
        if(StringUtil.isNotBlank(id)){
           int i =  balanceManagerDao.deleteByid(id);
           if(i>0){
               result="ok";
           }else{
               result="false";
           }
        }else{
            result="false";
        }
        return result;
    }

    //获取收入金额
    public BigDecimal getIncome(String siteId, Map <String, Object> map) {
        return balanceManagerDao.getIncome(siteId, map);
    }
    //获取支出金额
    public BigDecimal getOutcome(String siteId, Map <String, Object> map) {
        return balanceManagerDao.getOutcome(siteId, map);
    }
}
