package com.jojowonet.modules.fitting.service;

import com.jojowonet.modules.fitting.dao.MicroFactoryDao;
import com.jojowonet.modules.fitting.entity.MicroFactory;
import ivan.common.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MicroFactoryService extends BaseService {

    @Autowired
    MicroFactoryDao microFactoryDao;

    public MicroFactory findByName(String name) {
        return microFactoryDao.findByName(name);
    }
}
