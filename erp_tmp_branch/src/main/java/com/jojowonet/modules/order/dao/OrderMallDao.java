package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderMall;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2018/1/25.
 * 购机商场dao
 */
@Repository
public class OrderMallDao extends BaseDao<OrderMall> {
    public List<Record> filterOrderMall(String siteId, Page<Record> page) {
        SqlKit kit = new SqlKit().append(" SELECT * FROM crm_site_order_mall WHERE site_id=? and status='0' ORDER BY sort ASC ");
        if (page != null) {
            kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
        }
        return Db.find(kit.toString(), siteId);
    }

    public long getcount(String siteId){
        SqlKit kit = new SqlKit().append(" SELECT count(*) FROM crm_site_order_mall WHERE site_id=? and status='0'  ");
        return Db.queryLong(kit.toString(), siteId);
    }

    public List<Record> getlist(String siteId){
        SqlKit kit = new SqlKit().append("SELECT * FROM crm_site_order_mall WHERE site_id=? and status='0'");
        return Db.find(kit.toString(),siteId);
    }

    public List<String> getlistname(String siteId){
        SqlKit kit = new SqlKit().append("SELECT mall_name FROM crm_site_order_mall WHERE site_id=? and status='0'");
        return Db.query(kit.toString(),siteId);
    }
   //根据id查询
    public Record getOrderMallById(String id, String siteId) {
        String sql = "SELECT * FROM crm_site_order_mall WHERE site_id=?  AND id=? ";
        return Db.findFirst(sql, siteId, id);
    }

    //更新
    public int updatesMall(String name, Integer sort, String id,Date updateTime) {
        String sql = "UPDATE crm_site_order_mall SET mall_name=? ,sort=? ,update_time=? WHERE id=?";
        return Db.update(sql, name, sort,updateTime,id);
    }
    //删除
    public int deleteMall(String id){
        String sql = "update crm_site_order_mall set status='1' where id=?";
        return Db.update(sql,id);
    }
    //根据名字查询数量
    public long querylongbyname(String name,String id){
        StringBuffer sf = new StringBuffer();
        if(StringUtil.isNotBlank(id)){
            sf.append("select count(*) from crm_site_order_mall where mall_name=? and id!=? and status='0' ");
            return Db.queryLong(sf.toString(),name,id);
        }else{
            sf.append("select count(*) from crm_site_order_mall where mall_name=? and status='0'");
            return Db.queryLong(sf.toString(),name);
        }

    }
}
