/**
 */
package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.SiteTeleDevice;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

/**
 * 网点电话设备记录表。
 *
 * @author Gaols
 * @version 2016-08-01
 */
@Repository
public class SiteTeleDeviceDao extends BaseDao<SiteTeleDevice> {

    public Record findBySerialNo(String serialNo) {
        return Db.findFirst("select * from crm_site_tele_device where serial_no=? and `status`= '0' limit 1", serialNo);
    }
}
