/**
 */
package com.jojowonet.modules.order.web;


import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.order.entity.Category;
import com.jojowonet.modules.order.entity.Malfunction;
import com.jojowonet.modules.order.service.MalfunctionService;
import com.jojowonet.modules.order.utils.CategoryUtils;
import com.jojowonet.modules.order.utils.CrmUtils;

import ivan.common.entity.mysql.common.Role;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 故障类别Controller
 *
 * @author Ivan
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/order/malfunction")
public class MalfunctionController extends BaseController {

    @Autowired
    private MalfunctionService malfunctionService;

    @Autowired
	private SiteDao siteDao;

    @ModelAttribute
    public Malfunction get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return malfunctionService.get(id);
        } else {
            return new Malfunction();
        }
    }

    @RequestMapping(value = {"list", ""})
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        List<Record> cateList = new ArrayList<>();
        Integer category = null;
        List<Category> list = null;
        Integer caId = null;
       if("1".equals(user.getUserType())){
    	   //运营
    	   cateList = siteDao.getplatCategory(siteId);
    	   if(cateList.size()>0){
    		   caId = cateList.get(0).getInt("id");
    	   }
       }else if("2".equals(user.getUserType())){
    	   //网点
    	   cateList = siteDao.getCategory(siteId);
    	   if(cateList.size()>0){
    		   caId = cateList.get(0).getInt("id");
    	   }
       }
       Page<HashMap<String, List<Malfunction>>> page = malfunctionService.getListMalfunction(siteId, new Page<HashMap<String, List<Malfunction>>>(request, response), caId, null);
       model.addAttribute("caId",caId);
       model.addAttribute("cate",cateList);
       model.addAttribute("page", page);
       model.addAttribute("isSystem", isSystemAdmin(user));
       return "modules/" + "order/malfunctionList";
    }

    @RequestMapping(value = "getlist")
    public String getlistMal(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        List<Record> cateList = new ArrayList<>();
        List<Category> list = null;//tab分类
        String type = request.getParameter("type");
        if("1".equals(user.getUserType())) {
        	  cateList = siteDao.getplatCategory(siteId);
        }else if("2".equals(user.getUserType())) {
        	 cateList = siteDao.getCategory(siteId);
        }
        Integer caId = null;
        if(StringUtils.isNotBlank(request.getParameter("categroy"))) {
        	caId = Integer.valueOf(request.getParameter("categroy"));
        }
        Page<HashMap<String, List<Malfunction>>> page = malfunctionService.getListMalfunction(siteId, new Page<HashMap<String, List<Malfunction>>>(request, response), caId, type);
        model.addAttribute("caId", caId);//获取当前选择的Tab的id
        model.addAttribute("cate", cateList);
        model.addAttribute("page", page);
        model.addAttribute("type", type);
        model.addAttribute("isSystem", isSystemAdmin(user));
        return "modules/" + "order/malfunctionList";
    }


    @RequestMapping(value = "savemal")
    @ResponseBody
    public Object saveMal(HttpServletRequest request, HttpServletResponse response) {
        String description = request.getParameter("result");
        String solution = request.getParameter("solution");
        String type = request.getParameter("type");
        String categ = request.getParameter("cate");
        String isSelectedAdding = request.getParameter("sel");
        String categroy = CategoryUtils.getCategoryName(categ);
        
        HashMap<String, String> ret = new HashMap<>();

        if (malfunctionService.isPlatformType(type,categroy) && "false".equals(isSelectedAdding)) {
            ret.put("ok", "duplicate");
            return ret;
        }

        if (solution != null) {
            String[] des = description.split("/");
            String[] solutions = solution.split("\\^");
            User user = UserUtils.getUser();
            List<Malfunction> list = Lists.newArrayList();
            for (int i = 0; i < des.length; i++) {
                Malfunction mal = new Malfunction();
                mal.setDescription(des[i]);
                mal.setSolution(solutions[i]);
                mal.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
                mal.setCreateBy(user.getId());
                mal.setUserType(user.getUserType());
                list.add(mal);
            }
            malfunctionService.saveMal(categroy, type, list);
        }
        ret.put("ok", "true");
        return ret;
    }

    @RequestMapping(value = "getupmal")
    @ResponseBody
    public Object getListMalfunction(HttpServletRequest request, HttpServletResponse response) {
        String description = request.getParameter("result");
        String solution = request.getParameter("solution");
        String type = request.getParameter("type");
        String xintype = request.getParameter("xintype");
        String categ = request.getParameter("cate");
        String categroy = CategoryUtils.getCategoryName(categ);
        HashMap<String, String> ret = new HashMap<>();
        boolean malTypeExists = malfunctionService.isMalTypeExists(xintype, categroy);
        if (malTypeExists && !type.equals(xintype)) {
            ret.put("ok", "duplicate");
            return ret;
        }

        if (malfunctionService.isPlatformType(xintype, categroy) && !isSystemAdmin(UserUtils.getUser())) {
            ret.put("ok", "false");
            return ret;
        }

        if (malfunctionService.isSiteAddedType(xintype, categroy) && isSystemAdmin(UserUtils.getUser())) {
            ret.put("ok", "duplicate");
            return ret;
        }


        if (solution != null) {
            String[] des = description.split("/");
            String[] solutions = solution.split("@");
            User user = UserUtils.getUser();
            List<Malfunction> list = Lists.newArrayList();
            for (int i = 0; i < des.length; i++) {
                Malfunction mal = new Malfunction();
                mal.setDescription(des[i]);
                mal.setSolution(solutions[i]);
                mal.setSiteId(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
                mal.setCreateBy(user.getId());
                mal.setUserType(user.getUserType());
                list.add(mal);
            }
            malfunctionService.updateMal(categroy, type, list, CrmUtils.getCurrentSiteId(UserUtils.getUser()), xintype);
            ret.put("ok", "true");
            return ret;
        } else {
            ret.put("ok", "false");
            return ret;
        }

    }

    @RequestMapping(value = "delectMalfunction")
    public void delectMalfunction(HttpServletRequest request, HttpServletResponse sponser) {
        String type = request.getParameter("type");
        String category = request.getParameter("cate");
        malfunctionService.delectMalfuncton(category, type, CrmUtils.getCurrentSiteId(UserUtils.getUser()));
    }

    @RequestMapping(value = "delSelectedMalfunction")
    public void delSelectedMalfunction(HttpServletRequest request, HttpServletResponse sponser) {
        String[] ids = request.getParameterValues("ids[]");
        if (ids != null) {
            malfunctionService.deleteSelectedMalfunctions(ids, isSystemAdmin(UserUtils.getUser()));
        }
    }

    @RequestMapping(value = "checktypeduplication")
    @ResponseBody
    public Object isMalTypeExists(HttpServletRequest request, HttpServletResponse resp) {
        HashMap<String, Object> ret = new HashMap<>();
        String type = request.getParameter("type");
        String category = request.getParameter("cate");
        boolean malTypeExists = malfunctionService.isMalTypeExists(category, type);
        ret.put("exist", malTypeExists);
        return ret;
    }

    private boolean isSystemAdmin(User user) {
        List<Role> list = user.getRoleList();
        if (list != null) {
            for (Role r : list) {
                if ("运营管理员".equals(r.getName())) {
                    return true;
                }
            }
        }
        return false;
    }
}
