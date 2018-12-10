package com.jojowonet.modules.goods.web;

import ivan.common.entity.mysql.common.User;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.utils.HttpUtils;
import com.jojowonet.modules.goods.service.GoodsEmployeOwnService;
import com.jojowonet.modules.goods.utils.GoodsCategoryUtil;
import com.jojowonet.modules.order.service.UnitService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.sys.util.LogintHelper;

@Controller
@RequestMapping(value = "${adminPath}/goods/employeOwn")
public class GoodsEmployeOwnController extends BaseController {
	@Autowired
	private GoodsEmployeOwnService goodsEmployeOwnService;
	@Autowired
	private UnitService unitService;

	// 商品详情
	@RequestMapping(value = "showDetail")
	public Object showDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id = request.getParameter("id");
		String zNumber = CrmUtils.Spno();
		model.addAttribute("number", "SP" + zNumber);
		List<Record> listR = GoodsCategoryUtil.getSiteGoodsCategoryList(CrmUtils.getCurrentSiteId(UserUtils.getUser()));
		model.addAttribute("categoryList", listR);
		Record gss = goodsEmployeOwnService.showBJ(id);
		if (StringUtils.isNotEmpty(gss.getStr("imgs"))) {
			String[] str = gss.getStr("imgs").split(",");
			model.addAttribute("images", str);
			model.addAttribute("count", str.length);
		} else {
			model.addAttribute("count", 0);
		}
		model.addAttribute("siteSelf", gss);
		model.addAttribute("units", unitService.getUnitList());
		return "modules/goods/mygoodsTC/employeGoodsDetail";
	}

	@RequestMapping("alipayforward")
	public void alipayforward(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		new LogintHelper (resp).goSFHelper();
	}

}
