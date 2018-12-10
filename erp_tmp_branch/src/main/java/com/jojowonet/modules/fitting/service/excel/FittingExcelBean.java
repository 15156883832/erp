package com.jojowonet.modules.fitting.service.excel;

public class FittingExcelBean {

	private Object[] sqlParams;
	
	private FittingExcelDetailBean fittingExcelDetailBean;

	public Object[] getSqlParams() {
		return sqlParams;
	}

	public void setSqlParams(Object[] sqlParams) {
		this.sqlParams = sqlParams;
	}

	public FittingExcelDetailBean getFittingExcelDetailBean() {
		return fittingExcelDetailBean;
	}

	public void setFittingExcelDetailBean(FittingExcelDetailBean fittingExcelDetailBean) {
		this.fittingExcelDetailBean = fittingExcelDetailBean;
	}
	
}
