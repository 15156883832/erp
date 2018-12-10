package com.jojowonet.modules.goods.dao;

import com.jojowonet.modules.goods.entity.GoodsPlatform;
import com.jojowonet.modules.goods.entity.GoodsPlatformDetail;
import com.jojowonet.modules.order.utils.CrmUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 平台商品出入库明细dao层
 */
@Repository
public class GoodsPlatFormDetailDao extends BaseDao<GoodsPlatformDetail> {

	public void createGoodsPlatFormDetail(GoodsPlatform good, BigDecimal num, String stockType, User user) {
		GoodsPlatformDetail d = new GoodsPlatformDetail();
		String uname = CrmUtils.getUserXM();
		d.setGoodId(good.getId());
		d.setGoodNumber(good.getNumber());
		d.setGoodName(good.getName());
		d.setGoodBrand(good.getBrand());
		d.setGoodModel(good.getModel());
		d.setGoodCategory(good.getCategory());
		d.setGoodType(good.getType());
		d.setUnit(good.getUnit());
		d.setType(stockType);
		d.setSitePrice(good.getSitePrice());
		d.setPlatformPrice(good.getPlatformPrice());
		d.setProfit(good.getProfit());
		d.setAmount(num);
		d.setConfirmor(uname);
		d.setEndStocks(good.getStocks().add(num));
		d.setConfirmTime(new Date());
		d.setCreator(user.getId());
		d.setCreateTime(new Date());
		d.setStatus("0");
		save(d);
	}
}
