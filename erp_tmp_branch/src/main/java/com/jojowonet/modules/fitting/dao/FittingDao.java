package com.jojowonet.modules.fitting.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingUsedRecord;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.util.SMSUtils;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;

/**
 * 备件DAO接口
 *
 * @author Ivan
 * @version 2017-05-20
 */
@Repository
public class FittingDao extends BaseDao<Fitting> {

	private static Logger logger = Logger.getLogger(SMSUtils.class);
	@Autowired
	private EmployeFittingDao employeFittingDao;

	public Page<Record> getPreVerificationList(Page<Record> page, String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append(
				"SELECT u.id,u.status,u.collection_flag,u.fitting_code as `code`,u.fitting_name as `name`,u.`fitting_version` as `version`,u.`type`,u.used_num,of.`status` AS old_status,u.`user_name` AS `fitting_user`,f.brand,f.site_price,f.employe_price,u.used_time,u.confirmor,u.check_time,u.order_number,u.customer_name,u.customer_mobile,u.customer_address,u.warranty_type,u.order_id")
				.append("FROM crm_site_fitting_used_record AS u").append("LEFT JOIN crm_site_fitting AS f").append("ON u.fitting_id=f.id")
				.append("LEFT JOIN crm_site_old_fitting AS of ").append("ON of.used_record_id=u.id  and of.status!='2' ").append("WHERE u.site_id='" + siteId + "'")
				.append("AND u.`status` in('1','3')").append("AND u.`type`!='2' ").append(buildFittingVerificationSearchCondition(map))
				.append(createOrderBy(map, "order by u.used_time desc")).append(pageLimit(page));
		List<Record> data = Db.find(kit.toString());
		page.setList(data);
		page.setCount(getPreVerificationCount(siteId, map));
		return page;
	}

	private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
		String sort = getParamValue(map, "sidx");
		String dir = getParamValue(map, "sord");
		return (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by `" + sort + "` " + dir) : defaultOrderBy;
	}

	public Page<Record> getVerificationHistoryList(Page<Record> page, String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append(
				"SELECT u.confirm_type as confirmType,u.collection_flag,u.collection_money,u.confirmed_money,u.id,u.fitting_code as `code`,u.fitting_name as `name`,u.`fitting_version` as `version`,u.`type`,u.used_num,of.`status` AS old_status,u.`user_name` AS `fitting_user`,f.brand,f.site_price,f.employe_price,u.used_time,u.confirmor,u.check_time,u.order_number,u.customer_name,u.customer_mobile,u.customer_address,u.warranty_type,u.order_id")
				.append("FROM crm_site_fitting_used_record AS u").append("LEFT JOIN crm_site_fitting AS f").append("ON u.fitting_id=f.id")
				.append("LEFT JOIN crm_site_old_fitting AS of").append("ON of.used_record_id=u.id and of.status!='2' ").append("WHERE u.site_id='" + siteId + "'")
				.append("AND u.`status` in ('2', '3')").append("AND u.`type`!='2'  ").append(buildFittingVerificationSearchCondition(map))
				.append(createOrderBy(map, "order by u.check_time desc")).append(pageLimit(page));
		List<Record> data = Db.find(kit.toString());
		page.setList(data);
		page.setCount(getVerificationHistoryCount(siteId, map));
		return page;
	}

	public long getPreVerificationCount(String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append("SELECT count(1) as cnt").append("FROM crm_site_fitting_used_record AS u").append("LEFT JOIN crm_site_fitting AS f")
				.append("ON u.fitting_id=f.id").append("LEFT JOIN crm_site_old_fitting AS of  ").append("ON of.used_record_id=u.id and of.status!='2' ")
				.append("WHERE u.site_id='" + siteId + "'").append("AND u.`status`in('1','3')").append("AND u.`type`!='2'  ").append(buildFittingVerificationSearchCondition(map));
		return Db.queryLong(kit.toString());
	}

	public long getVerificationHistoryCount(String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append("SELECT count(1) as cnt").append("FROM crm_site_fitting_used_record AS u").append("LEFT JOIN crm_site_fitting AS f")
				.append("ON u.fitting_id=f.id").append("LEFT JOIN crm_site_old_fitting AS of").append("ON of.used_record_id=u.id  and of.status!='2' ")
				.append("WHERE u.site_id='" + siteId + "'").append("AND u.`status`in ('2', '3')").append("AND u.`type`!='2'  ")
				.append(buildFittingVerificationSearchCondition(map));
		return Db.queryLong(kit.toString());
	}
	
	public Page<Record> getbalanceOfPaymentsList(Page<Record> page, String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append(
				"SELECT u.confirm_type as confirmType,u.collection_flag,IFNULL(u.collection_money,0) as collection_money,IFNULL(u.confirmed_money,0) AS confirmed_money,u.id,u.fitting_code as `code`,u.fitting_name as `name`,u.`fitting_version` as `version`,u.`type`,u.used_num,of.`status` AS old_status,u.`user_name` ,IFNULL(f.site_price,0) AS site_price,IFNULL(f.employe_price,0) AS employe_price ,f.customer_price,u.used_time,u.confirmor,u.check_time,u.order_number,u.customer_name,u.customer_mobile,u.customer_address,u.warranty_type,u.order_id")
				.append("FROM crm_site_fitting_used_record AS u")
				.append("LEFT JOIN crm_site_fitting AS f")
				.append("ON u.fitting_id=f.id")
				.append("LEFT JOIN crm_site_old_fitting AS of")
				.append("ON of.used_record_id=u.id and of.status!='2' ")
				.append("WHERE u.site_id='" + siteId + "'")
				.append("AND u.`status` = '2' ")
				.append("AND u.`type`!='2'  ")
				.append(buildFittingVerificationSearchCondition(map))
				.append(createOrderBy(map, "order by u.check_time desc"))
				.append(pageLimit(page));
		List<Record> data = Db.find(kit.toString());
		page.setList(data);
		page.setCount(getbalanceOfPaymentsCount(siteId, map));
		return page;
	}
	
	public long getbalanceOfPaymentsCount(String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append("SELECT count(1) as cnt")
				.append("FROM crm_site_fitting_used_record AS u")
				.append("LEFT JOIN crm_site_fitting AS f")
				.append("ON u.fitting_id=f.id")
				.append("LEFT JOIN crm_site_old_fitting AS of")
				.append("ON of.used_record_id=u.id  and of.status!='2' ")
				.append("WHERE u.site_id='" + siteId + "'")
				.append("AND u.`status` = '2' ")
				.append("AND u.`type`!='2'  ")
				.append(buildFittingVerificationSearchCondition(map));
		return Db.queryLong(kit.toString());
	}
	
	/*收支汇总*/
	public Page<Record> getfittingRetailvolumeList(Page<Record> page, String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit()
				.append("SELECT u.fitting_code ,u.fitting_name ,u.`fitting_version` ,")
				.append(" SUM(IF(confirm_type !=1,used_num,0)) AS retailvolume, ")
				.append(" SUM(IF(confirm_type=1,used_num,0))AS amountofuse ")
				.append(" FROM crm_site_fitting_used_record AS u  ")
				.append("WHERE u.site_id='" + siteId + "'")
				.append("AND u.`status` = '2' ")
				.append("AND u.`type`!='2'  ")
				.append(buildFittingVerificationSearchCondition(map))
				.append(" GROUP BY u.fitting_id  ")
				.append(pageLimit(page));
		List<Record> data = Db.find(kit.toString());
		page.setList(data);
		page.setCount(getfittingRetailvolumeCount(siteId, map));
		return page;
	}
	
	public long getfittingRetailvolumeCount(String siteId, Map<String, Object> map) {
		SqlKit kit = new SqlKit().append("SELECT count(1) as cnt from (")
		.append("SELECT u.fitting_code ,u.fitting_name ,u.`fitting_version` ")
		.append(" FROM crm_site_fitting_used_record AS u  ")
		.append("WHERE u.site_id='" + siteId + "'")
		.append("AND u.`status` = '2' ")
		.append("AND u.`type`!='2'  ")
		.append(buildFittingVerificationSearchCondition(map))
		.append(" GROUP BY u.fitting_id  ) a" );
		return Db.queryLong(kit.toString());
	}

	private String buildFittingVerificationSearchCondition(Map<String, Object> map) {
		if (map == null) {
			return "";
		}
	//	Map<String,Object> maps = (Map<String, Object>) map.get("maps");
		
		SqlKit sb = new SqlKit();
		String code = getTrimmedParamValue(map, "code");
		if (StringUtil.isNotBlank(code)) {
			sb.append("and u.fitting_code like '%" + code + "%'");
		}
		String name = getTrimmedParamValue(map, "name");
		if (StringUtil.isNotBlank(name)) {
			sb.append("and u.fitting_name like '%" + name + "%'");
		}

		String employe = getTrimmedParamValue(map, "emps");
		
		String[] emps = (String[]) map.get("emps[]");
		String[] empss = (String[]) map.get("empss");
		if (StringUtils.isNotBlank(employe)) {
			sb.append(" and u.user_name = '" + employe + "' ");
		} else if (emps != null) {
			sb.append(" and u.user_name in (" + StringUtil.joinInSql(emps) + ") ");
		} else if (empss != null) {
			sb.append(" and u.user_name in (" + StringUtil.joinInSql(empss) + ") ");
		}

		if (StringUtil.isNotBlank(getParamValue(map, "verificationUsedType"))) {
			if ("1".equals(getParamValue(map, "verificationUsedType"))) {
				sb.append("and u.`type`='1' and u.collection_flag='0' ");
			} else if ("11".equals(getParamValue(map, "verificationUsedType"))) {
				sb.append("and u.`type`='1' and u.collection_flag='1' ");
			} else {
				sb.append("and u.`type`='" + getParamValue(map, "verificationUsedType") + "' ");
			}
		}
		if (StringUtil.isNotBlank(getParamValue(map, "verificationType"))) {
			sb.append("and u.`confirm_type`='" + getParamValue(map, "verificationType") + "' ");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "fistatus"))) {
			sb.append("and u.`status`='" + getParamValue(map, "fistatus") + "'");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "oldStatus"))) {
			sb.append("and of.`status`='" + getParamValue(map, "oldStatus") + "'");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "fittingBrand"))) {
			sb.append("and f.`brand` like '%" + getParamValue(map, "fittingBrand") + "%'");
		}
		String orderNo = getTrimmedParamValue(map, "orderNo");
		if (StringUtil.isNotBlank(orderNo)) {
			sb.append("and u.`order_number` like '%" + orderNo + "%'");
		}
		String tel = getTrimmedParamValue(map, "tel");
		if (StringUtil.isNotBlank(tel)) {
			sb.append("and u.customer_mobile like '%" + tel + "%' ");
		}
		String customerName = getTrimmedParamValue(map, "customerName");
		if (StringUtil.isNotBlank(customerName)) {
			sb.append("and u.customer_name like '%" + customerName + "%'");
		}
		String customerAddress = getTrimmedParamValue(map, "customerAddress");
		if (StringUtil.isNotBlank(customerAddress)) {
			sb.append("and u.customer_address like '%" + customerAddress + "%'");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "datemax"))) {
			sb.append("and u.used_time <= '" + getParamValue(map, "datemax") + " 23:59:59'");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "datemmin"))) {
			sb.append("and u.used_time >= '" + getParamValue(map, "datemmin") + " 00:00:00'");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "hxmin"))) {
			sb.append("and u.check_time >= '" + getParamValue(map, "hxmin") + " 00:00:00'");
		}
		if (StringUtil.isNotBlank(getParamValue(map, "hxmax"))) {
			sb.append("and u.check_time <= '" + getParamValue(map, "hxmax") + " 23:59:59'");
		}
		if (StringUtils.isNotBlank(getParamValue(map, "warrantyType"))) {
			sb.append(" and u.warranty_type ='" + getParamValue(map, "warrantyType") + "' ");
		}
		return sb.toString();
	}

	private String getParamValue(Map<String, Object> map, String param) {
		Object value = map.get(param);
		return value == null ? null : ((String[]) map.get(param))[0];
	}

	private String getTrimmedParamValue(Map<String, Object> map, String param) {
		return StringUtils.trim(getParamValue(map, param));
	}

	private String pageLimit(Page page) {
		return "limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize();
	}

	/**
	 * 零售核销需确保核销类型是“3” / "4"
	 *
	 * @param r
	 *            配件使用记录
	 */
	public void saleVerification(FittingUsedRecord r) {
		String type = r.getType();
		if ("3".equals(type)) { // 工程师零售
			fittingVerification(r);
			empFittingVerification(r);
		} else if ("4".equals(type)) { // 网点零售
			fittingVerification(r);
		} else {
			throw new RuntimeException("invalid verification type found:" + type);
		}
	}

	/**
	 * 配件核销，修改 fitting 表中的出库未核销数量和销件数量。
	 *
	 * @param r
	 *            配件使用记录
	 */
	private void fittingVerification(FittingUsedRecord r) {
		double v = r.getUsedNum().setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
		String fittingVerificationSql = new SqlKit().append("update crm_site_fitting as f").append("set f.`cjnum`=f.`cjnum`+" + v).append(",f.`number`=f.`number`-" + v)
				.append("where f.id=:id").toString();

		SQLQuery sqlQuery = getSession().createSQLQuery(fittingVerificationSql);
		sqlQuery.setParameter("id", r.getFittingId());
		if (StringUtils.isNotBlank(r.getFittingId())) {
			sqlQuery.executeUpdate();
		} else {
			throw new RuntimeException("invalid fitting id");
		}
	}

	/**
	 * 配件核销，修改 crm_employe_fitting 表中的出库未核销数量和销件数量。
	 *
	 * @param r
	 *            配件使用记录
	 */
	private void empFittingVerification(FittingUsedRecord r) {
		logger.info(String.format("emp fitting verification,use record id=%s,emp fitting is=%s", r.getId(), employeFittingDao.getEmpFitting(r.getEmployeId(), r.getFittingId())));
		double v = r.getUsedNum().setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
		String empFittingVerificationSql = new SqlKit().append("update crm_employe_fitting as f").append("set f.`cjnum`=f.`cjnum`+" + v).append(",f.`number`=f.`number`-" + v)
				.append("where f.fitting_id=:fid and f.employe_id=:empid").toString();

		String employeId = r.getEmployeId();
		String fittingId = r.getFittingId();
		if (StringUtils.isNotBlank(employeId) && StringUtils.isNotBlank(fittingId)) {
			SQLQuery sqlQuery = getSession().createSQLQuery(empFittingVerificationSql);
			sqlQuery.setParameter("fid", fittingId);
			sqlQuery.setParameter("empid", employeId);
			sqlQuery.executeUpdate();
		}
	}

	/**
	 * 工单中使用配件核销。
	 *
	 * @param r
	 *            配件使用记录
	 */
	public void orderUsedFittingVerification(FittingUsedRecord r) {
		fittingVerification(r);
		empFittingVerification(r);
	}

	// 根据备件条码检索
	public Record getFittingCode(String code, String siteId) {
		if (StringUtils.isNotEmpty(code)) {
			StringBuilder sf = new StringBuilder();
			sf.append("SELECT sf.* FROM crm_site_fitting sf ");
			sf.append("  WHERE binary sf.code='").append(StringUtils.trim(code)).append("' AND sf.site_id=? and status ='1' limit 1 ");
			return Db.findFirst(sf.toString(), siteId);
		}
		return null;
	}

	public List<Record> getFittings(String siteId) {
		return Db.find(("SELECT sf.* FROM crm_site_fitting sf where sf.site_id='" + siteId + "' and status ='1' "));
	}

	// 查询库存数
	public Fitting getWarning(String id) {
		return getByHql("from Fitting where id=:p1", new Parameter(id));
	}

	/**
	 * 生成预警
	 *
	 * @param targetId:预警对象的ID
	 * @param targetName:预警对象的名称
	 * @param siteId:预警的siteId
	 * @param content:预警内容，参考UI原型
	 * @param type:1.工程师接单预警2.服务完成工单预警3.库存预警4.缺件预警
	 * @return 是否操作成功
	 */
	public boolean createAlarm(String targetId, String targetName, String siteId, String content, String type) {
		try {
			StringBuilder sb = new StringBuilder();
			sb.append(" insert into crm_site_alarm (id, site_id, type, target_id, target_name, content, create_time, status, is_cancel, is_send) ");
			sb.append(" values ('" + IdGen.uuid() + "', '" + siteId + "', '" + type + "', '" + targetId + "', '" + targetName + "', '" + content + "', '"
					+ DateUtils.getDate("yyyy-MM-dd HH:mm:ss") + "', '0', '0', '0') ");
			Db.update(sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * @return TRUE:可以插入 FALSE:不可以插入
	 */
	public boolean checkAlarmValid(String targetId, String siteId, String type) {
		Record rd = Db.findFirst(" select id, val from crm_site_alarm_setting a where a.site_id = ? and a.status = '0' and a.type = ? ", siteId, type);
		if (rd == null) {
			return false;
		} else {
			if (StringUtils.isBlank(rd.getStr("val"))) {
				return false;
			}
		}
		return Db.findFirst("select * from crm_site_alarm a where a.site_id = ? and target_id = ? and type = ? and status = '0' and a.is_cancel = '0' ", siteId, targetId,
				type) == null;
	}

	/**
	 * 预警设置
	 */
	public boolean checkAlarm(String targetId, String siteId, String type) {
		Record rd = Db.findFirst(" select id, val from crm_site_alarm_setting a where a.site_id = ? and a.status = '1' and a.type = ? ", siteId, type);
		if (rd == null) {
			return false;
		} else {
			return Db.findFirst("select * from crm_site_alarm a where a.site_id = ? and target_id = ? and type = ? and status = '0' and a.is_cancel = '0' limit 1", siteId,
					targetId, type) == null;
		}
	}

	/**
	 * 取消预警
	 *
	 * @param targetId:预警对象的ID
	 * @param siteId:预警的siteId
	 * @param type:1.工程师接单预警2.服务完成工单预警3.库存预警4.缺件预警
	 * @return 是否操作成功
	 */
	public boolean cancelAlarm(String targetId, String siteId, String type) {
		try {
			String sb = " update crm_site_alarm set is_cancel = '1' " + " where site_id = '" + siteId + "' and target_id = '" + targetId + "' and type = '" + type + "'  ";
			Db.update(sb);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public List<Record> findStockPage(Page<Record> page, Map<String, Object> params, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append(
				" SELECT a.id,a.name , a.code ,a.version,a.brand,a.suit_category as suitCategory,a.warning,a.audited_sum AS auditedSum, a.unit,a.type,a.site_price AS sitePrice,a.employe_price AS employePrice, ");
		sf.append(" a.customer_price AS customerPrice,a.location,a.supplier,sum(case when b.type = '1' then b.used_num else 0 end) as useNum ,a.`newest_keep_time` ");
		sf.append("FROM crm_site_fitting AS a LEFT JOIN  crm_site_fitting_used_record AS b ON b.fitting_id=a.id  ");
		sf.append(" WHERE a.site_id='" + siteId + "'  ");
		sf.append(getConditions(params));
		sf.append(" AND a.status='1' group by a.id ORDER BY a.create_time DESC,a.code desc");
		sf.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		return Db.find(sf.toString());
	}

	public String getConditions(Map<String, Object> params) {
		StringBuffer sf = new StringBuffer();
		if (StringUtil.checkParamsValid(params.get("code"))) {
			sf.append(" AND a.code LIKE '%" + params.get("code") + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("name"))) {
			sf.append(" AND a.name LIKE '%" + params.get("name") + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("brand"))) {
			sf.append(" AND a.brand LIKE '%" + params.get("brand") + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("version"))) {
			sf.append(" AND a.version LIKE '%" + params.get("version") + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("type"))) {
			sf.append(" AND a.type = '" + params.get("type") + "' ");
		}
		if (StringUtil.checkParamsValid(params.get("suitCategory"))) {
			sf.append(" AND a.suit_category = '" + params.get("suitCategory") + "' ");
		}
		if (StringUtil.checkParamsValid(params.get("supplier"))) {
			sf.append(" AND a.supplier = '" + params.get("supplier") + "' ");
		}
		if (StringUtil.checkParamsValid(params.get("location"))) {
			sf.append(" AND a.location LIKE '%" + params.get("location") + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("minWarning"))) {
			sf.append(" AND a.warning >=" + Double.valueOf(String.valueOf(params.get("minWarning"))) + " ");
		}
		if (StringUtil.checkParamsValid(params.get("maxWarning"))) {
			sf.append(" AND a.warning <=" + Double.valueOf(String.valueOf(params.get("maxWarning"))) + " ");
		}
		return sf.toString();
	}

	public Long stockCount(Map<String, Object> params, String siteId) {
		StringBuffer sf = new StringBuffer();
		sf.append("select count(*) from crm_site_fitting as a where a.site_id='" + siteId + "' ");
		sf.append(getConditions(params));
		sf.append("and a.status='1'  order by a.create_time desc");
		return Db.queryLong(sf.toString());
	}
}
