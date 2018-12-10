package com.jojowonet.modules.finance.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.dao.InvoiceMsgDao;
import com.jojowonet.modules.finance.entity.InvoiceMsg;
import com.jojowonet.modules.order.utils.StringUtil;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/29.
 * 发票基本信息管理service
 */
@Component
@Transactional(readOnly = true)
public class InvoiceMsgService extends BaseService {
    @Autowired
    private InvoiceMsgDao invoiceMsgDao;

    public Record getInvoiceMsg(String siteId,String userId){
        return invoiceMsgDao.getInvoicemsg(siteId,userId);
    }

    public String saveInvoiceMsg(String siteId, String userId, Map <String, Object> map) {
        String flag = "";
        String invoicemsgid = null;
        if (getInvoiceMsg(siteId, userId) != null) {
            invoicemsgid = getInvoiceMsg(siteId, userId).getStr("id");
        }
        InvoiceMsg im = new InvoiceMsg();
        im.setSiteId(siteId);
        im.setUserId(userId);
        if (map != null) {
            if (map.get("MakeIvtype") != null && StringUtils.isNotEmpty(((String[]) map.get("MakeIvtype"))[0])) {
                if ("0".equals(((String[]) map.get("MakeIvtype"))[0])) {
                    im.setMakeIvtype(((String[]) map.get("MakeIvtype"))[0]);
                    if (map.get("invoiceTitle") != null && StringUtils.isNotEmpty(((String[]) map.get("invoiceTitle"))[0])) {
                        im.setInvoiceTitle(((String[]) map.get("invoiceTitle"))[0]);
                    } else {
                        flag = "请填写发票抬头";
                        return flag;
                    }
                    if (map.get("invoiceType") != null && StringUtils.isNotEmpty(((String[]) map.get("invoiceType"))[0])) {
                        im.setInvoiceType(((String[]) map.get("invoiceType"))[0]);
                    } else {
                        flag = "请选择发票类型";
                        return flag;
                    }
                } else {
                    im.setMakeIvtype(((String[]) map.get("MakeIvtype"))[0]);
                    if (map.get("invoiceTitle") != null && StringUtils.isNotEmpty(((String[]) map.get("invoiceTitle"))[0])) {
                        im.setInvoiceTitle(((String[]) map.get("invoiceTitle"))[0]);
                    } else {
                        flag = "请填写发票抬头";
                        return flag;
                    }
                    if (map.get("invoiceType") != null && StringUtils.isNotEmpty(((String[]) map.get("invoiceType"))[0])) {
                        im.setInvoiceType(((String[]) map.get("invoiceType"))[0]);
                    } else {
                        flag = "请选择发票类型";
                        return flag;
                    }
                    if (map.get("taxRegistrationNumber") != null && StringUtils.isNotEmpty(((String[]) map.get("taxRegistrationNumber"))[0])) {
                        im.setTaxRegistrationNumber(((String[]) map.get("taxRegistrationNumber"))[0]);
                    } else {
                        flag = "请填写税务登记证号";
                        return flag;
                    }
                    if (map.get("address") != null && StringUtils.isNotEmpty(((String[]) map.get("address"))[0])) {
                        im.setAddress(((String[]) map.get("address"))[0]);
                    } else {
                        flag = "请填写企业地址";
                        return flag;
                    }
                    if (map.get("mobile") != null && StringUtils.isNotEmpty(((String[]) map.get("mobile"))[0])) {
                        im.setMobile(((String[]) map.get("mobile"))[0]);
                    } else {
                        flag = "请填写联系电话";
                        return flag;
                    }
                    if (map.get("bankOfDeposit") != null && StringUtils.isNotEmpty(((String[]) map.get("bankOfDeposit"))[0])) {
                        im.setBankOfDeposit(((String[]) map.get("bankOfDeposit"))[0]);
                    } else {
                        flag = "请填写基本开户银行";
                        return flag;
                    }
                    if (map.get("openAccount") != null && StringUtils.isNotEmpty(((String[]) map.get("openAccount"))[0])) {
                        im.setOpenAccount(((String[]) map.get("openAccount"))[0]);
                    } else {
                        flag = "请填写基本开户账号";
                        return flag;
                    }

                    if("1".equals(im.getInvoiceType())){
                        if (map.get("icon") != null && StringUtils.isNotEmpty(((String[]) map.get("icon"))[0])) {
                            im.setIcon(((String[]) map.get("icon"))[0]);
                        } else {
                            flag = "请上传一般纳税人资格登记图片";
                            return flag;
                        }
                    }

                }
            } else {
                flag = "请选择开票类型";
                return flag;
            }
        } else {
            flag = "请填写相关信息";
            return flag;
        }
        if (StringUtil.isNotBlank(invoicemsgid)) {//更新
            im.setId(invoicemsgid);
            if (getInvoiceMsg(siteId, userId) != null) {
                Date imcreateTime = getInvoiceMsg(siteId, userId).getDate("create_time");
                im.setCreateTime(imcreateTime);
            }
            im.setUpdateTime(new Date());
            invoiceMsgDao.save(im);
            flag = "updateok";
            return flag;
        } else {//添加
            invoiceMsgDao.save(im);
            flag = "saveok";
            return flag;
        }
    }
}
