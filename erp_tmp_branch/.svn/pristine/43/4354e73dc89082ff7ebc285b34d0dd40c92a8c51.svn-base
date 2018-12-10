package com.jojowonet.modules.fmss.web;
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
import java.text.SimpleDateFormat;  
import java.util.ArrayList;  
import java.util.Date;  
import java.util.HashMap;  
import java.util.List;  
import java.util.Map;  
  
import org.apache.poi.hssf.usermodel.HSSFCell;  
import org.apache.poi.hssf.usermodel.HSSFCellStyle;  
import org.apache.poi.hssf.usermodel.HSSFDateUtil;  
import org.apache.poi.hssf.usermodel.HSSFFont;  
import org.apache.poi.hssf.usermodel.HSSFRichTextString;  
import org.apache.poi.hssf.usermodel.HSSFRow;  
import org.apache.poi.hssf.usermodel.HSSFSheet;  
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  
import org.apache.poi.hssf.util.HSSFColor;  
import org.apache.poi.poifs.filesystem.POIFSFileSystem;  
import org.slf4j.Logger;  
import org.slf4j.LoggerFactory;  
  
  
/** 
 * 该工具类提供针对Excel，cvs等表格进行读出的方法 
 * @author linwei 
 * 
 */  
public class ExcelUtil {  
  
    private final static Logger log = LoggerFactory.getLogger(ExcelUtil.class);  
      
      
    /** 
     * 根据传输的数据，生成对应的文件 
     * @param out    外部传递的文件输出流 
     * @param exportFileName    生成的文件名(需要带后缀格式) 
     * @param relaMap           用来表示列的行数，与titleMap以及List<Map<String,Object>>中的key的关系. [relaMap(行数,key关键字)] 
     * @param titleMap          文件第一行的各个列的名称(可为空，为空时，则直接显示数据行) 
     * @param list<Map>         数据列              
     * @return 
     *  
     * eg: 
     *  relaMap 数值从1开始，表示第一列 
     *   
     *   
        Map relaMap = new HashMap(); 
        relaMap.put("1", "no"); 
        relaMap.put("2", "test1"); 
        relaMap.put("3", "test2"); 
         
        Map titleMap = new HashMap(); 
        titleMap.put("no", "NO"); 
        titleMap.put("test1", "测试字段1"); 
        titleMap.put("test2", "测试字段2"); 
         
        List list = new ArrayList(); 
        Map m = new HashMap();  
        m.put("test1", "测试value1"); 
        m.put("test2", "测试value2"); 
        list.add(m); 
        m = new HashMap();  
        m.put("test1", "测试value11"); 
        m.put("test2", "测试value22"); 
        list.add(m);     
     *  
     *  
     */  
    public static String[] writeExcel(OutputStream out,Map<String,String> relaMap,Map<String,Object> titleMap,List<Map<String,Object>> list) {  
          
        String[] result = new String[2];  
        if(out == null || relaMap == null || relaMap.size() == 0) {  
            result[0] = "false";  
            result[1] = "in ExcelUtil.writeExcel,out or exportFileName or relaMap is null.";  
            return result;  
        }  
                  
//      String suffix = StringUtils.substringAfter(exportFileName, ".");  
//      if(!"xls".equalsIgnoreCase(suffix) || !"cvs".equalsIgnoreCase(suffix)) {  
//          result[0] = "false";  
//          result[1] = "suffix must xls or cvs.";  
//          return result;  
//      }  
          
        try {  
            createExcel(out,relaMap,titleMap,list);  
            result[0] = "true";  
            result[1] = "success.";  
        } catch (IOException e) {  
            log.error("in ExcelUtil.writeExcel has an error,e is " + e);  
            result[0] = "false";  
            result[1] = "in ExcelUtil.writeExcel has an error,e is " + e;  
        }  
          
        return result;  
    }  
      
    /** 
     * 该方法接受外部一个excel或者cvs等的输入流参数，返回解析后的List<Map<Integer,String>>对象 
     * @param in 
     * @param isParseFirstRow 
     * @return 
     */  
    public static List<Map<String,String>> readExcel(InputStream in,boolean isParseFirstRow) {  
          
        if(in == null)   
            return null;  
          
        List<Map<String,String>> list = null;  
        try {  
            list = readExcelContent(in,isParseFirstRow);  
        } catch (IOException e) {     
            log.error("in ExcelUtil.readExcel has an error,e is " + e);  
        }  
        return list;  
    }  
      
    /** 
     * 真实执行创建excel或者cvs文件的方法 
     * @param out 
     * @param relaMap 
     * @param titleMap 
     * @param list 
     * @throws IOException  
     */  
    private static void createExcel(OutputStream out,Map<String,String> relaMap,Map<String,Object> titleMap,List<Map<String,Object>> list) throws IOException {  
          
        //创建工作空间  
        HSSFWorkbook workbook = new HSSFWorkbook();  
        HSSFSheet sheet = workbook.createSheet();  
        //创建表格样式  
        HSSFCellStyle cellStyleHead = workbook.createCellStyle();  
        HSSFCellStyle cellStyleContent = workbook.createCellStyle();  
        //创建文字字体  
        HSSFFont headFont = workbook.createFont();  
        HSSFFont contentFont = workbook.createFont();  
          
        //表头设置字体  
        headFont.setFontHeightInPoints((short) 12);  
        headFont.setFontName("宋体");  
        headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        cellStyleHead.setFont(headFont);  
        // 颜色  
        cellStyleHead.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
        cellStyleHead.setFillForegroundColor(new HSSFColor.PALE_BLUE().getIndex());  
        // 边框，对齐  
        cellStyleHead.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        cellStyleHead.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
        cellStyleHead.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        cellStyleHead.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        cellStyleHead.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        cellStyleHead.setBorderRight(HSSFCellStyle.BORDER_THIN);  
          
        //设置内容格式  
        contentFont.setFontHeightInPoints((short) 12);  
        contentFont.setFontName("宋体");  
        cellStyleContent.setFont(contentFont);  
        // 边框，对齐  
        cellStyleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        cellStyleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
        cellStyleContent.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        cellStyleContent.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        cellStyleContent.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        cellStyleContent.setBorderRight(HSSFCellStyle.BORDER_THIN);  
          
        int rowIndex = 0;  
        HSSFRow row = null;  
        String key = null;  
        int size = 0;  
        if(titleMap != null && titleMap.size() > 0) {  
            row = sheet.createRow(rowIndex++);  
            size = relaMap.size();  
            for(int i=1;i<=size;i++) {  
                key = (String)relaMap.get(String.valueOf(i));  
                //excel中使用0表示第一列  
                setCell(row,i-1,titleMap.get(key),cellStyleHead);  
            }  
        }  
          
    //    if(CollectionUtils.isNotEmpty(list)) {  
            for(Map<String,Object> map:list) {  
                row = sheet.createRow(rowIndex++);  
                size = map.size();  
                for(int i=1;i<=size;i++) {  
                    key = (String)relaMap.get(String.valueOf(i));  
                    //excel中使用0表示第一列  
                    setCell(row,i-1,map.get(key),cellStyleContent);  
                }  
            }  
    //    }  
          
        workbook.write(out);  
    }  
      
      
    /** 
     * 设置单元格 
     * @param row      哪一行 
     * @param index    列号 
     * @param value    单元格的(字符串)填充值 
     * @param cellStyle     单元格样式 
     */  
    private static void setCell(HSSFRow row,int index,Object value,HSSFCellStyle cellStyle) {  
          
        HSSFCell cell = row.createCell((short) index);  
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);  
        String temp = "";  
        if(value != null) {  
            if(value instanceof String) {  
                temp = (String)value;  
            } else if(value instanceof Integer) {  
                temp = String.valueOf(value);  
            } else if(value instanceof Date) {  
             //   temp = DateHelper.getTimeStamp((Date)value,null);   
            }   
        }  
          
        cell.setCellValue(new HSSFRichTextString(temp));  
        cell.setCellStyle(cellStyle);  
    }  
      
    /** 
     * 解析相关excel输入流，并组装成list数组返回 
     *  
     */  
    private static List<Map<String,String>> readExcelContent(InputStream is,boolean isParseFirstRow) throws IOException {  
          
        POIFSFileSystem fs = new POIFSFileSystem(is);  
        HSSFWorkbook wb = new HSSFWorkbook(fs);  
        //默认只获取第一个sheet空间的数据  
        HSSFSheet sheet = wb.getSheetAt(0);  
        //得到总行数(getLastRowNum是从0开始计算的最后一行的行数,因此总行数需要加1)  
        int rowNum = sheet.getLastRowNum() + 1;  
        //判空操作，如果总行数为0，则直接返回null  
        if(rowNum == 0)  
            return null;  
        //设置行数,以及从哪行开始解析  
        int startPos = 0;  
        if(!isParseFirstRow) {  
            rowNum = rowNum - 1;  
            startPos = 1;  
        }  
  
        List<Map<String,String>> resList = new ArrayList<Map<String,String>>();  
        Map<String, String> content = null;  
        HSSFRow row = null;  
        row = sheet.getRow(0);  
        int colNum = row.getPhysicalNumberOfCells();  
        String str = null;  
        for (int i = startPos; i <= rowNum; i++) {  
            row = sheet.getRow(i);  
            content = new HashMap<String, String>();  
            for(int j = 0;j < colNum;j++) {  
                str = getCellFormatValue(row.getCell((short)j)).trim();  
                //设置好返回格式，外部使用该map时，使用的是从1开始的第一列，故需要加1  
                content.put(String.valueOf(j + 1), str);  
            }  
            resList.add(content);  
        }  
        return resList;  
    }  
  
    /** 
     * 根据HSSFCell类型设置数据 
     * @param cell 
     * @return 
     */  
    private static String getCellFormatValue(HSSFCell cell) {  
          
        String cellvalue = " ";  
        if(cell == null)  
            return cellvalue;  
          
        // 判断当前Cell的Type  
        switch (cell.getCellType()) {  
            // 如果当前Cell的Type为NUMERIC  
            case HSSFCell.CELL_TYPE_NUMERIC:  
              
            case HSSFCell.CELL_TYPE_FORMULA: {  
                // 判断当前的cell是否为Date  
                if (HSSFDateUtil.isCellDateFormatted(cell)) {  
                    // 如果是Date类型则，转化为Data格式  
      
                    //方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00  
                    //cellvalue = cell.getDateCellValue().toLocaleString();  
      
                    //方法2：这样子的data格式是不带带时分秒的：2011-10-12  
                    Date date = cell.getDateCellValue();  
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
                    cellvalue = sdf.format(date);  
                }  
                // 如果是纯数字  
                else {  
                    // 取得当前Cell的数值  
                    cellvalue = String.valueOf(cell.getNumericCellValue());  
                }  
                break;  
            }  
              
            // 如果当前Cell的Type为STRIN  
            case HSSFCell.CELL_TYPE_STRING:  
                // 取得当前的Cell字符串  
                cellvalue = cell.getRichStringCellValue().getString();  
                break;  
            // 默认的Cell值  
            default:  
                cellvalue = " ";  
        }  
  
        return cellvalue;  
    } 
}