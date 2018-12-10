package com.jojowonet.modules.fitting.service;

import com.jojowonet.modules.fitting.dao.FittingApplyPlanDao;
import com.jojowonet.modules.fitting.entity.FittingApplyPlan;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * 备件申请计划Service
 * @Author DQChen
 * @version 2018-01-29
 */
@Component
@Transactional(readOnly = true)
public class FittingApplyPlanService extends BaseService {
    @Autowired
    private FittingApplyPlanDao fittingApplyPlanDao;
}
