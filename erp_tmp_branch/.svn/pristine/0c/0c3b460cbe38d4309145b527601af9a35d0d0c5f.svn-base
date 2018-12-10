package com.jojowonet.modules.sys.config;

import ivan.common.utils.SpringContextHolder;

public class SFCacheServiceHelper {

    private static volatile SfCacheService service;

    public static SfCacheService getSFCacheService() {
        if (service == null) {
            service = SpringContextHolder.getBean(SfCacheService.class);
        }
        return service;
    }

}
