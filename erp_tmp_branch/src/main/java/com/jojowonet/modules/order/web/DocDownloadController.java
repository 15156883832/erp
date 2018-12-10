package com.jojowonet.modules.order.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ivan.common.web.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.service.DocSetService;

@Controller
@RequestMapping(value = "${adminPath}/docdownload")
public class DocDownloadController extends BaseController{
	@Autowired
	private DocSetService docSetService;
	@RequestMapping(value = "download")
	public String indexHelp(HttpServletRequest request,String a,HttpServletResponse response, Model model) {
		List<Record> list=docSetService.getDocListrecord();
         model.addAttribute("list", list);
		return "helpindex/" + "docdownload";
	}

}
