package com.jojowonet.modules.goods.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.goods.entity.GoodsPlatformOrderNandao;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public class GoodsPlatformOrderNandaoDao extends BaseDao<GoodsPlatformOrderNandao> {

	public Record getorderByid(String id) {
       String sql="select * from crm_goods_platform_transfer_order where id='"+id+"'";
		return Db.findFirst(sql);
	}

	public String getsitename(String siteid) {
		String sql="select name from crm_site where id='"+siteid+"'";
		return Db.queryStr(sql);
	}

}
