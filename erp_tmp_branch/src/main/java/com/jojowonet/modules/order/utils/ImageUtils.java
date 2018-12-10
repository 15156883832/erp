package com.jojowonet.modules.order.utils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.codec.binary.Base64;

public class ImageUtils {

	public static String imgToBase64(String imgPath) {
		InputStream in = null;
		byte[] data = null;
		// 读取图片字节数组
		try {
			in = new FileInputStream(imgPath);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 对字节数组Base64编码
		byte[] en = Base64.encodeBase64(data);
		return new String(en);// 返回Base64编码过的字节数组字符串
	}

	public static String imgFromBase64(String imgStr, String imgFile) {
		if (imgStr == null) // 图像数据为空
			return null;
		try {
			// Base64解码

			byte[] b = Base64.decodeBase64(new String(imgStr).getBytes());

			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {// 调整异常数据
					b[i] += 256;
				}
			}
			// 生成jpeg图片
			OutputStream out = new FileOutputStream(imgFile);
			out.write(b);
			out.flush();
			out.close();
			return imgFile;
		} catch (Exception e) {
			return null;
		}
	}

	public static void main(String[] args) {
	}
}