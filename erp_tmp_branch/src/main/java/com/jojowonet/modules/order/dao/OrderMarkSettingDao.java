package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderMarkSetting;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class OrderMarkSettingDao extends BaseDao<OrderMarkSetting> {

    public void deleteByIds(List<String> ids) {
        if (ids.size() > 0) {
            SqlKit kit = new SqlKit()
                    .append("update crm_order_mark_settings")
                    .append("set status='1'")
                    .append("where id in(" + CrmUtils.joinInSql(ids) + ")");
            getSession().createSQLQuery(kit.toString()).executeUpdate();
        }
    }

    public void saveList(String[] names, String[] sorts) {
        if (names == null || sorts == null) {
            return;
        }

        if (names.length <= 0 || sorts.length <= 0) {
            return;
        }

        if (names.length != sorts.length) {
            return;
        }

        List<OrderMarkSetting> settings = new ArrayList<>();
        String userId = UserUtils.getUser().getId();
        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        for (int i = 0; i < names.length; i++) {
            OrderMarkSetting os = new OrderMarkSetting();
            os.setName(names[i]);
            String sort = sorts[i];
            os.setSort(StringUtil.isBlank(sort) ? null : Long.valueOf(sort));
            os.setCreateBy(userId);
            os.setSiteId(siteId);
            settings.add(os);
        }
        save(settings);
    }

    public Page<Record> getOrderMarkList(Page<Record> page, String siteId, Map<String, Object> map) {
        SqlKit kit = new SqlKit()
                .append("select id, name, sort, create_time")
                .append("from crm_order_mark_settings")
                .append("where site_id=? and status='0'")
                .append("order by sort asc, create_time desc")
                .last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());

        List<Record> records = Db.find(kit.toString(), siteId);
        page.setList(records);
        page.setCount(getCount(siteId));
        return page;
    }

    public long getCount(String siteId) {
        SqlKit kit = new SqlKit()
                .append("select count(1) as cnt")
                .append("from crm_order_mark_settings")
                .append("where site_id=? and status='0'");
        return Db.queryLong(kit.toString(), siteId);
    }

    @SuppressWarnings("unchecked")
    public List<OrderMarkSetting> getOrderMarksBySite(String siteId) {
        Query query = getSession().createQuery("from OrderMarkSetting where siteId=:sid and status=:status");
        query.setParameter("sid", siteId);
        query.setParameter("status", "0");
        return query.list();
    }
}
