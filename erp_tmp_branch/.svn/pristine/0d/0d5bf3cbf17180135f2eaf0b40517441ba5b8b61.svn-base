package com.jojowonet.modules.operate.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.entity.Code;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by cdq on 2017/10/21
 */
@Repository
public class QRCodeDao extends BaseDao<Code> {

    /**
     * 运营管理下二维码管理
     * */
    public List<Record> getQRcodeList(Page<Record> page, Map<String, Object> map) {
        StringBuffer sf = new StringBuffer();
        sf.append(" select a.sequence,a.id,a.code,a.site_id,a.status,a.create_time,a.use_time,a.is_print,b.name as siteName from crm_code a ");
        sf.append(" left join crm_site b on a.site_id=b.id ");
        sf.append(" where a.status in('0','1') ");
        sf.append(queryByAnothers(map));
        sf.append(" order by a.create_time desc,a.sequence desc ");
        sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        return Db.find(sf.toString());
    }

    public long getQRCodeCount(Map<String,Object> map){
        StringBuffer sf = new StringBuffer();
        sf.append(" select count(*) from crm_code a ");
        sf.append(" left join crm_site b on a.site_id=b.id ");
        sf.append(" where a.status in('0','1') ");
        sf.append(queryByAnothers(map));
        return Db.queryLong(sf.toString());
    }

    public String queryByAnothers(Map<String,Object> map){
        StringBuffer sf = new StringBuffer();
        if(StringUtils.isNotBlank((CharSequence) map.get("serviceName"))){
            sf.append(" and b.id='"+map.get("serviceName")+"' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("isPrint"))){
            sf.append(" and a.is_print='"+map.get("isPrint")+"' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("beenUsed"))){
            sf.append(" and a.status = '"+map.get("beenUsed")+"' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("createTimeMin"))){
            sf.append(" and a.create_time >= '"+map.get("createTimeMin")+" 00:00:00' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("createTimeMax"))){
            sf.append(" and a.create_time <= '"+map.get("createTimeMax")+" 23:59:59' ");
        }
        return sf.toString();
    }


    /**
     *工单管理中二维码使用记录
     */

    public List<Record> getQRCodeUnitOrder(Page<Record> page, Map<String, Object> map,String siteId) {
        StringBuffer sb=new StringBuffer();
        sb.append(" SELECT a.*,b.warranty_type,b.customer_feedback,b.service_type,b.number,b.repair_time,b.service_mode FROM crm_code a  ");
        sb.append(" left JOIN crm_order b ON a.source=b.id  ");
        sb.append(" WHERE a.status ='1' and a.site_id='"+siteId+"' ");
        sb.append(queryBysource(map));
        sb.append(" order by a.use_time desc ");
        sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        return Db.find(sb.toString());
    }

    public long getUsedCount(Map<String,Object> map,String siteId){
        StringBuffer sb=new StringBuffer();
        sb.append(" SELECT count(*) from crm_code a ");
        sb.append(" left JOIN crm_order b ON a.source=b.id  ");
        sb.append(" WHERE a.status ='1' and a.site_id='"+siteId+"' ");
        sb.append(queryBysource(map));
        return Db.queryLong(sb.toString());
    }

    public String queryBysource(Map<String,Object> map){
        StringBuffer sb=new StringBuffer();
        if(StringUtil.isNotBlank((CharSequence) map.get("customerName"))){
            sb.append(" and a.customer_name like '%"+map.get("customerName")+"%' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("customerMobile"))){
            sb.append(" and a.customer_mobile like '%"+map.get("customerMobile")+"%' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("address"))){
            sb.append(" and a.customer_address like '%"+map.get("address")+"%' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("brand"))){
            sb.append(" and a.customer_brand like '%"+map.get("brand")+"%' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("category"))){
            sb.append(" and a.customer_category like '%"+map.get("category")+"%' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("useType"))){
            sb.append(" and b.service_mode='"+map.get("useType")+"' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("startBuyTime"))){
            sb.append(" and a.appliance_buy_time >= '"+map.get("startBuyTime")+" 00:00:00' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("endBuyTime"))){
            sb.append(" and a.appliance_buy_time <= '"+map.get("endBuyTime")+" 23:59:59' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("startUseTime"))){
            sb.append(" and a.use_time >= '"+map.get("startUseTime")+" 00:00:00' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("endUseTime"))){
            sb.append(" and a.use_time <= '"+map.get("endUseTime")+" 23:59:59' ");
        }
        if(StringUtils.isNotBlank((CharSequence) map.get("user"))){
            sb.append(" and a.user like '%"+map.get("user")+"%' ");
        }
        return sb.toString();
    }

    public List<Record> getQRCodeUnitOrderData(Page<Record> page,Map<String, Object> map,String siteId) {
        StringBuffer sb=new StringBuffer();
        sb.append(" SELECT a.*,b.warranty_type,b.customer_feedback,b.service_type,b.number FROM crm_code a  ");
        sb.append(" left JOIN crm_order b ON a.source=b.id  ");
        sb.append(" WHERE a.status ='1' and b.site_id='"+siteId+"' ");
        sb.append(queryBysource(map));
        sb.append(" order by a.use_time desc ");
        sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        return Db.find(sb.toString());
    }
    public List<Record> getSysQRCodeUnitOrderData(Page<Record> page,Map<String, Object> map) {
        StringBuffer sf = new StringBuffer();
        sf.append(" select a.sequence,a.id,a.code,a.site_id,a.status,a.create_time,a.use_time,a.is_print,b.name as siteName from crm_code a ");
        sf.append(" left join crm_site b on a.site_id=b.id ");
        sf.append(" where a.status in('0','1') ");
        sf.append(queryByAnothers(map));
        sf.append(" order by a.create_time desc,a.sequence desc ");
        sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        return Db.find(sf.toString());
    }
}
