package com.jojowonet.modules.sys.util;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.FittingDao;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingUsedRecord;
import com.jojowonet.modules.operate.dao.EmployeDao;
import com.jojowonet.modules.operate.entity.Employe;
import com.jojowonet.modules.order.dao.PushMessageDao;
import com.jojowonet.modules.order.entity.PushMessage;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.entity.mysql.common.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Date;


/**
 * 通知工程师，核销不通过。
 */
@Component
public class HxRefusedPusher extends BasePusher {

    private final AppPusher appPusher;
    private PushMessageDao pushMessageDao;
    private EmployeDao employeDao;
    private FittingDao fittingDao;
    private static Logger logger = Logger.getLogger(HxRefusedPusher.class);

    @Autowired
    public HxRefusedPusher(AppPusher appPusher) {
        this.appPusher = appPusher;
    }

    public void notifyHxRefused(FittingUsedRecord usedRecord, User operator) {
        if (usedRecord == null) {
            return;
        }

        Fitting fitting = fittingDao.get(usedRecord.getFittingId());
        if (fitting == null) {
            logger.info("notify hx abort for fitting id not found: " + usedRecord.getFittingId());
            return;
        }

        String employeId = usedRecord.getEmployeId();
        if (StringUtil.isBlank(employeId)) {
            logger.info("notify hx abort for no emp id");
            return;
        }

        Employe employe = employeDao.get(employeId);
        if (employe == null) {
            logger.info("notify hx abort for no emp id");
            return;
        }

        User user = employe.getUser();
        if (user == null) {
            logger.info("notify hx abort for no emp id");
            return;
        }

        Record userRecord = Db.findFirst("select * from sys_user where id=? and status='0'", user.getId());
        if (userRecord == null) {
            logger.info("notify hx abort for no emp id");
            return;
        }

        BigDecimal usedNum = usedRecord.getUsedNum();
        if (usedNum == null) {
            logger.info("used num invalid, id=" + usedRecord.getId());
            return;
        }

        String unit = "个";
        if (StringUtil.isNotBlank(fitting.getUnit())) {
            unit = fitting.getUnit();
        }

        PushMessage pm = new PushMessage();
        pm.setAppType("1"); // 这个值是随便填的
        pm.setType("4");
        String title = "核销提醒";
        String content = String.format("您申请的%s%s%s备件（%s）核销未通过", usedNum.stripTrailingZeros(), unit, fitting.getName(), fitting.getCode());
        pm.setStatus("0");
        pm.setIsRead("0");
        pm.setRegId(userRecord.getStr("registration_id"));
        pm.setPushIds(userRecord.getStr("sf_regis_id"));
        pm.setTitle(title);
        pm.setTargetId(usedRecord.getId());
        pm.setContent(content);
        pm.setSendTime(new Date());
        pm.setSenderName(CrmUtils.getUserXM());
        pm.setSenderId(getSenderId(operator));
        pm.setSenderType(operator.getUserType());
        pm.setReceiverId(employe.getId());
        pm.setReceiverName(employe.getName());
        pm.setReceiverType("4");
        pm.setSiteId(usedRecord.getSiteId());

        appPusher.pushMsg(pm);
        pushMessageDao.save(pm);
    }

    @Autowired
    public void setPushMessageDao(PushMessageDao pushMessageDao) {
        this.pushMessageDao = pushMessageDao;
    }

    @Autowired
    public void setEmployeDao(EmployeDao employeDao) {
        this.employeDao = employeDao;
    }

    @Autowired
    public void setFittingDao(FittingDao fittingDao) {
        this.fittingDao = fittingDao;
    }
}
