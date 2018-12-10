package com.jojowonet.modules.finance.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.entity.FactorySettle;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;

/**
 * 厂家结算录入Dao
 * 
 * @author yc
 * @version 2017-06-16
 */

@Repository
public class FactorySettleDao extends BaseDao<FactorySettle> {
	public List<Record> getfactorysettlelist(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT *  FROM crm_factory_settlement WHERE site_id=? AND status='0'");
		sf.append(getCondition(map));
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		return Db.find(sf.toString(), siteId);
	}

	public long getcount(String siteId, Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT COUNT(*) FROM crm_factory_settlement WHERE site_id=? AND status='0'");
		sf.append(getCondition(map));
		return Db.queryLong(sf.toString(), siteId);
	}

	// 根据id删除结算设置
	public void deleteFactorySettle(String id) {
		String sql = "UPDATE crm_factory_settlement SET status='1' WHERE id='" + id + "'";
		Db.update(sql);

	}

	// 根据id查询结算设置
	public Record FactorySettleById(String id) {
		String sql = "SELECT * FROM crm_factory_settlement WHERE id='" + id + "'";
		return Db.findFirst(sql);
	}

	public String getCondition(Map<String, Object> map) {
		StringBuffer sf = new StringBuffer();
		if (map != null) {
			if (map.get("vendorid") != null && StringUtils.isNotEmpty(((String[]) map.get("vendorid"))[0])) {
				sf.append(" and factory_id like '%" + (((String[]) map.get("vendorid"))[0]) + "%'");
			}

		}
		return sf.toString();
	}

	public void updateFactorySettle(String vendorid, String year, String month, String money, String userName, String remark, String id) {
		String sql = "UPDATE crm_factory_settlement SET factory_id=? , year=? , month=? , money=? , update_time=? , update_by=?,`remark`=?  WHERE id='" + id + "'";
		Db.update(sql, vendorid, year, month, money, new Date(), userName, remark);
	}

}