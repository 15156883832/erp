package com.jojowonet.modules.order.utils.caches;


import com.jojowonet.modules.order.service.SiteOrderMapService;
import com.jojowonet.modules.order.utils.SimpleCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SiteOrderMapCache extends SimpleCache<String> {
    @Autowired
    SiteOrderMapService siteOrderMapService;

    @Override
    protected String getCacheObject(String key) {
        return siteOrderMapService.getSiteOrderSuffix(key);
    }

    @Override
    protected int expireHour() {
        return 4;
    }

    @Override
    protected int cacheSize() {
        return 500;
    }

}
