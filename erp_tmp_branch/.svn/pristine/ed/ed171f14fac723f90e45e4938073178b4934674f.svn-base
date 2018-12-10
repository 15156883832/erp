package com.jojowonet.modules.order.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.service.OrderMustFillSettingService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import ivan.common.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @author DQChen
 * @date 2018/3/1 0001
 */
@Controller
@RequestMapping(value="${adminPath}/order/orderMustFill")
public class OrderMustFillSettingController {
    @Autowired
    private OrderMustFillSettingService orderMustFillSettingService;
    @Autowired
    SfCacheService sfCacheService;

    @RequestMapping(value="getMustFillInfo")
    public String getMustFillInfo(HttpServletRequest request,Model model){
        List<Record> reList = orderMustFillSettingService.getMustFillInfo();
        List<Record> reListFed = orderMustFillSettingService.getMustFillInfoFed();
        Boolean has=true;
        if(reList.size()<1){
            has = false;
        }else{
            boolean r = false;
            for (Record re : reList) {
                if ("customerType".equals(re.getStr("name"))) {
                    r = true;
                }
            }
            if(!r){
                Record re = new Record();
                re.set("name", "customerType");
                re.set("status", "1");
                re.set("type", "0");
                reList.add(re);
            }
        }
        Boolean hasFed = true;
        if(reListFed.size()<1){
            hasFed = false;
        }

        model.addAttribute("hasData", has);
        model.addAttribute("reList", reList);

        model.addAttribute("hasDataFed", hasFed);
        model.addAttribute("reListFed", reListFed);
        return "modules/order/settings/orderMustfillSetting";
    }

    @RequestMapping(value="saveMustFill")
    public void saveMustFill(HttpServletRequest request){
        Map<String, Object> params = request.getParameterMap();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        orderMustFillSettingService.saveMustFill(params, siteId);
        sfCacheService.hdel(SfCacheKey.mustFillMap, siteId);
        sfCacheService.hdelDelay(SfCacheKey.mustFillMap, 2, siteId);
    }

}
