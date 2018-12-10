package com.jojowonet.modules.operate.web;

import com.jojowonet.modules.operate.service.SiteReminderService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.utils.CrmUtils;
import ivan.common.config.Global;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 服务商Controller
 *
 * @author gaols
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/reminder/")
public class SiteReminderController extends BaseController {

    @Autowired
    SiteReminderService siteReminderService;
    @Autowired
    SiteService siteService;

    @ResponseBody
    @RequestMapping(value = "saveLastXuFeiRemind", method = RequestMethod.POST)
    public void saveLastRemind() {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        siteReminderService.touchLastRemind(siteId);
    }

    @RequestMapping(value = "xufeiRemind")
    public String xufeiRemind(HttpServletRequest request, HttpServletResponse response) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        request.setAttribute("xufeiInfo", siteService.getSiteXuFeiInfo(siteService.get(siteId)));
        return "modules/sys/xfr2";
    }

    @RequestMapping(value = "showXufei")
    public String showXufei(Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map<String, Integer> xuFeiInfo = siteService.getSiteXuFeiInfo(siteService.get(siteId));
        if (xuFeiInfo.get("remindIcon") != null && xuFeiInfo.get("remindIcon") == 1) {
            Integer discount = xuFeiInfo.get("discount");
            if (5 == discount) {
                model.addAttribute("fee", 1825);
            } else if (6 == discount) {
                model.addAttribute("fee", 2190);
            } else {
                model.addAttribute("fee", 2920); // 这其实是一种异常情况，应该不会发生。
            }
            return "modules/sys/vip-renew"; // 这个只针对5折和6折购买的老用户
        } else {
            return "redirect:"+ Global.getAdminPath() + "/goods/sitePlatformGoods/jumpVIP";
        }
    }
}
