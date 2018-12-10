package com.jojowonet.modules.operate.web;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.service.InvoiceAddressService;
import com.jojowonet.modules.finance.service.InvoiceApplicationService;
import com.jojowonet.modules.finance.service.InvoiceMsgService;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.service.SiteMsgService;
import com.jojowonet.modules.operate.service.SiteService;
import com.jojowonet.modules.order.utils.Apiutils;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.sys.util.FreeOrVipUtils;
import ivan.common.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @author yc
 * 服务商资料处理类
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/operate/getSiteMsg")
public class SiteMsgController {
	@Autowired
	private SiteMsgService siteMsgService;

	@Autowired
	private SiteService siteService;
	@Autowired
	private InvoiceMsgService invoiceMsgService;
	@Autowired
	private InvoiceAddressService invoiceAddressService;


	//查询服务商资料
	@RequestMapping(value = "site")
	public String getSiteMsg(Model model){
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String userId = UserUtils.getUser().getId();
		Record rd=siteMsgService.getSiteId(siteId);
		List<Record> provincelist=siteMsgService.getprovincelist();
		String adress=rd.getStr("province")+rd.getStr("city")+rd.getStr("area")+rd.getStr("address");
		List<Record> cities = siteMsgService.getCitiesByProvince(rd.getStr("province")); 
		List<Record> districts = siteMsgService.getDistrinctsProvince(rd.getStr("city")); 
		//将时间格式变为yyyy-mm-dd
		String createtime="";
		String createTime="";
		if(rd.getDate("create_time")!=null){
			createtime=rd.getDate("create_time").toString();
			createTime=createtime.substring(0,createtime.indexOf(" "));
		}
		String duetime="";
		String dueTime="";
		if(rd.getDate("due_time")!=null){
			duetime=rd.getDate("due_time").toString();
			dueTime=duetime.substring(0, duetime.indexOf(" "));
		}

		Record nowSite= Db.findFirst("select * from crm_site where id=? ",siteId);
		String siteType=nowSite.getStr("type");
		String parentSiteName="";
		if("2".equals(siteType)){
			List<Record> rds = siteService.getSiteParentList(siteId);
			//Record recorde=Db.findFirst("select parent_site_id from crm_site_parent_rel where  site_id=? and status='0' ",siteId);
			if(rds.size() >0){
				for(Record rda :rds) {
					String siteParent=rda.getStr("name");
					if(StringUtils.isNotBlank(parentSiteName) ) {
						parentSiteName = parentSiteName +"，"+ siteParent;
					}else {
						parentSiteName = siteParent;
					}
				}
			}

		}
		model.addAttribute("parentSiteName",parentSiteName);
		model.addAttribute("adress", adress);
		model.addAttribute("cities", cities);
		model.addAttribute("districts", districts);
		model.addAttribute("site", rd);
		String shareCode = rd.getStr("share_code");
		model.addAttribute("hasShareCode", StringUtils.isNotBlank(shareCode));
		model.addAttribute("share_code", shareCode);
		model.addAttribute("provincelist", provincelist);
		model.addAttribute("createTime", createTime);
		model.addAttribute("dueTime", dueTime);
		model.addAttribute("dict", FreeOrVipUtils.freeVip());
		Map<String, Object> levelMap = siteService.getSiteLevel(siteId);
		model.addAttribute("level", levelMap);
		Record invoiceMsg = invoiceMsgService.getInvoiceMsg(siteId,userId);
		Record invoiceAddress = invoiceAddressService.getInvoiceAddress(siteId,userId);
		model.addAttribute("invoiceMsg", invoiceMsg);
		model.addAttribute("invoiceAddress", invoiceAddress);
		return "modules/operate/siteMsg";
	}
	//修改服务商信息
	@RequestMapping(value="editeSite")	
	public String editeSite(String contacts,String telephone,String license_img,String province,String city,String area,String address ){
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		String adress=province+city+area+address;
		double[] dlnglat=Apiutils.addressToGPS(adress);//获得经纬度
		String lnglat=null;
		if(dlnglat!=null){
			String lng=dlnglat[0]+"";
			String lat=dlnglat[1]+"";
			lnglat=lng+","+lat;
		}
	siteMsgService.updateSite(siteId, contacts, province, city, area, telephone,address, license_img,lnglat);
		return null;
	}
	
	
	@RequestMapping(value="updatezfb")	
	public String updatezfb(String imgzfb){
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		siteMsgService.updateZfb(siteId, imgzfb);
		return null;
	
	}
	@RequestMapping(value="updatewx")	
	public String updatezwx(String imgwx){
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		siteMsgService.updateWx(siteId, imgwx);
		return null;
	
	}
	@ResponseBody
	@RequestMapping(value="getOrderTabCount")	
	public Object getOrderTabCount(HttpServletRequest request,HttpServletResponse response){
		String siteId= CrmUtils.getCurrentSiteId(UserUtils.getUser());
		Map<String,Long> map = siteService.getOrderTabCount(siteId);
		return  map;
		
	}
	
}

