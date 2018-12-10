package com.jojowonet.modules.factoryfitting;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.type.descriptor.java.BigIntegerTypeDescriptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.Order;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.UnitService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.sys.util.TrimMap;
import com.jojowonet.modules.sys.util.http.EzTemplate;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "${adminPath}/factoryfitting/stocks")
public class FactoryFittingStockController extends BaseController {
	
	@Autowired
    private EzTemplate ezTemplate;
	
	//厂家备件查看表头
	@RequestMapping(value="factoryfittingStocksHeaderLook")
	public String factoryfittingStocksHeaderLook(HttpServletRequest request,Model model) {
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,Object> map2 = new HashMap<>();
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getFactoryFittingCategory", map2, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
        });
		List<Map<String,Object>> listR= listResult.getData();
		model.addAttribute("listR", listR);
		model.addAttribute("headerData", stf);
		return "modules/factoryFitting/stocks/factoryfittingStocksLookList";
	}
	
	//备件库存管理列表
	@ResponseBody
	@RequestMapping(value ="getFactoryfittingStocksList")
	public String getFactoryfittingStocksList(Order order, HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String,Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		if (pages != null) {
			map.put("pageNo", pages.getPageNo());
			map.put("pageSize", pages.getPageSize());
		} else {
			map.put("pageNo", 1);
			map.put("pageSize", 20);
		}
		Page<Map<String,Object>> page = new Page<>();
		page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
		page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
		Result<Map<String,Object>> listResult = ezTemplate.postForm("/getFactoryFittingMsg", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
		page.setCount(Long.parseLong(listResult.getData().get("count").toString()));
		page.setList((List)listResult.getData().get("list"));
		return renderJson(new JqGridPage<>(page));
	}
	
	 @ResponseBody
	    @RequestMapping(value="getFactoryFittingsBySelect")
	    public  Map<String,Object> getFactoryFittingsBySelect(HttpServletRequest request,String page){
	        String code = request.getParameter("q");
	        Map<String,Object> map1 = new HashMap<>();
	        map1.put("code", code);
	        Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getFactoryFittingsBySelect", map1, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
	        });
	        Map<String,Object> map= Maps.newHashMap();
	        map.put("list",listResult.getData());
	        map.put("total_count",listResult.getData().size());
	        return map;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="getFactoryFittingsNameBySelect")
	    public  Map<String,Object> getFittingsNameBySelect(HttpServletRequest request,String page){
	        String name = request.getParameter("q");
	        StringBuilder sb=new StringBuilder();
	        Map<String,Object> map1 = new HashMap<>();
	        map1.put("name", name);
	        Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getFactoryFittingsNameBySelect", map1, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
	        });
	        Map<String,Object> map= Maps.newHashMap();
	        map.put("list",listResult.getData());
	        map.put("total_count",listResult.getData().size());
	        return map;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="getFactoryFittingsVersionBySelect")
	    public  Map<String,Object> getFactoryFittingsVersionBySelect(HttpServletRequest request,String page){
	        String version = request.getParameter("q");
	        Map<String,Object> map1 = new HashMap<>();
	        map1.put("version", version);
	        Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getFactoryFittingsVersionBySelect", map1, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
	        });
	        Map<String,Object> map= Maps.newHashMap();
	        map.put("list",listResult.getData());
	        map.put("total_count",listResult.getData().size());
	        return map;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="getFactoryFittingsByCode")
	    public  Map<String,Object> getFactoryFittingsByCode(HttpServletRequest request){
	        String code=request.getParameter("code");
	        Map<String,Object> map1 = new HashMap<>();
	        map1.put("code", code);
	        Result<Map<String,Object>> listResult = ezTemplate.postForm("/getFactoryFittingsByCode", map1, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
	        });
	        return listResult.getData();
	    }
	    
	  //服务商厂家备件查看导出
	    @RequestMapping(value="exportsSiteLook")
	    public String exportsSiteLook(HttpServletRequest request,HttpServletResponse response) {
	    	String formPath = request.getParameter("formPath");
	    	String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	    	SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId,formPath);
	    	String title = stf.getExcelTitle();
	    	String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
	    	JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
	    	Map<String,Object> map = new TrimMap(getParams(request));
	    	map.put("pageNo", 1);
	    	map.put("pageSize", 10000);
			Result<Map<String,Object>> listResult = ezTemplate.postForm("/getFactoryFittingMsg", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
	        });
	    	List<Map<String,Object>> list= (List)listResult.getData().get("list");;
	    	for (Map<String,Object> fit : list) {
	    		if ("1".equals(fit.get("type"))) {
	    			fit.put("type", "配件");
	    		} else if ("2".equals(fit.get("type"))) {
	    			fit.put("type", "耗材");
	    		} else {
	    			fit.put("type", "其他");
	    		}
	    		if (fit.get("site_price") != null) {
	    			BigDecimal bd = new BigDecimal(fit.get("site_price").toString());
	    			bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
	    			fit.put("site_price", bd.doubleValue());
	    		} else {
	    			fit.put("site_price", 0.00);
	    		}
	    		if (fit.get("stock_price") != null) {
	    			BigDecimal bd = new BigDecimal(fit.get("stock_price").toString());
	    			bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
	    			fit.put("stock_price", bd.doubleValue());
	    		} else {
	    			fit.put("stock_price", 0.00);
	    		}
	    	}
	    	try {
	    		new ExportJqExcel(title, jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
	    	} catch (Exception e) {
	    		return null;
	    	}
	    	return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	    }
	    
	    //旧件返厂记录表头
	    @RequestMapping(value = "revokeApplyRecordTab")
	    public String OldFittingWhole(HttpServletRequest request, HttpServletResponse response, Model model) {
	        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
	        model.addAttribute("headerData", stf);
	        model.addAttribute("siteId", siteId);
	        return "modules/factoryFitting/stocks/oldFittingRevertRecord";
	    }

	    //旧件返厂记录
	    @ResponseBody
	    @RequestMapping(value = "revokeApplyRecord")
	    public String revokeApplyRecord(HttpServletRequest request, HttpServletResponse response) {
	        User user = UserUtils.getUser();
	        String siteId = CrmUtils.getCurrentSiteId(user);
	        Map<String,Object> map = new TrimMap(getParams(request));
	        map.put("siteId", siteId);
			Page<Record> pages = new Page<Record>(request, response);
			if (pages != null) {
				map.put("pageNo", pages.getPageNo());
				map.put("pageSize", pages.getPageSize());
			} else {
				map.put("pageNo", 1);
				map.put("pageSize", 20);
			}
			Page<Map<String,Object>> page = new Page<>();
			page.setPageNo(Integer.valueOf(map.get("pageNo").toString()));
			page.setPageSize(Integer.valueOf(map.get("pageSize").toString()));
			Result<Map<String,Object>> listResult = ezTemplate.postForm("/revokeApplyRecord", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
	        });
			page.setCount(Long.parseLong(listResult.getData().get("count").toString()));
			page.setList((List)listResult.getData().get("list"));
	        return renderJson(new JqGridPage<>(page));
	    }
	    
	    @ResponseBody
	    @RequestMapping(value = "getFittingTabCount")
	    public Long getFittingTabCount(HttpServletRequest request) {
	    	Map<String,Object> map = new HashMap<>();
	    	String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	    	map.put("siteId", siteId);
	        Result<Long> listResult = ezTemplate.postForm("/getFittingTabCount", map, new ParameterizedTypeReference<Result<Long>>() {
	        });
	        return listResult.getData();
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="getApplysById")
	    public List<Map<String,Object>> getApplysById(HttpServletRequest request){
	        String id = request.getParameter("id");
	        Map<String,Object> map = new HashMap<>();
	    	map.put("id", id);
	    	map.put("siteId", CrmUtils.getCurrentSiteId(UserUtils.getUser()));
	        Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getInfoById", map, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
	        });
	        return  listResult.getData();
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="updateApplyRecord")
	    public String updateApplyRecord(HttpServletRequest request){
	        String ids=request.getParameter("ids");
	        if(StringUtils.isBlank(ids)){
	            return "201";
	        }
	        Map<String,Object> map = new HashMap<>();
	    	map.put("ids", ids);
	    	Result<String> listResult = ezTemplate.postForm("/updateApplyRecord", map, new ParameterizedTypeReference<Result<String>>() {
	        });
	        return listResult.getCode();
	    }
	    
	    @ResponseBody
	    @RequestMapping(value="deleteData")
	    public String deleteData(HttpServletRequest request){
	        String ids= request.getParameter("ids");
	        if(StringUtils.isBlank(ids)){
	            return "201";
	        }
	        Map<String,Object> map = new HashMap<>();
	    	map.put("ids", ids);
	    	Result<String> listResult = ezTemplate.postForm("/deleteData", map, new ParameterizedTypeReference<Result<String>>() {
	        });
	        return listResult.getCode();
	    }
	    
	    @RequestMapping(value = "exportOld")
	    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
	        try {
	            String formPath = request.getParameter("formPath");
	            String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
	            SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
	            String title = stf.getExcelTitle();
	            String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
	            Map<String, Object> map = getParams(request);
	            map.put("pageNo", 1);
		    	map.put("pageSize", 10000);
		    	map.put("siteId", siteId);
	            Result<Map<String,Object>> listResult = ezTemplate.postForm("/revokeApplyRecord", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
		        });
	            List<Map<String,Object>> list = (List)listResult.getData().get("list");

	            for (Map<String,Object> rd : list) {
	                if ("0".equals(rd.get("audit_status"))) {
	                    rd.put("audit_status", "待审核");
	                } else if ("1".equals(rd.get("audit_status"))) {
	                    rd.put("audit_status", "已入库");
	                }
	            }
	            new ExportJqExcel(title, stf.getTableHeader(), stf.getSortHeader())
	                    .setDataList(list)
	                    .write(request, response, fileName).dispose();
	            return null;
	        } catch (Exception e) {
	            e.printStackTrace();
	            addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
	        }
	        return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
	    }
	
}
