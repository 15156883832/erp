package com.jojowonet.modules.factoryfitting;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.service.MicroFactoryService;
import com.jojowonet.modules.goods.utils.HttpUtils;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
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
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "${adminPath}/factoryfitting/Apply")
public class FactoryFittingApplyController extends BaseController{
	@Autowired
	private SiteDao siteDao;
	@Autowired
    private EzTemplate ezTemplate;
	@Autowired
	private MicroFactoryService microFactoryService;
    
    //新增备件申请
    @RequestMapping(value="addFactoryFittingApplyForm")
    public String addFactoryFittingApplyForm(HttpServletRequest request,Model model) {
    	String ids = request.getParameter("ids");
    	String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	model.addAttribute("nowDate", DateToStringUtils.DateToString());
    	Map<String,Object> map = new HashMap<>();
    	map.put("siteId", siteId);
    	Result<Map<String,Object>> listResult = ezTemplate.postForm("/getSiteById", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
//    	Map<String,Object> mp2 = listResult.getData();
    	model.addAttribute("site", listResult.getData());
    	model.addAttribute("ids",ids);
    	model.addAttribute("factoryFttingNumber", CrmUtils.applyNo("FF"));
    	return "modules/factoryFitting/apply/siteApply/addFactoryFittingApplyForm";
    }
    
    @ResponseBody
    @RequestMapping(value="getDetailsByIds")
    public List<Map<String,Object>> getDetailsByIds(HttpServletRequest request){
    	String ids = request.getParameter("ids");
    	Map<String,Object> map = new HashMap<>();
    	map.put("ids", ids);
    	Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getFittingDetailsByIds", map, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
        });
    	return listResult.getData();
    }
    
    //执行新增备件申请
    @ResponseBody
    @RequestMapping(value="addApplySave")
    public Result<String> addApplySave(HttpServletRequest request) {
    	User user = UserUtils.getUser();
    	String siteId= CrmUtils.getCurrentSiteId(user);
    	String uname = CrmUtils.getUserXM();
    	Map<String,Object> map = getParams(request);
		Site site = siteDao.get(siteId);
		map.put("siteId", siteId);
		map.put("siteName", site.getName());
    	map.put("userId", user.getId());
    	map.put("uname", uname);
    	map.put("factory_id", microFactoryService.findByName(request.getParameter("factory")).getId());
		return ezTemplate.postForm("/addApplySave", map, new ParameterizedTypeReference<Result<String>>() {
        });
    }
    
  //网点申请厂家备件表头
  	@RequestMapping(value="siteApplyHeader")
  	public String siteApplyHeader(HttpServletRequest request,Model model) {
  		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
  		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
  		model.addAttribute("headerData", stf);
  		return "modules/factoryFitting/apply/siteApply/siteApplyList";
  	}
  	
  //网点申请厂家备件列表
  	@ResponseBody
  	@RequestMapping(value ="getSiteApplyList")
  	public String getSiteApplyList(HttpServletRequest request, HttpServletResponse response, Model model) {
  		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
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
		Result<Map<String,Object>> listResult = ezTemplate.postForm("/getSiteApplyList", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
		page.setCount(Long.parseLong(listResult.getData().get("count").toString()));
		page.setList((List)listResult.getData().get("list"));
		return renderJson(new JqGridPage<>(page));
  	}
  	
  //修改备件申请
    @RequestMapping(value="editFactoryFittingApplyForm")
    public String editFactoryFittingApplyForm(HttpServletRequest request,Model model) {
    	String id = request.getParameter("id");
    	String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	Map<String,Object> map = new HashMap<>();
    	map.put("id", id);
    	map.put("siteId", siteId);
    	/*FactoryFittingApply ffa = factoryFittingApplyDao.get(id);*/
    	Result<Map<String,Object>> listResult = ezTemplate.postForm("/editFactoryFittingApplyForm", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
    	model.addAttribute("site", listResult.getData().get("site"));
    	model.addAttribute("ffa", listResult.getData().get("data"));
    	//model.addAttribute("nowDate", DateToStringUtils.DateToStringParam1(listResult.getData().get("create_time")));
    	return "modules/factoryFitting/apply/siteApply/editFactoryFittingApplyForm";
    }
    
  //根据备件申请id获取备件申请明细数据
    @ResponseBody
    @RequestMapping(value="getApplyDetailDataByApplyId")
    public List<Map<String,Object>> getApplyDetailDataByApplyId(String ffId,HttpServletRequest request){
    	Map<String,Object> map = new HashMap<>();
    	map.put("ffId", ffId);
    	Result<List<Map<String,Object>>> listResult = ezTemplate.postForm("/getApplyDetailDataByApplyId", map, new ParameterizedTypeReference<Result<List<Map<String,Object>>>>() {
        });
    	return listResult.getData();
    }
    
    //执行修改备件申请
    @ResponseBody
    @RequestMapping(value="editApplySave")
    public String editApplySave(HttpServletRequest request) {
    	User user = UserUtils.getUser();
    	String siteId= CrmUtils.getCurrentSiteId(user);
    	String uname = CrmUtils.getUserXM();
    	Map<String,Object> map = getParams(request);
    	map.put("siteId", siteId);
    	map.put("userId", user.getId());
    	map.put("uname", uname);
    	Result<String> listResult = ezTemplate.postForm("/editApplySave", map, new ParameterizedTypeReference<Result<String>>() {
        });
    	return listResult.getCode();
    }
    
    //备件申请到货入库
    @RequestMapping(value="factoryFittingApplyInStocksForm")
    public String factoryFittingApplyInStocksForm(HttpServletRequest request,Model model) {
    	String id = request.getParameter("id");
    	Map<String,Object> map = new HashMap<>();
    	map.put("id", id);
    	Result<Map<String,Object>> listResult = ezTemplate.postForm("/factoryFittingApplyInStocksForm", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
    	model.addAttribute("ffa",listResult.getData() );
    	return "modules/factoryFitting/apply/siteApply/applyInStocksForm";
    }
    
    
    //执行备件入库申请
    @ResponseBody
    @RequestMapping(value="inStockApplySave")
    public String inStockApplySave(HttpServletRequest request) {
    	User user = UserUtils.getUser();
    	String siteId= CrmUtils.getCurrentSiteId(user);
    	String uname = CrmUtils.getUserXM();
    	Map<String,Object> map = getParams(request);
    	map.put("siteId", siteId);
    	map.put("userId", user.getId());
    	map.put("uname", uname);
    	Result<String> listResult = ezTemplate.postForm("/inStockApplySave", map, new ParameterizedTypeReference<Result<String>>() {
        });
    	return listResult.getCode();
    }
    
  //服务商备件申请详情
    @RequestMapping(value="applyDetailForm")
    public String  applyDetailForm(HttpServletRequest request,Model model) {
    	String id = request.getParameter("id");
    	String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
    	//FactoryFittingApply ffa = factoryFittingApplyDao.get(id);
    	
    	Map<String,Object> map = new HashMap<>();
    	map.put("id", id);
    	Result<Map<String,Object>> listResult = ezTemplate.postForm("/factoryFittingApplyInStocksForm", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
    	
    	model.addAttribute("site", siteDao.get(siteId));
    	model.addAttribute("ffa",listResult.getData() );
    	return "modules/factoryFitting/apply/siteApply/applyDetailForm";
    }
    
    /*
     * 查看物流详情
    */
	@RequestMapping(value = "logsitDetail")
	public String logsitDetail(HttpServletRequest request, Model model){
		String id=request.getParameter("id");
		String type = request.getParameter("type");
		Map<String,List<Map.Entry<String,String>>> mapss = Maps.newHashMap();
		String logistucsNo = "";
		String logistucsName = "";
		String confirmTime = "";
		if("1".equals(type)) {
			//厂家备件申请物流
			Map<String,Object> map = new HashMap<>();
	    	map.put("id", id);
	    	Result<Map<String,Object>> listResult = ezTemplate.postForm("/factoryFittingApplyInStocksForm", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
	        });
	    	Map<String,Object> maps = listResult.getData();
			logistucsNo =  maps.get("logistics_no")!=null ? maps.get("logistics_no").toString() : "";
			logistucsName = maps.get("logistics_name")!=null ? maps.get("logistics_name").toString() : ""; //confirmTime
			confirmTime = maps.get("confirmTime")!=null ? maps.get("confirmTime").toString() : "";
		}else if("2".equals(type)) {
			//旧件返还物流信息
			Map<String,Object> map = new HashMap<>();
	    	map.put("id", id);
	    	Result<Map<String,Object>> listResult = ezTemplate.postForm("/oldFittingRevokeApplyDetail", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
	        });
	    	Map<String,Object> maps = listResult.getData();
			logistucsNo = maps.get("logistics_no")!=null ? maps.get("logistics_no").toString() : "";
			logistucsName = maps.get("logistics_name")!=null ? maps.get("logistics_name").toString() : "";
			confirmTime = maps.get("createTime")!=null ? maps.get("createTime").toString() : "";
		}
	/*	logistucsNo = "3914733463425";
		logistucsName = "韵达快递";*/
		String[] logs = logistucsNo.split(",");
		for(String logNo:logs){
			Map<String,String> map = HttpUtils.getLogistics(logNo, logistucsName);
			List<Map.Entry<String,String>> list = HttpUtils.sort(map); 
			mapss.put(logNo, list);
		}	
		model.addAttribute("mapss",mapss);
		model.addAttribute("confirmTime",confirmTime);
		model.addAttribute("logistucsName",logistucsName);
		return "modules/" + "factoryFitting/logisticsForm";
	}
	
	//备件申请导出
    @RequestMapping(value="exports")
    public String exports(HttpServletRequest request,HttpServletResponse response) {
    	String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
        String formPath = request.getParameter("formPath");
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
        String title = stf.getExcelTitle();
        Map<String, Object> map = new TrimMap(getParams(request));
        String fileName = title + "数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
    	JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
//        Page<Record> page1 = new Page<>(request, response);
        map.put("pageNo", 1);
        map.put("pageSize", 10000);
        map.put("siteId", siteId);
		Result<Map<String,Object>> listResult = ezTemplate.postForm("/getSiteApplyList", map, new ParameterizedTypeReference<Result<Map<String,Object>>>() {
        });
        List<Map<String,Object>> list=(List)listResult.getData().get("list");
		for (Map<String,Object> fa : list) {
			String status = fa.get("status").toString();
			if("0".equals(status)) {
				fa.put("status", "待审核");
			}
			if("1".equals(status)) {
				fa.put("status", "待出库");
			}
			if("2".equals(status)) {
				fa.put("status", "在途");
			}
			if("3".equals(status)) {
				fa.put("status", "已入库");
			}
		}
		try {
			new ExportJqExcel(title, jarray.toString(), stf.getSortHeader()).setDataList(list).write(request, response, fileName).dispose();
		} catch (Exception e) {
			return null;
		}
        return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
    }
    
  //删除备件申请
    @ResponseBody
    @RequestMapping(value="deleteFittingApply")
    public String deleteFittingApply(String ids,HttpServletRequest request){
    	if(StringUtils.isBlank(ids)) {
    		return "420";
    	}
    	Map<String,Object> map = new HashMap<>();
    	map.put("ids", ids);
    	Result<String> listResult = ezTemplate.postForm("/deleteFittingApply", map, new ParameterizedTypeReference<Result<String>>() {
        });
    	return listResult.getCode();
    }
}
