package com.jojowonet.modules.order.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.OrderEvaluationDao;
import com.jojowonet.modules.order.entity.OrderEvaluation;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Component
@Transactional(readOnly = true)
public class OrderEvaluationService extends BaseService {

    @Autowired
    private OrderEvaluationDao orderEvaluationDao;

    public OrderEvaluation get(String id) {
        return orderEvaluationDao.get(id);
    }

    public Page<Record> evaluationList(Page<Record> page, String siteId, Map<String, Object> map) {
        return orderEvaluationDao.evaluationList(page, siteId, map);
    }
}
