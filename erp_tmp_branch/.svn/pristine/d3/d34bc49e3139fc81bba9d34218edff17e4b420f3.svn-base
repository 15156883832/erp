package com.jojowonet.modules.order.service.excel;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.utils.SqlKit;
import com.jojowonet.modules.order.utils.TableSplitMapper;
import com.jojowonet.modules.order.utils.excelExt.handler.ExcelAbstractHandler;
import com.jojowonet.modules.sys.util.ActiveRecordUtil;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.SpringContextHolder;
import ivan.common.utils.UserUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Pattern;

@Component
public class HistoryOrderExcelImportHandler  extends ExcelAbstractHandler{

	private static Logger logger = Logger.getLogger(HistoryOrderExcelImportHandler.class);

	public HistoryOrderExcelImportHandler() {
		this.userId = UserUtils.getUser().getId();
	}

	private final String userId;
	public Date now = new Date();
	/**
	 * 如果返回false，则表示终止继续遍历Excel,截至到当前的行数
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Boolean handler(Map<String, Object> rowData, int rowIndex) {
		if(StringUtils.isBlank(getExecuteSql())){
			String sql = generateSql();
			setExecuteSql(sql);//如果不存在SQL的话需要生成SQL 
			setSqlParamsCount(countSqlParamsNum(sql));
		}
		
		//此处的map主要用来处理结束后进行数据库去重操作
		Map<String, Object[]> map = (Map<String, Object[]>) getHandlerResult();
		if(map == null || map.isEmpty()){
			map = Maps.newHashMap();
			setHandlerResult(map);
		}
		
		String orderNum = cellValAsString(rowData.get("1"));
		boolean isValid = checkRowData(rowData);
		if(isValid && !map.containsKey(orderNum)){//验证成功，可以插入数据库
			increaseSuccessCount(1);
			Object[] param = wrapSqlParams(rowData, getSqlParamsCount());
			map.put(orderNum, param);
		}else{//验证失败，需要放入失败消息中
			if(StringUtils.isNotBlank(orderNum) && !"null".equalsIgnoreCase(orderNum)){
				increaseErrorCount(1);
				appendErrorDetail(orderNum);
			}
		}
		return true;
	}
	
	/**
	 * 如果返回false，则表示终止继续遍历Excel,截至到当前的行数
	 */
	//验证Excel模板
	@SuppressWarnings("unchecked")
	@Override
	public Boolean checkExcel(Map<String, Object> rowData, int rowIndex) {
//		if(rowIndex % 100 == 0) {
//			logger.info("current row is:" + rowIndex);
//		}
		Map<String, Object> result = (Map<String, Object>) this.getHandlerResult();
		if(result == null){
			result = Maps.newHashMap();
			this.setHandlerResult(result);
		}
		
		Map<String, String> existsOrderMap = (Map<String, String>) result.get("existsOrderMap");
		if(existsOrderMap == null){
			existsOrderMap = Maps.newHashMap();
			result.put("existsOrderMap", existsOrderMap);
		}

	/*	Map<String, String> needMap = Maps.newHashMap();
		needMap.put("1", "用户姓名");
		*/
		if(rowIndex == (getStartRow() -1)){//如果是title列，则直接检查是否同一个Excel模板,包括顺序和列名匹配
			StringBuilder sb = new StringBuilder("");
			sb.append("工单编号").append(",").append("用户姓名").append(",");
			sb.append("联系方式1").append(",").append("联系方式2").append(",");
			sb.append("联系方式3").append(",").append("用户地址").append(",");
			sb.append("家电品牌").append(",").append("家电品类").append(",");
			sb.append("产品型号").append(",").append("产品数量").append(",");
			sb.append("内机条码").append(",").append("外机条码").append(",");
			sb.append("服务类型").append(",").append("服务方式").append(",");
			sb.append("服务描述").append(",").append("保修类型").append(",");
			sb.append("购机日期").append(",").append("服务工程师").append(",");
			sb.append("信息来源").append(",").append("报修时间").append(",");
			sb.append("完工时间").append(",").append("服务反馈");
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
		}else if(checkOrderData(rowData) && rowIndex > (getStartRow() -1)){
			
			String orderNum = cellValAsString(rowData.get("1"));
			 String rowIndexOld = existsOrderMap.get(orderNum); 
			   if(StringUtils.isBlank(rowIndexOld)){
					//第一次肯定是有效的
					existsOrderMap.put(orderNum, String.valueOf(rowIndex+1));
				}else{
					//生成错误提醒
					existsOrderMap.put(orderNum, rowIndexOld + "," + (rowIndex+1));
				}
//				if(rowData.get("1") instanceof Double){
//					if(rowData.get("1") != null){
//						BigDecimal bigDecimal=BigDecimal.valueOf((Double) rowData.get("1")).stripTrailingZeros();
//						String str=bigDecimal.toPlainString();
//						if(!str.matches("^[0-9a-zA-Z]{2,20}$")){
//							appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：工单编号"+str+"格式错误,不超过20的数字或字母及两者组合"+"</p>");
//						}
//					}
//				}else{
//					if(rowData.get("1") != null &&!(rowData.get("1").toString()).matches("^[0-9a-zA-Z]{2,20}$")){
//						appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：工单编号"+rowData.get("1").toString()+"格式错误,不超过20的数字或字母及两者组合"+"</p>");
//					}
//				}
			if (orderNum == null || !PATT_ORDERNO.matcher(orderNum).matches()) {
				appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：工单编号"+orderNum+"格式错误,不超过20的数字或字母及两者组合"+"</p>");
			}

				if (rowData.get("3") != null && StringUtils.isNotBlank(rowData.get("3").toString())) {
					if (rowData.get("3").toString().length() > 20) {
						appendErrorDetail("<p>第" + (rowIndex + 1) + "行数据：联系方式1的长度不能超过20" + "</p>");
					}
				}

				if(rowData.get("1") == null || StringUtils.isBlank(rowData.get("1").toString())){
					appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：工单编号为空"+"</p>");
					return true;
				}else if(rowData.get("3") == null || StringUtils.isBlank(rowData.get("3").toString())){
					appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：联系方式1为空"+"</p>");
					return true;
				}else if(rowData.get("6") == null || StringUtils.isBlank(rowData.get("6").toString())){
					appendErrorDetail("<p>第"+(rowIndex+1)+"行数据：用户地址为空"+"</p>");
					return true;
				}

			if (rowData.get("17") != null  && StringUtils.isNotBlank(rowData.get("17").toString())) {
				try {
					//可能的数字excel时间
					if (NumberUtils.isDigits(rowData.get("17").toString())) {
						converExcelDate(rowData.get("17").toString());
					} else {
						DateUtils.parseDate(rowData.get("17").toString(), datePattern);
					}
				} catch (Exception e) {
					appendErrorDetail("<p>第" + (rowIndex + 1) + "行数据：购机日期格式不正确" + "</p>");
				}
			}
			if (rowData.get("20") != null && StringUtils.isNotBlank(rowData.get("20").toString())) {
				try {
					//可能的数字excel时间
					if (NumberUtils.isDigits(rowData.get("20").toString())) {
						converExcelDate(rowData.get("20").toString());
					} else {
						DateUtils.parseDate(rowData.get("20").toString(), datePattern);
					}
				} catch (Exception e) {
					appendErrorDetail("<p>第" + (rowIndex + 1) + "行数据：报修时间格式不正确" + "</p>");
				}
			}
			if (rowData.get("21") != null && StringUtils.isNotBlank(rowData.get("21").toString())) {
				try {
					//可能的数字excel时间
					if (NumberUtils.isDigits(rowData.get("21").toString())) {
						converExcelDate(rowData.get("21").toString());
					} else {
						DateUtils.parseDate(rowData.get("21").toString(), datePattern);
					}
				} catch (Exception e) {
					appendErrorDetail("<p>第" + (rowIndex + 1) + "行数据：完工时间格式不正确" + "</p>");
				}
			}

			if(rowIndex > (getMaxRows()+4001)){
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
	public String generateSql(){
		//TableSplitMapper tableSplitMapper = new TableSplitMapper();
		TableSplitMapper tableSplitMapper = SpringContextHolder.getBean(TableSplitMapper.class);
		StringBuilder sb = new StringBuilder();
		String siteId = "";

		try {
			Map<String, Object> map = (Map<String, Object>) this.getParams();
			siteId = String.valueOf(map.get("siteId"));
			sb.append(" INSERT INTO " + tableSplitMapper.mapOrder(siteId) + "(number, customer_name, customer_mobile, customer_telephone, customer_telephone2, ");
			sb.append(" customer_address,appliance_brand, appliance_category,appliance_model,appliance_num,appliance_barcode,appliance_machine_code, ");
			sb.append(" service_type,service_mode,customer_feedback,warranty_type,appliance_buy_time,employe_name,origin,repair_time, ");
			sb.append(" end_time,remarks,site_id, site_name, STATUS,id,create_time,create_by) ");
			sb.append(" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,'" + userId + "') ");
		}catch (Exception e){
			throw new RuntimeException(" generateSql err! >> " + sb.toString() + " , siteId:" + siteId);
		}
		return sb.toString();
	}
	
	/**
	 * 根据具体业务验证excel数据的正确有效性
	 * @param rowData:excel的每一行数据
	 * @return 
	 * 			true:表示可以插入数据库的，
	 * 			false:表示校验失败的，需要错误提示的
	 */
	public boolean checkRowData(Map<String, Object> rowData){
		if((rowData.get("1") == null || StringUtils.isBlank(rowData.get("1").toString()))
				|| (rowData.get("3") == null || StringUtils.isBlank(rowData.get("3").toString()))
				|| (rowData.get("6") == null || StringUtils.isBlank(rowData.get("6").toString()))
				){
			return false;
		}
		return true;
	}
	
	public boolean checkOrderData(Map<String, Object> rowData){
		if((rowData.get("1") == null || StringUtils.isBlank(rowData.get("1").toString()))
				&& (rowData.get("3") == null || StringUtils.isBlank(rowData.get("3").toString()))
				&& (rowData.get("6") == null || StringUtils.isBlank(rowData.get("6").toString()))
				){
			return false;
		}
		return true;
	}

	/**
	 * 根据业务封装可执行的SQL语句对应的参数数组
	 * @param rowData
	 * @param count
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Object[] wrapSqlParams(Map<String, Object> rowData, int count){
		Object[] param = new Object[count];
		Map<String, String> params = (Map<String, String>) getParams();
		for(int i = 1; i <= rowData.size(); i++){
			String idx = i + "";
			Object val = rowData.get(idx);

			if(i == 1) {
				val = cellValAsString(val);
			} else if(i==10){//购机数量
				if(val == null || StringUtils.isBlank(val.toString())){
					val = "1";
				}
			}else if(i==21 || i == 20 || i == 17){//完工时间|报修时间|购买日期
				if(val != null && StringUtils.isNotBlank(val.toString())){
					try{
						if(NumberUtils.isDigits(val.toString())){//可能的数字excel时间
							val = converExcelDate(val.toString());
						}else{
							val = DateUtils.parseDate(val.toString(), datePattern);
						}
					}catch (Exception e) {
						val="";
					}
				}else{
					val = null;
				}
			}else if(i == 16){//保修类型
				if(val != null && StringUtils.isNotBlank(val.toString())){
					String valStr = val.toString();
					if(valStr.contains("保内")) {
						val = "1";
					}else if(valStr.contains("保外")){
						val = "2";
					}else{
						val = "";
					}
				}else{
					val = "";
				}
			}
			param[i-1] = val;
		}
		//, site_id, site_name, status, create_time, repair_time, id
		param[22] = params.get("siteId");
		param[23] = params.get("siteName");
		param[24] = "5";
		param[25] = IdGen.uuid();
		param[26] = params.get("createTime");
		return param;
	}
	
	/**
	 * 数据库检验存在操作
	 */
	@SuppressWarnings("unchecked")
	public void checkExistsOrderNum(){
		Map<String, Object[]> orderMap = (Map<String, Object[]>) getHandlerResult();
		//获取可执行的sql语句对应的参数数组List
		List<Object[]> executeSqlParams = getExecuteParams();
		if(orderMap != null && !orderMap.isEmpty()){//没有成功的记录数，可直接返回，不需要在查数据库

			//TableSplitMapper tableSplitMapper = new TableSplitMapper();
			TableSplitMapper tableSplitMapper = SpringContextHolder.getBean(TableSplitMapper.class);

			Map<String, Object> info = (Map<String, Object>) getParams(); 
			String siteId = String.valueOf(info.get("siteId"));
			StringBuilder sb = new StringBuilder("select a.number from crm_order a where a.site_id = ? and a.number in("+SqlKit.joinInSql(orderMap.keySet())+") ");
			List<Record> nowRds = Db.find(sb.toString(), siteId);
			List<Record> rds = Lists.newArrayList();
			if(tableSplitMapper.exists(siteId)){
				List<Record> historyRds = Db.find("select a.number from " + tableSplitMapper.mapOrder(siteId) + " a where a.site_id = ? and a.number in ("+SqlKit.joinInSql(orderMap.keySet())+") ", siteId);
				rds = ActiveRecordUtil.combineRecords("number", nowRds, historyRds);
			}else{
				rds = nowRds;
			}

			Map<String, String> dbExistsMap = Maps.newHashMap();
			for(Record rd : rds){
				String number = rd.getStr("number");
				if(orderMap.containsKey(number)){//已经存在于数据库中了，不能进行插入数据库
					dbExistsMap.put(number, "1");
				}
			}
			
			for(Entry<String, Object[]> ent : orderMap.entrySet()){
				if(dbExistsMap.containsKey(ent.getKey())){//已经存在于数据库中了，不能进行插入数据库
					decreaseSuccessCount(1);//如果已经存在数据库中，那么就减少成功次数
					appendErrorDetail(ent.getKey());
					increaseErrorCount(1);
				}else{//如果没有存在于数据库中，那么就可以直接放入可插入的list中
					Object[] param = ent.getValue();
					executeSqlParams.add(param);
				}
			}
			setExecuteParams(executeSqlParams);
		}
	}


	private static final long BASE_TIME = baseTime();
	private static final Pattern PATT_EXCEL_DATE = Pattern.compile("[0-9]*");
	private static final Pattern PATT_ORDERNO = Pattern.compile("^[0-9a-zA-Z]{2,20}$");

	public static Date converExcelDate(String dateStr) throws Exception {
//		String pattern = "[0-9]*";
		if (PATT_EXCEL_DATE.matcher(dateStr).matches()) {
			long dateLong = BASE_TIME + (Long.valueOf(dateStr) - 2L) * 24L * 60L * 60L * 1000L;
			return new Date(dateLong);
		} else {
			return org.apache.commons.lang3.time.DateUtils.parseDate(dateStr, "yyyy-MM-dd");
		}
	}

	private static long baseTime() {
		Date originalDate;
		try {
			originalDate = org.apache.commons.lang3.time.DateUtils.parseDate("1900-01-01 00:00:00", "yyyy-MM-dd HH:mm:ss");
			return originalDate.getTime();
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
	}
}
