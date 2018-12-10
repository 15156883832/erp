package com.jojowonet.modules.order.web;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.service.FittingService;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.operate.service.EmployeService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.adapters.HistoryBkOrder;
import com.jojowonet.modules.order.dao.CustomerTypeDao;
import com.jojowonet.modules.order.dao.Order2017Dao;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.entity.SettlementTemplate;
import com.jojowonet.modules.order.form.vo.ExtendedCallback;
import com.jojowonet.modules.order.form.vo.ExtendedOrder2017Record;
import com.jojowonet.modules.order.service.*;
import com.jojowonet.modules.order.utils.BrandUtils;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.MsgModelUtils;
import com.jojowonet.modules.sys.util.RegexUtil;
import com.jojowonet.modules.sys.util.TranslationUtils;
import ivan.common.config.Global;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "${adminPath}/order2017/orderDispatch")
public class OrderDispatch2017Controller extends BaseController {
    @Autowired
    private OrderDispatchService orderDispatchService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderCallBackService orderCallBackService;
    @Autowired
    private OrderOriginService orderOriginServicce;
    @Autowired
    private SettlementTemplateService setService;
    @Autowired
    private SiteSettlementService settlementService;
    @Autowired
    EmployeService employeService;
    @Autowired
    FittingService fittingService;
    @Autowired
    ChangeSelfOrderService changeSelfOrderService;
    @Autowired
    private SmsTempletService smsTempletService;
    @Autowired
    private OrderMustFillSettingService orderMustFillSettingService;

    @Autowired
    private OrderMallService orderMallService;

    @Autowired
    private OrderDispatch2017Service orderDispatch2017Service;

    @Autowired
    private Order2017Dao order2017Dao;
    @Autowired
	private SiteService siteService;

    // 全部工单详情
    @RequestMapping(value = "order2017form")
    public String order2017form(HttpServletRequest request, Model model) {
        String haveData = "0";
//        User user = UserUtils.getUser();
//        String siteIdNow = CrmUtils.getCurrentSiteId(user);
//        String whereMark = request.getParameter("whereMark");
        Map<String, Object> map = getParams(request);

        String orderId = request.getParameter("id");

        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Record order = order2017Dao.findOrderById(orderId, siteId);
     // 报修图片
     		Integer repairImgsCount = 0;
        if (StringUtils.isNotBlank(order.getStr("bd_imgs"))) {
            String[] repairImgs = order.getStr("bd_imgs").split("[,;]");
            model.addAttribute("bdImgs", repairImgs);
    		repairImgsCount = repairImgs.length;
    		}
    		model.addAttribute("repairImgsCount", repairImgsCount);
        String customerName  = order.getStr("customer_name");
        if (customerName!= null) {
            order.set("customer_name", RegexUtil.NEW_LINE.matcher(customerName).replaceAll(""));
        }
//        String siteId = order.getStr("site_id");
        model.addAttribute("siteId", siteId);
        Long count = Db.queryLong("SELECT COUNT(*) FROM crm_sended_sms a WHERE a.order_id = '"
                        + orderId + "' AND a.site_id='" + siteId + "'");
      	// 地址信息
    		Site site = siteService.get(siteId);
    		Map<String, Object> mapAddr = CrmUtils.getProCityAreaRecord(site, order);
    		model.addAttribute("provincelist", mapAddr.get("provincelist"));
    		model.addAttribute("cities", mapAddr.get("cities"));
    		model.addAttribute("districts", mapAddr.get("districts"));
    		model.addAttribute("site", site);
    		// 自定义用户类型
    		model.addAttribute("cusTypecount", CustomerTypeDao.getsiteCustomerTypeCount(siteId));
        String name = site.getSmsSign();
        String jdPhone = site.getSmsPhone();
        String siteMobile = site.getMobile();
        String siteName = site.getName();
        String siteArea = site.getArea();
        model.addAttribute("haveData", haveData);
        model.addAttribute("mapDt", map);
        model.addAttribute("proTime", order.getDate("promise_time"));
        model.addAttribute("serviceName", name);
        model.addAttribute("jdPhone", jdPhone);
        model.addAttribute("siteMobile", siteMobile);
        model.addAttribute("siteArea", siteArea);
        model.addAttribute("siteName", siteName);
        if (StringUtils.isNotBlank(order.getStr("employe_id"))) {
            Map<String, String> msg2 = orderDispatchService.getEmployeMsg1(order.getStr("employe_id"));
            model.addAttribute("msg1", msg2.get("nameMobile"));
            model.addAttribute("msg2Names", msg2.get("empNames"));
            model.addAttribute("msg2Mobiles", msg2.get("empMobiles"));
        } else {
            model.addAttribute("msg1", "");
            model.addAttribute("msg2Names", "");
            model.addAttribute("msg2Mobiles", "");
        }

  
        //模板获取
        List<Record> listModel = MsgModelUtils.getListModel(order.getStr("status"));
        model.addAttribute("listModel", listModel);

        String orderAddress = org.apache.commons.lang3.StringUtils.defaultString(order.getStr("customer_address"), "").replaceAll("\n", "");
        model.addAttribute("orderAddress", orderAddress);
        order.set("customer_address", orderAddress);

        List<Record> category = CategoryUtils.getListCategorySite(siteId);
        Record rds = orderDispatchService.getOrderId2017(orderId, siteId);
        model.addAttribute("disOrder", rds);
        List<String> catelist = new ArrayList<>();
        for (Record caterd : category) {
            catelist.add(caterd.getStr("name"));
        }
        model.addAttribute("catelist", catelist);
        model.addAttribute("category", category);
        model.addAttribute("order", new HistoryBkOrder(order));
        String odStatus = (rds == null ? "" : rds.getStr("status"));
        model.addAttribute("dispStatus", (rds == null ? "" : TranslationUtils.translateDispatchOrderStatus(odStatus)));


        Map<String, String> brand = BrandUtils.getSiteBrand(siteId, null);
        model.addAttribute("brand", brand);
        List<String> brandlist = new ArrayList<>();
        brandlist.addAll(brand.values());
        model.addAttribute("brandlist", brandlist);
        model.addAttribute("number", order.getStr("number"));

        List<String> listStr;
        // 信息来源
        List<Record> listOrigin = orderOriginServicce.filterOrderOrigin(siteId);
        List<String> listOriginlist = new ArrayList<>();
        for (Record rdss : listOrigin) {
            listOriginlist.add(rdss.getStr("name"));
        }
        model.addAttribute("listorigin", listOrigin);
        model.addAttribute("listoriginlist", listOriginlist);
        // 时间要求
        List<Record> list = orderDispatchService.getAllProLimit(new ArrayList<Record>());
        listStr = Lists.newArrayList();
        for (int i = 0; i < list.size(); i++) {
            listStr.add(list.get(i).getStr("name"));
        }
        model.addAttribute("proLimitList", listStr);
        model.addAttribute("count", count);

        List<Record> malllist = orderMallService.getlist(siteId);
        model.addAttribute("malllist", malllist);

        //服务工程师
        if (StringUtils.isNotBlank(order.getStr("employe_name"))) {
            String[] emplName = order.getStr("employe_name").split(",");
            List<Record> listemp = new ArrayList<>();
            for (int i = 0; i < emplName.length; i++) {
                Record r = new Record();
                r.set("name", emplName[i]);
                listemp.add(r);
            }
            model.addAttribute("emName", listemp);
        }

        /*必填设置*/
        List<Record> mustFillInfoList = orderMustFillSettingService.getMustFillInfo();
        Record mustfill = new Record();
        for (Record re : mustFillInfoList) {
            Boolean rsu = changeFrom(re.getStr("status"));
            mustfill.set(re.getStr("name"), rsu);
        }
        if (mustFillInfoList.size() < 1) {
            mustfill.set("customerFeedback", true);
        }
        model.addAttribute("mustfill", mustfill);


        if ("1".equals(order.getStr("status")) || "7".equals(order.getStr("status")) || "0".equals(order.getStr("status"))) {
            //自定义模板获取
            List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
            model.addAttribute("definedmodel", definedmodel);
            //判断条码是否有历史工单
            return "modules/order/orderManagement/2017Order/order2017DispatchForm";
        } else if ("2".equals(order.getStr("status"))) {
            if (StringUtils.isNotBlank(order.getStr("employe_id"))) {
                model.addAttribute("empMobile", org.apache.commons.lang3.StringUtils.join(getOrderEmpMobiles(order.getStr("employe_id")), ","));
            }

            // 反馈信息
            Long count1 = orderService.getPjMsg1(orderId, siteId);
            Record rdetail = orderDispatchService.feedBackDuringDetail2017(siteId, orderId);
            if (rdetail != null) {
                model.addAttribute("duringFeedImgs", rdetail.getStr("feedback_img"));
                Integer duringFeedImgsCount = 0;
                if (StringUtils.isNotBlank(rdetail.getStr("feedback_img"))) {
                    model.addAttribute("duringFeedImgsArr", rdetail.getStr("feedback_img").split(","));
                    duringFeedImgsCount = rdetail.getStr("feedback_img").split(",").length;
                }
                model.addAttribute("duringFeedImgsCount", duringFeedImgsCount);
            }
            Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords2017(orderId, siteId);
            model.addAttribute("feedbackInfo", feedbackInfo);
            // 派工信息
            Record dispRd = orderDispatchService.getOrderDispatchForCallBack2017(order.getStr("id"), siteId);
            model.addAttribute("dispRd", dispRd);
            model.addAttribute("count1", count1);
            List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getStr("number"), siteId);
            model.addAttribute("collectionslist", collectionslist);

            //自定义模板获取
            List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
            model.addAttribute("definedmodel", definedmodel);
            //判断条码是否有历史工单
		    /*Map<String,Object> maps2 = orderDispatchService.checkIfHasSameCode(siteId,order);
		    model.addAttribute("maps2",maps2);*/
            String erpwx = Global.getConfig("server.erpwx");
            String longUrl = String.format("%s/api/v2/toUserDianSafe?siteId=%s", erpwx, siteId);
            String ret = CrmUtils.getShortUrl(longUrl).replace("\n", "");
            model.addAttribute("oneHref", ret);
            return "modules/order/orderManagement/2017Order/order2017DuringForm";
        } else if ("3".equals(order.getStr("status"))  || "4".equals(order.getStr("status"))) {
            // 反馈信息
            Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords2017(orderId, siteId);
            model.addAttribute("feedbackInfo", feedbackInfo);
            // 派工信息
            Record dispRd = orderDispatchService.getOrderDispatchForCallBack2017(order.getStr("id"), siteId);
            model.addAttribute("dispRd", dispRd);

            //厂家工单派工信息可能为空（防止出现空指针）
            List<Record> disRels = null;
            if (dispRd != null) {
                disRels = orderDispatchService.getDispatchRels2017(dispRd.getStr("id"), siteId);
            }
            model.addAttribute("disRels", disRels);
            // 回访信息
            Record callbacks = orderCallBackService.getCallBackInfo2017(orderId, siteId);
            model.addAttribute("cbInfo", callbacks);
            model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
            model.addAttribute("extendedOrder", new ExtendedOrder2017Record(order));
            model.addAttribute("siteId", siteId);
            Record rdetail = orderDispatchService.feedBackDetail(siteId, orderId);
            if (rdetail != null) {
                model.addAttribute("feedBackDetail", rdetail);
                String feedBImgs = rdetail.getStr("feedback_img");
                if (StringUtils.isNotBlank(feedBImgs)) {
                    model.addAttribute("feedImgs", feedBImgs.split(","));
                    model.addAttribute("feedImgsCount", feedBImgs.split(",").length);
                } else {
                    model.addAttribute("feedImgs", "");
                    model.addAttribute("feedImgsCount", 0);
                }
            } else {
                model.addAttribute("feedBackDetail", "");
            }
            // 结算措施
            List<SettlementTemplate> listsetTem = setService.getListSet(order.getStr("appliance_category"), siteId);
            model.addAttribute("listsetTem", listsetTem);
            /*结算条件设置query*/
            Record jsSetRd = orderDispatchService.queryLsSet(siteId);
            model.addAttribute("jsSetRd", jsSetRd);
            List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getStr("number"), siteId);
            model.addAttribute("collectionslist", collectionslist);
            //自定义模板获取
            List<Record> definedmodel = smsTempletService.getSmsmodel(siteId);
            model.addAttribute("definedmodel", definedmodel);
            return "modules/order/orderManagement/2017Order/order2017HfForm";
        }

        /**
         * 在有结算信息的前提下
         */
        /*是迁移过来的数据但在2.0中结算的可以添加结算*/
        Record settlement = settlementService.getOrderSettlement2017(orderId, siteId);
        model.addAttribute("hasSettlement", settlement != null);

        // 反馈信息
        Map<String, Object> feedbackInfo = orderService.getOrderFeedbackRecords2017(orderId, siteId);
        model.addAttribute("feedbackInfo", feedbackInfo);
        // 派工信息
        Record dispRd = orderDispatchService.getOrderDispatchForCallBack2017(order.getStr("id"), siteId);
        model.addAttribute("dispRd", dispRd);
        // 回访信息
        Record callbacks = orderCallBackService.getCallBackInfo2017(orderId, siteId);
        model.addAttribute("cbInfo", callbacks);
        model.addAttribute("extendedCallback", new ExtendedCallback(callbacks));
        model.addAttribute("extendedOrder", new ExtendedOrder2017Record(order));
        List<Record> collectionslist = orderDispatchService.getCollectionlistByOrderNumber(order.getStr("number"), siteId);
        model.addAttribute("collectionslist",collectionslist);
        return "modules/order/orderManagement/2017Order/order2017HistoryForm";

    }
    private Boolean changeFrom(String op){
        return "0".equals(op);
    }

    private List<String> getOrderEmpMobiles(String empids) {
        List<String> empMobileList = new ArrayList<>();
        if (StringUtils.isNotBlank(empids)) {
            if (!(empids.indexOf(",") > 0)) {
                if (StringUtils.isNotBlank(empids)) {
                    Employe employe = employeService.get(empids);
                    if (employe != null) {
                        empMobileList.add(employe.getMobile());
                    }
                }
            } else {
                List<Employe> emps = employeService.getEmployes(empids);
                if (emps != null) {
                    for (Employe e : emps) {
                        empMobileList.add(e.getMobile());
                    }
                }
            }
        }
        return empMobileList;
    }
    
	/**
	 * 历史工单修改用户信息
	 */
	@RequestMapping(value = "updateHistoryUser")
	@ResponseBody
	public void updateHistoryUser(HttpServletRequest request, Order order) {
		String factoryNumber = request.getParameter("factoryNumber");
		orderDispatch2017Service.updateHistoryUser(order, factoryNumber);
	}


}
