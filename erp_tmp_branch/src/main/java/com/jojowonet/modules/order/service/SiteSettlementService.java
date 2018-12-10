package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbPro;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.operate.dao.EmployeDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import com.jojowonet.modules.order.adapters.HistoryBkOrderSettlement;
import com.jojowonet.modules.order.adapters.HistoryBkOrderSettlementDetail;
import com.jojowonet.modules.order.dao.*;
import com.jojowonet.modules.order.entity.*;
import com.jojowonet.modules.order.form.*;
import com.jojowonet.modules.order.form.vo.*;
import com.jojowonet.modules.order.utils.*;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Parameter;
import ivan.common.service.BaseService;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


@Service
public class SiteSettlementService extends BaseService {

    public static final Log logger = LogFactory.getLog(SiteSettlementService.class);

    @Autowired
    SettlementTemplateDao tmplDao;
    @Autowired
    OrderSettlementDao settlementDao;
    @Autowired
    OrderService orderService;
    @Autowired
    SessionFactory sessionFactory;
    @Autowired
    EmployeDao employeDao;
    @Autowired
    private OrderDispatchService orderDispatchService;
    @Autowired
    private Order2017Dao order2017Dao;
    @Autowired
    private OrderSettlement2017Dao orderSettlement2017Dao;
    @Autowired
    private OrderSettlementDetail2017Dao orderSettlementDetail2017Dao;
    @Autowired
    OrderDao orderDao;
    @Autowired
    TableSplitMapper tableSplitMapper;

    private static final String BASE_TYPE_CUSTOM = "0"; // 自定义
    private static final String BASE_TYPE_SERVE = "1"; // 服务费
    private static final String BASE_TYPE_ACC = "2"; // 辅材费
    private static final String BASE_TYPE_YAN_BAO = "3"; // 延保费
    private static final String BASE_TYPE_FUCAI_PROFITS = "4"; // 默认辅材利润（辅材收费-配件入库价）
    private static final String BASE_TYPE_EMP_FUCAI_PROFITS = "6"; // 默认辅材利润（辅材收费-工程师价格）
    private static final String BASE_TYPE_CJJSF = "5"; // 厂家结算费

    private static final String ADDED_TYPE_KK = "1"; // 扣款
    private static final String ADDED_TYPE_DRZF = "2"; // 当日支付
    private static final String ADDED_TYPE_XZJS = "3"; // 新增结算费

    private static final String TYPE_JRZF_STR = "当日支付";
    private static final String JF_TYPE_NEW = "0"; // 结算
    private static final String JF_TYPE_RENEW = "1"; // 重新结算

    /**
     * 获取工单的辅材成本。
     *
     * @param orderNumber 工单id
     * @return 工单辅材费用
     */
    public BigDecimal getOrderAccessoryCost(String orderNumber, String siteId) {
        SqlKit kit = new SqlKit()
                .append("SELECT COALESCE(SUM(u.`used_num`*f.`site_price`), 0) FROM `crm_site_fitting_used_record` AS u")
                .append("INNER JOIN crm_site_fitting AS f")
                .append("ON u.`fitting_id`=f.`id`")
                .append("WHERE u.`type`='1'")
                .append("AND f.`site_id`=?")
                .append("AND u.`order_number`=?")
                .append("AND u.`site_id`=?")
                .append("AND u.`collection_flag`='1'");

        BigDecimal ret = Db.queryBigDecimal(kit.toString(), siteId, orderNumber, siteId);
        return ret.setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * 获取工单所消耗的配件的入库价格总和工程师价格总和。
     * @param orderNumber 工单id
     */
    public BigDecimal[] getOrderAccessoryCostAndEmpAccCost(String orderNumber, String siteId) {
        SqlKit kit = new SqlKit()
                .append("SELECT COALESCE(SUM(u.`used_num`*f.`site_price`), 0) as accCost, COALESCE(SUM(u.`used_num`*f.`employe_price`), 0) as empAccCost FROM `crm_site_fitting_used_record` AS u")
                .append("INNER JOIN crm_site_fitting AS f")
                .append("ON u.`fitting_id`=f.`id`")
                .append("WHERE u.`type`='1'")
                .append("AND f.`site_id`=?")
                .append("AND u.`order_number`=?")
                .append("AND u.`site_id`=?")
                .append("AND u.`collection_flag`='1'");

        Record rs = Db.findFirst(kit.toString(), siteId, orderNumber, siteId);
        BigDecimal[] ret = new BigDecimal[2];
        ret[0] = rs.getBigDecimal("accCost").setScale(2, RoundingMode.HALF_UP);
        ret[1] = rs.getBigDecimal("empAccCost").setScale(2, RoundingMode.HALF_UP);
        return ret;
    }

    public List<Record> getOrderRelatedEmployeList(String orderId) {
        return orderService.getOrderRelatedEmployeList(orderId);
    }

    public List<Record> getOrderRelatedEmployeList2017(String orderId, String siteId) {
        return orderService.getOrderRelatedEmployeList2017(orderId, siteId);
    }


    /**
     * 获取网点指定品类的所有结算方案。
     *
     * @param orderUsedFittingCost 工单使用配件的配件成本，即入库价格。
     * @param order                指定的工单
     * @return 返回每种结算方案针对于指定order的各个结算项的值。
     */
    @SuppressWarnings("unchecked")
    public List<SettlementTemplateVo> getSiteSettlementTemplateList(Order order, BigDecimal[] orderUsedFittingCost) {
        String category = order.getApplianceCategory();
        List<SettlementTemplateVo> templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, category);
        if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("空调")) { //对空调特殊处理
            templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, "空调");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("冰箱")) { //对冰箱特殊处理
            templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, "冰箱");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("洗衣机")) { //对洗衣机特殊处理
            templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, "洗衣机");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("净水器")) { //对净水器特殊处理
            templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, "净水器");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("烟机")) { //对烟机特殊处理
            templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, "烟机");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("热水器")) { //对热水器特殊处理
            templateVos = doGetSiteSettlementTemplateList(order, orderUsedFittingCost, "热水器");
        }
        return templateVos;
    }

    @SuppressWarnings("unchecked")
    public List<SettlementTemplateVo> getSiteSettlementTemplateList2017(HistoryBkOrder order, BigDecimal[] orderUsedFittingCost) {
        String category = order.getApplianceCategory();
        List<SettlementTemplateVo> templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, category);
        if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("空调")) { //对空调特殊处理
            templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, "空调");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("冰箱")) { //对冰箱特殊处理
            templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, "冰箱");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("洗衣机")) { //对洗衣机特殊处理
            templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, "洗衣机");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("净水器")) { //对净水器特殊处理
            templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, "净水器");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("烟机")) { //对烟机特殊处理
            templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, "烟机");
        } else if (templateVos.isEmpty() && StringUtils.isNotBlank(category) && category.contains("热水器")) { //对热水器特殊处理
            templateVos = doGetSiteSettlementTemplateList2017(order, orderUsedFittingCost, "热水器");
        }
        return templateVos;
    }

    public List<SettlementTemplateVo> doGetSiteSettlementTemplateList(Order order, BigDecimal[] orderUsedFittingCost, String category) {
        List<SettlementTemplateVo> ret = new ArrayList<>();
        Query query = tmplDao.getSession().createQuery("from SettlementTemplate where siteId=:sid and status=:s and category like :category");
        query.setParameter("s", "0");
        query.setParameter("sid", order.getSiteId());
        query.setParameter("category", '%' + category + '%');
        List<SettlementTemplate> list = query.list();

        Map<String, SettlementTemplateVo> templateMapping = new HashMap<>();
        int index = 0;
        for (SettlementTemplate tmpl : list) {
            String templateName = tmpl.getServiceMeasures();
            String templateCategory = tmpl.getCategory();
            String key = templateCategory + templateName;
            SettlementTemplateVo vo = templateMapping.get(key);
            if (vo == null) {
                vo = new SettlementTemplateVo();
                vo.setName(templateName);
                vo.setIndex(++index);
                templateMapping.put(key, vo);
                ret.add(vo);
            }
            vo.getItems().add(createSettlementItem(tmpl, order, orderUsedFittingCost));
        }

        return ret;
    }

    public List<SettlementTemplateVo> doGetSiteSettlementTemplateList2017(HistoryBkOrder order, BigDecimal[] orderUsedFittingCost, String category) {
        List<SettlementTemplateVo> ret = new ArrayList<>();
        Query query = tmplDao.getSession().createQuery("from SettlementTemplate where siteId=:sid and status=:s and category like :category");
        query.setParameter("s", "0");
        query.setParameter("sid", order.getSiteId());
        query.setParameter("category", '%' + category + '%');
        List<SettlementTemplate> list = query.list();

        Map<String, SettlementTemplateVo> templateMapping = new HashMap<>();
        int index = 0;
        for (SettlementTemplate tmpl : list) {
            String templateName = tmpl.getServiceMeasures();
            String templateCategory = tmpl.getCategory();
            String key = templateCategory + templateName;
            SettlementTemplateVo vo = templateMapping.get(key);
            if (vo == null) {
                vo = new SettlementTemplateVo();
                vo.setName(templateName);
                vo.setIndex(++index);
                templateMapping.put(key, vo);
                ret.add(vo);
            }
            vo.getItems().add(createSettlementItem2017(tmpl, order, orderUsedFittingCost));
        }

        return ret;
    }

    /**
     * 获取网点指定品类的所有结算模板。
     *
     * @param siteId 网点
     */
    @SuppressWarnings("unchecked")
    public List<SettlementTemplateVo> getSiteSettlementTemplateList(String siteId) { // SettlementTemplateVo 代表一个真正的模板，包含若干结算项目。
        List<SettlementTemplateVo> ret = new ArrayList<>();
        Query query = tmplDao.getSession().createQuery("from SettlementTemplate where siteId=:sid and status=:s");
        query.setParameter("s", "0");
        query.setParameter("sid", siteId);
        List<SettlementTemplate> list = query.list(); // SettlementTemplate其实并不是一个完整的模板，其实是一个模板项。
        Map<String, SettlementTemplateVo> templateMapping = new HashMap<>();

        int index = 0;
        for (SettlementTemplate tmpl : list) {
            String templateName = tmpl.getServiceMeasures();
            String templateCategory = tmpl.getCategory();
            String key = templateCategory + templateName;
            SettlementTemplateVo vo = templateMapping.get(key);
            if (vo == null) {
                vo = new SettlementTemplateVo();
                vo.setName(templateName);
                vo.setIndex(++index); // 配合前台页面，其实通过其他方法也可以不需要这个字段。
                templateMapping.put(key, vo);
                ret.add(vo);
            }
            vo.getItems().add(createSettlementItem(tmpl)); // 根据结算模板项生成结算项目
        }

        return ret;
    }

    private SettlementItem createSettlementItem(SettlementTemplate tmpl) { // 批量结算项会使用到此方法
        SettlementItem item = new SettlementItem();
        item.setId(tmpl.getId());
        item.setName(tmpl.getChargeName());
        item.setType(tmpl.getBasisType());
        Double chargeAmount = tmpl.getChargeAmount(); // 如果proportion为null 那么说明按照固定值结算，否则按照比例结算。
        double cost = 0;
        Integer chargeProportion = tmpl.getChargeProportion();
        if (chargeProportion == null) {
            cost = chargeAmount;
        } else {
            String basisType = tmpl.getBasisType();
            if (BASE_TYPE_CUSTOM.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * tmpl.getBasisAmount();
            } else if (BASE_TYPE_SERVE.equals(basisType)) {
                cost = chargeProportion;
                item.setProportion(true);
            } else if (BASE_TYPE_ACC.equals(basisType)) {
                cost = chargeProportion;
                item.setProportion(true);
            } else if (BASE_TYPE_YAN_BAO.equals(basisType)) {
                cost = chargeProportion;
                item.setProportion(true);
            } else if (BASE_TYPE_FUCAI_PROFITS.equals(basisType)) {
                cost = chargeProportion;
                item.setProportion(true);
            } else if (BASE_TYPE_EMP_FUCAI_PROFITS.equals(basisType)) {
                cost = chargeProportion;
                item.setProportion(true);
            } else if (BASE_TYPE_CJJSF.equals(basisType)) {
                cost = chargeProportion; // 由于厂家结算费用预先并不知道，需要在页面中输入。
                item.setProportion(true);
            }
        }
        item.setCost(BigDecimal.valueOf(cost).setScale(2, RoundingMode.HALF_UP));
        return item;
    }

    private SettlementItem createSettlementItem(SettlementTemplate tmpl, Order order, BigDecimal[] orderUsedFittingCost) {
        SettlementItem item = new SettlementItem();
        item.setName(tmpl.getChargeName());
        String basisType = tmpl.getBasisType();
        Double chargeAmount = tmpl.getChargeAmount(); // 如果proportion为null， 那么说明按照固定值结算，否则按照比例结算。
        Integer chargeProportion = tmpl.getChargeProportion();
        double cost = 0;
        if (chargeProportion == null) {
            cost = chargeAmount;
        } else {
            if (BASE_TYPE_CUSTOM.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * tmpl.getBasisAmount();
            } else if (BASE_TYPE_SERVE.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * order.getServeCost();
            } else if (BASE_TYPE_ACC.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * order.getAuxiliaryCost();
            } else if (BASE_TYPE_YAN_BAO.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * order.getWarrantyCost();
            } else if (BASE_TYPE_FUCAI_PROFITS.equals(basisType)) {
                double based = (order.getAuxiliaryCost() - (orderUsedFittingCost == null ? 0 : orderUsedFittingCost[0].doubleValue()));
                cost = (double) chargeProportion / 100.0 * based;
            } else if (BASE_TYPE_EMP_FUCAI_PROFITS.equals(basisType)) {
                double based = (order.getAuxiliaryCost() - (orderUsedFittingCost == null ? 0 : orderUsedFittingCost[1].doubleValue()));
                cost = (double) chargeProportion / 100.0 * based;
            } else if (BASE_TYPE_CJJSF.equals(basisType)) {
                cost = 0; // 厂家结算费是在页面上临时输入的，因此无法根据工单信息以及模板预先计算。
                item.setFactoryPV(chargeProportion / 100.0d);
                item.setProportion(true);
                item.setType(BASE_TYPE_CJJSF);
            }
        }
        item.setCost(BigDecimal.valueOf(cost).setScale(2, RoundingMode.HALF_UP));
        return item;
    }

    private SettlementItem createSettlementItem2017(SettlementTemplate tmpl, HistoryBkOrder order, BigDecimal[] orderUsedFittingCost) {
        SettlementItem item = new SettlementItem();
        item.setName(tmpl.getChargeName());
        String basisType = tmpl.getBasisType();
        Double chargeAmount = tmpl.getChargeAmount(); // 如果proportion为null， 那么说明按照固定值结算，否则按照比例结算。
        Integer chargeProportion = tmpl.getChargeProportion();
        double cost = 0;
        if (chargeProportion == null) {
            cost = chargeAmount;
        } else {
            if (BASE_TYPE_CUSTOM.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * tmpl.getBasisAmount();
            } else if (BASE_TYPE_SERVE.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * MathUtils.getDouble(order.getServeCost(), 2);
            } else if (BASE_TYPE_ACC.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * MathUtils.getDouble(order.getAuxiliaryCost(), 2);
            } else if (BASE_TYPE_YAN_BAO.equals(basisType)) {
                cost = (double) chargeProportion / 100.0 * MathUtils.getDouble(order.getWarrantyCost(), 2);
            } else if (BASE_TYPE_FUCAI_PROFITS.equals(basisType)) {
                double based = (order.getAuxiliaryCost().doubleValue() - (orderUsedFittingCost == null ? 0 : orderUsedFittingCost[0].doubleValue()));
                cost = (double) chargeProportion / 100.0 * based;
            } else if (BASE_TYPE_EMP_FUCAI_PROFITS.equals(basisType)) {
                double based = (order.getAuxiliaryCost().doubleValue() - (orderUsedFittingCost == null ? 0 : orderUsedFittingCost[1].doubleValue()));
                cost = (double) chargeProportion / 100.0 * based;
            } else if (BASE_TYPE_CJJSF.equals(basisType)) {
                cost = 0; // 厂家结算费是在页面上临时输入的，因此无法根据工单信息以及模板预先计算。
                item.setFactoryPV(chargeProportion / 100.0d);
                item.setProportion(true);
                item.setType(BASE_TYPE_CJJSF);
            }
        }
        item.setCost(BigDecimal.valueOf(cost).setScale(2, RoundingMode.HALF_UP));
        return item;
    }


    // 2018-01-05号改动：派工单工程师的结算费可以手动修改
    public Result<Void> save(SettlementForm settlementForm) {
        // dispatch_id is of no use
        OrderSettlement settlement = new OrderSettlement();
        Order order = orderService.get(settlementForm.getOrderId());

        if (!JF_TYPE_RENEW.equals(settlementForm.getMode()) && hasAlreadyC(settlementForm.getOrderId())) {
//            return Result.fail("421", String.format("order[%s] has already been settled", settlementForm.getOrderId()));
            if (StringUtil.isNotBlank(settlementForm.getOrderId())) {
                Record s = Db.findFirst("select * from crm_order_settlement where order_id=? limit 1", settlementForm.getOrderId());
                if (s != null) {
                    Db.update("delete from crm_order_settlement where order_id=?", settlementForm.getOrderId());
                    Db.update("delete from crm_order_settlement_detail where settlement_id=?", s.getStr("id"));
                }
            }
        }

        User user = UserUtils.getUser();
        String username = CrmUtils.getUserXM();
        String siteId = CrmUtils.getCurrentSiteId(user);
        Double factoryFee = safeDoubleConv(settlementForm.getFactoryFee()); // 厂家结算费
        Double auxiliaryFee = safeDoubleConv(settlementForm.getAccCost()); // 辅材成本
        Double empTotalFee = calcDispAndAddedEmployeCost(settlementForm); // 工程师支出
//        Double orderFee = order.getServeCost() + order.getAuxiliaryCost() + order.getWarrantyCost();
        Record rds = Db.findFirst("select a.* from crm_order_settlement a where a.site_id=? and a.order_id=?",siteId,settlementForm.getOrderId());
        settlement.setOrderId(settlementForm.getOrderId());
        settlement.setCreateTime(new Date());
        settlement.setSettlementTime(formatDate(settlementForm.getSettlementTime()));
        settlement.setCreateName(username);
        settlement.setRemarks(settlementForm.getMemo());
        settlement.setServiceMeasures(settlementForm.getsMethod());
        settlement.setSiteId(siteId);
        settlement.setCreateBy(user.getId());
        settlement.setFittingCosts(auxiliaryFee);
        settlement.setFactoryMoney(factoryFee);
        settlement.setSumMoney(empTotalFee);
        // profits 已经不是计算出来，而是手填。
//        settlement.setProfits(orderFee + factoryFee - auxiliaryFee - empTotalFee);
        String strProfit = settlementForm.getProfit();
        settlement.setProfits(StringUtil.isBlank(strProfit) ? 0 : Double.valueOf(strProfit.trim()));
        settlement.setCostDetail(overallCostDetail(settlementForm)); // 暂时不存cost detail
        settlement.setSettlementDetail(createSettlementDetail(settlementForm));
        settlement.setPaymentAmount(safeDoubleConv(settlementForm.getPaymentAmount()));

        String orderId = settlementForm.getOrderId();
        List<Record> orderDispEmployeList = getOrderRelatedEmployeList(orderId);

        if (!JF_TYPE_RENEW.equals(settlementForm.getMode())) {
            if (orderDispEmployeList == null || orderDispEmployeList.size() == 0) {
                return Result.fail("422", String.format("order[%s] has no related employee", settlementForm.getOrderId()));
            }
        }

        List<AddedSettlementItem> addedSettlementItem = settlementForm.getAddedJisuan();
        List<OrderSettlementDetail> details = createSettlementDetailsForDispEmps(orderDispEmployeList, settlementForm, siteId, username);
        List<OrderSettlementDetail> detailsForAddedEmps = createSettlementDetailsForAddedEmps(settlementForm, addedSettlementItem, siteId, username);
        details.addAll(detailsForAddedEmps);

        StatelessSession session = sessionFactory.openStatelessSession();
        Transaction tx = session.beginTransaction();
        if (JF_TYPE_RENEW.equals(settlementForm.getMode())) {
            // 重新结算
            OrderSettlement oldSettlement = settlementDao.getByHql("from OrderSettlement where orderId=:p1 and siteId=:p2", new Parameter(orderId, siteId));
            if (oldSettlement != null) {
                session.delete(oldSettlement);
                SQLQuery sqlQuery = session.createSQLQuery("delete from crm_order_settlement_detail where settlement_id=:sid");
                sqlQuery.setParameter("sid", oldSettlement.getId());
                sqlQuery.executeUpdate();
            }
            // 重置工单的审核状态为未审核
            order.setReview("0");
        }
        session.insert(settlement);

        Date now = new Date();
        order.setStatus("5");
        if(StringUtils.isNotBlank(order.getParentSiteId())) {
			order.setParentStatus("5");
		}
        OrderDispatchService.setParentStatusWithGuard(order, Order.PSTATUS_WAIT_CALLBACK);
        String content = String.format(JF_TYPE_RENEW.equals(settlementForm.getMode()) ? "%s重新结算" : "%s结算", username);
        if(JF_TYPE_RENEW.equals(settlementForm.getMode())) {//重新结算
        	if(rds!=null) {
        		double oldSumMny = rds.getBigDecimal("sum_money")!=null ? Double.valueOf(rds.getBigDecimal("sum_money").toString()) : Double.valueOf("0");
        		double newSumMny = empTotalFee;
        		if(oldSumMny!=newSumMny) {
        			content = content + "，原结算金额为"+oldSumMny+"元，新结算金额为"+newSumMny+"元";
        			order.setLatestProcessTime(new Date());
        			order.setLatestProcess(content);
        		}
        	}
        }
        Target ta1 = new Target();
        ta1.setContent(content);
        ta1.setName(username);
        ta1.setType(Target.MESS_SETTLEMENT);
        ta1.setTime(formatDatetime(new Date()));

        Target ta = new Target();
        ta.setContent("工单完成");
        ta.setName(username);
        ta.setType(Target.COMPLETE_ORDER);
        ta.setTime(formatDatetime(new Date(now.getTime() + 1)));
        List<Target> targets = new ArrayList<>();
        targets.add(ta1);
        targets.add(ta);

        order.setProcessDetail(WebPageFunUtils.appendProcessDetails(targets, org.apache.commons.lang.StringUtils.defaultIfEmpty(order.getProcessDetail(), "")));
        session.update(order);

        for (OrderSettlementDetail detail : details) {
            detail.setSettlementId(settlement.getId());
            session.insert(detail);
        }
        try {
            tx.commit();
        } catch (Exception ex) {
            tx.rollback();
            logger.error(ex.getMessage(), ex);
            return Result.fail("422", String.format("do settlement for order[%s] failed", settlementForm.getOrderId()));
        } finally {
            session.close();
        }

        return Result.ok();
    }

    // 2018-01-05号改动：派工单工程师的结算费可以手动修改
    public Result<Void> save2017(SettlementForm settlementForm, String siteId) {
        // dispatch_id is of no use
        boolean hasError;
        User user = UserUtils.getUser();
        String username = CrmUtils.getUserXM();
        String orderTable = tableSplitMapper.mapOrder(siteId);
        String settlementTable = tableSplitMapper.mapOrderSettlement(siteId);
        String settlementDetailTable = tableSplitMapper.mapOrderSettlementDetail(siteId);
        if (settlementTable == null || settlementDetailTable  == null) {
            throw new RuntimeException("settlement table not found");
        }

        HistoryBkOrderSettlement settlement = new HistoryBkOrderSettlement(new Record());
        String settlementId = IdGen.uuid();
        settlement.setId(settlementId);

        HistoryBkOrder order = new HistoryBkOrder(new Record());
        order.setId(settlementForm.getOrderId());

        if (!JF_TYPE_RENEW.equals(settlementForm.getMode()) && hasAlreadyC2017(settlementForm.getOrderId(), siteId)) {
            if (StringUtil.isNotBlank(settlementForm.getOrderId())) {
                Record s = Db.findFirst("select * from "  + settlementTable + " where order_id=? limit 1", settlementForm.getOrderId());
                if (s != null) {
                    Db.update("delete from " + settlementTable + " where order_id=?", settlementForm.getOrderId());
                    Db.update("delete from " + settlementDetailTable + " where settlement_id=?", s.getStr("id"));
                }
            }
        }

        BigDecimal factoryFee = MathUtils.asBigDecimal(settlementForm.getFactoryFee()); // 厂家结算费
        BigDecimal auxiliaryFee = MathUtils.asBigDecimal(settlementForm.getAccCost()); // 辅材成本
        Double empTotalFee = calcDispAndAddedEmployeCost(settlementForm); // 工程师支出
        Record rds = Db.findFirst("select a.* from " + settlementTable + " a where a.site_id=? and a.order_id=?",siteId,settlementForm.getOrderId());
        settlement.setOrderId(settlementForm.getOrderId());
        settlement.setCreateTime(new Date());
        settlement.setSettlementTime(formatDate(settlementForm.getSettlementTime()));
        settlement.setCreateName(username);
        settlement.setRemarks(settlementForm.getMemo());
        settlement.setServiceMeasures(settlementForm.getsMethod());
        settlement.setSiteId(siteId);
        settlement.setCreateBy(user.getId());
        settlement.setFittingCosts(auxiliaryFee);
        settlement.setFactoryMoney(factoryFee);
        settlement.setSumMoney(new BigDecimal(empTotalFee));
        // profits 已经不是计算出来，而是手填。
        String strProfit = settlementForm.getProfit();
        settlement.setProfits(StringUtil.isBlank(strProfit) ? new BigDecimal("0") : new BigDecimal(strProfit.trim()));
        settlement.setCostDetail(overallCostDetail(settlementForm)); // 暂时不存cost detail
        settlement.setSettlementDetail(createSettlementDetail(settlementForm));
        settlement.setPaymentAmount(MathUtils.asBigDecimal(settlementForm.getPaymentAmount()));

        String orderId = settlementForm.getOrderId();
        List<Record> orderDispEmployeList = getOrderRelatedEmployeList2017(orderId, siteId);

        if (!JF_TYPE_RENEW.equals(settlementForm.getMode())) {
            if (orderDispEmployeList == null || orderDispEmployeList.size() == 0) {
                return Result.fail("422", String.format("order[%s] has no related employee", settlementForm.getOrderId()));
            }
        }

        List<AddedSettlementItem> addedSettlementItem = settlementForm.getAddedJisuan();
        List<HistoryBkOrderSettlementDetail> details = createSettlementDetailsForDispEmps2017(orderDispEmployeList, settlementForm, siteId, username);
        List<HistoryBkOrderSettlementDetail> detailsForAddedEmps = createSettlementDetailsForAddedEmps2017(settlementForm, addedSettlementItem, siteId, username);
        details.addAll(detailsForAddedEmps);

//        StatelessSession session = sessionFactory.openStatelessSession();
//        Transaction tx = session.beginTransaction();
        if (JF_TYPE_RENEW.equals(settlementForm.getMode())) {
            // 重新结算
            Record orderRec = Db.findFirst("select id from " + settlementTable + " where order_id=? and site_id=?", orderId, siteId);
            if (orderRec != null) {
                Db.update("delete from " + settlementTable + " where order_id=? and site_id=?", orderId, siteId);
                Db.update("delete from " + settlementDetailTable + " where settlement_id=?", orderRec.getStr("id"));
            }
            // 重置工单的审核状态为未审核
            order.setReview("0");
        }
//        session.insert(settlement);
        hasError = !settlement.persist(settlementTable, "id");
        if (!hasError) {
            Date now = new Date();
            order.setStatus("5");
            OrderDispatchService.setParentStatusWithGuard2017(order2017Dao.findOrderById(order.getId(), siteId), CrmOrder2017.PSTATUS_WAIT_CALLBACK, tableSplitMapper, siteId);
            String content = String.format(JF_TYPE_RENEW.equals(settlementForm.getMode()) ? "%s重新结算" : "%s结算", username);
            if (JF_TYPE_RENEW.equals(settlementForm.getMode())) {//重新结算
                if (rds != null) {
                    double oldSumMny = rds.getBigDecimal("sum_money") != null ? Double.valueOf(rds.getBigDecimal("sum_money").toString()) : Double.valueOf("0");
                    double newSumMny = empTotalFee;
                    if (oldSumMny != newSumMny) {
                        content = content + "，原结算金额为" + oldSumMny + "元，新结算金额为" + newSumMny + "元";
                        order.setLatestProcessTime(new Date());
                        order.setLatestProcess(content);
                    }
                }
            }
            Target ta1 = new Target();
            ta1.setContent(content);
            ta1.setName(username);
            ta1.setType(Target.MESS_SETTLEMENT);
            ta1.setTime(formatDatetime(new Date()));

            Target ta = new Target();
            ta.setContent("工单完成");
            ta.setName(username);
            ta.setType(Target.COMPLETE_ORDER);
            ta.setTime(formatDatetime(new Date(now.getTime() + 1)));
            List<Target> targets = new ArrayList<>();
            targets.add(ta1);
            targets.add(ta);

            order.setProcessDetail(WebPageFunUtils.appendProcessDetails(targets, org.apache.commons.lang.StringUtils.defaultIfEmpty(order.getProcessDetail(), "")));
//            session.update(order);

            for (HistoryBkOrderSettlementDetail detail : details) {
                detail.setSettlementId(settlementId);
                if (!detail.persist(settlementDetailTable, "id")) {
                    hasError = true;
                    break;
                }
            }
        }

        if (hasError) {
            delSettlement2017(settlementId, siteId);
            return Result.fail("422", "settlement failed");
        } else {
            order.update(orderTable, "id");
        }

        return Result.ok();
    }

    private String formatDatetime(Date date) {
        return DateToStringUtils.DateToStringParam1(date);
    }

    private String createSettlementDetail(SettlementForm settlementForm) {
        List<String> jiesuanItems = settlementForm.getJiesuanItems();
        List<Double> jiesuanItemVals = settlementForm.getJiesuanItemVals();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < jiesuanItems.size(); i++) {
            String label = jiesuanItems.get(i);
            label = label.replaceAll("[:：]\\s*$", "");
            sb.append(label).append("###").append(jiesuanItemVals.get(i)).append(";");
        }
        return sb.toString();
    }

    private String overallCostDetail(SettlementForm settlementForm) {
        return "";
    }

    private Double safeDoubleConv(String val) {
        return StringUtils.isBlank(val) ? 0 : MathUtils.convertToDouble(StringUtils.trim(val));
    }

    private List<OrderSettlementDetail> createSettlementDetailsForDispEmps(List<Record> orderDispEmployeList2, SettlementForm settlementForm, String siteId, String name) {
        List<String> dispEmpIds = settlementForm.getDispEmpIds();
        List<String> dispEmpVals = settlementForm.getDispEmpVals();
        Map<String, Double> empFeeMap = new HashMap<>();
        for (int i = 0; i < dispEmpIds.size(); i++) {
            empFeeMap.put(dispEmpIds.get(i), safeDoubleConv(dispEmpVals.get(i)));
        }

        List<OrderSettlementDetail> ret = new ArrayList<>();
//        double totalCost = calcDispEmployeCost(settlementForm);
//        double allRatio = calcAllRatio(orderDispEmployeList);
        List<Employe> orderDispEmployeList = employeDao.getEmployes(dispEmpIds);

        for (Employe r : orderDispEmployeList) {
            OrderSettlementDetail detail = new OrderSettlementDetail();
            BigDecimal ratio = r.getRatio();
            detail.setSiteId(siteId);
            detail.setServiceMeasures(settlementForm.getsMethod());
            detail.setCreateName(name);
            detail.setEmployeId(r.getId());
            detail.setEmployeName(r.getName());
            detail.setCreateTime(new Date());
            detail.setOrderId(settlementForm.getOrderId());
//            detail.setSumMoney(calcEmpCost(ratio, allRatio, totalCost));
            detail.setSumMoney(empFeeMap.get(r.getId()));
            detail.setRemarks(settlementForm.getMemo());
            detail.setType("0"); // 派工结算
            detail.setRatio(ratio);
            detail.setSettlementTime(formatDate(settlementForm.getSettlementTime()));
            // 由于每个工程师的计算费是可以支持手动修改，于是工程师每个结算项已经无法计算
//            detail.setCostDetail(createDispEmpCostDetailWithRatio(settlementForm, allRatio, ratio.doubleValue()));
            ret.add(detail);
        }
        return ret;
    }

    private List<HistoryBkOrderSettlementDetail> createSettlementDetailsForDispEmps2017(List<Record> orderDispEmployeList2, SettlementForm settlementForm, String siteId, String name) {
        List<String> dispEmpIds = settlementForm.getDispEmpIds();
        List<String> dispEmpVals = settlementForm.getDispEmpVals();
        Map<String, BigDecimal> empFeeMap = new HashMap<>();
        for (int i = 0; i < dispEmpIds.size(); i++) {
            empFeeMap.put(dispEmpIds.get(i), MathUtils.asBigDecimal(dispEmpVals.get(i)));
        }

        List<HistoryBkOrderSettlementDetail> ret = new ArrayList<>();
//        double totalCost = calcDispEmployeCost(settlementForm);
//        double allRatio = calcAllRatio(orderDispEmployeList);
        List<Employe> orderDispEmployeList = employeDao.getEmployes(dispEmpIds);

        for (Employe r : orderDispEmployeList) {
            HistoryBkOrderSettlementDetail detail = new HistoryBkOrderSettlementDetail(new Record());
            detail.setId(IdGen.uuid());
            BigDecimal ratio = r.getRatio();
            detail.setSiteId(siteId);
            detail.setServiceMeasures(settlementForm.getsMethod());
            detail.setCreateName(name);
            detail.setEmployeId(r.getId());
            detail.setEmployeName(r.getName());
            detail.setCreateTime(new Date());
            detail.setOrderId(settlementForm.getOrderId());
//            detail.setSumMoney(calcEmpCost(ratio, allRatio, totalCost));
            detail.setSumMoney(empFeeMap.get(r.getId()));
            detail.setRemarks(settlementForm.getMemo());
            detail.setType("0"); // 派工结算
            detail.setRatio(ratio);
            detail.setSettlementTime(formatDate(settlementForm.getSettlementTime()));
            // 由于每个工程师的计算费是可以支持手动修改，于是工程师每个结算项已经无法计算
//            detail.setCostDetail(createDispEmpCostDetailWithRatio(settlementForm, allRatio, ratio.doubleValue()));
            ret.add(detail);
        }
        return ret;
    }

    private double calcEmpCost(BigDecimal ratio, double allRatio, double totalCost) {
        return totalCost * 1.0 / allRatio * ratio.doubleValue();
    }

    public static double calcAllRatio(List<Record> orderDispEmployeList) {
        BigDecimal ret = new BigDecimal(0.00d);
        for (Record r : orderDispEmployeList) {
            BigDecimal ratio = r.getBigDecimal("ratio");
            if (ret == null) {
                logger.error(String.format("ret null detected,r=%s", r.getColumns()));
            }
            if (ratio == null) {
                logger.error(String.format("ratio null detected,r=%s", r.getColumns()));
            }
            ret = ret.add(ratio);
        }
        ret = ret.setScale(2, RoundingMode.HALF_UP);
        double v = ret.doubleValue();
        if (v <= 0) {
            throw new RuntimeException("invalid ratio found");
        }
        return v;
    }

    private List<OrderSettlementDetail> createSettlementDetailsForAddedEmps(SettlementForm settlementForm, List<AddedSettlementItem> items, String siteId, String name) {
        List<OrderSettlementDetail> ret = new ArrayList<>();
        for (AddedSettlementItem r : items) {
            OrderSettlementDetail detail = new OrderSettlementDetail();
            detail.setSiteId(siteId);
            detail.setServiceMeasures(convItem(r.getItem()));
            detail.setCreateName(name);
            detail.setEmployeId(r.getEmpId());
            detail.setEmployeName(r.getEmpName());
            detail.setCreateTime(new Date());
            detail.setOrderId(settlementForm.getOrderId());
            detail.setSumMoney(safeDoubleConv(r.getAmount()));
            detail.setRemarks(r.getRemark());
            detail.setType("2"); // 添加结算
            detail.setSettlementTime(formatDate(settlementForm.getSettlementTime()));
            detail.setCostDetail(createAddedEmpCostDetail(settlementForm, r));
            ret.add(detail);
        }
        return ret;
    }

    private List<HistoryBkOrderSettlementDetail> createSettlementDetailsForAddedEmps2017(SettlementForm settlementForm, List<AddedSettlementItem> items, String siteId, String name) {
        List<HistoryBkOrderSettlementDetail> ret = new ArrayList<>();
        for (AddedSettlementItem r : items) {
            HistoryBkOrderSettlementDetail detail = new HistoryBkOrderSettlementDetail(new Record());
            detail.setId(IdGen.uuid());
            detail.setSiteId(siteId);
            detail.setServiceMeasures(convItem(r.getItem()));
            detail.setCreateName(name);
            detail.setEmployeId(r.getEmpId());
            detail.setEmployeName(r.getEmpName());
            detail.setCreateTime(new Date());
            detail.setOrderId(settlementForm.getOrderId());
            detail.setSumMoney(MathUtils.asBigDecimal(r.getAmount()));
            detail.setRemarks(r.getRemark());
            detail.setType("2"); // 添加结算
            detail.setSettlementTime(formatDate(settlementForm.getSettlementTime()));
            detail.setCostDetail(createAddedEmpCostDetail(settlementForm, r));
            ret.add(detail);
        }
        return ret;
    }

    private String convItem(String item) {
        if (ADDED_TYPE_KK.equals(item)) {
            return "扣款";
        } else if (ADDED_TYPE_DRZF.equals(item)) {
            return TYPE_JRZF_STR;
        } else if (ADDED_TYPE_XZJS.equals(item)) {
            return "新增结算费";
        }
        throw new RuntimeException("invalid item: " + item);
    }

    // 均分
    @Deprecated
    private String createDispEmpCostDetail(SettlementForm settlementForm, int dispEmpCount) {
        if (dispEmpCount > 0) {
            StringBuilder sb = new StringBuilder();
            List<String> jiesuanItems = settlementForm.getJiesuanItems();
            List<Double> jiesuanItemVals = settlementForm.getJiesuanItemVals();
            for (int i = 0; i < jiesuanItems.size(); i++) {
                Double val = MathUtils.getDouble(jiesuanItemVals.get(i) / dispEmpCount, 2);
                String label = jiesuanItems.get(i).replaceAll("[:：]\\s*$", "");
                sb.append(label).append(":").append(val).append(",");
            }
            return sb.toString();
        }
        return "";
    }

    private String createDispEmpCostDetailWithRatio(SettlementForm settlementForm, double allRatio, double ratio) {
        if (allRatio > 0) {
            StringBuilder sb = new StringBuilder();
            List<String> jiesuanItems = settlementForm.getJiesuanItems();
            List<Double> jiesuanItemVals = settlementForm.getJiesuanItemVals();
            for (int i = 0; i < jiesuanItems.size(); i++) {
                Double val = MathUtils.getDouble(jiesuanItemVals.get(i) * 1.00d / allRatio * ratio, 2);
                String label = jiesuanItems.get(i).replaceAll("[:：]\\s*$", "");
                sb.append(label).append(":").append(val).append(",");
            }
            return sb.toString();
        }
        return "";
    }

    private String createAddedEmpCostDetail(SettlementForm settlementForm, AddedSettlementItem item) {
        String itemVal = item.getItem();
        String itemLabel = convItem(itemVal);
        // 真有必要存吗
        return itemLabel + ":" + item.getAmount();
    }

    private Double calcDispEmployeCost(SettlementForm settlementForm) {
        List<String> itemVals = settlementForm.getDispEmpVals();
        double total = 0;
        if (itemVals != null) {
            for (String val : itemVals) {
                total += safeDoubleConv(val);
            }
        }
        return total;
    }

    private Double calcDispAndAddedEmployeCost(SettlementForm settlementForm) {
        List<AddedSettlementItem> addedSettlementItem = settlementForm.getAddedJisuan();
        double total = calcDispEmployeCost(settlementForm);
        if (addedSettlementItem != null) {
            for (AddedSettlementItem item : addedSettlementItem) {
                if (!ADDED_TYPE_DRZF.equals(item.getItem())) {
                    String amount = item.getAmount();
                    if (StringUtils.isNotBlank(amount)) {
                        total += safeDoubleConv(amount);
                    }
                }
            }
        }
        return total;
    }

    public OrderSettlement getOrderSettlementByOrderId(String orderId) {
        Query sqlQuery = settlementDao.getSession().createQuery("from OrderSettlement where orderId=:oid");
        sqlQuery.setParameter("oid", orderId);
        return (OrderSettlement) sqlQuery.uniqueResult();
    }

    @SuppressWarnings("unchecked")
    public List<OrderSettlementDetail> getSettlementDetailItems(String settlementId) {
        Query sqlQuery = settlementDao.getSession().createQuery("from OrderSettlementDetail where settlementId=:sid");
        sqlQuery.setParameter("sid", settlementId);
        return sqlQuery.list();
    }

    @SuppressWarnings("unchecked")
    public List<Record> getSettlementDetailItems2017(String settlementId) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String table = tableSplitMapper.mapOrderSettlementDetail(siteId);
        if (table == null) {
            return new ArrayList<>();
        }
        return Db.find("select * from " + table + " where settlement_id=?", settlementId);
    }

    public OrderSettlementVo getSettlementDetails(String orderId) {
        Order order = orderService.get(orderId);
        OrderSettlementVo vo = new OrderSettlementVo();
        vo.setOrder(order);
        OrderSettlement settlement = getOrderSettlementByOrderId(orderId);
        if (settlement == null) {
            return null;
        }

        vo.setOrderSettlement(settlement);
        String settlementDetail = settlement.getSettlementDetail();//辅材费###20;延保费###30
        List<EntryItem<String, String>> jiesuanItems = new ArrayList<>();
        if (StringUtils.isNotBlank(settlementDetail)) {
            String[] fs = settlementDetail.split(";");
            for (String item : fs) {
                String[] split = item.split("###");
                EntryItem<String, String> entryItem = new EntryItem<>();
                entryItem.setKey(split[0]);
                entryItem.setValue(split[1]);
                jiesuanItems.add(entryItem);
            }
        }
        vo.setJiesuanItems(jiesuanItems); // 结算方案对应的结算项目的值

        List<OrderSettlementDetail> detailItems = getSettlementDetailItems(settlement.getId());
        List<OrderSettlementDetail> addedEmpSettlementItems = new ArrayList<>();
        List<OrderSettlementDetail> dispEmpSettlementItems = new ArrayList<>();

        Map<String, AddedSettlementItem> mergedAddedItems = new HashMap<>();
        // 分离派工单工程师和额外添加的工程师结算详情
        for (OrderSettlementDetail detail : detailItems) {
            if ("2".equals(detail.getType())) { // 添加结算
                addedEmpSettlementItems.add(detail);
            } else if ("0".equals(detail.getType())) { // 派工工程师结算
                dispEmpSettlementItems.add(detail);
            }
        }

        // 对于额外添加的工程师结算项目（将按照工程师id合并添加工程师傅的总费用，页面需要展示合并后的总费用）
        for (OrderSettlementDetail detail : addedEmpSettlementItems) {
            if (!TYPE_JRZF_STR.equals(detail.getServiceMeasures())) {
                String empId = detail.getEmployeId();
                AddedSettlementItem item = mergedAddedItems.get(empId);
                if (item == null) {
                    item = new AddedSettlementItem();
                    item.setEmpId(empId);
                    item.setEmpName(detail.getEmployeName());
                    item.setCost(detail.getSumMoney());
                    mergedAddedItems.put(empId, item);
                } else {
                    item.setCost(item.getCost() + detail.getSumMoney());
                }
            }
        }

        vo.setDispEmpSettlementDetail(dispEmpSettlementItems);
        vo.setAddedEmpSettlementDetail(addedEmpSettlementItems);
        Collection<AddedSettlementItem> values = mergedAddedItems.values();
        List<AddedSettlementItem> items = new ArrayList<>();
        items.addAll(values);
        vo.setAddedJisuan(items);
        return vo;
    }

    public OrderSettlement2017Vo getSettlementDetails2017(String orderId, String siteId) {
        Record order = order2017Dao.findOrderById(orderId, siteId);
        OrderSettlement2017Vo vo = new OrderSettlement2017Vo();
        vo.setOrder(order);
        Record settlement = getOrderSettlement2017(orderId, siteId);
        if (settlement == null) {
            return null;
        }

        vo.setOrderSettlement(settlement);
        String settlementDetail = settlement.getStr("settlement_detail");
        List<EntryItem<String, String>> jiesuanItems = new ArrayList<>();
        if (StringUtils.isNotBlank(settlementDetail)) {
            String[] fs = settlementDetail.split(";");
            for (String item : fs) {
                String[] split = item.split("###");
                EntryItem<String, String> entryItem = new EntryItem<>();
                entryItem.setKey(split[0]);
                entryItem.setValue(split[1]);
                jiesuanItems.add(entryItem);
            }
        }
        vo.setJiesuanItems(jiesuanItems); // 结算方案对应的结算项目的值

        List<Record> detailItems = getSettlementDetailItems2017(settlement.getStr("id"));
        List<Record> addedEmpSettlementItems = new ArrayList<>();
        List<Record> dispEmpSettlementItems = new ArrayList<>();

        Map<String, AddedSettlementItem> mergedAddedItems = new HashMap<>();
        // 分离派工单工程师和额外添加的工程师结算详情
        for (Record detail : detailItems) {
            if ("2".equals(detail.getStr("type"))) { // 添加结算
                addedEmpSettlementItems.add(detail);
            } else if ("0".equals(detail.getStr("type"))) { // 派工工程师结算
                dispEmpSettlementItems.add(detail);
            }
        }

        // 对于额外添加的工程师结算项目（将按照工程师id合并添加工程师傅的总费用，页面需要展示合并后的总费用）
        for (Record detail : addedEmpSettlementItems) {
            if (!TYPE_JRZF_STR.equals(detail.getStr("service_measures"))) {
                String empId = detail.getStr("employe_id");
                AddedSettlementItem item = mergedAddedItems.get(empId);
                if (item == null) {
                    item = new AddedSettlementItem();
                    item.setEmpId(empId);
                    item.setEmpName(detail.getStr("employe_name"));
                    item.setCost(MathUtils.getDouble(detail.getBigDecimal("sum_money"), 2));
                    mergedAddedItems.put(empId, item);
                } else {
                    item.setCost(item.getCost() + MathUtils.getDouble(detail.getBigDecimal("sum_money"), 2));
                }
            }
        }

        vo.setDispEmpSettlementDetail(dispEmpSettlementItems);
        vo.setAddedEmpSettlementDetail(addedEmpSettlementItems);
        Collection<AddedSettlementItem> values = mergedAddedItems.values();
        List<AddedSettlementItem> items = new ArrayList<>();
        items.addAll(values);
        vo.setAddedJisuan(items);
        return vo;
    }

    @Transactional
    public Result<Void> appendNewSettlementItem(AppendedSettlementItem item) {
        String settlementId = item.getSettlementId();
        Session session = settlementDao.getSession();
        Double amount = item.getAmount();
        String opSumMoney = amount >= 0 ? "+" : "-";
        String opProfits = amount >= 0 ? "-" : "+";

        if (StringUtil.isNotBlank(settlementId)) {
            if (!TYPE_JRZF_STR.equals(item.getItem())) { // 当日支付不计算到工程师结算总费用和利润计算中
                SqlKit kit = new SqlKit()
                        .append("update crm_order_settlement")
                        .append("set `sum_money`=`sum_money`" + opSumMoney + Math.abs(amount))
                        .append(",`profits`=`profits`" + opProfits + Math.abs(amount))
                        .append("where id=:id");
                SQLQuery sqlQuery = session.createSQLQuery(kit.toString());
                sqlQuery.setParameter("id", item.getSettlementId());
                sqlQuery.executeUpdate();
            } else {
                SqlKit kit = new SqlKit()
                        .append("update crm_order_settlement")
                        .append("set `payment_amount`=`payment_amount`+" + amount)
                        .append("where id=:id");
                SQLQuery sqlQuery = session.createSQLQuery(kit.toString());
                sqlQuery.setParameter("id", item.getSettlementId());
                sqlQuery.executeUpdate();
            }

            OrderSettlementDetail detail = new OrderSettlementDetail();
            detail.setRemarks(item.getRemark());
            detail.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
            detail.setEmployeId(item.getEmpId());
            detail.setEmployeName(item.getEmpName());
            detail.setSettlementId(item.getSettlementId());
            detail.setServiceMeasures(item.getItem());
            detail.setSumMoney(amount);
            detail.setOrderId(item.getOrderId());
            detail.setSettlementTime(formatDate(item.getSettlementDate()));
            detail.setCreateName(CrmUtils.getUserXM());
            detail.setCreateTime(new Date());
            detail.setType("2");
            detail.setCostDetail(""); // ? !--
            session.save(detail);
            return Result.ok();
        }

        return Result.fail("settlement id required");
    }

    private Date formatDate(String date) {
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(date);
        } catch (ParseException e) {
            throw new RuntimeException("invalid date");
        }
    }

    private Map<String, List<Record>> getBatchSettlementRelEmps(String[] orderIds) {
        Map<String, List<Record>> ret = new HashMap<>(); // orderId -> emp records
        SqlKit kit = new SqlKit()
                .append("SELECT r.*,(select ratio from crm_employe where id=r.emp_id) as ratio FROM")
                .append("(SELECT * FROM crm_order WHERE id IN (" + StringUtil.joinInSql(orderIds) + ")) AS t")
                .append("INNER JOIN crm_order_dispatch AS d")
                .append("ON d.order_id=t.id AND d.`status`='5'")
                .append("INNER JOIN `crm_order_dispatch_employe_rel` AS r")
                .append("ON r.`dispatch_id`=d.`id`");

        List<Record> emps = Db.find(kit.toString());
        for (Record r : emps) {
            String orderId = r.getStr("order_id");
            List<Record> records = ret.get(orderId);
            if (records == null) {
                records = new ArrayList<>();
                ret.put(orderId, records);
            }
            records.add(r);
        }

        return ret;
    }

    private Map<String, List<Record>> getBatchSettlementRelEmps2017(String[] orderIds, String siteId) {
        String orderTable = tableSplitMapper.mapOrder(siteId);
        String relTable = tableSplitMapper.mapOrderDispatchEmployeRel(siteId);
        String dispatchTable = tableSplitMapper.mapOrderDispatch(siteId);
        if (orderTable == null) {
            throw new RuntimeException("order map table required, site.id=" + siteId);
        }

        Map<String, List<Record>> ret = new HashMap<>(); // orderId -> emp records
        SqlKit kit = new SqlKit()
                .append("SELECT r.*,(select ratio from crm_employe where id=r.emp_id) as ratio FROM")
                .append("(SELECT * FROM " + orderTable + " WHERE id IN (" + StringUtil.joinInSql(orderIds) + ")) AS t")
                .append("INNER JOIN " + dispatchTable + " AS d")
                .append("ON d.order_id=t.id AND d.`status`='5'")
                .append("INNER JOIN " + relTable + " AS r")
                .append("ON r.`dispatch_id`=d.`id`");

        List<Record> emps = Db.find(kit.toString());
        for (Record r : emps) {
            String orderId = r.getStr("order_id");
            List<Record> records = ret.get(orderId);
            if (records == null) {
                records = new ArrayList<>();
                ret.put(orderId, records);
            }
            records.add(r);
        }

        return ret;
    }

    /**
     * 获取每个工单对应的配件成本。
     */
    private Map<String, BigDecimal[]> getOrderFittingCost(String[] orderIds, String siteId) {
        SqlKit kit1 = new SqlKit()
                .append("select number from crm_order as o")
                .append("where o.id in(" + StringUtil.joinInSql(orderIds) + ")");
        List<Record> orderNumberRds = Db.find(kit1.toString());
        List<String> orderNumbers = new ArrayList<>();
        for (Record rd : orderNumberRds) {
            orderNumbers.add(rd.getStr("number"));
        }

        Map<String, BigDecimal[]> ret = new HashMap<>(); // orderId -> fitting price.
        SqlKit kit = new SqlKit()
                .append("SELECT COALESCE(SUM(u.`used_num`*f.`site_price`), 0) as m, COALESCE(SUM(u.`used_num`*f.`employe_price`), 0) as n, u.order_id FROM `crm_site_fitting_used_record` AS u")
                .append("INNER JOIN crm_site_fitting AS f")
                .append("ON u.`fitting_id`=f.`id`")
                .append("WHERE u.`type`='1'")
                .append("AND f.`site_id`=?")
                .append("AND u.`collection_flag`='1'")
                .append("AND u.`site_id`=?")
                .append("AND u.`order_number` IN (" + CrmUtils.joinInSql(orderNumbers) + ")")
                .append("GROUP BY u.`order_number`");

        List<Record> records = Db.find(kit.toString(), siteId, siteId);
        for (Record r : records) {
            ret.put(r.getStr("order_id"), new BigDecimal[] {r.getBigDecimal("m"), r.getBigDecimal("n") });
        }
        return ret;
    }

    /**
     * 获取每个工单对应的配件成本。
     */
    private Map<String, BigDecimal[]> getOrderFittingCost2017(String[] orderIds, String siteId) {
        String orderTable = tableSplitMapper.mapOrder(siteId);
        if (orderTable == null) {
            throw new RuntimeException("order map table required, site.id=" + siteId);
        }

        SqlKit kit1 = new SqlKit()
                .append("select number from " + orderTable + " as o")
                .append("where o.id in(" + StringUtil.joinInSql(orderIds) + ")");
        List<Record> orderNumberRds = Db.find(kit1.toString());
        List<String> orderNumbers = new ArrayList<>();
        for (Record rd : orderNumberRds) {
            orderNumbers.add(rd.getStr("number"));
        }

        Map<String, BigDecimal[]> ret = new HashMap<>(); // orderId -> fitting price.
        SqlKit kit = new SqlKit()
                .append("SELECT COALESCE(SUM(u.`used_num`*f.`site_price`), 0) as m, COALESCE(SUM(u.`used_num`*f.`employe_price`), 0) as n, u.order_id FROM `crm_site_fitting_used_record` AS u")
                .append("INNER JOIN crm_site_fitting AS f")
                .append("ON u.`fitting_id`=f.`id`")
                .append("WHERE u.`type`='1'")
                .append("AND f.`site_id`=?")
                .append("AND u.`collection_flag`='1'")
                .append("AND u.`site_id`=?")
                .append("AND u.`order_number` IN (" + CrmUtils.joinInSql(orderNumbers) + ")")
                .append("GROUP BY u.`order_number`");

        List<Record> records = Db.find(kit.toString(), siteId, siteId);
        for (Record r : records) {
            ret.put(r.getStr("order_id"), new BigDecimal[] {r.getBigDecimal("m"), r.getBigDecimal("n") });
        }
        return ret;
    }

    private OrderSettlement createSettlementWhenBatch(StatelessSession session, BatchSettlementForm form, List<Record> relEmps, BigDecimal[] fittingPrice, Order order, String siteId, String uname) {
        if (relEmps == null) {
            logger.error(String.format("skip settlement for order: %s for rel emps is null", order.getId()));
            return null;
        }

        OrderSettlement s = new OrderSettlement();
        User user = UserUtils.getUser();
        double fittingCost = fittingPrice == null ? 0d : fittingPrice[0].doubleValue();
        Tuple<Double, String> dispEmpCostAndItem = dispEmpCostAndSettlementDetails(form, order, fittingPrice);
        double factoryFee = safeDoubleConv(form.getFactoryFee());
        double orderFee = order.getAuxiliaryCost() + order.getServeCost() + order.getWarrantyCost();

        // 已经约定，不存disp_id
        s.setOrderId(order.getId());
        s.setCreateTime(new Date());
        s.setCreateBy(user.getId());
        s.setCreateName(uname);
        s.setSumMoney(dispEmpCostAndItem.getVal1());
        s.setRemarks(form.getMemo());
        s.setServiceMeasures(form.getsMethod());
        s.setPaymentAmount(0d);
        s.setSiteId(siteId);
        s.setFittingCosts(fittingCost);
        s.setFactoryMoney(factoryFee);
        s.setProfits(factoryFee + orderFee - fittingCost - dispEmpCostAndItem.getVal1());
        s.setSettlementDetail(dispEmpCostAndItem.getVal2());
        s.setSettlementTime(formatDate(form.getSettlementDate()));
        session.insert(s);

        finishOrder(order, uname); // 完成工单并创建过程。
        session.update(order);

        double allRatio = calcAllRatio(relEmps);
        for (Record r : relEmps) {
            BigDecimal ratio = r.getBigDecimal("ratio");
            OrderSettlementDetail sd = new OrderSettlementDetail();
            sd.setSettlementId(s.getId());
            sd.setOrderId(order.getId());
            sd.setCreateTime(new Date());
            sd.setEmployeId(r.getStr("emp_id"));
            sd.setEmployeName(r.getStr("emp_name"));
            sd.setCreateName(uname);
//            sd.setSumMoney(dispEmpCostAndItem.getVal1() / relEmps.size());
            sd.setSumMoney(calcEmpCost(ratio, allRatio, dispEmpCostAndItem.getVal1()));
            sd.setRemarks(form.getMemo());
            sd.setRatio(ratio);
            sd.setServiceMeasures(form.getsMethod());
            sd.setSiteId(siteId);
            sd.setSettlementTime(formatDate(form.getSettlementDate()));
            sd.setType("0");
            sd.setCostDetail(createDispEmpCostDetailWhenBatchWithRatio(form.getsItems(), allRatio, ratio.doubleValue()));
            session.insert(sd);
        }
        return s;
    }

    private HistoryBkOrderSettlement createSettlementWhenBatch2017(BatchSettlementForm form, List<Record> relEmps, BigDecimal[] fittingPrice, HistoryBkOrder order, String siteId, String uname) {
        if (relEmps == null) {
            logger.error(String.format("skip settlement for order: %s for rel emps is null", order.getId()));
            return null;
        }

        boolean hasError;
        String orderTable = tableSplitMapper.mapOrder(siteId);
        String settlementTable = tableSplitMapper.mapOrderSettlement(siteId);
        String settlementDetailTable = tableSplitMapper.mapOrderSettlementDetail(siteId);
        if  (orderTable == null) {
            logger.error("skip settlement for 2017, for order map table required,site.id=" + siteId);
            return null;
        }

        HistoryBkOrderSettlement s = new HistoryBkOrderSettlement(new Record());
        String settlementId = IdGen.uuid();
        s.setId(settlementId);
        User user = UserUtils.getUser();
        BigDecimal fittingCost = fittingPrice == null ? new BigDecimal("0") : fittingPrice[0];
        Tuple<Double, String> dispEmpCostAndItem = dispEmpCostAndSettlementDetails2017(form, order, fittingPrice);
        BigDecimal factoryFee = MathUtils.asBigDecimal(form.getFactoryFee());
        BigDecimal orderFee = MathUtils.sumBigDecimal(order.getAuxiliaryCost(), order.getServeCost(), order.getWarrantyCost());

        // 已经约定，不存disp_id
        s.setOrderId(order.getId());
        s.setCreateTime(new Date());
        s.setCreateBy(user.getId());
        s.setCreateName(uname);
        s.setSumMoney(new BigDecimal(dispEmpCostAndItem.getVal1()));
        s.setRemarks(form.getMemo());
        s.setServiceMeasures(form.getsMethod());
        s.setPaymentAmount(new BigDecimal("0"));
        s.setSiteId(siteId);
        s.setFittingCosts(fittingCost);
        s.setFactoryMoney(factoryFee);
        s.setProfits(factoryFee.add(orderFee).subtract(fittingCost).subtract(new BigDecimal(dispEmpCostAndItem.getVal1())));
        s.setSettlementDetail(dispEmpCostAndItem.getVal2());
        s.setSettlementTime(formatDate(form.getSettlementDate()));
        hasError = !s.persist(settlementTable, "id");

//        finishOrder2017(order, uname); // 完成工单并创建过程。
//        session.update(order);

        if (!hasError) {
            double allRatio = calcAllRatio(relEmps);
            for (Record r : relEmps) {
                BigDecimal ratio = r.getBigDecimal("ratio");
                HistoryBkOrderSettlementDetail sd = new HistoryBkOrderSettlementDetail(new Record());
                sd.setSettlementId(settlementId);
                sd.setOrderId(order.getId());
                sd.setCreateTime(new Date());
                sd.setEmployeId(r.getStr("emp_id"));
                sd.setEmployeName(r.getStr("emp_name"));
                sd.setCreateName(uname);
                sd.setSumMoney(new BigDecimal(calcEmpCost(ratio, allRatio, dispEmpCostAndItem.getVal1())));
                sd.setRemarks(form.getMemo());
                sd.setRatio(ratio);
                sd.setServiceMeasures(form.getsMethod());
                sd.setSiteId(siteId);
                sd.setSettlementTime(formatDate(form.getSettlementDate()));
                sd.setType("0");
                sd.setCostDetail(createDispEmpCostDetailWhenBatchWithRatio(form.getsItems(), allRatio, ratio.doubleValue()));
                sd.persist(settlementDetailTable, "id");
            }
        }

        if (hasError) {
            delSettlement2017(settlementId, siteId);
            logger.error("batch settlement failed, order.id="+ order.getId());
        } else {
            finishOrder2017(order, uname, siteId); // 完成工单并创建过程。
        }

        return s;
    }

    // 批量结算均分
    @Deprecated
    private String createDispEmpCostDetailWhenBatch(List<BatchSettlementItem> batchSettlementItems, int dispEmpCount) {
        if (dispEmpCount > 0) {
            StringBuilder sb = new StringBuilder();
            for (BatchSettlementItem item : batchSettlementItems) {
                String label = item.getLabel().replaceAll("[:：]\\s*$", "");
                sb.append(label).append(":").append(MathUtils.getDouble(item.getCalculatedValue() * 1.0 / dispEmpCount, 2));
            }
            return sb.toString();
        }
        return "";
    }

    private String createDispEmpCostDetailWhenBatchWithRatio(List<BatchSettlementItem> batchSettlementItems, double allRatio, double ratio) {
        if (allRatio > 0) {
            StringBuilder sb = new StringBuilder();
            for (BatchSettlementItem item : batchSettlementItems) {
                String label = item.getLabel().replaceAll("[:：]\\s*$", "");
                sb.append(label).append(":").append(MathUtils.getDouble(item.getCalculatedValue() * 1.0 / allRatio * ratio, 2));
            }
            return sb.toString();
        }
        return "";
    }

    private void finishOrder(Order order, String uname) {
        Date now = new Date();
        order.setStatus("5");
        if(StringUtils.isNotBlank(order.getParentSiteId())) {
			order.setParentStatus("5");
		}
       // OrderDispatchService.setParentStatusWithGuard(order, Order.PSTATUS_WAIT_CALLBACK);
        Target ta1 = new Target();
        ta1.setContent(String.format("%s批量结算", uname));
        ta1.setName(uname);
        ta1.setType(Target.MESS_SETTLEMENT);
        ta1.setTime(formatDatetime(now));

        Target ta = new Target();
        ta.setContent("工单完成");
        ta.setName(uname);
        ta.setType(Target.COMPLETE_ORDER);
        ta.setTime(formatDatetime(new Date(now.getTime() + 1)));
        List<Target> targets = new ArrayList<>();
        targets.add(ta1);
        targets.add(ta);
        order.setProcessDetail(WebPageFunUtils.appendProcessDetails(targets, org.apache.commons.lang.StringUtils.defaultIfEmpty(order.getProcessDetail(), "")));
    }

    private void finishOrder2017(HistoryBkOrder order, String uname, String siteId) {
        HistoryBkOrder o = new HistoryBkOrder(new Record());
        o.setId(order.getId());
        Date now = new Date();
        o.setStatus("5");
        OrderDispatchService.setParentStatusWithGuard2017(order.getRecord(), CrmOrder2017.PSTATUS_WAIT_CALLBACK,  tableSplitMapper, siteId);
        Target ta1 = new Target();
        ta1.setContent(String.format("%s批量结算", uname));
        ta1.setName(uname);
        ta1.setType(Target.MESS_SETTLEMENT);
        ta1.setTime(formatDatetime(now));

        Target ta = new Target();
        ta.setContent("工单完成");
        ta.setName(uname);
        ta.setType(Target.COMPLETE_ORDER);
        ta.setTime(formatDatetime(new Date(now.getTime() + 1)));
        List<Target> targets = new ArrayList<>();
        targets.add(ta1);
        targets.add(ta);
        o.setProcessDetail(WebPageFunUtils.appendProcessDetails(targets, org.apache.commons.lang.StringUtils.defaultIfEmpty(order.getProcessDetail(), "")));
        o.update(tableSplitMapper.mapOrder(siteId), "id");
    }

    private Tuple<Double, String> dispEmpCostAndSettlementDetails(BatchSettlementForm form, Order order, BigDecimal[] orderFittingCost) {
        if (orderFittingCost == null) {
            orderFittingCost = new BigDecimal[]{new BigDecimal("0"), new BigDecimal("0")};
        }

        List<BatchSettlementItem> batchSettlementItems = form.getsItems();
        double serveCost = order.getServeCost();
        double accCost = order.getAuxiliaryCost(); // 辅材收费
        double warrantyCost = order.getWarrantyCost();
        double sum = 0d;
        StringBuilder settlementDetail = new StringBuilder();
        for (BatchSettlementItem item : batchSettlementItems) {
            String label = item.getLabel();
            label = label.replaceAll("[:：]\\s*$", "");
            if (item.isP()) { // 表示比例
                double v;
                if (BASE_TYPE_SERVE.equals(item.getType())) {
                    v = safeDoubleConv(item.getValue()) / 100.0 * serveCost;
                } else if (BASE_TYPE_ACC.equals(item.getType())) {
                    v = safeDoubleConv(item.getValue()) / 100.0 * accCost;
                } else if (BASE_TYPE_YAN_BAO.equals(item.getType())) {
                    v = safeDoubleConv(item.getValue()) / 100.0 * warrantyCost;
                } else if (BASE_TYPE_FUCAI_PROFITS.equals(item.getType())) {
                    double based = accCost - orderFittingCost[0].doubleValue();
                    v = safeDoubleConv(item.getValue()) / 100.0 * based;
                } else if (BASE_TYPE_EMP_FUCAI_PROFITS.equals(item.getType())) {
                    double based = accCost - orderFittingCost[1].doubleValue();
                    v = safeDoubleConv(item.getValue()) / 100.0 * based;
                } else if (BASE_TYPE_CJJSF.equals(item.getType())) {
                    double based = safeDoubleConv(form.getFactoryFee());
                    v = safeDoubleConv(item.getValue()) / 100.0 * based;
                } else {
                    throw new RuntimeException("illegal base type:" + item.getType());
                }
                v = BigDecimal.valueOf(v).setScale(2, RoundingMode.HALF_UP).doubleValue();
                sum += v;
                settlementDetail.append(label).append("###").append(v).append(";");
                item.setCalculatedValue(v); // 副作用
            } else {
                sum += safeDoubleConv(item.getValue());
                settlementDetail.append(label).append("###").append(safeDoubleConv(item.getValue())).append(";");
                item.setCalculatedValue(safeDoubleConv(item.getValue())); // 副作用
            }
        }

        return new Tuple<>(sum, settlementDetail.toString());
    }

    private Tuple<Double, String> dispEmpCostAndSettlementDetails2017(BatchSettlementForm form, HistoryBkOrder order, BigDecimal[] orderFittingCost) {
        List<BatchSettlementItem> batchSettlementItems = form.getsItems();
        double serveCost = MathUtils.getDouble(order.getServeCost(), 2);
        double accCost = MathUtils.getDouble(order.getAuxiliaryCost()); // 辅材收费
        double warrantyCost = MathUtils.getDouble(order.getWarrantyCost());
        double sum = 0d;
        StringBuilder settlementDetail = new StringBuilder();
        for (BatchSettlementItem item : batchSettlementItems) {
            String label = item.getLabel();
            label = label.replaceAll("[:：]\\s*$", "");
            if (item.isP()) { // 表示比例
                double v;
                if (BASE_TYPE_SERVE.equals(item.getType())) {
                    v = safeDoubleConv(item.getValue()) / 100.0 * serveCost;
                } else if (BASE_TYPE_ACC.equals(item.getType())) {
                    v = safeDoubleConv(item.getValue()) / 100.0 * accCost;
                } else if (BASE_TYPE_YAN_BAO.equals(item.getType())) {
                    v = safeDoubleConv(item.getValue()) / 100.0 * warrantyCost;
                } else if (BASE_TYPE_FUCAI_PROFITS.equals(item.getType())) {
                    double based = accCost - orderFittingCost[0].doubleValue();
                    v = safeDoubleConv(item.getValue()) / 100.0 * based;
                } else if (BASE_TYPE_EMP_FUCAI_PROFITS.equals(item.getType())) {
                    double based = accCost - orderFittingCost[1].doubleValue();
                    v = safeDoubleConv(item.getValue()) / 100.0 * based;
                } else if (BASE_TYPE_CJJSF.equals(item.getType())) {
                    double based = safeDoubleConv(form.getFactoryFee());
                    v = safeDoubleConv(item.getValue()) / 100.0 * based;
                } else {
                    throw new RuntimeException("illegal base type:" + item.getType());
                }
                v = BigDecimal.valueOf(v).setScale(2, RoundingMode.HALF_UP).doubleValue();
                sum += v;
                settlementDetail.append(label).append("###").append(v).append(";");
                item.setCalculatedValue(v); // 副作用
            } else {
                sum += safeDoubleConv(item.getValue());
                settlementDetail.append(label).append("###").append(safeDoubleConv(item.getValue())).append(";");
                item.setCalculatedValue(safeDoubleConv(item.getValue())); // 副作用
            }
        }

        return new Tuple<>(sum, settlementDetail.toString());
    }

    // 判断工单是否已经存在结算记录。
    private boolean hasAlreadyC(String[] orderIds) {
        SqlKit kit = new SqlKit()
                .append("SELECT COUNT(1) AS cnt FROM crm_order_settlement AS s")
                .append("WHERE s.order_id IN (" + StringUtil.joinInSql(orderIds) + ")");

        Long count = Db.queryLong(kit.toString());
        return count > 0;
    }

    // 判断工单是否已经存在结算记录。
    private boolean hasAlreadyC2017(String[] orderIds, String  siteId) {
        String settlementTable = tableSplitMapper.mapOrderSettlement(siteId);
        if (settlementTable == null) {
            return false;
        }

        SqlKit kit = new SqlKit()
                .append("SELECT COUNT(1) AS cnt FROM " + settlementTable + " AS s")
                .append("WHERE s.order_id IN (" + StringUtil.joinInSql(orderIds) + ")");

        Long count = Db.queryLong(kit.toString());
        return count > 0;
    }

    // 判断指定工单是否已经存在结算记录。
    private boolean hasAlreadyC(String orderId) {
        SqlKit kit = new SqlKit()
                .append("SELECT COUNT(1) AS cnt FROM crm_order_settlement AS s")
                .append("WHERE s.order_id=?");

        Long count = Db.queryLong(kit.toString(), orderId);
        return count > 0;
    }

    // 判断指定工单是否已经存在结算记录。
    private boolean hasAlreadyC2017(String orderId, String siteId) {
        String settlementTable = tableSplitMapper.mapOrderSettlement(siteId);
        if (settlementTable == null) {
            return false;
        }

        SqlKit kit = new SqlKit()
                .append("SELECT COUNT(1) AS cnt FROM " + settlementTable + " AS s")
                .append("WHERE s.order_id=?");

        Long count = Db.queryLong(kit.toString(), orderId);
        return count > 0;
    }

    /**
     * 批量结算。
     */
    public Result<Void> batchSave(BatchSettlementForm form) {
        User user = UserUtils.getUser();
        String siteId = CrmUtils.getCurrentSiteId(user);
        String orderIds = form.getOrderIds();
        String[] orderIdArr = orderIds.split(",");
        logger.info("batch order ids: " + orderIds);
        if (hasAlreadyC(orderIdArr)) {
            return Result.fail("421", "some order has already been settled");
        }

        Map<String, List<Record>> relEmps = getBatchSettlementRelEmps(orderIdArr);
        // 检查关联的工程师，如果没有关联的工程师，那么直接认为该批量结算不合法。
        Set<Map.Entry<String, List<Record>>> entries = relEmps.entrySet();
        for (Map.Entry<String, List<Record>> entry : entries) {
            List<Record> value = entry.getValue();
            if (value == null || value.size() <= 0) {
                return Result.fail("422", String.format("order[%s] has no related employee", entry.getKey()));
            }
        }

        Map<String, BigDecimal[]> orderFittingCostMap = getOrderFittingCost(orderIdArr, siteId);
        List<Order> orders = orderService.getByIds(orderIdArr);
        StatelessSession session = sessionFactory.openStatelessSession();
        Transaction tx = session.beginTransaction();
        try {
            for (Order order : orders) {
                List<Record> orderRelEmps = relEmps.get(order.getId());
                BigDecimal[] fittingCost = orderFittingCostMap.get(order.getId()); // 该工单的配件成本
                createSettlementWhenBatch(session, form, orderRelEmps, fittingCost, order, siteId, CrmUtils.getUserXM());
            }
            tx.commit();
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
            tx.rollback();
            return Result.fail("423", "save batch failed");
        } finally {
            session.close();
        }
        return Result.ok();
    }

    /**
     * 批量结算。
     */
    public Result<Void> batchSave2017(BatchSettlementForm form, String siteId) {
        String orderIds = form.getOrderIds();
        String[] orderIdArr = orderIds.split(",");
        logger.info("batch order ids: " + orderIds);
        if (hasAlreadyC2017(orderIdArr, siteId)) {
            return Result.fail("421", "some order has already been settled");
        }

        Map<String, List<Record>> relEmps = getBatchSettlementRelEmps2017(orderIdArr, siteId);
        // 检查关联的工程师，如果没有关联的工程师，那么直接认为该批量结算不合法。
        Set<Map.Entry<String, List<Record>>> entries = relEmps.entrySet();
        for (Map.Entry<String, List<Record>> entry : entries) {
            List<Record> value = entry.getValue();
            if (value == null || value.size() <= 0) {
                return Result.fail("422", String.format("order[%s] has no related employee", entry.getKey()));
            }
        }

        Map<String, BigDecimal[]> orderFittingCostMap = getOrderFittingCost2017(orderIdArr, siteId);
        List<Record> orders = orderService.getByIds2017(orderIdArr, siteId);
//        StatelessSession session = sessionFactory.openStatelessSession();
//        Transaction tx = session.beginTransaction();
//        try {
            for (Record order : orders) {
                List<Record> orderRelEmps = relEmps.get(order.getStr("id"));
                BigDecimal[] fittingCost = orderFittingCostMap.get(order.getStr("id")); // 该工单的配件成本
                createSettlementWhenBatch2017(form, orderRelEmps, fittingCost, new HistoryBkOrder(order), siteId, CrmUtils.getUserXM());
            }
//            tx.commit();
//        } catch (Exception ex) {
//            logger.error(ex.getMessage(), ex);
//            tx.rollback();
//            return Result.fail("423", "save batch failed");
//        } finally {
//            session.close();
//        }
        return Result.ok();
    }

    public static BigDecimal sum(BigDecimal d0, BigDecimal d1, BigDecimal d2) {
        BigDecimal total = new BigDecimal("0");
        if (d0 != null) {
            total = total.add(d0);
        }
        if (d1 != null) {
            total = total.add(d1);
        }
        if (d2 != null) {
            total = total.add(d2);
        }
        return total;
    }

    //结算条件设置查询
    private Record queryLsSetPl(String siteId) {
        return Db.findFirst("select a.* from crm_site_common_setting a where a.site_id=? and a.type='5'", siteId);
    }

    //检验是否允许批量结算
    public Result<T> checkAllowSettle(String siteId, String ids) {
        /*结算条件设置query*/
        Record rd = queryLsSetPl(siteId);

        Result<T> rt = new Result<T>();
        rt.setCode("200");
        rt.setMsg("check success");
        String[] idsArr = ids.split(",");
        if (isOrdersRelatedDelEmp(idsArr)) {
            rt.setCode("422");
            rt.setErrMsg("order relate del emp");
            return rt;
        }

        List<Record> list = Db.find("select a.*,c.result as callResult from  crm_order a left join crm_order_callback c on a.id=c.order_id  where a.id in (" + StringUtil.joinInSql(idsArr) + ")");
        for (Record rds : list) {
            String status = rds.getStr("status");
            if (!"3".equals(status) && !"4".equals(status)) {
                rt.setCode("421");
                rt.setErrMsg(rds.getStr("number"));
                return rt;
            }

            if (rd != null) {//设置了结算条件
                BigDecimal allMny = sum(rds.getBigDecimal("auxiliary_cost"), rds.getBigDecimal("serve_cost"), rds.getBigDecimal("warranty_cost"));
                BigDecimal confirmMny = rds.getBigDecimal("confirm_cost");
                if (confirmMny == null) {
                    confirmMny = new BigDecimal("0");
                }
                if ("0".equals(rd.getStr("set_value"))) {//0先回访在结算
                    if (!"1".equals(rds.getStr("callResult"))) {
                        rt.setCode("430");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                }
                if ("1".equals(rd.getStr("set_value"))) {//1实收金额=交款金额
                    if (!(allMny.compareTo(confirmMny) == 0)) {//不相等
                        rt.setCode("431");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                }
                if ("2".equals(rd.getStr("set_value"))) {//0、1两种结算条件都选中
                    if (!"1".equals(rds.getStr("callResult"))) {
                        rt.setCode("432");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                    if (!(allMny.compareTo(confirmMny) == 0)) {//不相等
                        rt.setCode("433");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                }
                if ("3".equals(rd.getStr("set_value"))) {
                    //0、1两种结算条件都未选
                }
            }
        }
        return rt;
    }

    //检验是否允许批量结算
    public Result<T> checkAllowSettle2017(String siteId, String ids) {
        /*结算条件设置query*/
        Record rd = queryLsSetPl(siteId);

        Result<T> rt = new Result<T>();
        rt.setCode("200");
        rt.setMsg("check success");
        String[] idsArr = ids.split(",");
        if (isOrdersRelatedDelEmp2017(idsArr, siteId)) {
            rt.setCode("422");
            rt.setErrMsg("order relate del emp");
            return rt;
        }

        String orderTable =  tableSplitMapper.mapOrder(siteId);
        String callbackTable = tableSplitMapper.mapOrderCallback(siteId);
        if (orderTable == null ||  callbackTable == null) {
            rt.setCode("444");
            return rt;
        }

        List<Record> list = Db.find("select a.*,c.result as callResult from  " + orderTable + " a left join " + callbackTable + " c on a.id=c.order_id  where a.id in (" + StringUtil.joinInSql(idsArr) + ")");
        for (Record rds : list) {
            String status = rds.getStr("status");
            if (!"3".equals(status) && !"4".equals(status)) {
                rt.setCode("421");
                rt.setErrMsg(rds.getStr("number"));
                return rt;
            }

            if (rd != null) {//设置了结算条件
                BigDecimal allMny = sum(rds.getBigDecimal("auxiliary_cost"), rds.getBigDecimal("serve_cost"), rds.getBigDecimal("warranty_cost"));
                BigDecimal confirmMny = rds.getBigDecimal("confirm_cost");
                if (confirmMny == null) {
                    confirmMny = new BigDecimal("0");
                }
                if ("0".equals(rd.getStr("set_value"))) {//0先回访在结算
                    if (!"1".equals(rds.getStr("callResult"))) {
                        rt.setCode("430");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                }
                if ("1".equals(rd.getStr("set_value"))) {//1实收金额=交款金额
                    if (!(allMny.compareTo(confirmMny) == 0)) {//不相等
                        rt.setCode("431");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                }
                if ("2".equals(rd.getStr("set_value"))) {//0、1两种结算条件都选中
                    if (!"1".equals(rds.getStr("callResult"))) {
                        rt.setCode("432");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                    if (!(allMny.compareTo(confirmMny) == 0)) {//不相等
                        rt.setCode("433");
                        rt.setErrMsg(rds.getStr("number"));
                        return rt;
                    }
                }
                if ("3".equals(rd.getStr("set_value"))) {
                    //0、1两种结算条件都未选
                }
            }
        }
        return rt;
    }

    public Object saveEdit(SettlementForm settlementForm) {
        String serviceMeasures = settlementForm.getsMethod();
        if ("KEEPOLD".equals(serviceMeasures)) {
            String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
            String orderId = settlementForm.getOrderId();
            OrderSettlement oldSettlement = settlementDao.getByHql("from OrderSettlement where orderId=:p1 and siteId=:p2", new Parameter(orderId, siteId));
            settlementForm.setsMethod(oldSettlement.getServiceMeasures());
        }
        settlementForm.setMode(JF_TYPE_RENEW);
        return save(settlementForm);
    }

    public Object saveEdit2017(SettlementForm settlementForm, String siteId) {
        String serviceMeasures = settlementForm.getsMethod();
        if ("KEEPOLD".equals(serviceMeasures)) {
            String orderId = settlementForm.getOrderId();
            HistoryBkOrderSettlement oldSettlement = new HistoryBkOrderSettlement(getOrderSettlement2017(orderId, siteId));
            settlementForm.setsMethod(oldSettlement.getServiceMeasures());
        }
        settlementForm.setMode(JF_TYPE_RENEW);
        return save2017(settlementForm, siteId);
    }

    public boolean isOrderRelatedDelEmp(String orderId) {
        SqlKit kit = new SqlKit()
                .append("SELECT e.id FROM crm_employe AS e")
                .append("WHERE e.status='1'")
                .append("AND e.id IN (")
                .append("SELECT DISTINCT r.`emp_id` FROM crm_order AS o")
                .append("INNER JOIN crm_order_dispatch AS d")
                .append("ON o.id=d.`order_id` AND d.`status`='5'")
                .append("INNER JOIN `crm_order_dispatch_employe_rel` AS r")
                .append("ON r.`dispatch_id`=d.`id`")
                .append("WHERE o.`id`=?)");
        return Db.findFirst(kit.toString(), orderId) != null;
    }

    public boolean isOrderRelatedDelEmp2017(String orderId, String siteId) {
        String orderTable = tableSplitMapper.mapOrder(siteId);
        String dispatchTable = tableSplitMapper.mapOrderDispatch(siteId);
        String relTable = tableSplitMapper.mapOrderDispatchEmployeRel(siteId);
        if (orderTable == null || dispatchTable == null || relTable == null) {
            return false;
        }

        SqlKit kit = new SqlKit()
                .append("SELECT e.id FROM crm_employe AS e")
                .append("WHERE e.status='1'")
                .append("AND e.id IN (")
                .append("SELECT DISTINCT r.`emp_id` FROM "  + orderTable + " AS o")
                .append("INNER JOIN " + dispatchTable + " AS d")
                .append("ON o.id=d.`order_id` AND d.`status`='5'")
                .append("INNER JOIN " + relTable  + " AS r")
                .append("ON r.`dispatch_id`=d.`id`")
                .append("WHERE o.`id`=?)");
        return Db.findFirst(kit.toString(), orderId) != null;
    }

    public boolean isOrdersRelatedDelEmp(String[] orderIds) {
        SqlKit kit = new SqlKit()
                .append("SELECT e.id FROM crm_employe AS e")
                .append("WHERE e.status='1'")
                .append("AND e.id IN (")
                .append("SELECT DISTINCT r.`emp_id` FROM crm_order AS o")
                .append("INNER JOIN crm_order_dispatch AS d")
                .append("ON o.id=d.`order_id` AND d.`status`='5'")
                .append("INNER JOIN `crm_order_dispatch_employe_rel` AS r")
                .append("ON r.`dispatch_id`=d.`id`")
                .append("WHERE o.`id` IN(" + StringUtil.joinInSql(orderIds) + ") )");
        return Db.findFirst(kit.toString()) != null;
    }

    public boolean isOrdersRelatedDelEmp2017(String[] orderIds, String siteId) {
        String orderTable = tableSplitMapper.mapOrder(siteId);
        String dispatchTable = tableSplitMapper.mapOrderDispatch(siteId);
        String relTable = tableSplitMapper.mapOrderDispatchEmployeRel(siteId);
        if (orderTable == null || dispatchTable == null || relTable == null) {
            return false;
        }

        SqlKit kit = new SqlKit()
                .append("SELECT e.id FROM crm_employe AS e")
                .append("WHERE e.status='1'")
                .append("AND e.id IN (")
                .append("SELECT DISTINCT r.`emp_id` FROM " + orderTable + " AS o")
                .append("INNER JOIN " + dispatchTable + " AS d")
                .append("ON o.id=d.`order_id` AND d.`status`='5'")
                .append("INNER JOIN " + relTable + " AS r")
                .append("ON r.`dispatch_id`=d.`id`")
                .append("WHERE o.`id` IN(" + StringUtil.joinInSql(orderIds) + ") )");
        return Db.findFirst(kit.toString()) != null;
    }
    
    public BigDecimal getDailyPayByOrderId(String orderId) {
    	BigDecimal dailyPay = new BigDecimal(0);
    	Record rd = Db.findFirst("SELECT SUM(a.sum_money) as moneys FROM crm_order_settlement_detail a WHERE a.order_id=? and a.service_measures='当日支付'",orderId);
    	if(rd!=null) {
    		if(rd.getBigDecimal("moneys")!=null) {
    			dailyPay = rd.getBigDecimal("moneys");
    		}
    	}
    	return dailyPay;
    }

    public Record getOrderSettlement(String orderId) {
        return Db.findFirst("SELECT * FROM crm_order_settlement WHERE order_id=?", orderId);
    }

    public Record getOrderSettlement2017(String orderId, String siteId) {
        String table = tableSplitMapper.mapOrderSettlement(siteId);
        if (table == null) {
            return null;
        }

        return Db.findFirst("SELECT * FROM " + table + " WHERE order_id=?", orderId);
    }

    public Record getOrderSettlementIfHistory(String orderId, String siteId) {
        Order order = orderDao.get(orderId);
        return order == null ? getOrderSettlement2017(orderId, siteId) : getOrderSettlement(orderId);
    }

    public void delSettlement2017(String settlementId, String siteId) {
        String settlementTable = tableSplitMapper.mapOrderSettlement(siteId);
        String settlementDetailTable = tableSplitMapper.mapOrderSettlementDetail(siteId);
        if (settlementTable == null || settlementDetailTable ==  null) {
            return;
        }
        Db.update("delete from " + settlementTable + " where id=?",  settlementId);
        Db.update("delete from " + settlementDetailTable + " where settlement_id=?",  settlementId);
    }
}