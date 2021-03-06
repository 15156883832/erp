package com.jojowonet.modules.fitting.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.FittingDao;
import com.jojowonet.modules.fitting.dao.FittingOuterApplyDao;
import com.jojowonet.modules.fitting.dao.SiteFittingKeepDao;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingOuterApply;
import com.jojowonet.modules.fitting.entity.SiteFittingKeep;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SqlKit;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.UserUtils;

/**
 * 备件申请Service
 *
 * @author DQChen
 * @version 2018-01-22
 */
@Component
@Transactional(readOnly = true)
public class FittingOuterApplyService extends BaseService {
	@Autowired
	private FittingOuterApplyDao fittingOuterApplyDao;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private FittingDao fittingDao;
	@Autowired
	private FittingService fittingService;
	@Autowired
	private SiteFittingKeepDao siteFittingKeepDao;

	// type:表示配件申请菜单中的类别 0:待审核；1:待出库；2:全部申请
	public Page<Record> getWaitShenheList(Page<Record> page, String siteId, int type, Map<String, Object> ma) {
		List<Record> list = fittingOuterApplyDao.getWaitShenheList(page, siteId, type, ma);
		long count = fittingOuterApplyDao.getWaitShenheCount(siteId, type, ma);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Map<String, Object> twoStatusCount2(String siteId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Long count1 = Db.queryLong("select count(*) from crm_site_fitting_outer_apply a where a.status in('0','1') and a.target_site_id=?", siteId);
		Long count2 = Db.queryLong("select count(*) from crm_site_fitting_outer_apply a where a.status in('2') and a.target_site_id=?", siteId);
		map.put("ct1", count1);
		map.put("ct2", count2);
		return map;
	}

	public FittingOuterApply getFittingApplyOneId(String id) {
		return fittingOuterApplyDao.get(id);
	}

	public Site getSiteById(String id) {
		return siteDao.get(id);
	}

	public Record getFittingByCode(String code, String siteId) {
		return Db.findFirst("select a.* from crm_site_fitting a where a.code=? and a.site_id=? and a.status='1'", code, siteId);
	}

	// 保存
	@Transactional(rollbackFor = Exception.class)
	public String updateFittingOuterApply(String id, String auditMarks, String fittingAuditNum, String oldFittingFlag, String siteId) {
		Site st = siteDao.get(siteId);
		Date dt = new Date();
		FittingOuterApply foa = fittingOuterApplyDao.get(id);
		foa.setAuditMarks(auditMarks);
		foa.setOldFittingFlag(oldFittingFlag);
		if (StringUtils.isNotBlank(fittingAuditNum)) {
			foa.setAuditFittingNum(Double.valueOf(fittingAuditNum));
		}
		foa.setUpdateTime(dt);
		foa.setUpdateName(CrmUtils.getUserXM());
		foa.setStatus("0");
		// 生成预警
		Record rd = getFittingByCode(foa.getApplyFittingCode(), siteId);
		if (rd != null) {
			if (Double.valueOf(fittingAuditNum) > Double.valueOf(rd.getBigDecimal("warning").toString())) {// 审核数大于库存，生成预警
				String content = "" + foa.getApplyFittingName() + "、" + foa.getApplyFittingCode() + "缺件，请及时处理！";
				StringBuilder sb = new StringBuilder();
				sb.append(" insert into crm_site_alarm (id, site_id, type, target_id, target_name, content, create_time, status, is_cancel, is_send) ");
				sb.append(" values ('" + IdGen.uuid() + "', '" + siteId + "', '4', '" + id + "', '" + foa.getApplyFittingCode() + "', '" + content + "', '"
						+ DateUtils.getDate("yyyy-MM-dd HH:mm:ss") + "', '0', '0', '0') ");
				SQLQuery sql = fittingOuterApplyDao.getSession().createSQLQuery(sb.toString());
				sql.executeUpdate();
				foa.setStatus("1");
			}
		}
		fittingOuterApplyDao.save(foa);
		return "ok";

	}

	// 通过
	@Transactional(rollbackFor = Exception.class)
	public String adoptFittingOuterApply(String id, String auditMarks, String fittingAuditNum, String oldFittingFlag, String siteId) {
		Site st = siteDao.get(siteId);
		Date dt = new Date();
		FittingOuterApply foa = fittingOuterApplyDao.get(id);
		Record rd = getFittingByCode(foa.getApplyFittingCode(), siteId);
		if (rd == null) {
			return "420";
		}
		String status = foa.getStatus();
		if (!"0".equals(status) && !"1".equals(status)) {// 已通过或者已拒绝
			return "422";
		}
		BigDecimal stocks = rd.getBigDecimal("warning");
		if (stocks.compareTo(new BigDecimal(fittingAuditNum)) == -1) {// 等于0：相等；等于-1：大于；等于-1：小于
			return "421";
		}
		foa.setAuditMarks(auditMarks);
		foa.setOldFittingFlag(oldFittingFlag);
		if (StringUtils.isNotBlank(fittingAuditNum)) {
			foa.setAuditFittingNum(Double.valueOf(fittingAuditNum));
		}
		foa.setUpdateTime(dt);
		foa.setUpdateName(CrmUtils.getUserXM());
		foa.setAuditor(CrmUtils.getUserXM());
		foa.setShipmentFittingId(rd.getStr("id"));
		foa.setAuditorId(UserUtils.getUser().getId());
		foa.setStatus("2");
		foa.setAuditTime(dt);
		fittingOuterApplyDao.save(foa);
		SQLQuery sql = fittingOuterApplyDao.getSession()
				.createSQLQuery("update crm_site_fitting a set a.audited_sum=(a.audited_sum+'" + fittingAuditNum + "') where a.id='" + rd.getStr("id") + "'");
		sql.executeUpdate();
		// 取消预警
		cancelYujing(siteId, id);
		return "200";

	}

	@Transactional(rollbackFor = Exception.class)
	public void cancelYujing(String siteId, String id) {
		SQLQuery sql = fittingOuterApplyDao.getSession()
				.createSQLQuery("update crm_site_alarm set is_cancel = '1' where site_id = '" + siteId + "' and target_id = '" + id + "' and type = '4'");
		sql.executeUpdate();
	}

	// 拒绝
	@Transactional(rollbackFor = Exception.class)
	public String refuseFittingOuterApply(String id, String auditMarks, String reason, String siteId) {
		Site st = siteDao.get(siteId);
		Date dt = new Date();
		FittingOuterApply foa = fittingOuterApplyDao.get(id);
		String status = foa.getStatus();
		if (!"0".equals(status) && !"1".equals(status)) {// 已通过或者已拒绝
			return "420";
		}
		foa.setAuditMarks(auditMarks);
		foa.setUpdateTime(dt);
		foa.setUpdateName(CrmUtils.getUserXM());
		foa.setRefuseReason(reason);
		foa.setStatus("6");

		fittingOuterApplyDao.save(foa);
		cancelYujing(siteId, id);// 取消预警
		return "200";

	}

	// 出库
	@Transactional(rollbackFor = Exception.class)
	public String applyOutStocks(String id, String siteId) {
		Site st = siteDao.get(siteId);
		Date dt = new Date();
		FittingOuterApply foa = fittingOuterApplyDao.get(id);
		Record rd = getFittingByCode(foa.getApplyFittingCode(), siteId);
		if (rd == null) {
			return "420";// 备件不存在
		}
		String status = foa.getStatus();
		if (!"2".equals(status)) {// 已通过或者已拒绝
			return "424";
		}
		BigDecimal stocks = rd.getBigDecimal("warning");
		if (stocks.compareTo(new BigDecimal(foa.getAuditFittingNum())) == -1) {// 等于0：相等；等于1：大于；等于-1：小于
			return "421";// 库存不足
		}
		if (new BigDecimal(foa.getAuditFittingNum()).compareTo(new BigDecimal(0)) == -1) {// 等于0：相等；等于1：大于；等于-1：小于
			return "422";// 审核数要求大于0
		}
		if (new BigDecimal(foa.getAuditFittingNum()).compareTo(rd.getBigDecimal("audited_sum")) > 0) {// 等于0：相等；等于1：大于；等于-1：小于
			return "423";// 审核数大于该备件的审核总数待出库数
		}
		foa.setUpdateTime(dt);
		foa.setUpdateName(CrmUtils.getUserXM());
		foa.setStatus("3");
		foa.setShipmentName(CrmUtils.getUserXM());// 出库确认人
		foa.setShipmentId(UserUtils.getUser().getId());
		foa.setConfirmTime(dt);
		fittingOuterApplyDao.save(foa);
		Double auditNum = foa.getAuditFittingNum();
		updateFitApply(auditNum, dt, rd.getStr("id"));
		createSiteOutStockDetailByApply(foa, rd, st);// 公司出入库明细
		/*
		 * if(rd.getBigDecimal("warning")!=null && rd.getBigDecimal("alert_num")!=null){
		 * if (rd.getBigDecimal("warning").doubleValue()<=
		 * DataUtils.doubleIfNull(rd.getBigDecimal("alert_num").doubleValue(), -1.0d)) {
		 * if (fittingDao.checkAlarmValid(rd.getStr("id"), rd.getStr("site_id"), "3")) {
		 * String content = String.format("\"%s、%s\"", rd.getStr("name"),
		 * rd.getStr("code")) + "  剩余库存" + rd.getBigDecimal("warning") +
		 * rd.getStr("unit") + "，请注意及时补充库存数量！"; fittingDao.createAlarm(rd.getStr("id"),
		 * rd.getStr("code"), rd.getStr("site_id"), content, "3"); } } }
		 */
		fittingService.stockAlert(foa.getApplyFittingId());
		return "200";

	}

	// 批量出库
	@Transactional(rollbackFor = Exception.class)
	public Result<Void> batchOutStock(FittingOuterApply foa, String siteId, User user, Site st, Date dt) {
		Record rd = getFittingByCode(foa.getApplyFittingCode(), siteId);
		if (rd == null) {
			return Result.fail("420", "");// 备件不存在
		}
		String status = foa.getStatus();
		if (!"2".equals(status)) {// 已通过或者已拒绝
			return Result.fail("424", "");
		}
		BigDecimal stocks = rd.getBigDecimal("warning");
		if (stocks.compareTo(new BigDecimal(foa.getAuditFittingNum())) == -1) {// 等于0：相等；等于1：大于；等于-1：小于
			return Result.fail("421", "");// 库存不足
		}
		if (new BigDecimal(foa.getAuditFittingNum()).compareTo(new BigDecimal(0)) == -1) {// 等于0：相等；等于1：大于；等于-1：小于
			return Result.fail("422", "");// 审核数要求大于0
		}
		if (new BigDecimal(foa.getAuditFittingNum()).compareTo(rd.getBigDecimal("audited_sum")) > 0) {// 等于0：相等；等于1：大于；等于-1：小于
			return Result.fail("423", "");// 审核数大于该备件的审核总数待出库数
		}
		foa.setUpdateTime(dt);
		foa.setUpdateName(CrmUtils.getUserXM());
		foa.setStatus("3");
		foa.setShipmentName(CrmUtils.getUserXM());// 出库确认人
		foa.setShipmentId(user.getId());
		foa.setConfirmTime(dt);
		fittingOuterApplyDao.save(foa);
		Double auditNum = foa.getAuditFittingNum();
		updateFitApply(auditNum, dt, rd.getStr("id"));
		createSiteOutStockDetailByApply(foa, rd, st);// 公司出入库明细
		/*
		 * if(rd.getBigDecimal("warning")!=null && rd.getBigDecimal("alert_num")!=null){
		 * if (rd.getBigDecimal("warning").compareTo(rd.getBigDecimal("alert_num"))<1) {
		 * if (fittingDao.checkAlarmValid(rd.getStr("id"), rd.getStr("site_id"), "3")) {
		 * String content = String.format("\"%s、%s\"", rd.getStr("name"),
		 * rd.getStr("code")) + "  剩余库存" + rd.getBigDecimal("warning") +
		 * rd.getStr("unit") + "，请注意及时补充库存数量！"; fittingDao.createAlarm(rd.getStr("id"),
		 * rd.getStr("code"), rd.getStr("site_id"), content, "3"); } } }
		 */
		fittingService.stockAlert(rd.getStr("id"));
		fittingOuterApplyDao.getSession().flush();
		return Result.ok();
	}

	@Transactional(rollbackFor = Exception.class)
	private void updateFitApply(Double auditNum, Date dt, String id) {
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = fm.format(dt);
		String sql = new SqlKit().append("update crm_site_fitting").append("set `warning`=`warning`-" + auditNum).append(",`audited_sum`=`audited_sum`-" + auditNum)
				.append(",`cjnum`=`cjnum`+" + auditNum).append(",`newest_keep_time`='" + date + "'").append("where id=:id and `status`='1'").toString();

		SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(sql);
		sqlQuery.setParameter("id", id);
		sqlQuery.executeUpdate();
	}

	private void createSiteOutStockDetailByApply(FittingOuterApply foa, Record rd, Site st) {
		SiteFittingKeep sfkp = new SiteFittingKeep();
		sfkp.setNumber(CrmUtils.no());
		sfkp.setType("7"); // 出库
		sfkp.setFittingId(rd.getStr("id"));
		sfkp.setFittingCode(rd.getStr("code"));
		sfkp.setFittingName(rd.getStr("name"));
		sfkp.setAmount(foa.getAuditFittingNum());
		if (rd.getBigDecimal("site_price") != null) {
			sfkp.setPrice(Double.valueOf(rd.getBigDecimal("site_price").toString()));
		}
		if (rd.getBigDecimal("employe_price") != null) {
			sfkp.setEmployePrice(Double.valueOf(rd.getBigDecimal("employe_price").toString()));
		}
		if (rd.getBigDecimal("customer_price") != null) {
			sfkp.setCustomerPrice(Double.valueOf(rd.getBigDecimal("customer_price").toString()));
		}
		sfkp.setSiteId(st.getId());
		sfkp.setCreateBy(UserUtils.getUser().getId());
		sfkp.setApplicant(foa.getApplicantName());
		sfkp.setConfirmor(CrmUtils.getUserXM());
		siteFittingKeepDao.save(sfkp);
	}

	// 驳回
	@Transactional(rollbackFor = Exception.class)
	public String RejectFittingApply(String id, String siteId) {
		FittingOuterApply foa = fittingOuterApplyDao.get(id);
		Record rd = getFittingByCode(foa.getApplyFittingCode(), siteId);
		if (rd == null) {
			return "420";// 备件不存在
		}
		if (!"2".equals(foa.getStatus())) {
			return "421";// 已驳回
		}
		foa.setAuditMarks(foa.getAuditMarks() + ";" + DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss") + "驳回申请");
		foa.setUpdateTime(new Date());
		foa.setUpdateName(CrmUtils.getUserXM());
		foa.setStatus("0");

		Double v = foa.getAuditFittingNum();
		if (rd.getBigDecimal("audited_sum") == null) {
			return "422";// 备件的已审核待出库数量不能为null
		}

		String adoptApplySql = new SqlKit().append("update crm_site_fitting as f").append("set f.`audited_sum`=f.`audited_sum`-" + v).append("where f.id=:id").toString();

		SQLQuery sqlQuery = fittingOuterApplyDao.getSession().createSQLQuery(adoptApplySql);
		sqlQuery.setParameter("id", rd.getStr("id"));
		sqlQuery.executeUpdate();

		// 预警信息
		Double auditNum = foa.getAuditFittingNum().doubleValue();// 审核数
		Double warning = rd.getBigDecimal("warning").doubleValue();// 库存数
		if (auditNum > warning) {
			Record rd1 = getalarm(siteId, id);
			if (rd1 != null) {
				SQLQuery sql = fittingOuterApplyDao.getSession()
						.createSQLQuery("update crm_site_alarm set is_cancel = '0' where site_id = '" + siteId + "' and target_id = '" + id + "' and type = '4'");
				sql.executeUpdate();
			} else {
				String content = "" + rd.getStr("name") + "、" + rd.getStr("code") + "缺件，请及时处理！";
				String now = DateUtils.formatDateTime(new Date());
				SQLQuery sql = fittingOuterApplyDao.getSession()
						.createSQLQuery("insert into crm_site_alarm (id, site_id, type, target_id, target_name, content, create_time, status, is_cancel, is_send) values ('"
								+ IdGen.uuid() + "', '" + siteId + "', '4', '" + id + "','" + rd.getStr("code") + "', '" + content + "', '" + now + "', '0', '0', '0')");
				sql.executeUpdate();
			}
			foa.setStatus("1");
		}
		fittingOuterApplyDao.save(foa);
		return "200";
	}

	public Record getalarm(String siteId, String id) {
		StringBuilder sb = new StringBuilder();
		sb.append(" select * from crm_site_alarm  ");
		sb.append(" where site_id = '" + siteId + "' and target_id = '" + id + "' and type = '4'  ");
		return Db.findFirst(sb.toString());
	}

	@SuppressWarnings("unchecked")
	public List<FittingOuterApply> getFittingApplyList(String[] ids, String siteId) {
		List<FittingOuterApply> ret = new ArrayList<>();
		if (ids == null) {
			return ret;
		}
		Query query = fittingOuterApplyDao.getSession().createQuery("from FittingOuterApply where id in (:ids) and targetSiteId=:sid and status='2'");
		query.setParameterList("ids", ids);
		query.setParameter("sid", siteId);
		return query.list();
	}

	public Page<Record> getAllApplyList(Page<Record> page, String siteId, Map<String, Object> ma) {
		List<Record> list = fittingOuterApplyDao.getFittingApplyList(page, siteId, ma);
		long count = fittingOuterApplyDao.getFittingApplyCount(siteId, ma);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	/**
	 * 添加申请
	 */
	@Transactional
	public void saveFittingApply(FittingOuterApply outerApply) {
		fittingOuterApplyDao.save(outerApply);
		fittingOuterApplyDao.getSession().flush();
		// 库存预警
		Fitting fi = fittingDao.getByHql("from Fitting where code=:p1 and status='1' and site_id=:p2 ",
				new Parameter(outerApply.getApplyFittingCode(), outerApply.getTargetSiteId()));
		if (fi != null) {
			if (0 == fi.getWarning()) {
				String content = String.format("\"%s、%s\"", fi.getName(), fi.getCode()) + "  剩余库存" + fi.getWarning() + fi.getUnit() + "，请注意及时补充库存数量！";
				fittingDao.createAlarm(fi.getId(), fi.getCode(), outerApply.getTargetSiteId(), content, "4");
			}
		}
	}

	/**
	 * 撤销
	 */
	@Transactional
	public String revocationApply(String applyId) {
		FittingOuterApply outerApply = fittingOuterApplyDao.get(applyId);
		if (!"0".equals(outerApply.getStatus()) && !"6".equals(outerApply.getStatus())) {
			return "405";
		}
		fittingOuterApplyDao.update("update FittingOuterApply set status=:p1,end_time=:p2,update_time=:p3,update_name=:p4 where id=:p5 and status in ('0','6') ",
				new Parameter("5", new Date(), new Date(), CrmUtils.getUserXM(), applyId));
		return "200";
	}

	/**
	 * 入库操作
	 */
	@Transactional(rollbackFor = Exception.class)
	public void putInstock(FittingOuterApply outerApply) {
		Fitting fitting = fittingDao.get(outerApply.getApplyFittingId());
		User user = UserUtils.getUser();
		// 修改备件申请表信息
		fittingOuterApplyDao.save(outerApply);
		// 修改备件库存信息
		String sql = new SqlKit().append("update crm_site_fitting").append("set `warning`=`warning`+" + outerApply.getAuditFittingNum())
				.append(",`total`=`total`+" + outerApply.getAuditFittingNum()).append("where id=:id and `status`='1'").toString();
		SQLQuery sqlQuery = fittingDao.getSession().createSQLQuery(sql);
		sqlQuery.setParameter("id", outerApply.getApplyFittingId());
		sqlQuery.executeUpdate();
		// 修改出入库明细
		SiteFittingKeep sfkp = new SiteFittingKeep();
		sfkp.setNumber(CrmUtils.no());
		sfkp.setType("8");
		sfkp.setFittingId(fitting.getId());
		sfkp.setFittingCode(fitting.getCode());
		sfkp.setFittingName(fitting.getName());
		sfkp.setAmount(outerApply.getAuditFittingNum());
		sfkp.setPrice(fitting.getSitePrice());
		if (fitting.getEmployePrice() != null) {
			sfkp.setEmployePrice(fitting.getEmployePrice());
		}
		if (fitting.getCustomerPrice() != null) {
			sfkp.setCustomerPrice(fitting.getCustomerPrice());
		}
		sfkp.setSiteId(fitting.getSiteId());
		sfkp.setCreateBy(user.getId());
		sfkp.setApplicant(outerApply.getApplicantName());
		sfkp.setConfirmor(CrmUtils.getUserXM());
		siteFittingKeepDao.save(sfkp);
	}

	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> saveFittingApplyUpdate(String fIds, String nums, String marks, User user, String uname, String siteId, String parentSiteId, List<Record> list) {
		String[] idArr = fIds.split(",");
		String[] numArr = nums.split(",");
		String[] markArr = marks.split(",");
		Date dt = new Date();
		Map<String, Object> mapRet = new HashMap<>();
		List<FittingOuterApply> listRet = new ArrayList<>();
		for (int i = 0; i < idArr.length; i++) {
			Record rd = null;
			String fId = idArr[i];
			for (Record rd1 : list) {
				if (fId.equals(rd1.getStr("id"))) {
					rd = rd1;
				}
			}
			if (rd != null) {
				FittingOuterApply foa = new FittingOuterApply();
				foa.setApplicantId(user.getId());
				foa.setApplicantName(uname);
				foa.setApplyFittingBrand(rd.getStr("suit_brand"));
				foa.setApplyFittingCode(rd.getStr("code"));
				foa.setApplyFittingId(rd.getStr("id"));
				foa.setApplyFittingImg(rd.getStr("img"));
				foa.setApplyFittingName(rd.getStr("name"));
				foa.setApplyFittingNum(Double.valueOf((numArr[i])));
				foa.setApplyFittingType(rd.getStr("type"));
				foa.setApplyFittingVersion(rd.getStr("version"));
				foa.setApplySiteId(siteId);
				foa.setCreateTime(dt);
				foa.setCreator(uname);
				foa.setStatus("0");
				foa.setType("1");
				foa.setApplicantFeedback(markArr[i].substring(1, markArr[i].length()));
				foa.setUpdateName(uname);
				foa.setUpdateTime(dt);
				foa.setOldFittingFlag("0");
				foa.setTargetSiteId(parentSiteId);
				listRet.add(foa);
			}
		}
		if (listRet.size() > 0) {
			fittingOuterApplyDao.save(listRet);
		}
		mapRet.put("code", "200");
		mapRet.put("msg", "保存成功！");
		return mapRet;
	}
}
