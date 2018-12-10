package com.jojowonet.modules.order.utils;

import java.io.IOException;
import java.util.Properties;

/**
 * 类主要是用读取文件存储路径和设置文件缓存目录 允许上传图片的最大值
 * @author xsg
 *
 */
public class FileConst {

	private static Properties properties = new Properties();
	static {
		try {
			properties.load(FileConst.class.getClassLoader()
					.getResourceAsStream("uploadConst.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getValue(String key) {
		String value = (String) properties.get(key);
		return value.trim();
	}
}
