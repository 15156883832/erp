package com.jojowonet.modules.sys.util;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import ivan.common.entity.mysql.common.User;
import org.apache.log4j.Logger;

public class BasePusher {

    private static Logger logger = Logger.getLogger(BasePusher.class);

    String getSenderId(User operator) {
        String senderId = operator.getId();
        if ("2".equals(operator.getUserType())) {
            Record site = Db.findFirst("select s.id from crm_site as s where s.user_id=? and s.status='0'", operator.getId());
            senderId = site.getStr("id");
        } else if ("3".equals(operator.getUserType())) {
            Record man = Db.findFirst("select id from crm_non_serviceman where user_id=? and status='0'", operator.getId());
            senderId = man.getStr("id");
        } else {
            logger.warn(String.format("invalid user type found: %s", operator.getUserType()));
        }
        return senderId;
    }

}
