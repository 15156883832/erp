package com.jojowonet.modules.sys.db;

import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.druid.DruidPlugin;
import ivan.common.config.Global;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import javax.sql.DataSource;

public class JFinalDb implements ApplicationContextAware {
    public JFinalDb() {
    }

    public void setApplicationContext(ApplicationContext ctx) throws BeansException {
        (new ActiveRecordPlugin(DbKit.MAIN_CONFIG_NAME, ctx.getBean(DataSource.class))).start();

        String url = Global.getConfig("jdbc.order400.url");
        String username = Global.getConfig("jdbc.order400.username");
        String password = Global.getConfig("jdbc.order400.password");
        DruidPlugin druid = new DruidPlugin(url, username, password);
        druid.start();
        ActiveRecordPlugin arp = new ActiveRecordPlugin(DbKey.DB_ORDER_400, druid);
        arp.setShowSql(true);
        arp.start();
    }
}
