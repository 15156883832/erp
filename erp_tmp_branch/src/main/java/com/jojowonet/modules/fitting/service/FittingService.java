package com.jojowonet.modules.fitting.service;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.*;
import com.jojowonet.modules.fitting.entity.*;
import com.jojowonet.modules.fitting.service.excel.FittingImportExcelHandler;
import com.jojowonet.modules.fitting.utils.vo.FittingKeepInfo;
import com.jojowonet.modules.fmss.utils.DBUtils;
import com.jojowonet.modules.fmss.utils.DataUtils;
import com.jojowonet.modules.fmss.utils.DbBatchBean;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.order.dao.CrmOrder400Dao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.dao.UnitDao;
import com.jojowonet.modules.order.service.PushMessageService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.excelExt.ExcelReader;
import com.jojowonet.modules.sys.util.GuardUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 备件Service
 */
@Component
@Transactional(readOnly = true)
public class FittingService extends BaseService {

	private static final Logger logger = Logger.getLogger(FittingService.class);
	@Autowired
	private FittingDao fittingDao;
	@Autowired
	private FittingUsedRecordDao fittingUsedRecordDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private CrmOrder400Dao order400Dao;
	@Autowired
	private SiteFittingKeepDao skService;
	@Autowired
	private SiteFittingKeepService siteFittingKeepService;
	@Autowired
	private UnitDao unitDao;
	@Autowired
	private EmployeFittingDao employeFittingDao;
	@Autowired
	private EmpFittingKeepDao empFittingKeepDao;
	@Autowired
	private EmployeService employeService;
	@Autowired
	private FittingApplyPlanDao fittingApplyPlanDao;
	@Autowired
	private SiteFittingKeepDao siteFittingKeepDao;
	@Autowired
	private PushMessageService pushmessageService;

	public Fitting getById(String id) {
		return fittingDao.getByHql(" from Fitting a where a.id = :p1 ", new Parameter(id));
	}

	// 库存管理页面列表
	public Page<Fitting> findStockPage(Page<Fitting> page) {
		return fittingDao.find(page);
	}

	public Page<Record> getPreVerificationList(Page<Record> page, String siteId, Map<String, Object> map) {
		return fittingDao.getPreVerificationList(page, siteId, map);
	}

	public Page<Record> getVerificationHistoryList(Page<Record> page, String siteId, Map<String, Object> map) {
		return fittingDao.getVerificationHistoryList(page, siteId, map);
	}
	public Page<Record> getbalanceOfPaymentsList(Page<Record> page, String siteId, Map<String, Object> map) {
		return fittingDao.getbalanceOfPaymentsList(page, siteId, map);
	}
	public Page<Record> getfittingRetailvolumeList(Page<Record> page, String siteId, Map<String, Object> map) {
		return fittingDao.getfittingRetailvolumeList(page, siteId, map);
	}

	public long getPreVerificationCount(String siteId) {
		return fittingDao.getPreVerificationCount(siteId, null);
	}

	public long getVerificationHistoryCount(String siteId) {
		return fittingDao.getVerificationHistoryCount(siteId, null);
	}

	/*
	 * 批量核销
	 */
	@Transactional(rollbackFor = Exception.class)
	public Object batchVerification(String ids) {
		User user = UserUtils.getUser();
		if (StringUtils.isBlank(ids)) {
			return Result.fail("801", "missing verification");
		}
		String[] id = ids.split(",");
		if (id.length > 0) {
			for (String fid : id) {
				FittingUsedRecord verification = fittingUsedRecordDao.get(fid);
				if (verification == null) {
					return Result.fail("801", "missing verification");
				}
				String hxType = getHxType(verification.getType(), verification.getCollectionFlag()); // 核销类型
				BigDecimal money = verification.getCollectionMoney();// 收款金额
				String flag = verification.getCollectionFlag();
				String mone = "0";
				if (money != null) {
					int i = money.compareTo(BigDecimal.ZERO);
					if (i == 1) {
						flag = "1"; // 已收款
					}
					mone = money.toString();
				}
				// 调取之前核销逻辑；
				this.verify(user, fid, mone, flag, hxType);
			}
		}
		return Result.ok();
	}

	public static String getHxType(String type, String flag) {
		String hxtype = "1";
		if ("1".equals(type)) {
			if ("1".equals(flag)) {// 1已收款
				hxtype = "2";
			}
		} else if ("2".equals(type)) {
			hxtype = "5";
		} else if ("3".equals(type)) {
			hxtype = type;
		} else if ("4".equals(type)) {
			hxtype = type;
		}
		return hxtype;
	}

	/**
	 * Get verification detail info.
	 *
	 * @param id
	 *            verification id
	 */
	public Map<String, Object> getVerificationDetail(String id) {
		Map<String, Object> ret = new HashMap<>();
		FittingUsedRecord verification = fittingUsedRecordDao.get(id);
		ret.put("verification", verification);
		if (verification == null) {
			return ret;
		}

		String orderId = verification.getOrderId();
		if (StringUtil.isNotBlank(orderId)) {
			Record order = orderDao.findOrderByIdIfHistory(orderId, verification.getSiteId());
			if (order == null) {
				Record order400Rd = order400Dao.findOrder400ById(orderId, verification.getSiteId());
				if (order400Rd != null) {
					ret.put("order400Rd", order400Rd.getColumns());
				}
			}
			ret.put("order", order);
		}

		String fittingId = verification.getFittingId();
		if (StringUtil.isNotBlank(fittingId)) {
			Fitting fitting = fittingDao.get(fittingId);
			ret.put("fitting", fitting);
		}

		Record oldFitting = Db.findFirst("select * from crm_site_old_fitting where used_record_id=? and `status`!='2'", verification.getId());
		if (oldFitting != null) {
			ret.put("oldFitting", oldFitting.getColumns());
		}
		return ret;
	}

	/**
	 * @param user
	 *            当前用户
	 * @param id
	 *            使用记录的 id
	 */
	@Transactional(rollbackFor = Exception.class)
	public Object verify(User user, String id, String money, String flag, String hxType) {
		FittingUsedRecord verification = fittingUsedRecordDao.get(id);
		if (verification == null) {
			return Result.fail("801", "missing verification");
		}

		if ("2".equals(verification.getStatus())) {
			logger.error(String.format("used record[%s] has already been verified, request blocked", verification.getId()));
			return Result.fail("802", "verification already done");
		}

		BigDecimal usedNum = verification.getUsedNum();
		if (usedNum == null) {
			logger.error(String.format("used record[%s] used num is invalid, request rejected", verification.getId()));
			return Result.fail("802", "verification used num invalid");
		}

		// 保存操作
		this.saveCollection(id, money, flag, hxType);

		verification.setCheckTime(new Date());
		verification.setConfirmorId(user.getId());
		verification.setConfirmor(CrmUtils.getCreateName(user));
		verification.setStatus("2");

		String fittingId = verification.getFittingId();
		if (StringUtil.isBlank(fittingId)) {
			logger.error(String.format("used record[%s] fitting id  is null, request rejected", verification.getId()));
		} else {
			logger.info(String.format("about to verify fitting use, fitting=%s", fittingDao.get(fittingId)));
		}

		// 根据核销类型的不同，执行不同的操作
		if ("1".equals(verification.getType())) {
			// 工单中使用
			logger.info("do order used verification: " + verification);
			fittingDao.orderUsedFittingVerification(verification);
		} else if ("2".equals(verification.getType())) {
			// 备件归还
			throw new RuntimeException("invalid verification type: return");
		} else if ("3".equals(verification.getType()) || "4".equals(verification.getType())) {
			// 零售
			logger.info("do sales verification: " + verification);
			fittingDao.saleVerification(verification);
		} else {
			throw new RuntimeException("invalid verification found: " + verification.getType());
		}

		return Result.ok();
	}

	@Transactional(rollbackFor = Exception.class)
	public Object saveCollection(String id, String money, String flag, String hxType) {
		FittingUsedRecord verification = fittingUsedRecordDao.get(id);
		// 核销类型
		verification.setConfirmType(hxType);
		if (verification == null) {
			return Result.fail("801", "missing verification");
		}

		if (!("0".equals(flag) || "1".equals(flag))) {
			return Result.fail("801", "invalid flag");
		}

		if ("0".equals(flag)) {
			verification.setCollectionFlag(flag);
			verification.setConfirmedMoney(BigDecimal.valueOf(0.00));
			fittingUsedRecordDao.save(verification);
			return Result.ok();
		}

		double m;
		try {
			m = Double.valueOf(StringUtils.trim(money));
		} catch (Exception e) {
			return Result.fail("802", "invalid money");
		}
		if (m < 0) {
			return Result.fail("802", "invalid money");
		}
		verification.setCollectionFlag(flag);
		verification.setConfirmedMoney(BigDecimal.valueOf(m));
		fittingUsedRecordDao.save(verification);
		return Result.ok();
	}

	/**
	 * 通过使用记录id找到旧件记录
	 *
	 * @param id
	 *            使用记录id
	 */
	public Object stockOldFitting(String id) {
		FittingUsedRecord verification = fittingUsedRecordDao.get(id);
		if (verification == null) {
			return Result.fail("801", "missing verification");
		}

		Record oldFitting = Db.findFirst("select * from crm_site_old_fitting where used_record_id=? and `status`!='2'", verification.getId());
		if (oldFitting != null) {
			Db.update("update crm_site_old_fitting set `status`='1' where used_record_id=?", verification.getId());
		}
		return Result.ok();
	}

	// 库存管理页面列表
	public Page<Record> findStockPage(Page<Record> page, Map<String, Object> params, String siteId) {
		List<Record> list = fittingDao.findStockPage(page, params, siteId);
		Long count = fittingDao.stockCount(params, siteId);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 库存管理页面列表
	public Page<Fitting> findExportedStockPage(Page<Fitting> page, Map<String, Object> params, String siteId) {
		DetachedCriteria dc = fittingDao.createDetachedCriteria();
		if (StringUtil.checkParamsValid(params.get("code"))) {
			dc.add(Restrictions.like("code", "%" + params.get("code") + "%"));
		}
		if (StringUtil.checkParamsValid(params.get("name"))) {
			dc.add(Restrictions.like("name", "%" + params.get("name") + "%"));
		}
		if (StringUtil.checkParamsValid(params.get("brand"))) {
			dc.add(Restrictions.like("brand", "%" + params.get("brand") + "%"));
		}
		if (StringUtil.checkParamsValid(params.get("type"))) {
			dc.add(Restrictions.eq("type", params.get("type")));
		}
		if (StringUtil.checkParamsValid(params.get("suitCategory"))) {
			dc.add(Restrictions.eq("suitCategory", params.get("suitCategory")));
		}
		if (StringUtil.checkParamsValid(params.get("supplier"))) {
			dc.add(Restrictions.eq("supplier", params.get("supplier")));
		}
		if (StringUtil.checkParamsValid(params.get("location"))) {
			dc.add(Restrictions.like("location", "%" + params.get("location") + "%"));
		}
		if (StringUtil.checkParamsValid(params.get("minWarning"))) {
			dc.add(Restrictions.ge("warning", Double.valueOf(String.valueOf(params.get("minWarning")))));
		}
		if (StringUtil.checkParamsValid(params.get("maxWarning"))) {
			dc.add(Restrictions.le("warning", Double.valueOf(String.valueOf(params.get("maxWarning")))));
		}
		dc.add(Restrictions.eq("siteId", siteId));
		dc.add(Restrictions.eq("status", "1"));
		dc.addOrder(org.hibernate.criterion.Order.desc("createTime"));
		return fittingDao.find(page, dc);
	}

	public List<Fitting> findExportedStockPageforexport(String siteId) {
		DetachedCriteria dc = fittingDao.createDetachedCriteria();
		dc.add(Restrictions.eq("siteId", siteId));
		dc.add(Restrictions.eq("status", "1"));
		dc.addOrder(org.hibernate.criterion.Order.desc("createTime"));
		return fittingDao.find(dc);
	}

	public Page<Record> findEmpFittingPage(Page<Record> page, Map<String, Object> params) {
		List<Record> list = getEmpFittingList(page, params);
		/*
		 * List<Record> rd = Lists.newArrayList(); for (Record re : rds) { if
		 * (re.getBigDecimal("su").intValue() > 0) { rd.add(re); } }
		 */
		Long count = getEmpFittingCount(params);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Record> getDefaultEmployeList(String siteId) {
		return Db.find("select a.* from crm_employe a where a.status in ('0','3') and a.site_id=? order by a.status asc", siteId);
	}

	public Page<Record> findWaitReturnPage(Page<Record> page, Map<String, Object> params) {
		List<Record> list = getWaitReturnList(page.getPageSize(), page.getPageNo(), params);
		Long count = getWaitReturnCount(params);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> getEmpKeepPage(Page<Record> page, Map<String, Object> params) {
		List<Record> list = getEmpFittingItemsList(page, params);
		Long count = getEmpFittingItemsCount(params);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	// 待返还信息列表
	public List<Record> getWaitReturnList(int pageSize, int pageNo, Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select a.id, b.code, b.name, b.version, a.used_num, a.employe_id, a.creator as empName,c.name as empNameR, a.status, a.used_time ");
		sb.append(" from crm_site_fitting_used_record a  ");
		sb.append(" left join crm_site_fitting b on b.id = a.fitting_id and b.site_id = a.site_id  ");
		sb.append(" left join crm_employe c on c.id = a.employe_id and c.site_id = a.site_id ");
		sb.append(" where a.site_id = ? and a.type = '2' and a.status='" + 1 + "'");
		sb.append(generateWaitReturnFilter(params));
		sb.append(createOrderBy(params, "order by used_time desc"));
		sb.append(" limit " + pageSize + " offset " + (pageNo - 1) * pageSize);
		return Db.find(sb.toString(), params.get("siteId"));
	}

	// 表头排序
	private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
		String sort = null;
		String dir = null;
		if (StringUtils.isNotBlank(map.get("sidx").toString())) {
			sort = map.get("sidx").toString();
		}
		if (StringUtils.isNotBlank(map.get("sord").toString())) {
			dir = map.get("sord").toString();
		}
		return (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by '" + sort + "' " + dir) : defaultOrderBy;
	}

	// 待返还查询条件
	private String generateWaitReturnFilter(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		if (StringUtil.checkParamsValid(params.get("code"))) {
			sb.append(" and b.code like '%" + String.valueOf(params.get("code")) + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("name"))) {
			sb.append(" and b.name like '%" + String.valueOf(params.get("name")) + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("empId"))) {
			sb.append(" and a.employe_id='" + String.valueOf(params.get("empId")) + "' ");
		}
		if (StringUtil.checkParamsValid(params.get("version"))) {
			sb.append(" and b.version like '%" + String.valueOf(params.get("version")) + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("employeName"))) {
			sb.append(" and a.creator like '%" + String.valueOf(params.get("employeName")) + "%' ");
		}
		if (StringUtil.checkParamsValid(params.get("usedTimeMin"))) {
			sb.append(" and a.used_time >= '" + String.valueOf(params.get("usedTimeMin")) + "' ");
		}
		if (StringUtil.checkParamsValid(params.get("usedTimeMax"))) {
			sb.append(" and a.used_time <= '" + String.valueOf(params.get("usedTimeMax")) + "23:59:59' ");
		}
		return sb.toString();
	}

	// 待返还记录条数
	public Long getWaitReturnCount(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(1) from crm_site_fitting_used_record a  ");
		sb.append(" left join crm_site_fitting b on b.id = a.fitting_id and b.site_id = a.site_id ");
		sb.append(" where a.site_id = ? and a.type = '2' and a.status='1' ");
		sb.append(generateWaitReturnFilter(params));
		return Db.queryLong(sb.toString(), params.get("siteId"));
	}

	public Long getWaitReturnCount1(String siteId) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(1) from crm_site_fitting_used_record a  ");
		sb.append(" left join crm_site_fitting b on b.id = a.fitting_id and b.site_id = a.site_id ");
		sb.append(" where a.site_id = ? and a.type = '2' and a.status='1' ");
		return Db.queryLong(sb.toString(), siteId);
	}

	// 待返还（确认入库）【根据id修改】
	public void doDFH(String fittingId, double num) {
		String sql = null;
		try {
			sql = "update crm_site_fitting set warning=warning+:w,number=number-:n where id=:id";
			SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(sql);
			sqlQuery.setParameter("w", num);
			sqlQuery.setParameter("n", num);
			sqlQuery.setParameter("id", fittingId);
			sqlQuery.executeUpdate();
		} catch (Exception e) {
			logger.error("doDFH error,sql=" + sql, e);
			throw new RuntimeException(e);
		}
	}

	public Fitting getId(String id) {
		return fittingDao.getByHql(" from Fitting a where a.id = :p1", new Parameter(id));
	}

	public Fitting getByCode(String fittingCode, String siteId) {
		return fittingDao.getByHql(" from Fitting a where a.code = :p1 and a.siteId= :p2 and a.status='1'", new Parameter(fittingCode, siteId));
	}

	public Record getFittingCode(String code, String siteId) {
		return fittingDao.getFittingCode(code, siteId);
	}

	public List<Record> getFittings(String siteId) {
		return fittingDao.getFittings(siteId);
	}

	public void save(Fitting fi) {
		fittingDao.save(fi);
	}

	public Fitting get(String id) {
		return getById(id);
	}

	// 工程师库存列表
	public Record getEmpFittingListSum(Page<Record> page, Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(
				"SELECT SUM(ttt.ct) AS h1,SUM(ttt.su) AS h2,SUM(ttt.employe_number) AS h3,SUM(ttt.sallSitePrice) AS h4,SUM(ttt.semployeSitePrice) AS h5,SUM(ttt.hallSitePrice) AS h6,SUM(ttt.hemployeSitePrice) AS h7,SUM(ttt.usedNum) AS h8  FROM (");
		sb.append(" select a.id as employe_id,a.status as estatus, a.name,et.usedNum, ifnull(ot.ct, 0) as ct, ifnull(ot.su, 0) as su,\r\n"
				+ "  IFNULL(ot.employe_number, 0) AS employe_number,ROUND(IFNULL(ot.sallSitePrice, 0),2) AS sallSitePrice, ROUND(IFNULL(ot.semployeSitePrice, 0),2) AS semployeSitePrice, ROUND(IFNULL(ot.hallSitePrice, 0),2) AS hallSitePrice,ROUND(IFNULL(ot.hemployeSitePrice, 0),2) AS hemployeSitePrice from crm_employe a    LEFT JOIN (SELECT us.*,SUM(used_num) AS usedNum FROM  crm_site_fitting_used_record us WHERE  us.status='1' AND us.site_id=? AND us.type='2'  GROUP BY us.employe_id) AS et ON et.employe_id=a.id\r\n"
				+ " left join ( ");
		sb.append(
				" select a.employe_id, count(case when a.warning>0 then 1 end) as ct, sum(a.number) as employe_number,sum(a.warning) as su,SUM(a.warning * f.site_price) AS sallSitePrice,SUM(a.warning * f.employe_price) AS semployeSitePrice,SUM(a.number * f.site_price) AS hallSitePrice,SUM(a.number * f.employe_price) AS hemployeSitePrice from crm_employe_fitting a LEFT JOIN crm_site_fitting f ON a.fitting_id=f.id ");
		sb.append(" where a.site_id = ? and a.status = '1' ");

		sb.append(" group by a.employe_id ");
		sb.append(" ) ot on ot.employe_id = a.id ");
		sb.append(" and a.site_id = ? where ifnull(ot.su, 0) > 0 ");
		sb.append(empFittingCOnditions(params));
		// sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() -
		// 1) * page.getPageSize());
		sb.append(") AS ttt");
		return Db.findFirst(sb.toString(), params.get("siteId"), params.get("siteId"), params.get("siteId"));
	}

	// 工程师库存列表
	public List<Record> getEmpFittingList(Page<Record> page, Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append("select a.id as employe_id,a.status as estatus, a.name,et.usedNum, ifnull(ot.ct, 0) as ct, ifnull(ot.su, 0) as su,\r\n"
				+ "  IFNULL(ot.employe_number, 0) AS employe_number,ROUND(IFNULL(ot.sallSitePrice, 0),2) AS sallSitePrice, ROUND(IFNULL(ot.semployeSitePrice, 0),2) AS semployeSitePrice, ROUND(IFNULL(ot.hallSitePrice, 0),2) AS hallSitePrice,ROUND(IFNULL(ot.hemployeSitePrice, 0),2) AS hemployeSitePrice from crm_employe a    LEFT JOIN (SELECT us.*,SUM(used_num) AS usedNum FROM  crm_site_fitting_used_record us WHERE  us.status='1' AND us.site_id=? AND us.type='2'  GROUP BY us.employe_id) AS et ON et.employe_id=a.id\r\n"
				+ " left join ( ");
		sb.append(
				" select a.employe_id, count(case when a.warning>0 then 1 end) as ct, sum(a.number) as employe_number,sum(a.warning) as su,SUM(a.warning * f.site_price) AS sallSitePrice,SUM(a.warning * f.employe_price) AS semployeSitePrice,SUM(a.number * f.site_price) AS hallSitePrice,SUM(a.number * f.employe_price) AS hemployeSitePrice from crm_employe_fitting a LEFT JOIN crm_site_fitting f ON a.fitting_id=f.id ");
		sb.append(" where a.site_id = ? and a.status = '1' ");

		sb.append(" group by a.employe_id ");
		sb.append(" ) ot on ot.employe_id = a.id ");
		sb.append(" and a.site_id = ? where ifnull(ot.su, 0) > 0 ");
		sb.append(empFittingCOnditions(params));
		return Db.find(sb.toString(), params.get("siteId"), params.get("siteId"), params.get("siteId"));
	}

	// 工程师库存列表
	public Long getEmpFittingCount(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(*) from crm_employe a left join ( ");
		sb.append(" select a.employe_id, count(case when a.warning>0 then 1 end) as ct, sum(a.number) as employe_number,sum(a.warning) as su from crm_employe_fitting a ");
		sb.append(" where a.site_id = ? and a.status = '1' ");

		sb.append(" group by a.employe_id ");
		sb.append(" ) ot on ot.employe_id = a.id ");
		sb.append(" and a.site_id = ? where ifnull(ot.su, 0) > 0 ");
		sb.append(empFittingCOnditions(params));
		return Db.queryLong(sb.toString(), params.get("siteId"), params.get("siteId"));
	}

	public String empFittingCOnditions(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		if (params != null) {
			if (params.get("empIds") != null && StringUtils.isNotBlank(params.get("empIds").toString())) {
				sb.append(" and a.id='" + params.get("empIds") + "'");
			}
		}
		return sb.toString();
	}

	// 零售
	@Transactional
	public String doLS(Map<String, Object> params) {
		// double w = Double.parseDouble(params.get("warning").toString());//库存数量
		double s = Double.parseDouble(params.get("saleAmount").toString());// 售出数量

		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String date = fm.format(now);// 最新出库时间

		// double warning = w - s;//售出后库存数量
		String id = params.get("id").toString();
		String sql = "select * from crm_site_fitting where id='" + id + "' ";
		Record re = Db.findFirst(sql);
		if (re.getBigDecimal("warning") != null && !"".equals(re.getBigDecimal("warning"))) {
			if (s > re.getBigDecimal("warning").doubleValue()) {
				return "noEnough";// 库存数量不足
			} else {
				SQLQuery sqlQuery = fittingDao.getSession()
						.createSQLQuery("update crm_site_fitting set warning=warning-" + s + ",number=number+" + s + ",newest_keep_time='" + date + "'  where id='" + id + "'");
				sqlQuery.executeUpdate();
				return "succ";
			}
		}
		return "noEnough";
	}

	// 调整库存
	@Transactional(rollbackFor = Exception.class)
	public void doTZKC(Map<String, Object> params, Fitting fi, String name) {
		if (fi == null || org.apache.commons.lang.StringUtils.isBlank(fi.getId())) {
			throw new IllegalArgumentException("fitting not found");
		}

		Double warn = Double.valueOf(params.get("adj_num").toString());
		Double adjustCount = warn - fi.getWarning();

		if (adjustCount == 0) {
			return;
		}

		// crm_site_fitting表
		if (adjustCount > 0) {
			// 入库总数加
			SqlKit kit = new SqlKit().append("update crm_site_fitting").append("set `warning`=:warn,").append("total=total+" + adjustCount).append("where id=:id and `status`='1'");
			SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(kit.toString());
			sqlQuery.setParameter("warn", warn);
			sqlQuery.setParameter("id", fi.getId());
			sqlQuery.executeUpdate();
		} else {
			// 核销总数加
			SqlKit kit = new SqlKit().append("update crm_site_fitting").append("set `warning`=:warn,").append("cjnum=cjnum+" + Math.abs(adjustCount))
					.append("where id=:id and `status`='1'");
			SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(kit.toString());
			sqlQuery.setParameter("warn", warn);
			sqlQuery.setParameter("id", fi.getId());
			sqlQuery.executeUpdate();
		}

		SiteFittingKeep fk = new SiteFittingKeep();
		fk.setNumber(CrmUtils.no());
		fk.setType("3");
		fk.setFittingId(fi.getId());
		fk.setFittingCode(fi.getCode());
		fk.setFittingName(fi.getName());
		fk.setAmount(adjustCount);
		if (fi.getSitePrice() != null) {
			fk.setPrice(fi.getSitePrice());
		}
		if (fi.getEmployePrice() != null) {
			fk.setEmployePrice(fi.getEmployePrice());
		}
		if (fi.getCustomerPrice() != null) {
			fk.setCustomerPrice(fi.getCustomerPrice());
		}

		fk.setApplicant(name);// 申请人/领用人
		fk.setConfirmor(name);// 确认人，即为信息员/网点
		fk.setRemarks(params.get("tkccresource").toString());
		fk.setSiteId(fi.getSiteId());
		fk.setCreateBy(UserUtils.getUser().getId());
		skService.save(fk);
		if (fi.getAlertNum() != null && fi.getWarning() != null && fi.getWarning() <= fi.getAlertNum()) {
			if (fittingDao.checkAlarmValid(fi.getId(), fi.getSiteId(), "3")) {
				String content = String.format("\"%s、%s\"", fi.getName(), fi.getCode()) + "  剩余库存" + fi.getWarning() + fi.getUnit() + "，请注意及时补充库存数量！";
				fittingDao.createAlarm(fi.getId(), fi.getCode(), fi.getSiteId(), content, "3");
			}
		}
	}

	/**
	 * 手动入库
	 */
	@Transactional(rollbackFor = Exception.class)
	public String dosdruku(String data, String remarks, User user) {
		String[] two = data.split("-");
		for (int i = 0; i < two.length; i++) {
			two[i] = two[i].replace(" ", "");
			String[] f = two[i].split(",");
			if (f.length != 3) {
				String mes = "";
				for (int j = 0; j < f.length; j++) {
					mes += f[i] + "】【";
				}
				logger.info("手动入库错误" + mes);
				return "201";
			}
			String id = f[0];// 获取id
			double num = Double.parseDouble(f[1]);// 获取入库数量
			double price = -1;
			if (!"no".equals(f[2])) {
				price = Double.parseDouble(f[2]);// 获取最新入库价格
			}
			StringBuffer sb = new StringBuffer();
			sb.append("update crm_site_fitting set `warning`=`warning`+" + num + ",`total`=`total`+" + num + " ");
			if (price != -1) {
				sb.append("  ,`site_price`=" + price + "  ");
			}
			sb.append(" where id='" + id + "' ");
			SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(sb.toString());
			sqlQuery.executeUpdate();

			String op = CrmUtils.getUserXM();
			Fitting fitting = getId(id);
			FittingKeepInfo keepInfo = new FittingKeepInfo();
			keepInfo.setPrice(price);
			keepInfo.setAmount(num);
			keepInfo.setConfirmor(op);
			keepInfo.setApplicant(op);
			keepInfo.setType(SiteFittingKeepService.TYPE_STOCK_IN);
			siteFittingKeepService.createSiteFittingKeep(fitting, remarks, keepInfo, user);

			this.cancelStockAlert(id);
		}
		return "ok";
	}

	/**
	 * 备件申请中入库
	 */
	@Transactional(rollbackFor = Exception.class)
	public String putInStock(String fittingId, String applyPlanId, Double num, User user,String planMarks) {
		StringBuffer sb = new StringBuffer();
		sb.append("update crm_site_fitting set `warning`=`warning`+" + num + ",`total`=`total`+" + num + " ");
		sb.append(" where id='" + fittingId + "' ");
		SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(sb.toString());
		sqlQuery.executeUpdate();

		String op = CrmUtils.getUserXM();
		Fitting fitting = getId(fittingId);
		FittingKeepInfo keepInfo = new FittingKeepInfo();
		keepInfo.setAmount(num);
		keepInfo.setConfirmor(op);
		keepInfo.setApplicant(op);
		keepInfo.setType(SiteFittingKeepService.TYPE_STOCK_IN);
		keepInfo.setPrice(fitting.getSitePrice());
		String id = siteFittingKeepService.createSiteFittingKeepTwo(fitting, keepInfo, user);

		FittingApplyPlan applyPlan = fittingApplyPlanDao.get(applyPlanId);
		applyPlan.setFittingKeepId(id);
		applyPlan.setStatus("2");
		//修改备注信息
		applyPlan.setMarks(planMarks);
		fittingApplyPlanDao.save(applyPlan);
		return "ok";
	}

	// 工程师库存明细（单个工程师库存信息以及所有工程师的库存信息）
	public List<Record> getEmpFittingItems(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(
				" select p.allNum,a.newest_keep_time,a.employe_id,a.number as employe_number,a.id,e.name as empName,b.site_price as sitePrice,b.customer_price,b.code, b.name, b.version, a.warning, b.unit, b.type, a.suit_brand, a.suit_category ");
		sb.append(" from crm_employe_fitting a ");
		sb.append(" left join crm_employe e on e.id=a.employe_id");
		sb.append(" left join crm_site_fitting b on b.id = a.fitting_id and b.site_id = a.site_id and b.status = '1' ");
		sb.append(" left join (SELECT m.employe_id,m.fitting_id,SUM(used_num) AS allNum FROM crm_site_fitting_used_record m WHERE m.status='1' AND m.type='2' ");
		if (StringUtil.checkParamsValid(params.get("id")) && !"all".equalsIgnoreCase(String.valueOf(params.get("id")))) {// 单个工程师配件库存信息查询
			sb.append(" and m.employe_id = '").append(String.valueOf(params.get("id"))).append("' ");
		}
		sb.append(" GROUP BY m.fitting_id,m.employe_id) AS p ON a.fitting_id = p.fitting_id AND a.employe_id = p.employe_id  ");
		sb.append(" where a.site_id = ?  ");
		sb.append(searchTJ(params));
		if (StringUtil.checkParamsValid(params.get("id")) && !"all".equalsIgnoreCase(String.valueOf(params.get("id")))) {// 单个工程师配件库存信息查询
			sb.append(" and a.employe_id = '").append(String.valueOf(params.get("id"))).append("' ");
		}
		sb.append(" and a.status = '1' ");
		sb.append("  and ((a.warning IS NOT NULL AND a.warning > '0') OR (p.allNum IS NOT NULL AND p.allNum > '0') OR (a.number IS NOT NULL AND  a.number > '0'))");// 工程师库存、备件待审核数、待返还数有一项不为空且大于0时就显示，否则不显示
		return Db.find(sb.toString(), params.get("siteId"));
	}

	// 工程师库存明细（单个工程师库存信息以及所有工程师的库存信息）
	public List<Record> getEmpFittingItemsList(Page<Record> page, Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(
				" select p.allNum,a.fitting_id,e.status as estatus,DATE_FORMAT(a.newest_keep_time,'%Y-%m-%d %H:%i:%s') as newestKeepTime ,a.employe_id,a.number as employe_number,a.id,e.name as empName,b.site_price as sitePrice,b.customer_price,b.code, b.name, b.version, a.warning, b.unit, b.type, a.suit_brand, a.suit_category ");
		sb.append(" from crm_employe_fitting a ");
		sb.append(" left join crm_employe e on e.id=a.employe_id");
		sb.append(" left join crm_site_fitting b on b.id = a.fitting_id and b.site_id = a.site_id and b.status = '1' ");
		sb.append(" left join (SELECT m.employe_id,m.fitting_id,SUM(used_num) AS allNum FROM crm_site_fitting_used_record m WHERE m.status='1' AND m.type='2' ");
		if (StringUtil.checkParamsValid(params.get("id")) && !"all".equalsIgnoreCase(String.valueOf(params.get("id")))) {// 单个工程师配件库存信息查询
			sb.append(" and m.employe_id = '").append(String.valueOf(params.get("id"))).append("' ");
		}
		sb.append(" GROUP BY m.fitting_id,m.employe_id) AS p ON a.fitting_id = p.fitting_id AND a.employe_id = p.employe_id  ");
		sb.append(" where a.site_id = ?  ");
		sb.append(searchTJ(params));
		if (StringUtil.checkParamsValid(params.get("id")) && !"all".equalsIgnoreCase(String.valueOf(params.get("id")))) {// 单个工程师配件库存信息查询
			sb.append(" and a.employe_id = '").append(String.valueOf(params.get("id"))).append("' ");
		}
		sb.append(" and a.status = '1' and a.employe_id is not null and a.employe_id !='' ");
		sb.append("  and ((a.warning IS NOT NULL AND a.warning > '0') OR (p.allNum IS NOT NULL AND p.allNum > '0') OR (a.number IS NOT NULL AND  a.number > '0'))");// 工程师库存、备件待审核数、待返还数有一项不为空且大于0时就显示，否则不显示
		sb.append(" order by a.employe_id asc,a.create_time asc");
		sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		return Db.find(sb.toString(), params.get("siteId"));
	}

	// 工程师库存明细（单个工程师库存信息以及所有工程师的库存信息）
	public Long getEmpFittingItemsCount(Map<String, Object> params) {
		StringBuilder sb = new StringBuilder("");
		sb.append(" select count(*) ");
		sb.append(" from crm_employe_fitting a ");
		sb.append(" left join crm_employe e on e.id=a.employe_id");
		sb.append(" left join crm_site_fitting b on b.id = a.fitting_id and b.site_id = a.site_id and b.status = '1' ");
		sb.append(" left join (SELECT m.employe_id,m.fitting_id,SUM(used_num) AS allNum FROM crm_site_fitting_used_record m WHERE m.status='1' AND m.type='2' ");
		if (StringUtil.checkParamsValid(params.get("id")) && !"all".equalsIgnoreCase(String.valueOf(params.get("id")))) {// 单个工程师配件库存信息查询
			sb.append(" and m.employe_id = '").append(String.valueOf(params.get("id"))).append("' ");
		}
		sb.append(" GROUP BY m.fitting_id,m.employe_id) AS p ON a.fitting_id = p.fitting_id AND a.employe_id = p.employe_id  ");
		sb.append(" where a.site_id = ?  ");
		sb.append(searchTJ(params));
		if (StringUtil.checkParamsValid(params.get("id")) && !"all".equalsIgnoreCase(String.valueOf(params.get("id")))) {// 单个工程师配件库存信息查询
			sb.append(" and a.employe_id = '").append(String.valueOf(params.get("id"))).append("' ");
		}
		sb.append(" and a.status = '1' and a.employe_id is not null and a.employe_id !='' ");
		sb.append("  and ((a.warning IS NOT NULL AND a.warning > '0') OR (p.allNum IS NOT NULL AND p.allNum > '0') OR (a.number IS NOT NULL AND  a.number > '0'))");// 工程师库存、备件待审核数、待返还数有一项不为空且大于0时就显示，否则不显示
		return Db.queryLong(sb.toString(), params.get("siteId"));
	}

	// 工程师库存查询条件
	public String searchTJ(Map<String, Object> params) {
		StringBuilder sf = new StringBuilder();
		if (StringUtils.isNotEmpty((CharSequence) params.get("chacode"))) {
			sf.append(" and b.code like '%").append(params.get("chacode")).append("%'");
		}
		if (StringUtils.isNotEmpty((CharSequence) params.get("code"))) {
			sf.append(" and b.code  like '%").append(params.get("code")).append("%'");
		}
		if (StringUtils.isNotEmpty((CharSequence) params.get("fitName"))) {
			sf.append(" and b.name like '%").append(params.get("fitName")).append("%'");
		}
		if (StringUtils.isNotEmpty((CharSequence) params.get("category"))) {
			sf.append(" and a.suit_category like '%").append(params.get("category")).append("%'");
		}
		if (StringUtils.isNotEmpty((CharSequence) params.get("empId"))) {
			sf.append(" and a.employe_id ='").append(params.get("empId")).append("'");
		}
		if (StringUtils.isNotEmpty((CharSequence) params.get("chafittingName"))) {
			sf.append(" and b.name like '%").append(params.get("chafittingName")).append("%'");
		}
		if (StringUtils.isNotEmpty((CharSequence) params.get("chasuitCategory"))) {
			sf.append(" and a.suit_category like '%").append(params.get("chasuitCategory")).append("%'");
		}
		return sf.toString();
	}

	/**
	 * 新增配件
	 *
	 * @param fitting
	 *            配件信息
	 */
	@Transactional
	public Result<Void> addFitting(Fitting fitting) {
		GuardUtils.notBlank(fitting.getCode(), "fitting code required");
		GuardUtils.notBlank(fitting.getName(), "fitting name required");
		GuardUtils.notBlank(fitting.getVersion(), "fitting version required");
		GuardUtils.notBlank(fitting.getType(), "fitting type required");
		GuardUtils.notBlank(fitting.getSuitCategory(), "fitting category required");
		GuardUtils.notBlank(fitting.getUnit(), "fitting unit required");
		GuardUtils.notBlank(fitting.getSupplier(), "fitting supplier required");

		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		if (!checkFittingCode(siteId, fitting.getCode())) {
			return Result.fail("422", "code is already exists");
		}

		fitting.setId(null); // here id is empty string, so we need clear it.
		fitting.setSiteId(siteId);// 网点id
		fitting.setCreateTime(new Date());// 创建时间
		fitting.setCreateBy(user.getId());// 创建人user_id
		fitting.setTotal(fitting.getWarning());// 入库总数量（默认与新入库数量一致）
		fitting.setAuditedSum(0.0);// 已出库待领取数量，默认0
		fitting.setTotal(fitting.getWarning());
		Record rd = unitDao.getUnitType(fitting.getUnit());
		fitting.setUnitType(rd.getStr("type"));
		fitting.setSuitBrand(fitting.getSuitBrand());
		fittingDao.save(fitting);

		String op = CrmUtils.getUserXM();
		FittingKeepInfo keepInfo = new FittingKeepInfo();
		keepInfo.setType(SiteFittingKeepService.TYPE_STOCK_IN);
		keepInfo.setApplicant(op);
		keepInfo.setConfirmor(op);
		keepInfo.setAmount(fitting.getWarning());
		keepInfo.setPrice(fitting.getSitePrice());
		siteFittingKeepService.createSiteFittingKeep(fitting, null, keepInfo, user);
		return Result.ok();
	}

	@Transactional
	public Result<Void> modifyFitting(Fitting fitting) {
		GuardUtils.notBlank(fitting.getCode(), "fitting code required");
		GuardUtils.notBlank(fitting.getName(), "fitting name required");
		GuardUtils.notBlank(fitting.getVersion(), "fitting version required");
		GuardUtils.notBlank(fitting.getType(), "fitting type required");
		GuardUtils.notBlank(fitting.getSuitCategory(), "fitting category required");
		GuardUtils.notBlank(fitting.getUnit(), "fitting unit required");
		GuardUtils.notBlank(fitting.getSupplier(), "fitting supplier required");

		Fitting loadedFitting = getId(fitting.getId());
		loadedFitting.setName(fitting.getName());
		loadedFitting.setBrand(fitting.getBrand());
		loadedFitting.setSuitBrand(fitting.getSuitBrand());
		loadedFitting.setVersion(fitting.getVersion());
		loadedFitting.setSuitCategory(fitting.getSuitCategory());
		loadedFitting.setType(fitting.getType());
		loadedFitting.setUnit(fitting.getUnit());
		Record unit = unitDao.getUnitType(fitting.getUnit());
		loadedFitting.setUnitType(unit.getStr("type"));
		loadedFitting.setAlertNum(fitting.getAlertNum());
		loadedFitting.setSitePrice(fitting.getSitePrice());
		loadedFitting.setCustomerPrice(fitting.getCustomerPrice());
		loadedFitting.setEmployePrice(fitting.getEmployePrice());
		loadedFitting.setLocation(fitting.getLocation());
		loadedFitting.setRefundOldFlag(fitting.getRefundOldFlag());
		loadedFitting.setSupplier(fitting.getSupplier());
		loadedFitting.setImg(fitting.getImg());
		fittingDao.save(loadedFitting);
		return Result.ok();
	}

	public Fitting getWarning(String id) {
		return fittingDao.getWarning(id);
	}

	// 批量删除(修改备件状态为2)
	@Transactional
	public void pLSC(String ids1, String ids[]) {
		String sql = "update crm_site_fitting set status='2' where id in (" + ids1 + ")";
		Db.update(sql);

		String name = CrmUtils.getUserXM();
		for (int i = 0; i < ids.length; i++) {
			Fitting fi = fittingDao.get(ids[i]);
			if (fi.getWarning() != '0') {
				SiteFittingKeep sfk = new SiteFittingKeep();
				sfk.setNumber(CrmUtils.no());
				sfk.setType("5");
				sfk.setFittingId(fi.getId());
				sfk.setFittingCode(fi.getCode());
				sfk.setFittingName(fi.getName());
				sfk.setAmount(fi.getWarning());
				if (fi.getSitePrice() != null) {
					sfk.setPrice(fi.getSitePrice());
				}
				if (fi.getEmployePrice() != null) {
					sfk.setEmployePrice(fi.getEmployePrice());
				}
				if (fi.getCustomerPrice() != null) {
					sfk.setCustomerPrice(fi.getCustomerPrice());
				}
				sfk.setCreateTime(new Date());
				sfk.setApplicant(name);// 申请人/领用人
				sfk.setConfirmor(name);// 确认人，即为信息员/网点
				sfk.setSiteId(fi.getSiteId());
				sfk.setCreateBy(UserUtils.getUser().getId());
				skService.save(sfk);
			}
		}
	}

	private boolean checkFittingCode(String siteId, String code) {
		return Db.queryLong("select count(1) as cnt from crm_site_fitting where `site_id`=? and `code`=? and `status`='1'", siteId, code) == 0;
	}

	public List<Record> getEmployeFitting(String fittingId, String siteId) {
		return Db.find("select * from crm_employe_fitting a where a.status='1' and a.fitting_id='" + fittingId + "' and a.site_id='" + siteId + "'");
	}

	/**
	 * 看某个配件是否有关联的未完成申请。
	 * 
	 * @param fittingId
	 *            配件id
	 * @param siteId
	 *            网点id
	 */
	public List<Record> getUnfinishedFittingApply(String fittingId, String siteId) { // a.status=4 不考虑，将4看成是已完成的配件申请。
		return Db.find("select * from crm_site_fitting_apply a where a.status in ('0','1','2') and a.fitting_id='" + fittingId + "' and a.site_id='" + siteId + "'");
	}

	@Transactional
	public void addCrmSiteFittingKeepRecord(String[] ids) {
		String name = CrmUtils.getUserXM();
		for (int i = 0; i < ids.length; i++) {
			Fitting fi = fittingDao.get(ids[i]);
			if (fi.getWarning() != '0') {
				SiteFittingKeep sfk = new SiteFittingKeep();
				sfk.setNumber(CrmUtils.no());
				sfk.setType("5");
				sfk.setFittingId(fi.getId());
				sfk.setFittingCode(fi.getCode());
				sfk.setFittingName(fi.getName());
				sfk.setAmount(fi.getWarning());
				if (fi.getSitePrice() != null) {
					sfk.setPrice(fi.getSitePrice());
				}
				if (fi.getEmployePrice() != null) {
					sfk.setEmployePrice(fi.getEmployePrice());
				}
				if (fi.getCustomerPrice() != null) {
					sfk.setCustomerPrice(fi.getCustomerPrice());
				}
				sfk.setCreateTime(new Date());
				sfk.setApplicant(name);// 申请人/领用人
				sfk.setConfirmor(name);// 确认人，即为信息员/网点
				sfk.setSiteId(fi.getSiteId());
				sfk.setCreateBy(UserUtils.getUser().getId());
				skService.save(sfk);
			}
		}
	}

	public Map<String, Object> importFitting(Map<String, String> params, InputStream inp) {
		long st = System.currentTimeMillis();
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "import");
		FittingImportExcelHandler handler = new FittingImportExcelHandler();
		// handler.setMaxRows(10000);//条数限制1w条
		handler.setParams(params);
		try {
			new ExcelReader().read(inp, params.get("extName"), handler);
			DbBatchBean dbb = handler.fittingFilterInDb();
			DBUtils.batchSaveOrUpdateSQL(dbb, fittingDao.getSession());
			retMap.put("pass", "y");
			retMap.put("successCount", handler.getSuccessCount());
			retMap.put("errorCount", handler.getErrorCount());
			retMap.put("errorDetail", handler.getErrorDetail());
			retMap.put("importHints", "y");
		} catch (Exception e) {
			retMap.put("reporterrors", "y");
			e.printStackTrace();
		}
		return retMap;
	}

	@SuppressWarnings({ "unchecked" })
	public Map<String, Object> checkUnfinishedFitting(Map<String, String> params, InputStream in) {
		Map<String, Object> retMap = Maps.newHashMap();
		retMap.put("operType", "check");
		FittingImportExcelHandler handler = new FittingImportExcelHandler();
		// handler.setMaxRows(10000);//条数限制1w条
		handler.setStartSheet(1);
		handler.setStartRow(2);
		handler.setParams(params);
		try {
			new ExcelReader().check(in, params.get("extName"), handler);
			Map<String, Object> result = (Map<String, Object>) handler.getHandlerResult();
			Map<String, String> existsFittingMap = (Map<String, String>) result.get("existsFittingMap");

			String resul = (String) result.get("TemplateError");
			if (existsFittingMap.size() > 0) {
				for (String key : existsFittingMap.keySet()) {
					String vas = existsFittingMap.get(key);
					if (vas.contains(",")) {
						int one = vas.indexOf(",", 0);
						handler.appendErrorDetail("<p>第" + vas.substring(0, one) + "行数据与第" + vas.substring((one + 1), vas.length()) + "行备件条码(" + key + ")重复" + "</p>");
					}
				}
				String hanl = handler.getErrorDetail();
				if (StringUtils.isNotBlank(hanl)) {
					retMap.put("errorDetail", hanl);
					retMap.put("errorMessage", "y");
				} else {
					retMap.put("pass", "y");
				}
			}
			if ("TemplateError".equalsIgnoreCase(resul)) {
				retMap.put("templateError", "y");
			} else if ("overLimit".equalsIgnoreCase((String) result.get("overLimit"))) {
				retMap.put("overLimit", "y");
			} else {
				retMap.put("pass", "y");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return retMap;
	}

	/**
	 * 工程师备件库存返还，保存并入库操作。
	 */
	@Transactional
	public Result<Void> empFittingRecycle(String empFittingId, String fittingId, double recycleNum) {
		if (recycleNum <= 0) {
			return Result.fail("422", "返还数量不正确");
		}

		Fitting fitting = fittingDao.get(fittingId);
		String sql = "select * from crm_employe_fitting where id=?";
		Record re = Db.findFirst(sql, empFittingId);
		Employe employe = employeService.get(re.getStr("employe_id"));

		User user = UserUtils.getUser();
		int cnt1 = updateSiteFittingWarning(fittingId, recycleNum);
		if (cnt1 < 1) {
			throw new IllegalStateException("配件信息有误");
		}
		int cnt2 = employeFittingDao.updateEmpFittingWarning(empFittingId, -recycleNum);
		if (cnt2 < 1) {
			throw new IllegalStateException("配件信息有误");
		}
		siteFittingKeepService.createReturnFittingKeep(user, fitting, employe.getName(), recycleNum);
		empFittingKeepDao.createReturnEmpFittingKeep(fitting, employe.getId(), employe.getName(), user, recycleNum);
		fittingUsedRecordDao.createReturnFittingUsedRecord(employe.getId(), employe.getName(), user, CrmUtils.getUserXM(), fitting, CrmUtils.getCurrentSiteId(user), recycleNum);
		return Result.ok();
	}

	/* 工程师备件库存返还，保存并入库操作。 */

	@Transactional(rollbackFor = Exception.class)
	public Result<Void> empFittingRecycleNew(String empFittingId, String fittingId, double recycleNum) {
		Fitting fitting = fittingDao.get(fittingId);
		String sql = "select * from crm_employe_fitting where id=?";
		Record re = Db.findFirst(sql, empFittingId);
		Employe employe = employeService.get(re.getStr("employe_id"));

		User user = UserUtils.getUser();
		int cnt1 = updateSiteFittingWarning(fittingId, recycleNum);
		if (cnt1 < 1) {
			throw new IllegalStateException("配件信息有误");
		}
		int cnt2 = employeFittingDao.updateEmpFittingWarning(empFittingId, -recycleNum);
		if (cnt2 < 1) {
			throw new IllegalStateException("配件信息有误");
		}
		siteFittingKeepService.createReturnFittingKeep(user, fitting, employe.getName(), recycleNum);
		empFittingKeepDao.createReturnEmpFittingKeep(fitting, employe.getId(), employe.getName(), user, recycleNum);
		fittingUsedRecordDao.createReturnFittingUsedRecord(employe.getId(), employe.getName(), user, CrmUtils.getUserXM(), fitting, CrmUtils.getCurrentSiteId(user), recycleNum);
		return Result.ok();
	}

	/**
	 * 工程师备件库存返还保存操作。
	 */
	@Transactional
	public Result<Void> turnBack(String empFittingId, String fittingId, double recycleNum) {
		if (recycleNum <= 0) {
			return Result.fail("422", "返还数量不正确");
		}
		Fitting fitting = fittingDao.get(fittingId);
		String sql = "select * from crm_employe_fitting where id=?";
		Record re = Db.findFirst(sql, empFittingId);
		Employe employe = employeService.get(re.getStr("employe_id"));
		User user = UserUtils.getUser();

		// 工程师库存
		int cnt2 = employeFittingDao.updateEmpFittingWarningWhenSave(empFittingId, -recycleNum);
		if (cnt2 < 1) {
			throw new IllegalStateException("配件信息有误");
		}

		empFittingKeepDao.createReturnEmpFittingKeep(fitting, employe.getId(), employe.getName(), user, recycleNum);
		fittingUsedRecordDao.createReturnFittingUsedRecordTwo(employe.getId(), employe.getName(), user, CrmUtils.getUserXM(), fitting, CrmUtils.getCurrentSiteId(user), recycleNum);
		return Result.ok();
	}

	/**
	 * 工程师备件库存返还保存操作。
	 */
	@Transactional(rollbackFor = Exception.class)
	public Result<Void> turnBackNew(String empFittingId, String fittingId, double recycleNum) {
		Fitting fitting = fittingDao.get(fittingId);
		String sql = "select * from crm_employe_fitting where id=?";
		Record re = Db.findFirst(sql, empFittingId);
		Employe employe = employeService.get(re.getStr("employe_id"));
		User user = UserUtils.getUser();

		// 工程师库存
		int cnt2 = employeFittingDao.updateEmpFittingWarningWhenSave(empFittingId, -recycleNum);
		if (cnt2 < 1) {
			throw new IllegalStateException("配件信息有误");
		}

		empFittingKeepDao.createReturnEmpFittingKeep(fitting, employe.getId(), employe.getName(), user, recycleNum);
		fittingUsedRecordDao.createReturnFittingUsedRecordTwo(employe.getId(), employe.getName(), user, CrmUtils.getUserXM(), fitting, CrmUtils.getCurrentSiteId(user), recycleNum);
		return Result.ok();
	}

	/**
	 * 目前使用在pc端口，工程师库存返还。
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateSiteFittingWarning(String fittingId, double amount) {
		if (amount == 0) {
			return 0;
		}

		String op1 = amount > 0 ? "+" : "-";
		String op2 = amount > 0 ? "-" : "+";
		amount = Math.abs(amount);
		String sql = new SqlKit().append("update crm_site_fitting").append("set `warning`=`warning`" + op1 + amount).append(",`number`=`number`" + op2 + amount)
				.append("where id=:id and `status`='1'").toString();

		SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(sql);
		sqlQuery.setParameter("id", fittingId);
		return sqlQuery.executeUpdate();
	}

	public void refresh(Fitting fitting) {
		fittingDao.getSession().refresh(fitting);
	}

	public Long moreThanNum(Map<String, Object> map, String time, String siteId, String parentCode) {
		StringBuilder sb = new StringBuilder();
		sb.append(" select count(*) from crm_site_fitting a where a.status='1' and a.create_time='" + time + "' and a.code > '" + parentCode + "'");
		sb.append(fittingDao.getConditions(map));
		sb.append("limit 1 offset 0");
		return Db.queryLong(sb.toString());
	}

	public Long lessThanNum(Map<String, Object> map, String time, String siteId, String parentCode) {
		StringBuilder sb = new StringBuilder();
		sb.append(" select count(*) from crm_site_fitting a where a.status='1' and a.create_time='" + time + "' and a.code < '" + parentCode + "' ");
		sb.append(fittingDao.getConditions(map));
		sb.append("limit 1 offset 0");
		return Db.queryLong(sb.toString());
	}

	public Result<Record> getnextOrLastfittingDetailMsg(String id, String mark, Map<String, Object> map) {
		Result<Record> rt = new Result<Record>();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Record ft = Db.findFirst("select a.* from  crm_site_fitting a where a.id=?", id);
		if (ft == null) {
			rt.setCode("420");// 当前备件不存在，刷新页面
			rt.setErrMsg("not exist!");
			return rt;
		}
		String time = ft.getDate("create_time").toString();
		String parentCode = ft.getStr("code");
		// 查出时间相同备件的code大于当前code的条数
		Long num = moreThanNum(map, time, siteId, parentCode);
		// 查出时间相同工单的code小于当前code的条数
		Long num1 = lessThanNum(map, time, siteId, parentCode);
		StringBuilder sb = new StringBuilder();
		sb.append(" select a.* from crm_site_fitting a where a.status='1'");
		sb.append(fittingDao.getConditions(map));
		if ("1".equals(mark)) {
			if (num < 1) {
				sb.append(" and  a.site_id=? and a.id != '" + id + "' and a.create_time <= '" + time + "' ");
			} else {
				if (num1 < 1) {
					sb.append(" and a.site_id=? and a.id != '" + id + "' and a.create_time < '" + time + "' ");
				} else {
					sb.append(" and a.site_id=? and a.id != '" + id + "' and a.create_time <= '" + time + "' ");
				}
			}
			if (num < 1) {
				sb.append("ORDER BY a.create_time DESC,a.code desc");
			} else {// 存在时间相同备件的code大于当前备件code的备件
				if (num1 < 1) {
					sb.append("ORDER BY a.create_time DESC,a.code desc");
				} else {
					sb.append(" and a.code < '" + parentCode + "' ORDER BY a.create_time DESC,a.code desc");
				}
			}
		}
		if ("0".equals(mark)) {
			if (num1 < 1) {
				sb.append(" and a.site_id=? and a.id != '" + id + "' and a.create_time >= '" + time + "' ");
			} else {
				if (num < 1) {
					sb.append(" and a.site_id=? and a.id != '" + id + "' and a.create_time > '" + time + "' ");
				} else {
					sb.append(" and a.site_id=? and a.id != '" + id + "' and a.create_time >= '" + time + "' ");
				}
			}
			if (num1 < 1) {
				sb.append(" ORDER BY a.create_time ASC,a.code asc");
			} else {
				if (num < 1) {
					sb.append(" ORDER BY a.create_time ASC,a.code asc");
				} else {
					sb.append(" and a.code > '" + parentCode + "'  ORDER BY a.create_time ASC,a.code asc");
				}
			}
		}
		sb.append(" limit 1 offset 0 ");
		rt.setData(Db.findFirst(sb.toString(), siteId));
		rt.setCode("200");
		return rt;
	}

	/**
	 * 添加库存预警
	 */
	public void stockAlert(String fitId) {
		try {
			Fitting fi = fittingDao.get(fitId);
			fittingDao.getSession().refresh(fi);
			/* 库存预警 */
			if (fi.getWarning() <= DataUtils.doubleIfNull(fi.getAlertNum(), -1.0d)) {
				if (fittingDao.checkAlarm(fi.getId(), fi.getSiteId(), "3")) {
					String content = String.format("\"%s、%s\"", fi.getName(), fi.getCode()) + "  剩余库存" + fi.getWarning() + fi.getUnit() + "，请注意及时补充库存数量！";
					fittingDao.createAlarm(fi.getId(), fi.getCode(), fi.getSiteId(), content, "3");
				}
			}
		} catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
		}
	}

	/**
	 * 取消预警
	 */
	public void cancelStockAlert(String fitId) {
		try {
			Fitting fi = fittingDao.get(fitId);
			fittingDao.getSession().refresh(fi);
			/* 库存预警 */
			if (fi.getWarning() > DataUtils.doubleIfNull(fi.getAlertNum(), -1.0d)) {
				fittingDao.cancelAlarm(fi.getId(), fi.getSiteId(), "3");
			}
		} catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
		}
	}

	public List<Record> getDefaultReturnList(String ids) {
		return Db.find("select a.* from crm_site_fitting a where a.id in(" + StringUtil.joinInSql(ids.split(",")) + ")");
	}

	// 保存新件返厂
	@SuppressWarnings({ "unlikely-arg-type", "unused", "rawtypes" })
	@Transactional(rollbackFor = Exception.class)
	public Result saveNewFittingReturnFactory(Map<String, Object> map) {
		Result<Object> rt = new Result<>();
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String uname = CrmUtils.getUserXM();
		Object data = map.get("data");
		if (data == null) {
			rt.setCode("421");
			return rt;
		}
		String mark = "0";
		String errorCode = "";
		String[] two = data.toString().split("-");
		List<SiteFittingKeep> list1 = new ArrayList<>();
		for (int i = 0; i < two.length; i++) {
			two[i] = two[i].replace(" ", "");
			String[] f = two[i].split(",");
			if (f.length != 2) {
				throw new RuntimeException("fitting apply info error");
			}
			String ffId = f[0];// 获取备件id
			double num = Double.parseDouble(f[1]);// 获取申请数量
			if (StringUtils.isBlank(f[0]) || StringUtils.isBlank(f[1])) {
				mark = "2";
				break;
			}
			Fitting fitting = fittingDao.get(ffId);
			if (Double.valueOf(num) > fitting.getWarning()) {
				mark = "1";
				errorCode = fitting.getCode();
				break;
			} else {
				SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date now = new Date();
				String date = fm.format(now);
				SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(
						"update crm_site_fitting set warning=warning-'" + num + "',cjnum=cjnum+'" + num + "',newest_keep_time='" + date + "' where id='" + ffId + "'  ");
				sqlQuery.executeUpdate();

				SiteFittingKeep sfk = new SiteFittingKeep();
				sfk.setNumber(CrmUtils.no());
				sfk.setType("6");// 新件返厂
				sfk.setFittingId(ffId);
				if (StringUtil.isNotBlank(fitting.getCode())) {
					sfk.setFittingCode(fitting.getCode());
				}
				if (StringUtils.isNotBlank(fitting.getName())) {
					sfk.setFittingName(fitting.getName());
				}
				sfk.setAmount(Double.valueOf(num));
				if (fitting.getSitePrice() != null && !"".equals(fitting.getSitePrice())) {
					sfk.setPrice(fitting.getSitePrice());
				}
				if (fitting.getEmployePrice() != null && !"".equals(fitting.getEmployePrice())) {
					sfk.setEmployePrice(fitting.getEmployePrice());
				}
				if (fitting.getCustomerPrice() != null && !"".equals(fitting.getCustomerPrice())) {
					sfk.setCustomerPrice(fitting.getCustomerPrice());
				}
				sfk.setCreateTime(new Date());
				sfk.setCreateBy(uname);
				sfk.setSiteId(siteId);
				sfk.setApplicant(uname);
				sfk.setConfirmor(uname);
				list1.add(sfk);
			}
		}
		if ("2".equals(mark)) {
			rt.setCode("421");
			return rt;// 信息有误
		}
		if ("1".equals(mark)) {
			rt.setCode("420");
			rt.setErrMsg(errorCode);
			return rt;// 库存不足
		}
		if (list1.size() > 0) {
			siteFittingKeepDao.save(list1);
		}
		rt.setCode("200");
		return rt;
	}

	public void dealCountsAlert(Map<String, Object> map) {
		Object data = map.get("data");
		if (data != null) {
			String[] two = data.toString().split("-");
			for (int i = 0; i < two.length; i++) {
				two[i] = two[i].replace(" ", "");
				String[] f = two[i].split(",");
				if (f.length == 2) {
					String ffId = f[0];
					stockAlert(ffId);
				}
			}
		}
	}

	public boolean isFittingFromMicroFactory(String fittingId) {
		String factoryId = fittingDao.get(fittingId).getFactoryId();
		return StringUtils.isNotBlank(factoryId);
	}

	@Transactional(rollbackFor = Exception.class)
	public List<Record> getAllFittingByIds(String[] ids) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return Db.find("select *,0+cast(a.warning as decimal(9,0)) as fWarning  from crm_site_fitting a where a.id in (" + StringUtil.joinInSql(ids) + ") and a.site_id=? ",
				siteId);
	}

	@Transactional(rollbackFor = Exception.class)
	public Object RejectFitting(String id) {
		FittingUsedRecord verification = fittingUsedRecordDao.get(id);
		if (verification == null) {
			return Result.fail("801", "missing verification");
		}
		// 归还数量
		BigDecimal usedNum = verification.getUsedNum();
		if (usedNum == null) {
			logger.error(String.format("used record[%s] used num is invalid, request rejected", verification.getId()));
			return Result.fail("802", "verification used num invalid");
		}
		String employeId = verification.getEmployeId();
		String fittingId = verification.getFittingId();
		String orderId = verification.getOrderId();
		// 工程师备件库存
		EmployeFitting efi = employeFittingDao.getEmpFitting(employeId, fittingId);
		// 工程师出入库信息
		Record rds = Db.findFirst(
				" SELECT id FROM crm_employe_fitting_keep a WHERE a.type='3' AND a.fitting_id=? AND a.employe_id=? AND a.amount=? ORDER BY a.create_time LIMIT 1  ", fittingId,
				employeId, usedNum);
		if (rds == null) {
			logger.error(String.format("used record[%s] used num is invalid, request rejected", verification.getId()));
			return Result.fail("803", "verification used num invalid");
		}
		String content = "温馨提醒：备件" + verification.getFittingName() + "（" + verification.getFittingCode() + "）的返还申请已被驳回。";
		// 删除返还信息
		Db.update(" DELETE FROM crm_site_fitting_used_record WHERE id =? ", id);
		// 修改库存
		efi.setWarning(efi.getWarning().add(usedNum));
		efi.setNumber(efi.getNumber().subtract(usedNum));
		employeFittingDao.save(efi);
		// 删除出入库明细
		Db.update("DELETE FROM crm_employe_fitting_keep WHERE id = ? ", rds.getStr("id"));
		// 给工程师推送消息
		pushmessageService.notifyRejectFitting(orderId, content, employeId, "备件返还驳回", "4");
		return Result.ok();

	}

}
