package com.jojowonet.modules.goods.service;

import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jojowonet.modules.goods.dao.GoodsSiteselfDetailDao;

@Component
@Transactional(readOnly = true)
public class GoodsSiteselfDetailService extends BaseService{

	@Autowired
	private GoodsSiteselfDetailDao goodsSiteselfDetailDao;
	
}
