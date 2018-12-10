package com.jojowonet.modules.order.service;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SmsService {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional(rollbackFor = Exception.class)
    public void consumeSms(int count, String siteId) {
        if (count <= 0) {
            throw new IllegalArgumentException("consumed sms should gt 1, site_id=" + siteId);
        }

        Session session = sessionFactory.getCurrentSession();
//        SQLQuery sqlQuery = session.createSQLQuery("update crm_site a set a.sms_available_amount=a.sms_available_amount-:cnt where a.status='0' and a.id=:id and a.sms_available_amount>=:cnt1");
        SQLQuery sqlQuery = session.createSQLQuery("update crm_site a set a.sms_available_amount=a.sms_available_amount-:cnt where a.status='0' and a.id=:id");
        sqlQuery.setParameter("cnt", count);
        sqlQuery.setParameter("id", siteId);
        sqlQuery.executeUpdate();
//        int update = sqlQuery.executeUpdate();
//        if (update <= 0) {
//            throw new IllegalStateException(String.format("sms not enough,request count=%d,site_id=%s", count, siteId));
//        }
    }

}
