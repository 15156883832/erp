package com.jojowonet.modules.order.utils;

import ivan.common.utils.Encodes;
import ivan.common.utils.excel.ExportExcel;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFFormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtilsEx {

    public ExportExcel write(HttpServletRequest request,
            HttpServletResponse response, String fileName, ExportExcel ee) throws IOException{
        try {
            //中文文件名支持
            String encodedfileName = null;
            String agent = request.getHeader("USER-AGENT");
            if(null != agent && -1 != agent.indexOf("MSIE")){//IE
                encodedfileName = java.net.URLEncoder.encode(fileName,"UTF-8");
            }else if(null != agent && -1 != agent.indexOf("Mozilla")){
                encodedfileName = new String (fileName.getBytes("UTF-8"),"iso-8859-1");
            }else{
                encodedfileName = java.net.URLEncoder.encode(fileName,"UTF-8");
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedfileName + "\"");
            ee.write(response.getOutputStream());
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return ee;
    }
    
    /**
	 * 
	 * <li>读取excel中的数据
	 * 
	 * @Description:
	 * @param pathname
	 *            要读取的文件路径、名称、后缀
	 * @return list
	 * @throws Exception
	 *             List<Map<Integer,Object>>
	 * @Created:wangang 2013-6-19下午04:13:42
	 * @Modified:
	 */
	public static List<Map<Integer, Object>> readExcel(String pathname) throws Exception {
		InputStream is = new FileInputStream(pathname);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
		List<Map<Integer, Object>> resultList = new ArrayList<Map<Integer, Object>>();
		XSSFFormulaEvaluator evaluator = new XSSFFormulaEvaluator(xssfWorkbook);
		Map<Integer, Object> map = null;
		// 循环工作表Sheet
		// for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets();
		// numSheet++) {
		// 只需要读第一个工作表，不用循环
		XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);
		// xssfSheet.setDisplayFormulas(true);
		if (xssfSheet == null) {
			return null;
		}
		// 循环行Row
		for (int rowNum = 1; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
			XSSFRow xssfRow = xssfSheet.getRow(rowNum);
			if (xssfRow == null) {
				continue;
			}
			map = new HashMap<Integer, Object>();
			// 循环列Cell
			for (int cellNum = 0; cellNum <= xssfRow.getLastCellNum(); cellNum++) {
				XSSFCell xssfCell = xssfRow.getCell(cellNum);
				if (xssfCell == null) {
					continue;
				}
				String value = getValue(xssfCell, evaluator);
				if (value != null && value.length() > 0) {
					if (value.trim() == "结束" || "结束".equals(value.trim())) {
						continue;
					} else {
						map.put(cellNum, value);
					}
				} else {
					map.put(cellNum, value);
				}
			}
			resultList.add(map);
		}
		return resultList;
	}

	/**
	 * @获取Excel中某个单元格的值
	 * @param cell
	 *            EXCLE单元格对象
	 * @param evaluator
	 *            EXCLE单元格公式
	 * @return 单元格内容
	 */
	public static String getValue(XSSFCell cell, FormulaEvaluator evaluator) {

		String value = "";
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_NUMERIC: // 数值型
			if (HSSFDateUtil.isCellDateFormatted(cell)) { // 如果是时间类型
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				value = format.format(cell.getDateCellValue());
			} else { // 纯数字
				value = String.valueOf(cell.getNumericCellValue());
			}
			break;
		case HSSFCell.CELL_TYPE_STRING: // 字符串型
			value = cell.getStringCellValue();
			break;
		case HSSFCell.CELL_TYPE_BOOLEAN: // 布尔
			value = " " + cell.getBooleanCellValue();
			break;
		case HSSFCell.CELL_TYPE_BLANK: // 空值
			value = "";
			break;
		case HSSFCell.CELL_TYPE_ERROR: // 故障
			value = "";
			break;
		case HSSFCell.CELL_TYPE_FORMULA: // 公式型
			try {
				CellValue cellValue;
				cellValue = evaluator.evaluate(cell);
				switch (cellValue.getCellType()) { // 判断公式类型
				case Cell.CELL_TYPE_BOOLEAN:
					value = String.valueOf(cellValue.getBooleanValue());
					break;
				case Cell.CELL_TYPE_NUMERIC:
					// 处理日期
					if (DateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
						Date date = cell.getDateCellValue();
						value = format.format(date);
					} else {
						value = String.valueOf(cellValue.getNumberValue());
					}
					break;
				case Cell.CELL_TYPE_STRING:
					value = cellValue.getStringValue();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_ERROR:
					value = "";
					break;
				case Cell.CELL_TYPE_FORMULA:
					value = "";
					break;
				}
			} catch (Exception e) {
				value = cell.getStringCellValue().toString();
				cell.getCellFormula();
			}
			break;
		default:
			value = cell.getStringCellValue().toString();
			break;
		}
		return value;
	}
}
