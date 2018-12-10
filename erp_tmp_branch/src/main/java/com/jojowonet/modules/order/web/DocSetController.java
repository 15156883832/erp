package com.jojowonet.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.persistence.JqGridPage;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;






import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.DocSet;
import com.jojowonet.modules.order.form.SiteTableHeaderForm;
import com.jojowonet.modules.order.service.DocSetService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.JqGridTableUtils;


@Controller
@RequestMapping(value = "${adminPath}/order/docupload")
public class DocSetController extends BaseController{
	@Autowired
	private DocSetService docSetService;

	
	@RequestMapping(value="set")
	public String getDocList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String siteId=CrmUtils.getCurrentSiteId(UserUtils.getUser());
		SiteTableHeaderForm stf=JqGridTableUtils.getCustomizedTableHead(siteId, request.getServletPath());
		model.addAttribute("headerData", stf);
		return "modules/" + "order/docupload/docSetList";
	}
	
	@RequestMapping(value="getdocsetlist")
	@ResponseBody
	public String getDocSetList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		Page<Record> page = new Page<>(request, response);
		model.addAttribute("page", page);
		page=docSetService.getDocList(page);
		JqGridPage<Record> jqp = new JqGridPage<>(page);
		return renderJson(jqp);
	}
	@RequestMapping(value="save")
	@ResponseBody
	public String save(HttpServletRequest request,
			HttpServletResponse response,String name,String doctype,String icon,String description,String realdocpath,String filesize){
       return docSetService.save(name,doctype,description,realdocpath,icon,filesize);
	}
	//删除文档
		@RequestMapping(value = "delete")
		@ResponseBody
		public String delete(HttpServletRequest request,HttpServletResponse response, String[] idArr) {
			String resulte="";
			Integer rows=0;
			for(int i=0;i<idArr.length;i++){
				docSetService.deletedoc(idArr[i]);
				rows++;
			}
			if(rows==idArr.length){
				resulte="ok";
			}
			return resulte;
		}

}
