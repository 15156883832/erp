package com.jojowonet.modules.order.web;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.dao.OrderMallDao;
import com.jojowonet.modules.order.entity.OrderMall;
import com.jojowonet.modules.order.entity.OrderOrigin;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.OrderMallService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/1/25.
 * 购机商场controller
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderMall")
public class OrderMallController extends BaseController {
    @Autowired
    private OrderMallService orderMallService;

    @Autowired
    private SiteService siteSeivice;
    @Autowired
    private SfCacheService sfCacheService;


    @RequestMapping(value = {"list", ""})
    public String list(OrderOrigin orderOrigin, HttpServletRequest request, HttpServletResponse response, Model model) {
        //需要涉及到表头设置时才调用，如果不需要使用表头设置，则不需
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/" + "order/orderOrderMallList";
    }

    @RequestMapping(value = "mallList")
    @ResponseBody
    public String originList(OrderMall orderMall, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Record> page = new Page<>(request, response);
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map<String,Object> map = request.getParameterMap();
        page = orderMallService.find(page,map,siteId);
        model.addAttribute("page",page);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    @RequestMapping(value = "form")
    public String form( Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        List<String> malllist = orderMallService.getlistname(siteId);
        model.addAttribute("malllist", malllist);
        return "modules/" + "order/orderMallForm";
    }

    @RequestMapping(value = "save")
    @ResponseBody
    public  String save(String[] nameArr, String[] sortsArr, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes ) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        for (int i=0;i<nameArr.length;i++) {
            OrderMall orderMall=new OrderMall();
            orderMall.setMallName(nameArr[i]);
            if(sortsArr.length>0){
                if(StringUtil.isEmpty(sortsArr[i])){
                    sortsArr[i]="0";
                }
                Integer sort=null;
                if(StringUtil.isNotBlank(sortsArr[i])){
                    sort = Integer.valueOf(sortsArr[i]);
                }
                orderMall.setSort(sort);
            }
            orderMall.setSiteId(siteId);
            orderMall.setCreateBy(userId);
            orderMallService.save(orderMall);
        }
        sfCacheService.hdel(SfCacheKey.siteMallMap, siteId);
        sfCacheService.hdelDelay(SfCacheKey.siteMallMap, 2, siteId);
        return null;
    }
   @RequestMapping(value = "getMallByid")
   @ResponseBody
   public Record getMallById(String id,HttpServletRequest request,HttpServletResponse response){
       String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        return orderMallService.getOrderMallById(id,siteId);
   }


    @RequestMapping("update")
    @ResponseBody
    public String update(String names, String sorts, String id) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String result = "";
        if (StringUtil.isEmpty(names)) {
            result = "nullname";
        } else {
            if (StringUtil.isEmpty(sorts)) {
                sorts = "0";
            }
            Integer sort = null;
            if (StringUtil.isNotBlank(sorts)) {
                sort = Integer.valueOf(sorts);
            }
            result = orderMallService.updates(names, sort, id);
        }
        sfCacheService.hdel(SfCacheKey.siteMallMap, siteId);
        sfCacheService.hdelDelay(SfCacheKey.siteMallMap, 2, siteId);
        return result;
    }


    @RequestMapping(value = "deleteMall")
    @ResponseBody
    public String delete(String[] idArr) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        if(idArr!=null&&idArr.length>0){
            String ret = orderMallService.deleteMall(idArr);
            sfCacheService.hdel(SfCacheKey.siteMallMap, siteId);
            sfCacheService.hdelDelay(SfCacheKey.siteMallMap, 2, siteId);
            return ret;
        }else{
            return "false";
        }
    }

}