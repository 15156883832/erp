package com.jojowonet.modules.operate.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.dialect.Sqlite3Dialect;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.db.DbKey;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/9.
 */
@Repository
public class VipSiteExpireDao extends BaseDao<Site>{
    public List<Record> VipsiteList(Page<Record> page, Map<String,Object> map,String mon){
        StringBuffer sf=new StringBuffer();
        sf.append("SELECT t.*,(SELECT COUNT(1) FROM `crm_order` AS o WHERE o.`site_id`=t.`id`) AS ordercount, ");
        //ok
        sf.append(" 0 AS order400count,  ");
        sf.append(" (SELECT COUNT(1) FROM crm_goods_siteself_order AS g WHERE g.site_id=t.`id`) AS goodsselforder, ");
        sf.append(" (SELECT COUNT(1) FROM crm_goods_platform_order AS p WHERE p.site_id=t.`id`) AS goodsplatorder, ");
        sf.append(" (SELECT COUNT(1)  FROM crm_site_fitting_apply AS f WHERE f.`site_id`=t.`id`) AS sh ");
        sf.append("  FROM crm_site t INNER JOIN sys_user AS u ");
        sf.append(" ON t.`user_id` =u.`id` AND u.`status` ='0' WHERE t.status!=1 AND  ");
        sf.append(getMoncondition(mon));
        sf.append(getCondition2(map));
        sf.append(" ORDER BY t.due_time ASC,t.`create_time` DESC ");
        sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
        List<Record> records = Db.find(sf.toString());
        fill400OrderCount(records);
        return records;
    }

    public long getVipListCount(Map<String,Object> map,String mon){
        StringBuffer sf=new StringBuffer();
        sf.append("SELECT COUNT(t.id) FROM `crm_site` AS t INNER JOIN sys_user AS u ");
        sf.append("ON t.`user_id` =u.`id` AND u.`status` ='0'  WHERE t.`status` !='1' AND  ");
        sf.append(getMoncondition(mon));
        sf.append(getCondition2(map));
        //sf.append(page.getSqlOrderBy());
        sf.append(" ORDER BY t.due_time ASC,t.`create_time` DESC ");
        return Db.queryLong(sf.toString());
    }


    public List<Record> getVipAttermsList(Page<Record> page, Map<String,Object> map){
        StringBuffer sf=new StringBuffer();
        sf.append("SELECT t.*,(SELECT COUNT(1) FROM `crm_order` AS o WHERE o.`site_id`=t.`id`) AS ordercount, ");
        sf.append(" 0 AS order400count,  ");
        sf.append(" (SELECT COUNT(1) FROM crm_goods_siteself_order AS g WHERE g.site_id=t.`id`) AS goodsselforder, ");
        sf.append(" (SELECT COUNT(1) FROM crm_goods_platform_order AS p WHERE p.site_id=t.`id`) AS goodsplatorder, ");
        sf.append(" (SELECT COUNT(1)  FROM crm_site_fitting_apply AS f WHERE f.`site_id`=t.`id`) AS sh, ");
		sf.append(" (SELECT m.name FROM `crm_area_manager` AS m WHERE m.id=t.`area_manager_id`) AS areamanager ");
        sf.append("  FROM crm_site t INNER JOIN sys_user AS u ");
        sf.append(" ON t.`user_id` =u.`id` AND u.`status` ='0' WHERE t.status!=1 AND  ");
        sf.append("DATE_FORMAT(t.due_time,'%Y-%m-%d')<=(CURDATE())");
        sf.append(getCondition2(map));
        sf.append(" ORDER BY t.due_time ASC,t.`create_time` DESC ");
        sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
        List<Record> records = Db.find(sf.toString());
        fill400OrderCount(records);
        return records;
    }

    private void fill400OrderCount(List<Record> records) {
        List<String> idList = new ArrayList<>();
        Map<String, Record> mapper = new HashMap<>();
        for(Record r : records) {
            idList.add(r.getStr("id"));
            mapper.put(r.getStr("id"), r);
        }

        if (idList.size() > 0) {
            // ok
            SqlKit kit = new SqlKit().append("SELECT COUNT(1) as cnt,site_id FROM `crm_order_400` AS o WHERE o.`site_id` in(" + CrmUtils.joinInSql(idList) + ") group by o.site_id");
            List<Record> list = Db.use(DbKey.DB_ORDER_400).find(kit.toString());
            for (Record r : list) {
                String siteId = r.getStr("site_id");
                Record record = mapper.get(siteId);
                if (record != null) {
                    record.set("order400count", r.getLong("cnt"));
                }
            }
        }
    }

    public long getAttermsListCount(Map<String,Object> map){
        StringBuffer sf=new StringBuffer();
        sf.append("SELECT COUNT(t.id) FROM `crm_site` AS t INNER JOIN sys_user AS u ");
        sf.append("ON t.`user_id` =u.`id` AND u.`status` ='0'  WHERE t.`status` !='1' AND  DATE_FORMAT(t.due_time,'%Y-%m-%d')<=(CURDATE()) ");
        sf.append(getCondition2(map));
        //sf.append(page.getSqlOrderBy());
        sf.append(" ORDER BY t.due_time ASC,t.`create_time` DESC ");
        return Db.queryLong(sf.toString());
    }


    public String getCondition2(Map<String,Object> map){
        StringBuffer sf = new StringBuffer();
        if(StringUtil.checkParamsValid(map.get("name"))){
            sf.append(" and t.name like '%"+(map.get("name"))+"%' ");
        }
        if(StringUtil.checkParamsValid(map.get("version"))){
            if("1".equals(map.get("version"))){
                sf.append(" and t.due_time is null  ");
            }else{
                sf.append(" and t.due_time is not null ");
            }
        }
        if (StringUtil.checkParamsValid(map.get("createtimemax"))) {
            sf.append("and t.create_time <= '" + map.get("createtimemax") + " 23:59:59'");
        }
        if (StringUtil.checkParamsValid(map.get( "createtimemin"))) {
            sf.append("and t.create_time >= '" + map.get( "createtimemin") + " 00:00:00'");
        }
        if (StringUtil.checkParamsValid(map.get("duetimemax"))) {
        	sf.append("and t.due_time <= '" + map.get("duetimemax") + " 23:59:59'");
        }
        if (StringUtil.checkParamsValid(map.get( "duetimemin"))) {
        	sf.append("and t.due_time >= '" + map.get( "duetimemin") + " 00:00:00'");
        }
        return sf.toString();
    }

    public String getMoncondition(String mon){
        StringBuffer sf = new StringBuffer();
       if(StringUtil.isNotBlank(mon)){
           if("1".equals(mon)){
               sf.append(" DATE_FORMAT(t.due_time,'%Y-%m-%d')>=(CURDATE()) and DATE_FORMAT(t.due_time,'%Y-%m-%d')<=(CURDATE()+INTERVAL '1' MONTH) ");
           }else{
               sf.append(" DATE_FORMAT(t.due_time,'%Y-%m-%d')>=(CURDATE()+INTERVAL '1' MONTH) and DATE_FORMAT(t.due_time,'%Y-%m-%d')<=(CURDATE()+INTERVAL '3' MONTH) ");
           }

       }
        return sf.toString();
    }
}
