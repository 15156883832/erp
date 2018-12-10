package com.jojowonet.modules.order.adapters;

import com.jfinal.plugin.activerecord.DbPro;
import com.jfinal.plugin.activerecord.Record;

public class JBean {

    protected final Record record;

    public JBean(Record record) {
        this.record =  record;
    }

    public void set(String field, Object val) {
        this.record.set(field, val);
    }

    public <T> T get(String column) {
        return this.record.get(column);
    }

    public Record getRecord() {
        return record;
    }

    public boolean persist(String table, String primaryKey) {
        return DbPro.use().save(table, primaryKey, record);
    }

    public boolean update(String table, String primaryKey) {
        return DbPro.use().update(table, primaryKey, record);
    }
}
