package com.jojowonet.modules.fmss.web.util;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

/**
 * @author xsg
 * @description 上传帮助类
 */
public class UploadHelper {

    /**
     * @param request      请求对象
     * @param maxLength    文件最大限制
     * @param allowExtName 允许上传的文件扩展名
     * @return MultipartFile集合
     */
    public static List<MultipartFile> getFileSet(HttpServletRequest request, long maxLength, String[] allowExtName) {
        return getFileSet2(request, "attach", maxLength, allowExtName);
    }

    public static List<MultipartFile> getFileSet2(HttpServletRequest request, String name, long maxLength, String[] allowExtName) {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        List<MultipartFile> files = multipartRequest.getFiles(name);
        Iterator<MultipartFile> iterator = files.iterator();
        while (iterator.hasNext()) {
            MultipartFile file = iterator.next();
            if (!validateFile(file, maxLength, allowExtName)) {
                iterator.remove();
            }
        }
        return files;
    }

    /**
     * @param file MultipartFile对象
     * @param path 保存路径，如“D:\\File\\”
     * @return filename
     * @throws Exception 文件保存失败
     * @descrption 保存文件
     */
    public static String uploadFile(MultipartFile file, String path) throws Exception {
        String filename = file.getOriginalFilename();
        String extName = filename.substring(filename.lastIndexOf(".")).toLowerCase();
        String lastFileName = UUID.randomUUID().toString() + extName;
        if (!path.endsWith(File.separator)) {
            path += File.separator;
        }
        File temp = new File(path);
        if (!temp.isDirectory()) {
            temp.mkdirs();
        }
        // 图片存储的全路径
        FileCopyUtils.copy(file.getBytes(), new File(path + lastFileName));
        return lastFileName;
    }

    /**
     * @param file         MultipartFile对象
     * @param maxLength    文件最大限制
     * @param allowExtName 不允许上传的文件扩展名
     * @return 文件格式是否合法
     * @descrption 验证文件格式，这里主要验证后缀名
     */
    private static boolean validateFile(MultipartFile file, long maxLength, String[] allowExtName) {
        if (file.getSize() < 0 || file.getSize() > maxLength) {
            return false;
        }

        String filename = file.getOriginalFilename();
        // 处理不选择文件点击上传时，也会有MultipartFile对象，在此进行过滤
        if ("".equals(filename)) {
            return false;
        }

        String extName = filename.substring(filename.lastIndexOf(".")).toLowerCase();
        return allowExtName == null
                || allowExtName.length == 0
                || Arrays.asList(allowExtName).contains(extName);
    }

}
