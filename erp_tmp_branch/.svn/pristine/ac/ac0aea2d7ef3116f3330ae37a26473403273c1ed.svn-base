package com.jojowonet.modules.order.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.order.dao.PushMessageDao;
import com.jojowonet.modules.order.entity.PushMessage;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.sys.util.MessageUtils;

import ivan.common.entity.mysql.common.User;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;

@Component
@Transactional(readOnly = true)
public class PushMessageService extends BaseService {

	private static Logger logger = Logger.getLogger(PushMessageService.class);

	@Autowired
	private PushMessageDao pushMessageDao;

	@Autowired
	private SiteDao siteDao;

	@Autowired
	private NonServicemanDao nonServicemanDao;

	public Map<String, String> getSenderInfo(User user) {
		Map<String, String> map = Maps.newHashMap();
		String sendId = "";
		String sendName = "";
		String sendType = "";
		String siteId = "";
		Record site = siteDao.getByUserId(user.getId());
		if (site == null) {
			Record rd1 = Db.findFirst(
					"select *,s.name as siteName from crm_non_serviceman a left join crm_site s on a.site_id=s.id where a.status='0' and a.user_id='" + user.getId() + "'");
			if (rd1 != null && !"".equals(rd1)) {
				sendId = rd1.getStr("site_id");
				siteId = rd1.getStr("site_id");
				sendName = rd1.getStr("siteName");
			}
		} else {
			sendId = site.getStr("id");
			siteId = site.getStr("id");
			sendName = site.getStr("name");
		}
		sendType = "2";
		if ("3".equals(user.getUserType())) {// nonserviceman
			NonServiceman non = nonServicemanDao.getNonServiceman(user);
			sendId = non.getId();
			sendName = non.getName();
			sendType = "3";
		}
		map.put("siteId", siteId);
		map.put("sendId", sendId);
		map.put("sendName", sendName);
		map.put("sendType", sendType);
		return map;
	}

	/**
	 * 备件申请反馈提醒
	 * 
	 * @param targetId
	 * @return
	 */
	public boolean notifyFittingApplyFeedback(String targetId, String content, String empId) {
		Map<String, String> sendMap = getSenderInfo(UserUtils.getUser());
		SqlKit sb = new SqlKit();
		sb.append("select a.id,a.site_id, a.name,b.id as userId, b.registration_id, b.app_type,b.sf_regis_id");
		sb.append("from crm_employe a left join sys_user b on b.id = a.user_id and b.status = '0'");
		sb.append("where a.id = '" + empId + "'");
		Record rd = Db.findFirst(sb.toString());
		if (rd == null) {
			return true;
		}

		String regisId = rd.getStr("registration_id");
		String sfRegisId = rd.getStr("sf_regis_id");
		if (StringUtils.isNotBlank(regisId) || StringUtils.isNotBlank(sfRegisId)) {
			PushMessage pm = new PushMessage();
			pm.setAppType(rd.getStr("app_type"));
			pm.setTargetId(targetId);
			pm.setType("3");
			String title = "备件申请反馈";
			pm.setTitle(title);
			pm.setContent(content);
			pm.setSendTime(new Date());
			pm.setSenderName(sendMap.get("sendName"));
			pm.setSenderId(sendMap.get("sendId"));
			pm.setSenderType(sendMap.get("sendType"));
			pm.setReceiverId(rd.getStr("id"));
			pm.setReceiverName(rd.getStr("name"));
			pm.setReceiverType("4");
			pm.setIsRead("0");
			pm.setStatus("0");
			pm.setSiteId(rd.getStr("site_id"));
			pm.setRegId(regisId);
			pm.setPushIds(sfRegisId);
			MessageUtils.pushAppMsgAndSave(pm);
		}
		return true;
	}

	/**
	 * 备件返还驳回提醒
	 * 
	 * @param targetId
	 * @return
	 */
	public boolean notifyRejectFitting(String targetId, String content, String empId, String title, String type) {
		Map<String, String> sendMap = getSenderInfo(UserUtils.getUser());
		SqlKit sb = new SqlKit();
		sb.append("select a.id,a.site_id, a.name,b.id as userId, b.registration_id, b.app_type,b.sf_regis_id");
		sb.append("from crm_employe a left join sys_user b on b.id = a.user_id and b.status = '0'");
		sb.append("where a.id = '" + empId + "'");
		Record rd = Db.findFirst(sb.toString());
		if (rd == null) {
			return true;
		}

		String regisId = rd.getStr("registration_id");
		String sfRegisId = rd.getStr("sf_regis_id");
		if (StringUtils.isNotBlank(regisId) || StringUtils.isNotBlank(sfRegisId)) {
			PushMessage pm = new PushMessage();
			pm.setAppType(rd.getStr("app_type"));
			pm.setTargetId(targetId);
			pm.setType(type);
			pm.setTitle(title);
			pm.setContent(content);
			pm.setSendTime(new Date());
			pm.setSenderName(sendMap.get("sendName"));
			pm.setSenderId(sendMap.get("sendId"));
			pm.setSenderType(sendMap.get("sendType"));
			pm.setReceiverId(rd.getStr("id"));
			pm.setReceiverName(rd.getStr("name"));
			pm.setReceiverType("4");
			pm.setIsRead("0");
			pm.setStatus("0");
			pm.setSiteId(rd.getStr("site_id"));
			pm.setRegId(regisId);
			pm.setPushIds(sfRegisId);
			MessageUtils.pushAppMsgAndSave(pm);
		}
		return true;
	}

	/**
	 * 提醒工单
	 * 
	 * @param notifyType:1.提醒接收，２．提醒预警
	 * @return
	 */
	public boolean notifyOrder(Map<String, String> idMap, String notifyType, String employeId) {
		Map<String, String> sendMap = getSenderInfo(UserUtils.getUser());
		String siteId = sendMap.get("siteId");
		if (StringUtils.isNotBlank(siteId)) {
			StringBuilder sb = new StringBuilder("");
			sb.append(" select distinct a.emp_id, a.order_id, b.user_id, b.name, c.app_type, c.registration_id,c.sf_regis_id ");
			sb.append(" from crm_order_dispatch_employe_rel a left join crm_employe b on b.id = a.emp_id  ");
			sb.append(" and b.site_id = '" + siteId + "' and b.status = '0' ");
			sb.append(" left join sys_user c on c.id = b.user_id and c.status = '0' and c.user_type = '4' ");
			sb.append(" where a.site_id = '" + siteId + "' ");
			sb.append(" and a.order_id in (" + SqlKit.joinInSql(idMap.keySet()) + ") ");
			sb.append("  ");
			List<Record> rds = Db.find(sb.toString());
			for (Record rd : rds) {
				String empId = rd.getStr("emp_id");
				if (StringUtils.isNotBlank(employeId)) {
					if (employeId.indexOf(empId) == -1) {
						continue;
					}
				}
				String userId = rd.getStr("user_id");
				String regisId = rd.getStr("registration_id");
				String sfRegisId = rd.getStr("sf_regis_id");
				if (StringUtils.isNotBlank(userId) && (StringUtils.isNotBlank(regisId) || StringUtils.isNotBlank(sfRegisId))) {
					String orderId = rd.getStr("order_id");
					PushMessage pm = new PushMessage();
					String number = idMap.get(orderId);
					pm.setAppType(rd.getStr("app_type"));
					pm.setType(notifyType);
					String title = "";
					String content = "";
					if ("1".equals(notifyType)) {
						title = "提醒接单";
						content = number + ",请您及时接单!";
					} else if ("2".equals(notifyType)) {
						title = "提醒预警";
						content = number + "即将超时,请您及时处理!";
					}
					pm.setStatus("0");
					pm.setIsRead("0");
					pm.setRegId(regisId);
					pm.setPushIds(sfRegisId);
					pm.setTitle(title);
					pm.setTargetId(orderId);
					pm.setContent(content);
					pm.setSendTime(new Date());
					pm.setSenderName(sendMap.get("sendName"));
					pm.setSenderId(sendMap.get("sendId"));
					pm.setSenderType(sendMap.get("sendType"));
					pm.setReceiverId(rd.getStr("emp_id"));
					pm.setReceiverName(rd.getStr("name"));
					pm.setReceiverType("4");
					pm.setSiteId(siteId);
					MessageUtils.pushAppMsgAndSave(pm);
				}
			}
		} else {
			logger.error(String.format("user [%s] site id not found", UserUtils.getUser().getId()));
		}
		return true;
	}

	public List<PushMessage> getPushMessageByOrderId(String orderId) {
		DetachedCriteria dc = pushMessageDao.createDetachedCriteria();
		dc.add(Restrictions.eq("targetId", orderId));
		dc.add(Restrictions.eq("type", "1"));
		dc.addOrder(Order.desc("sendTime"));
		return pushMessageDao.find(dc);
	}

	/**
	 * 提醒工单
	 * 
	 * @param notifyType:1.提醒接收，２．提醒预警
	 * @return
	 */
	public boolean notifyOrderSmallProgram(Map<String, String> idMap, String notifyType, String employeId, User user) {
		Map<String, String> sendMap = getSenderInfo(user);
		String siteId = sendMap.get("siteId");
		if (StringUtils.isNotBlank(siteId)) {
			StringBuilder sb = new StringBuilder("");
			sb.append(" select distinct a.emp_id, a.order_id, b.user_id, b.name, c.app_type, c.registration_id,c.sf_regis_id ");
			sb.append(" from crm_order_dispatch_employe_rel a left join crm_employe b on b.id = a.emp_id  ");
			sb.append(" and b.site_id = '" + siteId + "' and b.status = '0' ");
			sb.append(" left join sys_user c on c.id = b.user_id and c.status = '0' and c.user_type = '4' ");
			sb.append(" where a.site_id = '" + siteId + "' ");
			sb.append(" and a.order_id in (" + SqlKit.joinInSql(idMap.keySet()) + ") ");
			sb.append("  ");
			List<Record> rds = Db.find(sb.toString());
			for (Record rd : rds) {
				String empId = rd.getStr("emp_id");
				if (StringUtils.isNotBlank(employeId)) {
					if (employeId.indexOf(empId) == -1) {
						continue;
					}
				}
				String userId = rd.getStr("user_id");
				String regisId = rd.getStr("registration_id");
				String sfRegisId = rd.getStr("sf_regis_id");
				if (StringUtils.isNotBlank(userId) && (StringUtils.isNotBlank(regisId) || StringUtils.isNotBlank(sfRegisId))) {
					String orderId = rd.getStr("order_id");
					PushMessage pm = new PushMessage();
					String number = idMap.get(orderId);
					pm.setAppType(rd.getStr("app_type"));
					pm.setType(notifyType);
					String title = "";
					String content = "";
					if ("1".equals(notifyType)) {
						title = "提醒接单";
						content = number + ",请您及时接单!";
					} else if ("2".equals(notifyType)) {
						title = "提醒预警";
						content = number + "即将超时,请您及时处理!";
					}
					pm.setStatus("0");
					pm.setIsRead("0");
					pm.setRegId(regisId);
					pm.setPushIds(sfRegisId);
					pm.setTitle(title);
					pm.setTargetId(orderId);
					pm.setContent(content);
					pm.setSendTime(new Date());
					pm.setSenderName(sendMap.get("sendName"));
					pm.setSenderId(sendMap.get("sendId"));
					pm.setSenderType(sendMap.get("sendType"));
					pm.setReceiverId(rd.getStr("emp_id"));
					pm.setReceiverName(rd.getStr("name"));
					pm.setReceiverType("4");
					pm.setSiteId(siteId);
					MessageUtils.pushAppMsgAndSave(pm);
				}
			}
		} else {
			logger.error(String.format("user [%s] site id not found", UserUtils.getUser().getId()));
		}
		return true;
	}
}
