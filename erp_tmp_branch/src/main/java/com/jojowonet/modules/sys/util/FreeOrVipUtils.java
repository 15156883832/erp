package com.jojowonet.modules.sys.util;

import org.springframework.stereotype.Component;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

@Component
public class FreeOrVipUtils {
	public static String freeVip(){
		Record rd = Db.findFirst("select * from sys_dict a where a.type='charge_config'");
		return rd.getStr("value");
	}
}
