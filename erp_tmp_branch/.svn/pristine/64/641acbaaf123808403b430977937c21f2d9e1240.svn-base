package com.jojowonet.modules.fitting.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fitting.dao.SiteFittingKeepDao;
import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.SiteFittingKeep;
import com.jojowonet.modules.fitting.utils.vo.FittingKeepInfo;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.sys.util.GuardUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 备件Service
 *
 * @version 2017-05-20
 */
@Component
@Transactional(readOnly = true)
public class SiteFittingKeepService extends BaseService {

//    类型：0入库，1出库，2归还 3库存调整 4服务商零售
    public static final String TYPE_STOCK_IN = "0";
    public static final String TYPE_STOCK_OUT = "1";
    public static final String TYPE_RETURN = "2";
    public static final String TYPE_STOCK_ADJUSTMENT = "3";
    public static final String TYPE_STOCK_SALE = "4";

    @Autowired
    private SiteFittingKeepDao siteFittingKeepDao;

    public SiteFittingKeep get(String id) {
        return siteFittingKeepDao.get(id);
    }

    public Page<SiteFittingKeep> find(Page<SiteFittingKeep> page, SiteFittingKeep siteFittingKeep) {
        DetachedCriteria dc = siteFittingKeepDao.createDetachedCriteria();
        if (StringUtils.isNotEmpty(siteFittingKeep.getId())) {
            dc.add(Restrictions.eq("id", siteFittingKeep.getId()));
        }
        dc.add(Restrictions.eq("status", "1"));

        return siteFittingKeepDao.find(page, dc);
    }

    //pages,siteId,"1"
    public Page<Record> getSiteFittingKeep(Page<Record> page, String siteId, Map<String, Object> map) {
        List<Record> list = siteFittingKeepDao.getListOfSiteFittingKeep2(page, siteId, map);
        long count = siteFittingKeepDao.getCountOfSiteFittingKeep(page, siteId, map);
        page.setList(list);
        page.setCount(count);
        return page;
    }
    
    public Page<Record> getSiteFittingKeepForExport(Page<Record> page, String siteId, Map<String, Object> map) {
    	List<Record> list = siteFittingKeepDao.getListOfSiteFittingKeep2(page, siteId, map);
    	long count = siteFittingKeepDao.getCountOfSiteFittingKeep(page, siteId, map);
    	page.setList(list);
    	page.setCount(count);
    	return page;
    }

    public void save(SiteFittingKeep sfk) {
        siteFittingKeepDao.save(sfk);
    }

    @Transactional
    public void createSiteFittingKeep(Fitting fitting,String remarks ,FittingKeepInfo keepInfo, User user) {
        GuardUtils.in(new String[]{"0", "1", "2", "3", "4"}, keepInfo.getType(), String.format("invalid fitting keep type found: %s", keepInfo.getType()));
        GuardUtils.notNull(user, "user required");
        GuardUtils.notBlank(fitting.getSiteId(), "fitting belonging site required");
        GuardUtils.notBlank(keepInfo.getApplicant(), "applicant required");
        GuardUtils.notBlank(keepInfo.getConfirmor(), "confirmor required");

        SiteFittingKeep fittingKeep = new SiteFittingKeep();
        fittingKeep.setFittingId(fitting.getId());
        fittingKeep.setNumber(CrmUtils.no());//用时间生成备件编号
        fittingKeep.setFittingCode(fitting.getCode());//备件条码
        fittingKeep.setFittingName(fitting.getName());//备件名称
        fittingKeep.setAmount(keepInfo.getAmount());//数量
        fittingKeep.setPrice(keepInfo.getPrice());//入库价格
        if (fitting.getEmployePrice() != null) {
            fittingKeep.setEmployePrice(fitting.getEmployePrice());//工程师价格
        }
        if (fitting.getCustomerPrice() != null) {
            fittingKeep.setCustomerPrice(fitting.getCustomerPrice());//零售价格
        }
        fittingKeep.setApplicant(keepInfo.getApplicant());
        fittingKeep.setConfirmor(keepInfo.getConfirmor());
        fittingKeep.setCreateBy(user.getId());//创建人user_id
        fittingKeep.setSiteId(fitting.getSiteId());            //服务商id
        fittingKeep.setRemarks(remarks);
        save(fittingKeep);
    }

    /*备件申请中入库*/
    @Transactional
    public String createSiteFittingKeepTwo(Fitting fitting, FittingKeepInfo keepInfo, User user) {
        GuardUtils.in(new String[]{"0", "1", "2", "3", "4"}, keepInfo.getType(), String.format("invalid fitting keep type found: %s", keepInfo.getType()));
        GuardUtils.notNull(user, "user required");
        GuardUtils.notBlank(fitting.getSiteId(), "fitting belonging site required");
        GuardUtils.notBlank(keepInfo.getApplicant(), "applicant required");
        GuardUtils.notBlank(keepInfo.getConfirmor(), "confirmor required");

        SiteFittingKeep fittingKeep = new SiteFittingKeep();
        fittingKeep.setFittingId(fitting.getId());
        fittingKeep.setNumber(CrmUtils.no());//用时间生成备件编号
        fittingKeep.setFittingCode(fitting.getCode());//备件条码
        fittingKeep.setFittingName(fitting.getName());//备件名称
        fittingKeep.setAmount(keepInfo.getAmount());//数量
        fittingKeep.setPrice(keepInfo.getPrice());//入库价格
        if (fitting.getEmployePrice() != null) {
            fittingKeep.setEmployePrice(fitting.getEmployePrice());//工程师价格
        }
        if (fitting.getCustomerPrice() != null) {
            fittingKeep.setCustomerPrice(fitting.getCustomerPrice());//零售价格
        }
        fittingKeep.setApplicant(keepInfo.getApplicant());
        fittingKeep.setConfirmor(keepInfo.getConfirmor());
        fittingKeep.setCreateBy(user.getId());//创建人user_id
        fittingKeep.setSiteId(fitting.getSiteId());            //服务商id
        save(fittingKeep);
        siteFittingKeepDao.getSession().flush();
        return fittingKeep.getId();
    }

    /**
     * 工程师配件返还时，生成网点出入库明细。
     */
    public void createReturnFittingKeep(User user, Fitting fitting, String empName, double amount) {
        SiteFittingKeep sfkp = new SiteFittingKeep();
        sfkp.setType("2"); // 返还
        sfkp.setNumber(CrmUtils.no());
        sfkp.setFittingId(fitting.getId());
        sfkp.setFittingCode(fitting.getCode());
        sfkp.setFittingName(fitting.getName());
        sfkp.setAmount(amount);
        sfkp.setPrice(fitting.getSitePrice());
        if (fitting.getEmployePrice() != null) {
            sfkp.setEmployePrice(fitting.getEmployePrice());
        }
        if (fitting.getCustomerPrice() != null) {
            sfkp.setCustomerPrice(fitting.getCustomerPrice());
        }
        sfkp.setSiteId(fitting.getSiteId());
        sfkp.setCreateBy(user.getId());
        sfkp.setApplicant(empName);
        sfkp.setConfirmor(CrmUtils.getUserXM());
        save(sfkp);
    }
    public void updateFittingKeepById(String fiId,String remarks) {
    	siteFittingKeepDao.updateFittingKeepById(fiId, remarks);
    }
    public void updateFittingKeep(String ids) {
    	siteFittingKeepDao.updateFittingKeep(ids);
    }

}
