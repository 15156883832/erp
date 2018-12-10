package com.jojowonet.modules.fmss.utils;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.csvreader.CsvReader;

/**   
 * CSV操作(导出和导入)
 *
 * @author xsg
 * @version 2015-12-28
 */
public class CSVUtils {
    
    /**
     * 导入
     * @param file csv文件(文件)
     * @return
     */
	public static List<String> importCsv(MultipartFile file) {
		List<String> dataList = new ArrayList<String>();
		BufferedReader br = null;
		try {
			InputStream is = file.getInputStream();
			InputStreamReader isr = new InputStreamReader(is,"gbk");
			br = new BufferedReader(isr);
			String line = "";
			while ((line = br.readLine()) != null) {
				dataList.add(line);
			}
		} catch (Exception e) {
		} finally {
			if (br != null) {
				try {
					br.close();
					br = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return dataList;
	}
	
	public static List<String> csvReader (MultipartFile file) {
		List<String> dataList = new ArrayList<String>();
		//生成CsvReader对象，以，为分隔符，GBK编码方式
        CsvReader r;
		try {
			r = new CsvReader(file.getInputStream(), Charset.forName("GBK"));
//			r = new CsvReader(file.getName(), ',',Charset.forName("GBK"));
		
	        //读取表头
	        r.readHeaders();
	        //逐条读取记录，直至读完
	        while (r.readRecord()) {
	            //读取一条记录
	            dataList.add(r.getRawRecord());
	            //按列名读取这条记录的值
	        }
	        r.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataList;
	}
	
	
}