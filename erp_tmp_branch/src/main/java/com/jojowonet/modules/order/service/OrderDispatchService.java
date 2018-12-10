package com.jojowonet.modules.order.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.operate.dao.EmployeDao;
import com.jojowonet.modules.operate.dao.NonServicemanDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.entity.NonServiceman;
import com.jojowonet.modules.operate.service.NonServicemanService;
import com.jojowonet.modules.order.dao.AnnouncementSiteReadDao;
import com.jojowonet.modules.order.dao.Order2017Dao;
import com.jojowonet.modules.order.dao.OrderDao;
import com.jojowonet.modules.order.dao.OrderDispatchDao;
import com.jojowonet.modules.order.dao.OrderFeedbackDao;
import com.jojowonet.modules.order.entity.AnnouncementSiteRead;
import com.jojowonet.modules.order.entity.CrmOrder2017;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.OrderDispatch;
import com.jojowonet.modules.order.entity.OrderDispatchEmployeRel;
import com.jojowonet.modules.order.entity.OrderFeedback;
import com.jojowonet.modules.order.form.GenerationOrderFrom;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.TableSplitMapper;
import com.jojowonet.modules.order.utils.WebPageFunUtils;
import com.jojowonet.modules.sys.util.InvalidOrderPusher;

import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

/**
 * 派工Service
 *
 * @author Ivan
 * @version 2017-05-04
 */
@Component
@Transactional
public class OrderDispatchService extends BaseService {

	private static Logger logger = Logger.getLogger(OrderDispatchService.class);

	@Autowired
	private OrderDispatchDao orderDispatchDao;

	@Autowired
	private OrderDao orderDao;
	@Autowired
	private NonServicemanDao nonDao;
	@Autowired
	private EmployeDao empDao;
	@Autowired
	private OrderFeedbackDao ofkDao;
	@Autowired
	private PushMessageService pushMessageService;
	@Autowired
	private AnnouncementSiteReadDao announcementSiteReadDao;
	@Autowired
	private InvalidOrderPusher invalidOrderPusher;
	@Autowired
	private Order2017Dao order2017Dao;
	@Autowired
	TableSplitMapper tableSplitMapper;

	@Autowired
	private NonServicemanService nonService;

	public OrderDispatch get(String id) {
		return orderDispatchDao.get(id);
	}

	public Page<OrderDispatch> find(Page<OrderDispatch> page, OrderDispatch orderDispatch) {
		DetachedCriteria dc = orderDispatchDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(orderDispatch.getId())) {
			dc.add(Restrictions.like("name", "%" + orderDispatch.getId() + "%"));
		}
		dc.add(Restrictions.eq("delFlag", "0"));
		dc.addOrder(org.hibernate.criterion.Order.desc("id"));
		return orderDispatchDao.find(page, dc);
	}

	@Transactional(readOnly = false)
	public void save(OrderDispatch orderDispatch) {
		orderDispatchDao.save(orderDispatch);
	}

	public Record getOrderId(String orderId, String siteId) {
		return orderDispatchDao.getOrderId(orderId, siteId);
	}

	public Record getOrderId2017(String orderId, String siteId) {
		return orderDispatchDao.getOrderId2017(orderId, siteId);
	}

	public Record getOrderIdIfHistory(String orderId, String siteId) {
		Order order = orderDao.get(orderId);
		return order == null ? getOrderId2017(orderId, siteId) : getOrderId(orderId, siteId);
	}

	public void saveDis(List<OrderDispatch> ods, List<Order> or) {

		orderDao.save(or);
		if (ods.size() >= 1) {
			orderDispatchDao.save(ods);
		}
	}

	/**
	 * 注意二级网点是不可以将一级网点派来的工单置为无效的。
	 */
	@Transactional(rollbackFor = Exception.class)
	public String updateInvalid(String id, String latestProcess, String reasonofwxgdType, String type) {
		User user = UserUtils.getUser();
		String name = "";
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = CrmUtils.getSiteName();
		} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
		}
		List<Order> list = Lists.newArrayList();
		List<OrderDispatch> listdis = Lists.newArrayList();
		List<Order> notifyOrders = new ArrayList<>();
		if (StringUtils.isNotEmpty(id)) {
			String ids[] = id.split(",");
			for (String oid : ids) {
				Target ta = new Target();
				ta.setType(Target.INVALID_ORDER);// 无效工单
				ta.setName(name);
				ta.setContent(name + "确认无效工单，" + latestProcess);
				ta.setTime(DateToStringUtils.DateToString());
				Order or = orderDao.get(oid);
				String str = WebPageFunUtils.appendProcessDetail(ta, or.getProcessDetail());
				or.setLatestProcessTime(new Date());
				or.setLatestProcess(name + "确认无效工单，" + latestProcess);
				or.setProcessDetail(str);
				// or.setProcessDetail(or.getProcessDetail()+"@#@"+DateUtils.formatDate(new
				// Date(), "yyyy-MM-dd HH:mm:ss")+"#@"+name+"确认无效工单"+latestProcess);
				if ("2".equals(or.getStatus()) || "3".equals(or.getStatus()) || "4".equals(or.getStatus())) {
					// 服务中、待回访、待结算的工单标记为无效的时候，需要通知工程师。
					notifyOrders.add(or);
				}
				if (or.getEndTime() == null) {
					or.setEndTime(new Date());
				}
				or.setStatus("8");
				or.setDisableType(reasonofwxgdType);
				or.setDisableResource(latestProcess);
				if (StringUtil.isBlank(type)) {
					if (StringUtil.isNotBlank(or.getParentSiteId())) {
						throw new RuntimeException("mark level 1 dispatched order as invalid is not permitted");
					}
					if ("7".equals(or.getOrderType())) {
						throw new RuntimeException("order from micro factory mark as invalid is not permitted");
					}
				}
				list.add(or);
				if ("2".equals(or.getStatus())) {
					OrderDispatch ods = orderDispatchDao.getOrderDis(or, or.getSiteId());
					ods.setStatus("7");
					listdis.add(ods);
				}
			}
			saveDis(listdis, list);
			for (Order o : notifyOrders) {
				invalidOrderPusher.notifyOrderMarkAsInvalid(o, user);
			}
		}
		return id;
	}

	@Transactional
	public void delayOrderDispatch(String id, String latestProcess, String siteId) {
		String name = CrmUtils.getUserXM();
		List<Order> list = Lists.newArrayList();
		List<String> validOrderIds = new ArrayList<>();
		HashSet<String> invalidStatusSet = new HashSet<>();
		invalidStatusSet.add("3");
		invalidStatusSet.add("4");
		invalidStatusSet.add("5");
		invalidStatusSet.add("6");
		invalidStatusSet.add("7");
		invalidStatusSet.add("8");

		if (StringUtils.isNotEmpty(id)) {
			String ids[] = id.split(",");

			for (String oid : ids) {
				Target ta = new Target();
				ta.setType(Target.WAIT_NOT_DISPATCH);// 暂不派工
				ta.setName(name);
				ta.setContent(name + "暂不派工," + latestProcess);
				ta.setTime(DateToStringUtils.DateToString());
				Order or = orderDao.get(oid);
				String status = or.getStatus();
				if (invalidStatusSet.contains(status)) {
					continue;
				}
				or.setDispatchTime(null);
				or.setProcessTime(null);
				or.setDropInTime(null);
				validOrderIds.add(oid);
				String str = WebPageFunUtils.appendProcessDetail(ta, or.getProcessDetail());
				or.setLatestProcess(name + "暂不派工," + latestProcess);
				or.setLatestProcessTime(new Date());
				if (StringUtils.isNotBlank(str)) {
					or.setProcessDetail(str);
				}
				or.setStatus("7");
				list.add(or);
			}
			orderDao.save(list);
		}
		// 派工表取消派工
		if (validOrderIds.size() > 0) {
			SqlKit kit = new SqlKit().append("update `crm_order_dispatch` as d").append("set d.`status` ='7'")
					.append("where d.`order_id` in(" + CrmUtils.joinInSql(validOrderIds) + ")").append("and d.`status` in ('1', '2', '3', '4')").append("and d.`site_id`=:sid");
			Session session = orderDao.getSession();
			SQLQuery sqlQuery = session.createSQLQuery(kit.toString());
			sqlQuery.setParameter("sid", siteId);
			sqlQuery.executeUpdate();
		}
	}

	public String updateClose(String id, String latestProcess) {
		User user = UserUtils.getUser();
		String name = "";
		NonServiceman no = null;
		if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			name = CrmUtils.getSiteName();
		} else {
			no = nonDao.getNonServiceman(user);
			name = no.getName();
		}
		List<Order> list = Lists.newArrayList();
		if (StringUtils.isNotEmpty(id)) {
			String ids[] = id.split(",");
			for (String oid : ids) {
				Order or = orderDao.get(oid);
				or.setLatestProcess(name + "确认直接封单" + latestProcess);
				or.setLatestProcessTime(new Date());
				// or.setProcessDetail(or.getProcessDetail()+"@#@"+DateUtils.formatDate(new
				// Date(), "yyyy-MM-dd HH:mm:ss")+"#@"+name+"确认直接封单"+latestProcess);
				Target ta = new Target();
				ta.setName(name);
				// Db.update("update crm_order_dispatch a set a.status='1'");
				ta.setType(Target.DIRECTLY_CLOSE);
				ta.setContent(name + "直接封单，" + latestProcess);
				ta.setTime(DateToStringUtils.DateToString());
				String processDetail = WebPageFunUtils.appendProcessDetail(ta, or.getProcessDetail());
				or.setProcessDetail(processDetail);
				or.setStatus("5");
				OrderDispatchService.setParentStatusWithGuard(or, Order.PSTATUS_WAIT_CALLBACK);
				Target tas = new Target();
				tas.setName(name);
				tas.setType(Target.COMPLETE_ORDER);
				tas.setContent("工单已完成");
				tas.setTime(DateToStringUtils.DateToString());
				or.setProcessDetail(WebPageFunUtils.appendProcessDetail(tas, processDetail));
				list.add(or);
			}
			orderDao.save(list);
		}

		return id;
	}

	public String updateClose2017(String id, String latestProcess) {
		User user = UserUtils.getUser();
		String name = CrmUtils.getUserXM();
		String siteId = CrmUtils.getCurrentSiteId(user);
		// NonServiceman no = null;
		// if (User.USER_TYPE_SIT.equals(user.getUserType())) {
		// name = CrmUtils.getSiteName();
		// } else {
		// no = nonDao.getNonServiceman(user);
		// name = no.getName();
		// }
		// List<CrmOrder2017> list = Lists.newArrayList();
		if (StringUtils.isNotEmpty(id)) {
			String table = tableSplitMapper.mapOrder(siteId);
			if (table == null) {
				throw new RuntimeException("unknown mapping table");
			}

			String ids[] = id.split(",");
			for (String oid : ids) {
				Record order = order2017Dao.findOrderById(oid, siteId);
				// CrmOrder2017 or = order2017Dao.get(oid);
				// or.setLatestProcess(name + "确认直接封单" + latestProcess);
				String latestProcess1 = name + "确认直接封单" + latestProcess;
				// or.setLatestProcessTime(new Date());
				// or.setProcessDetail(or.getProcessDetail()+"@#@"+DateUtils.formatDate(new
				// Date(), "yyyy-MM-dd HH:mm:ss")+"#@"+name+"确认直接封单"+latestProcess);
				Target ta = new Target();
				ta.setName(name);
				ta.setType(Target.DIRECTLY_CLOSE);
				ta.setContent(name + "直接封单，" + latestProcess);
				ta.setTime(DateToStringUtils.DateToString());
				String processDetail = WebPageFunUtils.appendProcessDetail(ta, order.getStr("process_detail"));
				// or.setProcessDetail(processDetail);
				// or.setStatus("5");

				OrderDispatchService.setParentStatusWithGuard2017(order, CrmOrder2017.PSTATUS_WAIT_CALLBACK, tableSplitMapper, siteId);
				Target tas = new Target();
				tas.setName(name);
				tas.setType(Target.COMPLETE_ORDER);
				tas.setContent("工单已完成");
				tas.setTime(DateToStringUtils.DateToString());
				processDetail = WebPageFunUtils.appendProcessDetail(tas, processDetail);
				// or.setProcessDetail(WebPageFunUtils.appendProcessDetail(tas, processDetail));
				// list.add(or);

				SqlKit kit = new SqlKit().append("update " + table).append("set latest_process=?").append(",latest_process_time=?").append(",process_detail=?").append(",status=?")
						.append("where id=?");
				Db.update(kit.toString(), latestProcess1, new Date(), processDetail, "5", oid);
			}
			// order2017Dao.save(list);
		}

		return id;
	}

	@Transactional(readOnly = false)
	public void update(Order order) {
		orderDao.updateDpgOrder(order);
	}

	@Transactional(readOnly = false)
	public void delete(String id) {
		orderDispatchDao.deleteById(id);
	}

	public OrderDispatch getOrderDis(Order order, String siteId) {
		return orderDispatchDao.getOrderDis(order, siteId);
	}

	public Record getOrderDispatchForCallBack(String orderId, String siteId) {
		return orderDispatchDao.getOrderDispatchForCallBack(orderId, siteId);
	}

	public Record getOrderDispatchForCallBackIfHistory(String orderId, String siteId) {
		Order order = orderDao.get(orderId);
		return order == null ? getOrderDispatchForCallBack2017(orderId, siteId) : getOrderDispatchForCallBack(orderId, siteId);
	}

	public Record getOrderDispatchForCallBack2017(String orderId, String siteId) {
		return orderDispatchDao.getOrderDispatchForCallBack2017(orderId, siteId);
	}

	/**
	 * 无效工单重新派工，二级网点是不可能将一级网点派工的工单标记为无效。
	 *
	 * @param orderId
	 *            工单id
	 * @param employeId
	 *            工程师id
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public Result<Order> wxOrderRedispatch(String orderId, String employeId) {
		if (StringUtil.isBlank(orderId) || employeId == null) {
			Result<Order> ret = new Result<>();
			ret.setData(null);
			ret.setCode("421");
			return ret;
		}
		Order order = orderDao.get(orderId);
		if (StringUtil.isNotBlank(order.getParentSiteId())) {
			// order is come from level 1 site,说明检测了一个异常状态，因为一级网点派来的工单是不可以被标记为无效的。
			Result<Order> ret = new Result<>();
			ret.setData(null);
			ret.setCode("421");
			return ret;
		}

		Order byNumber = orderDao.getValidOrderByNumber(order.getNumber(), order.getSiteId());
		if (byNumber != null) {
			Result<Order> ret = new Result<>();
			ret.setData(null);
			ret.setCode("422");
			ret.setErrMsg("该工单编号已经存在，无法重新派工");
			return ret;
		}

		List<Employe> employes = empDao.getEmployes(employeId);
		String empNames = joinedEmployes(employes);
		User user = UserUtils.getUser();

		order.setStatus("2");
		String operator = CrmUtils.getUserXM();
		order.newTarget(Target.DISPATCH_ORDER, operator, "无效工单重新派工");
		order.setLatestProcess("无效工单重新派工");
		order.setLatestProcessTime(new Date());
		order.setEmployeName(empNames);
		order.setUpdateName(operator);
		order.setEmployeId(employeId);
		order.setEmployeName(empNames);
		order.setDispatchTime(new Date());
		order.setProcessTime(null);// 转派时将接单时间设置空
		order.setDropInTime(null);
		OrderDispatch od = new OrderDispatch();
		if (User.USER_TYPE_XXY.equals(user.getUserType())) {
			NonServiceman no = nonDao.getNonServiceman(user);
			order.setMessengerName(no.getName());
			order.setMessengerId(no.getId());
			od.setMessengerName(no.getName());
			od.setMessengerId(no.getId());
		} else if (User.USER_TYPE_SIT.equals(user.getUserType())) {
			od.setMessengerId(order.getSiteId());
			od.setMessengerName(order.getSiteName());
		}

		orderDispatchDao.cancelOrderDispatch(order.getId());
		od.setOrder(order);
		od.setEmployeId(employeId);
		od.setEmployeName(empNames);
		od.setSiteId(order.getSiteId());
		od.setDispatchTime(new Date());
		od.setStatus("1");
		orderDispatchDao.save(od);

		createDispEmpRel(order.getSiteId(), order.getId(), od.getId(), employes);

		Map<String, String> idMap = Maps.newHashMap();
		idMap.put(order.getId(), order.getNumber());
		pushMessageService.notifyOrder(idMap, "1", employeId);// 推送消息

		Result<Order> ret = new Result<>();
		ret.setData(order);
		ret.setCode("200");
		return ret;
	}

	private void createDispEmpRel(String siteId, String orderId, String dispId, List<Employe> emps) {
		Session session = orderDispatchDao.getSession();
		for (Employe e : emps) {
			OrderDispatchEmployeRel rel = new OrderDispatchEmployeRel();
			rel.setId(IdGen.uuid());
			rel.setDispatchId(dispId);
			rel.setEmpId(e.getId());
			rel.setEmpName(e.getName());
			rel.setSiteId(siteId);
			rel.setOrderId(orderId);
			session.save(rel);
		}
	}

	private boolean canDispatch(Order order) {
		String status = order.getStatus();
		return StringUtil.equalsAny(status, "1", "7");
	}

	// 待派工中派工
	@Transactional(rollbackFor = Exception.class)
	public String Disorder(String orderId, String employeId, String userId) {
		User user = null;
		if (StringUtils.isNotBlank(userId)) {
			user = UserUtils.getUserById(userId);
		} else {
			user = UserUtils.getUser();
		}
		if (StringUtils.isNotEmpty(orderId)) {
			String ids[] = orderId.split(",");
			// markOldDispatchAsCancel(ids, CrmUtils.getCurrentSiteId(user));
			for (String id : ids) {
				Order order = orderDao.get(id);
				if (!canDispatch(order)) {
					continue;
				}
				//判断当前工单是否派工
				if(order.getStatus().equals("2")) {
					continue;
				}
				
				Target ta = new Target();
				String name = CrmUtils.getCreateName(user);
				// if (User.USER_TYPE_SIT.equals(user.getUserType())) {
				// name = siteService.getUserSite(user.getId()).getName();
				// } else {
				// name = nonService.getNonServiceman(user).getName();
				// }
				ta.setType(Target.DISPATCH_ORDER);
				ta.setName(name);
				ta.setTime(DateToStringUtils.DateToString());

				// Long count = Db.queryLong("select count(*) from crm_order_dispatch a where
				// a.order_id='"+id+"' and a.site_id='"+order.getSiteId()+"'");

				OrderDispatch od = new OrderDispatch();
				String siteId = order.getSiteId();
				if (StringUtils.isNotEmpty(employeId)) {
					String[] empId = employeId.split(",");
					String empName = "";
					for (String eid : empId) {
						Employe em = empDao.get(eid);
						if (empName == "") {
							empName = em.getName();
						} else {
							empName = empName + "," + em.getName();
						}
						od.setEmployeName(em.getName());
					}
					od.setSiteId(order.getSiteId());
					if (User.USER_TYPE_SIT.equals(user.getUserType())) {
						od.setMessengerId(order.getSiteId());
						od.setMessengerName(order.getSiteName());
						order.setUpdateName(order.getSiteName());
					} else if (User.USER_TYPE_XXY.equals(user.getUserType())) {
						NonServiceman no = nonDao.getNonServiceman(user);
						od.setMessengerId(no.getId());
						od.setMessengerName(no.getName());
						order.setMessengerId(no.getId());
						order.setMessengerName(no.getName());
						order.setUpdateName(no.getName());
					}
					order.setEmployeId(employeId);
					order.setEmployeName(empName);
					order.setUpdateTime(new Date());
					order.setLatestProcessTime(new Date());
					/*
					 * if(StringUtils.isNotBlank(order.getMessengerName())){
					 * order.setLatestProcess(order.getMessengerName()+" 派工至  "+order.getEmployeName
					 * ()); ta.setContent(order.getMessengerName()+"派工至"+order.getEmployeName());
					 * }else{
					 */
					order.setLatestProcess(name + " 派工至  " + order.getEmployeName());
					ta.setContent(name + "派工至" + order.getEmployeName());
					// }
					order.setDispatchTime(new Date());
					String str = WebPageFunUtils.appendProcessDetail(ta, order.getProcessDetail());
					order.setProcessDetail(str);
					// 保存派工数据
					od.setOrder(order);
					order.setStatus("2"); // 服务商工程师维修中
					od.setDispatchTime(new Date());
					od.setStatus("1"); // 等待服务商接单状态
					orderDao.save(order);
					// if(count > 0){
					// OrderDispatch orderDispatch = orderDispatchDao.get(id);
					// Db.update("update crm_order_dispatch a set a.status='1',a.update_time=NOW()
					// where a.order_id='"+id+"' and a.site_id='"+order.getSiteId()+"'");
					// }else{
					orderDispatchDao.save(od);
					// }
					List<String> list = Lists.newArrayList();
					for (String eId : empId) {
						Employe em = empDao.get(eId);
						StringBuffer sf = new StringBuffer();
						sf.append("INSERT INTO crm_order_dispatch_employe_rel (id,order_id, dispatch_id, emp_id, emp_name, site_id) VALUES( ");
						sf.append("'" + IdGen.uuid() + "', '" + order.getId() + "', '" + od.getId() + "', '" + em.getId() + "', '" + em.getName() + "', '" + siteId + "') ");
						list.add(sf.toString());
					}
					Db.batch(list, list.size());
				}
				// 派工推送消息
				Map<String, String> idMap = Maps.newHashMap();
				String oId = id;
				String num = order.getNumber();
				idMap.put(oId, num);
				pushMessageService.notifyOrder(idMap, "1", "");// 推送消息
			}
		}
		return orderId;
	}

	// 转派
	@Transactional(rollbackFor = Exception.class)
	public void Turntosend(String siteId, String orderId, String employeId, String disId, String transferReasons, String userId) {
		// 似乎这里的disId不是很靠谱，所以决定将根据orderId来查询所有的有效派工，然后就将折现有效派工全部置为6
		User user = null;
		if (StringUtils.isNotBlank(userId)) {
			user = UserUtils.getUserById(userId);
		} else {
			user = UserUtils.getUser();
		}
		if (StringUtil.isBlank(orderId) || StringUtil.isBlank(employeId)) {
			return;
		}

		// if (StringUtils.isNotEmpty(disId)) {
		// String dis[] = disId.split(",");

		// for (String diss : dis) {
		// String sql = "update crm_order_dispatch set status='6' where id='" + diss +
		// "' ";
		// Db.update(sql);
		// }
		// }
		String uname = CrmUtils.getCreateName(user);
		String ids[] = orderId.split(",");
		markOldDispatchAsCancel(ids, CrmUtils.getCurrentSiteId(user));
		for (String id : ids) {
			Order order = orderDao.get(id);
			OrderDispatch od = new OrderDispatch();
			List<Employe> employes = empDao.getEmployes(employeId);
			String empNames = joinedEmployes(employes);
			od.setEmployeName(empNames);
			od.setEmployeId(employeId);
			if (User.USER_TYPE_SIT.equals(user.getUserType())) {
				od.setMessengerId(order.getSiteId());
				od.setMessengerName(order.getSiteName());
				order.setUpdateName(order.getSiteName());
				order.setMessengerName(order.getSiteName());
			} else if (User.USER_TYPE_XXY.equals(user.getUserType())) {
				NonServiceman no = nonDao.getNonServiceman(user);
				od.setMessengerId(no.getId());
				od.setMessengerName(no.getName());
				order.setMessengerId(no.getId());
				order.setMessengerName(no.getName());
				order.setUpdateName(no.getName());
			}
			Date date = new Date();
			order.setEmployeId(employeId);
			order.setEmployeName(empNames);
			order.setUpdateTime(date);
			order.setStatus("2"); // 服务商工程师维修中
			order.setLatestProcessTime(date);
			order.setLatestProcess(uname + " 转派至 " + order.getEmployeName() + "：" + transferReasons);
			Target ta = new Target();
			ta.setType(Target.REDIRECT_DISPATCH_ORDER);// 转派
			ta.setName(uname);
			ta.setContent(uname + "转派至" + order.getEmployeName() + "：" + transferReasons);
			ta.setTime(DateToStringUtils.DateToString());
			String str = WebPageFunUtils.appendProcessDetail(ta, order.getProcessDetail());
			order.setProcessDetail(str);
			order.setDispatchTime(date);
			order.setProcessTime(null);// 转派时将接单时间设置空
			order.setDropInTime(null);
			od.setOrder(order);
			od.setSiteId(order.getSiteId());
			od.setDispatchTime(date);
			od.setStatus("1"); // 等待服务商接单状态
			orderDao.save(order);
			orderDispatchDao.save(od);
			List<String> list = Lists.newArrayList();
			for (Employe em : employes) {
				StringBuilder sf = new StringBuilder();
				sf.append("INSERT INTO crm_order_dispatch_employe_rel (id,order_id, dispatch_id, emp_id, emp_name, site_id) VALUES( ");
				sf.append("'" + IdGen.uuid() + "', '" + order.getId() + "', '" + od.getId() + "', '" + em.getId() + "', '" + em.getName() + "', '" + siteId + "') ");
				list.add(sf.toString());
			}
			int[] batchSize = Db.batch(list, list.size());
			if (sum(batchSize) != list.size()) {
				throw new RuntimeException("create crm_order_dispatch_employe_rel failed");
			}
			// 派工推送消息
			Map<String, String> idMap = Maps.newHashMap();
			String num = order.getNumber();
			idMap.put(id, num);
			pushMessageService.notifyOrder(idMap, "1", employeId);// 推送消息
		}
	}

	private void markOldDispatchAsCancel(String[] orderIds, String siteId) {
		SqlKit kit = new SqlKit().append("UPDATE crm_order_dispatch").append("SET status='6'").append("WHERE site_id='" + siteId + "'")
				.append("AND order_id IN(" + StringUtil.joinInSql(orderIds) + ")").append("AND status IN('1', '2', '4')");
		orderDispatchDao.getSession().createSQLQuery(kit.toString()).executeUpdate();
	}

	private String joinedEmployes(List<Employe> employes) {
		List<String> ret = new ArrayList<>();
		for (Employe e : employes) {
			ret.add(e.getName());
		}
		return org.apache.commons.lang3.StringUtils.join(ret, ",");
	}

	private int sum(int[] a) {
		int ret = 0;
		if (a != null) {
			for (int el : a) {
				ret += el;
			}
		}
		return ret;
	}

	// 来电弹屏中转派
	@Transactional(rollbackFor = Exception.class)
	public void TurntosendCallBack(String orderId, String employeId, String disId, String transferReasons, String noId) {
		if (StringUtils.isNotEmpty(disId)) {
			String dis[] = disId.split(",");
			for (String diss : dis) {
				String sql = "update crm_order_dispatch set status='6' where id='" + diss + "'  ";
				Db.update(sql);
			}
		}
		String uname = "";
		// orderDispatchDao.save(listdis);
		if (StringUtils.isNotEmpty(orderId)) {
			String ids[] = orderId.split(",");
			for (String id : ids) {
				Order order = orderDao.get(id);
				OrderDispatch od = new OrderDispatch();
				String siteId = order.getSiteId();
				if (StringUtils.isNotEmpty(employeId)) {
					String[] empId = employeId.split(",");
					String empName = "";
					for (String eid : empId) {
						Employe em = empDao.get(eid);
						if (empName == "") {
							empName = em.getName();
						} else {
							empName = empName + "," + em.getName();
						}
					}
					Date date = new Date();
					od.setEmployeName(empName);

					order.setEmployeId(employeId);
					order.setEmployeName(empName);
					StringBuffer sfb = new StringBuffer();

					NonServiceman no = nonDao.get(noId);
					od.setMessengerId(noId);
					od.setMessengerName(no.getName());
					order.setUpdateName(no.getName());

					uname = no.getName();

					order.setUpdateTime(date);
					order.setStatus("2"); // 服务商工程师维修中
					order.setLatestProcessTime(date);
					order.setLatestProcess(uname + " 转派至 " + order.getEmployeName() + "：" + transferReasons);
					sfb.append(uname + "转派至" + order.getEmployeName() + "：" + transferReasons);
					Target ta = new Target();
					ta.setType(Target.REDIRECT_DISPATCH_ORDER);// 转派
					ta.setName(uname);
					ta.setContent(uname + "转派至" + order.getEmployeName() + "：" + transferReasons);
					ta.setTime(DateToStringUtils.DateToString());
					String str = WebPageFunUtils.appendProcessDetail(ta, order.getProcessDetail());
					order.setProcessDetail(str);
					order.setDispatchTime(date);// 添加派工时间
					order.setProcessTime(null);// 清空接单时间
					order.setDropInTime(null);
					// 保存派工数据
					od.setOrder(order);
					od.setSiteId(order.getSiteId());
					od.setDispatchTime(date);
					od.setStatus("1"); // 等待服务商接单状态
					orderDao.save(order);
					orderDispatchDao.save(od);
					List<String> list = Lists.newArrayList();
					for (String eId : empId) {
						Employe em = empDao.get(eId);
						StringBuffer sf = new StringBuffer();
						sf.append("INSERT INTO crm_order_dispatch_employe_rel (id,order_id, dispatch_id, emp_id, emp_name, site_id) VALUES( ");
						sf.append("'" + IdGen.uuid() + "', '" + order.getId() + "', '" + od.getId() + "', '" + em.getId() + "', '" + em.getName() + "', '" + siteId + "') ");
						list.add(sf.toString());

					}
					Db.batch(list, list.size());
				}
				// 派工推送消息
				Map<String, String> idMap = Maps.newHashMap();
				String oId = id;
				String num = order.getNumber();
				idMap.put(oId, num);
				pushMessageService.notifyOrder(idMap, "1", employeId);// 推送消息
			}
		}
	}

	// 结算获取
	public List<Record> getOrderSettlement(String orderId, String siteId) {

		return orderDispatchDao.getOrderSettlement(orderId, siteId);
	}

	// 信息员反馈封单
	@Transactional(rollbackFor = Exception.class)
	public String ReplaceEmploye(GenerationOrderFrom gf, String operator) {
		User user = UserUtils.getUser();
		String uname = CrmUtils.getUserXM();
		Order or = orderDao.get(gf.getOrderId());
		OrderDispatch ods = orderDispatchDao.get(gf.getDisOrderId());
		logger.info(" >> change canoper [" + or.getNumber() + ", at:" + new Date() + "],mapping:OrderDispatchController,ReplaceEmploye");
		String[] empId = or.getEmployeId().split(",");
		Employe emp = empDao.get(empId[0]);
		OrderFeedback of = new OrderFeedback();
		of.setSiteId(or.getSiteId());
		of.setFeedbackType(gf.getFeedbackType());
		of.setOrderId(gf.getOrderId());
		of.setDispatchId(gf.getDisOrderId());
		of.setFeedbackTime(new Date());
		// todo emp is not correct
		if (emp == null) {
			of.setFeedbackId(or.getEmployeId());
			of.setFeedbackName(operator);
		} else {
			of.setFeedbackId(emp.getId());
			of.setFeedbackName(operator);
		}

		of.setUserType("4");
		of.setFeedback(gf.getFeedback());
		if (StringUtils.isNotEmpty(gf.getPickerImg())) {
			of.setFeedbackImg(gf.getPickerImg().trim());
		}
		of.setRemarks("web");
		or.setServiceType(gf.getServiceType());
		if (!"2".equals(gf.getFeedbackType())) {
			or.setStatus("3");
			OrderDispatchService.setParentStatusWithGuard(or, Order.PSTATUS_WAIT_CALLBACK);
		}
		or.setServiceMode(gf.getServiceMode());
		or.setApplianceCategory(gf.getApplianceCategory());
		or.setApplianceModel(gf.getApplianceModel());
		or.setApplianceBarcode(gf.getApplianceBarcode());
		or.setApplianceMachineCode(gf.getApplianceMachineCode());
		Target ta = new Target();
		ta.setName(or.getMessengerName());
		ta.setType(Target.FEEDBACK_CLOSE);
		if ("2".equals(gf.getFeedbackType())) {
			ta.setContent(operator + "过程反馈");
		} else {
			ta.setContent(operator + "反馈封单");
			or.setEndTime(new Date());
			or.setDropInTime(new Date());
		}
		ta.setTime(DateToStringUtils.DateToString());
		String str = WebPageFunUtils.appendProcessDetail(ta, or.getProcessDetail());
		or.setLatestProcess(ta.getContent());
		or.setProcessDetail(str);
		or.setLatestProcessTime(new Date());
		if (gf.getServeCost() != null) {
			or.setServeCost(gf.getServeCost());
		}
		if (gf.getAuxiliaryCost() != null) {
			or.setAuxiliaryCost(gf.getAuxiliaryCost());
		}
		if (gf.getWarrantyCost() != null) {
			or.setWarrantyCost(gf.getWarrantyCost());
		}
		or.setMalfunctionType(gf.getMalfunctionType());
		or.setWarrantyType(gf.getWarrantyType());

		ods.setRemarks("web反馈封单");
		or.setUpdateTime(new Date());
		ods.setUpdateTime(new Date());
		ods.setUpdateBy(user.getId());
		List<Target> targets = new ArrayList<>();
		targets.add(ta);
		if ("1".equals(gf.getFeedbackType())) { // 完工反馈 -> 工单将变为待回访
			Target target = new Target();
			target.setName(uname);
			target.setType(Target.FEEDBACK_CLOSE);
			target.setContent(or.getEmployeName() + "已完成");
			target.setTime(DateToStringUtils.DateToString());
			String processDetail = WebPageFunUtils.appendProcessDetail(target, or.getProcessDetail());
			if (ods.getDropInTime() == null) {
				ods.setDropInTime(new Date());
			}
			// ods.setProcessTime(new Date());
			or.setProcessDetail(processDetail);
			ods.setStatus("5");
			ods.setEndTime(new Date());
			or.setStatus("3"); // 待回访待结算
			or.setLatestProcessTime(new Date());
			or.setLatestProcess(or.getEmployeName() + "已完成");
			OrderDispatchService.setParentStatusWithGuard(or, Order.PSTATUS_WAIT_CALLBACK);
			targets.add(target);
			if ("7".equals(or.getOrderType())) {
				orderDao.notifyFactoryOrderComplete(or, CrmUtils.getCurrentSiteId(user), targets);
			}
		} else if ("3".equals(gf.getFeedbackType())) { // 无效工单反馈
			// todo check this branch can reach?
			Target ta1 = new Target();
			ta1.setName(uname);
			ta1.setType(Target.INVALID_ORDER);
			ta1.setContent(uname + "确认无效工单");
			ta1.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(new Date().getTime() + 1))); // 确保这个在反馈封单的后面
			String str1 = WebPageFunUtils.appendProcessDetail(ta1, or.getProcessDetail());
			or.setLatestProcess("无效工单");
			or.setLatestProcessTime(new Date());
			or.setProcessDetail(str1);
			or.setStatus("8");
			ods.setStatus("7");
		}
		// 修改order表的状态
		orderDao.save(or);
		// 修改派单表时间和状态
		orderDispatchDao.save(ods);
		// 反馈表添加信息
		ofkDao.save(of);
		return "ok";
	}

	// 待回访结算工单页面的反馈封单以及重新反馈封单都走这里，这里的反馈类型一定是完成反馈。
	@Transactional(rollbackFor = Exception.class)
	public String ReplaceEmployeRe(GenerationOrderFrom gf, String operator) {
		User user = UserUtils.getUser();
		Order or = orderDao.get(gf.getOrderId());
		OrderDispatch ods = orderDispatchDao.get(gf.getDisOrderId());
		logger.info(" >> change canoper [" + or.getNumber() + ", at:" + new Date() + "],mapping:OrderDispatchController,ReplaceEmploye");
		String[] empId = or.getEmployeId().split(",");
		Employe emp = empDao.get(empId[0]);

		OrderFeedback of = new OrderFeedback();
		of.setSiteId(or.getSiteId());
		of.setFeedbackType(gf.getFeedbackType());
		of.setOrderId(gf.getOrderId());
		of.setDispatchId(gf.getDisOrderId());
		of.setFeedbackTime(new Date());
		if (emp == null) {
			of.setFeedbackId(or.getEmployeId());
			of.setFeedbackName(operator);
		} else {
			of.setFeedbackId(emp.getId());
			of.setFeedbackName(operator);
		}

		of.setUserType("4");
		of.setFeedback(gf.getFeedback());
		if (StringUtils.isNotEmpty(gf.getPickerImg())) {
			of.setFeedbackImg(gf.getPickerImg().trim());
		}
		of.setRemarks("web");
		/*
		 * if (StringUtils.isNotBlank(gf.getFeedbackId())) { //
		 * 当该工单有对应的完成反馈的时候，更新该该工单的完成反馈信息。 of.setId(gf.getFeedbackId()); }
		 */
		or.setServiceType(gf.getServiceType());
		// if (!"2".equals(gf.getFeedbackType())) {
		// or.setStatus("3");
		// }
		or.setServiceMode(gf.getServiceMode());
		or.setApplianceCategory(gf.getApplianceCategory());
		or.setApplianceModel(gf.getApplianceModel());
		or.setApplianceBarcode(gf.getApplianceBarcode());
		or.setApplianceMachineCode(gf.getApplianceMachineCode());
		String content = operator + "重新反馈封单";
		// double oldMnys = or.getWarrantyCost() + or.getServeCost() +
		// or.getAuxiliaryCost();
		// double newMnys = gf.getWarrantyCost() + gf.getServeCost() +
		// or.getAuxiliaryCost();
		double oldMnys = calcTotalFee(or.getWarrantyCost(), or.getServeCost(), or.getAuxiliaryCost());
		double newMnys = calcTotalFee(gf.getWarrantyCost(), gf.getServeCost(), gf.getAuxiliaryCost());
		if (oldMnys != newMnys) {
			content = content + "，原收费总额为" + oldMnys + "元，新收费总额为" + newMnys + "元";
		}
		Target ta = new Target();
		ta.setName(or.getMessengerName());
		ta.setType(Target.FEEDBACK_CLOSE);
		ta.setContent(content);
		ta.setTime(DateToStringUtils.DateToString());
		String str = WebPageFunUtils.appendProcessDetail(ta, or.getProcessDetail());
		or.setProcessDetail(str);
		or.setLatestProcessTime(new Date());
		if (gf.getServeCost() != null) {
			or.setServeCost(gf.getServeCost());
		}
		// if (gf.getAuxiliaryCost() != null) {
		// or.setAuxiliaryCost(gf.getAuxiliaryCost());
		// }
		if (gf.getWarrantyCost() != null) {
			or.setWarrantyCost(gf.getWarrantyCost());
		}
		or.setMalfunctionType(gf.getMalfunctionType());
		or.setWarrantyType(gf.getWarrantyType());
		ods.setRemarks("web重新反馈封单");
		or.setUpdateTime(new Date());
		// or.setEndTime(new Date());
		if (or.getEndTime() == null) {
			or.setEndTime(new Date());
		}
		ods.setUpdateTime(new Date());
		ods.setUpdateBy(user.getId());
		// Target ta1 = new Target();
		// ta1.setName(or.getMessengerName());
		// ta1.setType(Target.REDIRECT_DISPATCH_ORDER);
		// ta1.setContent(or.getEmployeName() + "已完成");
		// ta1.setTime(DateToStringUtils.DateToString());
		// String str1 = WebPageFunUtils.appendProcessDetail(ta1,
		// or.getProcessDetail());
		// or.setProcessDetail(str1);
		// ods.setProcessTime(new Date());
		if (ods.getDropInTime() == null) {
			ods.setDropInTime(new Date());
		}
		if (ods.getEndTime() == null) {
			ods.setEndTime(new Date());
		}
		ods.setStatus("5");
		or.setStatus("3"); // 待回访待结算
		OrderDispatchService.setParentStatusWithGuard(or, Order.PSTATUS_WAIT_CALLBACK);
		or.setLatestProcessTime(new Date());
		or.setLatestProcess(content);
		// 修改order表的状态
		orderDao.save(or);
		// 修改派单表时间和状态
		orderDispatchDao.save(ods);
		// 反馈表添加信息
		ofkDao.save(of);
		return "ok";
	}

	private static double calcTotalFee(Double... fees) {
		double ret = 0;
		for (Double f : fees) {
			if (f != null) {
				ret += f;
			}
		}
		return ret;
	}

	public List<Record> getAllServiceMode(List<Record> list) {
		list = orderDispatchDao.getAllServiceMode("");
		return list;
	}

	public List<Record> getAllServiceType(List<Record> list) {

		list = orderDispatchDao.getAllServiceType("");

		return list;
	}

	public List<Record> getAllProLimit(List<Record> list) {

		list = orderDispatchDao.getAllProLimit("");

		return list;
	}

	public List<Record> getAllOrderOrigin(List<Record> list, String siteId) {

		list = orderDispatchDao.getAllOrderOrigin(siteId);

		return list;
	}

	public List<Record> getAllBrand(List<Record> list, String siteId) {

		list = orderDispatchDao.getAllBrand("", siteId);

		return list;
	}

	public List<Record> changeBrand(String name) {

		return orderDispatchDao.changeBrand(name);
	}

	// 获取派工的服务工程师
	public List<Record> getDispatchRels(String dispId, String siteId) {
		return orderDispatchDao.getDispatchRels(dispId, siteId);
	}

	// 获取派工的服务工程师
	public List<Record> getDispatchRels2017(String dispId, String siteId) {
		return orderDispatchDao.getDispatchRels2017(dispId, siteId);
	}

	public List<Record> getDispatchRelsIfHistory(String dispId, String siteId) {
		OrderDispatch dispatch = get(dispId);
		return dispatch == null ? getDispatchRels2017(dispId, siteId) : getDispatchRels(dispId, siteId);
	}

	/**
	 * 将派工单状态修改为已接单。
	 *
	 * @param dispid
	 *            派工单id
	 */
	@Transactional
	public void updateOrderDispatchStatusToYJD(String dispid) {
		if (StringUtils.isNotBlank(dispid)) {
			SQLQuery sqlQuery = orderDispatchDao.getSession()
					.createSQLQuery("update crm_order_dispatch set `status`='4' ,process_time ='" + DateUtils.getDateTime() + "' where id=:id and `status`='1'");
			sqlQuery.setParameter("id", dispid);
			sqlQuery.executeUpdate();
		}
	}

	public Long formCount(String orderId, String siteId) {
		return Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '" + orderId + "' AND a.site_id='" + siteId + "'");
	}

	@Deprecated
	public Record getSiteMsg(String siteId) {
		return Db.findFirst("select * from crm_site a where a.id=?", siteId);
	}

	public List<Map<String, Object>> getEmployeMsg(String employeId) {
		List<Map<String, Object>> list1 = new ArrayList<>();
		String empId = "";
		String[] eId = employeId.split(",");
		for (String st : eId) {
			if ("".equals(empId)) {
				empId = "'" + st + "'";
			} else {
				empId = empId + ",'" + st + "'";
			}
		}
		List<Record> list = Db.find("select * from crm_employe a where a.id in(" + empId + ") and a.status='0'");
		if (list.size() > 0) {
			for (Record rd : list) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("empName", rd.getStr("name"));
				map.put("mobile", rd.getStr("mobile"));
				list1.add(map);
			}
		} else {
			Map<String, Object> map = Maps.newHashMap();
			map.put("empName", "");
			map.put("mobile", "");
			list1.add(map);
		}
		return list1;
	}

	public Map<String, String> getEmployeMsg1(String employeId) {
		Map<String, String> map = Maps.newHashMap();
		String empId = "";
		String nameMobile = "";
		String empNames = "";
		String empMobiles = "";
		String[] eId = employeId.split(",");

		for (String st : eId) {
			if ("".equals(empId)) {
				empId = "'" + st + "'";
			} else {
				empId = empId + ",'" + st + "'";
			}
		}
		List<Record> list = Db.find("select * from crm_employe a where a.id in(" + empId + ") and a.status='0'");
		if (list.size() > 0) {
			for (Record rd : list) {
				if (StringUtils.isNotBlank(rd.getStr("mobile"))) {
					if ("".equals(nameMobile)) {
						nameMobile = rd.getStr("name") + "(" + rd.getStr("mobile") + ")";
					} else {
						nameMobile = nameMobile + "、" + rd.getStr("name") + "(" + rd.getStr("mobile") + ")";
					}
				}
				if (StringUtils.isNotBlank(rd.getStr("name"))) {
					if ("".equals(empNames)) {
						empNames = rd.getStr("name");
					} else {
						empNames = empNames + "," + rd.getStr("name");
					}
				}
				if (StringUtils.isNotBlank(rd.getStr("mobile"))) {
					if ("".equals(empMobiles)) {
						empMobiles = rd.getStr("mobile");
					} else {
						empMobiles = empMobiles + "," + rd.getStr("mobile");
					}
				}
			}
			map.put("empNames", empNames);
			map.put("empMobiles", empMobiles);
			map.put("nameMobile", nameMobile);
		}
		return map;
	}

	public Record getEmployeMsg4(String employeId) {
		return Db.findFirst("select * from crm_employe a where a.id='" + employeId + "'");
	}

	public List<Record> getoldFitting(String siteId, String orderId) {
		return orderDispatchDao.getOldFitting(siteId, orderId);
	}

	public Record feedBackDetail(String siteId, String orderId) {
		return Db.findFirst("select a.* from crm_order_feedback a where a.order_id=? and a.site_id=? and feedback_type='1' ORDER  BY feedback_time DESC LIMIT 1 ", orderId, siteId);
	}

	public Record feedBackDuringDetail(String siteId, String orderId) {
		return Db.findFirst("select a.* from crm_order_feedback a where a.order_id=? and a.site_id=? and feedback_type !='0' ORDER  BY feedback_time DESC LIMIT 1 ", orderId,
				siteId);
	}

	public Record feedBackDuringDetail2017(String siteId, String orderId) {
		String feedbackTable = tableSplitMapper.mapOrderFeedback(siteId);
		if (feedbackTable == null) {
			return null;
		}

		return Db.findFirst("select a.* from " + feedbackTable + " a where a.order_id=? and a.site_id=? and feedback_type !='0' ORDER  BY feedback_time DESC LIMIT 1 ", orderId,
				siteId);
	}

	public Record feedBackDetail2017(String siteId, String orderId) {
		String feedbackTable = tableSplitMapper.mapOrderFeedback(siteId);
		if (feedbackTable == null) {
			return null;
		}

		return Db.findFirst("select a.* from " + feedbackTable + " a where a.order_id=? and a.site_id=? and feedback_type ='1' ORDER  BY feedback_time DESC LIMIT 1 ", orderId,
				siteId);
	}

	public void updateHistoryUser(Order order, String factoryNumber) {
		Order orderUpdate = orderDao.get(order.getId());
		Record rd = Db.findFirst("select * from crm_order a where a.id='" + order.getId() + "'");
		orderUpdate.setCustomerName(order.getCustomerName());
		orderUpdate.setCustomerMobile(order.getCustomerMobile());
		orderUpdate.setCustomerTelephone(order.getCustomerTelephone());
		orderUpdate.setCustomerTelephone2(order.getCustomerTelephone2());
		orderUpdate.setCustomerAddress(order.getCustomerAddress());
		orderUpdate.setProvince(order.getProvince());
		orderUpdate.setCity(order.getCity());
		orderUpdate.setArea(order.getArea());

		orderUpdate.setCustomerLnglat(order.getCustomerLnglat());

		orderUpdate.setApplianceBrand(order.getApplianceBrand());
		orderUpdate.setApplianceCategory(order.getApplianceCategory());
		orderUpdate.setPromiseTime(order.getPromiseTime());
		orderUpdate.setPromiseLimit(order.getPromiseLimit());
		orderUpdate.setCustomerFeedback(order.getCustomerFeedback());
		orderUpdate.setRemarks(order.getRemarks());
		orderUpdate.setApplianceModel(order.getApplianceModel());
		orderUpdate.setApplianceNum(order.getApplianceNum());
		orderUpdate.setApplianceBarcode(order.getApplianceBarcode());
		orderUpdate.setApplianceMachineCode(order.getApplianceMachineCode());
		orderUpdate.setApplianceBuyTime(order.getApplianceBuyTime());
		orderUpdate.setPleaseReferMall(order.getPleaseReferMall());

		orderUpdate.setParentDipatchFlag(order.getParentDipatchFlag());

		orderUpdate.setWarrantyType(order.getWarrantyType());
		orderUpdate.setLevel(order.getLevel());
		orderUpdate.setCustomerType(order.getCustomerType());
		orderUpdate.setServiceMode(order.getServiceMode());
		orderUpdate.setBdImgs(order.getBdImgs());

		String name = CrmUtils.getUserXM();
		String finalProcessDetail = rd.getStr("process_detail");
		String finalLatestDetail = "";
		Date processTime = new Date();
		if ("1".equals(orderUpdate.getRecordAccount())) {// 曾经录过单
			if (!orderUpdate.getFactoryNumber().equals(factoryNumber)) {
				finalLatestDetail = name + "修改厂家工单编号为" + factoryNumber + "，原厂家工单编号为" + orderUpdate.getFactoryNumber();
				Target ta1 = new Target();
				ta1.setName(name);
				ta1.setContent(finalLatestDetail);
				ta1.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				ta1.setType(Target.SITE_EDIT_RECORD_ACCOUNT_TYPE);
				finalProcessDetail = WebPageFunUtils.appendProcessDetail(ta1, rd.getStr("process_detail"));
				orderUpdate.setRecordAccountTime(new Date());
				orderUpdate.setFactoryNumber(factoryNumber);
			}
		}

		String customer_mobile = "";
		String customer_telephone = "";
		String customer_telephone2 = "";
		if (StringUtil.isNotBlank(rd.getStr("customer_mobile"))) {
			customer_mobile = rd.getStr("customer_mobile");
		}
		if (StringUtil.isNotBlank(rd.getStr("customer_telephone"))) {
			customer_telephone = rd.getStr("customer_telephone");
		}
		if (StringUtil.isNotBlank(rd.getStr("customer_telephone2"))) {
			customer_telephone2 = rd.getStr("customer_telephone2");
		}
		if ((!customer_mobile.equals(order.getCustomerMobile())) || (!customer_telephone.equals(order.getCustomerTelephone()))
				|| (!customer_telephone2.equals(order.getCustomerTelephone2()))) {

			StringBuffer latestProcess = new StringBuffer();
			latestProcess.append(name);
			latestProcess.append("修改用户联系方式为：");
			if (!customer_mobile.equals(order.getCustomerMobile())) {
				latestProcess.append(order.getCustomerMobile());
				latestProcess.append("  ");
			}
			if (!customer_telephone.equals(order.getCustomerTelephone())) {
				latestProcess.append(order.getCustomerTelephone());
				latestProcess.append("  ");
			}
			if (!customer_telephone2.equals(order.getCustomerTelephone2())) {
				latestProcess.append(order.getCustomerTelephone2());
				latestProcess.append("  ");
			}
			latestProcess.append(",原用户联系方式为：");
			if (!customer_mobile.equals(order.getCustomerMobile())) {
				latestProcess.append(rd.getStr("customer_mobile"));
				latestProcess.append("  ");
			}
			if (!customer_telephone.equals(order.getCustomerTelephone())) {
				latestProcess.append(rd.getStr("customer_telephone"));
				latestProcess.append("  ");
			}
			if (!customer_telephone2.equals(order.getCustomerTelephone2())) {
				latestProcess.append(rd.getStr("customer_telephone2"));
				latestProcess.append("  ");
			}

			Target ta = new Target();
			ta.setName(name);
			ta.setContent(latestProcess.toString());
			ta.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			ta.setType(Target.MODIFY_YHMSG);
			finalProcessDetail = WebPageFunUtils.appendProcessDetail(ta, finalProcessDetail);
			if (StringUtils.isNotBlank(finalLatestDetail)) {
				finalLatestDetail = finalLatestDetail + "；" + latestProcess.toString();
			} else {
				finalLatestDetail = latestProcess.toString();
			}
		}
		if (StringUtils.isNotBlank(finalLatestDetail)) {
			orderUpdate.setLatestProcess(finalLatestDetail);
			orderUpdate.setLatestProcessTime(processTime);
			orderUpdate.setProcessDetail(finalProcessDetail);
		}
		orderDao.save(orderUpdate);
		orderDao.updateFittingOrder(orderUpdate);
		
	}

	public Result<T> confirmJk(String ids) {
		Result<T> rt = new Result<>();
		try {
			Db.update("update crm_order a set a.whether_collection='1' where a.id in(" + ids + ")");
			rt.setCode("200");
			rt.setMsg("jk success");
			return rt;
		} catch (Exception e) {
			rt.setCode("421");
			rt.setMsg("jk wrong");
			return rt;
		}
	}

	public Result<T> confirmJd(String ids) {
		Result<T> rt = new Result<>();
		try {
			Db.update("update crm_order a set a.return_card='1',a.return_card_time=now() where a.id in(" + ids + ")");
			rt.setCode("200");
			rt.setMsg("jd success");
			return rt;
		} catch (Exception e) {
			rt.setCode("421");
			rt.setMsg("jd wrong");
			return rt;
		}
	}

	// 表头排序
	@SuppressWarnings("unused")
	private String createOrderBy(Map<String, Object> map, String defaultOrderBy) {
		String sort = null;
		String dir = null;
		if (map.get("sidx") != null) {
			if (StringUtils.isNotBlank(map.get("sidx").toString())) {
				if ("end_time".equals(map.get("sidx").toString())) {
					sort = "o.end_time";
				} else {
					sort = map.get("sidx").toString();
				}
			}
		}
		if (map.get("sord") != null) {
			if (StringUtils.isNotBlank(map.get("sord").toString())) {
				dir = map.get("sord").toString();
			}
		}

		String result = defaultOrderBy;
		if (map.get("sidx") != null) {
			if ("end_time".equals(map.get("sidx").toString())) {
				result = (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by " + sort + " " + dir) : defaultOrderBy;
			} else {
				result = (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(dir)) ? ("order by `" + sort + "` " + dir) : defaultOrderBy;
			}
		}

		return result;
	}

	public Long whereData(Map<String, Object> map, String time, String siteId, String orderId, String parentNumber) {
		String status = null;
		if (map.get("statusFlagMap") != null) {
			status = map.get("statusFlagMap").toString();
		}
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(1) as count FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5')");
		sf.append(" WHERE o.site_id=? and o.id != '" + orderId + "' and o.create_time = '" + time + "' and o.number > '" + parentNumber + "' ");
		if (status == null) {
			status = "";
		}
		String[] statusx = null;
		if (StringUtil.isNotBlank(status)) {
			statusx = status.split(",");
		}
		if (statusx != null && statusx.length > 0) {
			sf.append(" AND o.status IN (" + StringUtil.joinInSql(statusx) + ") ");
		}
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			String cate = nonService.servicemanCate(user.getId(), siteId);
			String brand = nonService.servicemanBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cate);
			brandList = StringUtil.tolist(brand);
		}
		sf.append(orderDao.getOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(" limit 1 offset 0 ");
		return Db.queryLong(sf.toString(), siteId);
	}

	public Long whereData1(Map<String, Object> map, String time, String siteId, String orderId, String parentNumber) {
		String status = null;
		if (map.get("statusFlagMap") != null) {
			status = map.get("statusFlagMap").toString();
		}
		StringBuffer sf = new StringBuffer();
		sf.append(" SELECT count(1) as count FROM crm_order o  ");
		sf.append(" left join crm_order_dispatch cod on cod.order_id = o.id and cod.site_id = '" + siteId + "' and cod.status in ('1','2','4','5')");
		sf.append(" WHERE o.site_id=? and o.id != '" + orderId + "' and o.create_time = '" + time + "' and o.number < '" + parentNumber + "' ");
		if (status == null) {
			status = "";
		}
		String[] statusx = null;
		if (StringUtil.isNotBlank(status)) {
			statusx = status.split(",");
		}
		if (statusx != null && statusx.length > 0) {
			sf.append(" AND o.status IN (" + StringUtil.joinInSql(statusx) + ") ");
		}
		User user = UserUtils.getUser();
		List<String> cateList = null;
		List<String> brandList = null;
		if (!("2".equals(user.getUserType()))) {
			String cate = nonService.servicemanCate(user.getId(), siteId);
			String brand = nonService.servicemanBrand(user.getId(), siteId);
			cateList = StringUtil.tolist(cate);
			brandList = StringUtil.tolist(brand);
		}
		sf.append(orderDao.getOrderWholeCondition(map, siteId, cateList, brandList));
		sf.append(" limit 1 offset 0 ");
		return Db.queryLong(sf.toString(), siteId);
	}

	/*
	 * 点击下一单
	 */
	public Record getNextOrderId(Map<String, Object> map, String time, String siteId, String orderId, String parentNumber) {
		logger.error("getNextOrderId should not called", new Exception());
		return null;
	}

	/*
	 * 点击上一单
	 */
	public Record getPreviousOrderId(Map<String, Object> map, String time, String siteId, String orderId, String parentNumber) {
		logger.error("getPreviousOrderId should not called", new Exception());
		return null;
	}

	// 结算条件设置查询
	public Record queryLsSet(String siteId) {
		return Db.findFirst("select a.* from crm_site_common_setting a where a.site_id=? and a.type='5' limit 1", siteId);
	}

	// 工单收费信息
	public Record getOrderMoneyMsg(String orderId) {
		return Db.findFirst("select a.* from crm_order a where a.id=?", orderId);
	}

	// 工单收费信息
	@Deprecated
	public Record getOrderMoneyMsg2017(String orderId, String siteId) {
		return order2017Dao.findOrderById(orderId, siteId);
	}

	// 根据order_id 查询comletion_result
	public String getCompletionResult(String orderId, String sietId) {
		return Db.queryStr("select d.completion_result from crm_order_dispatch as d where d.order_id=? and d.site_id =? and d.status in ('1','2','4','5')", orderId, sietId);
	}

	public List<Record> getCollectionlistByOrderNumber(String orderNo, String siteId) {
		return orderDispatchDao.getCollectionlistByOrderNo(orderNo, siteId);
	}

	// 判断工单条码是否有相同的--工单//2018/1/30:要求过滤条码为0000000的工单匹配
	public Map<String, Object> checkIfHasSameCode(String siteId, Order order) {
		Map<String, Object> map = new HashMap<>();
		Long count1 = (long) 0;
		Long count2 = (long) 0;
		if (StringUtils.isNotBlank(order.getApplianceBarcode()) && !"0000000".equals(order.getApplianceBarcode())) {
			count1 = Db.queryLong("select count(*) from crm_order a where a.id!=? and a.site_id=? and (a.appliance_barcode=? or a.appliance_machine_code=?) ", order.getId(),
					siteId, order.getApplianceBarcode(), order.getApplianceBarcode());
		}
		if (StringUtils.isNotBlank(order.getApplianceMachineCode()) && !"0000000".equals(order.getApplianceMachineCode())) {
			count2 = Db.queryLong("select count(*) from crm_order a where a.id!=? and a.site_id=? and (a.appliance_barcode=? or a.appliance_machine_code=?) ", order.getId(),
					siteId, order.getApplianceMachineCode(), order.getApplianceMachineCode());
		}

		map.put("codeIn", count1);
		map.put("codeOut", count2);
		return map;
	}

	/**
	 *
	 * @param order
	 *            order which status will be changed
	 * @param parentStatus
	 *            the parent status to be changed
	 */
	public static void setParentStatusWithGuard(Order order, String parentStatus) {
		if (StringUtil.isBlank(order.getId())) {
			throw new IllegalArgumentException("order should be persisted");
		}

		String oldParentStatus = order.getParentStatus();
		if (Order.PSTATUS_CALLBACK.equals(oldParentStatus) || Order.PSTATUS_WAIT_CALLBACK.equals(oldParentStatus)) {
			// skip or throw exception?，i think should skip this attempt
			return;
		}
		order.setParentStatus(parentStatus);
	}

	public static void setParentStatusWithGuard2017(Record order, String parentStatus, TableSplitMapper mapper, String siteId) {
		if (StringUtil.isBlank(order.getStr("id"))) {
			throw new IllegalArgumentException("order should be persisted");
		}
		String orderTable = mapper.mapOrder(siteId);
		if (orderTable == null) {
			throw new RuntimeException("table not found");
		}

		String oldParentStatus = order.getStr("parent_status");
		if (CrmOrder2017.PSTATUS_CALLBACK.equals(oldParentStatus) || CrmOrder2017.PSTATUS_WAIT_CALLBACK.equals(oldParentStatus)) {
			// skip or throw exception?，i think should skip this attempt
			return;
		}
		Db.update("update " + orderTable + " set parent_status=? where id=?", parentStatus, order.getStr("id"));
	}

	public Record showLatestAnnounce(String siteId) {
		return Db.findFirst(
				"SELECT a.*,b.id AS readId FROM  crm_announcement a LEFT JOIN crm_announcement_site_read b ON a.id=b.announcement_id AND b.site_id=? WHERE a.status='0'  ORDER BY a.create_time DESC LIMIT 1",
				siteId);
	}

	@Transactional(rollbackFor = Exception.class)
	public void updateAnnounce(String siteId, Record rd) {
		AnnouncementSiteRead asr = new AnnouncementSiteRead();
		asr.setAnnouncementId(rd.getStr("id"));
		asr.setSiteId(siteId);
		announcementSiteReadDao.save(asr);
	}

	public Record showLatestAnnounceById(String id) {
		return Db.findFirst("select a.* from crm_announcement a where a.id=? ", id);
	}

	@Transactional(rollbackFor = Exception.class)
	public String deleteProcessImage(String id, String path) {
		Record rd = Db.findFirst("select a.* from crm_order_feedback a where a.id=? limit 1", id);
		if (rd == null) {
			return "420";// 过程信息有误！
		}
		String imgs = rd.getStr("feedback_img");// 所有的过程反馈图片
		if (StringUtils.isBlank(imgs)) {
			return "421";// 该图片已被删除，请刷新后重试！
		}
		String[] arr = imgs.split(",");
		String marks = "1";
		String newImags = "";
		String[] pathArr = path.split("/");
		for (String str : arr) {
			String[] strArr = str.split("/");
			if (path.equals(str) || pathArr[pathArr.length - 1].equals(strArr[strArr.length - 1])) {
				marks = "2";
			} else {
				newImags += StringUtils.isBlank(newImags) ? str : "," + str;
			}
		}

		if ("1".equals(marks)) {

			return "421";// 该图片已被删除，请刷新后重试！
		}

		SQLQuery sql = announcementSiteReadDao.getSession().createSQLQuery("update crm_order_feedback set feedback_img=:feedbackImg where id=:id");
		sql.setParameter("feedbackImg", newImags);
		sql.setParameter("id", id);
		sql.executeUpdate();

		String orderId = rd.getStr("order_id");
		Order od = orderDao.get(orderId);
		Target ta = new Target();
		String name = CrmUtils.getUserXM();
		ta.setType(Target.SITE_ORDER_DELETE_PROCESS_IMG);// 删除过程图片
		ta.setName(name);
		ta.setContent(name + "删除过程图片");
		ta.setTime(DateToStringUtils.DateToString());
		String str = WebPageFunUtils.appendProcessDetail(ta, od.getProcessDetail());
		od.setProcessDetail(str);
		od.setLatestProcess(name + "删除过程图片");
		od.setLatestProcessTime(new Date());
		orderDao.save(od);
		return "200";
	}
}
