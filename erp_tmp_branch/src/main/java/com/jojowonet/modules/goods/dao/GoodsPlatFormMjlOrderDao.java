package com.jojowonet.modules.goods.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;

import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import org.springframework.stereotype.Repository;

import com.jojowonet.modules.goods.entity.GoodsPlatFormMjlOrder;

import java.util.List;
import java.util.Map;

@Repository
public class GoodsPlatFormMjlOrderDao extends BaseDao<GoodsPlatFormMjlOrder> {


    public List<Record> getSitePlatformGoodsRecord(Page<Record> page, String siteId, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer("");
        sql.append("select gpo.*,concat(gpo.province,gpo.city,gpo.area,gpo.customer_address) as address,d.name as placeOrderName,c.mobile   ");
        sql.append(" FROM crm_goods_platform_mjl_order gpo ");
        sql.append(" left join sys_user c on gpo.placing_order_by=c.id  ");
        sql.append(" left join crm_site d on d.user_id=c.id  ");
        sql.append(" WHERE gpo.STATUS IN(0,1,2,3) AND gpo.site_id='"+siteId+"' ");
        sql.append(getRecordQuery(map));
        sql.append(" order by gpo.placing_order_time desc  ");
        if (page != null) {
            sql.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        }
        return Db.find(sql.toString());
    }

    public long getCount(Map<String, Object> map,String siteId){
        StringBuffer sql = new StringBuffer("");
        sql.append("select count(*) ");
        sql.append(" FROM crm_goods_platform_mjl_order gpo ");
        sql.append(" WHERE STATUS IN(0,1,2,3) AND site_id='"+siteId+"' ");
        sql.append(getRecordQuery(map));
        sql.append(" order by gpo.placing_order_time desc  ");
        return  Db.queryLong(sql.toString());
    }

    // 服务商付款记录明细查询条件
    private Object getRecordQuery(Map<String, Object> map) {
        if (map == null) {
            return "";
        }
        StringBuffer sf = new StringBuffer();
        String good_number = getTrimmedParamValue(map, "good_number");
        if (StringUtil.isNotBlank(good_number)) {
            sf.append(" and gpo.good_number like '%" + good_number + "%' ");
        }
        String number = getTrimmedParamValue(map, "number");
        if (StringUtil.isNotBlank(number)) {
            sf.append(" and gpo.number like '%" + number + "%' ");
        }
        String orderMan = getTrimmedParamValue(map, "orderMan");
        if (StringUtil.isNotBlank(orderMan)) {
            sf.append(" and gpo.placing_order_by = '" + orderMan + "' ");
        }
        String good_name = getTrimmedParamValue(map, "good_name");
        if (StringUtil.isNotBlank(good_name)) {
            sf.append(" and gpo.good_name like '%" + good_name + "%' ");
        }
        String good_brand = getTrimmedParamValue(map, "good_brand");
        if (StringUtil.isNotBlank(good_brand)) {
            sf.append(" and gpo.good_brand like '%" + good_brand + "%' ");
        }
        String good_model = getTrimmedParamValue(map, "good_model");
        if (StringUtil.isNotBlank(good_model)) {
            sf.append(" and gpo.good_model like '%" + good_model + "%' ");
        }
        String good_category = getTrimmedParamValue(map, "good_category");
        if (StringUtil.isNotBlank(good_category)) {
            sf.append(" and gpo.good_category like '%" + good_category + "%' ");
        }

        String status = getTrimmedParamValue(map, "status");
        if (StringUtil.isNotBlank(status)) {
            sf.append(" and gpo.status='"+status+"' ");
        }

        String customer_name = getTrimmedParamValue(map, "customer_name");
        if (StringUtil.isNotBlank(customer_name)) {
            sf.append(" and gpo.customer_name like '%" + customer_name + "%' ");
        }

        String customer_contact = getTrimmedParamValue(map, "customer_contact");
        if (StringUtil.isNotBlank(customer_contact)) {
            sf.append(" and gpo.customer_contact like '%" + customer_contact + "%' ");
        }

        String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
        if (StringUtil.isNotBlank(createTimeMin)) {// 接入时间
            sf.append(" and gpo.payment_time >= '" + createTimeMin
                    + " 00:00:00' ");
        }

        String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
        if (StringUtil.isNotBlank(createTimeMax)) {
            sf.append(" and gpo.payment_time <= '" + createTimeMax
                    + " 23:59:59' ");
        }

        return sf.toString();
    }

    //去空格
    private String getTrimmedParamValue(Map<String, Object> map, String param) {
        return StringUtils.trim(getParamValue(map, param));
    }

    //转换为String类型
    private String getParamValue(Map<String, Object> map, String param) {
        Object value = map.get(param);
        return value == null ? null : (map.get(param).toString());
    }
}