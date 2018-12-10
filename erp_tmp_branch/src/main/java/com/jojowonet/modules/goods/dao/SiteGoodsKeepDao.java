package com.jojowonet.modules.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.entity.GoodsSiteselfDetail;
import com.jojowonet.modules.order.utils.StringUtil;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

@Repository
public class SiteGoodsKeepDao extends BaseDao<GoodsSiteselfDetail> {

	public long getCountOfSiteGoodsKeep(Page<Record> page, String siteId, Map<String, Object> map) {

		StringBuffer sql = new StringBuffer("");
		sql.append("select count(*)");
		sql.append("from crm_goods_siteself_detail gsd ");
		sql.append("left join crm_goods_siteself_order gso on gsd.order_id = gso.id ");
		sql.append(" where gsd.site_id = ? and gsd.status='0' ");
		sql.append(getQuery1(map));

		return Db.queryLong(sql.toString(), siteId);
	}

	public List<Record> getListOfSiteGoodsKeep(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sql = new StringBuffer("");
		sql.append(
				"select c.sort_num,c.icon as icons,concat(gsd.type,gsd.amount) as mx,gsd.good_number,gsd.good_name,gsd.type,truncate(gsd.amount,0) as amount,gsd.good_brand,gsd.good_model,gsd.good_category,gsd.unit,gsd.pay_money, ");
		sql.append("gsd.site_price,gsd.employe_price,gsd.customer_price,gsd.applicant, ");
		sql.append("gsd.apply_time,gsd.confirmor,gsd.confirm_time, gsd.create_time, ");
		sql.append("gso.customer_name,gso.customer_contact,gso.customer_address, gso.number,c.icon AS good_icon  ");
		sql.append("from crm_goods_siteself_detail gsd ");
		sql.append(" left join crm_goods_siteself c on gsd.good_id=c.id ");
		sql.append("left join crm_goods_siteself_order gso on gsd.order_id = gso.id ");
		sql.append(" where gsd.site_id = ? and gsd.status='0'    ");
		sql.append(getQuery1(map));
		sql.append(" order by gsd.create_time desc  ");
		if (page != null) {
			sql.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}

		return Db.find(sql.toString(), siteId);
	}

	private String getParamValue(Map<String, Object> map, String param) {
		Object value = map.get(param);
		return value == null ? null : ((String[]) map.get(param))[0];
	}

	private String getTrimmedParamValue(Map<String, Object> map, String param) {
		return org.apache.commons.lang.StringUtils.trim(getParamValue(map, param));
	}

	public String getQuery1(Map<String, Object> map) {
		if (map == null) {
			return "";
		}

		StringBuffer sf = new StringBuffer();

		String good_number = getTrimmedParamValue(map, "good_number");
		if (StringUtil.isNotBlank(good_number)) {
			sf.append(" and gsd.good_number like '%" + good_number + "%' ");
		}
		String employeName = getTrimmedParamValue(map, "employeName");
		if (StringUtil.isNotBlank(employeName)) {
			sf.append(" and (gsd.applicant like '%" + employeName + "%' and gsd.type in ('2','6','8') ) ");
		}

		String good_name = getTrimmedParamValue(map, "good_name");
		if (StringUtil.isNotBlank(good_name)) {
			sf.append(" and gsd.good_name like '%" + good_name + "%' ");
		}

		String good_category = getTrimmedParamValue(map, "good_category");
		if (StringUtil.isNotBlank(good_category)) {
			sf.append(" and gsd.good_category = '" + good_category + " ' ");
		}

		String mxtype = getTrimmedParamValue(map, "mxtype");
		if (StringUtil.isNotBlank(mxtype)) {
			sf.append(" and gsd.type  = '" + mxtype + "' ");
		}

		String order_number = getTrimmedParamValue(map, "order_number");
		if (StringUtil.isNotBlank(order_number)) {
			sf.append(" and gso.number like '%" + order_number + "%' ");
		}

		String applicant = getTrimmedParamValue(map, "applicant");
		if (StringUtil.isNotBlank(applicant)) {
			sf.append(" and gsd.applicant like '%" + applicant + "%' ");
		}

		String confirmor = getTrimmedParamValue(map, "confirmor");
		if (StringUtil.isNotBlank(confirmor)) {
			sf.append(" and gsd.confirmor like '%" + confirmor + "%' ");
		}

		String customer_contact = getTrimmedParamValue(map, "customer_contact");
		if (StringUtil.isNotBlank(customer_contact)) {
			sf.append(" and gso.customer_contact like '%" + customer_contact + "%' ");
		}

		String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
		if (StringUtil.isNotBlank(createTimeMin)) {// 接入时间
			sf.append(" and gsd.create_time >= '" + createTimeMin + " 00:00:00' ");
		}

		String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
		if (StringUtil.isNotBlank(createTimeMax)) {
			sf.append(" and gsd.create_time <= '" + createTimeMax + " 23:59:59' ");
		}

		return sf.toString();
	}

	public List<Record> getListOfEmpGoodsKeep(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sql = new StringBuffer("");
		sql.append(
				"SELECT m.order_number,a.*,truncate(a.amount,0) as amount,e.name AS empName,cs.name AS siteName,cns.name AS cnsName ,em.name as employeName,b.category as goodCategory,  ");
		sql.append(" b.site_price,b.employe_price,b.name as goodName,b.number as goodNumber,b.model as goodModel,b.icon,m.creator,m.number as orderNumber, ");
		sql.append(" m.customer_name,m.customer_contact,m.customer_address FROM `crm_goods_employe_owndetail` a  ");
		sql.append(" LEFT JOIN crm_employe e ON a.employe_id=e.id LEFT JOIN crm_goods_siteself b ON a.good_id=b.id  ");
		sql.append(" left join crm_goods_siteself_order m on m.id=a.order_id  ");
		sql.append(" LEFT JOIN crm_site cs ON cs.user_id=a.create_by  ");
		sql.append(" LEFT JOIN crm_non_serviceman cns ON cns.user_id=a.create_by  ");
		sql.append(" LEFT JOIN crm_employe em ON a.create_by = em.user_id WHERE a.site_id=?  AND a.status='0' and a.stocks_type='0'  ");
		sql.append(getQueryEmpList(map));
		sql.append(" order by a.create_time desc  ");
		if (page != null) {
			sql.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sql.toString(), siteId);
	}

	public List<Record> getListOfEmpGoodsKeepgm(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sql = new StringBuffer("");
		sql.append(
				"SELECT m.order_number,a.*,truncate(a.amount,0) as amount,e.name AS empName,cs.name AS siteName,cns.name AS cnsName ,em.name as employeName,b.category as goodCategory,  ");
		sql.append(" b.site_price,b.employe_price,b.name as goodName,b.number as goodNumber,b.model as goodModel,b.icon,m.creator,m.number as orderNumber, ");
		sql.append(" m.customer_name,m.customer_contact,m.customer_address FROM `crm_goods_employe_owndetail` a  ");
		sql.append(" LEFT JOIN crm_employe e ON a.employe_id=e.id LEFT JOIN crm_goods_siteself b ON a.good_id=b.id  ");
		sql.append(" left join crm_goods_siteself_order m on m.id=a.order_id  ");
		sql.append(" LEFT JOIN crm_site cs ON cs.user_id=a.create_by  ");
		sql.append(" LEFT JOIN crm_non_serviceman cns ON cns.user_id=a.create_by  ");
		sql.append(" LEFT JOIN crm_employe em ON a.create_by = em.user_id WHERE a.site_id=?  AND a.status='0' and a.stocks_type='1'  ");
		sql.append(getQueryEmpList(map));
		sql.append(" order by a.create_time desc  ");
		if (page != null) {
			sql.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		return Db.find(sql.toString(), siteId);
	}

	public long getCountOfEmpGoodsKeep(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sql = new StringBuffer("");
		sql.append(
				"SELECT count(*) FROM `crm_goods_employe_owndetail` a LEFT JOIN crm_employe e ON a.employe_id=e.id LEFT JOIN crm_goods_siteself b ON a.good_id=b.id left join crm_goods_siteself_order m on m.id=a.order_id LEFT JOIN crm_site cs ON cs.user_id=a.create_by  LEFT JOIN crm_non_serviceman cns ON cns.user_id=a.create_by   LEFT JOIN crm_employe em ON a.create_by = em.user_id WHERE a.site_id=?  AND a.status='0' and a.stocks_type='0'  ");
		sql.append(getQueryEmpList(map));
		return Db.queryLong(sql.toString(), siteId);
	}

	public long getCountOfEmpGoodsKeepgm(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuffer sql = new StringBuffer("");
		sql.append(
				"SELECT count(*) FROM `crm_goods_employe_owndetail` a LEFT JOIN crm_employe e ON a.employe_id=e.id LEFT JOIN crm_goods_siteself b ON a.good_id=b.id left join crm_goods_siteself_order m on m.id=a.order_id LEFT JOIN crm_site cs ON cs.user_id=a.create_by  LEFT JOIN crm_non_serviceman cns ON cns.user_id=a.create_by   LEFT JOIN crm_employe em ON a.create_by = em.user_id WHERE a.site_id=?  AND a.status='0' and a.stocks_type='1'  ");
		sql.append(getQueryEmpList(map));
		return Db.queryLong(sql.toString(), siteId);
	}

	public String getQueryEmpList(Map<String, Object> map) {
		if (map == null) {
			return "";
		}

		StringBuffer sf = new StringBuffer();

		String good_number = getTrimmedParamValue(map, "good_number");
		if (StringUtil.isNotBlank(good_number)) {
			sf.append(" and a.good_number like '%" + good_number + "%' ");
		}
		String employeName = getTrimmedParamValue(map, "employeName");
		if (StringUtil.isNotBlank(employeName)) {
			sf.append(" and a.employe_id = '" + employeName + "' ");
		}

		String good_name = getTrimmedParamValue(map, "good_name");
		if (StringUtil.isNotBlank(good_name)) {
			sf.append(" and b.name like '%" + good_name + "%' ");
		}

		String good_category = getTrimmedParamValue(map, "good_category");
		if (StringUtil.isNotBlank(good_category)) {
			sf.append(" and b.category = '" + good_category + " ' ");
		}

		String mxtype = getTrimmedParamValue(map, "mxtype");
		if (StringUtil.isNotBlank(mxtype)) {
			sf.append(" and a.type  = '" + mxtype + "' ");
		}

		String order_number = getTrimmedParamValue(map, "order_number");
		if (StringUtil.isNotBlank(order_number)) {
			sf.append(" and m.number like '%" + order_number + "%' ");
		}

		String applicant = getTrimmedParamValue(map, "applicant");
		if (StringUtil.isNotBlank(applicant)) {
			sf.append(" and e.name like '%" + applicant + "%' ");
		}

		String confirmor = getTrimmedParamValue(map, "confirmor");
		if (StringUtil.isNotBlank(confirmor)) {
			sf.append(" and (em.name like '%" + confirmor + "%' or cs.name like '%" + confirmor + "%' or cns.name like '%" + confirmor + "%')");
		}

		String customer_contact = getTrimmedParamValue(map, "customer_contact");
		if (StringUtil.isNotBlank(customer_contact)) {
			sf.append(" and m.customer_contact like '%" + customer_contact + "%' ");
		}

		String createTimeMin = getTrimmedParamValue(map, "createTimeMin");
		if (StringUtil.isNotBlank(createTimeMin)) {// 接入时间
			sf.append(" and a.create_time >= '" + createTimeMin + " 00:00:00' ");
		}

		String createTimeMax = getTrimmedParamValue(map, "createTimeMax");
		if (StringUtil.isNotBlank(createTimeMax)) {
			sf.append(" and a.create_time <= '" + createTimeMax + " 23:59:59' ");
		}

		return sf.toString();
	}
}
