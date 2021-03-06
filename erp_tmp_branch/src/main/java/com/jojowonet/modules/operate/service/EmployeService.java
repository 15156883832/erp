/**
 */
package com.jojowonet.modules.operate.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.service.AccountService;
import com.jojowonet.modules.operate.dao.EmployeDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.order.utils.Apiutils;
import com.jojowonet.modules.order.utils.GPSUtil;
import com.jojowonet.modules.order.utils.GetLocation;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.dao.RoleDao;
import com.jojowonet.modules.sys.dao.UserDao;
import com.jojowonet.modules.sys.service.SystemService;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 服务工程师Service
 *
 * @author Ivan
 * @version 2016-08-01
 */
@Component
@Transactional(readOnly = true)
public class EmployeService extends BaseService {

	@Autowired
	private EmployeDao employeDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	@Autowired
	private SystemService systemService;

	@Autowired
	private AccountService accountService;

	private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");

	public Employe get(String id) {
		return employeDao.get(id);
	}

	public List<Employe> getListEmp(Employe employe, String siteId) {
		return employeDao.getListEmp(employe, siteId);
	}

	@Transactional
	public void save(Employe employe) {
		employeDao.save(employe);
	}

	@Transactional
	public void delete(String id) {
		Employe employe = employeDao.get(id);
		if (employe != null) {
			User user = employe.getUser();
			if (user != null) {
				// userDao.deleteById(user.getId());
				userDao.updateStatus(user.getId(), "2");
			}
			employeDao.deleteById(id);
		}
	}

	public List<Record> findBySiteId(String siteId) {
		return employeDao.findBySiteId(siteId);
	}

	public List<Record> findBySiteIdExpectId(String empId, String siteId) {
		StringBuffer sb = new StringBuffer("");
		sb.append(" SELECT *  FROM crm_employe a WHERE a.site_id = ? AND a.status in ('0','3') and a.id!='" + empId + "' order by a.status asc ");
		return Db.find(sb.toString(), siteId);
	}

	public List<Record> getSameDayOnlineEmploye(String siteId, String empId) {
		List<Record> list = employeDao.getSameDayOnlineEmploye(siteId, empId);
		for (Record rd : list) {
			if (StringUtils.isNotEmpty(rd.getStr("longitude")) && StringUtils.isNotEmpty(rd.getStr("latitude"))) {
				String address = GetLocation.getAdd(rd.getStr("longitude"), rd.getStr("latitude"));
				rd.set("address", address);
				rd.set("time", formatter.format(rd.getDate("create_date")));
			}
		}
		return list;
	}

	public List<Record> getEmployeOrder2(String siteId, String lnglat, String category, String address) {
		List<Record> list = employeDao.getEmployeOrder2(siteId, category);
		boolean isCustomerLngLatOk = StringUtils.isNotEmpty(lnglat);
		String[] lnglats;
		String lng = null;
		String lat = null;
		if (isCustomerLngLatOk) {
			lnglats = lnglat.split(",");
			lng = lnglats[0];
			lat = lnglats[1];
		} else {
			if (StringUtils.isNotBlank(address)) {
				double[] da = Apiutils.addressToGPS(address);
				if (da != null) {
					lng = Double.toString(da[0]);
					lat = Double.toString(da[1]);
				}
			}
		}
		for (Record r : list) {
			double d;
			String lng1 = r.getStr("longitude");
			String lat1 = r.getStr("latitude");
			Date cdate = r.getDate("create_date");
			Long jrgds = r.getLong("jrgds");
			Long jrywg = r.getLong("jrywg");
//			Integer jrywg = r.getInt("jrywg");
			Long wwg = r.getLong("wwg");
			Long sywwg = r.getLong("sywwg");
			if (jrgds == null) {
				r.set("jrgds", 0);
			}
			if (jrywg == null) {
				r.set("jrywg", 0);
			}
			if (wwg == null) {
				r.set("wwg", 0);
			}
			if (sywwg == null) {
				r.set("sywwg", 0);
			}
			/*r.set("jrgds", "--");
			r.set("jrywg", "--");
			r.set("wwg", "--");
			r.set("sywwg", "--");
			r.set("jrywg", "--");*/

			if (StringUtils.isNotEmpty(lng) && StringUtils.isNotEmpty(lat) && StringUtils.isNotEmpty(lng1) && StringUtils.isNotEmpty(lat1) && isValidLngLat(cdate)) {
				d = GPSUtil.getDistance(lng, lat, lng1, lat1);
			} else {
				d = Double.MAX_VALUE;
			}
			r.set("distance", d);
			r.set("distance_formatted", d == Double.MAX_VALUE ? "未知" : String.format("%.1fKM", d));
		}
		Collections.sort(list, new MapComparator2());
		return list;
	}

	public List<Record> empSearch(String siteId, Integer category, String name) {

		return employeDao.empSearch(siteId, category, name);
	}

	public List<Record> getEmployeOrderAsc(String siteId) {

		return employeDao.getEmployeOrderAsc(siteId);
	}

	public List<Record> getEmployeOrderSum(String siteId) {
		return employeDao.getEmployeOrderSum(siteId);
	}

	private boolean isValidLngLat(Date createDate) {
		long now = System.currentTimeMillis();
		long diff = now - createDate.getTime();
		return diff < 60 * 1000 * 60;
	}

	@Deprecated
	public List<Map<String, String>> getEmployeOrder(String siteId, String lnglat) {
		List<Record> rds = employeDao.getEmployeOrder(siteId);
		List<Map<String, String>> list = Lists.newArrayList();
		String lng;
		String lat;
		if (StringUtils.isNotEmpty(lnglat)) {
			lng = lnglat.split(",")[0];
			lat = lnglat.split(",")[1];

			if (rds != null) {
				for (Record rd : rds) {
					Map<String, String> map = new HashMap<String, String>();
					String id = rd.getStr("id");
					String name = rd.getStr("name");
					String mobile = rd.getStr("mobile");
					String wwc = rd.getBigDecimal("wwc").toString();
					String ywc = rd.getBigDecimal("ywc").toString();
					String lng1 = rd.getStr("longitude");
					String lat1 = rd.getStr("latitude");
					double d = 0;
					if (StringUtils.isNotEmpty(lng1) && StringUtils.isNotEmpty(lat1)) {
						d = GPSUtil.getDistance(lng, lat, lng1, lat1);
					}

					map.put("id", id);
					map.put("name", name);
					map.put("mobile", mobile);
					map.put("wwc", wwc);
					map.put("ywc", ywc);
					map.put("d", String.valueOf(d));
					list.add(map);
				}
				Collections.sort(list, new MapComparator());
			}
		}
		return list;
	}

	private static class MapComparator implements Comparator<Map<String, String>> {
		public int compare(Map<String, String> o1, Map<String, String> o2) {
			String b1 = o1.get("d");
			String b2 = o2.get("d");
			if (b2 != null) {
				return b1.compareTo(b2);
			}
			return 0;
		}
	}

	private static class MapComparator2 implements Comparator<Record> {
		@Override
		public int compare(Record o1, Record o2) {
			Double d1 = o1.getDouble("distance");
			Double d2 = o2.getDouble("distance");
			return d1.compareTo(d2);
		}
	}

	public List<Map<String, String>> getSiteEmploye(String siteId) {
		List<Record> rds = employeDao.getSiteEmploye(siteId);
		List<Map<String, String>> list = Lists.newArrayList();
		if (rds != null) {
			for (Record rd : rds) {
				Map<String, String> map = new HashMap<String, String>();
				String name = rd.getStr("name");
				String mobile = rd.getStr("mobile");
				String yjd = rd.getBigDecimal("yjd").toString();
				String yjdwwc = rd.getBigDecimal("yjdwwc").toString();
				String wjd = rd.getBigDecimal("wjd").toString();
				String id = rd.getStr("id");

				map.put("id", id);
				map.put("name", name);
				map.put("mobile", mobile);
				map.put("yjd", yjd);
				map.put("yjdwwc", yjdwwc);
				map.put("wjd", wjd);
				list.add(map);
			}
		}

		return list;
	}

	public List<Record> getSiteEmployeList(String siteId) {
		return Db.find("select e.id, e.name from crm_employe as e where e.status='0' and e.site_id=?", siteId);
	}

	@Transactional
	public void saveEmploye(Employe employe) {
		if (checkEmploye(employe)) {
			User user = employe.getUser();
			systemService.saveUser(user);
			systemService.assignUserToRole(roleDao.findByName("服务工程师"), user.getId());
			employeDao.save(employe);
		}
	}

	private boolean checkEmploye(Employe employe) {
		User user = employe.getUser();
		boolean ret = !accountService.isMobileExists(user.getMobile()) && (systemService.getUserByLoginName(user.getLoginName()) == null);
		if (!StringUtils.isBlank(user.getEmail())) {
			ret = ret && !accountService.isMailExists(user.getEmail());
		}
		return ret;
	}

	public Page<Record> getSiteEmployee(String siteId, Page<Record> page, Map<String, String[]> filterMap) {
		List<Record> list = employeDao.filterEmployee(siteId, page, filterMap);
		for (Record rd : list) {
			String categoryIds = rd.get("category");
			rd.set("category_names", StringUtil.join(categoryNameList(categoryIds)));
		}
		page.setList(list);
		page.setCount(employeDao.countFilteredEmployee(siteId, page, filterMap));
		return page;
	}

	public String getSiteId(User user) {
		return employeDao.getSiteidByUserId(user.getId());
	}

	private String[] categoryNameList(String categoryIds) {
		if (StringUtils.isBlank(categoryIds)) {
			return new String[0];
		}
		Map<String, String> map = new HashMap<>();
		map.put("1", "空调");
		map.put("2", "冰箱");
		map.put("3", "热水器");
		map.put("4", "电视");
		map.put("5", "油烟机");
		map.put("6", "洗衣机");
		map.put("9", "小家电");
		String[] split = categoryIds.split(",");
		List<String> ret = new ArrayList<>();
		// String[] categoryNames = {"空调", "冰箱", "热水器", "电视", "油烟机", "洗衣机", "小家电"};
		if (split.length > 0) {
			for (String i : split) {
				i = i.trim();
				if (StringUtils.isNotBlank(i) && StringUtils.isAlphanumeric(i)) {
					// int j = Integer.valueOf(i);
					// if (j < 7 && j > 0) {
					// ret.add(categoryNames[j - 1]);
					// }
					String name = map.get(i);
					if (name != null) {
						ret.add(map.get(i));
					}
				}
			}
		}
		String[] val = new String[ret.size()];
		return ret.toArray(val);
	}

	public String isLocEmploye(String empId) {
		return employeDao.isLocEmploye(empId);
	}

	public Map<String, Object> locEmploye(String empId) {
		return employeDao.locEmploye(empId);
	}

	/**
	 * 查询最近七天服务工程师签到
	 */
	public JSONArray getCountForms(String siteId, String source) {
		Record rd1 = null;
		Record rd2 = null;
		Record rd3 = null;
		Record rd4 = null;
		Record rd5 = null;
		Record rd6 = null;
		Record rd7 = null;
		// 如果source 等于1，则为考勤签到查询，否则为考勤签退
		if (source.equals("1")) {
			rd1 = employeDao.getEmployeSign("CURDATE()", siteId);
			rd2 = employeDao.getEmployeSign("DATE_SUB(CURDATE(),INTERVAL 1 DAY)", siteId);
			rd3 = employeDao.getEmployeSign("DATE_SUB(CURDATE(),INTERVAL 2 DAY)", siteId);
			rd4 = employeDao.getEmployeSign("DATE_SUB(CURDATE(),INTERVAL 3 DAY)", siteId);
			rd5 = employeDao.getEmployeSign("DATE_SUB(CURDATE(),INTERVAL 4 DAY)", siteId);
			rd6 = employeDao.getEmployeSign("DATE_SUB(CURDATE(),INTERVAL 5 DAY)", siteId);
			rd7 = employeDao.getEmployeSign("DATE_SUB(CURDATE(),INTERVAL 6 DAY)", siteId);
		} else {
			rd1 = employeDao.getEmployeSignOut("CURDATE()", siteId);
			rd2 = employeDao.getEmployeSignOut("DATE_SUB(CURDATE(),INTERVAL 1 DAY)", siteId);
			rd3 = employeDao.getEmployeSignOut("DATE_SUB(CURDATE(),INTERVAL 2 DAY)", siteId);
			rd4 = employeDao.getEmployeSignOut("DATE_SUB(CURDATE(),INTERVAL 3 DAY)", siteId);
			rd5 = employeDao.getEmployeSignOut("DATE_SUB(CURDATE(),INTERVAL 4 DAY)", siteId);
			rd6 = employeDao.getEmployeSignOut("DATE_SUB(CURDATE(),INTERVAL 5 DAY)", siteId);
			rd7 = employeDao.getEmployeSignOut("DATE_SUB(CURDATE(),INTERVAL 6 DAY)", siteId);
		}
		List<Integer> list1 = Lists.newArrayList();
		List<Integer> list2 = Lists.newArrayList();
		List<Integer> list3 = Lists.newArrayList();
		List<Integer> list4 = Lists.newArrayList();

		list1.add(rd1.getLong("wkq").intValue());
		list1.add(rd2.getLong("wkq").intValue());
		list1.add(rd3.getLong("wkq").intValue());
		list1.add(rd4.getLong("wkq").intValue());
		list1.add(rd5.getLong("wkq").intValue());
		list1.add(rd6.getLong("wkq").intValue());
		list1.add(rd7.getLong("wkq").intValue());

		list2.add(rd1.getLong("eightkq").intValue());
		list2.add(rd2.getLong("eightkq").intValue());
		list2.add(rd3.getLong("eightkq").intValue());
		list2.add(rd4.getLong("eightkq").intValue());
		list2.add(rd5.getLong("eightkq").intValue());
		list2.add(rd6.getLong("eightkq").intValue());
		list2.add(rd7.getLong("eightkq").intValue());

		list3.add(rd1.getLong("7to8kq").intValue());
		list3.add(rd2.getLong("7to8kq").intValue());
		list3.add(rd3.getLong("7to8kq").intValue());
		list3.add(rd4.getLong("7to8kq").intValue());
		list3.add(rd5.getLong("7to8kq").intValue());
		list3.add(rd6.getLong("7to8kq").intValue());
		list3.add(rd7.getLong("7to8kq").intValue());

		list4.add(rd1.getLong("sevenkq").intValue());
		list4.add(rd2.getLong("sevenkq").intValue());
		list4.add(rd3.getLong("sevenkq").intValue());
		list4.add(rd4.getLong("sevenkq").intValue());
		list4.add(rd5.getLong("sevenkq").intValue());
		list4.add(rd6.getLong("sevenkq").intValue());
		list4.add(rd7.getLong("sevenkq").intValue());

		JSONObject vipObj = new JSONObject();
		vipObj.accumulate("name", "未考勤");
		vipObj.accumulate("data", list1);

		JSONObject cleanObj = new JSONObject();
		if (source.equals("1")) {
			cleanObj.accumulate("name", "8点以后");
		} else {
			cleanObj.accumulate("name", "6点以后");
		}
		cleanObj.accumulate("data", list2);

		JSONObject ybObj = new JSONObject();
		if (source.equals("1")) {
			ybObj.accumulate("name", "7~8点");
		} else {
			ybObj.accumulate("name", "5~6点");
		}
		ybObj.accumulate("data", list3);

		JSONObject czObj = new JSONObject();
		if (source.equals("1")) {
			czObj.accumulate("name", "7点之前");
		} else {
			czObj.accumulate("name", "5点之前");
		}
		czObj.accumulate("data", list4);

		JSONArray arr = new JSONArray();
		arr.add(vipObj);
		arr.add(cleanObj);
		arr.add(ybObj);
		arr.add(czObj);

		return arr;
	}

	public List<String> getCountForm() {
		List<String> list = Lists.newArrayList();
		Date date = new Date(new Date().getTime());
		list.add(form.format(date));
		Date date2 = new Date(new Date().getTime() - 24 * 60 * 60 * 1000 * 1);
		list.add(form.format(date2));
		Date date3 = new Date(new Date().getTime() - 24 * 60 * 60 * 1000 * 2);
		list.add(form.format(date3));
		Date date4 = new Date(new Date().getTime() - 24 * 60 * 60 * 1000 * 3);
		list.add(form.format(date4));
		Date date5 = new Date(new Date().getTime() - 24 * 60 * 60 * 1000 * 4);
		list.add(form.format(date5));
		Date date6 = new Date(new Date().getTime() - 24 * 60 * 60 * 1000 * 5);
		list.add(form.format(date6));
		Date date7 = new Date(new Date().getTime() - 24 * 60 * 60 * 1000 * 6);
		list.add(form.format(date7));

		return list;
	}

	public Record gettodaySign(String siteId, String source) {
		Record rds = new Record();
		String wkqName = "";
		String eightkqName = "";
		String to8kqName = "";
		String sevenkqName = "";
		List<Record> list1 = Lists.newArrayList();
		List<Record> list2 = Lists.newArrayList();
		List<Record> list3 = Lists.newArrayList();
		List<Record> list4 = Lists.newArrayList();
		// 如果source 等于1，则为考勤签到查询，否则为考勤签退
		if (source.equals("1")) {
			list1 = employeDao.gettodaySign(siteId, "IS NULL");
			list2 = employeDao.gettodaySign(siteId, ">'08:00:00'");
			list3 = employeDao.gettodaySign(siteId, "> '07:00:00' AND TIME(c.signinTime) < '08:00:00'");
			list4 = employeDao.gettodaySign(siteId, "< '07:00:00'");
			// 如果source 等于1，则为考勤签到查询，否则为考勤签退
		} else {
			list1 = employeDao.gettodaySignOutName(siteId, "IS NULL");
			list2 = employeDao.gettodaySignOutName(siteId, "> '18:00:00'");
			list3 = employeDao.gettodaySignOutName(siteId, "> '17:00:00' AND TIME(c.signoutTime) < '18:00:00' ");
			list4 = employeDao.gettodaySignOutName(siteId, "< '17:00:00'");
		}

		for (Record rd : list1) {
			if (StringUtils.isEmpty(wkqName)) {
				wkqName = rd.getStr("name");
			} else {
				wkqName = wkqName + "、" + rd.getStr("name");
			}
		}
		rds.set("wkqName", wkqName);
		rds.set("wkqCount", list1.size());
		for (Record rd : list2) {
			if (StringUtils.isEmpty(eightkqName)) {
				eightkqName = rd.getStr("name");
			} else {
				eightkqName = eightkqName + "、" + rd.getStr("name");
			}
		}
		rds.set("eightkqName", eightkqName);
		rds.set("eightkqCount", list2.size());
		for (Record rd : list3) {
			if (StringUtils.isEmpty(to8kqName)) {
				to8kqName = rd.getStr("name");
			} else {
				to8kqName = to8kqName + "、" + rd.getStr("name");
			}
		}
		rds.set("to8kqName", to8kqName);
		rds.set("to8kqNameCount", list3.size());
		for (Record rd : list4) {
			if (StringUtils.isEmpty(sevenkqName)) {
				sevenkqName = rd.getStr("name");
			} else {
				sevenkqName = sevenkqName + "、" + rd.getStr("name");
			}
		}
		rds.set("sevenkqName", sevenkqName);
		rds.set("sevenkqCount", list4.size());
		return rds;
	}

	public String findByEmpliyeMobile(String siteId, String name) {
		return employeDao.findByEmpliyeMobile(siteId, name);
	}

	public Page<Record> getSmsSended(String siteId, Page<Record> page) {
		List<Record> list = employeDao.getSmsTemplate(page, siteId);
		page.setList(list);
		page.setCount(employeDao.getSmsTemplatecount(siteId));
		return page;
	}

	public String getById(String id) {
		return employeDao.getById(id);
	}

	public String getUserId(String id) {
		return employeDao.getUserId(id);
	}

	public List<Employe> getEmployes(List<String> empIds) {
		return employeDao.getEmployes(empIds);
	}

	@SuppressWarnings("unchecked")
	public List<Employe> getEmployes(String empIds) {
		return employeDao.getEmployes(empIds);
	}
}
