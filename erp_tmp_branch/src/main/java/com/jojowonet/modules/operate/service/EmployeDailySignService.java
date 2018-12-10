package com.jojowonet.modules.operate.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.SignJson;
import com.jojowonet.modules.operate.dao.EmployeDailySignDao;
import com.jojowonet.modules.operate.dao.EmployeDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.dao.SiteSignRuleDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.entity.EmployeDailySign;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.entity.SiteSignRule;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.utils.Apiutils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.WebPageFunUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

/**
 * 员工每日签到记录表Service
 * 
 * @author Ivan
 * @version 2017-06-13
 */
@Component
@Transactional(readOnly = true)
public class EmployeDailySignService extends BaseService {
	@Autowired
	private EmployeDailySignDao employeDailySignDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private SiteSignRuleDao siteSignRuleDao;
	@Autowired
	private EmployeDao employeDao;
	@Autowired
	private SiteDao siteDao;

	public Page<Record> employeDailySignList(Page<Record> page, String siteId, Map<String, Object> map) {// 查询grid表格
		List<Record> list = employeDailySignDao.employeDailySignList(page, siteId, map);
		Long count = employeDailySignDao.queryCount(siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public Page<Record> employeLeaveGrid(Page<Record> page, String siteId, Map<String, Object> map) {// 查询grid表格
		List<Record> list = employeLeaveList(page, siteId, map);
		Long count = employeLeaveCount(siteId, map);
		page.setList(list);
		page.setCount(count);
		return page;
	}

	public List<Record> employeLeaveList(Page<Record> page, String siteId, Map<String, Object> map) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT a.* from crm_employe_leave a where a.status='0' and a.site_id=? ");
		sb.append(employeLeaveConditions(map));
		sb.append(" order by a.create_time desc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		List<Record> list = Db.find(sb.toString(), siteId);
		DecimalFormat df = new DecimalFormat("0.0");
		for (Record rd : list) {
			Integer duration = rd.getInt("duration");
			rd.set("duration", df.format((float) duration / 60));
		}
		return list;
	}

	public Long employeLeaveCount(String siteId, Map<String, Object> map) {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT count(*) from crm_employe_leave a where a.status='0' and a.site_id=? ");
		sb.append(employeLeaveConditions(map));
		return Db.queryLong(sb.toString(), siteId);
	}

	public String employeLeaveConditions(Map<String, Object> map) {
		StringBuilder sb = new StringBuilder();
		if (map.get("employeName") != null) {
			if (StringUtils.isNotBlank(map.get("employeName").toString())) {
				sb.append(" and a.employe_name like '%" + map.get("employeName") + "%'");
			}
		}
		String mark = "1";
		if (map.get("leaveTimeMin") != null && map.get("leaveTimeMax") != null && StringUtils.isNotBlank(map.get("leaveTimeMin").toString())
				&& StringUtils.isNotBlank(map.get("leaveTimeMax").toString())) {
			sb.append(" and ((a.start_time >= '" + map.get("leaveTimeMin") + "' and '" + map.get("leaveTimeMax") + "' >= a.start_time) or (a.end_time >= '"
					+ map.get("leaveTimeMin") + "' and '" + map.get("leaveTimeMax") + "' >= a.end_time))");
		} else {
			if (map.get("leaveTimeMin") != null) {
				if (StringUtils.isNotBlank(map.get("leaveTimeMin").toString())) {
					mark = "2";
					sb.append(" and a.end_time >= '" + map.get("leaveTimeMin") + "' ");
				}
			}
			if (map.get("leaveTimeMax") != null) {
				if (StringUtils.isNotBlank(map.get("leaveTimeMax").toString())) {
					sb.append(" and '" + map.get("leaveTimeMax") + "' >= a.start_time");
				}
			}
		}
		return sb.toString();
	}

	public Boolean editSignTime(String rowId, String signTime, String signType) {// 修改打卡时间
		return employeDailySignDao.editSignTime(rowId, signTime, signType);
	}

	public Record ifExist(String siteId) {
		return employeDailySignDao.ifExist(siteId);
	}

	public String saveSign(String workingTime, String offWorkingTime, String signPoint, Integer signRange, BigDecimal latitude, BigDecimal longitude, String employeIds) {
		return employeDailySignDao.saveSign(workingTime, offWorkingTime, signPoint, signRange, latitude, longitude, employeIds);
	}

	public void deleteSign(String id) {
		SiteSignRule siteSignRule = siteSignRuleDao.get(id);
		siteSignRule.setStatus("1");
		siteSignRuleDao.save(siteSignRule);
	}

	public Record getInfoById(String id, String siteId) {
		return Db.findFirst(
				"SELECT *,DATE_FORMAT(working_time,'%H:%i:%s') as workingTime,DATE_FORMAT(off_working_time,'%H:%i:%s') as offWorkingTime  FROM crm_site_sign_rule WHERE id=? AND STATUS='0' AND site_id=?",
				id, siteId);
	}

	public List<Record> getSignInfos(String siteId) {
		return Db.find("SELECT * FROM crm_site_sign_rule WHERE STATUS='0' AND site_id=?", siteId);
	}

	public String saveSignEdit(String workingTime, String offWorkingTime, String signPoint, Integer signRange, BigDecimal latitude, BigDecimal longitude, String signId,
			String employeIds) {
		return employeDailySignDao.saveSignEdit(workingTime, offWorkingTime, signPoint, signRange, latitude, longitude, signId, employeIds);
	}

	// 导出数据的不分页查询所有数据
	public List<Record> employeDailySignforexcel(String siteId, Map<String, Object> map) {
		List<Record> employeDailySignList = employeDailySignDao.employeDailySignforexcel(siteId, map);
		return employeDailySignList;
	}

	/**
	 * 考情设置记录
	 * 
	 * @param siteId
	 * @param page
	 * @return
	 */
	public Page<Record> getSignSetList(String siteId, Page<Record> page) {
		List<Record> reList = employeDailySignDao.getSignList(siteId, page);
		for (Record re : reList) {
			String empNams = "";
			if (StringUtils.isNotBlank(re.getStr("employe_id"))) {
				String[] employeIds = re.getStr("employe_id").split(",");
				String sql = "select * from crm_employe where id in (" + StringUtil.joinInSql(employeIds) + ") and site_id=? and status='0' ";
				List<Record> empList = Db.find(sql, siteId);
				int i = 0;
				for (Record emp : empList) {
					if (i == empList.size()) {
						empNams += emp.getStr("name");
					} else {
						empNams += emp.getStr("name") + ",";
					}
					i++;
				}
			}
			re.set("employeNames", empNams);
		}
		page.setList(reList);
		page.setCount(employeDailySignDao.getSignListCount(siteId));
		return page;
	}

	public String checkIfExistEmp(String siteId, String eids, String id) {
		String sql = "select a.employe_id from crm_site_sign_rule a where a.status='0' and a.site_id=?";
		if (StringUtils.isNotBlank(id)) {
			sql = "select a.employe_id from crm_site_sign_rule a where a.status='0' and a.site_id=? and a.id!='" + id + "'";
		}
		List<Record> list = Db.find(sql, siteId);
		String empIds = "";
		String result = "ok";
		for (Record rd : list) {
			String eIds = rd.getStr("employe_id");
			if (StringUtils.isNotBlank(eIds)) {
				if (StringUtils.isBlank(empIds)) {
					empIds = eIds;
				} else {
					empIds += "," + eIds;
				}
			}
		}
		String[] ids = null;
		if (StringUtils.isNotBlank(empIds)) {
			ids = empIds.split(",");
			Set<String> set = new HashSet<>();
			for (int i = 0; i < ids.length; i++) {
				set.add(ids[i]);
			}
			if (StringUtils.isNotBlank(eids)) {
				String[] eIds = eids.split(",");
				for (int j = 0; j < eIds.length; j++) {
					Boolean rt = set.add(eIds[j]);
					if (!rt) {
						result = "no";
						break;
					}
				}
			}
		}
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	public String saveAddSignSet(Map<String, Object> map) {
		User user = UserUtils.getUser();
		String siteId = CrmUtils.getCurrentSiteId(user);
		String result = checkIfExistEmp(siteId, map.get("employeIds") != null ? map.get("employeIds").toString() : "", "");
		if ("no".equals(result)) {
			return "421";
		}
		Date dt = new Date();
		String addresses = map.get("signPoint") != null ? map.get("signPoint").toString() : "";
		Integer signNum = Integer.valueOf(map.get("signNum").toString());
		Long count = Db.queryLong("select count(*) from crm_site_sign_rule a where a.status='0' and a.site_id=?", siteId);
		SiteSignRule ssr = new SiteSignRule();
		if (StringUtils.isNotBlank(addresses)) {
			double[] address = Apiutils.addressToGPS(addresses);
			if (address != null) {
				ssr.setLatitude(new BigDecimal(address[1]));
				ssr.setLongitude(new BigDecimal(address[0]));
			}
		}
		ssr.setType("0");
		if (count > 0) {
			ssr.setType("1");
		}
		ssr.setCreateTime(dt);
		ssr.setEmployeId(map.get("employeIds") != null ? map.get("employeIds").toString() : "");

		ssr.setSignNum(signNum);
		ssr.setSignPoint(map.get("signPoint").toString());
		if (map.get("signRange") != null) {
			if (StringUtils.isNotBlank(map.get("signRange").toString())) {
				ssr.setSignRange(Integer.valueOf(map.get("signRange").toString()));
			}
		}
		ssr.setSiteId(siteId);
		ssr.setStatus("0");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			ssr.setOffWorkingTime(formatter.parse(map.get("off1").toString()));
			ssr.setWorkingTime(formatter.parse(map.get("on1").toString()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		SignJson sj = new SignJson();
		sj.setOn(map.get("on1").toString());
		sj.setOff(map.get("off1").toString());
		String str = WebPageFunUtils.appendSignJson(sj, "");
		if (signNum != 1) {
			SignJson sj1 = new SignJson();
			sj1.setOn(map.get("on2").toString());
			sj1.setOff(map.get("off2").toString());
			str = WebPageFunUtils.appendSignJson(sj1, str);
			if (signNum == 3) {
				SignJson sj2 = new SignJson();
				sj2.setOn(map.get("on3").toString());
				sj2.setOff(map.get("off3").toString());
				str = WebPageFunUtils.appendSignJson(sj2, str);
			}
		}
		ssr.setSignTimes(str);
		siteSignRuleDao.save(ssr);
		return "200";
	}

	@Transactional(rollbackFor = Exception.class)
	public String saveEditSignSet(Map<String, Object> map) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = map.get("id").toString();
		Long count = Db.queryLong("select count(*) from crm_site_sign_rule a where a.status='0' and a.id=?", map.get("id"));
		if (count < 1) {
			return "420";// 已删除
		}
		String result = checkIfExistEmp(siteId, map.get("employeIds") != null ? map.get("employeIds").toString() : "", id);
		if ("no".equals(result)) {
			return "421";
		}
		String addresses = map.get("signPoint") != null ? map.get("signPoint").toString() : "";
		Integer signNum = Integer.valueOf(map.get("signNum").toString());
		SiteSignRule ssr = siteSignRuleDao.get(id);
		if (StringUtils.isNotBlank(addresses)) {
			double[] address = Apiutils.addressToGPS(addresses);
			if (address != null) {
				ssr.setLatitude(new BigDecimal(address[1]));
				ssr.setLongitude(new BigDecimal(address[0]));
			}
		}
		ssr.setEmployeId(map.get("employeIds") != null ? map.get("employeIds").toString() : "");

		ssr.setSignPoint(map.get("signPoint").toString());
		if (map.get("signRange") != null) {
			if (StringUtils.isNotBlank(map.get("signRange").toString())) {
				ssr.setSignRange(Integer.valueOf(map.get("signRange").toString()));
			} else {
				ssr.setSignRange(null);
			}
		}
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			ssr.setOffWorkingTime(formatter.parse(map.get("off1").toString()));
			ssr.setWorkingTime(formatter.parse(map.get("on1").toString()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		SignJson sj = new SignJson();
		sj.setOn(map.get("on1").toString());
		sj.setOff(map.get("off1").toString());
		String str = WebPageFunUtils.appendSignJson(sj, "");
		if (signNum != 1) {
			SignJson sj1 = new SignJson();
			sj1.setOn(map.get("on2").toString());
			sj1.setOff(map.get("off2").toString());
			str = WebPageFunUtils.appendSignJson(sj1, str);
			if (signNum == 3) {
				SignJson sj2 = new SignJson();
				sj2.setOn(map.get("on3").toString());
				sj2.setOff(map.get("off3").toString());
				str = WebPageFunUtils.appendSignJson(sj2, str);
			}
		}
		ssr.setSignTimes(str);
		siteSignRuleDao.save(ssr);
		return "200";
	}

	public Record getSingSetById(String id) {
		Record rd = Db.findFirst("select a.* from crm_site_sign_rule a where a.id=? limit 1", id);
		String empId = rd.getStr("employe_id") != null ? rd.getStr("employe_id") : "";
		String[] arrays = empId.split(",");
		rd.set("idsArr", arrays);
		return rd;
	}

	public String getDefaultSign(String siteId) {
		Record rd = Db.findFirst("select a.sign_num from crm_site_sign_rule a where a.site_id=? and a.status='0' limit 1", siteId);
		if (rd != null) {
			return "ok";
		}
		return "no";
	}

	public Integer getDefaultSignTimeList(String siteId) {
		Record rd = Db.findFirst("select a.sign_num from crm_site_sign_rule a where a.site_id=? and a.status='0' limit 1", siteId);
		if (rd != null) {
			ArrayList<SignJson> lists = WebPageFunUtils.getSignTimesList(rd.getStr("sign_times"));
			return rd.getInt("sign_num");
		}
		return 0;
	}

	public String getDefaultSignNum(String siteId) {
		Record rd = Db.findFirst("select a.sign_num from crm_site_sign_rule a where a.site_id=? and a.status='0' limit 1", siteId);
		if (rd != null) {
			return rd.getInt("sign_num").toString();
		}
		return "1";
	}

	public Page<Record> getSignSetDetailList(String siteId, Page<Record> page, Map<String, Object> map) {
		if (map.get("pageSize") != null) {
			if (StringUtils.isNotBlank(map.get("pageSize").toString())) {
				page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
				page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			}
		}
		String signNum = "1";
		if (map.get("signNum") != null) {
			signNum = map.get("signNum").toString();
		} else {
			Record rd = Db.findFirst("select a.sign_num from crm_site_sign_rule a where a.site_id=? and a.status='0' limit 1", siteId);
			if (rd != null) {
				signNum = rd.getInt("sign_num").toString();
			}
		}
		List<Record> list = new ArrayList<Record>();
		StringBuilder sb = new StringBuilder();
		sb.append("select a.* from crm_site_sign_rule a where a.status='0' and a.site_id=? ");
		sb.append(" and a.sign_num=?");
		sb.append(" order by a.type,a.create_time desc");
		if (page != null) {
			sb.append(" limit " + page.getPageSize() + " offset " + (page.getPageNo() - 1) * page.getPageSize());
		}
		list = Db.find(sb.toString(), siteId, signNum);
		for (Record rd2 : list) {
			String employeIds = rd2.getStr("employe_id");
			String names = "";
			if (StringUtils.isNotBlank(employeIds)) {
				List<Record> list1 = Db.find("select a.name from crm_employe a where a.status='0' and a.id in (" + StringUtil.joinInSql(employeIds.split(",")) + ")");
				for (Record rd1 : list1) {
					if (StringUtils.isBlank(names)) {
						names = rd1.getStr("name");
					} else {
						names += "," + rd1.getStr("name");
					}
				}
			}
			rd2.set("names", names);
		}
		Long count = Db.queryLong("select count(*) from crm_site_sign_rule a where a.status='0' and a.site_id=? and a.sign_num=?", siteId, signNum);
		page.setCount(count);
		page.setList(list);
		return page;
	}

	@Transactional(rollbackFor = Exception.class)
	public void deleteOtherTimes(Map<String, Object> map, String siteId) {
		SQLQuery sql = siteSignRuleDao.getSession()
				.createSQLQuery("update crm_site_sign_rule a set a.status='1' where a.site_id=:siteId and a.status='0' and a.sign_num!=:signNum");
		sql.setParameter("siteId", siteId);
		sql.setParameter("signNum", map.get("signNum"));
		sql.executeUpdate();
	}

	public Page<Record> getEmployeDailySignList(Page<Record> page, String siteId, Map<String, Object> map, List<Record> finalList, List<String> listDate, Long countPage) {// 查询grid表格
		List<Record> list = getSignList(page, siteId, map, finalList);
		// Long count = getSignCount(siteId, map, listDate);
		page.setList(list);
		page.setCount(countPage);
		return page;
	}

	/*
	 * 根据日期、网点查询工程师的请假记录
	 */
	public List<Record> getEmployeLeaveListByDate(Map<String, Object> map) {
		return Db.find("");
	}

	public List<Record> getSignList(Page<Record> page, String siteId, Map<String, Object> map, List<Record> finalList) {
		List<Record> list = new ArrayList<Record>();
		for (Record fl : finalList) {
			String date = fl.getStr("date").substring(0, 10);
			String id = fl.getStr("empId");// 工程师的id
			Record rdSet = Db.findFirst("select a.sign_times,a.type from crm_site_sign_rule a where a.status='0' and FIND_IN_SET(?,a.employe_id) and a.site_id=? limit 1", id,
					siteId);
			if (rdSet == null) {// rdSet为工程师对应的考勤规则
				rdSet = Db.findFirst(
						"select a.sign_times,a.type from crm_site_sign_rule a where a.status='0' and a.site_id=? and (a.employe_id is null or a.employe_id='') limit 1", siteId);
			}
			if (rdSet == null) {// 如果工程师考勤规则没有的话则跳出本次循环
				list.add(new Record());
				continue;
			}
			String signNums = map.get("signNums") != null ? map.get("signNums").toString() : "";
			Integer sgNum = StringUtils.isNotBlank(signNums) ? Integer.valueOf(signNums.substring(0, 1)) : 0;
			Integer sgType = StringUtils.isNotBlank(signNums) ? Integer.valueOf(signNums.substring(1, 2)) : 0;
			String sgTimes = rdSet.getStr("sign_times");
			List<SignJson> listSj = WebPageFunUtils.getSignTimesList(sgTimes);
			List<Record> listn = new ArrayList<Record>();
			StringBuilder sd1 = new StringBuilder();
			sd1.append("select a.*,DATE_FORMAT(a.sign_time,'%H:%i') as signTime from crm_employe_daily_sign a where a.status='0' and a.site_id=? and a.employe_id=? and ('" + date
					+ " 00:00:00" + "'<= a.sign_time AND a.sign_time <= '" + date + " 23:59:50" + "') and a.sign_serial<='" + listSj.size() + "'  ");
			if (map.get("signResult") != null && StringUtils.isNotBlank(map.get("signResult").toString())) {
				if (!"4".equals(map.get("signResult").toString())) {// 未打卡除外
					sd1.append(" and a.sign_result='" + map.get("signResult") + "'");
				}
			}
			if (map.get("signType") != null && StringUtils.isNotBlank(map.get("signType").toString())) {
				sd1.append(" and a.sign_type='" + map.get("signType") + "'");
			}
			sd1.append(" order by a.sign_type asc");
			List<Record> listDeal = Db.find(sd1.toString(), siteId, id);

			// List<Record> empLeaveList = getEmployeLeaveListByDate(map);
			String signTypes = map.get("signType") != null ? map.get("signType").toString() : "";
			String signResults = map.get("signResult") != null ? map.get("signResult").toString() : "";
			if ("4".equals(signResults)) {// 条件查询——未打卡的情况
				for (int i = 1; i <= listSj.size(); i++) {
					if (sgNum > 0) {// 有打卡班次查询
						if (sgNum == i) {
							String nums = String.valueOf(i);
							for (int j = 1; j <= 2; j++) {
								if (sgType == j) {
									String types = String.valueOf(j);
									Record rdn = new Record();
									rdn.set("sign_serial", nums);// 班次
									rdn.set("sign_type", types);// 1签到or2签退or3未打卡 标记
									if (listDeal.size() < 1) {
										listn.add(rdn);
									} else {
										String mark1 = "1";
										String mark2 = "1";
										for (Record rdd : listDeal) {
											Integer h = rdd.getInt("sign_serial");
											Integer signType = Integer.valueOf(rdd.getStr("sign_type"));
											Integer signResult = Integer.valueOf(rdd.getStr("sign_result"));
											if (i == h) {
												mark1 = "2";
												if (j == signType) {// 签到签退分别生成一条记录
													if (sgType == signType) {
														mark2 = "2";
													}
												}
											} else {

											}
										}
										if ("1".equals(mark1)) {// 没有这个打卡时段的记录
											listn.add(rdn);
										} else {
											if ("1".equals(mark2)) {
												listn.add(rdn);
											}
										}
									}
								}
							}
						}
					} else {// 没有打卡班次查询
						String nums = String.valueOf(i);
						for (int j = 1; j <= 2; j++) {
							String types = String.valueOf(j);
							Record rdn = new Record();
							rdn.set("sign_serial", nums);// 班次
							rdn.set("sign_type", types);// 1签到or2签退or3未打卡 标记
							if (listDeal.size() < 1) {
								listn.add(rdn);
							} else {
								String mark1 = "1";
								String mark2 = "1";
								for (Record rdd : listDeal) {
									Integer h = rdd.getInt("sign_serial");
									Integer signType = Integer.valueOf(rdd.getStr("sign_type"));
									Integer signResult = Integer.valueOf(rdd.getStr("sign_result"));
									if (i == h) {
										mark1 = "2";
										if (j == signType) {// 签到签退分别生成一条记录
											mark2 = "2";
										}
									} else {

									}
								}
								if ("1".equals(mark1)) {// 没有这个打卡时段的记录
									listn.add(rdn);
								} else {
									if ("1".equals(mark2)) {
										listn.add(rdn);
									}
								}
							}
						}
					}

				}
			} else {
				for (int i = 1; i <= listSj.size(); i++) {
					if (sgNum > 0) {// 有打卡班次
						if (sgNum == i) {
							String nums = String.valueOf(i);

							for (int j = 1; j <= 2; j++) {
								if (sgType == j) {
									String types = String.valueOf(j);
									Record rdn = new Record();
									rdn.set("sign_serial", nums);// 班次
									rdn.set("sign_type", types);// 1签到or2签退or3未打卡 标记
									outer: for (Record rdd : listDeal) {
										Integer h = rdd.getInt("sign_serial");
										Integer signType = Integer.valueOf(rdd.getStr("sign_type"));
										Integer signResult = Integer.valueOf(rdd.getStr("sign_result"));
										// sgType
										if (i == h) {
											if (j == signType) {// 签到签退分别生成一条记录
												if (StringUtils.isNotBlank(signTypes) || StringUtils.isNotBlank(signResults)) {
													rdn = rdd;
													listn.add(rdn);
												} else {
													rdn = rdd;
													break outer;
												}
											}
										}
									}
									if (StringUtils.isNotBlank(signTypes) || StringUtils.isNotBlank(signResults)) {// 条件查询对应的打卡类型签到或者签退
									} else {
										listn.add(rdn);
									}
								}
							}
						}

					} else {
						String nums = String.valueOf(i);
						for (int j = 1; j <= 2; j++) {
							String types = String.valueOf(j);
							Record rdn = new Record();
							rdn.set("sign_serial", nums);// 班次
							rdn.set("sign_type", types);// 1签到or2签退or3未打卡 标记
							outer: for (Record rdd : listDeal) {
								Integer h = rdd.getInt("sign_serial");
								Integer signType = Integer.valueOf(rdd.getStr("sign_type"));
								Integer signResult = Integer.valueOf(rdd.getStr("sign_result"));
								if (i == h) {
									if (j == signType) {// 签到签退分别生成一条记录
										if (StringUtils.isNotBlank(signTypes) || StringUtils.isNotBlank(signResults)) {
											rdn = rdd;
											listn.add(rdn);
										} else {
											rdn = rdd;
											break outer;
										}
									}
								}
							}
							if (StringUtils.isNotBlank(signTypes) || StringUtils.isNotBlank(signResults) || sgType > 0) {// 条件查询对应的打卡类型签到或者签退
							} else {
								listn.add(rdn);
							}
						}
					}
				}
			}
			fl.set("detailList", listn);
		}
		return finalList;
	}

	public Long getSignCount(String siteId, Map<String, Object> map, List<String> listDate) {
		StringBuilder sf = new StringBuilder();
		sf.append("select count(*) from crm_employe e inner join sys_user u on e.user_id=u.id where e.status='0' and u.status='0' and e.site_id=?");
		if (map.get("employeName") != null) {
			if (StringUtils.isNotBlank(map.get("employeName").toString())) {
				sf.append(" and e.name like '%" + map.get("employeName") + "%'");
			}
		}
		Long count = Db.queryLong(sf.toString(), siteId);
		return count * listDate.size();
	}

	public List<Record> getAllEmpList(String siteId, Map<String, Object> map) {
		Record rdSet = Db.findFirst("select a.sign_times,a.type from crm_site_sign_rule a where a.status='0' and a.site_id=? and (a.employe_id is null or a.employe_id='') limit 1",
				siteId);
		if (rdSet == null) {
			return new ArrayList<Record>();
		}
		List<SignJson> listTimes = WebPageFunUtils.getSignTimesListUsed(rdSet.getStr("sign_times"));
		String signResult = map.get("signResult") != null ? map.get("signResult").toString() : "";
		String signType = map.get("signType") != null ? map.get("signType").toString() : "";
		if ("4".equals(signResult) && ("1".equals(signType) || "2".equals(signType))) {// 未打卡
			return new ArrayList<Record>();
		}
		StringBuilder sf = new StringBuilder();
		sf.append("select e.id,e.name from crm_employe e inner join sys_user u on e.user_id=u.id  ");
		sf.append(" where e.status='0' and u.status='0' and e.site_id=? ");
		if (map.get("employeName") != null) {
			if (StringUtils.isNotBlank(map.get("employeName").toString())) {
				sf.append(" and e.name like '%" + map.get("employeName") + "%'");
			}
		}
		sf.append("group by e.id order by e.create_time,e.id desc");
		return Db.find(sf.toString(), siteId);
	}

	@Transactional(rollbackFor = Exception.class)
	public String editSignTimes(Map<String, Object> map, String siteId) {
		String empId = map.get("editEmpId").toString();// 工程师Id
		Record rd = Db.findFirst("select a.employe_id,a.sign_serial,a.rule_type,a.sign_type from crm_employe_daily_sign a where a.id=? and a.status='0' limit 1",
				map.get("recordId"));

		Record rdSet = Db.findFirst("select a.sign_times,a.type from crm_site_sign_rule a where a.status='0' and FIND_IN_SET(?,a.employe_id) and a.site_id=? limit 1", empId,
				siteId);
		if (rdSet == null) {// 默认考勤
			rdSet = Db.findFirst("select a.sign_times,a.type from crm_site_sign_rule a where a.status='0' and a.site_id=? and (a.employe_id is null or a.employe_id='') limit 1",
					siteId);
		}
		if (rdSet == null) {
			return "421";// 无任何考勤规则
		}
		Integer signNum = Integer.valueOf(map.get("editSignSerial").toString());
		String signType = map.get("editSignType").toString();

		List<SignJson> listTimes = WebPageFunUtils.getSignTimesListUsed(rdSet.getStr("sign_times"));
		SignJson sj = listTimes.get(signNum - 1);
		String standardTime = sj.getOn();// 标准时间 格式：2017-08-12 09:09:00
		if ("2".equals(signType)) {// 签退
			standardTime = sj.getOff();
		}
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date standardDate = null;
		try {
			standardDate = format.parse(standardTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String editTime = sdf.format(standardDate).substring(0, 10) + " " + map.get("signTime").toString() + ":00";// 修改后的时间
		Date editDate = null;
		try {
			editDate = format.parse(editTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String editSignResult = "0";
		Long outTime = null;
		long dtSd = standardDate.getTime();
		long dtEd = editDate.getTime();
		if ("1".equals(signType)) {// 签到
			if (dtSd < dtEd) {// 迟到
				long rt = (dtEd - dtSd) / (1000 * 60);
				editSignResult = "1";
				outTime = rt;
			}
		} else {// 签退
			if (dtSd > dtEd) {// 早退
				long rt = (dtSd - dtEd) / (1000 * 60);
				editSignResult = "2";
				outTime = rt;
			}
		}
		if (map.get("recordId") == null || rd == null) {// 这条打卡记录不存在,则新增
			EmployeDailySign eds = new EmployeDailySign();
			String sgdt = map.get("editSignDate").toString() + " " + map.get("signTime").toString() + ":00";
			DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
			DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			Date dt = new Date();
			Date dt1 = null;
			Date dt3 = null;
			try {
				dt1 = format1.parse(map.get("editSignDate").toString());
				dt3 = format2.parse(sgdt);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			Site site = siteDao.get(siteId);
			String signAddress = (site.getProvince().equals(site.getCity()) ? site.getProvince() : (site.getProvince() + site.getCity())) + site.getArea() + site.getAddress();
			double[] lalt = Apiutils.addressToGPS(signAddress);
			BigDecimal lat = lalt != null ? BigDecimal.valueOf(lalt[0]) : null;
			BigDecimal lgt = lalt != null ? BigDecimal.valueOf(lalt[1]) : null;
			Employe employe = employeDao.get(empId);
			eds.setDate(dt1);
			eds.setCreateTime(dt);
			eds.setEmployeId(empId);
			eds.setEmployeName(employe != null ? employe.getName() : "");
			eds.setRuleType(rdSet.getStr("type"));
			eds.setSignAddress(signAddress);
			eds.setSignLatitude(lat);
			eds.setSignLongitude(lgt);
			eds.setSiteId(siteId);
			eds.setStatus("0");
			eds.setSignType(map.get("editSignType").toString());
			eds.setSignSerial(Integer.valueOf(map.get("editSignSerial").toString()));
			eds.setSignResult(editSignResult);
			eds.setSignTime(dt3);
			eds.setOutTime(outTime != null ? outTime.intValue() : null);
			employeDailySignDao.save(eds);
			return "200";
		} else {// 打卡记录存在,否则修改
			String id = map.get("recordId").toString();

			SQLQuery sql = employeDailySignDao.getSession()
					.createSQLQuery("update crm_employe_daily_sign a set a.sign_result=:signResult,a.out_time=:outTime,a.sign_time=:signTime where a.id=:id");
			sql.setParameter("signResult", editSignResult);
			sql.setParameter("outTime", outTime);
			sql.setParameter("signTime", map.get("editSignDate").toString() + " " + map.get("signTime").toString() + ":00");
			sql.setParameter("id", id);
			sql.executeUpdate();
			return "200";
		}
	}

	public Map<String, Object> getConditionsSelect(Map<String, Object> map, Integer leng) {
		Map<String, Object> map2 = new HashMap<String, Object>();
		List<Record> list = new ArrayList<Record>();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String mark = "1";
		String signNums = map.get("signNums") != null ? map.get("signNums").toString() : "";
		Integer sgNum = StringUtils.isNotBlank(signNums) ? Integer.valueOf(signNums.substring(0, 1)) : 0;
		Integer sgType = StringUtils.isNotBlank(signNums) ? Integer.valueOf(signNums.substring(1, 2)) : 0;
		if (map.get("signResult") != null && StringUtils.isNotBlank(map.get("signResult").toString())) {
			mark = "2";
			String signResult = map.get("signResult").toString();
			StringBuilder sb = new StringBuilder();
			sb.append("select a.employe_id,a.date from crm_employe_daily_sign a where a.status='0' and a.sign_serial <=" + leng + " and a.site_id=? and a.date >= '"
					+ map.get("startDate1") + " 00:00:00" + "' and a.date<='" + map.get("endDate1") + " 23:59:59" + "' ");
			if (!"4".equals(signResult)) {// 未打卡除外
				sb.append(" and a.sign_result='" + signResult + "'");
			}
			if (map.get("signType") != null && StringUtils.isNotBlank(map.get("signType").toString())) {
				if (StringUtils.isNotBlank(signNums)) {
					if (sgType != Integer.valueOf(map.get("signType").toString())) {
						list = new ArrayList<>();
						map2.put("list", list);
						map2.put("mark", mark);
						return map2;
					}
				}
				sb.append(" and a.sign_type='" + map.get("signType") + "'");

			}
			if (StringUtils.isNotBlank(signNums)) {
				if (sgType != Integer.valueOf(signResult) && !"0".equals(signResult) && !"4".equals(signResult)) {
					list = new ArrayList<>();
					map2.put("list", list);
					map2.put("mark", mark);
					return map2;
				}

				if ("0".equals(signResult)) {// 正常情况
					sb.append(" and a.sign_type='" + sgType + "'");
				}
				if ("4".equals(signResult)) {// 未打卡情况
					sb.append(" and a.sign_type='" + sgType + "'");
				}
				sb.append(" and a.sign_serial='" + sgNum + "'");
			}
			if ("4".equals(signResult)) {

			} else {
				sb.append(" group by a.employe_id,a.date");
			}

			list = Db.find(sb.toString(), siteId);
		} else {
			if (map.get("signType") != null) {
				String signType = map.get("signType").toString();
				if (StringUtils.isNotBlank(signType)) {
					mark = "2";
					StringBuilder sd = new StringBuilder();
					sd.append("select a.employe_id,a.date from crm_employe_daily_sign a where a.status='0' and a.sign_serial <=" + leng
							+ "  and  a.sign_type=? and a.site_id=? and a.date >= '" + map.get("startDate1") + " 00:00:00" + "' and a.date<='" + map.get("endDate1") + " 23:59:59"
							+ "'");
					if (StringUtils.isNotBlank(signNums)) {
						if (sgType == Integer.valueOf(signType)) {
							sd.append(" and a.sign_serial='" + sgNum + "'");
						} else {
							list = new ArrayList<>();
							map2.put("list", list);
							map2.put("mark", mark);
							return map2;
						}
					}
					sd.append(" group by a.employe_id,a.date");
					list = Db.find(sd.toString(), signType, siteId);

				}
			}
		}
		map2.put("list", list);
		map2.put("mark", mark);
		return map2;
	}

	// 考勤记录分页
	public Map<String, Object> dealFinalList(List<Record> listEmp, List<String> listDate, Map<String, Object> map) {
		Map<String, Object> mapsn = new HashMap<String, Object>();
		// 获取默认考勤时间分段
		Record rdDf = Db.findFirst(
				"select a.sign_times,a.sign_num from crm_site_sign_rule a  where a.status='0' and a.site_id=? and (a.employe_id is null or a.employe_id='') limit 1 ",
				map.get("siteId"));
		Integer leng = 0;
		if (rdDf != null) {
			String signTimes = rdDf.getStr("sign_times");
			List<SignJson> listTimes = WebPageFunUtils.getSignTimesListUsed(signTimes);
			leng = listTimes.size() * 2;
		}
		Integer pageNo = Integer.valueOf(map.get("pageNo").toString());
		Integer pageSize = Integer.valueOf(map.get("pageSize").toString());
		String signNums = map.get("signNums") != null ? map.get("signNums").toString() : "";
		Integer sgNum = StringUtils.isNotBlank(signNums) ? Integer.valueOf(signNums.substring(0, 1)) : 0;
		Integer sgType = StringUtils.isNotBlank(signNums) ? Integer.valueOf(signNums.substring(1, 2)) : 0;
		Map<String, Object> map2 = getConditionsSelect(map, leng / 2);
		List<Record> listn = (List<Record>) map2.get("list");
		String mark = map2.get("mark").toString();
		List<Record> list = new ArrayList<Record>();
		for (String str : listDate) {
			for (Record rd1 : listEmp) {
				if ("2".equals(mark)) {// 条件查询
					// 打卡的情况
					if (map.get("signResult") != null && "4".equals(map.get("signResult"))) {// 未打卡的情况
						if (StringUtils.isNotBlank(signNums)) {
							int k = 1;
							for (Record rd2 : listn) {
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								String date = sdf.format(rd2.getDate("date"));
								String empId = rd2.getStr("employe_id");
								if (str.equals(date) && empId.equals(rd1.getStr("id"))) {
									k = 2;
								}
							}
							if (k == 1) {
								Record rd = new Record();
								rd.set("date", str);
								rd.set("empName", rd1.getStr("name"));
								rd.set("empId", rd1.getStr("id"));
								list.add(rd);
							}
						} else {
							Integer i = 0;
							for (Record rd2 : listn) {
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								String date = sdf.format(rd2.getDate("date"));
								String empId = rd2.getStr("employe_id");
								if (str.equals(date) && empId.equals(rd1.getStr("id"))) {
									i++;
								}
							}
							if (leng > 0) {
								if (i != leng) {
									Record rd = new Record();
									rd.set("date", str);
									rd.set("empName", rd1.getStr("name"));
									rd.set("empId", rd1.getStr("id"));
									list.add(rd);
								}
							}
						}
					} else {
						for (Record rd2 : listn) {
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							String date = sdf.format(rd2.getDate("date"));
							String empId = rd2.getStr("employe_id");
							if (str.equals(date) && empId.equals(rd1.getStr("id"))) {
								Record rd = new Record();
								rd.set("date", str);
								rd.set("empName", rd1.getStr("name"));
								rd.set("empId", rd1.getStr("id"));
								list.add(rd);
							}
						}
					}
				} else {// 非条件查询

					Record rd = new Record();
					rd.set("date", str);
					rd.set("empName", rd1.getStr("name"));
					rd.set("empId", rd1.getStr("id"));
					list.add(rd);
				}
			}
		}

		String sql2 = "SELECT a.employe_id,DATE_FORMAT(a.end_time,'%Y-%m-%d') as endTime,DATE_FORMAT(a.start_time,'%Y-%m-%d') as startTime FROM crm_employe_leave a WHERE a.status='0' AND a.site_id=? AND (('"
				+ map.get("startDate1") + " 00:00:00'<=a.start_time and a.start_time<='" + map.get("endDate1") + " 23:59:59') or ('" + map.get("startDate1")
				+ " 00:00:00'<=a.end_time and a.end_time<='" + map.get("endDate1") + " 23:59:59')) ";
		List<Record> listLeave = Db.find(sql2, map.get("siteId"));
		List<Record> lists = new ArrayList<Record>();
		String ifLeave = map.get("ifLeave") != null ? map.get("ifLeave").toString() : "";// 是否请假
		for (Record rdf : list) {
			String empId = rdf.getStr("empId");
			String date = rdf.getStr("date");
			rdf.set("ifleave", "1");
			for (Record rd0 : listLeave) {
				String startTime = rd0.getStr("startTime");
				String endTime = rd0.getStr("endTime");
				String employeId = rd0.getStr("employe_id");
				if (startTime.equals(date) || endTime.equals(date)) {
					if (employeId.equals(empId)) {
						rdf.set("ifleave", "2");
						break;
					}
				}
			}
			if (StringUtils.isNotBlank(ifLeave)) {// 有是否请假的查询条件
				if ("1".equals(ifLeave)) {// 否
					if ("1".equals(rdf.get("ifleave"))) {
						lists.add(rdf);
					}
				} else {// 是
					if ("2".equals(rdf.get("ifleave"))) {
						lists.add(rdf);
					}
				}
			}
		}
		if (StringUtils.isNotBlank(ifLeave)) {
			list = lists;
		}
		List<Record> finalList = new ArrayList<Record>();
		for (int i = (pageNo - 1) * pageSize; i < (pageNo - 1) * pageSize + pageSize; i++) {
			if (i < list.size()) {
				finalList.add(list.get(i));
			}
		}
		mapsn.put("list", finalList);
		mapsn.put("count", list.size());
		return mapsn;
	}

	public Record getSignDetailById(String id) {
		return Db.findFirst("select a.*,DATE_FORMAT(a.sign_time,'%H:%i') as signTime from crm_employe_daily_sign a where a.id=? and a.status='0' ", id);
	}

	public Map<String, Object> getAnnouncement(String siteId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Record> list = Db.find(
				"SELECT e.name FROM crm_employe e inner join sys_user u on e.user_id=u.id WHERE e.status='0' and u.status='0' AND e.site_id=? AND e.id NOT IN (SELECT a.employe_id FROM crm_employe_daily_sign a WHERE DATE(a.date) = CURDATE() AND a.status='0' AND a.site_id=? ) order by e.create_time,e.id desc",
				siteId, siteId);
		String names = "";
		int i = 0;
		for (Record rd : list) {
			String name = rd.getStr("name");
			if (StringUtils.isBlank(names)) {
				names = name;
			} else {
				names += "、" + name;
			}
			i++;
		}
		map.put("names", names);
		map.put("count", i);
		return map;
	}

	public void delaEmployeSignTime() {
		List<SiteSignRule> list1 = getListEntitySiteSignRule();
		List<SiteSignRule> list = getListEntitySiteSignRule();
		for (SiteSignRule ssr : list1) {
			Date onDate = ssr.getWorkingTime();
			Date offDate = ssr.getOffWorkingTime();
			if (onDate != null && offDate != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SignJson sg = new SignJson();
				sg.setOn(sdf.format(onDate));
				sg.setOff(sdf.format(offDate));
				String str = WebPageFunUtils.appendSignJson(sg, "");
				ssr.setSignTimes(str);
				list.add(ssr);
			}
		}
		siteSignRuleDao.save(list);
	}

	public List<SiteSignRule> getListEntitySiteSignRule() {
		SQLQuery sqlQuery = siteSignRuleDao.getSession().createSQLQuery("SELECT a.* FROM crm_site_sign_rule a WHERE a.status='0' AND (a.sign_times IS NULL OR a.sign_times='')")
				.addEntity(SiteSignRule.class);
		return sqlQuery.list();
	}

}