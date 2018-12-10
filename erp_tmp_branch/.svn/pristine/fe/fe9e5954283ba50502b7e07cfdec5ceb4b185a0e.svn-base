/**
 */
package com.jojowonet.modules.fitting.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.entity.FittingApply;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.utils.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 备件申请DAO接口
 * @author Ivan
 * @version 2017-05-20
 */
@Repository
public class FittingApplyDao extends BaseDao<FittingApply> {
	
	public FittingApply getFittingApplyId(String id){
		return getByHql("from FittingApply where id=:p1 ", new Parameter(id));
	}
	
	//备件待审核/待出库列表
	public List<Record> getFittingApplyList(Page<Record> page ,String siteId,int type,Map<String,Object> ma){
		StringBuffer sf = new StringBuffer();
		sf.append("SELECT a.*,fap.status as fapStatus,concat(a.appliance_brand,a.appliance_category) as brandCategory, f.brand as suit_brand,f.warning,f.location FROM crm_site_fitting_apply a ");
		sf.append("LEFT JOIN crm_site_fitting f ON a.fitting_id=f.id AND a.site_id='"+siteId+"'  ");
		sf.append(" left join crm_site_fitting_apply_plan fap on fap.fitting_apply_id=a.id ");
		sf.append("WHERE a.site_id=?  ");
		
		if(type == 0){ // 待审核申请中 ： 0.申请待审核 1.缺件中
			sf.append(" AND a.status in ('0','1') ");
		} else if(type == 1) { //待出库  2.审核通过待出库 
			sf.append(" AND a.status = '2' ");
		} else if(type == 2) {//全部申请 0.申请待审核 1.缺件中 2.审核通过待出库 3.确认出库待领取 4.已领取可使用 5.申请已取消 6.申请审核未通过 7申请已删除
			sf.append(" AND a.status != '7' ");
		}

		sf.append(getqueryCriteria(ma));
		sf.append(createOrderBy(ma,"order by create_time desc"));
		if(page != null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString(),siteId);
	}
	
	//system权限下统计数据
	public List<Record> getFittingList(Page<Record> page ,Map<String,Object> ma){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT s.id, s.`name`, ");
		
		sf.append(" (SELECT COUNT(1) AS cnt FROM crm_site_fitting_apply AS a WHERE a.`site_id`=s.id      ");
		if(ma.get("startTime")!=null && ma.get("startTime")!=""){
			if(StringUtils.isNotBlank(ma.get("startTime").toString())){
				sf.append(" AND '"+ma.get("startTime")+"' <= a.create_time ");
			}
		}
		if(ma.get("endTime")!=null && ma.get("endTime")!=""){
			if(StringUtils.isNotBlank(ma.get("endTime").toString())){
				sf.append(" AND  a.create_time<= '"+ma.get("endTime")+"23:59:59' ");
			}
		}
		sf.append("  ) AS sh,  ");
		
		sf.append(" (SELECT COUNT(1) AS cnt FROM crm_site_fitting_used_record AS r WHERE r.`site_id`=s.id AND r.`status`='1'    AND r.TYPE!='2'    ");
		if(ma.get("startTime")!=null && ma.get("startTime")!=""){
			if(StringUtils.isNotBlank(ma.get("startTime").toString())){
				sf.append(" AND '"+ma.get("startTime")+"' <= r.used_time ");
			}
		}
		if(ma.get("endTime")!=null && ma.get("endTime")!=""){
			if(StringUtils.isNotBlank(ma.get("endTime").toString())){
				sf.append(" AND r.used_time <= '"+ma.get("endTime")+"23:59:59' ");
			}
		}
		sf.append(" ) AS dhx, ");
		
		
		sf.append(" (SELECT COUNT(1) AS cnt FROM crm_site_fitting_used_record AS r WHERE r.`site_id`=s.id AND r.`status`='2'   AND r.TYPE!='2'   ");
		if(ma.get("startTime")!=null && ma.get("startTime")!=""){
			if(StringUtils.isNotBlank(ma.get("startTime").toString())){
				sf.append("  AND '"+ma.get("startTime")+"' <= r.check_time ");
			}
		}
		if(ma.get("endTime")!=null && ma.get("endTime")!=""){
			if(StringUtils.isNotBlank(ma.get("endTime").toString())){
				sf.append("  AND r.check_time <= '"+ma.get("endTime")+"23:59:59' ");
			}
		}
		sf.append(" ) AS yhx, ");
		sf.append(" (SELECT m.name FROM `crm_area_manager` AS m WHERE m.id=s.`area_manager_id`) AS areamanager, ");
		sf.append(" s.province,s.city,s.area,s.address  ");
		
		sf.append(" FROM crm_site AS s  ");
		sf.append(" INNER JOIN sys_user AS u ON u.id=s.user_id    ");
		sf.append(" WHERE s.status='0' AND u.status='0' ");
		if(ma.get("name")!=null && ma.get("name")!=""){
			if(StringUtils.isNotBlank(ma.get("name").toString())){
				String name=ma.get("name").toString().trim();
				sf.append(" and s.name like '%"+name+"%'  ");
			}
		}
		if(ma.get("area")!=null && ma.get("area")!=""){
			if(StringUtils.isNotBlank(ma.get("area").toString())){
				String area=ma.get("area").toString().trim();
				sf.append(" and s.province like '%"+area+"%'  ");
			}
		}
		sf.append(" ORDER BY s.create_time DESC  ");
		if(page != null){
			sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sf.toString());
	}
	
	public long getCountFitCount(Map<String,Object> ma){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT COUNT(t.name) FROM( ");
		sf.append(" SELECT s.id, s.`name`, ");
		
		sf.append(" (SELECT COUNT(1) AS cnt FROM crm_site_fitting_apply AS a WHERE a.`site_id`=s.id      ");
		if(ma.get("startTime")!=null && ma.get("startTime")!=""){
			if(StringUtils.isNotBlank(ma.get("startTime").toString())){
				sf.append(" AND '"+ma.get("startTime")+"' <= a.create_time ");
			}
		}
		if(ma.get("endTime")!=null && ma.get("endTime")!=""){
			if(StringUtils.isNotBlank(ma.get("endTime").toString())){
				sf.append(" AND  a.create_time<= '"+ma.get("endTime")+"23:59:59' ");
			}
		}
		sf.append("  ) AS sh,  ");
		
		sf.append(" (SELECT COUNT(1) AS cnt FROM crm_site_fitting_used_record AS r WHERE r.`site_id`=s.id AND r.`status`='1'  AND r.TYPE!='2'  ");
		if(ma.get("startTime")!=null && ma.get("startTime")!=""){
			if(StringUtils.isNotBlank(ma.get("startTime").toString())){
				sf.append(" AND '"+ma.get("startTime")+"' <= r.used_time ");
			}
		}
		if(ma.get("endTime")!=null && ma.get("endTime")!=""){
			if(StringUtils.isNotBlank(ma.get("endTime").toString())){
				sf.append(" AND r.used_time <= '"+ma.get("endTime")+"23:59:59' ");
			}
		}
		sf.append(" ) AS dhx, ");
		
		
		sf.append(" (SELECT COUNT(1) AS cnt FROM crm_site_fitting_used_record AS r WHERE r.`site_id`=s.id AND r.status !='1'  AND r.TYPE != '2'   ");
		if(ma.get("startTime")!=null && ma.get("startTime")!=""){
			if(StringUtils.isNotBlank(ma.get("startTime").toString())){
				sf.append("  AND '"+ma.get("startTime")+"' <= r.check_time ");
			}
		}
		if(ma.get("endTime")!=null && ma.get("endTime")!=""){
			if(StringUtils.isNotBlank(ma.get("endTime").toString())){
				sf.append("  AND r.check_time <= '"+ma.get("endTime")+"23:59:59' ");
			}
		}
		sf.append(" ) AS yhx, ");
		sf.append(" CONCAT(s.province,s.city,s.area,s.address) AS detailAddress     ");
		sf.append(" FROM crm_site AS s  ");
		sf.append(" INNER JOIN sys_user AS u ON u.id=s.user_id    ");
		sf.append(" WHERE s.status='0' AND u.status='0' ");
		if(ma.get("name")!=null && ma.get("name")!=""){
			if(StringUtils.isNotBlank(ma.get("name").toString())){
				String name=ma.get("name").toString().trim();
				sf.append(" and s.name like '%"+name+"%'  ");
			}
		}
		if(ma.get("area")!=null && ma.get("area")!=""){
			if(StringUtils.isNotBlank(ma.get("area").toString())){
				String area=ma.get("area").toString().trim();
				sf.append(" and s.province like '%"+area+"%'  ");
			}
		}
		sf.append(" ORDER BY s.create_time DESC  ");
		sf.append(" ) t ");
		
		return Db.queryLong(sf.toString());
	}
	
	
	//表头排序
		private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
			String sort =null;
			String dir = null;
			if(map.get("sidx")!=null){
				if(StringUtils.isNotBlank(map.get("sidx").toString())){
					sort = map.get("sidx").toString();
				}
			}
		if(map.get("sord")!=null){
			if(StringUtils.isNotBlank(map.get("sord").toString())){
				dir = map.get("sord").toString();
			}
		}
		
		    return (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by `" + sort + "` " + dir) : defaultOrderBy;
		}
	
	public long getFittingApplyCount(String siteId,int type,Map<String,Object> ma){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_site_fitting_apply a ");
		sf.append(" LEFT JOIN crm_site_fitting f ON a.fitting_id=f.id AND a.site_id='"+siteId+"'  ");
		sf.append(" left join crm_site_fitting_apply_plan fap on fap.fitting_apply_id=a.id ");
		sf.append(" WHERE a.site_id=?  ");
		
		if(type == 0){ // 待审核申请中 ： 0.申请待审核 1.缺件中
			sf.append(" AND ( a.status = '0' OR a.status = '1' ) ");
		} else if(type == 1) { //待出库  2.审核通过待出库 
			sf.append(" AND a.status = '2' ");
		} else if(type == 2) {//全部申请 0.申请待审核 1.缺件中 2.审核通过待出库 3.确认出库待领取 4.已领取可使用 5.申请已取消 6.申请审核未通过 7申请已删除
			sf.append(" AND a.status != '7' ");
		}
		
		sf.append(getqueryCriteria(ma));
		return Db.queryLong(sf.toString(), siteId);
	}
	
	public long getFittingApplyCount1(String siteId){
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(*) as count FROM crm_site_fitting_apply a ");
		sf.append(" LEFT JOIN crm_site_fitting f ON a.fitting_id=f.id AND a.site_id='"+siteId+"'  ");
		sf.append(" WHERE a.site_id=?  ");
		sf.append(" AND ( a.status = '0' OR a.status = '1' ) "); // 待审核申请中 ： 0.申请待审核 1.缺件中
		return Db.queryLong(sf.toString(), siteId);
	}

	//备件在途
	public List<Record> getFittingRoadList(Page<Record> page, Map<String, Object> map, String siteId) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.status as applyStatus ,b.order_number,b.fitting_code,c.version,b.fitting_name,c.brand,a.* from crm_site_fitting_apply_plan a  ");
		sb.append(" left join crm_site_fitting_apply b on a.fitting_apply_id=b.id ");
		sb.append(" left join crm_site_fitting c on c.id=b.fitting_id ");
		sb.append(" where a.site_id=?  ");
		sb.append(getSQLBySourch(map));
		sb.append(" order by status asc,a.create_time desc ");
		sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		return Db.find(sb.toString(), siteId);
	}

	public String getSQLBySourch(Map<String, Object> map) {
		StringBuffer sb = new StringBuffer();
		if (StringUtils.isNotBlank((CharSequence) map.get("fittingCode"))) {
			sb.append(" and b.fitting_code like '%" + map.get("fittingCode") + "%' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("fittingName"))) {
			sb.append(" and b.fitting_name like '%" + map.get("fittingName") + "%' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("marks"))) {
			sb.append(" and a.marks like '%" + map.get("marks") + "%' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("source"))) {
			sb.append(" and a.source='" + map.get("source") + "' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("createTimeMin"))) {
			sb.append(" and a.plan_time >= '" + map.get("createTimeMin") + " 00:00:00' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("createTimeMax"))) {
			sb.append(" and a.plan_time <= '" + map.get("createTimeMax") + " 23:59:59' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("applicant"))) {
			sb.append(" and a.plan_applicant like '%" + map.get("applicant") + "%' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("fapStatus"))) {
			sb.append(" and a.status = '" + map.get("fapStatus") + "' ");
		}
		if (StringUtils.isNotBlank((CharSequence) map.get("applyId"))) {
			sb.append(" and a.fitting_apply_id = '" + map.get("applyId") + "' ");
		}
		return sb.toString();
	}

	public long getFittingRoadCount(String siteId) {
		return Db.queryLong("select count(*) from crm_site_fitting_apply_plan where status<>3 ");
	}


		public long getFittingApplyCount2(String siteId){
			StringBuffer sf = new StringBuffer();
			sf.append(" SELECT count(*) as count FROM crm_site_fitting_apply a ");
			sf.append(" LEFT JOIN crm_site_fitting f ON a.fitting_id=f.id AND a.site_id='"+siteId+"'  ");
			sf.append(" WHERE a.site_id=?  ");
			sf.append(" AND a.status = '2' ");//待出库  2.审核通过待出库
			return Db.queryLong(sf.toString(), siteId);
		}
		public long getFittingApplyCount3(String siteId){
			return Db.queryLong("select count(*) from crm_site_fitting_apply_plan a where a.status=1 and a.site_id=? ",siteId);
		}

	public String getqueryCriteria(Map<String, Object> ma) {
		StringBuffer sf = new StringBuffer();
		if (StringUtils.isNotEmpty((CharSequence) ma.get("fittingCode"))) {
			sf.append(" and a.fitting_code like '%" + ma.get("fittingCode") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("fapStatus"))) {
			sf.append(" and fap.status ='" + ma.get("fapStatus") + "' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("fittingName"))) {
			sf.append(" and a.fitting_name like '%" + ma.get("fittingName") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("warrantyType"))) {
			sf.append(" and a.warranty_type ='" + ma.get("warrantyType") + "' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("employeName"))) {
			sf.append(" and a.employe_name like '%" + ma.get("employeName") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("orderNumber"))) {
			sf.append(" and a.order_number like '%" + ma.get("orderNumber") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("suitBrand"))) {
			sf.append(" and f.suit_brand like '%" + ma.get("suitBrand") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("customerMobile"))) {
			sf.append(" and a.customer_mobile like '%" + ma.get("customerMobile") + "%' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("status"))) {
			if (ma.get("status").equals("0")) {
				sf.append(" and a.status in ('0','1') ");
			} else {
				sf.append(" and a.status = '" + ma.get("status") + "' ");
			}
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("createTimeMin"))) {
			sf.append(" and a.create_time >= '" + ma.get("createTimeMin") + "' ");
		}
		if (StringUtils.isNotEmpty((CharSequence) ma.get("createTimeMax"))) {
			sf.append(" and a.create_time <= '" + ma.get("createTimeMax") + " 23:59:59' ");
		}
		if (StringUtils.isNotBlank((CharSequence) ma.get("suitCategory"))) {
			sf.append(" and a.suit_category='" + ma.get("suitCategory") + "' ");
		}
		if (StringUtils.isNotBlank((CharSequence) ma.get("applianceCategory"))) {
			sf.append(" and a.appliance_category='" + ma.get("applianceCategory") + "' ");
		}
		if (StringUtils.isNotBlank((CharSequence) ma.get("applianceBrand"))) {
			sf.append(" and a.appliance_brand='" + ma.get("applianceBrand") + "' ");
		}
		return sf.toString();
	}
	
	public Map<String ,Object> getCount(String siteId){
		StringBuilder sb = new StringBuilder();
		sb.append("	SELECT ");
		sb.append(" COUNT(CASE WHEN  a.status='0'   THEN 1 END) AS 'dsh', ");
		sb.append(" COUNT(CASE WHEN  a.status='2'   THEN 1 END) AS 'dck', "); 
		sb.append(" COUNT(*) AS 'history' ");
		sb.append(" FROM crm_site_fitting_apply a  ");
		sb.append(" WHERE a.site_id =? ");
		Record rd = Db.findFirst(sb.toString(), siteId);
		if(rd !=null){
			return rd.getColumns();
		}
		return null;
	}
	
	public List<Record> q_bjapply(String siteId,String code){
		
		StringBuffer sql = new StringBuffer();
		sql.append("select * from crm_site_fitting s where s.site_id ='"+siteId+"'");
		sql.append(" and s.code = '"+code+"'");
		
		return Db.find(sql.toString());
	}
	
	//删除备件申请信息
	public void deleteFittingApply(String id){
		String sql ="UPDATE  crm_site_fitting_apply SET STATUS ='7' WHERE id=? ";
		Db.update(sql,id);
	}
	
}
