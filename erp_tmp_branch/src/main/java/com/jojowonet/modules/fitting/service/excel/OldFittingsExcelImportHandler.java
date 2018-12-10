package com.jojowonet.modules.fitting.service.excel;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.fmss.utils.DbBatchBean;
import com.jojowonet.modules.fmss.utils.DbBatchItem;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.excelExt.handler.ExcelAbstractHandler;
import ivan.common.utils.IdGen;
import org.apache.commons.lang.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by cdq on 2017/8/24 0024.
 */
public class OldFittingsExcelImportHandler extends ExcelAbstractHandler {


    public String insertFittingSql = getFittngSql();
    public String insertFittingKeepSql = getFittngKeepSql();
    public String updateFittingSql = getUpdateFittingSql();


    public Map<String, FittingExcelBean> fittingCodeMap = Maps.newHashMap();

    /**
     * 如果返回false，则表示终止继续遍历Excel,截至到当前的行数
     */
    @SuppressWarnings("unchecked")
    @Override
    public Boolean handler(Map<String, Object> rowData, int rowIndex) {

        //该List中包含了明细表记录
        List<FittingExcelBean> fittings = (List<FittingExcelBean>) getHandlerResult();
        if(fittings == null || fittings.size() == 0){
            fittings = Lists.newArrayList();
            setHandlerResult(fittings);
        }

        String fittingCode = String.valueOf(rowData.get("1"));//备件的条码
        boolean isValid = checkRowData(rowData);//检查Excel的必输选项是否为空!!

        if(isValid && !fittingCodeMap.containsKey(fittingCode)){//验证成功，可以插入数据库
            FittingExcelBean feb = new FittingExcelBean();
            increaseSuccessCount(1);
            wrapSqlParams(rowData, feb);
            fittingCodeMap.put(fittingCode, feb);
        }else{//验证失败，需要放入失败消息中
            if(StringUtils.isNotBlank(fittingCode) && !"null".equalsIgnoreCase(fittingCode)){
                increaseErrorCount(1);
                appendErrorDetail(fittingCode);
            }
        }
        return true;
    }

    /**
     * 根据具体业务验证excel数据的正确有效性
     * @param rowData:excel的每一行数据
     * @return
     * 			true:表示可以插入数据库的，
     * 			false:表示校验失败的，需要错误提示的
     */
    public boolean checkRowData(Map<String, Object> rowData){
        if((rowData.get("2") == null || StringUtils.isBlank(rowData.get("5").toString()))
                ){
            return false;
        }
        return true;
    }
    /**
     * 根据具体业务验证excel数据的正确有效性
     * @param rowData:excel的每一行数据
     * @return
     * 			true:表示可以插入数据库的，
     * 			false:表示校验失败的，需要错误提示的
     */
    public boolean checkFittingData(Map<String, Object> rowData){
        if((rowData.get("1") == null || StringUtils.isBlank(rowData.get("1").toString()))
                && (rowData.get("2") == null || StringUtils.isBlank(rowData.get("2").toString()))
                && (rowData.get("3") == null || StringUtils.isBlank(rowData.get("3").toString()))
                && (rowData.get("5") == null || StringUtils.isBlank(rowData.get("5").toString()))
                && (rowData.get("6") == null || StringUtils.isBlank(rowData.get("6").toString()))
                && (rowData.get("7") == null || StringUtils.isBlank(rowData.get("7").toString()))
                && (rowData.get("9") == null || StringUtils.isBlank(rowData.get("9").toString()))
                && (rowData.get("11") == null || StringUtils.isBlank(rowData.get("11").toString()))
                && (rowData.get("12") == null || StringUtils.isBlank(rowData.get("12").toString()))
                && (rowData.get("13") == null || StringUtils.isBlank(rowData.get("13").toString()))
                ){
            return false;
        }
        return true;
    }

    /**
     * 如果返回false，则表示终止继续遍历Excel,截至到当前的行数
     */
    @SuppressWarnings("unchecked")
    //验证Excel模板
    @Override
    public Boolean checkExcel(Map<String, Object> rowData, int rowIndex) {

        Map<String,Object> result = (Map<String, Object>) this.getHandlerResult();
        if(result == null){
            result = Maps.newHashMap();
            this.setHandlerResult(result);
        }

        Map<String, String> existsFittingMap = (Map<String, String>) result.get("existsFittingMap");
        if(existsFittingMap == null){
            existsFittingMap = Maps.newHashMap();
            result.put("existsFittingMap", existsFittingMap);
        }

        if(rowIndex == (getStartRow() -1)){//如果是title列，则直接检查是否同一个Excel模板,包括顺序和列名匹配
            //{1=备件名称, 10=工程师价格, 11=零售价格, 12=入库数量, 13=备件来源, 14=库位, 15=返还旧件, 2=备件条码,
            //3=备件型号, 4=备件品牌, 5=适用品类, 6=备件类型, 7=计量单位, 8=预警数量, 9=入库价格}
            StringBuilder sb = new StringBuilder("");
            sb.append("旧件条码").append(",").append("旧件名称 *").append(",").append("旧件型号").append(",");
            sb.append("旧件品牌").append(",").append("登记数量 *").append(",");
            sb.append("旧件单价").append(",");
            sb.append("是否原配").append(",").append("服务工程师").append(",");
            sb.append("工单编号").append(",").append("保修类型").append(",");
            sb.append("用户姓名").append(",").append("联系方式").append(",");
            sb.append("详细地址").append(",").append("备注").append(",");
            String[] titles = sb.toString().split(",");
            boolean ret = true;
            for(int i = 0; i < titles.length; i++){
                String tt = String.valueOf(rowData.get(String.valueOf(i + 1)));
                if(!titles[i].equals(tt.trim())){
                    result.put("TemplateError", "TemplateError");
                    ret = false;
                    break;
                }
            }
            return ret;
        }else if(checkFittingData(rowData) && rowIndex > (getStartRow() -1)){
            String fittingCode = (String) rowData.get("1");
            String rowIndexOld = existsFittingMap.get(fittingCode);
            if(StringUtils.isBlank(rowIndexOld)){
                //第一次肯定是有效的
                existsFittingMap.put(fittingCode, String.valueOf(rowIndex+1));
            }else{
                //生成错误提醒
                existsFittingMap.put(fittingCode, rowIndexOld + "," + (rowIndex+1));
            }
            //校验配件条码格式
            if(StringUtils.isNotBlank((String) rowData.get("1")) && !((String) rowData.get("1")).matches("^[0-9a-zA-Z]{1,40}$")){
                appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：旧件条码"+rowData.get("1")+"格式错误,最多不超过40位！</p>");
            }
            //校验必填项

            if(rowData.get("2") == null || StringUtils.isBlank(rowData.get("2").toString())){
                appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：旧件名称为空"+"</p>");
                return true;
            }else if(rowData.get("5") == null || StringUtils.isBlank(rowData.get("5").toString())){
                appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：登记数量为空"+"</p>");
                return true;
            }

            if(rowIndex > getMaxRows()){
                result.put("overLimit", "overLimit");
                return false;
            }
        }
        return true;
    }

    /**
     * 生成批量插入的SQL语句
     * @return
     */
    public String getFittngSql(){
        StringBuilder sf = new StringBuilder();

        sf.append(" INSERT INTO crm_site_old_fitting(CODE,NAME,VERSION,brand,num,unit_price,yrpz_flag,employe_name, ");
        sf.append(" order_id,warranty_type,customer_name,customer_mobile,customer_address,remarks, ");
        sf.append(" confirm_time,create_time,confirm_name,create_name,status,site_id,id) ");//最后一行是非Excel表格外的参数
        sf.append(" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");
        return sf.toString();
    }
    /**
     * 生成明细批量插入的SQL语句
     * @return
     */
    public String getFittngKeepSql(){
        StringBuilder sf = new StringBuilder();
        /*sf.append(" INSERT INTO crm_site_fitting_keep (id, number, TYPE, fitting_id, ");
        sf.append("	fitting_code, fitting_name, amount, price, employe_price, customer_price, ");
        sf.append(" create_time, site_id, create_by) ");
        sf.append("	VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");*/
        return sf.toString();
    }
    /**
     * 生成明细批量修改的SQL语句
     * @return
     */
    public String getUpdateFittingSql(){
        StringBuffer sf = new StringBuffer();
        sf.append("UPDATE crm_site_old_fitting SET CODE =?,NAME = ? ,VERSION = ? , ");
        sf.append("brand = ? ,num = ?,unit_price=?,yrpz_flag=?, employe_name=? ,order_id = ? , warranty_type = ?,customer_name = ? , ");
        sf.append("customer_mobile = ?, customer_address =? ,remarks=? ");
        sf.append("WHERE id = ?  ");
        return sf.toString();
    }


    /**
     * 根据业务封装可执行的SQL语句对应的参数数组
     * @param rowData
     * @return
     */
    public FittingExcelBean wrapSqlParams(Map<String, Object> rowData, FittingExcelBean feb){
        Object[] fittingParams = new Object[21];
       // Object[] fittingKeepParams = new Object[13];

        for(int i = 1; i <= rowData.size(); i++){
            String idx = i + "";
            Object val = rowData.get(idx);
            if(i==6){
                if(val!=null && !"".equals(val)){
                    val=val;
                }else{
                    val="0.00";
                }
            }
            if(i==7){
                if("是".equals(val)){
                    val="1";
                }else if("否".equals(val)){
                    val = "2";
                }else{
                    val = "";
                }
            }else if(i==10){
                if("保内".equals(val)){
                    val=1;
                }else if("保外".equals(val)){
                    val = "2";
                }else{
                    val = "";
                }
            }
            fittingParams[i-1] = val;
        }
        Map<String, String> paramMap = (Map<String, String>) getParams();
        String uti = rowData.get("7").toString().trim();

        fittingParams[14] = paramMap.get("date");//status
        fittingParams[15] = paramMap.get("date");//site_id
        fittingParams[16] = paramMap.get("name");//create_time
        fittingParams[17] = paramMap.get("name");//create_by
        fittingParams[18] = "1";//status
        fittingParams[19] = paramMap.get("siteId");
        fittingParams[20] =  IdGen.uuid();
        feb.setSqlParams(fittingParams);
        return feb;
    }

    //处理更新的参数集
    public Object[] generateFittingKeepParams(FittingExcelBean fib){
        Object[] params = new Object[15];
        Object[] fittingParams = fib.getSqlParams();
        params[0] = fittingParams[0];
        params[1] = fittingParams[1];
        params[2] = fittingParams[2];
        params[3] = fittingParams[3];
        params[4] = fittingParams[4];
        params[5] = fittingParams[5];
        params[6] = fittingParams[6];
        params[7] = fittingParams[7];
        params[8] = fittingParams[8];
        params[9] = fittingParams[9];
        params[11] = fittingParams[10];
        params[11] = fittingParams[11];
        params[12] = fittingParams[12];
        params[13] = fittingParams[13];
        params[14] = fittingParams[14];
        return params;
    }

    public DbBatchBean fittingFilterInDb(){
        //	Map<String, Object> retMap = Maps.newHashMap();
        DbBatchBean dbb = new DbBatchBean();
        DbBatchItem insertFittingDBI = new DbBatchItem();
        DbBatchItem insertFittingKeepDBI = new DbBatchItem();
        DbBatchItem updateFittingDBI = new DbBatchItem();
        Map<String, String> paramMap = (Map<String, String>) getParams();
        List<Object[]> ifitting = Lists.newArrayList();
        List<Object[]> ifittingKeep = Lists.newArrayList();
        List<Object[]> updateFitting = Lists.newArrayList();

        if(fittingCodeMap != null && fittingCodeMap.size() > 0){
            StringBuilder sb = new StringBuilder("SELECT id,code FROM crm_site_old_fitting a WHERE a.status='1' AND a.code IN ("+SqlKit.joinInSql(fittingCodeMap.keySet())+") AND a.site_id='"+paramMap.get("siteId")+"' ");
            List<Record> rds = Db.find(sb.toString());
            Map<String, String> existMap = Maps.newHashMap();
            for(Record rd : rds){
                String code = rd.getStr("code");
                String id = rd.getStr("id");
                if(fittingCodeMap.containsKey(code)){
                    existMap.put(code, id);
                }
            }
            for(Map.Entry<String, FittingExcelBean> ent : fittingCodeMap.entrySet()){
                /*if(existMap.containsKey(ent.getKey())){//已经存在于数据库中了，则更新操作
                    String fittingId = existMap.get(ent.getKey());
                    ent.getValue().getSqlParams()[14] = existMap.get(ent.getKey());
                    Object[] updateParams = generateFittingKeepParams(ent.getValue());
                    updateParams[14]=fittingId;
                    updateFitting.add(updateParams);
                }else{//如果没有存在于数据库中，那么就可以直接放入可插入的list中
                    ifitting.add(ent.getValue().getSqlParams());
                }*/
                ifitting.add(ent.getValue().getSqlParams());
            }
            if(ifitting != null && ifitting.size() > 0){
                insertFittingDBI.setSql(insertFittingSql);
                insertFittingDBI.setParams(ifitting);
                dbb.appendDBI(insertFittingDBI);
            }
            if(ifittingKeep != null && ifittingKeep.size() > 0){
                insertFittingKeepDBI.setSql(insertFittingKeepSql);
                insertFittingKeepDBI.setParams(ifittingKeep);
                dbb.appendDBI(insertFittingKeepDBI);
            }
            if(updateFitting != null && updateFitting.size() > 0){
                updateFittingDBI.setSql(updateFittingSql);
                updateFittingDBI.setParams(updateFitting);
                dbb.appendDBI(updateFittingDBI);
            }
        }
        return dbb;
    }
}
