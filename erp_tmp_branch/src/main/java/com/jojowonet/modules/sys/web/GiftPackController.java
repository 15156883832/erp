package com.jojowonet.modules.sys.web;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.service.GiftPackService;
import com.jojowonet.modules.sys.util.TrimMap;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/gift")
public class GiftPackController extends BaseController {

    @Autowired
    private GiftPackService giftPackService;

    @RequestMapping("")
    public String getHeaderList(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        long allVipGiftCount = giftPackService.allVipGiftCount(siteId);
        if(allVipGiftCount>0) {
            return "modules/sys/gift";
        } else {
            return "modules/sys/blankGift";
        }
    }

    @RequestMapping("vipTake")
    @ResponseBody
    public Result<Map<String, String>> vipTake(HttpServletRequest request, HttpServletResponse response, Model model) {
        String giftId = request.getParameter("id");
        return giftPackService.takeVipGift(giftId);
    }

    @SuppressWarnings("unchecked")
    @ResponseBody
    @RequestMapping(value = "giftPackGrid")
    public String getSiteCategoryList(HttpServletRequest request, HttpServletResponse response) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Page<Record> pages = new Page<>(request, response);
        Map<String, Object> map = new TrimMap(request.getParameterMap());
        Page<Record> page = giftPackService.getVipGifts(pages, siteId, map);
        return renderJson(new JqGridPage<>(page));
    }
}
