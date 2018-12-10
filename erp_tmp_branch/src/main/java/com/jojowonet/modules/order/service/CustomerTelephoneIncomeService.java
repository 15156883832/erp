package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.CustomerTelephoneIncomeDao;
import com.jojowonet.modules.order.dao.SiteTeleDeviceDao;
import com.jojowonet.modules.order.entity.CustomerTelephoneIncome;
import ivan.common.service.BaseService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class CustomerTelephoneIncomeService extends BaseService {
    @Autowired
    CustomerTelephoneIncomeDao incomeDao;
    @Autowired
    SiteTeleDeviceDao siteTeleDeviceDao;

    private static final Logger logger = Logger.getLogger(CustomerTelephoneIncome.class);

    public void save(String tel, String serialNo) {
        Record boundDeviceRecord = siteTeleDeviceDao.findBySerialNo(serialNo);
        if (boundDeviceRecord == null) {
            logger.error(String.format("device is not bound, serialNo=%s, incoming tel=%s", serialNo, tel));
            return;
        }

        String siteId = boundDeviceRecord.getStr("site_id");
        CustomerTelephoneIncome income = new CustomerTelephoneIncome();
        income.setIncomeTime(new Date());
        income.setTelephone(tel);
        income.setSiteId(siteId);
        incomeDao.save(income);
    }
}
