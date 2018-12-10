package com.jojowonet.modules.order.dao;

import java.util.List;
import java.util.Map;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SiteAlarm;
import com.jojowonet.modules.order.utils.CrmUtils;

/**
 * 预警消息DAO接口
 * 
 * @author yc
 * @version 2017-06-15
 */

@Repository
public class SiteAlarmDao extends BaseDao<SiteAlarm> {
	public List<Record> getAlarmlist(String siteId) {
		String sql = "SELECT * FROM crm_site_alarm WHERE site_id='" + siteId
				+ "' and is_cancel ='0' ORDER BY create_time DESC";
		return Db.find(sql);
	}

	/* 查询四中预警状态的个数 */
	public Long queryEmployeCount(String siteId) {
		return Db
				.queryLong("SELECT count(*) from crm_site_alarm a where a.site_id='"
						+ siteId + "' and a.type='1' and a.is_cancel='0' ");
	}

	public Long queryFinishedCount(String siteId) {
		return Db
				.queryLong("SELECT count(*) from crm_site_alarm a where a.site_id='"
						+ siteId + "' and a.type='2' and a.is_cancel='0' ");
	}

	public Long queryStoreCount(String siteId) {
		return Db
				.queryLong("SELECT count(*) from crm_site_alarm a where a.site_id='"
						+ siteId + "' and a.type='3' and a.is_cancel='0' ");
	}

	public Long queryShortCount(String siteId) {
		return Db
				.queryLong("SELECT count(*) from crm_site_alarm a where a.site_id='"
						+ siteId + "' and a.type='4' and a.is_cancel='0' ");
	}

	public List<Record> getAlarmDetailList(Page<Record> page, String siteId,
			Map<String, Object> map) {// 查询列表
		StringBuilder sf = new StringBuilder();
		StringBuilder sf1 = new StringBuilder();
		StringBuilder sf2 = new StringBuilder();
		sf.append("select a.* from crm_site_alarm a where a.site_id=?  and a.is_cancel='0' ");
		sf2.append("select b.id from crm_site_alarm b where b.site_id=?  and b.is_cancel='0' ");
		sf.append(selectCondition(map));
		sf2.append(selectCondition1(map));
		sf.append(" ORDER BY a.is_top DESC,a.create_time DESC");

		if (page != null) {
			sf.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
			sf2.append(" limit " + page.getPageSize() + " offset "
					+ (page.getPageNo() - 1) * page.getPageSize());
		}
		sf1.append("update crm_site_alarm a set a.status='1' where a.id in( select c.id from("+sf2.toString()+") c )");
		Db.update(sf1.toString(),siteId);
		return Db.find(sf.toString(), siteId);
	}

	public Long queryCount(String siteId, Map<String, Object> map) {// 查询数据总数
		StringBuilder sf = new StringBuilder();
		sf.append("select count(*) from crm_site_alarm a where a.site_id=? and a.is_cancel='0' ");
		sf.append(selectCondition(map));
		return Db.queryLong(sf.toString(), siteId);
	}

	public String selectCondition(Map<String, Object> map) {// 查询条件
		StringBuilder stringBuilder = new StringBuilder();
		User user = UserUtils.getUser();
		Boolean peiJian = CrmUtils.isPeijianMan(user);
		Boolean xinXi = CrmUtils.isXinxiMan(user);
		if (xinXi == false && peiJian == false) {
			stringBuilder.append(" and a.type='' ");
		} else if (xinXi == true && peiJian == true) {
			if (map != null) {
				if (map.get("type") != null && StringUtils.isNotEmpty(((String[]) map.get("type"))[0])) {
					String type = ((String[]) map.get("type"))[0];
					stringBuilder.append(" and a.type = '"
							+ ((String[]) map.get("type"))[0] + "' ");
				}
			}
		} else if (xinXi == true && peiJian == false) {
			stringBuilder.append(" and (a.type='1' or a.type='2')");
			if (map != null) {
				if (map.get("type") != null
						&& StringUtils
								.isNotEmpty(((String[]) map.get("type"))[0])) {
					String type = ((String[]) map.get("type"))[0];
					if (type.equals("1") || type.equals("2")) {
						stringBuilder.append(" and a.type = '"
								+ ((String[]) map.get("type"))[0] + "' ");
					} else {
						stringBuilder.append(" and a.type='' ");
					}
				}
			}
		} else if (peiJian == true && xinXi == false) {
			stringBuilder.append(" and (a.type='3' or a.type='4')");
			if (map != null) {
				if (map.get("type") != null
						&& StringUtils
								.isNotEmpty(((String[]) map.get("type"))[0])) {
					String type = ((String[]) map.get("type"))[0];
					if (type.equals("3") || type.equals("4")) {
						stringBuilder.append(" and a.type = '"
								+ ((String[]) map.get("type"))[0] + "' ");
					} else {
						stringBuilder.append(" and a.type='' ");
					}
				}
			}
		}
		return stringBuilder.toString();
	}
	
	public String selectCondition1(Map<String, Object> map) {// 查询条件
		StringBuilder stringBuilder = new StringBuilder();
		User user = UserUtils.getUser();
		Boolean peiJian = CrmUtils.isPeijianMan(user);
		Boolean xinXi = CrmUtils.isXinxiMan(user);
		if (xinXi == false && peiJian == false) {
			stringBuilder.append(" and b.type='' ");
		} else if (xinXi == true && peiJian == true) {
			if (map != null) {
				if (map.get("type") != null
						&& StringUtils
								.isNotEmpty(((String[]) map.get("type"))[0])) {
					String type = ((String[]) map.get("type"))[0];
					stringBuilder.append(" and b.type = '"
							+ ((String[]) map.get("type"))[0] + "' ");
				}
			}
		} else if (xinXi == true && peiJian == false) {
			stringBuilder.append(" and (b.type='1' or b.type='2')");
			if (map != null) {
				if (map.get("type") != null
						&& StringUtils
								.isNotEmpty(((String[]) map.get("type"))[0])) {
					String type = ((String[]) map.get("type"))[0];
					if (type.equals("1") || type.equals("2")) {
						stringBuilder.append(" and b.type = '"
								+ ((String[]) map.get("type"))[0] + "' ");
					} else {
						stringBuilder.append(" and b.type='' ");
					}
				}
			}
		} else if (peiJian == true && xinXi == false) {
			stringBuilder.append(" and (b.type='3' or b.type='4')");
			if (map != null) {
				if (map.get("type") != null
						&& StringUtils.isNotEmpty(((String[]) map.get("type"))[0])) {
					String type = ((String[]) map.get("type"))[0];
					if (type.equals("3") || type.equals("4")) {
						stringBuilder.append(" and b.type = '"
								+ ((String[]) map.get("type"))[0] + "' ");
					} else {
						stringBuilder.append(" and b.type='' ");
					}
				}
			}
		}
		return stringBuilder.toString();
	}

	public String cancelAlarm(String rowId) {// 取消预警
		Db.update("update crm_site_alarm a set a.is_cancel='1',a.update_time=now() WHERE a.id='"
				+ rowId + "'");
		return "ok";
	}

	public String isTop(String rowId, String isTop) {// 是否置顶
		if (isTop.equals("0")) {
			Db.update("update crm_site_alarm a set a.is_top='1',a.update_time=now() WHERE a.id='"
					+ rowId + "'");
		} else if (isTop.equals("1")) {
			Db.update("update crm_site_alarm a set a.is_top='0',a.update_time=now() WHERE a.id='"
					+ rowId + "'");
		}
		return "ok";
	}

	public String isFlag(String rowId, String isflag) {//是否标记
		if (isflag.equals("0")) {
			Db.update("update crm_site_alarm a set a.flag='1',a.update_time=now() WHERE a.id='"
					+ rowId + "'");
		} else if (isflag.equals("1")) {
			Db.update("update crm_site_alarm a set a.flag='0',a.update_time=now() WHERE a.id='"
					+ rowId + "'");
		}
		return "ok";
	}
//批量取消预警
	public boolean plcancelAlarm(String ids) {
		Db.update("update crm_site_alarm a set a.is_cancel='1',a.update_time=now() WHERE a.id='"
				+ ids + "'");
		return true;
		
	}

	//批量置顶
		public boolean pltop(String ids) {
			Db.update("update crm_site_alarm a set a.is_top='1',a.update_time=now() WHERE a.id='"
					+ ids + "'");
			return true;
			
		}
		//批量取消标记
		public boolean plcanceltop(String ids) {
			Db.update("update crm_site_alarm a set a.is_top='0',a.update_time=now() WHERE a.id='"
					+ ids + "'");
			return true;
			
		}

}
