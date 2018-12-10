package com.jojowonet.modules.fitting.dao;

import com.jojowonet.modules.fitting.entity.Fitting;
import com.jojowonet.modules.fitting.entity.FittingUsedRecord;
import com.jojowonet.modules.order.utils.CrmUtils;
import ivan.common.entity.mysql.common.User;
import ivan.common.persistence.BaseDao;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 备件DAO接口
 *
 * @author Ivan
 * @version 2017-05-20
 */
@Repository
public class FittingUsedRecordDao extends BaseDao<FittingUsedRecord> {

    /**
     * 工程师配件返还并入库
     */
    public void createReturnFittingUsedRecord(String empId, String empName, User user,String userName, Fitting fi, String siteId, double amount) {
        FittingUsedRecord fur = new FittingUsedRecord();
        fur.setFittingId(fi.getId());
        fur.setFittingCode(fi.getCode());
        fur.setFittingName(fi.getName());
        fur.setFittingVersion(fi.getVersion());
        fur.setBrand(fi.getSuitBrand());
        fur.setCategory(fi.getSuitCategory());
        fur.setSiteId(siteId);

        fur.setUsedNum(new BigDecimal(amount));
        fur.setStatus("2");//已核销
        fur.setConfirmor(CrmUtils.getUserXM());
        fur.setConfirmorId(user.getId());
        fur.setCheckTime(new Date());
        fur.setEmployeId(empId);
        fur.setUserName(empName);
        fur.setCreateBy(user.getId());
        fur.setCreator(userName);
        fur.setUsedTime(new Date());
        fur.setOldFittingFlag(fi.getRefundOldFlag());
        fur.setType("2");// 返还
        save(fur);
    }

    public void refuseHx(String fittingUsedRecordId) {
        FittingUsedRecord record = get(fittingUsedRecordId);
        record.setStatus("3");
        save(record);
    }

    /**
     * 工程师备件返还（保存操作）
     */
    public void createReturnFittingUsedRecordTwo(String empId, String empName, User user,String userName, Fitting fi, String siteId, double amount) {
        FittingUsedRecord fur = new FittingUsedRecord();
        fur.setFittingId(fi.getId());
        fur.setFittingCode(fi.getCode());
        fur.setFittingName(fi.getName());
        fur.setFittingVersion(fi.getVersion());
        fur.setBrand(fi.getSuitBrand());
        fur.setCategory(fi.getSuitCategory());
        fur.setSiteId(siteId);

        fur.setUsedNum(new BigDecimal(amount));
        fur.setStatus("1");// 待核销
        fur.setEmployeId(empId);
        fur.setUserName(empName);

        fur.setCreateBy(user.getId());
        fur.setCreator(userName);
        fur.setUsedTime(new Date());
        fur.setOldFittingFlag(fi.getRefundOldFlag());
        fur.setType("2");// 返还
        save(fur);
    }
}
