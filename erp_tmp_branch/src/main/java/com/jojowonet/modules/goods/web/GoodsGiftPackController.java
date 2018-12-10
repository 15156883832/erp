package com.jojowonet.modules.goods.web;

import com.jfinal.ext.interceptor.GET;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.service.GoodsGiftPackService;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/19.
 */
@Controller
@RequestMapping(value="${adminPath}/goods/giveGift")
public class GoodsGiftPackController extends BaseController{

    @Autowired
    private GoodsGiftPackService goodsGiftPackService;

    @RequestMapping(value="giftPakege")
    public String getGiftpack(HttpServletRequest request, HttpServletResponse response, Model model){
        User user = UserUtils.getUser();
        String siteId = CrmUtils.getCurrentSiteId(user);
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        List<Record> sitelist = goodsGiftPackService.getSiteList();
        model.addAttribute("sitelist", sitelist);
        model.addAttribute("headerData", stf);
        return "modules/goods/giftPack";
    }


    @RequestMapping(value="getGiftPacklist")
    @ResponseBody
    public String getGiftPacklist(HttpServletRequest request, HttpServletResponse response, Model model) {
        Map<String,Object> map =  new TrimMap(getParams(request));
        Page<Record> pages = new Page<Record>(request, response);
        Page<Record> page = goodsGiftPackService.getGiftPackList(pages,map);
        return renderJson(new JqGridPage<>(page));
    }

    @RequestMapping(value="addGiftpack")
    @ResponseBody
    public String addGiftpack(HttpServletRequest request, HttpServletResponse response,String name,String takeSiteId,String addnum) {
        return goodsGiftPackService.addGiftpack(name,takeSiteId,addnum);
    }


    //删除公告
    @RequestMapping(value = "delete")
    @ResponseBody
    public String delete(HttpServletRequest request,HttpServletResponse response, String[] idArr) {
        String resulte="";
        Integer rows=0;
        for(int i=0;i<idArr.length;i++){
            goodsGiftPackService.deleteGiftpack(idArr[i]);
            rows++;
        }
        if(rows==idArr.length){
            resulte="ok";
        }
        return resulte;
    }

}
