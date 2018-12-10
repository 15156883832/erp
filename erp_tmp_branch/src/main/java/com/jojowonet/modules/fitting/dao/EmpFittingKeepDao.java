package com.jojowonet.modules.fitting.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.entity.EmpFittingKeep;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.order.utils.CrmUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class EmpFittingKeepDao extends BaseDao<EmpFittingKeep> {
	
	public List<Record> getListOfEmpFittingKeep2(Page<Record> page,String siteId,Map<String,Object> map){
		StringBuffer sql=new StringBuffer("");
		sql.append("select efk.fitting_code,efk.employe_name ,efk.fitting_name, ");//基础表
		sql.append(" sf.version ,efk.type as ktype,efk.amount ,sf.type , ");
		sql.append(" sf.brand,sf.suit_category,sf.site_price,efk.employe_price,");
		sql.append("efk.customer_price,sf.supplier, ");
		sql.append("efk.order_number , efk.customer_name,efk.customer_mobile,efk.warranty_type,efk.create_time");//关联工单表
		sql.append("  from crm_employe_fitting_keep efk ");
		sql.append(" inner join crm_site_fitting sf ");
		sql.append(" on efk.fitting_id = sf.id ");
		
		sql.append(" where efk.site_id = ? ");
		sql.append(getQuery(map));
		sql.append(createOrderBy(map,"  order by efk.create_time desc "));
		if(page!=null){
			sql.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo()-1)*page.getPageSize());
		}
		return Db.find(sql.toString(),siteId);
		
	}
	//表头排序
	private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
		String sort = getParamValue(map, "sidx");
		String dir = getParamValue(map, "sord");
		return (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by '" + sort + "' " + dir) : defaultOrderBy;
	}
	
	private String getParamValue(Map<String, Object> map, String param) {
        Object value = map.get(param);
        return value == null ? null : ((String[]) map.get(param))[0];
    }
	
	public long getCountOfEmpFittingKeep(Page<Record> page,String siteId,Map<String,Object> map){
		StringBuffer sql = new StringBuffer("");
		sql.append("select count(*)  ");
		sql.append("  from crm_employe_fitting_keep efk ");
		sql.append(" inner join crm_site_fitting sf ");
		sql.append(" on efk.fitting_id = sf.id ");
		sql.append(" where  efk.site_id = ? ");	
		sql.append(getQuery(map));
		return Db.queryLong(sql.toString(),siteId);
	}
	public String getQuery(Map<String,Object> map){
		StringBuffer sf = new StringBuffer();
		if(map != null){
			if(map.get("fitting_code") != null && StringUtils.isNotEmpty(((String[])map.get("fitting_code"))[0])){
				sf.append(" and efk.fitting_code like '%"+((String[])map.get("fitting_code"))[0]+"%' ");
			}
			if (map.get("fitting_name") != null && StringUtils.isNotEmpty(((String[])map.get("fitting_name"))[0])){
				sf.append(" and efk.fitting_name like '%"+((String[])map.get("fitting_name"))[0]+"%' ");
			}
			if(map.get("mxtype") != null && StringUtils.isNotEmpty(((String[])map.get("mxtype"))[0])){
				sf.append(" and efk.type = '"+((String[])map.get("mxtype"))[0]+" ' ");
			}
			if(map.get("applicant") != null && StringUtils.isNotEmpty(((String[])map.get("applicant"))[0])){
				sf.append(" and efk.employe_name  = '"+((String[])map.get("applicant"))[0]+" ' ");
			}
			if(map.get("supplier") != null && StringUtils.isNotEmpty(((String[])map.get("supplier"))[0])){
				sf.append(" and sf.supplier  like '%"+((String[])map.get("supplier"))[0]+"%' ");
			}
			if(map.get("brand") != null && StringUtils.isNotEmpty(((String[])map.get("brand"))[0])){
				sf.append(" and sf.brand  like '%"+((String[])map.get("brand"))[0]+"%' ");
			}
			if(map.get("suit_category") != null && StringUtils.isNotEmpty(((String[])map.get("suit_category"))[0])){
				sf.append(" and sf.suit_category = '"+((String[])map.get("suit_category"))[0]+"' ");
			}

			if(map.get("createTimeMin") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMin"))[0])){//接入时间
				sf.append(" and efk.create_time >= '"+((String[]) map.get("createTimeMin"))[0]+" 00:00:00' ");
			}
			if(map.get("createTimeMax") != null && StringUtils.isNotEmpty(((String[])map.get("createTimeMax"))[0])){
				sf.append(" and efk.create_time <= '"+((String[]) map.get("createTimeMax"))[0]+" 23:59:59' ");
			}

		}

		return sf.toString();
	}

	/**
	 * 工程师库存返还时，创建出入库明细。
	 */
	public void createReturnEmpFittingKeep(Fitting fitting, String empId, String empName, User user,double amount) {
		EmpFittingKeep ekp = new EmpFittingKeep();
		ekp.setNumber(CrmUtils.no());
		ekp.setType("3"); // 返还
		ekp.setFittingId(fitting.getId());
		ekp.setFittingCode(fitting.getCode());
		ekp.setFittingName(fitting.getName());
		ekp.setAmount(amount);
		ekp.setPrice(fitting.getSitePrice());
		if (fitting.getEmployePrice() != null) {
			ekp.setEmployePrice(fitting.getEmployePrice());
		}
		if (fitting.getCustomerPrice() != null) {
			ekp.setCustomerPrice(fitting.getCustomerPrice());
		}
		ekp.setEmployeId(empId);
		ekp.setEmployeName(empName);
		ekp.setSiteId(fitting.getSiteId());
		ekp.setCreateBy(user.getId());
		save(ekp);
	}
	
}
