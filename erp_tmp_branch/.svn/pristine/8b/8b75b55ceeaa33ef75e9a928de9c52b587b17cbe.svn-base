package com.jojowonet.modules.finance.web;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.dao.ExacctDao;
import com.jojowonet.modules.finance.service.BalanceManagerService;
import com.jojowonet.modules.finance.service.ExacctService;
import com.jojowonet.modules.order.entity.GoodsCategory;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.sys.util.TrimMap;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;

/**
 * Created by Administrator on 2017/12/26.
 * 收支流水管理controller
 */

@Controller
@RequestMapping(value = "${adminPath}/finance/balanceManager")
public class BalanceManagerController extends BaseController {

    @Autowired
    private BalanceManagerService balanceManagerService;
    @Autowired
    private ExacctDao exacctDao;
    @Autowired
    private ExacctService exacctService;


    @RequestMapping(value = "balance")
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        List <Record> sitealllist = balanceManagerService.getAllsiteInfo(siteId);
        if (sitealllist != null) {
            model.addAttribute("sitealllist", sitealllist);
        }
        List <Record> exacctlist = exacctDao.getexacctlistSite(null, siteId, null);
        model.addAttribute("exacctlist", exacctlist);
        String createT = DateUtils.formatDate(new Date(), "yyyy-MM");
        String createT2 = DateUtils.formatDate(new Date(),"yyyy-MM-dd");
        model.addAttribute("occurtimemin", createT+"-01");
        model.addAttribute("occurtimemax", createT2);
        return "modules/finance/balanceManager";
    }

    @RequestMapping("getbalanceManagerlist")
    @ResponseBody
    public String getlist(HttpServletRequest request, HttpServletResponse response){
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map<String,Object> map = new TrimMap(getParams(request));
        Page<Record> page = new Page<>(request, response);
        page = balanceManagerService.getBalanceManagerList(page,siteId,map);
        JqGridPage<Record> jqp = new JqGridPage<>(page);
        return renderJson(jqp);
    }

    @RequestMapping("toadd")
    public String toadd(HttpServletRequest request, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        String username = CrmUtils.getUserXM();
        List <Record> sitealllist = balanceManagerService.getAllsiteInfo(siteId);
        if (sitealllist != null) {
            model.addAttribute("sitealllist", sitealllist);
        }
        List <Record> exacctlist = exacctDao.getexacctlistSite(null, siteId, null);
        model.addAttribute("exacctlist", exacctlist);
        String createT2 = DateUtils.formatDate(new Date(),"yyyy-MM-dd");
        model.addAttribute("occurtimemax", createT2);
        model.addAttribute("username",username);
        model.addAttribute("siteId",siteId);
        model.addAttribute("userId",userId);
        return "modules/finance/balanceManagerform";
    }

    //保存信息
    @RequestMapping("savebalance")
    @ResponseBody
    public String saveBalance(HttpServletRequest request, Model model) {
        String siteId = request.getParameter("siteId");
        String exacctId = request.getParameter("exacctName");
        String costType = request.getParameter("cost_type");
        String costTotal = request.getParameter("cost_total");
        String billType = request.getParameter("bill_type");
        String billAmount = request.getParameter("bill_amount");
        String detailContent = request.getParameter("detail_content");
        String costProducer = request.getParameter("createName");
        String costProducerName = request.getParameter("cost_producer_name");
        String occurTimes = request.getParameter("occurTimes");
        String createBy = request.getParameter("create_by_id");
        String createByName = request.getParameter("create_by");
        String remarks = request.getParameter("remarks");
        String exacctBrand = request.getParameter("exacct_brand");
        String imgs = request.getParameter("imgs");
        String result = balanceManagerService.save(siteId, exacctId, costType, costTotal, billType, billAmount, detailContent, costProducer, costProducerName, occurTimes, createBy, createByName,null,"0",remarks,exacctBrand,imgs);
        return result;

    }

    //求取支出与收入的差值
    @RequestMapping("sumbalanceAmount")
    @ResponseBody
    public Map <String, Object> sumbalanceAmount(HttpServletRequest request, Model model) {
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        Map <String, Object> map = new TrimMap(getParams(request));
        BigDecimal income = balanceManagerService.getIncome(siteId, map);
        BigDecimal outcome = balanceManagerService.getOutcome(siteId, map);
        BigDecimal sub = new BigDecimal(0);
        if (income != null && outcome != null) {
            sub = income.subtract(outcome);
        } else if (income == null && outcome != null) {
            sub = sub.subtract(outcome);
        } else if (income != null && outcome == null) {
            sub = income;
        } else {
        }
        Map <String, Object> result = new HashMap <>();
        result.put("income", income);
        result.put("outcome", outcome);
        result.put("sub", sub);
        return result;
    }

    @RequestMapping("showBJ")
    public String showBJ(String id,Model model){
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String userId = UserUtils.getUser().getId();
        String username = CrmUtils.getUserXM();
        List <Record> sitealllist = balanceManagerService.getAllsiteInfo(siteId);
        if (sitealllist != null) {
            model.addAttribute("sitealllist", sitealllist);
        }
        List <Record> exacctlist = exacctDao.getexacctlistSite(null, siteId, null);
        model.addAttribute("exacctlist", exacctlist);
        String createT2 = DateUtils.formatDate(new Date(),"yyyy-MM-dd");
        model.addAttribute("occurtimemax", createT2);
        model.addAttribute("username",username);
        model.addAttribute("userId",userId);
        Record bm = balanceManagerService.getBalanceById(id);
        if(bm.getDate("occur_time")!=null){
            String date = DateUtils.formatDate(bm.getDate("occur_time"),"yyyy-MM-dd");
            bm.set("occur_time",date);
        }
        if (StringUtils.isNotBlank(bm.getStr("imgs"))) {
            model.addAttribute("imagesSize", bm.getStr("imgs").split(",").length);
            model.addAttribute("images",bm.getStr("imgs").split(","));
        }else{
            model.addAttribute("imagesSize", 0);
            model.addAttribute("images",null);
        }

        model.addAttribute("bm",bm);
        return "modules/finance/balanceManagerBjform";
    }

    @RequestMapping("edite")
    @ResponseBody
    public String edite(HttpServletRequest request){
        String id = request.getParameter("id");
        String siteId = request.getParameter("siteId");
        String exacctId = request.getParameter("exacctName");
        String costType = request.getParameter("cost_type");
        String costTotal = request.getParameter("cost_total");
        String billType = request.getParameter("bill_type");
        String billAmount = request.getParameter("bill_amount");
        String detailContent = request.getParameter("detail_content");
        String costProducer = request.getParameter("createName");
        String costProducerName = request.getParameter("cost_producer_name");
        String occurTimes = request.getParameter("occurTimes");
        String createBy = request.getParameter("create_by_id");
        String createByName = request.getParameter("create_by");
        String remarks = request.getParameter("remarks");
        String exacctBrand = request.getParameter("exacct_brand");
        String imgs = request.getParameter("imgs");
        return balanceManagerService.edite(id,siteId, exacctId, costType, costTotal, billType, billAmount, detailContent, costProducer, costProducerName, occurTimes, createBy, createByName,null,"0",remarks,exacctBrand,imgs);
    }

    @RequestMapping("doShanchu")
    @ResponseBody
    public String doShanchu(String id){
        return balanceManagerService.doShanchu(id);
    }

    //导出
    @RequestMapping(value = "export")
    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String formPath = request.getParameter("formPath");
            User user = UserUtils.getUser();
            String siteId = CrmUtils.getCurrentSiteId(user);
            Page <Record> pages = new Page <Record>(request, response);
            pages.setPageNo(1);
            pages.setPageSize(10000);
            SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
            String title = stf.getExcelTitle();
            String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            Map <String, Object> ma = new TrimMap(getParams(request));
            JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
            jarray.remove(0);
            jarray.remove(10);
            List <Record> list = null;
            Date now = new Date();
            if ("收支流水".equals(title)) {
                list = balanceManagerService.getBalanceManagerList(pages, siteId, ma).getList();
                for (Record rd : list) {
                    if ("0".equals(rd.getStr("cost_type"))) {
                        rd.set("cost_type", "收入");
                    } else if ("1".equals(rd.getStr("cost_type"))) {
                        rd.set("cost_type", "支出");
                    } else if ("2".equals(rd.getStr("cost_type"))) {
                        rd.set("cost_type", "欠款");
                    } else {
                        rd.set("cost_type", "");
                    }
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    if (rd.getDate("occur_time") != null) {
                        rd.set("occur_time", sdf.format(rd.getDate("occur_time")));
                    }
                }

            } else {
            }
            new ExportJqExcel(title + "数据", jarray.toString(), stf.getSortHeader())
                    .setDataList(list).write(request, response, fileName).dispose();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
    }
    
    //费用科目自定义
    @RequestMapping(value="toExacctSiteSet")
    public String toExacctSiteSet(HttpServletRequest request,Model model) {
    	String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
    	model.addAttribute("headerData", stf);
    	return "modules/order/exacctSiteSet";
    }
    
    @ResponseBody
    @RequestMapping(value = "ExacctSiteList")
	public String goodsCateList(HttpServletRequest request, HttpServletResponse response) {
		Page<Record> page = new Page<Record>(request, response);
		Map<String,Object> map = new HashMap<>();
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		page = exacctService.getexacctlistSite(page, siteId, map);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
    
   //点击添加跳转到添加页面
  	@RequestMapping(value = "exacctForm")
  	public String form(GoodsCategory goodsCategory, Model model) {
  		model.addAttribute("goodsCategory", goodsCategory);
  		return "modules/" + "order/exacctForm";
  	}
  	
  //点击修改跳转到修改页面
  	@RequestMapping(value="editeExacct")
  	public String edite(HttpServletRequest request,String id,Model model){
  		model.addAttribute("exacct",exacctDao.get(id));
  		return "modules/" + "order/exacctEdit";
  	}
  	
  	//新增
  	@ResponseBody
  	@RequestMapping(value="saveExacctAdd")
  	public Map<String,Object> saveExacctAdd(String[] nameArr,HttpServletRequest request) {
  		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
  		String userId = UserUtils.getUser().getId();
  		//对系统默认的费用科目特殊处理--新增
  		exacctService.addDefault(siteId,"","");
  		return exacctService.saveExacctAdd(siteId,userId,nameArr);
  	}
  	
  	
  	//修改
  	@ResponseBody
  	@RequestMapping(value="updateExacctEdit")
  	public Map<String,Object> updateExacctEdit(String name,String id,HttpServletRequest request) {
  		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
  		String userId = UserUtils.getUser().getId();
  		return exacctService.updateExacctEdit(siteId,userId,name,id);
  	}
  	
  	//删除
  	@ResponseBody
  	@RequestMapping(value="deleteExacctCount")
  	public Map<String,Object> deleteExacctCount(String[] idArr,HttpServletRequest request) {
  		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
  		return exacctService.deleteExacctCount(siteId,idArr);
  	}
}
