package com.jojowonet.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;




import ivan.common.web.BaseController;


@Controller
@RequestMapping(value = "${adminPath}/helpindex")
public class helpindexController extends BaseController{
	@RequestMapping(value = "indexHelp")
	public String indexHelp(HttpServletRequest request,String a,HttpServletResponse response, Model model) {
         model.addAttribute("para", a);
		return "helpindex/" + "indexHelp";
	}
	@RequestMapping(value = "hGdztsm")
	public String hGdztsm(HttpServletRequest request,
			HttpServletResponse response, Model model) {

		return "helpindex/" + "hGdztsm";
	}
	
	@RequestMapping(value = "help/{menus}")
	public String hGdxj(HttpServletRequest request,@PathVariable String menus,String a,HttpServletResponse response, Model model) {
		model.addAttribute("para", a);
		if("hGdxj".equals(menus)){
			return "helpindex/" + "hGdxj";
		}else if("hGddr".equals(menus)){
			return "helpindex/" + "hGddr";
		}else if("hGdpg".equals(menus)){
			return "helpindex/" + "hGdpg";
		}else if("hGdpdfk".equals(menus)){
			return "helpindex/" + "hGdpdfk";
		}else if("hGdhf".equals(menus)){
			return "helpindex/" + "hGdhf";
		}else if("hGddy".equals(menus)){
			return "helpindex/" + "hGddy";
		}else if("hBjrk".equals(menus)){
			return "helpindex/" + "hBjrk";
		}else if("hBjsqsh".equals(menus)){
			return "helpindex/" + "hBjsqsh";
		}else if("hBjsy".equals(menus)){
			return "helpindex/" + "hBjsy";
		}else if("hBjhx".equals(menus)){
			return "helpindex/" + "hBjhx";
		}else if("hBjdj".equals(menus)){
			return "helpindex/" + "hBjdj";
		}else if("hSptj".equals(menus)){
			return "helpindex/" + "hSptj";
		}else if("hSpxs".equals(menus)){
			return "helpindex/" + "hSpxs";
		}else if("hYytjyg".equals(menus)){
			return "helpindex/" + "hYytjyg";
		}else if("hYyfpqx".equals(menus)){
			return "helpindex/" + "hYyfpqx";
		}else if("hSzfwpl".equals(menus)){
			return "helpindex/" + "hSzfwpl";
		}else if("hSzfwpp".equals(menus)){
			return "helpindex/" + "hSzfwpp";
		}else if("hSzxxly".equals(menus)){
			return "helpindex/" + "hSzxxly";
		}else if("hSzxxtb".equals(menus)){
			return "helpindex/" + "hSzxxtb";
		}else if("hSzdx".equals(menus)){
			return "helpindex/" + "hSzdx";
		}else{
			return "helpindex/" + "indexHelp";
		}
		
		
	}

}
