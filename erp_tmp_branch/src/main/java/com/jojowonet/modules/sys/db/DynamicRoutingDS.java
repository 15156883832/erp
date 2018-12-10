package com.jojowonet.modules.sys.db;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicRoutingDS extends AbstractRoutingDataSource {

    private static final String DB_ERP ="";

    @Override
    protected Object determineCurrentLookupKey() {
        return DynamicDSContextHolder.getDataSourceKey();
    }

    public void switchDS(String key) {
        DynamicDSContextHolder.setDataSourceKey(key);
    }
}
