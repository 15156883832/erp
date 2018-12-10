/**
 */
package com.jojowonet.modules.order.dao;

import java.util.List;

import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;

import org.springframework.stereotype.Repository;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderOrigin;
import com.jojowonet.modules.order.utils.SqlKit;

/**
 * 来源DAO接口
 *
 * @author Ivan
 * @version 2017-05-04
 */
@Repository
public class OrderOriginDao extends BaseDao<OrderOrigin> {

    public List<Record> filterOrderOrigin(String siteId, Page<Record> page) {
        SqlKit kit = new SqlKit().append(" SELECT * FROM crm_site_order_origin WHERE site_id=? and status='0' ORDER BY sort ASC ");
        if (page != null) {
            kit.last("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
        }
        return Db.find(kit.toString(), siteId);
    }

    public Record getOrderOriginById(String id, String siteId) {
        String sql = "SELECT * FROM crm_site_order_origin WHERE site_id=?  AND id=? ";
        return Db.findFirst(sql, siteId, id);
    }

    public void updates(String name, String sort, String id) {
        String sql = "UPDATE crm_site_order_origin SET name=? ,sort=? WHERE id=?";
        Db.update(sql, name, sort, id);
    }
}
