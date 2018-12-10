package com.jojowonet.modules.sys.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.service.SiteService;

import ivan.common.web.BaseController;


/**
 * 不需要登录权限调用（移动设备调用）
 * @author ivan
 *
 */
@Controller
@RequestMapping(value = "unAuthCMobile")
public class UnAuthController extends BaseController{

	@Autowired
	private SiteService siteService;
	
	/**
     * 服务商营销方案二维码跳转验证
     * @param request
     * @return
     */
    @RequestMapping(value = "checkSiteCode")
    public String checkSiteCode(HttpServletRequest request){
    	Map<String, Object> params = getParams(request);
    	Record rd = (Record)siteService.getSiteCode(params);
    	if(rd != null){
    		//认证成功，则跳转到对应的路径地址
			Db.update("update crm_site_code as a set a.`clicks`=a.`clicks`+1 where a.`number`=? and a.status = '0'", params.get("number"));
			return "modules/operate/site/sitecode";
    	}
    	//认证失败则跳转到失败页面
    	return "modules/operate/site/invalidCode";
    }
}
