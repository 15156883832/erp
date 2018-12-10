package com.jojowonet.modules.order.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.entity.OrderEvaluation;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.persistence.BaseDao;
import ivan.common.persistence.Page;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Repository;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Repository
public class OrderEvaluationDao extends BaseDao<OrderEvaluation> {

    public Page<Record> evaluationList(Page<Record> page, String siteId, Map<String, Object> map) {
        SqlKit kit = new SqlKit()
                .append("SELECT o.*,e.`name` as empName,c.* FROM `crm_order_evaluation` AS o")
                .append("INNER JOIN crm_employe AS e")
                .append("ON o.`employe_id`=e.`id`")
                .append("INNER JOIN crm_code AS c")
                .append("ON o.`code`=c.`code`")
                .append("WHERE e.site_id=?")
                .append(searchConditions(map))
                .append("ORDER BY o.`eval_time` desc")
                .append("LIMIT " + page.getPageSize() + " OFFSET " + (page.getPageNo() - 1) * page.getPageSize());
        page.setList(Db.find(kit.toString(), siteId));
        page.setCount(getCount(siteId, map));
        return page;
    }

    private String searchConditions(Map<String, Object> map) {
        SqlKit kit = new SqlKit();
        String eval = (String) map.get("serviceEval");
        if (StringUtil.isNotBlank(eval)) {
            kit.append("and o.service_eval='" + eval + "'");
        }
        String chargeCondition = (String) map.get("chargeCondition");
        if (StringUtil.isNotBlank(chargeCondition)) {
            kit.append("and o.charge_condition='" + chargeCondition + "'");
        }
        String employeId = (String) map.get("employeId");
        if (StringUtil.isNotBlank(employeId)) {
            kit.append("and o.employe_id='" + employeId + "'");
        }
        String createTimeMin = (String) map.get("createTimeMin");
        if (StringUtil.isNotBlank(createTimeMin)) {
            kit.append("and o.eval_time>='" + createTimeMin + "'");
        }
        String createTimeMax = (String) map.get("createTimeMax");
        if (StringUtil.isNotBlank(createTimeMax)) {
            try {
                Date date = DateUtils.parseDate(createTimeMax, "yyyy-MM-dd");
                String end = new SimpleDateFormat("yyyy-MM-dd").format(DateUtils.addDays(date, 1));
                kit.append("and o.eval_time>='" + end + "'");
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }
        return kit.toString();
    }

    private long getCount(String siteId, Map<String, Object> map) {
        SqlKit kit = new SqlKit()
                .append("SELECT count(1) as cnt FROM `crm_order_evaluation` AS o")
                .append("INNER JOIN crm_employe AS e")
                .append("ON o.`employe_id`=e.`id`")
                .append("INNER JOIN crm_code AS c")
                .append("ON o.`code`=c.`code`")
                .append(searchConditions(map))
                .append("WHERE e.site_id=?");
        return Db.queryLong(kit.toString(), siteId);
    }

}
