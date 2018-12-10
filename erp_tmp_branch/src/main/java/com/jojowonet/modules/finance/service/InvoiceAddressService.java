package com.jojowonet.modules.finance.service;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.finance.dao.InvoiceAddressDao;
import com.jojowonet.modules.finance.entity.InvoiceAddress;
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
 * 发票基本信息Service
 */
@Component
@Transactional(readOnly = true)
public class InvoiceAddressService extends BaseService{
    @Autowired
    private InvoiceAddressDao invoiceAddressDao;

    public Record getInvoiceAddress(String siteId, String userId){
         return invoiceAddressDao.getInvoiceAddress(siteId,userId);
    }

    //保存发票寄送地址信息
    public String saveInvoiceAddress(String siteId, String userId, Map <String, Object> map) {
        String flag = "";
        String invoiceAddressid = null;
        if (getInvoiceAddress(siteId, userId) != null) {
            invoiceAddressid = getInvoiceAddress(siteId, userId).getStr("id");
        }
        InvoiceAddress id = new InvoiceAddress();
        id.setSiteId(siteId);
        id.setUserId(userId);
        if (map != null) {
            if (map.get("receiverName") != null && StringUtils.isNotEmpty(((String[]) map.get("receiverName"))[0])) {
                id.setReceiverName(((String[]) map.get("receiverName"))[0]);
            } else {
                flag = "请填写收件人姓名";
                return flag;
            }
            if (map.get("receiverProvince") != null && StringUtils.isNotEmpty(((String[]) map.get("receiverProvince"))[0])) {
                id.setReceiverProvince(((String[]) map.get("receiverProvince"))[0]);
            } else {
                flag = "请选择省";
                return flag;
            }
            if (map.get("recevierCity") != null && StringUtils.isNotEmpty(((String[]) map.get("recevierCity"))[0])) {
                id.setRecevierCity(((String[]) map.get("recevierCity"))[0]);
            } else {
                flag = "请选择市";
                return flag;
            }
            if (map.get("receiverArea") != null && StringUtils.isNotEmpty(((String[]) map.get("receiverArea"))[0])) {
                id.setReceiverArea(((String[]) map.get("receiverArea"))[0]);
            } else {
                flag = "请选择区";
                return flag;
            }
            if (map.get("recevierAddress") != null && StringUtils.isNotEmpty(((String[]) map.get("recevierAddress"))[0])) {
                id.setRecevierAddress(((String[]) map.get("recevierAddress"))[0]);
            } else {
                flag = "请填写详细地址";
                return flag;
            }
            if (map.get("postcode") != null && StringUtils.isNotEmpty(((String[]) map.get("postcode"))[0])) {
                id.setPostcode(((String[]) map.get("postcode"))[0]);
            } else {
                flag = "请填写邮政编码";
                return flag;
            }
            if (map.get("recevierMobile") != null && StringUtils.isNotEmpty(((String[]) map.get("recevierMobile"))[0])) {
                id.setRecevierMobile(((String[]) map.get("recevierMobile"))[0]);
            } else {
                flag = "请填写收件人手机号";
                return flag;
            }
        } else {
            flag = "请填写相关信息";
            return flag;
        }
        if (StringUtil.isNotBlank(invoiceAddressid)) {//修改
            id.setId(invoiceAddressid);
            if (getInvoiceAddress(siteId, userId) != null) {
                Date idcreatetime = getInvoiceAddress(siteId, userId).getDate("create_time");
                id.setCreateTime(idcreatetime);
            }
            id.setUpdateTime(new Date());
            invoiceAddressDao.save(id);
            flag = "updateok";
            return flag;
        } else {//保存
            id.setCreateTime(new Date());
            invoiceAddressDao.save(id);
            flag = "saveok";
            return flag;
        }
    }
}
