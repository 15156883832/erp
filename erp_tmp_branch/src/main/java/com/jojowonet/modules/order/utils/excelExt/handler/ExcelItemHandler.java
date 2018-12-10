package com.jojowonet.modules.order.utils.excelExt.handler;

import java.util.Map;

public interface ExcelItemHandler {

	Boolean handler(Map<String, Object> rowData, int rowIndex);
	
	Boolean checkExcel(Map<String, Object> rowData, int rowIndex);
	
	Class<?> getExcelItemClass();
	
	Map<String, Object> getExcelTemplate();
	
	Object getParams();
	
	int getStartRow();
	
	int getStartSheet();
}
