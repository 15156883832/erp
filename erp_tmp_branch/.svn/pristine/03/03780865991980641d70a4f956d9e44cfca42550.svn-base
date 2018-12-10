package com.jojowonet.modules.sys.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.SiteDao;
import com.jojowonet.modules.operate.entity.Site;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.sys.entity.GiftPack;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import ivan.common.utils.UserUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 用户DAO接口
 *
 * @version 2013-8-23
 */
@Repository
public class GiftPackDao extends BaseDao<GiftPack> {

    @Autowired
    SiteDao siteDao;

    public Page<Record> getVipGiftPackList(Page<Record> page, String siteId, Map<String, Object> map) {
        SqlKit kit = new SqlKit()
                .append("select *")
                .append("from crm_gift_pack")
                .append("where take_site_id=? and idc=?")
                .append("order by create_time desc")
                .last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());

        List<Record> records = Db.find(kit.toString(), siteId, GiftPack.IDC.VIP.getVal());
        page.setList(records);
        page.setCount(getCount(siteId));
        return page;
    }

    public long getCount(String siteId) {
        SqlKit kit = new SqlKit()
                .append("select count(1) as cnt")
                .append("from crm_gift_pack")
                .append("where take_site_id=? and idc=?");
        return Db.queryLong(kit.toString(), siteId, GiftPack.IDC.VIP.getVal());
    }

    public Map<String, String> takeVipGift(String giftId) {
        GiftPack giftPack = get(giftId);
        User user = UserUtils.getUser();
        String siteId = CrmUtils.getCurrentSiteId(user);

        if (giftPack != null && giftPack.getTakeTime() == null) {
            if (!siteId.equals(giftPack.getTakeSiteId())) {
                return null;
            }

            SQLQuery sqlQuery = getSession().createSQLQuery("update crm_gift_pack set take_time=:tt,take_by=:takeby where take_time is null and id=:id");
            sqlQuery.setParameter("tt", new Date());
            sqlQuery.setParameter("takeby", user.getId());
            sqlQuery.setParameter("id", giftPack.getId());
            int updated = sqlQuery.executeUpdate();
            if (updated == 1) {
                Site site = siteDao.get(siteId);
                Date oldDueTime = site.getDueTime();
                if (oldDueTime == null || oldDueTime.before(new Date())) {
                    oldDueTime = new Date();
                }
                site.setDueTime(DateUtils.addMonths(oldDueTime, giftPack.getNum()));
                siteDao.save(site);
                Map<String, String> data = new HashMap<>();
                data.put("due", new SimpleDateFormat("yyyy-MM-dd").format(site.getDueTime()));
                data.put("gift", giftPack.getDescription());
                return data;
            }
        }
        return null;
    }

    public long giftAvailable(String siteId) {
        return Db.queryLong("select count(1) as cnt from crm_gift_pack where take_time is null and take_site_id=?", siteId);
    }

    public long allVipGiftCount(String siteId) {
        return Db.queryLong("select count(1) as cnt from crm_gift_pack where take_site_id=?", siteId);
    }
}
