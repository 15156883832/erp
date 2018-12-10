package com.jojowonet.modules.finance.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.Exacct;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/26.
 * 费用科目dao
 */

@Repository
public class ExacctDao extends BaseDao<Exacct> {
    public List <Record> getexacctlistSite(Page <Record> page, String siteId, Map <String, Object> map) {
    	//先看该服务商有没有自定义费用科目
    	Long count = Db.queryLong("select count(*) from crm_exacct a where a.site_id=?",siteId);
        StringBuffer sf = new StringBuffer();
        sf.append("SELECT * from crm_exacct a where a.status='0' ");
        if(count > 0 ) {//自定义过
        	sf.append(" and a.site_id=? ");
    	}else {//未自定义
    		sf.append(" and a.site_id is null ");
    	}
        sf.append(getCondition(map));
        sf.append(" order by a.create_time asc");
        if (page != null) {
            sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
        }
        if(count > 0 ) {
        	return Db.find(sf.toString(),siteId);
        }else {
        	return Db.find(sf.toString());
        }
    }
    
    public long getcountSite(String siteId, Map <String, Object> map) {
    	//先看该服务商有没有自定义费用科目
    	Long count = Db.queryLong("select count(*) from crm_exacct a where a.site_id=? ",siteId);
        StringBuffer sf = new StringBuffer();
        sf.append("SELECT COUNT(*) FROM crm_exacct a where  a.status='0'");
        if(count > 0 ) {//自定义过
        	sf.append(" and a.site_id=? ");
    	}else {//未自定义
    		sf.append(" and a.site_id is null ");
    	}
        sf.append(getCondition(map));
        if(count > 0 ) {
        	return Db.queryLong(sf.toString(),siteId);
        }else {
        	return Db.queryLong(sf.toString());
        }
    }
    
    public List <Record> getexacctlist(Page <Record> page, String siteId, Map <String, Object> map) {
    	StringBuffer sf = new StringBuffer();
    	sf.append("SELECT * from crm_exacct a where a.status='0' ");
    	//sf.append(" and (a.site_id=? or a.site_id is null) ");
    	sf.append(getCondition(map));
    	sf.append(" order by a.create_time asc");
    	if (page != null) {
    		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
    	}
    	return Db.find(sf.toString());
    }

    public long getcount(String siteId, Map <String, Object> map) {
        StringBuffer sf = new StringBuffer();
        sf.append("SELECT COUNT(*) FROM crm_exacct a where  a.status='0'");
        //sf.append(" and a.site_id=? ");
        sf.append(getCondition(map));
        return Db.queryLong(sf.toString());
    }

    public String getCondition(Map <String, Object> map) {
        StringBuffer sf = new StringBuffer();
        if (map != null) {
            if (map.get("name") != null && StringUtils.isNotEmpty(((String[]) map.get("name"))[0])) {
                sf.append(" and a.name like'%" + (((String[]) map.get("name"))[0]) + "%'");
            }
        }
        return sf.toString();
    }
}
