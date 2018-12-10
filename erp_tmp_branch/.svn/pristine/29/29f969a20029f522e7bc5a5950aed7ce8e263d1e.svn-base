package com.jojowonet.modules.order.utils.excelExt.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.poi.ss.formula.functions.T;

import com.jfinal.plugin.activerecord.Db;
import com.jojowonet.modules.order.utils.excelExt.pojo.ExcelResult;
import com.jojowonet.modules.order.utils.excelExt.utils.ExcelConvertor;

import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;

public class ExcelItemDefaultHandler implements ExcelItemHandler{

	private Map<String, Object> excelTemplate;
	
	private String[] datePattern = {"yyyy-MM-dd HH:mm:ss.0", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy-MM-dd", "yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss.0", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm"}; 
	
	private Object params;
	
	@SuppressWarnings({"unchecked"})
	@Override
	public Boolean handler(Map<String, Object> rowData, int rowIndex) {
		ExcelResult target = new ExcelResult();
		TreeMap<String, Object> treemap = new TreeMap<String, Object>(rowData);
		Map<String, Object> resultMap = (Map<String, Object>) target.getResult();
		Integer count = 0;
		int paramCount = 0;
		if(resultMap == null){
			resultMap = new HashMap<>();
			target.setResult(resultMap);
			//第一次的时候需要初始化插入的表头
			StringBuilder headerSB = new StringBuilder("");
			for(Entry<String, Object> entry : treemap.entrySet()){
				String colIndex = entry.getKey();
				String colLabel = ExcelConvertor.excelColIndexToStr(Integer.valueOf(colIndex));
				for(Entry<String, Object> tempEntry : excelTemplate.entrySet()){
					if(colLabel.equalsIgnoreCase(String.valueOf(tempEntry.getValue()))){
						headerSB.append(",").append(tempEntry.getKey());
						break;
					}
				}
			}
			String header = headerSB.append(",number,origin,source,site_id,site_name,create_by,messenger_id,messenger_name,id").toString().substring(1);
			resultMap.put("header", header);
			
			StringBuilder sb = new StringBuilder("");
    		sb.append(" insert into crm_order ("+header+") values( ");
    		String[] headerArr = header.split(",");
    		for(int i = 0; i < headerArr.length; i++){
    			sb.append(i == 0 ? "" : ",").append("?");
    			paramCount ++;
    		}
    		sb.append(" ) ");
    		resultMap.put("sql", sb.toString());
    		resultMap.put("paramCount", paramCount);
		}
		List<Object[]> params = (List<Object[]>) resultMap.get("params");
		if(params == null){
			params = new ArrayList<>();
			resultMap.put("params", params);
		}
		int i = 0;
		paramCount = Integer.valueOf(String.valueOf(resultMap.get("paramCount")));
		Object[] param = new Object[paramCount];
		Map<String, Object> infoMap = (Map<String, Object>) getParams();
		//Map<String, Object> existOrderMap = (Map<String, Object>) infoMap.get("existOrderMap");
		boolean isValidRow = true;
		for(Entry<String, Object> entry : treemap.entrySet()){
			String colIndex = entry.getKey();
			String colLabel = ExcelConvertor.excelColIndexToStr(Integer.valueOf(colIndex));
			
			for(Entry<String, Object> tempEntry : excelTemplate.entrySet()){
				if(colLabel.equalsIgnoreCase(String.valueOf(tempEntry.getValue()))){
					/*if("number".equalsIgnoreCase(tempEntry.getKey())){
						if(existOrderMap.containsKey(String.valueOf(entry.getValue())) || StringUtils.isBlank(String.valueOf(entry.getValue()))){
							isValidRow = false;
							break;
						}
					}*/
					
					Object val = null;
					String valStr = String.valueOf(entry.getValue());
					
					if("appliance_buy_time".equalsIgnoreCase(tempEntry.getKey()) || "create_time".equalsIgnoreCase(tempEntry.getKey())
							|| "promise_time".equalsIgnoreCase(tempEntry.getKey())){
						try{
							if("create_time".equalsIgnoreCase(tempEntry.getKey())){
								val = new Date();
							}else{
								val = DateUtils.parseDate(String.valueOf(entry.getValue()), datePattern);
							}
						}catch (Exception e) {
							//isValidRow = false;
							val = null;
						}
					}else if("status".equalsIgnoreCase(tempEntry.getKey())){
						val = "1";
					}else if("service_type".equalsIgnoreCase(tempEntry.getKey())){
						val = "1";
					}else if("repair_type".equalsIgnoreCase(tempEntry.getKey())){
						if(StringUtils.isNumeric(String.valueOf(valStr))){
							Integer rpt = Integer.valueOf(String.valueOf(valStr));
							if(rpt >=1 && rpt <= 6){
								val = valStr;
							}else{
								val = "6";
							}
						}else{
							if(valStr.indexOf("维修") != -1){
								val = "1";
							}else if(valStr.indexOf("安装") != -1){
								val = "2";
							}else if(valStr.indexOf("咨询") != -1){
								val = "3";
							}else if(valStr.indexOf("保养") != -1){
								val = "4";
							}else if(valStr.indexOf("工程") != -1){
								val = "5";
							}else if(valStr.indexOf("其他") != -1){
								val = "6";
							}else{
								val = "6";
							}
						}
					}else if("level".equalsIgnoreCase(tempEntry.getKey())){
						if(StringUtils.isNotEmpty(valStr)){
							if(valStr.indexOf("很紧急") != -1){
								val = "1";
							}else if(valStr.indexOf("紧急") != -1){
								val = "2";
							}else if(valStr.indexOf("尽快") != -1){
								val = "3";
							}else if(valStr.indexOf("一般") != -1){
								val = "4";
							}
						}else{
							val = "4";
						}
					}else if("origin".equalsIgnoreCase(tempEntry.getKey())){
						if(StringUtils.isNotEmpty(valStr)){
							if(valStr.indexOf("用户") != -1){
								val = "2"; 
							}else if(valStr.indexOf("经销商") != -1){
								val = "5";
							}
							else if(valStr.indexOf("厂家派工") != -1){
								val = "7";
							}
						}else{
							val = "2";
						}
					}else if("service_type".equalsIgnoreCase(tempEntry.getKey())){
						if(StringUtils.isNotEmpty(valStr)){
							if(valStr.indexOf("保内") != -1){
								val = "1";
							}else if(valStr.indexOf("保外") != -1){
								val = "2";
							}
							else if(valStr.indexOf("保外转保内") != -1){
								val = "3";
							}
						}
					}
					
					else{
						val = entry.getValue();
					}
					param[i] = val;
					i++;
					break;
				}
			}
			if(!isValidRow){
				break;
			}
		}
		
		if(isValidRow){
			//number,origin,source,site_id,site_name,create_by,messenger_id,messenger_name,id
			param[paramCount-9] = DateUtils.formatDate(new Date(), "yyyyMMddHHmm") + RandomStringUtils.randomNumeric(5);
			//param[paramCount-9] = "AAAAAAAAAAAA" + RandomStringUtils.randomNumeric(5);
			param[paramCount-8] = excelTemplate.get("origin");
			param[paramCount-7] = excelTemplate.get("source");
			param[paramCount-6] = infoMap.get("siteId");
			param[paramCount-5] = infoMap.get("siteName");
			param[paramCount-4] = infoMap.get("createBy");
			param[paramCount-3] = infoMap.get("messengerId");
			param[paramCount-2] = infoMap.get("messengerName");
			param[paramCount-1] = IdGen.uuid();
			params.add(param);
			count ++;
		}
		Integer oldCount = 0;
		if(resultMap.containsKey("count")){
			oldCount = ((Integer)resultMap.get("count")).intValue();
		}
		resultMap.put("count", oldCount + count);
		return true;
	}

	@Override
	public Class<?> getExcelItemClass() {
		return T.class;
	}

	@Override
	public Map<String, Object> getExcelTemplate() {
		return excelTemplate;
	}

	public void setExcelTemplate(String templateId) {
		if(excelTemplate == null){
			excelTemplate = Db.findFirst("SELECT * FROM crm_order_import_template a where a.id = ?", templateId).getColumns();
		}
	}

	@Override
	public Object getParams() {
		return params;
	}

	public void setParams(Object params){
		this.params = params;
	}

	@Override
	public int getStartRow() {
		return 0;
	}

	@Override
	public int getStartSheet() {
		return 0;
	}

	@Override
	public Boolean checkExcel(Map<String, Object> rowData, int rowIndex) {
		return null;
	}
}
