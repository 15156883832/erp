package com.jojowonet.modules.goods.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.entity.GiftPacks;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/19.
 */
@Repository
public class GoodsGiftPackDao extends BaseDao<GiftPacks> {
    // 礼包记录列表
    public List<Record> getGiftPackList(Page<Record> page,Map<String, Object> map) {
        StringBuffer sb = new StringBuffer();
        sb.append("select g.*,s.name as take_site,(select u.login_name from sys_user  as u where u.id=g.take_by ) as takeBy");
        sb.append("  from crm_gift_pack as g left join crm_site as s on g.take_site_id=s.id where g.status='0' ");
        sb.append(getqueryCondition(map));
        sb.append(" order by g.create_time desc");
        if (page != null) {
            sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        }
        return Db.find(sb.toString());
    }



    // 礼包记录数量
    public Long getCount(Map<String, Object> map) {
        StringBuffer sb = new StringBuffer();
        sb.append("select count(*) from crm_gift_pack as g where g.status='0' ");
        sb.append(getqueryCondition(map));
        return Db.queryLong(sb.toString());
    }

    // 查询条件
    public String getqueryCondition(Map<String, Object> ma) {
        StringBuffer sf = new StringBuffer();
        if(StringUtil.checkParamsValid(ma.get("createTimesMin"))){
            sf.append(" and g.create_time >= '"+(ma.get("createTimesMin"))+" 00:00:00'  ");
        }
        if(StringUtil.checkParamsValid(ma.get("createTimesMax"))){
            sf.append(" and g.create_time <= '"+(ma.get("createTimesMax"))+" 23:59:59' ");
        }
        if(StringUtil.checkParamsValid(ma.get("takeSite"))){
            String str[]=ma.get("takeSite").toString().split(",");
            sf.append(" and g.take_site_id in (" + StringUtil.joinInSql(str) + ")");
        }
        return sf.toString();
    }

    public List<Record> getSiteList(){
        String sql = "select * from crm_site where status!=1";
        return Db.find(sql);
    }

    public Integer deletGiftByid(String id){
        String  sql = "update crm_gift_pack set status='1' where id=? ";
        return  Db.update(sql,id);
    }

}
