package com.jojowonet.modules.order.utils;

import ivan.common.config.Global;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.jojowonet.modules.fmss.utils.HttpUtils;

import net.sf.json.JSONObject;

public class StaticResourceUtils {

	/**
	 * 将本地的图片拷贝一份到公共图片资源路径，然后不同的端口统一从公共资源路径调用即可
	 * @param relativePath	：文件的相对路径,也即存储在数据库的路径。
	 * <p>值如：relativePath="/upload/img/1/20150327/6ec6a432-0ea4-46b3-bd94-9efed895653d.png"</p>
	 * 
	 * @param absoultePath	：文件的绝对路径。
	 * <p>值如：absoultePath="D:/test/file/upload/img/1/20150327/6ec6a432-0ea4-46b3-bd94-9efed895653d.png"</p>
	 * @return	: true:保存成功，false:保存失败
	 */
	public static boolean syncStaticImage(String relativePath, String absoultePath){
	    //return syncStaticImageOld(relativePath, absoultePath);
	    return syncStaticImageNew(relativePath, absoultePath);
	}
	
	public static boolean syncStaticImageNew(String relativePath, String absoultePath){
	    Map<String, String> imageMap = new HashMap<>();
	    String separator = "/";
	    String srcFileName = relativePath.substring(relativePath.lastIndexOf(separator), relativePath.length());
	    imageMap.put("fileName", srcFileName);
	    String imgStr = ImageUtils.imgToBase64(absoultePath);
	    imageMap.put("fileStr", imgStr);
	    imageMap.put("filePath", relativePath);
	    HttpUtils.doPost(Global.getConfig("imageSync.common.url"), imageMap);
	    return true;
	}
	
	public static boolean syncStaticImageOld(String relativePath, String absoultePath){
        String destPath = Global.getConfig("static.resource.img.dest.path");
        String separator = "/";
        String srcFileName = relativePath.substring(relativePath.lastIndexOf(separator), relativePath.length());
        if(!relativePath.startsWith(separator)){
            relativePath = separator + relativePath;
        }
        String srcTmp = relativePath;
        String[] srcArr = srcTmp.substring(0, srcTmp.lastIndexOf(separator)).split(separator);
        String destTmp = destPath;
        //初始化目录
        for(String s1 : srcArr){
            if("".equals(s1)){
                continue;
            }
            String tmp = destTmp +s1 + File.separator;

            File srcD = new File(tmp);
            if(!srcD.exists()){
                boolean b = srcD.mkdir();
            }
            destTmp = tmp;
        }
        /*执行拷贝文件*/
        File srcFile = new File(absoultePath);
        try{
            if (srcFile.exists()) {
                InputStream inStream = new FileInputStream(srcFile);      //读入原文件 
                FileOutputStream fs = new FileOutputStream(destTmp + File.separator + srcFileName); 
                byte[] buffer = new byte[1204]; 
                int byteread=0;
                while ((byteread = inStream.read(buffer)) != -1) { 
                    fs.write(buffer, 0, byteread); 
                } 
                inStream.close(); 
                fs.close();
            }
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        
        return true;
    }
	
}