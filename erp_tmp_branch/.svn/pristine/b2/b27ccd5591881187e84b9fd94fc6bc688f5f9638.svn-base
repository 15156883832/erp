package com.jojowonet.modules.goods.web;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.goods.dao.GoodsPlatFormDao;
import com.jojowonet.modules.goods.dao.GoodsPlatFormOrderDao;
import com.jojowonet.modules.goods.entity.GoodsPlatformOrder;
import com.jojowonet.modules.goods.service.GoodsPlatFormService;
import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.DateUtils;
import ivan.common.utils.UserUtils;
import ivan.common.utils.excel.ExportJqExcel;
import ivan.common.web.BaseController;

import java.math.BigDecimal;
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
import com.jojowonet.modules.goods.dao.GoodsPlatFormMjlOrderDao;
import com.jojowonet.modules.goods.entity.GoodsPlatFormMjlOrder;
import com.jojowonet.modules.goods.service.GoodsPlatFormMjlOrderService;
import com.jojowonet.modules.goods.utils.HttpUtils;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;

@Controller
@RequestMapping(value = "${adminPath}/goods/mjl")
public class GoodsPlatFormMjlOrderController extends BaseController {
	@Autowired
	private GoodsPlatFormMjlOrderService goodsPlatFormMjlOrderService;
	@Autowired
    private GoodsPlatFormMjlOrderDao goodsPlatFormMjlOrderDao;
	@Autowired
	private GoodsPlatFormOrderDao goodsPlatFormOrderDao;

	@RequestMapping(value="sysMjlOrder")
	public String getSysMjlOrderHeader(HttpServletRequest request,HttpServletResponse response,Model model){
		SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(null, request.getServletPath());
		 model.addAttribute("headerData", stf);
		return "modules/goods/mjlSysOrder";
	}
	
	@ResponseBody
	@RequestMapping(value="sysMjlGrid")
	public String sysMjlGrid(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = request.getParameterMap();
		Page<Record> pages = new Page<Record>(request,response);
		Page<Record> page = goodsPlatFormMjlOrderService.sysMjlGrid(pages,map);
		return renderJson(new JqGridPage<>(page));
	}
	
	@ResponseBody
	@RequestMapping(value="showOrderdetail")
	public Record showOrderdetail(String id,HttpServletRequest request,HttpServletResponse response){
		return goodsPlatFormMjlOrderService.showOrderdetail(id);
	}
	
	// 商品购买记录导出
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "exportsSys")
		public String exportFile1(HttpServletRequest request,
				HttpServletResponse response, RedirectAttributes redirectAttributes) {
			try {
				String formPath = request.getParameter("formPath");
				User user = UserUtils.getUser();
				String siteId = CrmUtils.getCurrentSiteId(user);
				Page<Record> pages = new Page<Record>(request, response);
				pages.setPageNo(1);
		        pages.setPageSize(10000);
		    	Map<String,Object> map = request.getParameterMap();
				SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
						siteId, formPath);
				String title = stf.getExcelTitle();
				String fileName = title + "数据"
						+ DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
				JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
				List<Record> list =  goodsPlatFormMjlOrderService.sysMjlGrid(pages,map).getList();
				if(list.size()>0){
					for(Record rd : list){
						if(rd.getStr("status")!=null){
							String status = rd.getStr("status");
							if(status.equals("0")){
								rd.set("status", "待审核 ");
							}else if(status.equals("1")){
								rd.set("status", "待出库");
							}else if(status.equals("2")){
								rd.set("status", "已完成");
							}else if(status.equals("3")){
								rd.set("status", "审核不通过");
							}else if(status.equals("4")){
								rd.set("status", "已取消");
							}else{
								rd.set("status", "---");
							}
						}
						if("0".equals(rd.getStr("payment_type"))){
							rd.set("payment_type", "微信");
						}else if("1".equals(rd.getStr("payment_type"))){
							rd.set("payment_type", "支付宝");
						}else{
							rd.set("payment_type", "---");
						}
						if("0".equals(rd.getStr("pay_status"))){
							rd.set("pay_status", "未支付");
						}else if("1".equals(rd.getStr("pay_status"))){
							rd.set("pay_status", "已支付");
						}else{
							rd.set("pay_status", "---");
						}
					}
				}
				new ExportJqExcel(title + "数据", jarray.toString(),
						stf.getSortHeader()).setDataList(list)
						.write(request, response, fileName).dispose();
				return null;
			} catch (Exception e) {
				e.printStackTrace();
				addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
			}
			return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
		}
		
		// 商品购买记录导出
				@SuppressWarnings("unchecked")
				@RequestMapping(value = "exportSupply")
				public String exportFile2(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) {
					try {
						String formPath = request.getParameter("formPath");
						User user = UserUtils.getUser();
						String siteId = CrmUtils.getCurrentSiteId(user);
						Page<Record> pages = new Page<Record>(request, response);
						pages.setPageNo(1);
				        pages.setPageSize(10000);
				    	Map<String,Object> map = request.getParameterMap();
						SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
								siteId, formPath);
						String title = stf.getExcelTitle();
						String fileName = title + "数据"
								+ DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
						JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
			            jarray.remove(0);
			            jarray.remove(0);
						List<Record> list =  goodsPlatFormMjlOrderService.supplyMjlGrid(pages,map).getList();
						if(list.size()>0){
							for(Record rd : list){
								if(rd.getStr("status")!=null){
									String status = rd.getStr("status");
									if(status.equals("0")){
										rd.set("status", "待审核 ");
									}else if(status.equals("1")){
										rd.set("status", "待出库");
									}else if(status.equals("2")){
										rd.set("status", "已完成");
									}else if(status.equals("3")){
										rd.set("status", "审核不通过");
									}else if(status.equals("4")){
										rd.set("status", "已取消");
									}else{
										rd.set("status", "---");
									}
								}
								if("0".equals(rd.getStr("payment_type"))){
									rd.set("payment_type", "微信");
								}else if("1".equals(rd.getStr("payment_type"))){
									rd.set("payment_type", "支付宝");
								}else{
									rd.set("payment_type", "---");
								}
							}
						}
						new ExportJqExcel(title + "数据", jarray.toString(),
								stf.getSortHeader()).setDataList(list)
								.write(request, response, fileName).dispose();
						return null;
					} catch (Exception e) {
						e.printStackTrace();
						addMessage(redirectAttributes, "导出数据失败！失败信息：" + e.getMessage());
					}
					return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
				}
			
		@RequestMapping(value="supplyMjlOrder")
		public String getSupplyMjlOrderHeader(HttpServletRequest request,HttpServletResponse response,Model model){
			SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(null, request.getServletPath());
			model.addAttribute("headerData", stf);
			return "modules/goods/mjlSupplyOrder";
		}
		
		@ResponseBody
		@RequestMapping(value="supplyMjlGrid")
		public String supplyMjlGrid(HttpServletRequest request,HttpServletResponse response){
			Map<String,Object> map = request.getParameterMap();
			Page<Record> pages = new Page<Record>(request,response);
			Page<Record> page = goodsPlatFormMjlOrderService.supplyMjlGrid(pages,map);
			return renderJson(new JqGridPage<>(page));
		}
		
		@ResponseBody
		@RequestMapping(value="pass")
		public String pass(HttpServletRequest request, HttpServletResponse response){
			String id = request.getParameter("id");
			return goodsPlatFormMjlOrderService.pass(id);
		}
		
		@ResponseBody
		@RequestMapping(value="noPass")
		public String noPass(HttpServletRequest request, HttpServletResponse response){
			String id = request.getParameter("noPassId");
			String reason = request.getParameter("reason");
			return goodsPlatFormMjlOrderService.noPass(id,reason);
		}
		
		@ResponseBody
		@RequestMapping(value="detail")
		public Record getDetailById(HttpServletRequest request, HttpServletResponse response){
			String id = request.getParameter("id");
			return goodsPlatFormMjlOrderService.getDetailById(id);
		}
		
		@ResponseBody
		@RequestMapping(value="outStockConfirm")
		public String outStockConfirm(HttpServletRequest request, HttpServletResponse response){
			String id = request.getParameter("id");
			String logisticsName = request.getParameter("logisticsName");
			String logisticsNo = request.getParameter("logisticsNo");
			String goodId = request.getParameter("goodId");
			return goodsPlatFormMjlOrderService.outStockConfirm(id,logisticsName,logisticsNo,goodId);
		}
  
   


    // 获取服务商商品出入库明细表头(商品购买记录)
    @RequestMapping(value = "list")
    public String list(HttpServletRequest request, Model model) {

        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(
                siteId, request.getServletPath());
        model.addAttribute("headerData", stf);
        return "modules/" + "goods/meiJieLiOrderDetail";
    }

    // 获取服务商购买的平台商品交易记录
    @RequestMapping(value = "getPlatfromGoodsRecord")
    public String getSiteFitKeepList(HttpServletRequest request,
                                     HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        Map<String, Object> map = getParams(request);
        String siteId = CrmUtils.getCurrentSiteId(user);
        Page<Record> pages = new Page<Record>(request, response);
        Page<Record> page = null;
        page = goodsPlatFormMjlOrderService.getPlatformGoodsRecord(pages, siteId, map);
        model.addAttribute("page",page);
		model.addAttribute("placeOrderMan",CrmUtils.getAllSiteManInfo(siteId));
		model.addAttribute("searchValues",map);
		return "modules/" + "goods/meiJieLiOrderDetail";
    }

	public List<Record> getAllSiteManInfo(String siteId){
		StringBuffer sb2=new StringBuffer();
		sb2.append(" SELECT u.id,a.name  FROM crm_site a INNER JOIN sys_user u ON a.user_id=u.id WHERE u.status='0' AND a.status='0' AND a.id=? ");
		return Db.find(sb2.toString(),siteId);
	}

    @ResponseBody
    @RequestMapping(value = "repeatConmit")
    public void repeatConmit(HttpServletRequest request, Model model){
        String id=request.getParameter("id");
        String num=request.getParameter("num");
        String customerName=request.getParameter("customerName");
        String customerMobile=request.getParameter("customerMobile");
        String address=request.getParameter("address");
        //String pingzheng=request.getParameter("pingzheng");
        GoodsPlatFormMjlOrder sf=goodsPlatFormMjlOrderDao.get(id);
        if(request.getParameter("icon")!=null && !"".equals(request.getParameter("icon"))){
            sf.setPayConfirm(request.getParameter("icon"));
        }
        sf.setPurchaseNum(BigDecimal.valueOf(Double.valueOf(num)));
        sf.setStatus("0");
        sf.setCustomerName(customerName);
        sf.setCustomerContact(customerMobile);
        sf.setCustomerAddress(address);
        goodsPlatFormMjlOrderDao.save(sf);
    }



    @ResponseBody
    @RequestMapping(value = "cancelOrder")
    public String cancelOrder(HttpServletRequest request, Model model){
        String id=request.getParameter("id");
        String result="ok";
        try {
            goodsPlatFormMjlOrderService.cancelOrder(id);
        }catch(Exception e){
            e.printStackTrace();
            result="fail";
        }finally {
            return result;
        }
    }

    //重新提交
    @RequestMapping(value = "continuePay")
    public String continuePay(HttpServletRequest request, Model model){
        String type=request.getParameter("type");
        String id=request.getParameter("id");
        model.addAttribute("type",type);
        model.addAttribute("orderDetail",goodsPlatFormMjlOrderDao.get(id));
        return "modules/" + "goods/ContinuePayFoundation";
    }
    /*
	 * 查看商品物流信息
	*/
    @RequestMapping(value = "logsitDetail")
    public String logsitDetail(HttpServletRequest request, Model model){
    	String id=request.getParameter("id");
    	GoodsPlatFormMjlOrder mjl = goodsPlatFormMjlOrderDao.get(id);
    	Map<String,String> map = HttpUtils.getLogistics(mjl.getLogisticsNo(), mjl.getLogisticsName());
		List<Map.Entry<String,String>> list = HttpUtils.sort(map); 
		model.addAttribute("type",3);
		model.addAttribute("list",list);
    	model.addAttribute("orderDetail",mjl);
    	return "modules/" + "goods/ContinuePayFoundation";
    }

    /*
	 * 查看商品物流信息
	*/
    @RequestMapping(value = "logsitDetailforPlat")
    public String logsitDetailforPlat(HttpServletRequest request, Model model){
    	String id=request.getParameter("id");
    	GoodsPlatformOrder platformOrder = goodsPlatFormOrderDao.get(id);
    	Map<String,String> map = HttpUtils.getLogistics(platformOrder.getLogisticsNo(), platformOrder.getLogisticsName());
		List<Map.Entry<String,String>> list = HttpUtils.sort(map);
		model.addAttribute("type",3);
		model.addAttribute("list",list);
    	model.addAttribute("orderDetail",platformOrder);
    	return "modules/" + "goods/ContinuePayFoundation";
    }

    @RequestMapping(value="exports")
    public String exports(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String formPath = request.getParameter("formPath");
            User user = UserUtils.getUser();
            String siteId= CrmUtils.getCurrentSiteId(user);
            Map<String,Object> map = request.getParameterMap();
            SiteTableHeaderForm stf = JqGridTableUtils.getCustomizedTableHead(siteId, formPath);
            String title = stf.getExcelTitle();
            String fileName = title+"数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Record> pages = new Page<Record>(request, response);
            pages.setPageNo(1);
            pages.setPageSize(10000);
            JSONArray jarray = JSONArray.fromObject(stf.getTableHeader());
            Page<Record> page = goodsPlatFormMjlOrderService.nandaoGrid(pages,map);
            List<Record> list =page.getList();
            for(Record rd : list){
                if("0".equals(rd.getStr("status"))){
                    rd.set("status", "待审核");
                    rd.set("sendgood_time", "");
                }else  if("1".equals(rd.getStr("status"))){
                    rd.set("status", "待出库");
                    rd.set("sendgood_time", "");
                }else  if("2".equals(rd.getStr("status"))){
                    rd.set("status", "已完成");
                    rd.set("sendgood_time", rd.getDate("sendgood_time"));
                }else  if("3".equals(rd.getStr("status"))){
                    rd.set("status", "审核未通过");
                    rd.set("sendgood_time",rd.getDate("no_pass_time"));
                }else  if("4".equals(rd.getStr("status"))){
                    rd.set("status", "已取消");
                    rd.set("sendgood_time", rd.getDate("no_pass_time"));
                }else{
                    rd.set("status", "---");
                    rd.set("sendgood_time", "");
                }
                rd.set("address",rd.getStr("customer_address"));
            }
            jarray.remove(0);
            jarray.remove(0);
            new ExportJqExcel(title+"数据",  jarray.toString(), stf.getSortHeader())
                    .setDataList(list).write(request, response, fileName).dispose();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "导出数据失败！失败信息："+e.getMessage());
        }
        return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
    }

}
