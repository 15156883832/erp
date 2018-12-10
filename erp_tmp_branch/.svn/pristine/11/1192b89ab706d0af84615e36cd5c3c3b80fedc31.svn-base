package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SmsTemplet;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/1/15.
 * 短信模板dao
 */
@Repository
public class SmsTempletDao  extends BaseDao<SmsTemplet>{
    public List<Record> smstempletList(Page<Record> page, Map<String, Object> map,String siteId){
        StringBuffer sf = new StringBuffer();
        sf.append("select * from crm_site_sms_template where status='0' and site_id=? ");
        sf.append(getCondition(map));
        sf.append(" order by create_time desc");
        if(page!=null){
            sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
        }
        return Db.find(sf.toString(),siteId);
    }

    public long listcount(Map<String,Object> map,String siteId){
        StringBuffer sf = new StringBuffer();
        sf.append("select count(*) from crm_site_sms_template where status='0' and site_id=? ");
        sf.append(getCondition(map));
        sf.append(" order by create_time desc");
        return Db.queryLong(sf.toString(),siteId);
    }


    public String getCondition(Map<String, Object> map){
        StringBuffer sf = new StringBuffer();
        if(map!=null){

        }
        return sf.toString();
    }


    public int deleteSms(String userId, Date deleteTime, String id){
        String sql ="update crm_site_sms_template set status='1' , delete_by=?, delete_time=? where id =?";
        return Db.update(sql, userId, deleteTime,id);
    }

    public Record getByid(String id){
        String sql = "select * from crm_site_sms_template where id=? and status='0'";
        return Db.findFirst(sql,id);
    }

    public List<Record> getAlllist(){
        StringBuffer sf = new StringBuffer();
        sf.append("select * from crm_site_sms_template where status='0' ");
        sf.append(" order by create_time desc");
        return Db.find(sf.toString());
    }

    public void updateSmsStatus(String status,String id){
        String sql = "update crm_site_sms_template set reviewsms_status=? where id=?";
         Db.update(sql,status,id);
    }
    public void updateSmsReason(String reason,String id){
        String sql = "update crm_site_sms_template set failed_reason=? where id=?";
        Db.update(sql,reason,id);
    }

    public List<Record> getsmsmodel(String siteId){
        String sql = "select * from crm_site_sms_template where status='0' and reviewsms_status='1' and site_id=?";
        return Db.find(sql,siteId);

    }

    public List<Record> getnamelist(String name,String id,String siteId){
        String sql="";
        if(StringUtil.isNotBlank(id)){
            sql="select * from crm_site_sms_template where site_id=? and name=?  and status='0' and id!=? ";
            return Db.find(sql,siteId,name,id);
        }else{
           sql="select * from crm_site_sms_template where site_id=? and name=?  and status='0'";
            return Db.find(sql,siteId,name);
        }
    }
    public Record getsmsById(String id,String siteId){
        String sql = "select * from crm_site_sms_template where site_id=? and id=? and status='0' and reviewsms_status='1'";
        return  Db.findFirst(sql,siteId,id);
    }
}
