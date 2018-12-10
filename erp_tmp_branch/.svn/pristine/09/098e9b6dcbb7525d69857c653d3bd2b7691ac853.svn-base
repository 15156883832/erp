/**
 */
package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SiteCommonSetting;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.IdGen;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 类型信息DAO接口
 * @author Ivan
 * @version 2017-10-25
 */
@Repository
public class SiteCommonSettingDao extends BaseDao<SiteCommonSetting> {


	public List<Record> getCommenSetting(Page<Record> page, String siteId,String type){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT * FROM crm_site_common_setting s WHERE s.site_id=? ");
		sf.append(getSettingCondition(type));
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());

		return Db.find(sf.toString(),siteId);

	}

	public SiteCommonSetting getSettingByType(String type, String siteId) {
		Query query = getSession().createQuery("from SiteCommonSetting where type=:type and siteId=:sid");
		query.setParameter("type", type);
		query.setParameter("sid", siteId);
		return (SiteCommonSetting) query.uniqueResult();
	}

	public String getSettingCondition(String type){
		StringBuffer sf = new StringBuffer();
		if(type != null){
			sf.append(" and s.type = '"+type+"' ");
		}
		return sf.toString();
	}
	public long getListcount(String siteId,String type){
		StringBuffer sf = new StringBuffer();
	   sf.append(" select count(*) as count from crm_site_common_setting s  where s.site_id=? ");
		sf.append(getSettingCondition(type));
		return Db.queryLong(sf.toString(),siteId);
	}

	public void updatesetting(String id) {
		String sql ="UPDATE crm_site_common_setting SET set_value = '1' WHERE id = '"+id+"'";
		Db.update(sql);
	}
	public void updatesettings(String id){
		String sql ="UPDATE crm_site_common_setting SET set_value = '0' WHERE id = '"+id+"'";
		Db.update(sql);
	}
	//3.设置工程师APP结算显示方式（set_value对应值是：1报修时间2完工时间3结算归属时间）
	public void updateSetvalue(String id,String value){
		String sql ="UPDATE crm_site_common_setting SET set_value = '"+value+"' WHERE id = '"+id+"'";
		Db.update(sql);
	}
	public Record getCommensetting(String siteId,String type){
		String sql = "SELECT * FROM crm_site_common_setting a WHERE a.site_id='"+siteId+"' AND a.type='"+type+"'";
		return Db.findFirst(sql);
	}

	public void saveCommensetting(SiteCommonSetting com){
		String sql = "INSERT INTO crm_site_common_setting (id, site_id, type, set_value)VALUES(?, ?, ?, ?) ";
		Db.update(sql,IdGen.uuid(),com.getSiteId(),com.getType(),com.getSetValue());
	}

	public void saveSiteCommonSetting(List<String> siteIds, String type, String value) {
		if (siteIds.isEmpty() || StringUtil.isBlank(value) || StringUtil.isBlank(type)) {
			throw new IllegalArgumentException();
		}
		//use del and create pattern
		Session session = getSession();
		SQLQuery query = session.createSQLQuery("delete from crm_site_common_setting where site_id in(:ids) and `type`=:type");
		query.setParameterList("ids", siteIds);
		query.setParameter("type", type);
		query.executeUpdate();

		for (String siteId : siteIds) {
			SiteCommonSetting setting = new SiteCommonSetting();
			setting.setSiteId(siteId);
			setting.setSetValue(value);
			setting.setType(type);
			save(setting);
		}
	}

	public boolean hasWxOpenPermission(String siteId) {
		Record first = Db.findFirst("select a.set_value from crm_site_common_setting as a where a.site_id=? and a.type=? limit 1", siteId, "16");
		return first != null && "0".equals(first.getStr("set_value"));
	}
}
