package com.jojowonet.modules.order.utils.excelExt.handler;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.formula.functions.T;

import com.google.common.collect.Lists;

public abstract class ExcelAbstractHandler implements ExcelItemHandler{

	public String[] datePattern = {"yyyy-MM-dd HH:mm:ss.0", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy-MM-dd", "yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss.0", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm"};

	private Map<String, Object> excelTemplate;//自定义模板时使用，暂不用

	private int startSheet = 1;//开始的Excel工作簿从1开始
	private int startRow = 3;//开始的行数，从1开始
	private int maxRows = 1000;//导入的最大条数

	/**
	 * params:主要用于传递公共的一些参数，如siteId，userId等
	 * handlerResult:主要用于保存处理过后的信息，比如成功条数，失败条数等信息
	 * executeSql:主要用于保存批量插入时的SQL 语句，
	 * executeParams:主要用于保存executeSql对应的参数集
	 * executeBean:当采用一些ORM 框架批量保存时需要保存的javaBean
	 */
	private Object params;//参数传递
	private Object handlerResult;//处理完的结果集
	private String executeSql = "";//需要执行的SQL 语句
	private List<Object[]> executeParams = Lists.newArrayList();//需要执行的SQL 语句对应的参数集
	private List<?> executeBean = Lists.newArrayList();//需要操作的javaBean
	private int sqlParamsCount = 0;
	private int successCount;//成功的条数
	private int errorCount;//失败的条数
	private String errorDetail = "";//失败的具体信息,比如存失败的工单编号
	private String successDetail = "";//成功的具体信息，比如存成功的工单编号

	@Override
	public Class<?> getExcelItemClass() {
		return T.class;
	}

	@Override
	public Map<String, Object> getExcelTemplate() {
		return excelTemplate;
	}

	@Override
	public Object getParams() {
		return params;
	}

	public void setParams(Object params){
		this.params = params;
	}

	public Object getHandlerResult() {
		return handlerResult;
	}

	public void setHandlerResult(Object handlerResult) {
		this.handlerResult = handlerResult;
	}

	public int getStartSheet() {
		return startSheet;
	}

	public void setStartSheet(int startSheet) {
		this.startSheet = startSheet;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public String getExecuteSql() {
		return executeSql;
	}

	public void setExecuteSql(String executeSql) {
		this.executeSql = executeSql;
	}

	public List<Object[]> getExecuteParams() {
		return executeParams;
	}

	public void setExecuteParams(List<Object[]> executeParams) {
		this.executeParams = executeParams;
	}

	public List<?> getExecuteBean() {
		return executeBean;
	}

	public void setExecuteBean(List<?> executeBean) {
		this.executeBean = executeBean;
	}

	public int getSuccessCount() {
		return successCount;
	}

	public void setSuccessCount(int successCount) {
		this.successCount = successCount;
	}

	public int getErrorCount() {
		return errorCount;
	}

	public void setErrorCount(int errorCount) {
		this.errorCount = errorCount;
	}

	public String getErrorDetail() {
		return errorDetail;
	}

	public void setErrorDetail(String errorDetail) {
		this.errorDetail = errorDetail;
	}

	public String getSuccessDetail() {
		return successDetail;
	}

	public void setSuccessDetail(String successDetail) {
		this.successDetail = successDetail;
	}

	public int increaseSuccessCount(int num){
		this.successCount += num;
		return this.successCount;
	}

	public int decreaseSuccessCount(int num){
		this.successCount -= num;
		return this.successCount;
	}

	public int increaseErrorCount(int num){
		this.errorCount += num;
		return this.errorCount;
	}

	public int getSqlParamsCount() {
		return sqlParamsCount;
	}

	public void setSqlParamsCount(int sqlParamsCount) {
		this.sqlParamsCount = sqlParamsCount;
	}

	public void appendErrorDetail(String detail){
		if(StringUtils.isBlank(this.errorDetail)){
			this.errorDetail = detail;
		}else{
			this.errorDetail = this.errorDetail + " " + detail;
		}
	}

	public void appendSuccessDetail(String detail){
		if(StringUtils.isBlank(this.successDetail)){
			this.successDetail = detail;
		}else{
			this.successDetail = this.successDetail + "," + detail;
		}
	}

	/**
	 * 统计SQL语句中的参数的个数
	 * @param sql
	 * @return
	 */
	public int countSqlParamsNum(String sql){
		return StringUtils.countMatches(sql, "?");
	}

	public int getMaxRows() {
		return maxRows;
	}

	public void setMaxRows(int maxRows) {
		this.maxRows = maxRows;
	}

    public static String cellValAsString(Object cellVal) {
        if (cellVal instanceof Double) {
            BigDecimal bigDecimal = BigDecimal.valueOf((Double) cellVal).stripTrailingZeros();
            return bigDecimal.toPlainString();
        } else if (cellVal instanceof Integer) {
            BigDecimal bigDecimal = BigDecimal.valueOf((Integer) cellVal);
            return bigDecimal.toPlainString();
        } else if (cellVal instanceof Long) {
            BigDecimal bigDecimal = BigDecimal.valueOf((Long) cellVal);
            return bigDecimal.toPlainString();
        } else if (cellVal instanceof Float) {
            BigDecimal bigDecimal = BigDecimal.valueOf((Float) cellVal);
            return bigDecimal.toPlainString();
        }

        return cellVal == null ? null : cellVal.toString();
    }
}
