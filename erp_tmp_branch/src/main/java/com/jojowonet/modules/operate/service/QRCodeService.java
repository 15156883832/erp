package com.jojowonet.modules.operate.service;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.operate.dao.QRCodeDao;
import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;
import ivan.common.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by cdq on 2017/10/21
 */
@Component
@Transactional(readOnly = true)
public class QRCodeService extends BaseService {

    @Autowired
    private QRCodeDao qrCodeDao;

    public Page<Record> getQRCodeList(Page<Record> page, Map<String, Object> map) {
        List<Record> list = qrCodeDao.getQRcodeList(page,map);
        long count=qrCodeDao.getQRCodeCount(map);
        page.setList(list);
        page.setCount(count);
        return page;
    }

    @Transactional
    public String createCode(String siteId,int num,String date){
        String sql="SELECT sequence  FROM  crm_code WHERE site_id='"+siteId+"' AND STATUS IN ('0','1') order by sequence desc ";
        Record re=Db.findFirst(sql);
        int maxSequence=0;
        if(re!=null){
            maxSequence=re.getInt("sequence");//当前服务商二维码的最大序号
        }

        List<String> sqlstr= Lists.newArrayList();
        String result="1";
        for(int i=0;i<num;i++){
            sqlstr.add("insert into crm_code(id,sequence,code,create_time,create_by,site_id) value('"+ IdGen.uuid()+"','"+(maxSequence+i+1)+"','"+IdGen.uuid()+"','"+date+"','"+siteId+"','"+siteId+"') ");
        }
        try {
            Db.batch(sqlstr,sqlstr.size());
        } catch (Exception e) {
            e.printStackTrace();
            result="2";
        }finally {
            return result;
        }
    }

    public Page<Record> getQRCodeUsedList(Page<Record> page, Map<String, Object> map,String siteId) {
        List<Record> list = qrCodeDao.getQRCodeUnitOrder(page,map,siteId);
        long count=qrCodeDao.getUsedCount(map,siteId);
        page.setList(list);
        page.setCount(count);
        return page;
    }

    public List<Record> getExportData(Page<Record> page,Map<String,Object> map,String siteId){
        return qrCodeDao.getQRCodeUnitOrderData(page,map,siteId);
    }

    public List<Record> getExportSysData(Page<Record> page,Map<String,Object> map){
        return qrCodeDao.getSysQRCodeUnitOrderData(page,map);
    }

}
