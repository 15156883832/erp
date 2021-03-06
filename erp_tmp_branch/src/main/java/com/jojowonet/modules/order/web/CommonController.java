package com.jojowonet.modules.order.web;

import ivan.common.config.Global;
import ivan.common.utils.FileUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.PropertiesLoader;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.multipart.MultipartFile;
import com.jojowonet.modules.order.utils.ImageUtil;
import com.jojowonet.modules.order.utils.ServletUtils;
import com.sf.file.core.template.SfFileInfo;
import com.sf.file.core.template.SfFileTemplate;

@Controller
@RequestMapping(value = "${adminPath}/common/" )
public class CommonController {

	@Resource
	private SfFileTemplate sfFileTemplate;
	
    @RequestMapping("download")
    public void download(HttpServletRequest request, HttpServletResponse response) throws IOException{
        PropertiesLoader prol = new PropertiesLoader(this.getClass().getResource("/download_tmplate.properties").toString(), "UTF-8");
        String fileName = request.getParameter("fileName");
        String realFileName = prol.getProperty(fileName);
        String realPath = Global.getConfig("static.resource.img.dest.path") + "common_download/" + fileName;
        
        File downloadFile = new File(realPath);
        if(!downloadFile.exists()){
            response.getWriter().write(" download error !");
            return ;
        }
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        OutputStream fos = null;
        InputStream fis = null;
        try {
            fis = new FileInputStream(downloadFile);
            bis = new BufferedInputStream(fis);
            fos = response.getOutputStream();
            bos = new BufferedOutputStream(fos);
            ServletUtils.setFileDownloadHeader(request,response, realFileName);
            int byteRead = 0;
            byte[] buffer = new byte[8192];
            while((byteRead=bis.read(buffer,0,8192))!=-1){
                bos.write(buffer,0,byteRead);
            }
             
            bos.flush();
            fis.close();
            bis.close();
            fos.close();
            bos.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(" download error !");
            return;
        }
    }

    @RequestMapping("/downloadFile")
	public String download(String fileName, HttpServletRequest request,
			HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/octet-stream; charset=utf-8");
		response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
		try {
			//http://192.168.2.23:80/sfimggroup/M00/00/00/wKgCF1kWpQKAeXbXAAA6j-CvzrY12..png?token=256d3e8095e4f5156222cec8630a3614&ts=1494656652
			//byte[] bts = SfFileTemplate.loadFile("sfimggroup", "M00/00/00/wKgCF1kWqdSATFEUAAA6j-CvzrY39..png");
			String msg = request.getParameter("msg");
			OutputStream os = response.getOutputStream();
			if(StringUtils.isNotBlank(msg)){
				msg = msg.replaceAll(",", "\r\n");
				os.write(msg.getBytes());
			}else{
				byte[] bts = sfFileTemplate.loadFile("sfimggroup", "M00/00/00/wKgCF1kWpQKAeXbXAAA6j-CvzrY12..png");
				os.write(bts);
			}
			 // 这里主要关闭。
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
    
    /*
     * 上传图片，压缩处理
    */
    @RequestMapping(value = "uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Object webuploadImagesSite(MultipartFile file,HttpServletRequest request, HttpServletResponse response) {
        String filename= file.getOriginalFilename();
        String extName = filename.substring(filename.lastIndexOf(".")).toLowerCase();
        SfFileInfo fileInfo = null;
        Map<String, Object> ret = new HashMap<>();
		try {
			String webPath = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
			File tempDir = new File(webPath + File.separator + "temp");
			if (!tempDir.exists()) {
				tempDir.mkdirs();
			}
			String tempFilePath = tempDir.getAbsolutePath() + File.separator + IdGen.uuid() + extName;
			ImageUtil.compressImage(file.getInputStream(), tempFilePath, 1024);
			File tempFile = new File(tempFilePath);
     		fileInfo = sfFileTemplate.upload(FileUtils.readFileToByteArray(tempFile), extName);
	    	if(StringUtils.isNotBlank(fileInfo.getPath())){
				//上传成功，需要删除临时文件
				FileUtils.deleteFile(tempFilePath);
				ret.put("path", fileInfo.getPath());
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        return ret;
    }
    /*
     * 上传模板图片，不压缩处理
    */
    @RequestMapping(value = "uploadFilePrint", method = RequestMethod.POST)
    @ResponseBody
    public Object webuploadImagesPrint(MultipartFile file,HttpServletRequest request, HttpServletResponse response) {
        String filename= file.getOriginalFilename();
        String extName = filename.substring(filename.lastIndexOf(".")).toLowerCase();
        SfFileInfo fileInfo = null;
        Map<String, Object> ret = new HashMap<>();
		try {
			String webPath = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
			File tempDir = new File(webPath + File.separator + "temp");
			if (!tempDir.exists()) {
				tempDir.mkdirs();
			}
     		fileInfo = sfFileTemplate.upload(file.getBytes(), extName);
	    	if(StringUtils.isNotBlank(fileInfo.getPath())){
				//上传成功，需要删除临时文件
			//	FileUtils.deleteFile(tempFilePath);
				ret.put("path", fileInfo.getPath());
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        return ret;
    }
    //上传其他文件
    @RequestMapping(value = "uploadFile2", method = RequestMethod.POST)
    @ResponseBody
    public Object webuploadImagesSites(MultipartFile file,HttpServletRequest request, HttpServletResponse response) {
        String filename= file.getOriginalFilename();
        String extName = filename.substring(filename.lastIndexOf(".")).toLowerCase();
        SfFileInfo fileInfo = null;
        Map<String, Object> ret = new HashMap<>();
		try {
			String webPath = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
			File tempDir = new File(webPath + File.separator + "temp");
			if (!tempDir.exists()) {
				tempDir.mkdirs();
			}
			fileInfo = sfFileTemplate.upload(file.getBytes(), extName);
			if(StringUtils.isNotBlank(fileInfo.getPath())){
				//上传成功，需要删除临时文件
//				FileUtils.deleteFile(tempFilePath);
				ret.put("path", fileInfo.getPath());
				ret.put("filename", filename);
				ret.put("extName", extName);
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        return ret;
    }
    
}
