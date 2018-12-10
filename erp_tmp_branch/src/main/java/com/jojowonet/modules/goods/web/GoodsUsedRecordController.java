package com.jojowonet.modules.goods.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.service.GoodsUsedRecordService;
import com.jojowonet.modules.goods.service.GoodsSiteSelfService;
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

@Controller
@RequestMapping(value="${adminPath}/goods/usedRecord")
public class GoodsUsedRecordController extends BaseController {
	@Autowired
	private GoodsSiteSelfService goodsSiteSelfService;
	@Autowired
	private GoodsUsedRecordService goodsUsedRecordService;

	/*
	 * 商品待返还表头
	 * */
	@RequestMapping(value="waitReturn")
	public String waitReturn(HttpServletRequest request,HttpServletResponse response,Model model){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsUsedRecordService.waitReturnList(pages, map,siteId);
		model.addAttribute("employes", goodsUsedRecordService.getEmployes(siteId));
		model.addAttribute("page", page);
		model.addAttribute("map", map);
		return  "modules/goods/waitReturn";		
	}
	/*
	 * 商品待返还列表Grid
	 * */
	@ResponseBody
	@RequestMapping(value="waitReturnList")
	public String waitReturnList(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String, Object> map = new TrimMap(getParams(request));
		Page<Record> pages = new Page<Record>(request, response);
		Page<Record> page = goodsUsedRecordService.waitReturnList(pages, map,siteId);
		return renderJson(new JqGridPage<>(page));
	}
	
	/*
	 * 待返还商品-记录总数
	 * */
	@ResponseBody
	@RequestMapping(value="allCount")
	public Long allCount(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		return goodsUsedRecordService.allCount(siteId);
	}
	
	/*
	 * 商品返还-确认返还操作
	 * */
	@ResponseBody
	@RequestMapping(value="confirmInStocks")
	public Object confirmInStocks(HttpServletRequest request,HttpServletResponse response){
		String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String id = request.getParameter("id");
		String amount = request.getParameter("amount");
		String goodId = request.getParameter("goodId");
		return goodsUsedRecordService.confirmInStocks(id,amount,goodId,siteId);
	}
	
	/*
	 * 商品待返还-点击商品编号查看详情
	 * */
	@RequestMapping(value="todetail")
	public String toDetail(HttpServletRequest request,HttpServletResponse response,Model model){
		String id = request.getParameter("id");
		String goodId = request.getParameter("goodId");
		Record rd = goodsUsedRecordService.getDetailById(goodId);
		model.addAttribute("siteSelf", rd);
		model.addAttribute("returnGoods", goodsUsedRecordService.getDetailByIdReturn(id));
		return "modules/goods/waitReturnDetail";	
	}
	
	//导出公司库存数据
			@RequestMapping(value="export")
			public String exportfile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
				try {
					String formPath = request.getParameter("formPath");
					User user = UserUtils.getUser();
					String siteId= CrmUtils.getCurrentSiteId(user);
					Page<Record> pages = new Page<Record>(request, response);
					pages.setPageNo(1);
					pages.setPageSize(10000);
					Map<String,Object> map = getParams(request);
					SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
					JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
		            jarray.remove(0);
					String title = stf.getExcelTitle();
			        String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
			        List<Record> list = goodsUsedRecordService.waitReturnList(pages, map,siteId).getList();
					new ExportJqExcel(title+"数据", jarray.toString(), stf.getSortHeader())
						.setDataList(list).write(request, response, fileName).dispose();
					return null;
				} catch (Exception e) {
					e.printStackTrace();
					addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
				}
				return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
			}
}
