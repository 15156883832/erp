package com.jojowonet.modules.order.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.OrderMarkSettingDao;
import com.jojowonet.modules.order.entity.OrderMarkSetting;
import com.jojowonet.modules.order.form.vo.OrderMark;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.sys.config.SfCacheKey;
import com.jojowonet.modules.sys.config.SfCacheService;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.UserUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author gaols
 */
@Service
@Transactional(readOnly = true)
public class OrderMarkSettingService extends BaseService {

    @Autowired
    private OrderMarkSettingDao orderMarkSettingDao;

    @Autowired
    SfCacheService sfCacheService;

    @Transactional
    public void deleteByIds(List<String> ids) {
        orderMarkSettingDao.deleteByIds(ids);

        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        sfCacheService.hdel(SfCacheKey.siteMarkSettingMap, siteId);
        sfCacheService.hdelDelay(SfCacheKey.siteMarkSettingMap, 2, siteId);
    }

    public Page<Record> getOrderMarkList(Page<Record> page, String siteId, Map<String, Object> map) {
        return orderMarkSettingDao.getOrderMarkList(page, siteId, map);
    }

    @Transactional
    public void saveList(String[] names, String[] sorts) {
        orderMarkSettingDao.saveList(names, sorts);

        String siteId = CrmUtils.getCurrentSiteId(UserUtils.getUser());
        sfCacheService.hdel(SfCacheKey.siteMarkSettingMap, siteId);
        sfCacheService.hdelDelay(SfCacheKey.siteMarkSettingMap, 2, siteId);
    }

    public OrderMarkSetting get(String id) {
        return orderMarkSettingDao.get(id);
    }

    public OrderMarkSetting edit(String id, String name, String sort) {
        if (StringUtil.isBlank(id) || StringUtil.isBlank(name)) {
            throw new RuntimeException("");
        }

        OrderMarkSetting setting = orderMarkSettingDao.get(id);
        setting.setName(name);
        setting.setSort(StringUtil.isBlank(sort) ? null : Long.valueOf(sort));
        orderMarkSettingDao.save(setting);

        sfCacheService.hdel(SfCacheKey.siteMarkSettingMap, setting.getSiteId());
        sfCacheService.hdelDelay(SfCacheKey.siteMarkSettingMap, 2, setting.getSiteId());
        return setting;
    }

    public List<OrderMarkSetting> getOrderMarksBySite(String siteId) {
        return orderMarkSettingDao.getOrderMarksBySite(siteId);
    }

    public List<Record> getSettingsBySiteId(String siteId) {
        List<Record> settings = getSettingsFromCacheBySiteId(siteId);
        if (settings != null) {
            return settings;
        }

        String sql = "select id,name from crm_order_mark_settings where site_id=? and status='0' order by sort asc";
        List<Record> ret = Db.find(sql, siteId);
        List<OrderMark> marks = new ArrayList<>();
        for (Record r : ret) {
            OrderMark mark = new OrderMark();
            mark.setId(r.getStr("id"));
            mark.setN(r.getStr("name"));
            marks.add(mark);
        }
        sfCacheService.hset(SfCacheKey.siteMarkSettingMap, siteId, new Gson().toJson(marks));
        return ret;
    }

    private List<Record> getSettingsFromCacheBySiteId(String siteId) {
        String json = sfCacheService.hget(SfCacheKey.siteMarkSettingMap, siteId);
        if (StringUtils.isBlank(json)) {
            return null;
        }

        List<OrderMark> marks = new Gson().fromJson(json, new TypeToken<List<OrderMark>>() {
        }.getType());
        List<Record> ret = new ArrayList<>();
        for (OrderMark mark : marks) {
            Record r = new Record();
            r.set("id", mark.getId());
            r.set("name", mark.getN());
            ret.add(r);
        }
        return ret;
    }

}
