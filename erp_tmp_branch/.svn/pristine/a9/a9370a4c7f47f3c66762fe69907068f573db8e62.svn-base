package com.jojowonet.modules.order.web;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteService;
import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2018/1/19.
 * 跳转到系统设置页面
 */
@Controller
@RequestMapping(value = "${adminPath}/order/Sysset")
public class SysSetController extends BaseController {

    SiteService siteService;

    @RequestMapping(value="tosysset")
    public String toSysset(HttpServletRequest request, HttpServletResponse response, Model model){
        String siteId = "";
        User user = UserUtils.getUser();
        if("2".equalsIgnoreCase(user.getUserType())){//服务商
            siteId = Db.findFirst(" select id from crm_site a where a.user_id = ? ", user.getId()).getStr("id");
        }else if("3".equalsIgnoreCase(user.getUserType())){
            siteId = Db.findFirst(" select a.site_id from crm_non_serviceman a where a.user_id = ? ", user.getId()).getStr("site_id");
        }
        model.addAttribute("siteId", siteId);
        return "modules/" + "order/sysSet";
    }
}
